Return-Path: <netdev+bounces-230285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A53EBE6399
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 05:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CEF620BAD
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4FD2EAD05;
	Fri, 17 Oct 2025 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euCOp/e2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAEC2EACE0
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672536; cv=none; b=JrjgvCIlroZglrFFYkJYAQkb+CmrBYmjk2i1sy+Ugko4Z9rWdXZ/2UgsIcrgrFNZS/X3AaOuuW5ea3lJsONUS516rVgUWYxo64B3F8Rg1f4QTc+EgngHI+3ctYXylvj/HOoE8NOcTxYWKM+4s8pD5GAluvWn/yz+bOI4RT1UXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672536; c=relaxed/simple;
	bh=Yu7Ry0nHYzkFpOviPQ73wvr+2M7lP6QTxPFeJoZcWGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzcekiZOvBxDhZWeD7LOyTRIhOZekzJHPaGYf57q1RpjULszM00QBEawH5O6+WtQlobNxu4pfTwlZ1P14nqGsaAI3S+zgL0HMoeb117ArouGcyAz28pW7MO2nxoT6lJNvYKhxE7q9Z2JlQUiOjiRjhli/aSCxVGsUN5gJ9a6cVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euCOp/e2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782e93932ffso1357223b3a.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760672534; x=1761277334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YR2Qwuf4oEi0NJdlFXFCJhjQKRsh3wLw7gZtNuj+GkU=;
        b=euCOp/e2MVmkUwzkkzFIVCYpuZ45bVjt2wxSFaI0rw8RwOEgp5vyKRpD+hzTMIGhGv
         dzArAlE9Mu7udlcRlubHMMCcFD4QFMVk5IgoKilnRx7M7FgYLTINe0xue6IMC3MoELz7
         9dCyggLNSiZaVzCzSN+wFtUc/6dzKl0X2YiCh/QBCtuL/Jz4mwmWVN6m4XFOjhCb6nqu
         s2pLKrJJj6kHscUnwatpD7dlVxAd3SraOtHd6xXCAxxq1AosY4x9IHbMpQnBEiK9OEbx
         RTQSOGRHB7qY1mNWx/48c3V2q2n6CcPs7KENalAGDU8Z881KEznCFXZUp0KxvI0Kw4GJ
         7zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760672534; x=1761277334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YR2Qwuf4oEi0NJdlFXFCJhjQKRsh3wLw7gZtNuj+GkU=;
        b=gjyG+TMkBoYfAzgtPdhjSwvpjGQe9SP+6Ts8LGkFrSyibkF5Rv4QhuipHLDaVEdqqZ
         H9qRy5KvgQ+3irnYo1INm4uSDwVnF0eG6ZqXZR8vHr5SWGgg8Xx/jaJ4y/qU12jdbX/d
         1P5P99SFWrC5ZMlyXYoSlbSu4w552E/hJ69tPPp0I10kHgwgf/SqFCS5Xb5/gTYfHpXq
         m8+x/PlsgK82iU7145CJPZ21mYrdd4Ki2t/2PMB1bAcDIUZnJmOt/CMJPnGaXw0rVsFh
         2cUj+I2njtVMTTTCdyEqs8NelD5Iih2ZRJrILnA9EbJN0vRrWQhazAQ+vpfGBG0jXFAQ
         ISxw==
X-Gm-Message-State: AOJu0YzE/RBjTWWG+WOBy/XuvNyRtWVgtqLcmBUWdUXzTpSJHygJSm6i
	eJZZgoINYtrSiBEMlBrAkma+PrNarCko8duAt+J8mCcG8ZLo/6SSCCGpWKYSqom11wQ=
X-Gm-Gg: ASbGncvKKGwQw+cRQqMqax/0ouGzBsuciNk0pI2iSvjfnaMtupaxvW8Yl0z1Ig+4iIK
	PfrgSCUMnlysvFxIBXNssyYXwxf+tee0zin7pG3oNiFk4ZY3ZC29LgztxbJ4NvxZ50Hj37vT/Zy
	nn7iFAuD9PLKIcIhGlJQx06OOv0iHWjGOgEUuwXknE2YIAGITcN7+6f0uKBJtcNGYfJ0OKpbkk1
	IZgIWsUfVhXNnQAHx42s28/5UTB3NvfZtdy5g2Ylo83fpevFWQ8TEDG2KE1+k8aZ2LFoh4j6IJF
	NpnwYQ70JxGhUEVDv0VVuUjn0e6nGEBZDraVgbSFpbJbSyOBc/YZwh55L8yQrA04AmwlmIjax+4
	wNhhhyu4FQ79iINfGELwLT7KwXlolLGRrN68pivuq28VX07DDYzhanApRJX0CCGY4GiVjfB8ZF6
	GJ+N38
X-Google-Smtp-Source: AGHT+IFM96S/jI0CT9nb4RQ/t3eV705T8Y4/fxX+JPnp7pYo83b3A1owVVu0bMujEg+L2uhb6eirug==
X-Received: by 2002:a17:903:2411:b0:290:ad79:c616 with SMTP id d9443c01a7336-290ccaccc25mr25597505ad.57.1760672533651;
        Thu, 16 Oct 2025 20:42:13 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4715sm46695165ad.93.2025.10.16.20.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:42:13 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 1/4] net: add a common function to compute features for upper devices
Date: Fri, 17 Oct 2025 03:41:52 +0000
Message-ID: <20251017034155.61990-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251017034155.61990-1-liuhangbin@gmail.com>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some high level software drivers need to compute features from lower
devices. But each has their own implementations and may lost some
feature compute. Let's use one common function to compute features
for kinds of these devices.

The new helper uses the current bond implementation as the reference
one, as the latter already handles all the relevant aspects: netdev
features, TSO limits and dst retention.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/linux/netdev_features.h | 18 +++++++
 include/linux/netdevice.h       |  1 +
 net/core/dev.c                  | 88 +++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7a01c518e573..93e4da7046a1 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -255,6 +255,24 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_GSO_UDP_TUNNEL |		\
 				 NETIF_F_GSO_UDP_TUNNEL_CSUM)
 
+/* virtual device features */
+#define MASTER_UPPER_DEV_VLAN_FEATURES	 (NETIF_F_HW_CSUM | NETIF_F_SG | \
+					  NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+					  NETIF_F_GSO_ENCAP_ALL | \
+					  NETIF_F_HIGHDMA | NETIF_F_LRO)
+
+#define MASTER_UPPER_DEV_ENC_FEATURES	 (NETIF_F_HW_CSUM | NETIF_F_SG | \
+					  NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
+					  NETIF_F_GSO_PARTIAL)
+
+#define MASTER_UPPER_DEV_MPLS_FEATURES	 (NETIF_F_HW_CSUM | NETIF_F_SG | \
+					  NETIF_F_GSO_SOFTWARE)
+
+#define MASTER_UPPER_DEV_XFRM_FEATURES	 (NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
+					  NETIF_F_GSO_ESP)
+
+#define MASTER_UPPER_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
+
 static inline netdev_features_t netdev_base_features(netdev_features_t features)
 {
 	features &= ~NETIF_F_ONE_FOR_ALL;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..7f5aad5cc9a1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5304,6 +5304,7 @@ static inline netdev_features_t netdev_add_tso_features(netdev_features_t featur
 int __netdev_update_features(struct net_device *dev);
 void netdev_update_features(struct net_device *dev);
 void netdev_change_features(struct net_device *dev);
+void netdev_compute_master_upper_features(struct net_device *dev, bool update_header);
 
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 33e6101dbc45..50d8ebd13a56 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12641,6 +12641,94 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 }
 EXPORT_SYMBOL(netdev_increment_features);
 
+/**
+ *	netdev_compute_master_upper_features - compute feature from lowers
+ *	@dev: the upper device
+ *	@update_header: whether to update upper device's header_len/headroom/tailroom
+ *
+ *	Recompute the upper device's feature based on all lower devices.
+ */
+void netdev_compute_master_upper_features(struct net_device *dev, bool update_header)
+{
+	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = MASTER_UPPER_DEV_GSO_PARTIAL_FEATURES;
+	netdev_features_t xfrm_features = MASTER_UPPER_DEV_XFRM_FEATURES;
+	netdev_features_t mpls_features = MASTER_UPPER_DEV_MPLS_FEATURES;
+	netdev_features_t vlan_features = MASTER_UPPER_DEV_VLAN_FEATURES;
+	netdev_features_t enc_features = MASTER_UPPER_DEV_ENC_FEATURES;
+	unsigned short max_header_len = ETH_HLEN;
+	unsigned int tso_max_size = TSO_MAX_SIZE;
+	unsigned short max_headroom = 0;
+	unsigned short max_tailroom = 0;
+	u16 tso_max_segs = TSO_MAX_SEGS;
+	struct net_device *lower_dev;
+	struct list_head *iter;
+
+	mpls_features = netdev_base_features(mpls_features);
+	vlan_features = netdev_base_features(vlan_features);
+	enc_features = netdev_base_features(enc_features);
+
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		gso_partial_features = netdev_increment_features(gso_partial_features,
+								 lower_dev->gso_partial_features,
+								 MASTER_UPPER_DEV_GSO_PARTIAL_FEATURES);
+
+		vlan_features = netdev_increment_features(vlan_features,
+							  lower_dev->vlan_features,
+							  MASTER_UPPER_DEV_VLAN_FEATURES);
+
+		enc_features = netdev_increment_features(enc_features,
+							 lower_dev->hw_enc_features,
+							 MASTER_UPPER_DEV_ENC_FEATURES);
+
+		if (IS_ENABLED(CONFIG_XFRM_OFFLOAD))
+			xfrm_features = netdev_increment_features(xfrm_features,
+								  lower_dev->hw_enc_features,
+								  MASTER_UPPER_DEV_XFRM_FEATURES);
+
+		mpls_features = netdev_increment_features(mpls_features,
+							  lower_dev->mpls_features,
+							  MASTER_UPPER_DEV_MPLS_FEATURES);
+
+		dst_release_flag &= lower_dev->priv_flags;
+
+		if (update_header) {
+			max_header_len = max(max_header_len, lower_dev->hard_header_len);
+			max_headroom = max(max_headroom, lower_dev->needed_headroom);
+			max_tailroom = max(max_tailroom, lower_dev->needed_tailroom);
+		}
+
+		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
+		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
+	}
+
+	dev->gso_partial_features = gso_partial_features;
+	dev->vlan_features = vlan_features;
+	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+			       NETIF_F_HW_VLAN_CTAG_TX |
+			       NETIF_F_HW_VLAN_STAG_TX;
+	if (IS_ENABLED(CONFIG_XFRM_OFFLOAD))
+		dev->hw_enc_features |= xfrm_features;
+	dev->mpls_features = mpls_features;
+
+	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	if ((dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
+	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
+		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
+
+	if (update_header) {
+		dev->hard_header_len = max_header_len;
+		dev->needed_headroom = max_headroom;
+		dev->needed_tailroom = max_tailroom;
+	}
+
+	netif_set_tso_max_segs(dev, tso_max_segs);
+	netif_set_tso_max_size(dev, tso_max_size);
+
+	netdev_change_features(dev);
+}
+EXPORT_SYMBOL(netdev_compute_master_upper_features);
+
 static struct hlist_head * __net_init netdev_create_hash(void)
 {
 	int i;
-- 
2.50.1


