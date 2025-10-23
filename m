Return-Path: <netdev+bounces-232057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4BFC005FC
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43AE94E1CD9
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4A1280024;
	Thu, 23 Oct 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tX5yKIBY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qwZ/ApOf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56BE1D9346
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213713; cv=none; b=JPrtVttInsBjDzo0CqrJ6v8kdjYwSGyubrbtRZGoWh0SynRW4DmXwym2kivTkUUNmxXEHB4dd6sy7Zb7dH9ILx7twjBwRgurknpDzaH9op+vI1uEk5EIggJm6fNHS8HI6MBqu/CHeycB59Ei3q8zpbsH2ohnZVX/+vXAVyoJbKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213713; c=relaxed/simple;
	bh=i8iTFIpSYHr7NzE1lDkPHpkvPukENwJx5HMYBoh3o1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Htiu3Q9hbCvhixgXb/r+cOiX0opK1uwmoKS0dWZMneqVHa9540WLShMynj6HKQIAj/ZTW3lLTP7j7XbiQ9SbDEXOgPDgCatvybmwXMl2rnnTh0jZ99SIi0nVp+xruom5G8ntrnDj5DcLcPn15ZRlLyO7OkJgQnTW+CHa/yyBpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tX5yKIBY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qwZ/ApOf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8FFC1F388;
	Thu, 23 Oct 2025 10:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761213703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8CphuBVHORvBwJQPcaj5D55Ah/F0BPK3ytrl067uAgA=;
	b=tX5yKIBYzbBZj/BQYIXPh0+mjlAtOJmPNxvCaerMk9w09wmW9rpnjYghvOHFRZeoysy1qj
	st15Muds/PAm9ZQzEbMD0xJ5g3B1LUokCAS2eE5eyZJgoXE1Xsvb+XVWLLgjHdGA7ni1V4
	vVvUylnAE9jjqPcVB20U+NE+2p8nMtc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="qwZ/ApOf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761213699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8CphuBVHORvBwJQPcaj5D55Ah/F0BPK3ytrl067uAgA=;
	b=qwZ/ApOfaf4ZA07/9ksOrwwVDhnolkyMDpZ1W6Oa3f+WLSnPUCeob/vbTebWKyuPMGlIDa
	T79xELna0goXVq8/TIG1D4ab+udFBTlZJ/8QDrexwAMAfNm6jOh8+c7gqlonodFGdUXD4C
	WyjXNHj3ej/UnND7Ot2eEZi9LBUAtJA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79A0713285;
	Thu, 23 Oct 2025 10:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OSOWHAP9+WgvXwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 23 Oct 2025 10:01:39 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH net-next 1/1] net: usb: usbnet: coding style for functions
Date: Thu, 23 Oct 2025 12:00:19 +0200
Message-ID: <20251023100136.909118-1-oneukum@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8FFC1F388
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 

Functions are not to have blanks between names
and parameter lists. Remove them.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/usbnet.c | 49 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index bf01f2728531..62a85dbad31a 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -189,7 +189,7 @@ static bool usbnet_needs_usb_name_format(struct usbnet *dev, struct net_device *
 		 is_local_ether_addr(net->dev_addr));
 }
 
-static void intr_complete (struct urb *urb)
+static void intr_complete(struct urb *urb)
 {
 	struct usbnet	*dev = urb->context;
 	int		status = urb->status;
@@ -221,7 +221,7 @@ static void intr_complete (struct urb *urb)
 			  "intr resubmit --> %d\n", status);
 }
 
-static int init_status (struct usbnet *dev, struct usb_interface *intf)
+static int init_status(struct usbnet *dev, struct usb_interface *intf)
 {
 	char		*buf = NULL;
 	unsigned	pipe = 0;
@@ -326,7 +326,7 @@ static void __usbnet_status_stop_force(struct usbnet *dev)
  * Some link protocols batch packets, so their rx_fixup paths
  * can return clones as well as just modify the original skb.
  */
-void usbnet_skb_return (struct usbnet *dev, struct sk_buff *skb)
+void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 {
 	struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
 	unsigned long flags;
@@ -396,7 +396,7 @@ EXPORT_SYMBOL_GPL(usbnet_update_max_qlen);
  *
  *-------------------------------------------------------------------------*/
 
-int usbnet_change_mtu (struct net_device *net, int new_mtu)
+int usbnet_change_mtu(struct net_device *net, int new_mtu)
 {
 	struct usbnet	*dev = netdev_priv(net);
 	int		ll_mtu = new_mtu + net->hard_header_len;
@@ -472,7 +472,7 @@ static enum skb_state defer_bh(struct usbnet *dev, struct sk_buff *skb,
  * NOTE:  annoying asymmetry:  if it's active, schedule_work() fails,
  * but tasklet_schedule() doesn't.  hope the failure is rare.
  */
-void usbnet_defer_kevent (struct usbnet *dev, int work)
+void usbnet_defer_kevent(struct usbnet *dev, int work)
 {
 	set_bit (work, &dev->flags);
 	if (!usbnet_going_away(dev)) {
@@ -489,9 +489,9 @@ EXPORT_SYMBOL_GPL(usbnet_defer_kevent);
 
 /*-------------------------------------------------------------------------*/
 
-static void rx_complete (struct urb *urb);
+static void rx_complete(struct urb *urb);
 
-static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
+static int rx_submit(struct usbnet *dev, struct urb *urb, gfp_t flags)
 {
 	struct sk_buff		*skb;
 	struct skb_data		*entry;
@@ -597,7 +597,7 @@ static inline int rx_process(struct usbnet *dev, struct sk_buff *skb)
 
 /*-------------------------------------------------------------------------*/
 
-static void rx_complete (struct urb *urb)
+static void rx_complete(struct urb *urb)
 {
 	struct sk_buff		*skb = (struct sk_buff *) urb->context;
 	struct skb_data		*entry = (struct skb_data *) skb->cb;
@@ -728,7 +728,7 @@ EXPORT_SYMBOL_GPL(usbnet_purge_paused_rxq);
 
 // unlink pending rx/tx; completion handlers do all other cleanup
 
-static int unlink_urbs (struct usbnet *dev, struct sk_buff_head *q)
+static int unlink_urbs(struct usbnet *dev, struct sk_buff_head *q)
 {
 	unsigned long		flags;
 	struct sk_buff		*skb;
@@ -823,7 +823,7 @@ static void usbnet_terminate_urbs(struct usbnet *dev)
 	remove_wait_queue(&dev->wait, &wait);
 }
 
-int usbnet_stop (struct net_device *net)
+int usbnet_stop(struct net_device *net)
 {
 	struct usbnet		*dev = netdev_priv(net);
 	const struct driver_info *info = dev->driver_info;
@@ -892,7 +892,7 @@ EXPORT_SYMBOL_GPL(usbnet_stop);
 
 // precondition: never called in_interrupt
 
-int usbnet_open (struct net_device *net)
+int usbnet_open(struct net_device *net)
 {
 	struct usbnet		*dev = netdev_priv(net);
 	int			retval;
@@ -1048,7 +1048,7 @@ int usbnet_set_link_ksettings_mii(struct net_device *net,
 }
 EXPORT_SYMBOL_GPL(usbnet_set_link_ksettings_mii);
 
-u32 usbnet_get_link (struct net_device *net)
+u32 usbnet_get_link(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
 
@@ -1076,7 +1076,7 @@ int usbnet_nway_reset(struct net_device *net)
 }
 EXPORT_SYMBOL_GPL(usbnet_nway_reset);
 
-void usbnet_get_drvinfo (struct net_device *net, struct ethtool_drvinfo *info)
+void usbnet_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
 {
 	struct usbnet *dev = netdev_priv(net);
 
@@ -1087,7 +1087,7 @@ void usbnet_get_drvinfo (struct net_device *net, struct ethtool_drvinfo *info)
 }
 EXPORT_SYMBOL_GPL(usbnet_get_drvinfo);
 
-u32 usbnet_get_msglevel (struct net_device *net)
+u32 usbnet_get_msglevel(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
 
@@ -1095,7 +1095,7 @@ u32 usbnet_get_msglevel (struct net_device *net)
 }
 EXPORT_SYMBOL_GPL(usbnet_get_msglevel);
 
-void usbnet_set_msglevel (struct net_device *net, u32 level)
+void usbnet_set_msglevel(struct net_device *net, u32 level)
 {
 	struct usbnet *dev = netdev_priv(net);
 
@@ -1166,7 +1166,7 @@ static void __handle_set_rx_mode(struct usbnet *dev)
  * especially now that control transfers can be queued.
  */
 static void
-usbnet_deferred_kevent (struct work_struct *work)
+usbnet_deferred_kevent(struct work_struct *work)
 {
 	struct usbnet		*dev =
 		container_of(work, struct usbnet, kevent);
@@ -1277,7 +1277,7 @@ usbnet_deferred_kevent (struct work_struct *work)
 
 /*-------------------------------------------------------------------------*/
 
-static void tx_complete (struct urb *urb)
+static void tx_complete(struct urb *urb)
 {
 	struct sk_buff		*skb = (struct sk_buff *) urb->context;
 	struct skb_data		*entry = (struct skb_data *) skb->cb;
@@ -1332,7 +1332,7 @@ static void tx_complete (struct urb *urb)
 
 /*-------------------------------------------------------------------------*/
 
-void usbnet_tx_timeout (struct net_device *net, unsigned int txqueue)
+void usbnet_tx_timeout(struct net_device *net, unsigned int txqueue)
 {
 	struct usbnet		*dev = netdev_priv(net);
 
@@ -1382,8 +1382,7 @@ static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
 	return 1;
 }
 
-netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
-				     struct net_device *net)
+netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, struct net_device *net)
 {
 	struct usbnet		*dev = netdev_priv(net);
 	unsigned int			length;
@@ -1561,7 +1560,7 @@ static inline void usb_free_skb(struct sk_buff *skb)
 
 // work (work deferred from completions, in_irq) or timer
 
-static void usbnet_bh (struct timer_list *t)
+static void usbnet_bh(struct timer_list *t)
 {
 	struct usbnet		*dev = timer_container_of(dev, t, delay);
 	struct sk_buff		*skb;
@@ -1636,7 +1635,7 @@ static void usbnet_bh_work(struct work_struct *work)
 
 // precondition: never called in_interrupt
 
-void usbnet_disconnect (struct usb_interface *intf)
+void usbnet_disconnect(struct usb_interface *intf)
 {
 	struct usbnet		*dev;
 	struct usb_device	*xdev;
@@ -1700,7 +1699,7 @@ static const struct device_type wwan_type = {
 };
 
 int
-usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
+usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 {
 	struct usbnet			*dev;
 	struct net_device		*net;
@@ -1907,7 +1906,7 @@ EXPORT_SYMBOL_GPL(usbnet_probe);
  * resume only when the last interface is resumed
  */
 
-int usbnet_suspend (struct usb_interface *intf, pm_message_t message)
+int usbnet_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet		*dev = usb_get_intfdata(intf);
 
@@ -1940,7 +1939,7 @@ int usbnet_suspend (struct usb_interface *intf, pm_message_t message)
 }
 EXPORT_SYMBOL_GPL(usbnet_suspend);
 
-int usbnet_resume (struct usb_interface *intf)
+int usbnet_resume(struct usb_interface *intf)
 {
 	struct usbnet		*dev = usb_get_intfdata(intf);
 	struct sk_buff          *skb;
-- 
2.51.1


