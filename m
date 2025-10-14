Return-Path: <netdev+bounces-229306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 558ADBDA6BB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C48EA507B2F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8F6306486;
	Tue, 14 Oct 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jGkWiRip"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D786304BC8
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455566; cv=none; b=XFfXBBKImr3yVmJ6yqlMg+JdVui/aM5RXsja8ZpFWYHyDVMb8XUMDekvwf+jQcooTa0MPe+NCY8HvUCPSAMMtWjebHcgteCgX2diBusX/xfuEptK9V7CsblcmsvPiU19+pL+9t1UTTNowGIW4gHZiRJcuwLLgl9u9+1cF1I0V9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455566; c=relaxed/simple;
	bh=4Kc7dBSFaD6z25zl6rVBPh9V2LR/PdW5rOp1Ot6UiMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuU+NEJIZsqGxm/RXf7QoFnFE1MIrXuVIWHff7DR7JhRFrfmDEsv61fUsjv4zii6zTPc3cmy5vmHK/xLZs7ghT1ZSmyj2GE1Bwfau7YkACGukb9Zbh+6a8VuDyTCZcGRbwAvJU0d5pRw/Bn5PN2KgF8CzlwGQF4uBHAtstiF5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jGkWiRip; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 69E4F4E410B4;
	Tue, 14 Oct 2025 15:26:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3DBE9606EC;
	Tue, 14 Oct 2025 15:26:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF1C2102F22B5;
	Tue, 14 Oct 2025 17:25:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455561; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JRB1v2jUJr+q7iCHIqulhDNoJ2z36CVmrWMSFTiGPyA=;
	b=jGkWiRip0O1XiIyEw/7hEB/rCycWRWjJudpny5jmMa8sRMVIwLZGvqZEX4C5I3MVEcI7gn
	aiEZxmsI1f3oUMS8XpAqpGXcndBCQEWeTdfgkX0DtOCkHoa60ngfY9CvDyOApNNeYj1+Bp
	fB/G1YwHLGzZO7/Gkc5Qtz+nlCkBs3q01FUtqS387A1XZdb8pKKqZ/PloTx3LPixmN38fv
	iY3UaMOMtQceR8UzFlIsXGQ4IhXxPH3jxIwaRT73yMEITPnKqGp43fExZIMVv1N0fH+x82
	qeia0bz4CtlN5Ohat3a1bmHcCP4rVvwLcwnF7oHisKA1pPU3wnCEQPW0Nm7rNQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:12 +0200
Subject: [PATCH net-next 11/15] net: macb: replace min() with umin() calls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-11-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Whenever min(a, b) is used with a and b unsigned variables or literals,
`make W=2` complains. Change four min() calls into umin().

stderr extract (GCC 11.2.0, MIPS Codescape):

./include/linux/minmax.h:68:57: warning: comparison is always true due
                          to limited range of data type [-Wtype-limits]
   68 | #define __is_nonneg(ux) statically_true((long long)(ux) >= 0)
      |                                                         ^~
drivers/net/ethernet/cadence/macb_main.c:2299:26: note: in expansion of
                                                            macro ‘min’
 2299 |              hdrlen = min(skb_headlen(skb), bp->max_tx_length);
      |                       ^~~

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 98e28d51a6e12c24ef27c939363eb43c0aec1951..6c6bc6aa23c718772b95b398e807f193a38e141a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2035,7 +2035,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 		count++;
 		tx_head++;
 
-		size = min(len, bp->max_tx_length);
+		size = umin(len, bp->max_tx_length);
 	}
 
 	/* Then, map paged data from fragments */
@@ -2045,7 +2045,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 		len = skb_frag_size(frag);
 		offset = 0;
 		while (len) {
-			size = min(len, bp->max_tx_length);
+			size = umin(len, bp->max_tx_length);
 			entry = macb_tx_ring_wrap(bp, tx_head);
 			tx_skb = &queue->tx_skb[entry];
 
@@ -2301,7 +2301,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 		}
 	} else
-		hdrlen = min(skb_headlen(skb), bp->max_tx_length);
+		hdrlen = umin(skb_headlen(skb), bp->max_tx_length);
 
 #if defined(DEBUG) && defined(VERBOSE_DEBUG)
 	netdev_vdbg(bp->dev,
@@ -4573,8 +4573,8 @@ static int macb_init(struct platform_device *pdev)
 	 * each 4-tuple define requires 1 T2 screener reg + 3 compare regs
 	 */
 	reg = gem_readl(bp, DCFG8);
-	bp->max_tuples = min((GEM_BFEXT(SCR2CMP, reg) / 3),
-			GEM_BFEXT(T2SCR, reg));
+	bp->max_tuples = umin((GEM_BFEXT(SCR2CMP, reg) / 3),
+			      GEM_BFEXT(T2SCR, reg));
 	INIT_LIST_HEAD(&bp->rx_fs_list.list);
 	if (bp->max_tuples > 0) {
 		/* also needs one ethtype match to check IPv4 */

-- 
2.51.0


