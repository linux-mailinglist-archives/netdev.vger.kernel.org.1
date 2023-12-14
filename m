Return-Path: <netdev+bounces-57470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B681322C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAFA1C21A7B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2DE59E3C;
	Thu, 14 Dec 2023 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="lb9SPqEZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686B7126
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:56 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9f9db9567so93431921fa.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702561854; x=1703166654; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R9Kj97axnrKUFcG0F4MCzmjC1h8BGCgdpbcM+QoaZpY=;
        b=lb9SPqEZFrLMwTxkZdd+0DdW2u0M/cq7bh1V5AgTliCEgCvTitXyHOJW0dOTtFwCc3
         oFgPclpdgLxsALwk6MaCuvr0lEvou85lEJo+r2Rts3BEmwJYu1iWlHRIUL9CMsjKYK5p
         /la0aDqIZ0Bfodu7Cg2Yu2agWKn2Q/J54k/Pf4QtoBm9bl/HdcLRepdi2o4hQq7/oBPQ
         UFIMIAOT6Aj/iTE/7LKMGK9zwPOlRz0lPAYCXO9Jl0lKpq6i//FzsxPWBImo6hZHUrJq
         V2mQlzvhUrXzUJwrpMv8opFBkYgjJYz3xZ8fpT99wJSOylxF+LCwHbd5Z39pzobnnGG8
         YCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561854; x=1703166654;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9Kj97axnrKUFcG0F4MCzmjC1h8BGCgdpbcM+QoaZpY=;
        b=c0eOCgQBVnjMeMxBNd6IFULGsuNkkQKUDcD3HpaAj7GCB9jYO0BJhfqCjMQ6YDY1tp
         55YUswxJNQsDpV1IQb82tj4cJLdhOt6uLFZiJfdh29qO9PrrfY6KT/rc1jYYMXL9BjFA
         OFqHBdfIHnVjM1pXFuSHG4TvzL4w9KIVIh2i71eQcS6JRu7KB9NMyLL45kz3UFkMuuz4
         eQPVrbACusqaQqW4J1O6OUh8ZhQgUGKenb4a0NqkCrdoYdg6GcpbcSlWXf6chgNMSAqK
         p5Yjf/5weJEr8NNIjnYWdGgrfiWAqeViKgkW9xZzOgsqRmeMTNGwBsCKA6svShvzZ8I8
         uCNQ==
X-Gm-Message-State: AOJu0YyTs0+XJUJ0x+TZTQtoTwQX7ODo2Vw2lmjO8r8WXuYP9A/snKU2
	0IiKlRTZZCzF10oAXCM1IkTjTA==
X-Google-Smtp-Source: AGHT+IH5H/bRBJ5u5QC7+Jzvrh2EtnQ19QFxIPTaJlWupciEdEnsVmzYTreR4c9+9J/l+np+FFv55w==
X-Received: by 2002:a05:651c:2225:b0:2cb:2bf9:7b8d with SMTP id y37-20020a05651c222500b002cb2bf97b8dmr4332042ljq.30.1702561854730;
        Thu, 14 Dec 2023 05:50:54 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a2ebc84000000b002cc258b5491sm1154010ljf.10.2023.12.14.05.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:53 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v4 net-next 7/8] net: dsa: mv88e6xxx: Add "rmon" counter group support
Date: Thu, 14 Dec 2023 14:50:28 +0100
Message-Id: <20231214135029.383595-8-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135029.383595-1-tobias@waldekranz.com>
References: <20231214135029.383595-1-tobias@waldekranz.com>
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

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 9e365364a34a..383b3c4d6f59 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1369,6 +1369,47 @@ static void mv88e6xxx_get_eth_mac_stats(struct dsa_switch *ds, int port,
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
@@ -6891,6 +6932,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.get_strings		= mv88e6xxx_get_strings,
 	.get_ethtool_stats	= mv88e6xxx_get_ethtool_stats,
 	.get_eth_mac_stats	= mv88e6xxx_get_eth_mac_stats,
+	.get_rmon_stats		= mv88e6xxx_get_rmon_stats,
 	.get_sset_count		= mv88e6xxx_get_sset_count,
 	.port_max_mtu		= mv88e6xxx_get_max_mtu,
 	.port_change_mtu	= mv88e6xxx_change_mtu,
-- 
2.34.1


