Return-Path: <netdev+bounces-57468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5783281322B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0329E1F2226E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B200359E2D;
	Thu, 14 Dec 2023 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="OmtqvR+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE8D11D
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:54 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2cc3647bf06so23714051fa.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702561852; x=1703166652; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=28adhbU+JLrokN6RtHCJuYlNsZyAEkIxAcu+k1dn4Lg=;
        b=OmtqvR+7vakXeIxX/KJN9EH5fi5bC9bhecSIj0OeBgzKe4j9CGs4Cjk/6YSfJ8Qjr3
         k11UnYz0aNrXXMVVOxVnULNK19NsS0flsb/iEUjugWsebEnaN9cwv/50Ch54MmaTrRlq
         HhIruWtz9buFkmR+dAb+SZE3qSycc115SwOV8Vner/Sh2RLE+8QnxNPb/nAzZOj75V/Y
         oFj+aqO2u3cE7HIJOvr0tyCJrsi53tvLqLND7eL5X0NkzCbnir86pXDEXIHsF+pK2fs6
         0os5znJrVjWcgEw1pJRtqnaaoccdSaAU2ObktRfpCU45NJqCI1ZqxK2h7dL05dWEB8q8
         kl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561852; x=1703166652;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28adhbU+JLrokN6RtHCJuYlNsZyAEkIxAcu+k1dn4Lg=;
        b=X3p1UlXH7wlyzukzQGxuCqnwvahGmjuaxRpxBRDjmfVc+HZjUAXlZNu+GtsBR1LfIE
         SXKM9X4JOGxKPXFrL7UQB4Jq3RShlqoVz8zzgM+WAFj35coFd9Xls3GJvTw4B9tAKu/k
         zjsiH6ZdPTBIEnRA2k+OH+sJfMoIgqHFaLVZfetL6hb3wj/yw2mCujk2obvEbwU+x5Yd
         qKs+6IA08L+nkd6Omcu2Roz+yJzcgjaSTmfuKD5xIc69yPosw8a1O/UVtQLtJxh5ll+V
         BrvxxjkKH0qVGbMMEa/tM8cJekgYR/TrVe00sVX0LGFtT226ETnBTTSwjFieVox1butW
         CFeg==
X-Gm-Message-State: AOJu0Yx+jZZwdiMt9S4m9oZejilfi98a87QG/ZTj4O74jkwWvifZN7UQ
	L6DSHSgIBkg8YJXI8IVeurjsaQ==
X-Google-Smtp-Source: AGHT+IFj6D19dCdHdYnWyhalhMiDEUgQbDMnyiQSEXn+wsZOsMz+2+SxUcxtc6Ag6vUpP9zbZ9kuRg==
X-Received: by 2002:a2e:5c01:0:b0:2cb:2bd1:e984 with SMTP id q1-20020a2e5c01000000b002cb2bd1e984mr2778215ljb.17.1702561852537;
        Thu, 14 Dec 2023 05:50:52 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a2ebc84000000b002cc258b5491sm1154010ljf.10.2023.12.14.05.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:51 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v4 net-next 5/8] net: dsa: mv88e6xxx: Add "eth-mac" counter group support
Date: Thu, 14 Dec 2023 14:50:26 +0100
Message-Id: <20231214135029.383595-6-tobias@waldekranz.com>
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
ethtool's standardized "eth-mac" counter group.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c1cfe4f72868..627ed0d8be94 100644
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


