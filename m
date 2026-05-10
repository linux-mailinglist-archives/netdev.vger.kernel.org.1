Return-Path: <netdev+bounces-286268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPHFEVBNAGqsGAEAu9opvQ
	(envelope-from <netdev+bounces-286268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:18:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A253C5034B6
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 499FF303789A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334D536B042;
	Sun, 10 May 2026 09:15:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E8D35A398
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404538; cv=none; b=N/v+pzYoEUZWtqvxKWJubgN+70zFtnjQ7B8iO6gMDxGo0IsQFFBTBnRs5ja2eSy/g8M+evH01sZ7Yu2SErLNU3ekYyd3254/284wXhW1vTshxjRvp/mwW8g+lttJg/pdVhfML0wtI+EFQ2IQqsYydFQX1O26hks78ttP/8RjHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404538; c=relaxed/simple;
	bh=4ByYkf3UNl3k/TuaUltHvzHTwKVFV62lGW6QhoO0rq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc3dvS9rZ7I5G9P+cQaVxKeIT2zkXOGgcaCuCIGWEkDNu9w29RZFYrtLfMGEc9f3qgDk55/9wNzep8KN7bX5j+MjdRKTsUNB/lWwRNmqpi38zdC+1ACZCIi1rr56PEy1nCbUk78TEuEQR8YRk/4QdMoC8w7I81hcAh/dkl7b/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADHO_yeTABq+l4BAQ--.3772S3;
	Sun, 10 May 2026 17:15:13 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	horatiu.vultur@microchip.com,
	kuba@kernel.org,
	henrik.bjoernlund@microchip.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	ronbogo@outlook.com,
	zylzyl2333@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
Date: Sun, 10 May 2026 17:15:05 +0800
Message-ID: <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1778378864.git.zylzyl2333@gmail.com>
References: <cover.1778378864.git.zylzyl2333@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADHO_yeTABq+l4BAQ--.3772S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGryUAr48Cr1fCryDZrWfAFb_yoWrCryfpF
	WYgwn8JrWDXr1a9w40yFy8Ary3Kr4kK3y3K398A34SvrnYqFy8AFZxAr1avF45uFW8ur43
	CF1UKr1rtw4DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0DCWoARmUARQAAsK
X-Rspamd-Queue-Id: A253C5034B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-286268-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[blackwall.org,nvidia.com,microchip.com,kernel.org,gmail.com,lzu.edu.cn,outlook.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.845];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,lzu.edu.cn:email]
X-Rspamd-Action: no action

From: Yilin Zhu <zylzyl2333@gmail.com>

CFM registers a bridge frame handler when the first MEP is created and
unregisters it when the last MEP is deleted. The registered object also
contains the hlist_node used by the bridge-local frame_type_list.

The CFM frame type is currently global, so enabling CFM on multiple
bridges links the same hlist_node into multiple bridge-local lists. A
later unregister on one bridge can then operate on list state belonging
to another bridge.

Move the CFM frame type into struct net_bridge and register/unregister
the bridge-owned object. This keeps frame handler list membership local
to the bridge while preserving the existing first-MEP/last-MEP lifetime.

Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Peihan Liu <ronbogo@outlook.com>
Signed-off-by: Peihan Liu <ronbogo@outlook.com>
Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/bridge/br_cfm.c     | 14 ++++++--------
 net/bridge/br_private.h | 18 +++++++++++-------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 118c7ea48c35..547c7415c0ea 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
 	return 1;
 }
 
-static struct br_frame_type cfm_frame_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_CFM),
-	.frame_handler = br_cfm_frame_rx,
-};
-
 int br_cfm_mep_create(struct net_bridge *br,
 		      const u32 instance,
 		      struct br_cfm_mep_create *const create,
@@ -558,8 +553,11 @@ int br_cfm_mep_create(struct net_bridge *br,
 	INIT_HLIST_HEAD(&mep->peer_mep_list);
 	INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
 
-	if (hlist_empty(&br->mep_list))
-		br_add_frame(br, &cfm_frame_type);
+	if (hlist_empty(&br->mep_list)) {
+		br->cfm_frame_type.type = cpu_to_be16(ETH_P_CFM);
+		br->cfm_frame_type.frame_handler = br_cfm_frame_rx;
+		br_add_frame(br, &br->cfm_frame_type);
+	}
 
 	hlist_add_tail_rcu(&mep->head, &br->mep_list);
 
@@ -588,7 +586,7 @@ static void mep_delete_implementation(struct net_bridge *br,
 	kfree_rcu(mep, rcu);
 
 	if (hlist_empty(&br->mep_list))
-		br_del_frame(br, &cfm_frame_type);
+		br_del_frame(br, &br->cfm_frame_type);
 }
 
 int br_cfm_mep_delete(struct net_bridge *br,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index bed1b1d9b282..a3ed9ee826f5 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -61,6 +61,9 @@ typedef struct bridge_id bridge_id;
 typedef struct mac_addr mac_addr;
 typedef __u16 port_id;
 
+struct net_bridge_port;
+struct sk_buff;
+
 struct bridge_id {
 	unsigned char	prio[2];
 	unsigned char	addr[ETH_ALEN];
@@ -70,6 +73,13 @@ struct mac_addr {
 	unsigned char	addr[ETH_ALEN];
 };
 
+struct br_frame_type {
+	__be16			type;
+	int			(*frame_handler)(struct net_bridge_port *port,
+						 struct sk_buff *skb);
+	struct hlist_node	list;
+};
+
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 /* our own querier */
 struct bridge_mcast_own_query {
@@ -585,6 +595,7 @@ struct net_bridge {
 	struct hlist_head		mrp_list;
 #endif
 #if IS_ENABLED(CONFIG_BRIDGE_CFM)
+	struct br_frame_type	cfm_frame_type;
 	struct hlist_head		mep_list;
 #endif
 };
@@ -926,13 +937,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct net_device *backup_dev);
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
 rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
 
-struct br_frame_type {
-	__be16			type;
-	int			(*frame_handler)(struct net_bridge_port *port,
-						 struct sk_buff *skb);
-	struct hlist_node	list;
-};
-
 void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
 void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
 
-- 
2.47.3


