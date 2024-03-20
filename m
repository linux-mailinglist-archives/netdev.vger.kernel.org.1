Return-Path: <netdev+bounces-80782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92E8810D0
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6191F24843
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA33C485;
	Wed, 20 Mar 2024 11:21:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629A3C471
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933712; cv=none; b=YHOGoyBydJp2/i1NxhOhPUViz4WTiw9ubc/7Uy7z8rusH1XdHO2A/fmvBTwrPnROgIk0GeI13zCG01E+3L6bbDCCsgwpkScBe3XKcUois3c2XyWQ4gG6OFNzcJcTZVi5j8raKQYXFwpkFYt/Q5pjDsze3Vsnz2g+tHqi1yWn+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933712; c=relaxed/simple;
	bh=sH5QCp/CT76MJiPwxEwgetpBKYN8GHSUPg2m6mYsgWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwEgvpkw7LsaXc8YPUPxxJAkEdi/y7jkb4Aose+s6PUP1243q9HmXCeHlTvA+PAcSqZTxdryLv+Cm4vQiOHl1zdWQ8Ylf8OFJDja50eBruv1rUq1KVqYot9S6rphvwHp7yy/fWw3g0e5vXjmHi+acFu0zuKDBd5EKmv1PPIbuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rmu0y-0007nI-T1
	for netdev@vger.kernel.org; Wed, 20 Mar 2024 12:21:48 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rmu0y-007SJV-GJ
	for netdev@vger.kernel.org; Wed, 20 Mar 2024 12:21:48 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2E5742A824C
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 11:21:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7BC0D2A8240;
	Wed, 20 Mar 2024 11:21:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5a515acc;
	Wed, 20 Mar 2024 11:21:46 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Martin=20Joci=C4=87?= <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net] can: kvaser_pciefd: Add additional Xilinx interrupts
Date: Wed, 20 Mar 2024 11:50:26 +0100
Message-ID: <20240320112144.582741-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320112144.582741-1-mkl@pengutronix.de>
References: <20240320112144.582741-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Martin Jocić <martin.jocic@kvaser.com>

Since Xilinx-based adapters now support up to eight CAN channels, the
TX interrupt mask array must have eight elements.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Link: https://lore.kernel.org/all/2ab3c0585c3baba272ede0487182a423a420134b.camel@kvaser.com
Fixes: 9b221ba452aa ("can: kvaser_pciefd: Add support for Kvaser PCIe 8xCAN")
[mkl: replace Link by Fixes tag]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index f81b598147b3..7b5028b67cd5 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -370,8 +370,8 @@ static const struct kvaser_pciefd_irq_mask kvaser_pciefd_sf2_irq_mask = {
 
 static const struct kvaser_pciefd_irq_mask kvaser_pciefd_xilinx_irq_mask = {
 	.kcan_rx0 = BIT(4),
-	.kcan_tx = { BIT(16), BIT(17), BIT(18), BIT(19) },
-	.all = GENMASK(19, 16) | BIT(4),
+	.kcan_tx = { BIT(16), BIT(17), BIT(18), BIT(19), BIT(20), BIT(21), BIT(22), BIT(23) },
+	.all = GENMASK(23, 16) | BIT(4),
 };
 
 static const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops = {

base-commit: e54e09c05c00120cbe817bdb037088035be4bd79
-- 
2.43.0



