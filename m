Return-Path: <netdev+bounces-253143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P9AJtnVdWn0IwEAu9opvQ
	(envelope-from <netdev+bounces-253143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:35:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7618005A
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 889883002908
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79631815D;
	Sun, 25 Jan 2026 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUMxDSo0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5521A459
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769330130; cv=none; b=Yrv9I0e27c/P/Kzfj7BsG4ftwL0TaYLDgHtGlbL+sdZY/4TDpNCmKMAgbz+cL1eyX5i4LQRKq+PQqQPHpadQiL4eRD/qxptB84IPXFdTfZLXeAQ64gGAvyof0AHgMJUkCfDpvcW1RHfzUYA+I94/l0AK7jyjWzUsqHQwYcGZ8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769330130; c=relaxed/simple;
	bh=GzBDLGBocitxdoam6aBT/6PlZGW+8mF1hp9l3EqP07U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF2Mn5rB5aW4L8ekVTW834RGwQMSguxYEaUC5FwWOZCkdIOLsvPdefL6Jpr3nKJJCFDjfO5FqHQPBXke06mrHGx2IFRT4ZEDAnmWxCVTogYNMQZ6dHbLjpKDZkM1d1wi6Zvv7BXafhGvU0ci6ab9xHUUI6w7V1+c1JcVRew+tZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUMxDSo0; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b720bb90d0so3181905eec.0
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 00:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769330128; x=1769934928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNy2hBem/8NYXTwi6a7AXV3n4+qEbntRa2UCgw80QcU=;
        b=DUMxDSo0Rj/9p5BKH1LkYjsfXNbe55QIP09v2MNOAtWgmiEgm0Ie3YVrKfJur3gzAS
         LwvlpbRZ824j3snXTYPbT7J/uxyIUzr8ED2q3xvf64JR36ZydAp0enTgbHhbHDi6rqvV
         1G0KuITLBu/NeQIkM+7CwB37TqqHsAZkhAUBefhmBf7uDiXTvfoyLbFT1hZwbiKOiKWm
         6vB+ZipeZx9aJi7d7hJPHp7eoYkvAoLr5CoH8cb5PSQJBS2oxp/PjQw0VJhSZRcY8Mq2
         Tj8r2eJg/lKXPBhl9XJoS64xCw7WAzTTu0iNLtL83vKLnIfdO6WpPREi0vP3Oo+Capqz
         gDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769330128; x=1769934928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNy2hBem/8NYXTwi6a7AXV3n4+qEbntRa2UCgw80QcU=;
        b=M/NliJThcMEFHj9ECxZCHVOci+g76UqVPGS38M4krGxyocRTJ/qOH293VS8k1yf0ts
         cLXF2wjPAhLm91+Ylda3FWrBUwuTRx8hCz+vDERny5WpLWFEa+RP3SkMhrlddQhO2LjQ
         FPO9MIUPgo9bYfONAV7g870GIc3RuvdPPvSfldWQUJdIOC3TdaDZYuR5nM/Qewd7w1Wn
         r2OAucfYdNG94Qw3c40Qo3/ynNbRmVR5g36vgoQfPcoUH4eE9Ipd/yNFb8EtAfrVatg5
         joO91vshQRvMNGO4P7sog3opLewix68oEOT9mzppkQJQYpiUivE0qbTWJQhvVEvcrrx4
         iX2g==
X-Gm-Message-State: AOJu0Yxi8xnrc4wXV7O4YrK2WojQi1H7ym2g6WqagnoEN6ie8t+0Q6jX
	p/lZi66l5TxzNnKmSLTO9DpmdJeMRzMiikUFXzVEGMpV39E/3pdndtATl3lea4Dg
X-Gm-Gg: AZuq6aLytdnHfzfAtpGyO81Z3RJqv4hhb8+CiPXPOFEpe1/9SJ0dOACKzXFT/BOZf5P
	GSnsdnCoLB2Is6dA9bEtIfA0ahGkl+V6YLaeVr6ckWukqzMscsQw9DLwlbDNjWODyug/ckaxURF
	hudtUR0KJZTmfmuKDLxgh6caw1gTd0AgRKIBfPtQrL7BPTL9pvH4/9js9GmZKYcFn1Oi04JumWE
	0/C4uVWcVwELUt7Wxhdx397YMArDZS5wyTacibx0CANGsHgElQPCyRfy97rnC1e5088LQrcZe6B
	9oIE0nfhT6RJOXcvhHJe6fBWa0TEXHkFTb0VT/2QoXgS/kWqDUruW6iJu7VF4M1a6kiKTh5vXSi
	wD9hzPb5g8o5VVjmrqXhUPq6dNFn3GFcjvgh/8vnWCoQDOux3oCsbFWRlt17+Zd0QvEcg2UwN/A
	NZPA+msh4+kecTYWto2pE7tPi6UAmdStEpQEaH/aiXrLCqNuzXdvdZT3jbTj7FZ96yT9aQGghD2
	OpZE+7T/mYaSk/GrWEIzUcQIcPof6WnaV3va0dAIF8dVr4YBIl4pwNYJctWhY3czmBrxBSNRFon
	OHXx
X-Received: by 2002:a05:7300:cc1b:b0:2b7:1abc:a6eb with SMTP id 5a478bee46e88-2b764218a16mr498757eec.7.1769330127811;
        Sun, 25 Jan 2026 00:35:27 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7410615c0sm7994977eec.0.2026.01.25.00.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 00:35:27 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/3] net: usb: rtl8150: remove rtl8150_t typedef for struct rtl8150
Date: Sun, 25 Jan 2026 00:34:55 -0800
Message-ID: <20260125083501.34513-2-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125083501.34513-1-enelsonmoore@gmail.com>
References: <20260125083501.34513-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253143-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nucleusys.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B7618005A
X-Rspamd-Action: no action

It violates kernel code style guidelines to define typedefs for
non-opaque types. Update rtl8150 to conform to these guidelines by
expanding the rtl8150_t typedef. Also remove a few extra spaces after
the * in pointer declarations to adhere to kernel code style.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/rtl8150.c | 68 +++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index e40b0669d9f4..142bd468b2a3 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -144,8 +144,6 @@ struct rtl8150 {
 	u8 phy;
 };
 
-typedef struct rtl8150 rtl8150_t;
-
 struct async_req {
 	struct usb_ctrlrequest dr;
 	u16 rx_creg;
@@ -158,14 +156,14 @@ static const char driver_name [] = "rtl8150";
 **	device related part of the code
 **
 */
-static int get_registers(rtl8150_t * dev, u16 indx, u16 size, void *data)
+static int get_registers(struct rtl8150 *dev, u16 indx, u16 size, void *data)
 {
 	return usb_control_msg_recv(dev->udev, 0, RTL8150_REQ_GET_REGS,
 				    RTL8150_REQT_READ, indx, 0, data, size,
 				    1000, GFP_NOIO);
 }
 
-static int set_registers(rtl8150_t * dev, u16 indx, u16 size, const void *data)
+static int set_registers(struct rtl8150 *dev, u16 indx, u16 size, const void *data)
 {
 	return usb_control_msg_send(dev->udev, 0, RTL8150_REQ_SET_REGS,
 				    RTL8150_REQT_WRITE, indx, 0, data, size,
@@ -183,7 +181,7 @@ static void async_set_reg_cb(struct urb *urb)
 	usb_free_urb(urb);
 }
 
-static int async_set_registers(rtl8150_t *dev, u16 indx, u16 size, u16 reg)
+static int async_set_registers(struct rtl8150 *dev, u16 indx, u16 size, u16 reg)
 {
 	int res = -ENOMEM;
 	struct urb *async_urb;
@@ -217,7 +215,7 @@ static int async_set_registers(rtl8150_t *dev, u16 indx, u16 size, u16 reg)
 	return res;
 }
 
-static int read_mii_word(rtl8150_t * dev, u8 phy, __u8 indx, u16 * reg)
+static int read_mii_word(struct rtl8150 *dev, u8 phy, __u8 indx, u16 *reg)
 {
 	int i;
 	u8 data[3], tmp;
@@ -241,7 +239,7 @@ static int read_mii_word(rtl8150_t * dev, u8 phy, __u8 indx, u16 * reg)
 		return 1;
 }
 
-static int write_mii_word(rtl8150_t * dev, u8 phy, __u8 indx, u16 reg)
+static int write_mii_word(struct rtl8150 *dev, u8 phy, __u8 indx, u16 reg)
 {
 	int i;
 	u8 data[3], tmp;
@@ -264,7 +262,7 @@ static int write_mii_word(rtl8150_t * dev, u8 phy, __u8 indx, u16 reg)
 		return 1;
 }
 
-static void set_ethernet_addr(rtl8150_t *dev)
+static void set_ethernet_addr(struct rtl8150 *dev)
 {
 	u8 node_id[ETH_ALEN];
 	int ret;
@@ -283,7 +281,7 @@ static void set_ethernet_addr(rtl8150_t *dev)
 static int rtl8150_set_mac_address(struct net_device *netdev, void *p)
 {
 	struct sockaddr *addr = p;
-	rtl8150_t *dev = netdev_priv(netdev);
+	struct rtl8150 *dev = netdev_priv(netdev);
 
 	if (netif_running(netdev))
 		return -EBUSY;
@@ -315,7 +313,7 @@ static int rtl8150_set_mac_address(struct net_device *netdev, void *p)
 	return 0;
 }
 
-static int rtl8150_reset(rtl8150_t * dev)
+static int rtl8150_reset(struct rtl8150 *dev)
 {
 	u8 data = 0x10;
 	int i = HZ;
@@ -328,7 +326,7 @@ static int rtl8150_reset(rtl8150_t * dev)
 	return (i > 0) ? 1 : 0;
 }
 
-static int alloc_all_urbs(rtl8150_t * dev)
+static int alloc_all_urbs(struct rtl8150 *dev)
 {
 	dev->rx_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!dev->rx_urb)
@@ -348,21 +346,21 @@ static int alloc_all_urbs(rtl8150_t * dev)
 	return 1;
 }
 
-static void free_all_urbs(rtl8150_t * dev)
+static void free_all_urbs(struct rtl8150 *dev)
 {
 	usb_free_urb(dev->rx_urb);
 	usb_free_urb(dev->tx_urb);
 	usb_free_urb(dev->intr_urb);
 }
 
-static void unlink_all_urbs(rtl8150_t * dev)
+static void unlink_all_urbs(struct rtl8150 *dev)
 {
 	usb_kill_urb(dev->rx_urb);
 	usb_kill_urb(dev->tx_urb);
 	usb_kill_urb(dev->intr_urb);
 }
 
-static inline struct sk_buff *pull_skb(rtl8150_t *dev)
+static inline struct sk_buff *pull_skb(struct rtl8150 *dev)
 {
 	struct sk_buff *skb;
 	int i;
@@ -379,7 +377,7 @@ static inline struct sk_buff *pull_skb(rtl8150_t *dev)
 
 static void read_bulk_callback(struct urb *urb)
 {
-	rtl8150_t *dev;
+	struct rtl8150 *dev;
 	unsigned pkt_len, res;
 	struct sk_buff *skb;
 	struct net_device *netdev;
@@ -453,7 +451,7 @@ static void read_bulk_callback(struct urb *urb)
 
 static void write_bulk_callback(struct urb *urb)
 {
-	rtl8150_t *dev;
+	struct rtl8150 *dev;
 	int status = urb->status;
 
 	dev = urb->context;
@@ -471,7 +469,7 @@ static void write_bulk_callback(struct urb *urb)
 
 static void intr_callback(struct urb *urb)
 {
-	rtl8150_t *dev;
+	struct rtl8150 *dev;
 	__u8 *d;
 	int status = urb->status;
 	int res;
@@ -528,7 +526,7 @@ static void intr_callback(struct urb *urb)
 
 static int rtl8150_suspend(struct usb_interface *intf, pm_message_t message)
 {
-	rtl8150_t *dev = usb_get_intfdata(intf);
+	struct rtl8150 *dev = usb_get_intfdata(intf);
 
 	netif_device_detach(dev->netdev);
 
@@ -541,7 +539,7 @@ static int rtl8150_suspend(struct usb_interface *intf, pm_message_t message)
 
 static int rtl8150_resume(struct usb_interface *intf)
 {
-	rtl8150_t *dev = usb_get_intfdata(intf);
+	struct rtl8150 *dev = usb_get_intfdata(intf);
 
 	netif_device_attach(dev->netdev);
 	if (netif_running(dev->netdev)) {
@@ -562,7 +560,7 @@ static int rtl8150_resume(struct usb_interface *intf)
 **
 */
 
-static void fill_skb_pool(rtl8150_t *dev)
+static void fill_skb_pool(struct rtl8150 *dev)
 {
 	struct sk_buff *skb;
 	int i;
@@ -579,7 +577,7 @@ static void fill_skb_pool(rtl8150_t *dev)
 	}
 }
 
-static void free_skb_pool(rtl8150_t *dev)
+static void free_skb_pool(struct rtl8150 *dev)
 {
 	int i;
 
@@ -623,7 +621,7 @@ static void rx_fixup(struct tasklet_struct *t)
 	tasklet_schedule(&dev->tl);
 }
 
-static int enable_net_traffic(rtl8150_t * dev)
+static int enable_net_traffic(struct rtl8150 *dev)
 {
 	u8 cr, tcr, rcr, msr;
 
@@ -644,7 +642,7 @@ static int enable_net_traffic(rtl8150_t * dev)
 	return 0;
 }
 
-static void disable_net_traffic(rtl8150_t * dev)
+static void disable_net_traffic(struct rtl8150 *dev)
 {
 	u8 cr;
 
@@ -655,7 +653,7 @@ static void disable_net_traffic(rtl8150_t * dev)
 
 static void rtl8150_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 {
-	rtl8150_t *dev = netdev_priv(netdev);
+	struct rtl8150 *dev = netdev_priv(netdev);
 	dev_warn(&netdev->dev, "Tx timeout.\n");
 	usb_unlink_urb(dev->tx_urb);
 	netdev->stats.tx_errors++;
@@ -663,7 +661,7 @@ static void rtl8150_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 
 static void rtl8150_set_multicast(struct net_device *netdev)
 {
-	rtl8150_t *dev = netdev_priv(netdev);
+	struct rtl8150 *dev = netdev_priv(netdev);
 	u16 rx_creg = 0x9e;
 
 	if (netdev->flags & IFF_PROMISC) {
@@ -684,7 +682,7 @@ static void rtl8150_set_multicast(struct net_device *netdev)
 static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 					    struct net_device *netdev)
 {
-	rtl8150_t *dev = netdev_priv(netdev);
+	struct rtl8150 *dev = netdev_priv(netdev);
 	int count, res;
 
 	/* pad the frame and ensure terminating USB packet, datasheet 9.2.3 */
@@ -721,7 +719,7 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 
 static void set_carrier(struct net_device *netdev)
 {
-	rtl8150_t *dev = netdev_priv(netdev);
+	struct rtl8150 *dev = netdev_priv(netdev);
 	short tmp;
 
 	get_registers(dev, CSCR, 2, &tmp);
@@ -733,7 +731,7 @@ static void set_carrier(struct net_device *netdev)
 
 static int rtl8150_open(struct net_device *netdev)
 {
-	rtl8150_t *dev = netdev_priv(netdev);
+	struct rtl8150 *dev = netdev_priv(netdev);
 	int res;
 
 	if (dev->rx_skb == NULL)
@@ -770,7 +768,7 @@ static int rtl8150_open(struct net_device *netdev)
 
 static int rtl8150_close(struct net_device *netdev)
 {
-	rtl8150_t *dev = netdev_priv(netdev);
+	struct rtl8150 *dev = netdev_priv(netdev);
 
 	netif_stop_queue(netdev);
 	if (!test_bit(RTL8150_UNPLUG, &dev->flags))
@@ -782,7 +780,7 @@ static int rtl8150_close(struct net_device *netdev)
 
 static void rtl8150_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 {
-	rtl8150_t *dev = netdev_priv(netdev);
+	struct rtl8150 *dev = netdev_priv(netdev);
 
 	strscpy(info->driver, driver_name, sizeof(info->driver));
 	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
@@ -792,7 +790,7 @@ static void rtl8150_get_drvinfo(struct net_device *netdev, struct ethtool_drvinf
 static int rtl8150_get_link_ksettings(struct net_device *netdev,
 				      struct ethtool_link_ksettings *ecmd)
 {
-	rtl8150_t *dev = netdev_priv(netdev);
+	struct rtl8150 *dev = netdev_priv(netdev);
 	short lpa = 0;
 	short bmcr = 0;
 	u32 supported;
@@ -841,7 +839,7 @@ static const struct ethtool_ops ops = {
 static int rtl8150_siocdevprivate(struct net_device *netdev, struct ifreq *rq,
 				  void __user *udata, int cmd)
 {
-	rtl8150_t *dev = netdev_priv(netdev);
+	struct rtl8150 *dev = netdev_priv(netdev);
 	u16 *data = (u16 *) & rq->ifr_ifru;
 	int res = 0;
 
@@ -880,7 +878,7 @@ static int rtl8150_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
-	rtl8150_t *dev;
+	struct rtl8150 *dev;
 	struct net_device *netdev;
 	static const u8 bulk_ep_addr[] = {
 		RTL8150_USB_EP_BULK_IN | USB_DIR_IN,
@@ -890,7 +888,7 @@ static int rtl8150_probe(struct usb_interface *intf,
 		RTL8150_USB_EP_INT_IN | USB_DIR_IN,
 		0};
 
-	netdev = alloc_etherdev(sizeof(rtl8150_t));
+	netdev = alloc_etherdev(sizeof(struct rtl8150));
 	if (!netdev)
 		return -ENOMEM;
 
@@ -954,7 +952,7 @@ static int rtl8150_probe(struct usb_interface *intf,
 
 static void rtl8150_disconnect(struct usb_interface *intf)
 {
-	rtl8150_t *dev = usb_get_intfdata(intf);
+	struct rtl8150 *dev = usb_get_intfdata(intf);
 
 	usb_set_intfdata(intf, NULL);
 	if (dev) {
-- 
2.43.0


