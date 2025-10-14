Return-Path: <netdev+bounces-229082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222ABD811A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 053624F9691
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C1630E84F;
	Tue, 14 Oct 2025 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0U8vhkV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4E2DC323
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428960; cv=none; b=jRS+aZ+hhXHABzZjjB7A+wfXZ6PvOppDn1v7zRNuAAcPzyvTAFFIQiFH/0vPveQvqfXLVtq/fHJP5l6mUCfzzrhYcdVhWfaNm0dFRwpMN/5LGldxAb0K/USTcnopzxOtRsvyZcx2IgPywHkEJbs/scirH9NYql7phJVkjNYC+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428960; c=relaxed/simple;
	bh=8dTxGOgQN7TatfYGs89HXqTVV1dfXFxVLm/rqIOGmqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4JKI3cT4joKN4V1ypl1+swEPelyONCuQ4W5Cxrn5EeLk38V+kGgxoQ2QVAlcpr5r4+5vUTXIOPccJma8XPITlbliKY9vHpqOqv2Nh2q9CvVUakVChb75+fo9jFRzHsWD5YtITZzi3bu0Vpyq2wXgfG9IyFeFZ8tnt+63hfFTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0U8vhkV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4532856b3a.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760428958; x=1761033758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWnH+cC42+c5SizK69CiWCx74af0EbDcIh1zp6haGLQ=;
        b=B0U8vhkVTsZHKfGQc6vnQAFpclzBDXEjx+ywfqd08W2i0KiL08hRG9EylU5i3lY9LE
         Bq8es+vI2PACTE5ebTkAhss3dInMIOl9bXfH6B2i8vI7BzmzZkIn9E0JyPM3UhCWGxYz
         0gPO2IFl04Kc/kSq3T61hvazkCKBSp4rPj/EwYhtcK/qF/JdVR6taOxZWjfcJSDcTV3W
         E05SQgLMTgNVBo4F3mxvPXKOQ3VgJvrvEcbTTKHrXyHnxs3KIa7LIFr32UL850l9irIA
         L0ZJKEFUk8NidzEDwvZEPwWIeETz9DJV3maRUpKy7h63FYrrmjgYuaa7NVSFimnTMmXU
         YyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428958; x=1761033758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWnH+cC42+c5SizK69CiWCx74af0EbDcIh1zp6haGLQ=;
        b=n0cKYY+PmMdXqLAbkJnvpjbiuJjanXdULU9JnLLjwZBXjKTPlheVS5PeLfk4btc5jf
         7AfwrgGLU5V0x9psvpk/mH4P8gW871v4X46TFKHAfOylOC7kOY22y2UrOjAeDfiNivlF
         4mKZxU5rMcy8xBlxmKBOjgMv26hcI/2jjFU0ZZNCasvKRQ1CZ4Loj2O483lfRA84QLFB
         km0fkZB0v4YYEYUVCTiPSRhohq4R4zzhBX2I0UqR7R8R4KRS6MWVCNTbqwWvToQ1Brpb
         Hyq+yjmp++oYIOTNo8BlDMCLLIB829RdQQ2EzFdE39/lMigQuI77KhNzM5JXWHrmCaK4
         m/9Q==
X-Gm-Message-State: AOJu0YyngmrwktWKNdg4l7lUDT3bYw8OhwVYmqiw/+wRADiM7+/QijBs
	kWxBmv5KZFepkWyxEOK7AMc/g9P3eiaVJDVUgZdO2cnh6/3v3JDbJpeTljj0vQVS57c=
X-Gm-Gg: ASbGncuH3pkTHW+SAxn5MQ0tJ4+lUysM4ERQsjQTLjXjj9tiwoO0qsZSVLYUZYJpcMB
	WmpsjTrBKoxRYtRWHs3JT9zbEUJ7PBDqSEbkOT4M+dgB8q7psfio3nj7uVhBslJBHNgy2pyb7aV
	pT6Q/KfHePycOvdVyiOPdR8bzbtfHHgwYP2XBMTPFkpbFxbaRdFlsI8G9J8txFfKoHe4oGaLQAL
	Obv+Ns+eNTOAerYxoYb+HNWpSt++RZ9N7sG1U3GSJbnO3q4q/aJHzvmVks0hA5wQgJ1uTIw2brx
	hk+bkVwZyDB/e03w/ZpFMyvEQSxvhPw+yNFu0CnsKLRStde+++zEvjkTFH9w9e8VHBSG6deASZo
	3qvBtJig+GBl4W4LuuXeAp55uil7j58EV0UO+XhRvjtmc+w==
X-Google-Smtp-Source: AGHT+IHtgBHpjqHOfJPQMdE11TvFAmCGMEgpTH8sJ4AtgUwzT3dUkv9OUYCk/OS7ICE9VnkZDoBWig==
X-Received: by 2002:a17:90b:1c0e:b0:335:2823:3686 with SMTP id 98e67ed59e1d1-33b510ff59bmr29055412a91.2.1760428957619;
        Tue, 14 Oct 2025 01:02:37 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626407c4sm14648210a91.6.2025.10.14.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:02:37 -0700 (PDT)
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 1/4] net: add a common function to compute features from lowers devices
Date: Tue, 14 Oct 2025 08:02:14 +0000
Message-ID: <20251014080217.47988-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014080217.47988-1-liuhangbin@gmail.com>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some high level virtual drivers need to compute features from lower
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
 net/core/dev.c                  | 95 +++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7a01c518e573..f3fe2d59ea96 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -255,6 +255,24 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_GSO_UDP_TUNNEL |		\
 				 NETIF_F_GSO_UDP_TUNNEL_CSUM)
 
+/* virtual device features */
+#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
+					 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+					 NETIF_F_GSO_ENCAP_ALL | \
+					 NETIF_F_HIGHDMA | NETIF_F_LRO)
+
+#define VIRTUAL_DEV_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
+					 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
+					 NETIF_F_GSO_PARTIAL)
+
+#define VIRTUAL_DEV_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
+					 NETIF_F_GSO_SOFTWARE)
+
+#define VIRTUAL_DEV_XFRM_FEATURES	(NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
+					 NETIF_F_GSO_ESP)
+
+#define VIRTUAL_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
+
 static inline netdev_features_t netdev_base_features(netdev_features_t features)
 {
 	features &= ~NETIF_F_ONE_FOR_ALL;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..8e28fee247f5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5304,6 +5304,7 @@ static inline netdev_features_t netdev_add_tso_features(netdev_features_t featur
 int __netdev_update_features(struct net_device *dev);
 void netdev_update_features(struct net_device *dev);
 void netdev_change_features(struct net_device *dev);
+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header);
 
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index a64cef2c537e..54f0e792fbd2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12616,6 +12616,101 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 }
 EXPORT_SYMBOL(netdev_increment_features);
 
+/**
+ *	netdev_compute_features_from_lowers - compute feature from lowers
+ *	@dev: the upper device
+ *	@update_header: whether to update upper device's header_len/headroom/tailroom
+ *
+ *	Recompute the upper device's feature based on all lower devices.
+ */
+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)
+{
+	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
+#ifdef CONFIG_XFRM_OFFLOAD
+	netdev_features_t xfrm_features = VIRTUAL_DEV_XFRM_FEATURES;
+#endif
+	netdev_features_t mpls_features = VIRTUAL_DEV_MPLS_FEATURES;
+	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
+	netdev_features_t enc_features = VIRTUAL_DEV_ENC_FEATURES;
+	unsigned short max_header_len = ETH_HLEN;
+	unsigned int tso_max_size = TSO_MAX_SIZE;
+	u16 tso_max_segs = TSO_MAX_SEGS;
+	struct net_device *lower_dev;
+	unsigned short max_headroom;
+	unsigned short max_tailroom;
+	struct list_head *iter;
+
+	mpls_features = netdev_base_features(mpls_features);
+	vlan_features = netdev_base_features(vlan_features);
+	enc_features = netdev_base_features(enc_features);
+
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		gso_partial_features = netdev_increment_features(gso_partial_features,
+								 lower_dev->gso_partial_features,
+								 VIRTUAL_DEV_GSO_PARTIAL_FEATURES);
+
+		vlan_features = netdev_increment_features(vlan_features,
+							  lower_dev->vlan_features,
+							  VIRTUAL_DEV_VLAN_FEATURES);
+
+		enc_features = netdev_increment_features(enc_features,
+							 lower_dev->hw_enc_features,
+							 VIRTUAL_DEV_ENC_FEATURES);
+
+#ifdef CONFIG_XFRM_OFFLOAD
+		xfrm_features = netdev_increment_features(xfrm_features,
+							  lower_dev->hw_enc_features,
+							  VIRTUAL_DEV_XFRM_FEATURES);
+#endif
+
+		mpls_features = netdev_increment_features(mpls_features,
+							  lower_dev->mpls_features,
+							  VIRTUAL_DEV_MPLS_FEATURES);
+
+		dst_release_flag &= lower_dev->priv_flags;
+
+		if (update_header) {
+			max_header_len = max_t(unsigned short, max_header_len,
+					lower_dev->hard_header_len);
+			max_headroom = max_t(unsigned short, max_headroom,
+					lower_dev->needed_headroom);
+			max_tailroom = max_t(unsigned short, max_tailroom,
+					lower_dev->needed_tailroom);
+		}
+
+		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
+		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
+	}
+
+	dev->gso_partial_features = gso_partial_features;
+	dev->vlan_features = vlan_features;
+	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+				    NETIF_F_HW_VLAN_CTAG_TX |
+				    NETIF_F_HW_VLAN_STAG_TX;
+#ifdef CONFIG_XFRM_OFFLOAD
+	dev->hw_enc_features |= xfrm_features;
+#endif
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
+EXPORT_SYMBOL(netdev_compute_features_from_lowers);
+
 static struct hlist_head * __net_init netdev_create_hash(void)
 {
 	int i;
-- 
2.50.1


