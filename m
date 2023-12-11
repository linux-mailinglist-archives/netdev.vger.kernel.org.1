Return-Path: <netdev+bounces-56117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB93480DE53
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B901C216DC
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAB456455;
	Mon, 11 Dec 2023 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="QW7mP+Jo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851ECAB
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:07 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bf82f4409so4907595e87.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702334046; x=1702938846; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3oYFX19aoMkMqEQ86H9Yvx8cbrkSVlx34zUodyS/Ze4=;
        b=QW7mP+Jo5e4qsHrWk6klXEBSFE7GbNN0ll6PGilNiRXQECTEwJ1g1m/GsjEuneUzpS
         W6LWOjdBbHD2v6cRHbMH40O+po0Qg4OJ1c0XVyRvqKZJC4v2G5iHq6Dl4H7RKPS+TGw7
         tiSWL19xoiSBGINwObDLeak3CEENWpGpX0PUYWTe3oWODAJ5gS1nFA+/xpYHlcXXggow
         aBXjhKfMVZn9eNGTotD9aBs2xvEhrIwMGEQz7Fon0O75HTMXQR+GJCTJogvCmBYLTHlj
         MK+dzI4gws7Lp6BVAcPMlmHfpqXqDmPSHfMy357qt8yo7TxcVzQXuhZdd8TTED8bet8e
         QhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334046; x=1702938846;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3oYFX19aoMkMqEQ86H9Yvx8cbrkSVlx34zUodyS/Ze4=;
        b=F3D3ovGTZc3NLQgGALRycGcwYpLR9oCzzhtPYNKAd7cjph61arDW3AvLAJ7gas5dbk
         4z93CS2EQta+Df+JrBFF8O2OzuJRvfYo9Mwp1LOEtsuT+96GvmtUWK9z/0LHB/GyehVq
         rWV63YQBZxTOLhgp2ccySv31pfYCdSbiDbyIQnPfomjNwW0BJa6QHDricZ1v/M6fWJNm
         RP3a9aiwNYi4tjsRKmNV9fBu8ZA1Kem+atajWKfcjoldwmjDv9yIxxjqP5YDoTdPhnGf
         cWxy33spQMCwUug+YDL9SCawY5fGqlSlGxBTXyZGviIEyNKf/otUZ6Oe56u9/tdpOeYp
         Bh7w==
X-Gm-Message-State: AOJu0YzvovebZNQ7wsNkbAN7Ep8pdQj/KSCKDjhIoycITpHeUX7wXHec
	xL1L/dL1hUd9r9WOpGuytis16g==
X-Google-Smtp-Source: AGHT+IEQLqqKq9WaSUJEt0zK2Nouxm4uOAapPqUCg/v5IdZKrd0D7iV8e74N+8PukUz+Lpiy13Uy+A==
X-Received: by 2002:a19:5e1d:0:b0:50b:f03c:1eb2 with SMTP id s29-20020a195e1d000000b0050bf03c1eb2mr2394612lfb.20.1702334045744;
        Mon, 11 Dec 2023 14:34:05 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651232d100b0050bfc6dbb8asm1217649lfg.302.2023.12.11.14.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:34:04 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v3 net-next 7/8] net: dsa: mv88e6xxx: Add "rmon" counter group support
Date: Mon, 11 Dec 2023 23:33:45 +0100
Message-Id: <20231211223346.2497157-8-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211223346.2497157-1-tobias@waldekranz.com>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
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
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index a3bd12ceba7b..a237f132c163 100644
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


