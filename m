Return-Path: <netdev+bounces-272921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FNEODo5yWmKwAUAu9opvQ
	(envelope-from <netdev+bounces-272921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:37:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A760352732
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFDF23041780
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653F637CD22;
	Sun, 29 Mar 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lWKIRLFL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FTUThhHj"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB736EAB8;
	Sun, 29 Mar 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774794926; cv=none; b=MCZTaS4w24nM8KPx7DNyIYu0QnRZ7EOPNsvredhDsqZBq6JAn98HJbxgUb3Fc/HpPFmimdXibe/gKdiewKCCkWJ//D7LSYtZ0V8FBz6FxVBXbPaMgb1gBGhb+zp/sTrzdRB5Ne67DRErLKj9F8LFwY/Jw9nfKMPM4CqyPMvePOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774794926; c=relaxed/simple;
	bh=s3/VKpFq2ZVvYcAhvpWyg0QzeZ+ObTgNF74YA20D090=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loaO2caiBlMUu3wqjZlnX1hjovn7+XQ4huubB1U0kFU49lokRd+tQO/MphUeKLZ9pM6m6Q8Pax0AlqF/6KQcCszLmTm1s0i+wfu1JvxDdhtAJWwxIupbWLKng0RJkMMcIjb3lqr3GifBzL/A3HkBzhDWK8G1Gr9De0PyPddUXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lWKIRLFL; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FTUThhHj; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fkH3Z4FFxzB15Y;
	Sun, 29 Mar 2026 16:35:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSHEf+vOm07DUwuFZuNsd+xmh9OA334UYTdjyDKm8JM=;
	b=lWKIRLFLL2VEVe4uBzByTpCkJzto+CqnHV3ZB4cBrox+42dIPh/5rO2rUUD6fgGGRbiePf
	HJPrz/L+Iwpw7C3K3WeS3oqyNwbqlr/3mIXOF1iPsToAAajF33J1VtEqxuMvmTo863lN0I
	Tt00i/Vy28p8L0FEA4jPaUMl3Iu9C0JpW5VI4EDpAbCNXGS33MB2iliwKbudUnndyYv8zB
	HpuhaoZkIlUkz56rC4sTFlcZn7qKIEYNHj3xhf2gjqLo1lnpmPUjzW70Vtxphh/ZgLCzf+
	A5B2P2R/JjE4W0qxNj8NYeA1nSh/5C9mHBqaefarNGButbo677EfE/+Z891Zgg==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSHEf+vOm07DUwuFZuNsd+xmh9OA334UYTdjyDKm8JM=;
	b=FTUThhHjp0fAC0Kx/lb1F9AgkwkqztJ1fPD6iU1KA2ZZuOgZuDf6MY570Ox92oAM9Gvd5y
	JOPOLxcHbsnXUQLMfdzL/T3chKB7bPuyRgNXcxD6vdwyaGapXJ8ef/RtnAj4EiPlKng+mp
	2ssHsWiAht/LRrwYnDO1leuGAzERVKHRx9OiWJyr5s8W+IwoWao32QQHOtjUwfWLhhi+j5
	XbRmpkCnAjasowIL5rhL2X8xTNU98yzMGtADV3Ek0pfl9unAxjrnie2Hr0VyuK1Z5SmhIH
	iOq9sj/JRpVnSp2kIniYGpWfPU8j7rtbLEGg8DjwnhV2V8ErzOqkY+IDXJxN6A==
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH 4/5] hamradio: mkiss: modernize logging with netdev and pr macros
Date: Sun, 29 Mar 2026 22:34:07 +0800
Message-ID: <20260329143408.747197-5-mashiro.chen@mailbox.org>
In-Reply-To: <20260329143408.747197-1-mashiro.chen@mailbox.org>
References: <20260329143408.747197-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e24e158184cdcadac5d
X-MBO-RS-META: qqikef4qtbimyw6zz684nkett7ayd995
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272921-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A760352732
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace legacy printk() calls with modern logging macros.
This allows for better device-specific context by using
netdev_err() and netdev_info() where possible. For global
module-level messages, use pr_info() and pr_err(). This
modernization also allows the removal of the redundant
'banner' and 'msg_regfail' static strings, simplifying
the driver initialization logic.

Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/mkiss.c | 51 ++++++++++++------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index b9160b95f..75b9bd2e1 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -249,9 +249,7 @@ static void ax_bump(struct mkiss *ax)
 				return;
 			}
 			if (ax->crcmode != CRC_MODE_SMACK && ax->crcauto) {
-				printk(KERN_INFO
-				       "mkiss: %s: Switching to crc-smack\n",
-				       ax->dev->name);
+				netdev_info(ax->dev, "Switching to crc-smack\n");
 				ax->crcmode = CRC_MODE_SMACK;
 			}
 			ax->rcount -= 2;
@@ -263,9 +261,7 @@ static void ax_bump(struct mkiss *ax)
 				return;
 			}
 			if (ax->crcmode != CRC_MODE_FLEX && ax->crcauto) {
-				printk(KERN_INFO
-				       "mkiss: %s: Switching to crc-flexnet\n",
-				       ax->dev->name);
+				netdev_info(ax->dev, "Switching to crc-flexnet\n");
 				ax->crcmode = CRC_MODE_FLEX;
 			}
 			ax->rcount -= 2;
@@ -284,8 +280,7 @@ static void ax_bump(struct mkiss *ax)
 
 	skb = dev_alloc_skb(count);
 	if (!skb) {
-		printk(KERN_ERR "mkiss: %s: memory squeeze, dropping packet.\n",
-		       ax->dev->name);
+		netdev_err(ax->dev, "memory squeeze, dropping packet.\n");
 		ax->dev->stats.rx_dropped++;
 		spin_unlock_bh(&ax->buflock);
 		return;
@@ -376,9 +371,7 @@ static void ax_changedmtu(struct mkiss *ax)
 	rbuff = kmalloc(len + 4, GFP_ATOMIC);
 
 	if (xbuff == NULL || rbuff == NULL)  {
-		printk(KERN_ERR "mkiss: %s: unable to grow ax25 buffers, "
-		       "MTU change cancelled.\n",
-		       ax->dev->name);
+		netdev_err(ax->dev, "unable to grow ax25 buffers, MTU change cancelled.\n");
 		dev->mtu = ax->mtu;
 		kfree(xbuff);
 		kfree(rbuff);
@@ -433,7 +426,7 @@ static void ax_encaps(struct net_device *dev, unsigned char *icp, int len)
 		ax_changedmtu(ax);
 
 	if (len > ax->mtu) {		/* Sigh, shouldn't occur BUT ... */
-		printk(KERN_ERR "mkiss: %s: truncating oversized transmit packet!\n", ax->dev->name);
+		netdev_err(ax->dev, "truncating oversized transmit packet!\n");
 		dev->stats.tx_dropped++;
 		netif_start_queue(dev);
 		return;
@@ -469,8 +462,7 @@ static void ax_encaps(struct net_device *dev, unsigned char *icp, int len)
 				  cmd = 0;
 				}
 				ax->crcauto = (cmd ? 0 : 1);
-				printk(KERN_INFO "mkiss: %s: crc mode set to %d\n",
-				       ax->dev->name, cmd);
+				netdev_info(ax->dev, "crc mode set to %d\n", cmd);
 			}
 			spin_unlock_bh(&ax->buflock);
 			netif_start_queue(dev);
@@ -484,7 +476,7 @@ static void ax_encaps(struct net_device *dev, unsigned char *icp, int len)
 		switch (ax->crcmode) {
 		case CRC_MODE_SMACK_TEST:
 			ax->crcmode  = CRC_MODE_FLEX_TEST;
-			printk(KERN_INFO "mkiss: %s: Trying crc-smack\n", ax->dev->name);
+			netdev_info(ax->dev, "Trying crc-smack\n");
 			fallthrough;
 		case CRC_MODE_SMACK:
 			*p |= 0x80;
@@ -493,7 +485,7 @@ static void ax_encaps(struct net_device *dev, unsigned char *icp, int len)
 			break;
 		case CRC_MODE_FLEX_TEST:
 			ax->crcmode = CRC_MODE_NONE;
-			printk(KERN_INFO "mkiss: %s: Trying crc-flexnet\n", ax->dev->name);
+			netdev_info(ax->dev, "Trying crc-flexnet\n");
 			fallthrough;
 		case CRC_MODE_FLEX:
 			*p |= 0x20;
@@ -526,7 +518,7 @@ static netdev_tx_t ax_xmit(struct sk_buff *skb, struct net_device *dev)
 		return ax25_ip_xmit(skb);
 
 	if (!netif_running(dev))  {
-		printk(KERN_ERR "mkiss: %s: xmit call when iface is down\n", dev->name);
+		netdev_err(ax->dev, "xmit call when iface is down\n");
 		return NETDEV_TX_BUSY;
 	}
 
@@ -540,8 +532,8 @@ static netdev_tx_t ax_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 		}
 
-		printk(KERN_ERR "mkiss: %s: transmit timed out, %s?\n", dev->name,
-		       (tty_chars_in_buffer(ax->tty) || ax->xleft) ?
+		netdev_err(ax->dev, "transmit timed out, %s?\n",
+			   (tty_chars_in_buffer(ax->tty) || ax->xleft) ?
 		       "bad line quality" : "driver error");
 
 		ax->xleft = 0;
@@ -735,24 +727,20 @@ static int mkiss_open(struct tty_struct *tty)
 	switch (crc_force) {
 	case 3:
 		ax->crcmode  = CRC_MODE_SMACK;
-		printk(KERN_INFO "mkiss: %s: crc mode smack forced.\n",
-		       ax->dev->name);
+		netdev_info(ax->dev, "crc mode smack forced.\n");
 		break;
 	case 2:
 		ax->crcmode  = CRC_MODE_FLEX;
-		printk(KERN_INFO "mkiss: %s: crc mode flexnet forced.\n",
-		       ax->dev->name);
+		netdev_info(ax->dev, "crc mode flexnet forced.\n");
 		break;
 	case 1:
 		ax->crcmode  = CRC_MODE_NONE;
-		printk(KERN_INFO "mkiss: %s: crc mode disabled.\n",
-		       ax->dev->name);
+		netdev_info(ax->dev, "crc mode disabled.\n");
 		break;
 	case 0:
 	default:
 		crc_force = 0;
-		printk(KERN_INFO "mkiss: %s: crc mode is auto.\n",
-		       ax->dev->name);
+		netdev_info(ax->dev, "crc mode is auto.\n");
 		ax->crcmode  = CRC_MODE_SMACK_TEST;
 	}
 	ax->crcauto = (crc_force ? 0 : 1);
@@ -949,20 +937,15 @@ static struct tty_ldisc_ops ax_ldisc = {
 	.write_wakeup	= mkiss_write_wakeup
 };
 
-static const char banner[] __initconst = KERN_INFO \
-	"mkiss: AX.25 Multikiss, Hans Albas PE1AYX\n";
-static const char msg_regfail[] __initconst = KERN_ERR \
-	"mkiss: can't register line discipline (err = %d)\n";
-
 static int __init mkiss_init_driver(void)
 {
 	int status;
 
-	printk(banner);
+	pr_info("mkiss: AX.25 Multikiss, Hans Albas PE1AYX\n");
 
 	status = tty_register_ldisc(&ax_ldisc);
 	if (status != 0)
-		printk(msg_regfail, status);
+		pr_err("mkiss: can't register line discipline (err = %d)\n", status);
 
 	return status;
 }
-- 
2.53.0


