Return-Path: <netdev+bounces-56116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E390480DE52
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789C9281C3B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAD656445;
	Mon, 11 Dec 2023 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="pCUwrPpO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF78C4
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bf82f4409so4907564e87.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702334043; x=1702938843; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uuy7a+L6R2lPQ95bEcZRj/bnh0pNGS9jFwEfj/XjEkU=;
        b=pCUwrPpOOqSExf3/KqwIFaL7gBS/zcuCIUGcb8Q3avCkK4ZSJXu+PI3dDRfess2KG6
         5EGq09f2soJ3U/pjWJMV7OJiHHxrp0Qh+4Rz/4Eyskjb/DhPaJ/famDUroncotwetUn+
         PPr0yV1WjYq2rtNNGo+08V2kGOvvxqyRqlpkc3y2Zxsbmzua3RFRGxhtNas4DritKDOZ
         bGngGyevZyVycOWZEzQ+rwqBcmHz5/2EN7posrTElkL+MxM/VthTe1H5GXs+VxrG5zEK
         1KphdWB3id7mh5jGgZ3u1NG6pdY5XyVJCLiCacaAWNqPZ7bGndPSi+S3Lxm+Ez3cLcXh
         yX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334043; x=1702938843;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uuy7a+L6R2lPQ95bEcZRj/bnh0pNGS9jFwEfj/XjEkU=;
        b=jC4sntRCHQkBCkjQBxXajZ4vM7Vj9D8pUeXSoSAfYqI/TeBGR+DZgANpJJcRSIMZvk
         vtApcIHH42ooHfMPZhPBIhakKpkVb6tjTs7cnc2mo/qUvnuSvxoO43X9b0gTO62rq6Hb
         a9dKxi83Bqh/TE9gK7Ryd+UQfiYCxGq7uqXIsnn1IIkmybplhEXXjOGO2C68ZWvMJR3U
         Y61fZdnMlhC3TaQc2xW++8FJlQBR1XyMpEgoUQI1xYmOHKdMuqcR9Lcr5XfTbzclhCY2
         WMqkgnPcMl/RLWtIbN4E1nL7DvYSjo9gAYlWqSU8NhjFr+xYYPUoAVUZCMQoiHaxyU9u
         xpdQ==
X-Gm-Message-State: AOJu0YzKjKlGIbkId41SXi7hLxdeOckO3LS39IvYtASxnrDwNiZjhWyd
	e3SrzEHqi/gTIPbyDOPRK6ef2Q==
X-Google-Smtp-Source: AGHT+IEYDR964Ktv3i/qef5vSuv5Bhfo/B7ZAdAjpgSOxkTGA2wRtAzYfur5peCm/wIgCuJjyOzD9w==
X-Received: by 2002:a05:6512:1304:b0:50d:1a0e:45bf with SMTP id x4-20020a056512130400b0050d1a0e45bfmr3351542lfu.29.1702334043511;
        Mon, 11 Dec 2023 14:34:03 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651232d100b0050bfc6dbb8asm1217649lfg.302.2023.12.11.14.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:34:02 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v3 net-next 5/8] net: dsa: mv88e6xxx: Add "eth-mac" counter group support
Date: Mon, 11 Dec 2023 23:33:43 +0100
Message-Id: <20231211223346.2497157-6-tobias@waldekranz.com>
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
ethtool's standardized "eth-mac" counter group.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index cbbaf393ed28..6f1f71cb0de5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1331,6 +1331,44 @@ static void mv88e6xxx_get_ethtool_stats(struct dsa_switch *ds, int port,
 	mv88e6xxx_get_stats(chip, port, data);
 }
 
+static void mv88e6xxx_get_eth_mac_stats(struct dsa_switch *ds, int port,
+					struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int ret;
+
+	ret = mv88e6xxx_stats_snapshot(chip, port);
+	if (ret < 0)
+		return;
+
+#define MV88E6XXX_ETH_MAC_STAT_MAP(_id, _member)			\
+	mv88e6xxx_stats_get_stat(chip, port,				\
+				 &mv88e6xxx_hw_stats[MV88E6XXX_HW_STAT_ID_ ## _id], \
+				 &mac_stats->stats._member)
+
+	MV88E6XXX_ETH_MAC_STAT_MAP(out_unicast, FramesTransmittedOK);
+	MV88E6XXX_ETH_MAC_STAT_MAP(single, SingleCollisionFrames);
+	MV88E6XXX_ETH_MAC_STAT_MAP(multiple, MultipleCollisionFrames);
+	MV88E6XXX_ETH_MAC_STAT_MAP(in_unicast, FramesReceivedOK);
+	MV88E6XXX_ETH_MAC_STAT_MAP(in_fcs_error, FrameCheckSequenceErrors);
+	MV88E6XXX_ETH_MAC_STAT_MAP(out_octets, OctetsTransmittedOK);
+	MV88E6XXX_ETH_MAC_STAT_MAP(deferred, FramesWithDeferredXmissions);
+	MV88E6XXX_ETH_MAC_STAT_MAP(late, LateCollisions);
+	MV88E6XXX_ETH_MAC_STAT_MAP(in_good_octets, OctetsReceivedOK);
+	MV88E6XXX_ETH_MAC_STAT_MAP(out_multicasts, MulticastFramesXmittedOK);
+	MV88E6XXX_ETH_MAC_STAT_MAP(out_broadcasts, BroadcastFramesXmittedOK);
+	MV88E6XXX_ETH_MAC_STAT_MAP(excessive, FramesWithExcessiveDeferral);
+	MV88E6XXX_ETH_MAC_STAT_MAP(in_multicasts, MulticastFramesReceivedOK);
+	MV88E6XXX_ETH_MAC_STAT_MAP(in_broadcasts, BroadcastFramesReceivedOK);
+
+#undef MV88E6XXX_ETH_MAC_STAT_MAP
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
@@ -6852,6 +6890,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.phylink_mac_link_up	= mv88e6xxx_mac_link_up,
 	.get_strings		= mv88e6xxx_get_strings,
 	.get_ethtool_stats	= mv88e6xxx_get_ethtool_stats,
+	.get_eth_mac_stats	= mv88e6xxx_get_eth_mac_stats,
 	.get_sset_count		= mv88e6xxx_get_sset_count,
 	.port_max_mtu		= mv88e6xxx_get_max_mtu,
 	.port_change_mtu	= mv88e6xxx_change_mtu,
-- 
2.34.1


