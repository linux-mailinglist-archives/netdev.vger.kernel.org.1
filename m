Return-Path: <netdev+bounces-52400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE017FEA10
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 08:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17ACA1C20A34
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8E820DDC;
	Thu, 30 Nov 2023 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CWpSaIQt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC31BE5
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 23:59:05 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc9b626a96so6548415ad.2
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 23:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701331145; x=1701935945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KlByuks1Jx+Wl9b3Tee/pDpTmzdOczE9maWDQUbD5Y8=;
        b=CWpSaIQtdtNrtBT0ysc+EU4CFV1Wb/GSqwbrS8Yo2TfyRvdfd63jJ+nXiFVYmS6+kI
         aUI+qo+yhqCaD30bbOInqca+bN182y4gjVgRJwDZcizntGor1SkEhINpRIdUX8APmi8F
         0GyzPHT6+fZ09bGMnql19xEdanHUohFPoWXLPPMbAgvedImzBQEv9r+OMng9TK1pOuCA
         XuV+YLqbjG/6+TX0rGgN6nsS2+kVOGRxaE5Sq7AyY0BGEsc5LhxfY0Bhv08wAcL5NUqx
         ppAc70pM+topRDsQGeeO5IhQ51UsLetN/T4i7TdIbMHU4zLpdbxD0dpoez9e4QkUfMJc
         3b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701331145; x=1701935945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlByuks1Jx+Wl9b3Tee/pDpTmzdOczE9maWDQUbD5Y8=;
        b=DVeJuywN7mPzXRxT0NNEGrAVNdd8y2cxMNw3uL7y1iKPd98GIDQMuOYfvSU6Wb9DPN
         up8YhqYdRD/f6Cb67YRaAoR1VmP4tCO6xTMW769vslg/l0+qMBtfa8zUshfXgbhes6c3
         1wLUA87ntCOhrNRYIn12iw+euBWqGVW4Rvhy6N7iY7oqJZfaRK89evo9bKV65Nv+mdFg
         hbeUQ75io6mePQJcKm1ucdSPKD5r2cAQGPN7cfNFSR1euu9HOBeCA4DWtK+6O/tX36rZ
         5slvxEUbBeUIF3JkJSFvsgCkM5AbFTxoUnobthins+mEKuclMaTvpKRntinvL4IAcnRn
         UlMA==
X-Gm-Message-State: AOJu0YzgpY+QwCqo9Tv0nhXiLIpHQh0FQwZOTHzMOQDj1lXkcJWUeHEj
	ENdTrKxwmkBeEAhlieahe+zNFg==
X-Google-Smtp-Source: AGHT+IFExjE3BDEku4ZHInfO3rmuTiYxdr2UmNotXjtt51WP3MH/kZc7YhCAB/c3UDm5ZFP16/KJKQ==
X-Received: by 2002:a17:903:2311:b0:1cf:8e0e:43d5 with SMTP id d17-20020a170903231100b001cf8e0e43d5mr24705887plh.6.1701331144990;
        Wed, 29 Nov 2023 23:59:04 -0800 (PST)
Received: from C02F52LSML85.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b001cffb969683sm671756plg.174.2023.11.29.23.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:59:04 -0800 (PST)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: daniel@iogearbox.net,
	razor@blackwall.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	tangchen.1@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next] netkit: Add some ethtool ops to provide information to user
Date: Thu, 30 Nov 2023 15:58:44 +0800
Message-Id: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Add get_strings, get_sset_count, get_ethtool_stats to get peer
ifindex.
ethtool -S nk1
NIC statistics:
     peer_ifindex: 36

Add get_link, get_link_ksettings to get link stat.
ethtool nk1
Settings for nk1:
	...
	Link detected: yes

Add get_ts_info.
ethtool -T nk1
Time stamping parameters for nk1:
...

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 drivers/net/netkit.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 97bd6705c241..1a5199568a07 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -34,6 +34,12 @@ struct netkit_link {
 	u32 location;
 };
 
+static struct {
+	const char string[ETH_GSTRING_LEN];
+} ethtool_stats_keys[] = {
+	{ "peer_ifindex" },
+};
+
 static __always_inline int
 netkit_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
 	   enum netkit_action ret)
@@ -211,8 +217,55 @@ static void netkit_get_drvinfo(struct net_device *dev,
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
 }
 
+static void netkit_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
+{
+	u8 *p = buf;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(p, &ethtool_stats_keys, sizeof(ethtool_stats_keys));
+		p += sizeof(ethtool_stats_keys);
+		break;
+	}
+}
+
+static int netkit_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(ethtool_stats_keys);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void netkit_get_ethtool_stats(struct net_device *dev,
+				     struct ethtool_stats *stats, u64 *data)
+{
+	struct netkit *nk = netkit_priv(dev);
+	struct net_device *peer = rtnl_dereference(nk->peer);
+
+	data[0] = peer ? peer->ifindex : 0;
+}
+
+static int netkit_get_link_ksettings(struct net_device *dev,
+				     struct ethtool_link_ksettings *cmd)
+{
+	cmd->base.speed		= SPEED_10000;
+	cmd->base.duplex	= DUPLEX_FULL;
+	cmd->base.port		= PORT_TP;
+	cmd->base.autoneg	= AUTONEG_DISABLE;
+	return 0;
+}
+
 static const struct ethtool_ops netkit_ethtool_ops = {
 	.get_drvinfo		= netkit_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_strings		= netkit_get_strings,
+	.get_sset_count		= netkit_get_sset_count,
+	.get_ethtool_stats	= netkit_get_ethtool_stats,
+	.get_link_ksettings	= netkit_get_link_ksettings,
+	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
 static void netkit_setup(struct net_device *dev)
-- 
2.30.2


