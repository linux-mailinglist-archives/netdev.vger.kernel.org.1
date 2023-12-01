Return-Path: <netdev+bounces-52918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D29800B56
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B52A1C20959
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AE425774;
	Fri,  1 Dec 2023 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="qPthpX49"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1CD10E2
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 04:58:53 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9c18e7990so27533591fa.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 04:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701435531; x=1702040331; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3nO97Jrg0PQ6UehyNGDlcD8xXoZojQSDiJExXNN24ho=;
        b=qPthpX499RLrR+TgG5aTmzMdje6jv14zRnQoCbIYF+64mYqkEBumYCMPEG33tBFR23
         maJBYhFRyPeken14QVB/RjDiMUwYeBow5o0wEr7lirYM8I2xvofjWHrAsTtsDp5ibem8
         hIPfn4HOIx41F6p5VmyxEbm5keMeJxeL0OawucJOg8AL+GbL3jLSaV/XhkOBPiSzizwF
         1d4/V9qYaW6L7NNmsN/DJQKw/mU3PGwiPWgVeGyt0m+7sXOa69vcezG8edY4a+ci+xel
         BP8gJC+vXY1A42lXPukTO7J/+DHhBYRu3Z9tKBUenyHk+91Fp8jqyOBOHtOdUFjJQ/V4
         mvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701435531; x=1702040331;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nO97Jrg0PQ6UehyNGDlcD8xXoZojQSDiJExXNN24ho=;
        b=tWeEfIEm2K8qqlt907yfrbfUQ4aiIyKmlOwJ4RINZ/MOKHNAm65BkOyNaEkk9etB+w
         3s6D069PXDrC7+xrAihQHcBOM7wj/N5gmzZGJqjGP8HU7Cy5bEOTlbbaQEU7+sRUdziF
         qjlQaji8Xlj5gwOzL+mPdWPQqxJHMbC880gnF7t+MpqF6O3RQoON9LmBjoxERec6jCM7
         rRxw/I0Lahmim7rUN9c5MKqklCMPJ2VB0h3vLJtn/qOsJk998KY0Jvs1gKFemEi9Yi+N
         DNgqfQVbT/ZypYG+q2kMVAebhSTA0qpkordF0wx+vGn6qzk2dY1ErDcTc4JX/LPMatCE
         bP1w==
X-Gm-Message-State: AOJu0Yyp35atBX61uDYLkQzkOkrrMkVkVZLQlBG+XYlIw6HG2Ru+4163
	Z2JdJiW+cQCik8yYNZIehWf7lQ==
X-Google-Smtp-Source: AGHT+IHOAAz+6anfXzaug6CijYDcDKmUqZQ351SgIm+13Rmi6q/HQdKOA8zYwtvRQoBj2vrjFx/vyA==
X-Received: by 2002:a2e:90cf:0:b0:2c9:d872:abc7 with SMTP id o15-20020a2e90cf000000b002c9d872abc7mr837566ljg.69.1701435531481;
        Fri, 01 Dec 2023 04:58:51 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id z13-20020a05651c11cd00b002c02b36d381sm417036ljo.88.2023.12.01.04.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:58:50 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next 4/4] net: dsa: mv88e6xxx: Add "rmon" counter group support
Date: Fri,  1 Dec 2023 13:58:12 +0100
Message-Id: <20231201125812.1052078-5-tobias@waldekranz.com>
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
ethtool's standardized "rmon" counter group.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 51e3744cb89b..bcb47ccf3ec1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1371,6 +1371,60 @@ static void mv88e6xxx_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	mac_stats->stats.FramesReceivedOK += mac_stats->stats.BroadcastFramesReceivedOK;
 }
 
+static void mv88e6xxx_get_rmon_stats(struct dsa_switch *ds, int port,
+				     struct ethtool_rmon_stats *rmon_stats,
+				     const struct ethtool_rmon_hist_range **ranges)
+{
+#define MV88E6XXX_RMON_STAT_MAPPING(_id, _member)			\
+	[MV88E6XXX_HW_STAT_ID_ ## _id] =				\
+		offsetof(struct ethtool_rmon_stats, stats._member)	\
+
+	static const size_t stat_map[MV88E6XXX_HW_STAT_ID_MAX] = {
+		MV88E6XXX_RMON_STAT_MAPPING(in_undersize, undersize_pkts),
+		MV88E6XXX_RMON_STAT_MAPPING(in_oversize, oversize_pkts),
+		MV88E6XXX_RMON_STAT_MAPPING(in_fragments, fragments),
+		MV88E6XXX_RMON_STAT_MAPPING(in_jabber, jabbers),
+		MV88E6XXX_RMON_STAT_MAPPING(hist_64bytes, hist[0]),
+		MV88E6XXX_RMON_STAT_MAPPING(hist_65_127bytes, hist[1]),
+		MV88E6XXX_RMON_STAT_MAPPING(hist_128_255bytes, hist[2]),
+		MV88E6XXX_RMON_STAT_MAPPING(hist_256_511bytes, hist[3]),
+		MV88E6XXX_RMON_STAT_MAPPING(hist_512_1023bytes, hist[4]),
+		MV88E6XXX_RMON_STAT_MAPPING(hist_1024_max_bytes, hist[5]),
+	};
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
+		member = (u64 *)(((char *)rmon_stats) + stat_map[id]);
+		mv88e6xxx_stats_get_stat(chip, port, stat, member);
+	}
+
+	*ranges = rmon_ranges;
+}
+
 static int mv88e6xxx_get_regs_len(struct dsa_switch *ds, int port)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
@@ -6891,6 +6945,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.get_strings		= mv88e6xxx_get_strings,
 	.get_ethtool_stats	= mv88e6xxx_get_ethtool_stats,
 	.get_eth_mac_stats	= mv88e6xxx_get_eth_mac_stats,
+	.get_rmon_stats		= mv88e6xxx_get_rmon_stats,
 	.get_sset_count		= mv88e6xxx_get_sset_count,
 	.port_max_mtu		= mv88e6xxx_get_max_mtu,
 	.port_change_mtu	= mv88e6xxx_change_mtu,
-- 
2.34.1


