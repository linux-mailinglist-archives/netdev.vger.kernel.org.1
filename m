Return-Path: <netdev+bounces-304367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WqEKBddZR2qiWgAAu9opvQ
	(envelope-from <netdev+bounces-304367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:42:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0CF6FF27C
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:42:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=SHITKHDu;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304367-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304367-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 775AA300753D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2205E3845D9;
	Fri,  3 Jul 2026 06:42:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17237DEA4;
	Fri,  3 Jul 2026 06:42:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060945; cv=none; b=OFY+XLmtpVGGrEglU31Fr3bRe1ppBGBtoHh7ltlJdaCo1blELLVbcfsi4e52J3hbQbBBxBXb8PQcjtjMf5l6Z3j0M/oUugitVQq9yf+hYmR2qejgbK49j3le7uxYZvaKYzqfaY/Rhn+MOo8muVmwHMWY/zc9qpKeExxo98ikUgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060945; c=relaxed/simple;
	bh=yqyUQkVEkUXCbHFZIAKgdiaARCwoJcRB6O9eG0PCG5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIi6NQNUxR9551utkihguQT6KTojpYycWQQWgb575Lhu8+Rp7VMW/TLB8+axfrhgI491g376lPGl4CiJT/K22rmSLNubvQKGwUtP8AJrvhKwhYwA3SDahWbYMD153RstFwbr1X2RuA4Ck4i9am2+KAjrJEGnRrTLfCeChRx9YoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=SHITKHDu; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id ACD3960D44;
	Fri,  3 Jul 2026 02:42:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783060938; bh=WkTdTgDIxMxX0wIXRMFAOqBPNT0QOgcQbLaOk2TSZWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SHITKHDu6dG75FzPSUffQItp1rFARAWzsZD79dgpNlctMXGy+X/u0icnmc5G5IaP5
	 dUOlBNv/ac8e+MyYaIVCq251KEUvGdmq/c5pOaf04n+c/Yldzi8pkK+bqFDgK8VXfD
	 4ZDIjTI7MEyFm2K1lAGtVuOZwgDpmSc+QcBjj2eIhPzvrtd0eBZwebIWk9A82YN6go
	 M0HAlxt9Ym6h/BJwMaU5dbjM78lbbLQ0O2ClWCWzKhw9lc8pOdIPLGO7qhCkEacw79
	 ramoc+qedLxmGozVkKCUEJ8PHrgX0toC8nnJMpxTsoQhHNWgdxCz5noNi9PqNFbIZX
	 4c2QmG2ZTsRGA==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 16:41:59 +1000
Subject: [PATCH net-next 2/2] net: dsa: mv88e6xxx: embedded PTP timestamp
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mv88e6xxx-ptp-fixes-v1-2-0138581889a9@padl.com>
References: <20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com>
In-Reply-To: <20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.deA>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783060925; l=9937;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=yqyUQkVEkUXCbHFZIAKgdiaARCwoJcRB6O9eG0PCG5E=;
 b=0CtGgPhSt/IcmvL9DmJJxYP3rVDZsm4r8oEShKGMRiLvRVPb2qRoCofFOMEwK0QwZw5tAaK2k
 yKT0FciHRKvCXJOv9RgDdKPwEFR6GMR30dzwgBxRoaDUuBfEetP6pAy
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304367-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:richardcochran@gmail.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.deA,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.deA,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D0CF6FF27C

mv88e6xxx switches can support embedding PTP timestamps directly
in the frame, either as a trailer or at a configurable offset
(typically the reserved bytes in the PTP header).

Add support for this on the 88E6341 and 88E6352 switches, being
those on which I was able to verify this. Other switch chips may
also work. The arrival timestamp offsets are relative to the PTP
common header and will work for both L2 and L3 PTP packets; the
respective headers are skipped by the number of bytes set in the
ETJump and IPJump registers, which are initialized to sensible
defaults and are VLAN tag-aware.

(Note: the 6352 datasheet incorrectly states that ETJump and
IPJump are initialized to zero. They are initialized to 12 and
2 respectively; this is corrected in the 6341 data sheet.)

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c     |   3 +
 drivers/net/dsa/mv88e6xxx/chip.h     |   8 +++
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 122 +++++++++++++++++++++++++++++++----
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |  14 ++++
 4 files changed, 135 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513d..c3277c1f3d785 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -28,6 +28,7 @@
 #include <linux/of_mdio.h>
 #include <linux/platform_data/mv88e6xxx.h>
 #include <linux/property.h>
+#include <linux/ptp_classify.h>
 #include <linux/netdevice.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phylink.h>
@@ -6370,6 +6371,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.ops = &mv88e6341_ops,
+		.arr_ts_mode = offsetof(struct ptp_header, reserved2),
 	},
 
 	[MV88E6350] = {
@@ -6447,6 +6449,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.ops = &mv88e6352_ops,
+		.arr_ts_mode = offsetof(struct ptp_header, reserved2),
 	},
 	[MV88E6361] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6361,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index e966e7c4cc5de..b6a90eba81c43 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -180,6 +180,14 @@ struct mv88e6xxx_info {
 	 * port 0, 1 means internal PHYs range starts at port 1, etc
 	 */
 	unsigned int internal_phys_offset;
+
+	/* Arrival Time Stamp Mode (ArrTSMode); see the ArrTSMode encoding in
+	 * hwtstamp.h. Zero (the default) leaves arrival time stamps in the
+	 * switch registers; non-zero embeds them in the frame, either appended
+	 * as a trailer or overwritten at that byte offset past the start of the
+	 * PTP common header.
+	 */
+	unsigned int arr_ts_mode;
 };
 
 struct mv88e6xxx_atu_entry {
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 57ff77496864f..341a9e33021d7 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -8,6 +8,8 @@
  *      Erik Hons <erik.hons@ni.com>
  *      Brandon Streiff <brandon.streiff@ni.com>
  *      Dane Wagner <dane.wagner@ni.com>
+ *
+ * Copyright (c) 2025 PADL Software Pty Ltd
  */
 
 #include "chip.h"
@@ -15,6 +17,7 @@
 #include "hwtstamp.h"
 #include "ptp.h"
 #include <linux/ptp_classify.h>
+#include <linux/unaligned.h>
 
 #define SKB_PTP_TYPE(__skb) (*(unsigned int *)((__skb)->cb))
 
@@ -245,6 +248,63 @@ static int seq_match(struct sk_buff *skb, u16 ts_seqid)
 	return ts_seqid == ntohs(hdr->sequence_id);
 }
 
+static bool parse_embedded_ts(unsigned int arr_ts_mode,
+			      struct sk_buff *skb, u64 *ns)
+{
+	struct ptp_header *hdr;
+
+	*ns = 0;
+
+	/* APPEND means the switch appended the time stamp as a 4-byte trailer
+	 * (not all switches support this). Any other non-zero value is the byte
+	 * offset past the start of the PTP common header at which the switch
+	 * overwrote the time stamp in place (e.g. the reserved header bytes).
+	 */
+	if (arr_ts_mode == MV88E6XXX_PTP_ARR_TS_MODE_APPEND && skb->len >= 4) {
+		*ns = (u64)get_unaligned_be32(&skb->data[skb->len - 4]);
+		skb_trim(skb, skb->len - 4);
+	} else if (arr_ts_mode + 4 <= sizeof(*hdr)) {
+		hdr = ptp_parse_header(skb, SKB_PTP_TYPE(skb));
+		if (!hdr)
+			return false;
+
+		*ns = (u64)get_unaligned_be32((u8 *)hdr + arr_ts_mode);
+		memset((u8 *)hdr + arr_ts_mode, 0, 4);
+	} else {
+		return false;
+	}
+
+	return true;
+}
+
+static void mv88e6xxx_get_rxts_embedded(struct mv88e6xxx_chip *chip,
+					struct mv88e6xxx_port_hwtstamp *ps,
+					struct sk_buff *skb)
+{
+	struct sk_buff_head *rxq = &ps->rx_queue;
+	struct skb_shared_hwtstamps *shwt;
+	struct sk_buff_head received;
+	unsigned long flags;
+	u64 ns;
+
+	__skb_queue_head_init(&received);
+	spin_lock_irqsave(&rxq->lock, flags);
+	skb_queue_splice_tail_init(rxq, &received);
+	spin_unlock_irqrestore(&rxq->lock, flags);
+
+	for ( ; skb; skb = __skb_dequeue(&received)) {
+		if (parse_embedded_ts(chip->info->arr_ts_mode, skb, &ns)) {
+			mv88e6xxx_reg_lock(chip);
+			ns = timecounter_cyc2time(&chip->tstamp_tc, ns);
+			mv88e6xxx_reg_unlock(chip);
+			shwt = skb_hwtstamps(skb);
+			memset(shwt, 0, sizeof(*shwt));
+			shwt->hwtstamp = ns_to_ktime(ns);
+		}
+		netif_rx(skb);
+	}
+}
+
 static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
 			       struct mv88e6xxx_port_hwtstamp *ps,
 			       struct sk_buff *skb, u16 reg,
@@ -307,8 +367,21 @@ static void mv88e6xxx_rxtstamp_work(struct mv88e6xxx_chip *chip,
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
 	struct sk_buff *skb;
 
-	skb = skb_dequeue(&ps->rx_queue);
+	if (chip->info->arr_ts_mode) {
+		/* If arr_ts_mode is set, the timestamps are embedded in the
+		 * frames so a register read is not required. We still need a
+		 * work queue rather than processing inline because
+		 * timecounter_cyc2time() takes the global mutex and this
+		 * cannot be called from mv88e6xxx_port_rxtstamp().
+		 */
+		skb = skb_dequeue(&ps->rx_queue);
+		if (skb)
+			mv88e6xxx_get_rxts_embedded(chip, ps, skb);
 
+		return;
+	}
+
+	skb = skb_dequeue(&ps->rx_queue);
 	if (skb)
 		mv88e6xxx_get_rxts(chip, ps, skb, ptp_ops->arr0_sts_reg,
 				   &ps->rx_queue);
@@ -350,7 +423,7 @@ bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 
 	SKB_PTP_TYPE(skb) = type;
 
-	if (is_pdelay_msg(hdr))
+	if (!chip->info->arr_ts_mode && is_pdelay_msg(hdr))
 		skb_queue_tail(&ps->rx_queue2, skb);
 	else
 		skb_queue_tail(&ps->rx_queue, skb);
@@ -530,14 +603,37 @@ int mv88e6165_global_enable(struct mv88e6xxx_chip *chip)
 
 int mv88e6352_hwtstamp_port_disable(struct mv88e6xxx_chip *chip, int port)
 {
-	return mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG0,
-					MV88E6XXX_PORT_PTP_CFG0_DISABLE_PTP);
+	int err;
+
+	err = mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG0,
+				       MV88E6XXX_PORT_PTP_CFG0_DISABLE_PTP);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG2, 0);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 int mv88e6352_hwtstamp_port_enable(struct mv88e6xxx_chip *chip, int port)
 {
-	return mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG0,
-					MV88E6XXX_PORT_PTP_CFG0_DISABLE_TSPEC_MATCH);
+	int err;
+
+	if (chip->info->arr_ts_mode) {
+		err = mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG2,
+					       chip->info->arr_ts_mode << 8);
+		if (err)
+			return err;
+	}
+
+	err = mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG0,
+				       MV88E6XXX_PORT_PTP_CFG0_DISABLE_TSPEC_MATCH);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static int mv88e6xxx_hwtstamp_port_setup(struct mv88e6xxx_chip *chip, int port)
@@ -591,12 +687,14 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	/* Use ARRIVAL1 for peer delay messages. */
-	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_TS_ARRIVAL_PTR,
-				  MV88E6XXX_PTP_MSGTYPE_PDLAY_REQ |
-				  MV88E6XXX_PTP_MSGTYPE_PDLAY_RES);
-	if (err)
-		return err;
+	if (!chip->info->arr_ts_mode) {
+		/* Use ARRIVAL1 for peer delay messages. */
+		err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_TS_ARRIVAL_PTR,
+					  MV88E6XXX_PTP_MSGTYPE_PDLAY_REQ |
+					  MV88E6XXX_PTP_MSGTYPE_PDLAY_RES);
+		if (err)
+			return err;
+	}
 
 	/* 88E6341 devices default to timestamping at the PHY, but this has
 	 * a hardware issue that results in unreliable timestamps. Force
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index c359821d5a6ea..c25f53923e768 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -68,6 +68,20 @@
 #define MV88E6XXX_PORT_PTP_CFG2_DEP_IRQ_EN		0x0002
 #define MV88E6XXX_PORT_PTP_CFG2_ARR_IRQ_EN		0x0001
 
+/* Arrival Time Stamp Mode (ArrTSMode), CFG2 bits [15:8]: configures how the
+ * switch embeds the arrival time stamp (PTPArr0Time) into enabled PTP event
+ * frames.
+ *   0x00        frame modification disabled (time stamp read from registers)
+ *   0x01        append the 4-byte time stamp at the end of the frame,
+ *               growing the frame by four bytes
+ *   0x04..0xEF  overwrite the 4-byte time stamp in place, that many bytes past
+ *               the start of the PTP common header, without growing the frame
+ *               (offsetof(struct ptp_header, reserved2) targets the reserved
+ *               bytes of the header)
+ *   others      reserved
+ */
+#define MV88E6XXX_PTP_ARR_TS_MODE_APPEND		0x01
+
 /* Offset 0x03: PTP LED Configuration */
 #define MV88E6XXX_PORT_PTP_LED_CFG	0x03
 

-- 
2.43.0


