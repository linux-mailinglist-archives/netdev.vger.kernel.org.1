Return-Path: <netdev+bounces-54008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F48805973
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5545C1F21878
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B88563DEC;
	Tue,  5 Dec 2023 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="bGF82Aa1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3019B
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:04:36 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bffb64178so1915796e87.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701792275; x=1702397075; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0vPITSTVxxWi/QeTHEeq7unWtEaVpM/oZPsQybO2yv4=;
        b=bGF82Aa1BnBnoAQWmc7PcqqceQjI2WR9GMvtvDOSJcx80Ni2jgtD50juR0k6J0e6LY
         XRu81gHkKBk4PYVCHQof8LYR+ZWhJetwb+V0dnZF7LGTUoALWhQjYQKn/Y0/MBDmYhm5
         uvAREwRj+orojrh1vQtcWlmPEym2KsTjiUndzNuNTdRRNsGIhaA4Mfmrr8gGFHjlJ1Hp
         9yHVxEoB4xHxlLttKh3XfTRgG+VTwkjfNJlwvlhCnZZdOQkElm6VGSLt6fTOLoWEWAE+
         OGMv1fv0AuUa/konbyzjc9IODcQm95f8nI08G25+0t1Px7hkNy9FWFdQABKtk+i9VMz2
         eo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792275; x=1702397075;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vPITSTVxxWi/QeTHEeq7unWtEaVpM/oZPsQybO2yv4=;
        b=wtcQcLWCHfhOWk/MFqxUHjhTvORzMxVhMFvZ3qvhbDrHf0ByKfMZF2olsMYax4yQfN
         cGHiq3RirfY2DTHBcGKbxL9DMX/I3VgkxxzDInE8QqD3AA18VIqCkL4RMGEgVgomimjs
         YstCqBUwbyYYlrtkIZKZPAiPvwUWu70bmnExh3ycTDcA0g8fl5jHNGHfWHCi4pca3uRB
         SCTZhpCF4Pv+eP0eqZxkJ42OoBR6RwyXzPMJ6Nbt3gCjcJFZFHYAgfqkTw2EiEVgb1Kp
         BwbAvuXlau2pVl/4M7Vse1ocptlxM6ekCzbfl3IaBno6LbvdxEMxj+IJJAc3Pv2iV8nh
         Txiw==
X-Gm-Message-State: AOJu0YwTu7an/MI754WWxylZ8iOeUU/DshjkUzVKupSURMg/2uORuNsL
	EcBZltqq86qxuhjE/HuAzkVn3w==
X-Google-Smtp-Source: AGHT+IHttDQ/vNNmlIivAzLFIz91u/kcs2nQe0Atn/Z2JbLsZk2egvbXivFRnbtZBlMLV75WRTpJSA==
X-Received: by 2002:ac2:43a3:0:b0:50b:f547:82ba with SMTP id t3-20020ac243a3000000b0050bf54782bamr1742774lfl.130.1701792275147;
        Tue, 05 Dec 2023 08:04:35 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h25-20020a056512055900b0050c0bbbe3d2sm171341lfl.256.2023.12.05.08.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:04:34 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 6/6] net: dsa: mv88e6xxx: Add "rmon" counter group support
Date: Tue,  5 Dec 2023 17:04:18 +0100
Message-Id: <20231205160418.3770042-7-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205160418.3770042-1-tobias@waldekranz.com>
References: <20231205160418.3770042-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Report the applicable subset of an mv88e6xxx port's counters using
ethtool's standardized "rmon" counter group.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 1a16698181fb..2e74109196f4 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1357,6 +1357,47 @@ static void mv88e6xxx_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	mac_stats->stats.FramesReceivedOK += mac_stats->stats.BroadcastFramesReceivedOK;
 }
 
+static void mv88e6xxx_get_rmon_stats(struct dsa_switch *ds, int port,
+				     struct ethtool_rmon_stats *rmon_stats,
+				     const struct ethtool_rmon_hist_range **ranges)
+{
+	static const struct ethtool_rmon_hist_range rmon_ranges[] = {
+		{   64,    64 },
+		{   65,   127 },
+		{  128,   255 },
+		{  256,   511 },
+		{  512,  1023 },
+		{ 1024, 65535 },
+		{}
+	};
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int ret;
+
+	ret = mv88e6xxx_stats_snapshot(chip, port);
+	if (ret < 0)
+		return;
+
+#define MV88E6XXX_RMON_STAT_MAP(_id, _member)				\
+	mv88e6xxx_stats_get_stat(chip, port,				\
+				 &mv88e6xxx_hw_stats[MV88E6XXX_HW_STAT_ID_ ## _id], \
+				 &rmon_stats->stats._member)
+
+	MV88E6XXX_RMON_STAT_MAP(in_undersize, undersize_pkts);
+	MV88E6XXX_RMON_STAT_MAP(in_oversize, oversize_pkts);
+	MV88E6XXX_RMON_STAT_MAP(in_fragments, fragments);
+	MV88E6XXX_RMON_STAT_MAP(in_jabber, jabbers);
+	MV88E6XXX_RMON_STAT_MAP(hist_64bytes, hist[0]);
+	MV88E6XXX_RMON_STAT_MAP(hist_65_127bytes, hist[1]);
+	MV88E6XXX_RMON_STAT_MAP(hist_128_255bytes, hist[2]);
+	MV88E6XXX_RMON_STAT_MAP(hist_256_511bytes, hist[3]);
+	MV88E6XXX_RMON_STAT_MAP(hist_512_1023bytes, hist[4]);
+	MV88E6XXX_RMON_STAT_MAP(hist_1024_max_bytes, hist[5]);
+
+#undef MV88E6XXX_RMON_STAT_MAP
+
+	*ranges = rmon_ranges;
+}
+
 static int mv88e6xxx_get_regs_len(struct dsa_switch *ds, int port)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
@@ -6877,6 +6918,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.get_strings		= mv88e6xxx_get_strings,
 	.get_ethtool_stats	= mv88e6xxx_get_ethtool_stats,
 	.get_eth_mac_stats	= mv88e6xxx_get_eth_mac_stats,
+	.get_rmon_stats		= mv88e6xxx_get_rmon_stats,
 	.get_sset_count		= mv88e6xxx_get_sset_count,
 	.port_max_mtu		= mv88e6xxx_get_max_mtu,
 	.port_change_mtu	= mv88e6xxx_change_mtu,
-- 
2.34.1


