Return-Path: <netdev+bounces-229851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D708FBE1601
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398C53B4F3B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 03:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070CF1DA55;
	Thu, 16 Oct 2025 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIVHW24F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8C3254B8
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585930; cv=none; b=mfptweKu4uU6A7taPylReP7A9QlofCw3N+RAfr71APQJTaGDp3+u5ds7ceoLgulaUpXqmzKXvQLROhBUSVzlK4IXDsmVMIb/1/j/lIURBYQuG1IoJO22YM+NgNZU1zVVPOSMbWzx+OrZLSTvH/KRe1gJGbibstYQ+Kvn2bsUWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585930; c=relaxed/simple;
	bh=jtxM883aMPKlN/KGb2ljhQBXsIkM0dA3IyBTXpxd4Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+TKMx0QY9f7PczUYesf63c9dIVPcOXryhy/VU5qD9gFVoU6PTr0SVRqJXLC68Ueicw2GnSffjFI58XCEipyTKbulOTJ5w9wN7XV+B9353NBjmtEua3sJ7ksAauhmiQAK1SPV6XNJEwXi/MYS19GUfIe0bufC5TZWw6zwavmsbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIVHW24F; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-794e300e20dso1318827b3a.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760585927; x=1761190727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U3shMQWdIXc1mtcSMjgFuKSzDMPyNXZfAEh5poLBz4=;
        b=bIVHW24FnJk/xd4AaD2v6M5ilW83ODuV0kPIcY+2CNxx1dp1f7mDPerQ3T3iQiNHgo
         ybeUpgYWHAh8TFp4XEWyRiF7FFk/jyV5XqfYcm/zG/J9jnXjEfKUoqRb+RGkPDewK3V5
         5+Oe8+hTpCaVEZsmKT8cj6hqs0X2MmJp9VMrAmlZhLqSxl1LwyD6ivIcMMJSP31eDgY5
         jbJvKFZCGmEBuAaqblqN/0ujP8T1IRe2AdcGdPcdlMteVihJRMBpzuZqL9VQO7pcqZpQ
         zI/3f3ZWrV7Q/Zuiat15tFaVZtNLz/Co/TS6DgTBH5uNMTnfqpofXUrz9SjZT9Y4cJo0
         7vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760585927; x=1761190727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1U3shMQWdIXc1mtcSMjgFuKSzDMPyNXZfAEh5poLBz4=;
        b=aTypsdFpABguUB1ohrYg4Xd/Yd9D0J1+iNp3b1FUjmfxDqYnmp0p7KFddR0vd5vYpE
         SqHhI5Hyv5kG5xchr1GmKKWcH42+SKCK1H77TaMKeWFcylp1E2GPsLEXJYu2T1aWkcdw
         ejbG5bbOdTs+a1cim9PCxFeTFp7AbCje0RaHatwCn83bdMWwUvNi9tgeQRfuw3SpTUhT
         LX05uFj1OtmMQnYsuVQne81qccB51gwvS+nRZf3YnMF8InmDmGD8eZav9woJevJL0haD
         OMD9ZoJXFxp0i9VuFtvAW0EFXQOgSsh/GSRUx4sACCQBFHk0xfL5y2HoCKxRkSeC1DlD
         fwcg==
X-Gm-Message-State: AOJu0YzYFjuklnKFSRdrKxOkWFGAiuIZxeZa5EKqnqpGTWOVopWHPss6
	Iv3+mgAzjPUTvYa0zaNiMFiOzcAni+oDIYlpkhEIUvlJgznn0XPfXYOHvOjix2aV3n8=
X-Gm-Gg: ASbGnctQu2MAryLw4lKo/4XS/pXKgxuL8FhqsZYBfKf0HJz91PLagGEZhYLv1WHVy79
	UrBI1VY3lXmPO1CeZx/P0EfvtLeS/7v5jaYD6dv4TakTosqy1G3f9sEwyn41MefoEoX4xIbTg45
	9HUeXfMYyRnVmRk5NehlsWJgPZgSEnx6ZOgenGoNZZrr0YFmcIqUbAKvNSc5kPGw6w0np+G9n8j
	p2t5xs/uDDk3Pv8wgMDWzbwzYa8MABZiQ3sooDkpCD8TMadgRvQ7aUo8Mtn56d+bIM5YBG4yPTU
	syMVC4ZmMICX7Ao2HrdyAT9Ll6abIYnyKDuApL/u+MjStIOw99/85GFn+9CkAjOOWEyBXCZuxGM
	HtL5TP2wPzIRe3BYs7Z5snhwWE8Nrj2wwnG4FtUaYRtHCySzDDB/oq130+MXakDj+KwbegKjlMi
	kofSI8J++N2XXL/0Y=
X-Google-Smtp-Source: AGHT+IEQnSNMmFHmCUEdL+aRIKm9fNrjLAzbqx2Ldo6MIRmL9eucbRosmVQisM3sE1KVA/Y8CVNmdA==
X-Received: by 2002:a17:903:2c0f:b0:278:f46b:d49c with SMTP id d9443c01a7336-290919db9c6mr28052985ad.9.1760585927423;
        Wed, 15 Oct 2025 20:38:47 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343065sm12507925ad.26.2025.10.15.20.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:38:46 -0700 (PDT)
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
Subject: [PATCHv5 net-next 1/4] net: add a common function to compute features for upper devices
Date: Thu, 16 Oct 2025 03:38:25 +0000
Message-ID: <20251016033828.59324-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016033828.59324-1-liuhangbin@gmail.com>
References: <20251016033828.59324-1-liuhangbin@gmail.com>
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
index 7a01c518e573..ffb5f2ccfea2 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -255,6 +255,24 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_GSO_UDP_TUNNEL |		\
 				 NETIF_F_GSO_UDP_TUNNEL_CSUM)
 
+/* virtual device features */
+#define UPPER_DEV_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
+				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+				 NETIF_F_GSO_ENCAP_ALL | \
+				 NETIF_F_HIGHDMA | NETIF_F_LRO)
+
+#define UPPER_DEV_ENC_FEATURES  (NETIF_F_HW_CSUM | NETIF_F_SG | \
+				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
+				 NETIF_F_GSO_PARTIAL)
+
+#define UPPER_DEV_MPLS_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
+				 NETIF_F_GSO_SOFTWARE)
+
+#define UPPER_DEV_XFRM_FEATURES (NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
+				 NETIF_F_GSO_ESP)
+
+#define UPPER_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
+
 static inline netdev_features_t netdev_base_features(netdev_features_t features)
 {
 	features &= ~NETIF_F_ONE_FOR_ALL;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..e25c02eb537d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5304,6 +5304,7 @@ static inline netdev_features_t netdev_add_tso_features(netdev_features_t featur
 int __netdev_update_features(struct net_device *dev);
 void netdev_update_features(struct net_device *dev);
 void netdev_change_features(struct net_device *dev);
+void netdev_compute_upper_features(struct net_device *dev, bool update_header);
 
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 33e6101dbc45..fab7ccedc5a3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12641,6 +12641,94 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 }
 EXPORT_SYMBOL(netdev_increment_features);
 
+/**
+ *	netdev_compute_upper_features - compute feature from lowers
+ *	@dev: the upper device
+ *	@update_header: whether to update upper device's header_len/headroom/tailroom
+ *
+ *	Recompute the upper device's feature based on all lower devices.
+ */
+void netdev_compute_upper_features(struct net_device *dev, bool update_header)
+{
+	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = UPPER_DEV_GSO_PARTIAL_FEATURES;
+	netdev_features_t xfrm_features = UPPER_DEV_XFRM_FEATURES;
+	netdev_features_t mpls_features = UPPER_DEV_MPLS_FEATURES;
+	netdev_features_t vlan_features = UPPER_DEV_VLAN_FEATURES;
+	netdev_features_t enc_features = UPPER_DEV_ENC_FEATURES;
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
+								 UPPER_DEV_GSO_PARTIAL_FEATURES);
+
+		vlan_features = netdev_increment_features(vlan_features,
+							  lower_dev->vlan_features,
+							  UPPER_DEV_VLAN_FEATURES);
+
+		enc_features = netdev_increment_features(enc_features,
+							 lower_dev->hw_enc_features,
+							 UPPER_DEV_ENC_FEATURES);
+
+		if (IS_ENABLED(CONFIG_XFRM_OFFLOAD))
+			xfrm_features = netdev_increment_features(xfrm_features,
+								  lower_dev->hw_enc_features,
+								  UPPER_DEV_XFRM_FEATURES);
+
+		mpls_features = netdev_increment_features(mpls_features,
+							  lower_dev->mpls_features,
+							  UPPER_DEV_MPLS_FEATURES);
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
+EXPORT_SYMBOL(netdev_compute_upper_features);
+
 static struct hlist_head * __net_init netdev_create_hash(void)
 {
 	int i;
-- 
2.50.1


