Return-Path: <netdev+bounces-224575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A56B864C4
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E441D1675BB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55531D37A;
	Thu, 18 Sep 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k4Hlso6c"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3B31D369
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217231; cv=none; b=Y2uOKGEzyAFHd9qCazLTbr/yPtYjuP2MPFQ1kAs2n564qKWVI9yDzUZ1h5+/N2GPteiawSUEJXsEoeibDzn0Nm5o+C6sPMplMYudQTZg4kdEyTwatlQ+YgyeJ1MPw85iVQcURhtfCvWDc/UQa8ItPvNrclHucfqZz6CHDZiYKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217231; c=relaxed/simple;
	bh=oz3FJEbVUdDjHMA6QB3nvnBf2rAsrNL8dlhJtLgsHys=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tijbB5kA2JyK8tJ8uEIGfrnWvIjzAu0CqxYjxExGlYKOthY6XT7wfRiDcK7mfFh6u2CrwmCDiKV+b83pkwJ0btduD85EZjWexaNr6X3IF5gTwOzLFo+c2MoXVENaBdrf+U6pLplP3v9rJ8j8zVLO6DLW8XSW5mIlLB/4gi7EcOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k4Hlso6c; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zbuJVTM9js4Elajaqc2pyIRZ28SonZIWs3wDqLohVN0=; b=k4Hlso6cCbe8fAB3mwed8bEd3h
	oaf2HxV8gz+TGW5aMg8o41R4hIj8xqsig17VLPupAkOV6rVteFth8URor9xu8bKKoZv0AU8wjs1Tt
	xP5AtvcfP1THa/8Cm94b4qyBFD94GhVF+Y/KhPmytmOFpFDVhk9CzfDaZKA+nQArmIrOI9xuhGcvx
	vls2oJJYlzrqyUO1ej6A9hEgYu9Jc6FYMaYPnbGmH0qV2sOXW1mKwINekBbrRaAIeQJl2eVCtRFcW
	43VmCyZt7GuaxnnMwV4Jn8M1p6tQ4FDFKWY6zlFemy/qTbTSXg6EjjBVdtrlC8MkgEWNRNMO8HNPC
	YpuioGqQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49256 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIcK-000000001e1-3G0v;
	Thu, 18 Sep 2025 18:40:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIcJ-00000006n0x-46U2;
	Thu, 18 Sep 2025 18:40:24 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 18/20] net: dsa: mv88e6xxx: switch rx
 timestamping to core
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIcJ-00000006n0x-46U2@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:40:23 +0100

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.h     |   7 --
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 154 +--------------------------
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |   4 -
 3 files changed, 2 insertions(+), 163 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 16de29c6cd43..0c41b5595dd3 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -225,16 +225,9 @@ enum {
 };
 
 struct mv88e6xxx_port_hwtstamp {
-	/* Port index */
-	int port_id;
-
 	/* Timestamping state */
 	unsigned long state;
 
-	/* Resources for receive timestamping */
-	struct sk_buff_head rx_queue;
-	struct sk_buff_head rx_queue2;
-
 	/* Current timestamp configuration */
 	struct kernel_hwtstamp_config tstamp_config;
 };
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 7422beba5496..fd4afb5e4d49 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -209,158 +209,17 @@ int mv88e6xxx_port_hwtstamp_get(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-/* Returns a pointer to the PTP header if the caller should time stamp,
- * or NULL if the caller should not.
- */
-static struct ptp_header *mv88e6xxx_should_tstamp(struct mv88e6xxx_chip *chip,
-						  int port, struct sk_buff *skb,
-						  unsigned int type)
-{
-	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
-	struct ptp_header *hdr;
-
-	if (!chip->info->ptp_support)
-		return NULL;
-
-	hdr = ptp_parse_header(skb, type);
-	if (!hdr)
-		return NULL;
-
-	if (!test_bit(MV88E6XXX_HWTSTAMP_ENABLED, &ps->state))
-		return NULL;
-
-	return hdr;
-}
-
-static int mv88e6xxx_ts_valid(u16 status)
-{
-	if (!(status & MV88E6XXX_PTP_TS_VALID))
-		return 0;
-	if (status & MV88E6XXX_PTP_TS_STATUS_MASK)
-		return 0;
-	return 1;
-}
-
-static int seq_match(struct sk_buff *skb, u16 ts_seqid)
-{
-	unsigned int type = SKB_PTP_TYPE(skb);
-	struct ptp_header *hdr;
-
-	hdr = ptp_parse_header(skb, type);
-
-	return ts_seqid == ntohs(hdr->sequence_id);
-}
-
-static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
-			       struct mv88e6xxx_port_hwtstamp *ps,
-			       struct sk_buff *skb, u16 reg,
-			       struct sk_buff_head *rxq)
-{
-	u16 buf[4] = { 0 }, status, seq_id;
-	struct skb_shared_hwtstamps *shwt;
-	struct sk_buff_head received;
-	u64 ns, timelo, timehi;
-	unsigned long flags;
-	int err;
-
-	/* The latched timestamp belongs to one of the received frames. */
-	__skb_queue_head_init(&received);
-	spin_lock_irqsave(&rxq->lock, flags);
-	skb_queue_splice_tail_init(rxq, &received);
-	spin_unlock_irqrestore(&rxq->lock, flags);
-
-	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_port_ptp_read(chip, ps->port_id,
-				      reg, buf, ARRAY_SIZE(buf));
-	mv88e6xxx_reg_unlock(chip);
-	if (err)
-		pr_err("failed to get the receive time stamp\n");
-
-	status = buf[0];
-	timelo = buf[1];
-	timehi = buf[2];
-	seq_id = buf[3];
-
-	if (status & MV88E6XXX_PTP_TS_VALID) {
-		mv88e6xxx_reg_lock(chip);
-		err = mv88e6xxx_port_ptp_write(chip, ps->port_id, reg, 0);
-		mv88e6xxx_reg_unlock(chip);
-		if (err)
-			pr_err("failed to clear the receive status\n");
-	}
-	/* Since the device can only handle one time stamp at a time,
-	 * we purge any extra frames from the queue.
-	 */
-	for ( ; skb; skb = __skb_dequeue(&received)) {
-		if (mv88e6xxx_ts_valid(status) && seq_match(skb, seq_id)) {
-			ns = timehi << 16 | timelo;
-
-			ns = marvell_tai_cyc2time(chip->tai, ns);
-			shwt = skb_hwtstamps(skb);
-			memset(shwt, 0, sizeof(*shwt));
-			shwt->hwtstamp = ns_to_ktime(ns);
-			status &= ~MV88E6XXX_PTP_TS_VALID;
-		}
-		netif_rx(skb);
-	}
-}
-
-static void mv88e6xxx_rxtstamp_work(struct mv88e6xxx_chip *chip,
-				    struct mv88e6xxx_port_hwtstamp *ps)
-{
-	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
-	struct sk_buff *skb;
-
-	skb = skb_dequeue(&ps->rx_queue);
-
-	if (skb)
-		mv88e6xxx_get_rxts(chip, ps, skb, ptp_ops->arr0_sts_reg,
-				   &ps->rx_queue);
-
-	skb = skb_dequeue(&ps->rx_queue2);
-	if (skb)
-		mv88e6xxx_get_rxts(chip, ps, skb, ptp_ops->arr1_sts_reg,
-				   &ps->rx_queue2);
-}
-
-static int is_pdelay_resp(const struct ptp_header *hdr)
-{
-	return (hdr->tsmt & 0xf) == 3;
-}
-
 bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 			     struct sk_buff *skb, unsigned int type)
 {
-	struct mv88e6xxx_port_hwtstamp *ps;
-	struct mv88e6xxx_chip *chip;
-	struct ptp_header *hdr;
-
-	chip = ds->priv;
-	ps = &chip->port_hwtstamp[port];
-
-	if (ps->tstamp_config.rx_filter != HWTSTAMP_FILTER_PTP_V2_EVENT)
-		return false;
-
-	hdr = mv88e6xxx_should_tstamp(chip, port, skb, type);
-	if (!hdr)
-		return false;
-
-	SKB_PTP_TYPE(skb) = type;
-
-	if (is_pdelay_resp(hdr))
-		skb_queue_tail(&ps->rx_queue2, skb);
-	else
-		skb_queue_tail(&ps->rx_queue, skb);
-
-	marvell_tai_schedule(chip->tai, 0);
+	struct mv88e6xxx_chip *chip = ds->priv;
 
-	return true;
+	return marvell_ts_rxtstamp(&chip->ptp_ts[port], skb, type);
 }
 
 long mv88e6xxx_hwtstamp_work(struct mv88e6xxx_chip *chip)
 {
 	struct dsa_switch *ds = chip->ds;
-	struct mv88e6xxx_port_hwtstamp *ps;
 	long ret, delay = -1;
 	int i;
 
@@ -368,9 +227,6 @@ long mv88e6xxx_hwtstamp_work(struct mv88e6xxx_chip *chip)
 		if (!dsa_is_user_port(ds, i))
 			continue;
 
-		ps = &chip->port_hwtstamp[i];
-		mv88e6xxx_rxtstamp_work(chip, ps);
-
 		ret = marvell_ts_aux_work(&chip->ptp_ts[i]);
 		if (ret >= 0 && (delay == -1 || delay > ret))
 			delay = ret;
@@ -446,12 +302,6 @@ int mv88e6352_hwtstamp_port_enable(struct mv88e6xxx_chip *chip, int port)
 static int mv88e6xxx_hwtstamp_port_setup(struct mv88e6xxx_chip *chip, int port)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
-	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
-
-	ps->port_id = port;
-
-	skb_queue_head_init(&ps->rx_queue);
-	skb_queue_head_init(&ps->rx_queue2);
 
 	if (ptp_ops->port_disable)
 		return ptp_ops->port_disable(chip, port);
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index f27fe0cb27ea..f6182658c971 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -101,10 +101,6 @@
 /* Offset 0x13: PTP Departure Sequence ID */
 #define MV88E6XXX_PORT_PTP_DEP_SEQID	0x13
 
-/* Status fields for arrival and depature timestamp status registers */
-#define MV88E6XXX_PTP_TS_STATUS_MASK		0x0006
-#define MV88E6XXX_PTP_TS_VALID			0x0001
-
 #ifdef CONFIG_NET_DSA_MV88E6XXX_PTP
 
 int mv88e6xxx_port_hwtstamp_set(struct dsa_switch *ds, int port,
-- 
2.47.3


