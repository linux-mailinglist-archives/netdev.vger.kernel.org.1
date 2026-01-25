Return-Path: <netdev+bounces-253144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHUDJxrWdWn0IwEAu9opvQ
	(envelope-from <netdev+bounces-253144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:36:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AD580073
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2778E300CC26
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCAA205E3B;
	Sun, 25 Jan 2026 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNc69PHU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3470246778
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769330139; cv=none; b=vDpIJKsSEoZMoGaCUfmM2OY1ULXectBZJeDadVuSCK6knDRKVx0MJ1jbPRA4bPwqLskmZ7GZDqCHEJQRouWeUybGGZFYF++7c7EILU0a+x1X/znZ/srLFpVzM4cS4M9fCITiFqzz2cC6D0EQa8BmheLwHLF7Y/OSN9g5NsPK9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769330139; c=relaxed/simple;
	bh=a8/Jz4t+QSejf3DaIFPp2hGHMr0wpqyl7dtL1FKK188=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjEBPHm2KGYGg39V/rPAJ9zHx6L1E2ftnQTufFVFy4K/AHJVRDNBq7LXWplrsM5jcpiiBEVslXOnxTGGLT4hmD+lOJIZI2UiLv1DQCohe0a+JgE/bhWpyDMpF0P4+EsWPDLkOm3VPPxZVF4jTE2M+0jlVZQMSDqjysd3mRVEOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNc69PHU; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b7070acfdcso4010247eec.0
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 00:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769330137; x=1769934937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRV2tc7UKGydtDugCyIQZoyJpOk914+23c8gH2LlXIA=;
        b=QNc69PHUTEcizgpth7Dx6AnPRTDKiFu0+Eikhp5CFAKsZl79+ZnVauNFIM3lPgwFMJ
         P3+QWobyPRPFB3oA0l/4sqFsN0DNOmtY4VD6yyBgrSNyNdnQ9Cg9b3dZn4xxkYboljMH
         U+kd4zI8JjgE4B+0P/YNJz9eY68Uz514KxdfQjtcuFLfpTTgZ0GwIXyzxQH4tyEqSuCA
         OBLc8OoRuYbE5jax3lvNHlT67Ox8+Dr9f1OWRPkY5R1FzFqATTTxDHOcJX+RMyu3W4Jt
         tFOvQGstb5lZBeLUaFH1vejNGvDfPz1Yz/42EPzCDoBT475iwJEFsVnCyorGH/naiJng
         65vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769330137; x=1769934937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRV2tc7UKGydtDugCyIQZoyJpOk914+23c8gH2LlXIA=;
        b=DrKX+SusyDv/y2D0o6o41I17ShI+puDPsOtNFkpolbVX+Hr1p/5bqeZ6JvSr+kDLsB
         0b055qLr065vVV4BGl6wqfkUcA6WB9fNBobCKqwE/LsVUGb2rTnONlH/olCe7OTdQPbt
         QQvz64/2nEjMkHku82GjgDk6DFg450sI5XPfo56Zl/6ISWAefmEBdnG3kI0hSzqx3E5f
         vQuTdrTK25iCrBk01KJ3MICeMUbZSrjoxUJuObAKxCYTNJrc8TrYXQrdFyfBVJ4lP1cA
         obgc8maf9DNryylt1Z3Exw7/HNWcwuffXYjpEYhkFsOGubC35cWoLTg8eNN27Mi+Y1si
         9ZvQ==
X-Gm-Message-State: AOJu0Yxo5qrE71BuimmQjlRIg9lHNOq9ZE8ff7PmjVRYXLk95FsocUUe
	zxEeKyt1tZwXRbVYABLBMtBwtpTBr2N1pRBEGiVd+idaoBplzjhFLdoMK4RpT5HA
X-Gm-Gg: AZuq6aLufaZRuPstiJixc82N7PoEoIF851FMjseSMXRNL4PXWS7fnwSndIAsvyBWfDE
	govmiqfZDR4rn3iltLJYGvlaUfU9fmoIbxfkKj323COA76v/89QhCSDbVT+ByRr+u26ciNZ6gRX
	eegf0M3r75W/GzKBW7PSxfuuE5G2SnUiTDEIhM0B/sjBryB2javOJQqvsTRUdk7gvoNAXNIwAb0
	ZOEqihstbHeUStK2140l0B3qh+kuSXz9tn6006tIE+d8T46RBiT051bs0O4di6q41UZyPdF6bS1
	3xSdgu+7B1NsWt3ZE3YZ9Medstws2khAxi60JgfpNfY2HDMS+whtkJHh4lRn3Qm/GdMadgzE+Ts
	YH4A7bCic3Mu1BfU61RprjbH6ody8nXCSbgCxG7WTWn9z44w6G942qwRF/g131lVZ2H93kWt+p8
	9DyVcoEozxC7bCUgYbJPnKlgRQ+PnK7TEkgQt7qJHZ/Cxmu2N2C8EY51qhfhB7plUvnuIzN6C54
	eMyySZ038HmgF5nUp93Vvqjr7L62+zuHombcwdxr/Us8b+YEGdD6o99XwJaxJEY8hK0Dod95Wzp
	XDxS+eeSRwDsT5Y=
X-Received: by 2002:a05:7300:dc97:b0:2b7:3538:ce5c with SMTP id 5a478bee46e88-2b76421b0b2mr428650eec.2.1769330136745;
        Sun, 25 Jan 2026 00:35:36 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7410615c0sm7994977eec.0.2026.01.25.00.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 00:35:36 -0800 (PST)
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
Subject: [PATCH net-next 2/3] net: usb: pegasus: remove pegasus_t typedef for struct pegasus
Date: Sun, 25 Jan 2026 00:34:56 -0800
Message-ID: <20260125083501.34513-3-enelsonmoore@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253144-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[carrier_check.work:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06AD580073
X-Rspamd-Action: no action

It violates kernel code style guidelines to define typedefs for
non-opaque types. Update pegasus to conform to these guidelines by
expanding the pegasus_t typedef. Also replace a few tabs before * in
struct pegasus variable declarations with spaces.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/pegasus.c | 92 +++++++++++++++++++--------------------
 drivers/net/usb/pegasus.h |  4 +-
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index c514483134f0..a85ffb04fc2b 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -97,14 +97,14 @@ static void async_ctrl_callback(struct urb *urb)
 	usb_free_urb(urb);
 }
 
-static int get_registers(pegasus_t *pegasus, __u16 indx, __u16 size, void *data)
+static int get_registers(struct pegasus *pegasus, __u16 indx, __u16 size, void *data)
 {
 	return usb_control_msg_recv(pegasus->usb, 0, PEGASUS_REQ_GET_REGS,
 				   PEGASUS_REQT_READ, 0, indx, data, size,
 				   1000, GFP_NOIO);
 }
 
-static int set_registers(pegasus_t *pegasus, __u16 indx, __u16 size,
+static int set_registers(struct pegasus *pegasus, __u16 indx, __u16 size,
 			 const void *data)
 {
 	int ret;
@@ -123,7 +123,7 @@ static int set_registers(pegasus_t *pegasus, __u16 indx, __u16 size,
  * specific control request.  'data' is ignored by the device, but it is here to
  * not break the API.
  */
-static int set_register(pegasus_t *pegasus, __u16 indx, __u8 data)
+static int set_register(struct pegasus *pegasus, __u16 indx, __u8 data)
 {
 	void *buf = &data;
 	int ret;
@@ -137,7 +137,7 @@ static int set_register(pegasus_t *pegasus, __u16 indx, __u8 data)
 	return ret;
 }
 
-static int update_eth_regs_async(pegasus_t *pegasus)
+static int update_eth_regs_async(struct pegasus *pegasus)
 {
 	int ret = -ENOMEM;
 	struct urb *async_urb;
@@ -174,7 +174,7 @@ static int update_eth_regs_async(pegasus_t *pegasus)
 	return ret;
 }
 
-static int __mii_op(pegasus_t *p, __u8 phy, __u8 indx, __u16 *regd, __u8 cmd)
+static int __mii_op(struct pegasus *p, __u8 phy, __u8 indx, __u16 *regd, __u8 cmd)
 {
 	int i, ret;
 	__le16 regdi;
@@ -211,20 +211,20 @@ static int __mii_op(pegasus_t *p, __u8 phy, __u8 indx, __u16 *regd, __u8 cmd)
 }
 
 /* Returns non-negative int on success, error on failure */
-static int read_mii_word(pegasus_t *pegasus, __u8 phy, __u8 indx, __u16 *regd)
+static int read_mii_word(struct pegasus *pegasus, __u8 phy, __u8 indx, __u16 *regd)
 {
 	return __mii_op(pegasus, phy, indx, regd, PHY_READ);
 }
 
 /* Returns zero on success, error on failure */
-static int write_mii_word(pegasus_t *pegasus, __u8 phy, __u8 indx, __u16 *regd)
+static int write_mii_word(struct pegasus *pegasus, __u8 phy, __u8 indx, __u16 *regd)
 {
 	return __mii_op(pegasus, phy, indx, regd, PHY_WRITE);
 }
 
 static int mdio_read(struct net_device *dev, int phy_id, int loc)
 {
-	pegasus_t *pegasus = netdev_priv(dev);
+	struct pegasus *pegasus = netdev_priv(dev);
 	int ret;
 	u16 res;
 
@@ -237,13 +237,13 @@ static int mdio_read(struct net_device *dev, int phy_id, int loc)
 
 static void mdio_write(struct net_device *dev, int phy_id, int loc, int val)
 {
-	pegasus_t *pegasus = netdev_priv(dev);
+	struct pegasus *pegasus = netdev_priv(dev);
 	u16 data = val;
 
 	write_mii_word(pegasus, phy_id, loc, &data);
 }
 
-static int read_eprom_word(pegasus_t *pegasus, __u8 index, __u16 *retdata)
+static int read_eprom_word(struct pegasus *pegasus, __u8 index, __u16 *retdata)
 {
 	int ret, i;
 	__le16 retdatai;
@@ -277,7 +277,7 @@ static int read_eprom_word(pegasus_t *pegasus, __u8 index, __u16 *retdata)
 }
 
 #ifdef	PEGASUS_WRITE_EEPROM
-static inline void enable_eprom_write(pegasus_t *pegasus)
+static inline void enable_eprom_write(struct pegasus *pegasus)
 {
 	__u8 tmp;
 
@@ -285,7 +285,7 @@ static inline void enable_eprom_write(pegasus_t *pegasus)
 	set_register(pegasus, EthCtrl2, tmp | EPROM_WR_ENABLE);
 }
 
-static inline void disable_eprom_write(pegasus_t *pegasus)
+static inline void disable_eprom_write(struct pegasus *pegasus)
 {
 	__u8 tmp;
 
@@ -294,7 +294,7 @@ static inline void disable_eprom_write(pegasus_t *pegasus)
 	set_register(pegasus, EthCtrl2, tmp & ~EPROM_WR_ENABLE);
 }
 
-static int write_eprom_word(pegasus_t *pegasus, __u8 index, __u16 data)
+static int write_eprom_word(struct pegasus *pegasus, __u8 index, __u16 data)
 {
 	int i;
 	__u8 tmp, d[4] = { 0x3f, 0, 0, EPROM_WRITE };
@@ -326,7 +326,7 @@ static int write_eprom_word(pegasus_t *pegasus, __u8 index, __u16 data)
 }
 #endif	/* PEGASUS_WRITE_EEPROM */
 
-static inline int get_node_id(pegasus_t *pegasus, u8 *id)
+static inline int get_node_id(struct pegasus *pegasus, u8 *id)
 {
 	int i, ret;
 	u16 w16;
@@ -341,7 +341,7 @@ static inline int get_node_id(pegasus_t *pegasus, u8 *id)
 	return 0;
 }
 
-static void set_ethernet_addr(pegasus_t *pegasus)
+static void set_ethernet_addr(struct pegasus *pegasus)
 {
 	int ret;
 	u8 node_id[6];
@@ -369,7 +369,7 @@ static void set_ethernet_addr(pegasus_t *pegasus)
 	return;
 }
 
-static inline int reset_mac(pegasus_t *pegasus)
+static inline int reset_mac(struct pegasus *pegasus)
 {
 	int ret, i;
 	__u8 data = 0x8;
@@ -416,7 +416,7 @@ static inline int reset_mac(pegasus_t *pegasus)
 
 static int enable_net_traffic(struct net_device *dev, struct usb_device *usb)
 {
-	pegasus_t *pegasus = netdev_priv(dev);
+	struct pegasus *pegasus = netdev_priv(dev);
 	int ret;
 	__u16 linkpart;
 	__u8 data[4];
@@ -456,7 +456,7 @@ static int enable_net_traffic(struct net_device *dev, struct usb_device *usb)
 
 static void read_bulk_callback(struct urb *urb)
 {
-	pegasus_t *pegasus = urb->context;
+	struct pegasus *pegasus = urb->context;
 	struct net_device *net;
 	u8 *buf = urb->transfer_buffer;
 	int rx_status, count = urb->actual_length;
@@ -566,7 +566,7 @@ static void read_bulk_callback(struct urb *urb)
 
 static void rx_fixup(struct tasklet_struct *t)
 {
-	pegasus_t *pegasus = from_tasklet(pegasus, t, rx_tl);
+	struct pegasus *pegasus = from_tasklet(pegasus, t, rx_tl);
 	int status;
 
 	if (pegasus->flags & PEGASUS_UNPLUG)
@@ -602,7 +602,7 @@ static void rx_fixup(struct tasklet_struct *t)
 
 static void write_bulk_callback(struct urb *urb)
 {
-	pegasus_t *pegasus = urb->context;
+	struct pegasus *pegasus = urb->context;
 	struct net_device *net;
 	int status = urb->status;
 
@@ -638,7 +638,7 @@ static void write_bulk_callback(struct urb *urb)
 
 static void intr_callback(struct urb *urb)
 {
-	pegasus_t *pegasus = urb->context;
+	struct pegasus *pegasus = urb->context;
 	struct net_device *net;
 	int res, status = urb->status;
 
@@ -694,7 +694,7 @@ static void intr_callback(struct urb *urb)
 
 static void pegasus_tx_timeout(struct net_device *net, unsigned int txqueue)
 {
-	pegasus_t *pegasus = netdev_priv(net);
+	struct pegasus *pegasus = netdev_priv(net);
 	netif_warn(pegasus, timer, net, "tx timeout\n");
 	usb_unlink_urb(pegasus->tx_urb);
 	net->stats.tx_errors++;
@@ -703,7 +703,7 @@ static void pegasus_tx_timeout(struct net_device *net, unsigned int txqueue)
 static netdev_tx_t pegasus_start_xmit(struct sk_buff *skb,
 					    struct net_device *net)
 {
-	pegasus_t *pegasus = netdev_priv(net);
+	struct pegasus *pegasus = netdev_priv(net);
 	int count = ((skb->len + 2) & 0x3f) ? skb->len + 2 : skb->len + 3;
 	int res;
 	__u16 l16 = skb->len;
@@ -739,14 +739,14 @@ static netdev_tx_t pegasus_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static inline void disable_net_traffic(pegasus_t *pegasus)
+static inline void disable_net_traffic(struct pegasus *pegasus)
 {
 	__le16 tmp = cpu_to_le16(0);
 
 	set_registers(pegasus, EthCtrl0, sizeof(tmp), &tmp);
 }
 
-static inline int get_interrupt_interval(pegasus_t *pegasus)
+static inline int get_interrupt_interval(struct pegasus *pegasus)
 {
 	u16 data;
 	u8 interval;
@@ -776,7 +776,7 @@ static inline int get_interrupt_interval(pegasus_t *pegasus)
 
 static void set_carrier(struct net_device *net)
 {
-	pegasus_t *pegasus = netdev_priv(net);
+	struct pegasus *pegasus = netdev_priv(net);
 	u16 tmp;
 
 	if (read_mii_word(pegasus, pegasus->phy, MII_BMSR, &tmp))
@@ -788,21 +788,21 @@ static void set_carrier(struct net_device *net)
 		netif_carrier_off(net);
 }
 
-static void free_all_urbs(pegasus_t *pegasus)
+static void free_all_urbs(struct pegasus *pegasus)
 {
 	usb_free_urb(pegasus->intr_urb);
 	usb_free_urb(pegasus->tx_urb);
 	usb_free_urb(pegasus->rx_urb);
 }
 
-static void unlink_all_urbs(pegasus_t *pegasus)
+static void unlink_all_urbs(struct pegasus *pegasus)
 {
 	usb_kill_urb(pegasus->intr_urb);
 	usb_kill_urb(pegasus->tx_urb);
 	usb_kill_urb(pegasus->rx_urb);
 }
 
-static int alloc_urbs(pegasus_t *pegasus)
+static int alloc_urbs(struct pegasus *pegasus)
 {
 	int res = -ENOMEM;
 
@@ -827,7 +827,7 @@ static int alloc_urbs(pegasus_t *pegasus)
 
 static int pegasus_open(struct net_device *net)
 {
-	pegasus_t *pegasus = netdev_priv(net);
+	struct pegasus *pegasus = netdev_priv(net);
 	int res=-ENOMEM;
 
 	if (pegasus->rx_skb == NULL)
@@ -880,7 +880,7 @@ static int pegasus_open(struct net_device *net)
 
 static int pegasus_close(struct net_device *net)
 {
-	pegasus_t *pegasus = netdev_priv(net);
+	struct pegasus *pegasus = netdev_priv(net);
 
 	netif_stop_queue(net);
 	if (!(pegasus->flags & PEGASUS_UNPLUG))
@@ -894,7 +894,7 @@ static int pegasus_close(struct net_device *net)
 static void pegasus_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
-	pegasus_t *pegasus = netdev_priv(dev);
+	struct pegasus *pegasus = netdev_priv(dev);
 
 	strscpy(info->driver, driver_name, sizeof(info->driver));
 	usb_make_path(pegasus->usb, info->bus_info, sizeof(info->bus_info));
@@ -906,7 +906,7 @@ static void pegasus_get_drvinfo(struct net_device *dev,
 static void
 pegasus_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
-	pegasus_t	*pegasus = netdev_priv(dev);
+	struct pegasus *pegasus = netdev_priv(dev);
 
 	wol->supported = WAKE_MAGIC | WAKE_PHY;
 	wol->wolopts = pegasus->wolopts;
@@ -915,7 +915,7 @@ pegasus_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int
 pegasus_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
-	pegasus_t	*pegasus = netdev_priv(dev);
+	struct pegasus *pegasus = netdev_priv(dev);
 	u8		reg78 = 0x04;
 	int		ret;
 
@@ -952,7 +952,7 @@ static int
 pegasus_get_link_ksettings(struct net_device *dev,
 			   struct ethtool_link_ksettings *ecmd)
 {
-	pegasus_t *pegasus;
+	struct pegasus *pegasus;
 
 	pegasus = netdev_priv(dev);
 	mii_ethtool_get_link_ksettings(&pegasus->mii, ecmd);
@@ -963,31 +963,31 @@ static int
 pegasus_set_link_ksettings(struct net_device *dev,
 			   const struct ethtool_link_ksettings *ecmd)
 {
-	pegasus_t *pegasus = netdev_priv(dev);
+	struct pegasus *pegasus = netdev_priv(dev);
 	return mii_ethtool_set_link_ksettings(&pegasus->mii, ecmd);
 }
 
 static int pegasus_nway_reset(struct net_device *dev)
 {
-	pegasus_t *pegasus = netdev_priv(dev);
+	struct pegasus *pegasus = netdev_priv(dev);
 	return mii_nway_restart(&pegasus->mii);
 }
 
 static u32 pegasus_get_link(struct net_device *dev)
 {
-	pegasus_t *pegasus = netdev_priv(dev);
+	struct pegasus *pegasus = netdev_priv(dev);
 	return mii_link_ok(&pegasus->mii);
 }
 
 static u32 pegasus_get_msglevel(struct net_device *dev)
 {
-	pegasus_t *pegasus = netdev_priv(dev);
+	struct pegasus *pegasus = netdev_priv(dev);
 	return pegasus->msg_enable;
 }
 
 static void pegasus_set_msglevel(struct net_device *dev, u32 v)
 {
-	pegasus_t *pegasus = netdev_priv(dev);
+	struct pegasus *pegasus = netdev_priv(dev);
 	pegasus->msg_enable = v;
 }
 
@@ -1007,7 +1007,7 @@ static int pegasus_siocdevprivate(struct net_device *net, struct ifreq *rq,
 				  void __user *udata, int cmd)
 {
 	__u16 *data = (__u16 *) &rq->ifr_ifru;
-	pegasus_t *pegasus = netdev_priv(net);
+	struct pegasus *pegasus = netdev_priv(net);
 	int res;
 
 	switch (cmd) {
@@ -1031,7 +1031,7 @@ static int pegasus_siocdevprivate(struct net_device *net, struct ifreq *rq,
 
 static void pegasus_set_multicast(struct net_device *net)
 {
-	pegasus_t *pegasus = netdev_priv(net);
+	struct pegasus *pegasus = netdev_priv(net);
 
 	if (net->flags & IFF_PROMISC) {
 		pegasus->eth_regs[EthCtrl2] |= RX_PROMISCUOUS;
@@ -1047,7 +1047,7 @@ static void pegasus_set_multicast(struct net_device *net)
 	update_eth_regs_async(pegasus);
 }
 
-static __u8 mii_phy_probe(pegasus_t *pegasus)
+static __u8 mii_phy_probe(struct pegasus *pegasus)
 {
 	int i, ret;
 	__u16 tmp;
@@ -1065,7 +1065,7 @@ static __u8 mii_phy_probe(pegasus_t *pegasus)
 	return 0xff;
 }
 
-static inline void setup_pegasus_II(pegasus_t *pegasus)
+static inline void setup_pegasus_II(struct pegasus *pegasus)
 {
 	int ret;
 	__u8 data = 0xa5;
@@ -1104,7 +1104,7 @@ static inline void setup_pegasus_II(pegasus_t *pegasus)
 
 static void check_carrier(struct work_struct *work)
 {
-	pegasus_t *pegasus = container_of(work, pegasus_t, carrier_check.work);
+	struct pegasus *pegasus = container_of(work, struct pegasus, carrier_check.work);
 	set_carrier(pegasus->net);
 	if (!(pegasus->flags & PEGASUS_UNPLUG)) {
 		queue_delayed_work(system_long_wq, &pegasus->carrier_check,
@@ -1133,7 +1133,7 @@ static int pegasus_probe(struct usb_interface *intf,
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct net_device *net;
-	pegasus_t *pegasus;
+	struct pegasus *pegasus;
 	int dev_index = id - pegasus_ids;
 	int res = -ENOMEM;
 
diff --git a/drivers/net/usb/pegasus.h b/drivers/net/usb/pegasus.h
index a05b143155ba..6810adf43f78 100644
--- a/drivers/net/usb/pegasus.h
+++ b/drivers/net/usb/pegasus.h
@@ -76,7 +76,7 @@ enum pegasus_registers {
 };
 
 
-typedef struct pegasus {
+struct pegasus {
 	struct usb_device	*usb;
 	struct usb_interface	*intf;
 	struct net_device	*net;
@@ -97,7 +97,7 @@ typedef struct pegasus {
 	__u8			eth_regs[4];
 	__u8			phy;
 	__u8			gpio_res;
-} pegasus_t;
+};
 
 
 struct usb_eth_dev {
-- 
2.43.0


