Return-Path: <netdev+bounces-28504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2F177FA5C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520671C21457
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD81114F80;
	Thu, 17 Aug 2023 15:07:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2914168AE
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:07:11 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5326BC;
	Thu, 17 Aug 2023 08:07:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 497F160004;
	Thu, 17 Aug 2023 15:07:07 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Scott Dial <scott@scottdial.com>
Subject: [PATCH net-next] macsec: introduce default_async_crypto sysctl
Date: Thu, 17 Aug 2023 17:07:03 +0200
Message-Id: <9328d206c5d9f9239cae27e62e74de40b258471d.1692279161.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit ab046a5d4be4 ("net: macsec: preserve ingress frame ordering")
tried to solve an issue caused by MACsec's use of asynchronous crypto
operations, but introduced a large performance regression in cases
where async crypto isn't causing reordering of packets.

This patch introduces a per-netns sysctl that administrators can set
to allow new SAs to use async crypto, such as aesni. Existing SAs
won't be modified.

By setting default_async_crypto=1 and reconfiguring macsec, a single
netperf instance jumps from 1.4Gbps to 4.4Gbps.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 Documentation/admin-guide/sysctl/net.rst |  39 +++++++--
 drivers/net/macsec.c                     | 101 ++++++++++++++++++++---
 2 files changed, 119 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 4877563241f3..ce47b612c517 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -34,14 +34,14 @@ Table : Subdirectories in /proc/sys/net
  ========= =================== = ========== ===================
  Directory Content               Directory  Content
  ========= =================== = ========== ===================
- 802       E802 protocol         mptcp      Multipath TCP
- appletalk Appletalk protocol    netfilter  Network Filter
- ax25      AX25                  netrom     NET/ROM
- bridge    Bridging              rose       X.25 PLP layer
- core      General parameter     tipc       TIPC
- ethernet  Ethernet protocol     unix       Unix domain sockets
- ipv4      IP version 4          x25        X.25 protocol
- ipv6      IP version 6
+ 802       E802 protocol         macsec     MACsec
+ appletalk Appletalk protocol    mptcp      Multipath TCP
+ ax25      AX25                  netfilter  Network Filter
+ bridge    Bridging              netrom     NET/ROM
+ core      General parameter     rose       X.25 PLP layer
+ ethernet  Ethernet protocol     tipc       TIPC
+ ipv4      IP version 4          unix       Unix domain sockets
+ ipv6      IP version 6          x25        X.25 protocol
  ========= =================== = ========== ===================
 
 1. /proc/sys/net/core - Network core options
@@ -503,3 +503,26 @@ originally may have been issued in the correct sequential order.
 If named_timeout is nonzero, failed topology updates will be placed on a defer
 queue until another event arrives that clears the error, or until the timeout
 expires. Value is in milliseconds.
+
+
+6. /proc/sys/net/macsec - Parameters for MACsec
+-----------------------------------------------
+
+default_async_crypto
+--------------------
+
+The software implementation of MACsec uses the kernel cryptography
+API, which provides both asynchronous and synchronous implementations
+of algorithms. The asynchronous implementations tend to provide better
+performance, but in some cases, can cause reordering of packets.
+
+This only affects newly created Security Associations. Existing SAs
+will be unchanged. Whether a MACsec device was created before or after
+this sysctl is set has no impact.
+
+Values:
+
+	- 0 - disable asynchronous cryptography
+	- 1 - allow asynchronous cryptography (if available)
+
+Default : 0 (only synchronous)
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ae60817ec5c2..88743ce5839b 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -138,6 +138,15 @@ struct macsec_cb {
 	bool has_sci;
 };
 
+static unsigned int macsec_net_id __read_mostly;
+
+struct macsec_net {
+#ifdef CONFIG_SYSCTL
+	struct ctl_table_header *ctl_hdr;
+#endif
+	u8 default_async;
+};
+
 static struct macsec_rx_sa *macsec_rxsa_get(struct macsec_rx_sa __rcu *ptr)
 {
 	struct macsec_rx_sa *sa = rcu_dereference_bh(ptr);
@@ -1325,14 +1334,14 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	return RX_HANDLER_PASS;
 }
 
-static struct crypto_aead *macsec_alloc_tfm(char *key, int key_len, int icv_len)
+static struct crypto_aead *macsec_alloc_tfm(const struct net *net,
+					    char *key, int key_len, int icv_len)
 {
+	struct macsec_net *macsec_net = net_generic(net, macsec_net_id);
 	struct crypto_aead *tfm;
 	int ret;
 
-	/* Pick a sync gcm(aes) cipher to ensure order is preserved. */
-	tfm = crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
-
+	tfm = crypto_alloc_aead("gcm(aes)", 0, macsec_net->default_async ? 0 : CRYPTO_ALG_ASYNC);
 	if (IS_ERR(tfm))
 		return tfm;
 
@@ -1350,14 +1359,14 @@ static struct crypto_aead *macsec_alloc_tfm(char *key, int key_len, int icv_len)
 	return ERR_PTR(ret);
 }
 
-static int init_rx_sa(struct macsec_rx_sa *rx_sa, char *sak, int key_len,
-		      int icv_len)
+static int init_rx_sa(const struct net *net, struct macsec_rx_sa *rx_sa,
+		      char *sak, int key_len, int icv_len)
 {
 	rx_sa->stats = alloc_percpu(struct macsec_rx_sa_stats);
 	if (!rx_sa->stats)
 		return -ENOMEM;
 
-	rx_sa->key.tfm = macsec_alloc_tfm(sak, key_len, icv_len);
+	rx_sa->key.tfm = macsec_alloc_tfm(net, sak, key_len, icv_len);
 	if (IS_ERR(rx_sa->key.tfm)) {
 		free_percpu(rx_sa->stats);
 		return PTR_ERR(rx_sa->key.tfm);
@@ -1450,14 +1459,14 @@ static struct macsec_rx_sc *create_rx_sc(struct net_device *dev, sci_t sci,
 	return rx_sc;
 }
 
-static int init_tx_sa(struct macsec_tx_sa *tx_sa, char *sak, int key_len,
-		      int icv_len)
+static int init_tx_sa(const struct net *net, struct macsec_tx_sa *tx_sa,
+		      char *sak, int key_len, int icv_len)
 {
 	tx_sa->stats = alloc_percpu(struct macsec_tx_sa_stats);
 	if (!tx_sa->stats)
 		return -ENOMEM;
 
-	tx_sa->key.tfm = macsec_alloc_tfm(sak, key_len, icv_len);
+	tx_sa->key.tfm = macsec_alloc_tfm(net, sak, key_len, icv_len);
 	if (IS_ERR(tx_sa->key.tfm)) {
 		free_percpu(tx_sa->stats);
 		return PTR_ERR(tx_sa->key.tfm);
@@ -1795,7 +1804,7 @@ static int macsec_add_rxsa(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 	}
 
-	err = init_rx_sa(rx_sa, nla_data(tb_sa[MACSEC_SA_ATTR_KEY]),
+	err = init_rx_sa(dev_net(dev), rx_sa, nla_data(tb_sa[MACSEC_SA_ATTR_KEY]),
 			 secy->key_len, secy->icv_len);
 	if (err < 0) {
 		kfree(rx_sa);
@@ -2038,7 +2047,7 @@ static int macsec_add_txsa(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 	}
 
-	err = init_tx_sa(tx_sa, nla_data(tb_sa[MACSEC_SA_ATTR_KEY]),
+	err = init_tx_sa(dev_net(dev), tx_sa, nla_data(tb_sa[MACSEC_SA_ATTR_KEY]),
 			 secy->key_len, secy->icv_len);
 	if (err < 0) {
 		kfree(tx_sa);
@@ -4168,7 +4177,7 @@ static int macsec_validate_attr(struct nlattr *tb[], struct nlattr *data[],
 			char dummy_key[DEFAULT_SAK_LEN] = { 0 };
 			struct crypto_aead *dummy_tfm;
 
-			dummy_tfm = macsec_alloc_tfm(dummy_key,
+			dummy_tfm = macsec_alloc_tfm(&init_net, dummy_key,
 						     DEFAULT_SAK_LEN,
 						     icv_len);
 			if (IS_ERR(dummy_tfm))
@@ -4380,6 +4389,65 @@ static struct notifier_block macsec_notifier = {
 	.notifier_call = macsec_notify,
 };
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table macsec_table[] = {
+	{
+		.procname = "default_async_crypto",
+		.maxlen = sizeof(u8),
+		.mode = 0644,
+		.proc_handler = proc_dou8vec_minmax,
+		.extra1 = SYSCTL_ZERO,
+		.extra2 = SYSCTL_ONE,
+	},
+	{ },
+};
+
+static int __net_init macsec_init_net(struct net *net)
+{
+	struct ctl_table *table = macsec_table;
+	struct macsec_net *macsec_net;
+
+	if (!net_eq(net, &init_net)) {
+		table = kmemdup(table, sizeof(macsec_table), GFP_KERNEL);
+		if (!table)
+			return -ENOMEM;
+	}
+
+	macsec_net = net_generic(net, macsec_net_id);
+	table[0].data = &macsec_net->default_async;
+	macsec_net->default_async = 0;
+
+	macsec_net->ctl_hdr = register_net_sysctl(net, "net/macsec", table);
+	if (!macsec_net->ctl_hdr)
+		goto free;
+
+	return 0;
+
+free:
+	if (!net_eq(net, &init_net))
+		kfree(table);
+	return -ENOMEM;
+}
+
+static void __net_exit macsec_exit_net(struct net *net)
+{
+	struct macsec_net *macsec_net = net_generic(net, macsec_net_id);
+
+	unregister_net_sysctl_table(macsec_net->ctl_hdr);
+	if (!net_eq(net, &init_net))
+		kfree(macsec_net->ctl_hdr->ctl_table_arg);
+}
+#endif
+
+static struct pernet_operations macsec_net_ops __read_mostly = {
+#ifdef CONFIG_SYSCTL
+	.init = macsec_init_net,
+	.exit = macsec_exit_net,
+#endif
+	.id   = &macsec_net_id,
+	.size = sizeof(struct macsec_net),
+};
+
 static int __init macsec_init(void)
 {
 	int err;
@@ -4397,8 +4465,14 @@ static int __init macsec_init(void)
 	if (err)
 		goto rtnl;
 
+	err = register_pernet_subsys(&macsec_net_ops);
+	if (err)
+		goto genl;
+
 	return 0;
 
+genl:
+	genl_unregister_family(&macsec_fam);
 rtnl:
 	rtnl_link_unregister(&macsec_link_ops);
 notifier:
@@ -4408,6 +4482,7 @@ static int __init macsec_init(void)
 
 static void __exit macsec_exit(void)
 {
+	unregister_pernet_subsys(&macsec_net_ops);
 	genl_unregister_family(&macsec_fam);
 	rtnl_link_unregister(&macsec_link_ops);
 	unregister_netdevice_notifier(&macsec_notifier);
-- 
2.40.1


