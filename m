Return-Path: <netdev+bounces-229553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4BCBDE015
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E231924009
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10633218A0;
	Wed, 15 Oct 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g/kJj2pl"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3732143E
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524085; cv=none; b=VNZdXAitj4zPvawbrHv0m+AVArcp55g+iv0EqIpQVCtISyJ5Z7k1evPDz3BqYxdy2FpDzIzs3FIFeBD1pbG76uRYQK0jL+mKNEFK0FFqI+QYlJskYGJ/LEtNEoz324B4sbPz1Xtv6K06yH/GnuSw2pmqj3Y9m/hPZtDJ+eqLMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524085; c=relaxed/simple;
	bh=5nQAw5GQ6ugNur5M+TWWUhkIoaRb6FPIJIkJdJA9X48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7n0zOlUS/uE99HQvcJ54MvRslYNI6klFwqIF2SalNGl/KEj+3PH9eeAip2EqIC1sUHlYAqwRWfyJ/RYJwnt8VJzfhLcJk5K7pIQiyCN3VMNf6x8aNOspzjeGxUm0IAfNp6+Q5YOK/Qs8eIAs+tUU6iuU80E0yQUag8gv/izWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g/kJj2pl; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 74F084E410CB;
	Wed, 15 Oct 2025 10:27:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B668606F9;
	Wed, 15 Oct 2025 10:27:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5353E102F22CB;
	Wed, 15 Oct 2025 12:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760524075; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=DFHqEMv9Ms4KjKDEGNbMoEMnbx63tPMi8GTPSWp0mEA=;
	b=g/kJj2pldVwGsy3HTNK+CfxIaQftqhqjjPw9zXYU7nMDWyzmW9QuV9lGgRhbQO745GWzzz
	pWddzTodIjPOw5dtDadZu863Ejlyvx/sfeVsxSZkRreC3TwJEe7Lo92aV0zAKzp7ub5oNl
	70slry/Hx0VxdpsfVFbvBcQvx2RXvZSCy32iS4Qa39W+8v3lWln52rDqeAK8/gG29onnZf
	+Ddqcj65+/QEr39etjg54TqlsftV88y14o+F4j9HRfuMpW5JDCPskaTNN8QyQ7NkkXIAYc
	2S+hgyfpWSWbz7W5wWrndlltWfjWVRehPYBuDq3714Yn6xbWuuyC86RZonrpXA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: stmmac: Allow supporting coarse adjustment mode
Date: Wed, 15 Oct 2025 12:27:22 +0200
Message-ID: <20251015102725.1297985-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The DWMAC1000 supports 2 timestamping configurations to configure how
frequency adjustments are made to the ptp_clock, as well as the reported
timestamp values.

There was a previous attempt at upstreaming support for configuring this
mode by Olivier Dautricourt and Julien Beraud a few years back [1]

In a nutshell, the timestamping can be either set in fine mode or in
coarse mode.

In fine mode, which is the default, we use the overflow of an accumulator to
trigger frequency adjustments, but by doing so we lose precision on the
timetamps that are produced by the timestamping unit. The main drawback
is that the sub-second increment value, used to generate timestamps, can't be
set to lower than (2 / ptp_clock_freq).

The "fine" qualification comes from the frequent frequency adjustments we are
able to do, which is perfect for a PTP follower usecase.

In Coarse mode, we don't do frequency adjustments based on an
accumulator overflow. We can therefore have very fine subsecond
increment values, allowing for better timestamping precision. However
this mode works best when the ptp clock frequency is adjusted based on
an external signal, such as a PPS input produced by a GPS clock. This
mode is therefore perfect for a Grand-master usecase.

We therefore attempt to map these 2 modes with the newly introduced
hwtimestamp qualifiers (precise and approx).

Precise mode is mapped to stmmac fine mode, and is the expected default,
suitable for all cases and perfect for follower mode

Approx mode is mapped to coarse mode, suitable for Grand-master.

Changing between these modes is done using ethtool :

 - Fine mode

   ethtool --set-hwtimestamp-cfg eth0 index 0 qualifier precise

 - Coarse mode

   ethtool --set-hwtimestamp-cfg eth0 index 0 qualifier approx

[1] : https://lore.kernel.org/netdev/20200514102808.31163-1-olivier.dautricourt@orolia.com/

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 39fa1ec92f82..0594acbc0ead 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1192,6 +1192,8 @@ static void stmmac_get_mm_stats(struct net_device *ndev,
 static const struct ethtool_ops stmmac_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
+	.supported_hwtstamp_qualifiers = BIT(HWTSTAMP_PROVIDER_QUALIFIER_PRECISE) |
+					 BIT(HWTSTAMP_PROVIDER_QUALIFIER_APPROX),
 	.get_drvinfo = stmmac_ethtool_getdrvinfo,
 	.get_msglevel = stmmac_ethtool_getmsglevel,
 	.set_msglevel = stmmac_ethtool_setmsglevel,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3f79b61d64b9..4859aba10aa3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -675,6 +675,14 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 
 	priv->systime_flags = STMMAC_HWTS_ACTIVE;
 
+	/* This is the "coarse" mode, where we get lower frequency adjustment
+	 * precision, but better timestamping precision. This is useful when
+	 * acting as a grand-master, as we usually sync with a hgh-previcision
+	 * clock through PPS input. We default to "fine" mode.
+	 */
+	if (config->qualifier == HWTSTAMP_PROVIDER_QUALIFIER_APPROX)
+		priv->systime_flags &= ~PTP_TCR_TSCFUPDT;
+
 	if (priv->hwts_tx_en || priv->hwts_rx_en) {
 		priv->systime_flags |= tstamp_all | ptp_v2 |
 				       ptp_over_ethernet | ptp_over_ipv6_udp |
@@ -684,6 +692,12 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
 
+	/* Switching between coarse/fine mode also requires updating the
+	 * subsecond increment
+	 */
+	if (priv->plat->clk_ptp_rate)
+		stmmac_update_subsecond_increment(priv);
+
 	priv->tstamp_config = *config;
 
 	return 0;
-- 
2.49.0


