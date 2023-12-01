Return-Path: <netdev+bounces-52919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F26800B57
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06766B212A2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517D525777;
	Fri,  1 Dec 2023 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="VfWS8zZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41401B3
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 04:58:51 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9b88cf626so28048101fa.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 04:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701435530; x=1702040330; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=emgmCjmERPAQVOPYdRIVng8dq1nSX2gRlTojtJgnELA=;
        b=VfWS8zZLXU2snFmSxcE5y6e2z5KpjsEcOMEyKl9YbDiArh5eVbaGA4inCnuQd9jCxU
         7qpmaJx4uRTwL7oGCPKzS+nyC5d1j8rHjekUFKwwONVf55Ey5SDQpU6Sa/J7d/FCF3mF
         n4Zkv2gD3Ov3plBY9ZOjmzY27vsqAWVqEvI5bSZ9DRoJFVyr63b5fM7gksCNeoBx537E
         Sv0/G3cLdZfcq78dulXGYJ6gXglm+jAeV9cSZngQduab0kr11KJv2Fn3IR0c5ATM6xbM
         uEFo02MMfkr0IRmLKsSyj4lF7z+oM+q60TF/xJqwLWRZQr6uJ7IbXZjLExlsGOhog64k
         N5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701435530; x=1702040330;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emgmCjmERPAQVOPYdRIVng8dq1nSX2gRlTojtJgnELA=;
        b=EWAZFO29fMEWkSz2zrEts2VAzWz3Vf+v8kYhhb6k4DOnB0KFlzhQpt1/739YfqGXwU
         yaWGDtXKyeRRi5BqF74fifJAP8pPlb6Rj0X7cM0lsADmEcBOgW6P4wXPAsQYU7C1OH/Y
         Rknm2VAHy7jGmLHW6hrb3YyJa6EAbL9TZzrcqOuM675TPmhSWUOzIlUyztzep9C0Vy3w
         fzj2jLWVKduF706gsi7tWKjQFHLemba7WMSNYsCfDD0zwpo4TiD8NZE7t4g+Qekp3eH1
         8ODyH6UHAy6S/jCvhdG9s0/Ozq7z7mNNjLPIE5bfsSTTkVeJU+G8gTFP96eQhl6Yg0Im
         35jQ==
X-Gm-Message-State: AOJu0Yz3qJ/R8A8h/LpgtRt4AGr2mHmBa3J/B5nJ4vWqQvCg/b7RoUeb
	6t9CahS5kDaI0fPIc6c32T5tTw==
X-Google-Smtp-Source: AGHT+IEPtlwCMSmQKnEYHe/wVXAiCwqDKPcDP6UVRIuDjprAJXl31Q1iPp+78BAMoWH0JySe3/YSEg==
X-Received: by 2002:a2e:8708:0:b0:2c9:d872:e7a6 with SMTP id m8-20020a2e8708000000b002c9d872e7a6mr900767lji.93.1701435530239;
        Fri, 01 Dec 2023 04:58:50 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id z13-20020a05651c11cd00b002c02b36d381sm417036ljo.88.2023.12.01.04.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:58:49 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/4] net: dsa: mv88e6xxx: Add "eth-mac" counter group support
Date: Fri,  1 Dec 2023 13:58:11 +0100
Message-Id: <20231201125812.1052078-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201125812.1052078-1-tobias@waldekranz.com>
References: <20231201125812.1052078-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Report the applicable subset of an mv88e6xxx port's counters using
ethtool's standardized "eth-mac" counter group.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 71c60f229a2f..51e3744cb89b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1320,6 +1320,57 @@ static void mv88e6xxx_get_ethtool_stats(struct dsa_switch *ds, int port,
 
 }
 
+static void mv88e6xxx_get_eth_mac_stats(struct dsa_switch *ds, int port,
+					struct ethtool_eth_mac_stats *mac_stats)
+{
+#define MV88E6XXX_ETH_MAC_STAT_MAPPING(_id, _member)			\
+	[MV88E6XXX_HW_STAT_ID_ ## _id] =				\
+		offsetof(struct ethtool_eth_mac_stats, stats._member)	\
+
+	static const size_t stat_map[MV88E6XXX_HW_STAT_ID_MAX] = {
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(out_unicast, FramesTransmittedOK),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(single, SingleCollisionFrames),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(multiple, MultipleCollisionFrames),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(in_unicast, FramesReceivedOK),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(in_fcs_error, FrameCheckSequenceErrors),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(out_octets, OctetsTransmittedOK),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(deferred, FramesWithDeferredXmissions),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(late, LateCollisions),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(in_good_octets, OctetsReceivedOK),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(out_multicasts, MulticastFramesXmittedOK),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(out_broadcasts, BroadcastFramesXmittedOK),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(excessive, FramesWithExcessiveDeferral),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(in_multicasts, MulticastFramesReceivedOK),
+		MV88E6XXX_ETH_MAC_STAT_MAPPING(in_broadcasts, BroadcastFramesReceivedOK),
+	};
+	struct mv88e6xxx_chip *chip = ds->priv;
+	const struct mv88e6xxx_hw_stat *stat;
+	enum mv88e6xxx_hw_stat_id id;
+	u64 *member;
+	int ret;
+
+	mv88e6xxx_reg_lock(chip);
+	ret = mv88e6xxx_stats_snapshot(chip, port);
+	mv88e6xxx_reg_unlock(chip);
+
+	if (ret < 0)
+		return;
+
+	stat = mv88e6xxx_hw_stats;
+	for (id = 0; id < MV88E6XXX_HW_STAT_ID_MAX; id++, stat++) {
+		if (!stat_map[id])
+			continue;
+
+		member = (u64 *)(((char *)mac_stats) + stat_map[id]);
+		mv88e6xxx_stats_get_stat(chip, port, stat, member);
+	}
+
+	mac_stats->stats.FramesTransmittedOK += mac_stats->stats.MulticastFramesXmittedOK;
+	mac_stats->stats.FramesTransmittedOK += mac_stats->stats.BroadcastFramesXmittedOK;
+	mac_stats->stats.FramesReceivedOK += mac_stats->stats.MulticastFramesReceivedOK;
+	mac_stats->stats.FramesReceivedOK += mac_stats->stats.BroadcastFramesReceivedOK;
+}
+
 static int mv88e6xxx_get_regs_len(struct dsa_switch *ds, int port)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
@@ -6839,6 +6890,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.phylink_mac_link_up	= mv88e6xxx_mac_link_up,
 	.get_strings		= mv88e6xxx_get_strings,
 	.get_ethtool_stats	= mv88e6xxx_get_ethtool_stats,
+	.get_eth_mac_stats	= mv88e6xxx_get_eth_mac_stats,
 	.get_sset_count		= mv88e6xxx_get_sset_count,
 	.port_max_mtu		= mv88e6xxx_get_max_mtu,
 	.port_change_mtu	= mv88e6xxx_change_mtu,
-- 
2.34.1


