Return-Path: <netdev+bounces-39456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A59A7BF4DE
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9816B1C208CD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9C13FE9;
	Tue, 10 Oct 2023 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMI+ffJ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DCFBEA
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CBDC433C7;
	Tue, 10 Oct 2023 07:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696924429;
	bh=gh+wF2cOm71mHLeriwt1ClLG5cXqexAVx/dzA0lWn7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMI+ffJ9AN/y2qJ9AO9MU2AgEBE2589Kk1bIOq7YWkAqx0RkIlzhYh+Ao4AX8SWbE
	 ZGZqrhh99+Fc+JLDnzskHqNAwMN/XXxPBZvpYNaysSBwHFteSyO4bBzXAVlDXtEhaI
	 AwMLnIym/vAicYnaFHcrBk/S15Ts20bfzNZ7Q4N+fpxyL2tCAvBhvTarqvAvquH1uQ
	 IlelyzJ8gkUCzxvPdsa56+zfyZWYS/6f6iDlsAkp69k4+iPB6l0BLP5G+JJ0f7qJLh
	 +gtPdZXxSiOURBYlwBG/AMGd9Yv3YoydGu7xKaELp2uDkCpSeIH50t6xxNsoEWzczC
	 h4QEDqjDnez+A==
From: Arnd Bergmann <arnd@kernel.org>
To: Rodolfo Zitellini <rwz@xhero.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Netdev <netdev@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wpan@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] appletalk: make localtalk and ppp support conditional
Date: Tue, 10 Oct 2023 09:53:37 +0200
Message-Id: <20231010075337.3100563-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <DE61EEA5-D560-40B6-8F4D-22F299AC61ED@xhero.org>
References: <DE61EEA5-D560-40B6-8F4D-22F299AC61ED@xhero.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The last localtalk driver is gone now, and ppp support was never fully
merged, but the code to support them for phase1 networking still calls
the deprecated .ndo_do_ioctl() helper.

In order to better isolate the localtalk and ppp portions of appletalk,
guard all of the corresponding code with CONFIG_DEV_APPLETALK checks,
including a preprocessor conditional that guards the internal ioctl calls.

This is currently all dead code and will now be left out of the
module since this Kconfig symbol is always undefined, but there are
plans to add a new driver for localtalk again in the future. When
that happens, the logic can be cleaned up to work properly without
the need for the ioctl.

Link: https://lore.kernel.org/lkml/790BA488-B6F6-41ED-96EF-2089EF1C043B@xhero.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: don't actually remove the code, just make it conditional since we
are likely to need it again.

 include/linux/atalk.h  |  1 -
 net/appletalk/Makefile |  3 ++-
 net/appletalk/aarp.c   | 24 +++++++++++++++---------
 net/appletalk/ddp.c    | 24 +++++++++++++-----------
 4 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/include/linux/atalk.h b/include/linux/atalk.h
index a55bfc6567d01..2896f2ac9568e 100644
--- a/include/linux/atalk.h
+++ b/include/linux/atalk.h
@@ -121,7 +121,6 @@ static inline struct atalk_iface *atalk_find_dev(struct net_device *dev)
 #endif
 
 extern struct atalk_addr *atalk_find_dev_addr(struct net_device *dev);
-extern struct net_device *atrtr_get_dev(struct atalk_addr *sa);
 extern int		 aarp_send_ddp(struct net_device *dev,
 				       struct sk_buff *skb,
 				       struct atalk_addr *sa, void *hwaddr);
diff --git a/net/appletalk/Makefile b/net/appletalk/Makefile
index 33164d972d379..410d52f9113e2 100644
--- a/net/appletalk/Makefile
+++ b/net/appletalk/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_ATALK) += appletalk.o
 
-appletalk-y			:= aarp.o ddp.o dev.o
+appletalk-y			:= aarp.o ddp.o
 appletalk-$(CONFIG_PROC_FS)	+= atalk_proc.o
 appletalk-$(CONFIG_SYSCTL)	+= sysctl_net_atalk.o
+appletalk-$(CONFIG_DEV_APPLETALK) += dev.o
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index 9fa0b246902be..b15f67293ac4c 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -438,14 +438,17 @@ static struct atalk_addr *__aarp_proxy_find(struct net_device *dev,
  */
 static void aarp_send_probe_phase1(struct atalk_iface *iface)
 {
+#if IS_ENABLED(CONFIG_DEV_APPLETALK)
 	struct ifreq atreq;
 	struct sockaddr_at *sa = (struct sockaddr_at *)&atreq.ifr_addr;
 	const struct net_device_ops *ops = iface->dev->netdev_ops;
 
 	sa->sat_addr.s_node = iface->address.s_node;
 	sa->sat_addr.s_net = ntohs(iface->address.s_net);
-
-	/* We pass the Net:Node to the drivers/cards by a Device ioctl. */
+	/*
+	 * We used to pass the address via device ioctl, this has to
+	 *  be rewritten if we bring back localtalk.
+	 */
 	if (!(ops->ndo_do_ioctl(iface->dev, &atreq, SIOCSIFADDR))) {
 		ops->ndo_do_ioctl(iface->dev, &atreq, SIOCGIFADDR);
 		if (iface->address.s_net != htons(sa->sat_addr.s_net) ||
@@ -455,13 +458,15 @@ static void aarp_send_probe_phase1(struct atalk_iface *iface)
 		iface->address.s_net  = htons(sa->sat_addr.s_net);
 		iface->address.s_node = sa->sat_addr.s_node;
 	}
+#endif
 }
 
 
 void aarp_probe_network(struct atalk_iface *atif)
 {
-	if (atif->dev->type == ARPHRD_LOCALTLK ||
-	    atif->dev->type == ARPHRD_PPP)
+	if (IS_ENABLED(CONFIG_DEV_APPLETALK) &&
+	    (atif->dev->type == ARPHRD_LOCALTLK ||
+	     atif->dev->type == ARPHRD_PPP))
 		aarp_send_probe_phase1(atif);
 	else {
 		unsigned int count;
@@ -488,8 +493,9 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 	 * we don't currently support LocalTalk or PPP for proxy AARP;
 	 * if someone wants to try and add it, have fun
 	 */
-	if (atif->dev->type == ARPHRD_LOCALTLK ||
-	    atif->dev->type == ARPHRD_PPP)
+	if (IS_ENABLED(CONFIG_DEV_APPLETALK) &&
+	    (atif->dev->type == ARPHRD_LOCALTLK ||
+	     atif->dev->type == ARPHRD_PPP))
 		goto out;
 
 	/*
@@ -550,7 +556,8 @@ int aarp_send_ddp(struct net_device *dev, struct sk_buff *skb,
 	skb_reset_network_header(skb);
 
 	/* Check for LocalTalk first */
-	if (dev->type == ARPHRD_LOCALTLK) {
+	if (IS_ENABLED(CONFIG_DEV_APPLETALK) &&
+	    dev->type == ARPHRD_LOCALTLK) {
 		struct atalk_addr *at = atalk_find_dev_addr(dev);
 		struct ddpehdr *ddp = (struct ddpehdr *)skb->data;
 		int ft = 2;
@@ -588,7 +595,7 @@ int aarp_send_ddp(struct net_device *dev, struct sk_buff *skb,
 	}
 
 	/* On a PPP link we neither compress nor aarp.  */
-	if (dev->type == ARPHRD_PPP) {
+	if (IS_ENABLED(CONFIG_DEV_APPLETALK) && dev->type == ARPHRD_PPP) {
 		skb->protocol = htons(ETH_P_PPPTALK);
 		skb->dev = dev;
 		goto sendit;
@@ -674,7 +681,6 @@ int aarp_send_ddp(struct net_device *dev, struct sk_buff *skb,
 drop:
 	return NET_XMIT_DROP;
 }
-EXPORT_SYMBOL(aarp_send_ddp);
 
 /*
  *	An entry in the aarp unresolved queue has become resolved. Send
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 8978fb6212ffb..d4dc6a9fd3b6b 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -473,7 +473,7 @@ static struct atalk_route *atrtr_find(struct atalk_addr *target)
  * Given an AppleTalk network, find the device to use. This can be
  * a simple lookup.
  */
-struct net_device *atrtr_get_dev(struct atalk_addr *sa)
+static struct net_device *atrtr_get_dev(struct atalk_addr *sa)
 {
 	struct atalk_route *atr = atrtr_find(sa);
 	return atr ? atr->dev : NULL;
@@ -1947,10 +1947,6 @@ static struct packet_type ppptalk_packet_type __read_mostly = {
 
 static unsigned char ddp_snap_id[] = { 0x08, 0x00, 0x07, 0x80, 0x9B };
 
-/* Export symbols for use by drivers when AppleTalk is a module */
-EXPORT_SYMBOL(atrtr_get_dev);
-EXPORT_SYMBOL(atalk_find_dev_addr);
-
 /* Called by proto.c on kernel start up */
 static int __init atalk_init(void)
 {
@@ -1971,8 +1967,10 @@ static int __init atalk_init(void)
 		goto out_sock;
 	}
 
-	dev_add_pack(&ltalk_packet_type);
-	dev_add_pack(&ppptalk_packet_type);
+	if (IS_ENABLED(CONFIG_DEV_APPLETALK)) {
+		dev_add_pack(&ltalk_packet_type);
+		dev_add_pack(&ppptalk_packet_type);
+	}
 
 	rc = register_netdevice_notifier(&ddp_notifier);
 	if (rc)
@@ -1998,8 +1996,10 @@ static int __init atalk_init(void)
 out_dev:
 	unregister_netdevice_notifier(&ddp_notifier);
 out_snap:
-	dev_remove_pack(&ppptalk_packet_type);
-	dev_remove_pack(&ltalk_packet_type);
+	if (IS_ENABLED(CONFIG_DEV_APPLETALK)) {
+		dev_remove_pack(&ppptalk_packet_type);
+		dev_remove_pack(&ltalk_packet_type);
+	}
 	unregister_snap_client(ddp_dl);
 out_sock:
 	sock_unregister(PF_APPLETALK);
@@ -2026,8 +2026,10 @@ static void __exit atalk_exit(void)
 	atalk_proc_exit();
 	aarp_cleanup_module();	/* General aarp clean-up. */
 	unregister_netdevice_notifier(&ddp_notifier);
-	dev_remove_pack(&ltalk_packet_type);
-	dev_remove_pack(&ppptalk_packet_type);
+	if (IS_ENABLED(CONFIG_DEV_APPLETALK)) {
+		dev_remove_pack(&ltalk_packet_type);
+		dev_remove_pack(&ppptalk_packet_type);
+	}
 	unregister_snap_client(ddp_dl);
 	sock_unregister(PF_APPLETALK);
 	proto_unregister(&ddp_proto);
-- 
2.39.2


