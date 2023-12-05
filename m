Return-Path: <netdev+bounces-54009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE117805974
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5335B21094
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA86063DF4;
	Tue,  5 Dec 2023 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="NMX9GK6+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA3F1B6
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:04:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bf1e32571so3323316e87.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701792274; x=1702397074; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tBdLjc3B7qKl4y/0UG50f7tnGZ2PLAtrmTBWMvkt2bs=;
        b=NMX9GK6+KJkzSA54+1RoUitaXxBvJ2lZ19c7HLRaecUrhvko7SegZqtWhznCcx8Ad4
         TIQK5G52DeXW27XSvDo1ywmSwt9Mj0nb/S6DdYPNgiyVJYVWf/+H+stTMm9QYhP/8CzZ
         R5Hn8PSxY4UHXLC3blqhmUE7/do5ooHllioblTcEzWjrc2OZoNZxCjFPXIK4fVDnMuFp
         qWlWh4DJmB1bipko7/KKF/BhpvL/3DXzOTtd8nyFC8IGSNko0Mzpc9EONs3UvmiDEuEC
         D91wFGn9owCIMitE0rtm/g6q7Bwu3jhgBy5vucOjfg0YJ9X05kr+bfoueQKr/ZKqbKFs
         IXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792274; x=1702397074;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tBdLjc3B7qKl4y/0UG50f7tnGZ2PLAtrmTBWMvkt2bs=;
        b=rFONx2FXzqa/HheXF9ZNKK7A6qQHFmDhhvDu1iOrdH4xEw5knmdgqnJQyamrebYIqa
         du3NDVcrhGQPVEr1B1aceCl5k0vebAGjNbMqUr6ChwEy5SffCqNfDreHNBkir+RTzhJm
         6OMftQGHBb2f9nwsL9L8OQtS54jeWAcyi3CWzfWMtObDugdtGXSLA8zRvNzp1q19lCsO
         GQr4pLGMkevYjazVUppjxgJW9rkluocBP4TV9lCXMcQrZXp/zWq7Dot7ORThjTIPvNcB
         pFnNRrfNTFy3cvdBVFNrr4UvrW+PdmHCWBTRSWjWUZuZ3eT4lbq8v7OTjLeUdWAgYANZ
         clew==
X-Gm-Message-State: AOJu0YxrUECVQ31T5jjLBRo7ryoQCnPttYQJMsDrJfst9kHj1aMLjTDs
	QVKNFneiKzVMssKIJHe/rzK53Q==
X-Google-Smtp-Source: AGHT+IHaEUCXN+o2v9oJcYcBIhbQbGkOVX7Fckw3vDqK7Qv790rJe/x1HArFlTmsTVDL67luGIFaqw==
X-Received: by 2002:a19:711a:0:b0:50b:f6d2:8569 with SMTP id m26-20020a19711a000000b0050bf6d28569mr1593587lfc.129.1701792274094;
        Tue, 05 Dec 2023 08:04:34 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h25-20020a056512055900b0050c0bbbe3d2sm171341lfl.256.2023.12.05.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:04:33 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 5/6] net: dsa: mv88e6xxx: Add "eth-mac" counter group support
Date: Tue,  5 Dec 2023 17:04:17 +0100
Message-Id: <20231205160418.3770042-6-tobias@waldekranz.com>
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
ethtool's standardized "eth-mac" counter group.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 473f31761b26..1a16698181fb 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1319,6 +1319,44 @@ static void mv88e6xxx_get_ethtool_stats(struct dsa_switch *ds, int port,
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
@@ -6838,6 +6876,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.phylink_mac_link_up	= mv88e6xxx_mac_link_up,
 	.get_strings		= mv88e6xxx_get_strings,
 	.get_ethtool_stats	= mv88e6xxx_get_ethtool_stats,
+	.get_eth_mac_stats	= mv88e6xxx_get_eth_mac_stats,
 	.get_sset_count		= mv88e6xxx_get_sset_count,
 	.port_max_mtu		= mv88e6xxx_get_max_mtu,
 	.port_change_mtu	= mv88e6xxx_change_mtu,
-- 
2.34.1


