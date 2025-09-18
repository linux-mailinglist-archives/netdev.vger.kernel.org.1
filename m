Return-Path: <netdev+bounces-224574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC6FB864B2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511197BED56
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFBD31A7EB;
	Thu, 18 Sep 2025 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NQXsl5hE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3C1E3DE5
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217228; cv=none; b=F84b0ipSsPkxP5nlBZiFF0Gknfpc4ya0H35uLwJ12yunAIS2vEIBTjPcJzzymqg/uAQnFxZyVQ4ntzseyjdQ803/lP2LVERWMDCIYVK7PgnEJBo84Wge3wNmh3EjIBPvTVCy8dSx1DgT63Ou09SClFUMeYCVlkBeQntPvF/Mqrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217228; c=relaxed/simple;
	bh=g1rjsURth4mH797HsDw/60wFsc0edVLO15htk/D+9PI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=a4xuH1KX8a6mx2KapNwTwQkAh7QGb78WnJ3+LzDWL3Y/o128T9+srthTSxpgC4m0J1ftbvP0Xqm9/FnMua6HRXlk7V2lKpiNTVLn4EakyYXLpvvVS3gKh3YNTBeDM+0pBYF1W2eNo4bIJjpsPE5o9fZI8IsK7SCuwGELt8JUh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NQXsl5hE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YOcFj4wkzfzyPVA6ZZYSVGVtAHI3KQAK1BmGqug8l2k=; b=NQXsl5hEgoovAi0rXGlCcw0wWB
	xf50wXMyd++7i1TN3hWssYNdnk8nibuGTf0aaUbRo7JhmymgHC3StJOh+YnVuNQGNOIVqDBOqZKKl
	uuadREY9NAB5+ZRs6WwPGJkbxQOtE24ylYw3hrsio/aj5n0Y2eU37pzR87H2kd4iG036tMYHaSZQx
	Ho05XL670McehV3I59CIghqIe4wUXVGrlPavQHAe1IWuiW5+3NZ93DULH+2E3Q+3U4F8KRWLUfFIK
	0Opla/m+COBJq3qzKmc7QtSPQpIZf+IzAj7Gm2EjWiQlHv+8s3VRYVolm9VITF6RGpRyDcPgAdLEl
	QPB0p3fA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49254 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIcF-000000001do-2TNM;
	Thu, 18 Sep 2025 18:40:19 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIcE-00000006n0r-3cMV;
	Thu, 18 Sep 2025 18:40:18 +0100
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
Subject: [PATCH RFC net-next 17/20] net: dsa: mv88e6xxx: switch tx
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
Message-Id: <E1uzIcE-00000006n0r-3cMV@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:40:18 +0100

---
 drivers/net/dsa/mv88e6xxx/chip.h     |   6 --
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 116 ++-------------------------
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |   3 -
 3 files changed, 7 insertions(+), 118 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index a297b8867225..16de29c6cd43 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -222,7 +222,6 @@ struct mv88e6xxx_irq {
 /* state flags for mv88e6xxx_port_hwtstamp::state */
 enum {
 	MV88E6XXX_HWTSTAMP_ENABLED,
-	MV88E6XXX_HWTSTAMP_TX_IN_PROGRESS,
 };
 
 struct mv88e6xxx_port_hwtstamp {
@@ -236,11 +235,6 @@ struct mv88e6xxx_port_hwtstamp {
 	struct sk_buff_head rx_queue;
 	struct sk_buff_head rx_queue2;
 
-	/* Resources for transmit timestamping */
-	unsigned long tx_tstamp_start;
-	struct sk_buff *tx_skb;
-	u16 tx_seq_id;
-
 	/* Current timestamp configuration */
 	struct kernel_hwtstamp_config tstamp_config;
 };
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 3e6a0481fc19..7422beba5496 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -357,90 +357,6 @@ bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 	return true;
 }
 
-static int mv88e6xxx_txtstamp_work(struct mv88e6xxx_chip *chip,
-				   struct mv88e6xxx_port_hwtstamp *ps)
-{
-	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
-	struct skb_shared_hwtstamps shhwtstamps;
-	u16 departure_block[4], status;
-	struct sk_buff *tmp_skb;
-	u32 time_raw;
-	int err;
-	u64 ns;
-
-	if (!ps->tx_skb)
-		return 0;
-
-	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_port_ptp_read(chip, ps->port_id,
-				      ptp_ops->dep_sts_reg,
-				      departure_block,
-				      ARRAY_SIZE(departure_block));
-	mv88e6xxx_reg_unlock(chip);
-
-	if (err)
-		goto free_and_clear_skb;
-
-	if (!(departure_block[0] & MV88E6XXX_PTP_TS_VALID)) {
-		if (time_is_before_jiffies(ps->tx_tstamp_start +
-					   TX_TSTAMP_TIMEOUT)) {
-			dev_warn(chip->dev, "p%d: clearing tx timestamp hang\n",
-				 ps->port_id);
-			goto free_and_clear_skb;
-		}
-		/* The timestamp should be available quickly, while getting it
-		 * is high priority and time bounded to only 10ms. A poll is
-		 * warranted so restart the work.
-		 */
-		return 1;
-	}
-
-	/* We have the timestamp; go ahead and clear valid now */
-	mv88e6xxx_reg_lock(chip);
-	mv88e6xxx_port_ptp_write(chip, ps->port_id, ptp_ops->dep_sts_reg, 0);
-	mv88e6xxx_reg_unlock(chip);
-
-	status = departure_block[0] & MV88E6XXX_PTP_TS_STATUS_MASK;
-	if (status != MV88E6XXX_PTP_TS_STATUS_NORMAL) {
-		dev_warn(chip->dev, "p%d: tx timestamp overrun\n", ps->port_id);
-		goto free_and_clear_skb;
-	}
-
-	if (departure_block[3] != ps->tx_seq_id) {
-		dev_warn(chip->dev, "p%d: unexpected seq. id\n", ps->port_id);
-		goto free_and_clear_skb;
-	}
-
-	memset(&shhwtstamps, 0, sizeof(shhwtstamps));
-	time_raw = ((u32)departure_block[2] << 16) | departure_block[1];
-	ns = marvell_tai_cyc2time(chip->tai, time_raw);
-	shhwtstamps.hwtstamp = ns_to_ktime(ns);
-
-	dev_dbg(chip->dev,
-		"p%d: txtstamp %llx status 0x%04x skb ID 0x%04x hw ID 0x%04x\n",
-		ps->port_id, ktime_to_ns(shhwtstamps.hwtstamp),
-		departure_block[0], ps->tx_seq_id, departure_block[3]);
-
-	/* skb_complete_tx_timestamp() will free up the client to make
-	 * another timestamp-able transmit. We have to be ready for it
-	 * -- by clearing the ps->tx_skb "flag" -- beforehand.
-	 */
-
-	tmp_skb = ps->tx_skb;
-	ps->tx_skb = NULL;
-	clear_bit_unlock(MV88E6XXX_HWTSTAMP_TX_IN_PROGRESS, &ps->state);
-	skb_complete_tx_timestamp(tmp_skb, &shhwtstamps);
-
-	return 0;
-
-free_and_clear_skb:
-	dev_kfree_skb_any(ps->tx_skb);
-	ps->tx_skb = NULL;
-	clear_bit_unlock(MV88E6XXX_HWTSTAMP_TX_IN_PROGRESS, &ps->state);
-
-	return 0;
-}
-
 long mv88e6xxx_hwtstamp_work(struct mv88e6xxx_chip *chip)
 {
 	struct dsa_switch *ds = chip->ds;
@@ -453,16 +369,7 @@ long mv88e6xxx_hwtstamp_work(struct mv88e6xxx_chip *chip)
 			continue;
 
 		ps = &chip->port_hwtstamp[i];
-		if (test_bit(MV88E6XXX_HWTSTAMP_TX_IN_PROGRESS, &ps->state) &&
-		    mv88e6xxx_txtstamp_work(chip, ps))
-			delay = 1;
-
 		mv88e6xxx_rxtstamp_work(chip, ps);
-	}
-
-	for (i = 0; i < ds->num_ports; i++) {
-		if (!dsa_is_user_port(ds, i))
-			continue;
 
 		ret = marvell_ts_aux_work(&chip->ptp_ts[i]);
 		if (ret >= 0 && (delay == -1 || delay > ret))
@@ -476,34 +383,25 @@ void mv88e6xxx_port_txtstamp(struct dsa_switch *ds, int port,
 			     struct sk_buff *skb)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
-	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
-	struct ptp_header *hdr;
 	struct sk_buff *clone;
 	unsigned int type;
 
-	type = ptp_classify_raw(skb);
-	if (type == PTP_CLASS_NONE)
+	/* The DSA core will have checked the tx_flags of the skb, so we only
+	 * see packets that have had hardware timestamping requested here.
+	 */
+	if (!chip->info->ptp_support)
 		return;
 
-	hdr = mv88e6xxx_should_tstamp(chip, port, skb, type);
-	if (!hdr)
+	type = ptp_classify_raw(skb);
+	if (type == PTP_CLASS_NONE)
 		return;
 
 	clone = skb_clone_sk(skb);
 	if (!clone)
 		return;
 
-	if (test_and_set_bit_lock(MV88E6XXX_HWTSTAMP_TX_IN_PROGRESS,
-				  &ps->state)) {
+	if (!marvell_ts_txtstamp(&chip->ptp_ts[port], clone, type))
 		kfree_skb(clone);
-		return;
-	}
-
-	ps->tx_skb = clone;
-	ps->tx_tstamp_start = jiffies;
-	ps->tx_seq_id = be16_to_cpu(hdr->sequence_id);
-
-	marvell_tai_schedule(chip->tai, 0);
 }
 
 int mv88e6165_global_disable(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index f82383764653..f27fe0cb27ea 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -103,9 +103,6 @@
 
 /* Status fields for arrival and depature timestamp status registers */
 #define MV88E6XXX_PTP_TS_STATUS_MASK		0x0006
-#define MV88E6XXX_PTP_TS_STATUS_NORMAL		0x0000
-#define MV88E6XXX_PTP_TS_STATUS_OVERWITTEN	0x0002
-#define MV88E6XXX_PTP_TS_STATUS_DISCARDED	0x0004
 #define MV88E6XXX_PTP_TS_VALID			0x0001
 
 #ifdef CONFIG_NET_DSA_MV88E6XXX_PTP
-- 
2.47.3


