Return-Path: <netdev+bounces-83583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB0C8931F8
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFDE281707
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84A1448CE;
	Sun, 31 Mar 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FeEduH3y"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4422EB08
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711895060; cv=none; b=HxjalImC7qI1sb74E8GgayZhsw0UIzrhvJF6rT4VlGeBuoBYl3CQ3hiItGoTmTXvH3686v22oO/2+Iix6LQ15cXh0+uCKa5xog4GKS33fraavYCqTcI7FqYOjxaoWUH9jzd3jcaFa4mdK241IO0jGuxnd+W+N6tO5QE3v193LFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711895060; c=relaxed/simple;
	bh=NIMVcTtVhHbqBbSGKs4tcm1rlGj/qEgfgNzDsBHR5AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jLp8Nq0l32Wiwz0S6eMykZxc9k4igCTtKsd4iapMNckbCaAInL1aLIGQsHzBdZmn/4k2ueTIuhrJM1K/pcsQvYb/X4gkj+YziT1YEHeOxAkD3NWEK7sUpPhP1khDem761ww5QZf1fMghcvL9dB6QlKSfJQZ6bsY8KcaqWIzw3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FeEduH3y; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5047887F1E;
	Sun, 31 Mar 2024 16:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711895056;
	bh=bCdicDafxJzTPN6RIRxqiWS7Nl/e57ev0THPblaPhYA=;
	h=From:To:Cc:Subject:Date:From;
	b=FeEduH3y1YMpKYQpWwtSB7k6k6M+i/g6Ko32OuEYX7kiSLverE+9qtcLOUStXS2EU
	 W94n3fN32XaCKq7PX87lqUYrWJoTOEsugyD7Yc2jHxzmve8G7hjiqlSVFrvmPi/Bbq
	 9V9ekzIhi0M+UQf9vHdfdwX5s8ZCg90PLaeJVOlNZjIWk60V4mQYoGyeaMo9asKG6V
	 6Gc0iMFxDOna/8bmfV5k1SHXxs8+d4gYIxiNrVufraNaLPK/ns+elH83z/oydSS/++
	 SCMxG7vFFUW+8DmEuat3nqE6SChoOjQIrgfly94clQZJSbpqijwWfBVAfwdedAnC2u
	 iaA9ScVBNSN0g==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 1/2] net: ks8851: Inline ks8851_rx_skb()
Date: Sun, 31 Mar 2024 16:21:45 +0200
Message-ID: <20240331142353.93792-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Both ks8851_rx_skb_par() and ks8851_rx_skb_spi() call netif_rx(skb),
inline the netif_rx(skb) call directly into ks8851_common.c and drop
the .rx_skb callback and ks8851_rx_skb() wrapper. This removes one
indirect call from the driver, no functional change otherwise.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/micrel/ks8851.h        |  3 ---
 drivers/net/ethernet/micrel/ks8851_common.c | 12 +-----------
 drivers/net/ethernet/micrel/ks8851_par.c    | 11 -----------
 drivers/net/ethernet/micrel/ks8851_spi.c    | 11 -----------
 4 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/micrel/ks8851.h
index e5ec0a363aff8..31f75b4a67fd7 100644
--- a/drivers/net/ethernet/micrel/ks8851.h
+++ b/drivers/net/ethernet/micrel/ks8851.h
@@ -368,7 +368,6 @@ union ks8851_tx_hdr {
  * @rdfifo: FIFO read callback
  * @wrfifo: FIFO write callback
  * @start_xmit: start_xmit() implementation callback
- * @rx_skb: rx_skb() implementation callback
  * @flush_tx_work: flush_tx_work() implementation callback
  *
  * The @statelock is used to protect information in the structure which may
@@ -423,8 +422,6 @@ struct ks8851_net {
 					  struct sk_buff *txp, bool irq);
 	netdev_tx_t		(*start_xmit)(struct sk_buff *skb,
 					      struct net_device *dev);
-	void			(*rx_skb)(struct ks8851_net *ks,
-					  struct sk_buff *skb);
 	void			(*flush_tx_work)(struct ks8851_net *ks);
 };
 
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 0bf13b38b8f5b..896d43bb8883d 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -231,16 +231,6 @@ static void ks8851_dbg_dumpkkt(struct ks8851_net *ks, u8 *rxpkt)
 		   rxpkt[12], rxpkt[13], rxpkt[14], rxpkt[15]);
 }
 
-/**
- * ks8851_rx_skb - receive skbuff
- * @ks: The device state.
- * @skb: The skbuff
- */
-static void ks8851_rx_skb(struct ks8851_net *ks, struct sk_buff *skb)
-{
-	ks->rx_skb(ks, skb);
-}
-
 /**
  * ks8851_rx_pkts - receive packets from the host
  * @ks: The device information.
@@ -309,7 +299,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 					ks8851_dbg_dumpkkt(ks, rxpkt);
 
 				skb->protocol = eth_type_trans(skb, ks->netdev);
-				ks8851_rx_skb(ks, skb);
+				netif_rx(skb);
 
 				ks->netdev->stats.rx_packets++;
 				ks->netdev->stats.rx_bytes += rxlen;
diff --git a/drivers/net/ethernet/micrel/ks8851_par.c b/drivers/net/ethernet/micrel/ks8851_par.c
index 2a7f298542670..381b9cd285ebd 100644
--- a/drivers/net/ethernet/micrel/ks8851_par.c
+++ b/drivers/net/ethernet/micrel/ks8851_par.c
@@ -210,16 +210,6 @@ static void ks8851_wrfifo_par(struct ks8851_net *ks, struct sk_buff *txp,
 	iowrite16_rep(ksp->hw_addr, txp->data, len / 2);
 }
 
-/**
- * ks8851_rx_skb_par - receive skbuff
- * @ks: The device state.
- * @skb: The skbuff
- */
-static void ks8851_rx_skb_par(struct ks8851_net *ks, struct sk_buff *skb)
-{
-	netif_rx(skb);
-}
-
 static unsigned int ks8851_rdreg16_par_txqcr(struct ks8851_net *ks)
 {
 	return ks8851_rdreg16_par(ks, KS_TXQCR);
@@ -298,7 +288,6 @@ static int ks8851_probe_par(struct platform_device *pdev)
 	ks->rdfifo = ks8851_rdfifo_par;
 	ks->wrfifo = ks8851_wrfifo_par;
 	ks->start_xmit = ks8851_start_xmit_par;
-	ks->rx_skb = ks8851_rx_skb_par;
 
 #define STD_IRQ (IRQ_LCI |	/* Link Change */	\
 		 IRQ_RXI |	/* RX done */		\
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index 2f803377c9f9d..670c1de966db8 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -298,16 +298,6 @@ static unsigned int calc_txlen(unsigned int len)
 	return ALIGN(len + 4, 4);
 }
 
-/**
- * ks8851_rx_skb_spi - receive skbuff
- * @ks: The device state
- * @skb: The skbuff
- */
-static void ks8851_rx_skb_spi(struct ks8851_net *ks, struct sk_buff *skb)
-{
-	netif_rx(skb);
-}
-
 /**
  * ks8851_tx_work - process tx packet(s)
  * @work: The work strucutre what was scheduled.
@@ -435,7 +425,6 @@ static int ks8851_probe_spi(struct spi_device *spi)
 	ks->rdfifo = ks8851_rdfifo_spi;
 	ks->wrfifo = ks8851_wrfifo_spi;
 	ks->start_xmit = ks8851_start_xmit_spi;
-	ks->rx_skb = ks8851_rx_skb_spi;
 	ks->flush_tx_work = ks8851_flush_tx_work_spi;
 
 #define STD_IRQ (IRQ_LCI |	/* Link Change */	\
-- 
2.43.0


