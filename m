Return-Path: <netdev+bounces-230286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496FEBE639C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 05:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F99162100B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965BF2EACE0;
	Fri, 17 Oct 2025 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKqUfzo6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE42EAB7E
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672542; cv=none; b=mAcZ28jwZFb9nxJ9e/x/Zsax54OWNMq8gy0Vk8ddtEPDgFwsjluKsDyJ1bBHS65b2qxtjAwxCY28sWXAhWuUy1seirqY/bHq3aWzYUN2HT0rQGFj5+NXykQ57ECUMDEUBwZCi/ghlYA/BuQkw3BbQgjbMMgjdeO8vGjwXKsgFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672542; c=relaxed/simple;
	bh=GAj+Rj3U/iz2aCJlYeL1KvIfh4Se4wq/aFheRKL3Za0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auZEapAfkYRLDW4tBBrvEkdKi4vVuz8wZHdydLjUAxfvcNSyfIu2FrBJdCAwlVxZONI2LmkD2bc5aVdf5IM30/FT8z4/BPrI3fxO6jOR44q4OUPuWCZaJIf0KFbyVyMWhJM4AaMSSyUROxauMYtehmmxpqHAE8XJyST+zOooYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKqUfzo6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eceb38eb1so16792965ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760672540; x=1761277340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIu/AI3rt8eRH0zwke7Amlwg0XvJcRGg+AXdpABIBOw=;
        b=JKqUfzo6trTQH9F1wx7iwonXr8BSagFBKA/xgUK+nGTS0wC3WnucGuItXfFzwpdTQ9
         jc/DA0dWBsyPVeauaEque+XIQ3yiw3Sqt2GC6ryIFI5ZGBWoSQjL8TkMR0YRIOVk2cDi
         nAWiPsVrNUFb1NItYrsEVJGZfUgIatVg4wzmz/6WmuDB0GiHhZm6LIHdGBgkHctspQcu
         W7fVq8etETEEHKSsnpmXApAptgiywlqIpWrPOAPcZFUD7xEWNaag0Fn9iP3IdlGKFq6V
         OEY/yZu0+/hgepL6WTu3XBV1T732/ivY8sZBKPBkU39spDcpunp8BGddgjpRm6i+xsqM
         p5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760672540; x=1761277340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIu/AI3rt8eRH0zwke7Amlwg0XvJcRGg+AXdpABIBOw=;
        b=bPjL/+AWTvpVgJ6d69Nc51RYVhyWYGh4VOSc4v4z2D5nBYajtGT0eXKRwpnqg+OAdo
         d8JH2PP1E6XVRH3EH4o+2uoe3PWYcFMXXbA9Rok20cRcubkjPAV4Ff2qo/+z7KrggwON
         pr6nYVDVKmf3oce1pTa0u5GYpDrlHpPIliOn0wdTeTgSTjE4UYXhzLEyaYyUeu5U5tXn
         FgkYhBn7TLg6W0WafJAjbFC0NHrqv8zwyvOpto5spyfLHeoLk9pPJyIc/0SkWFEf39Nr
         MdR/SIAkKhxGJ6CRAtx0pE2J1PORpN4C8HiH+EK2Mv14RmIJrs55r7Amr8Nt9zC+LS4J
         iR5g==
X-Gm-Message-State: AOJu0Ywhq7RNcaEPP9SR7vEGwIMFWlDRbhNxfI3mJfojhSOFsdO+XIkg
	3Fol6uKSU+ip0hjIw8ynoWRHvuebtFzVKVQycw5/WLgYIYFQ8j4Hrgkqgfn4mhqtFlQ=
X-Gm-Gg: ASbGncuB4xTk7fTGI0UEjSOz/gVkUtQK41PEJ8zJY3qrrO+CTzuFJU5AL6to9OIu9Ix
	CJ19ofMJ2Cpvr2EzRicyECrUTgB2Fp9e84vq8M3yYfQtPyWo3ZkGzkAB8NugQbMDFfVJXb32bVS
	6N7TKXQSRyW3E4WjtI+GI8boofxhqN2v0UUx1QvqZQLQIoy49VTpKIGo2etxN/hc/Ugs313Nmu4
	SShVNreMEj8D7rJx/iA2Q8PAdHZQ4d/qoLrWkR+F3a03bV9snjkYCJuq9lqpunp6OkNHC1H9NBs
	myAaEaFnX0rAKP5WYc4o5ff7wYpfsksNmQ6QDiSgT+JEyz+WgFVVqnbv1wnW9joWMM3k1od18Y8
	PcNHLNdxVZ3MrHx2MISB1+ljL5vNhyY7hkBVVCEj5yH85VW89mcphkzjBO10BTLiOBhgXleNeUb
	40z4ay9sbkUVzTiE0=
X-Google-Smtp-Source: AGHT+IGpVn4CL9wEstHcEqk50p3Ed2u9SXoXAKeRWGfsyYTJjWnCjhRapkAwDqDLLKd5diZb2j0STg==
X-Received: by 2002:a17:902:e841:b0:290:c902:759 with SMTP id d9443c01a7336-290ccab6c0amr19097455ad.51.1760672540170;
        Thu, 16 Oct 2025 20:42:20 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4715sm46695165ad.93.2025.10.16.20.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:42:19 -0700 (PDT)
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
Subject: [PATCHv6 net-next 2/4] bonding: use common function to compute the features
Date: Fri, 17 Oct 2025 03:41:53 +0000
Message-ID: <20251017034155.61990-3-liuhangbin@gmail.com>
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

Use the new functon netdev_compute_master_upper_features() to compute the bonding
features.

Note that bond_compute_features() currently uses bond_for_each_slave()
to traverse the lower devices list, and that is just a macro wrapper of
netdev_for_each_lower_private(). We use similar helper
netdev_for_each_lower_dev() in netdev_compute_master_upper_features() to
iterate the slave device, as there is not need to get the private data.

No functional change intended.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 99 ++-------------------------------
 1 file changed, 4 insertions(+), 95 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4da619210c1f..cd7da6ed8c6b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1468,97 +1468,6 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	return features;
 }
 
-#define BOND_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-				 NETIF_F_GSO_ENCAP_ALL | \
-				 NETIF_F_HIGHDMA | NETIF_F_LRO)
-
-#define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
-				 NETIF_F_GSO_PARTIAL)
-
-#define BOND_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_GSO_SOFTWARE)
-
-#define BOND_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
-
-
-static void bond_compute_features(struct bonding *bond)
-{
-	netdev_features_t gso_partial_features = BOND_GSO_PARTIAL_FEATURES;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
-	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
-	netdev_features_t enc_features  = BOND_ENC_FEATURES;
-#ifdef CONFIG_XFRM_OFFLOAD
-	netdev_features_t xfrm_features  = BOND_XFRM_FEATURES;
-#endif /* CONFIG_XFRM_OFFLOAD */
-	netdev_features_t mpls_features  = BOND_MPLS_FEATURES;
-	struct net_device *bond_dev = bond->dev;
-	struct list_head *iter;
-	struct slave *slave;
-	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int tso_max_size = TSO_MAX_SIZE;
-	u16 tso_max_segs = TSO_MAX_SEGS;
-
-	if (!bond_has_slaves(bond))
-		goto done;
-
-	vlan_features = netdev_base_features(vlan_features);
-	mpls_features = netdev_base_features(mpls_features);
-
-	bond_for_each_slave(bond, slave, iter) {
-		vlan_features = netdev_increment_features(vlan_features,
-			slave->dev->vlan_features, BOND_VLAN_FEATURES);
-
-		enc_features = netdev_increment_features(enc_features,
-							 slave->dev->hw_enc_features,
-							 BOND_ENC_FEATURES);
-
-#ifdef CONFIG_XFRM_OFFLOAD
-		xfrm_features = netdev_increment_features(xfrm_features,
-							  slave->dev->hw_enc_features,
-							  BOND_XFRM_FEATURES);
-#endif /* CONFIG_XFRM_OFFLOAD */
-
-		gso_partial_features = netdev_increment_features(gso_partial_features,
-								 slave->dev->gso_partial_features,
-								 BOND_GSO_PARTIAL_FEATURES);
-
-		mpls_features = netdev_increment_features(mpls_features,
-							  slave->dev->mpls_features,
-							  BOND_MPLS_FEATURES);
-
-		dst_release_flag &= slave->dev->priv_flags;
-		if (slave->dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = slave->dev->hard_header_len;
-
-		tso_max_size = min(tso_max_size, slave->dev->tso_max_size);
-		tso_max_segs = min(tso_max_segs, slave->dev->tso_max_segs);
-	}
-	bond_dev->hard_header_len = max_hard_header_len;
-
-done:
-	bond_dev->gso_partial_features = gso_partial_features;
-	bond_dev->vlan_features = vlan_features;
-	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
-				    NETIF_F_HW_VLAN_CTAG_TX |
-				    NETIF_F_HW_VLAN_STAG_TX;
-#ifdef CONFIG_XFRM_OFFLOAD
-	bond_dev->hw_enc_features |= xfrm_features;
-#endif /* CONFIG_XFRM_OFFLOAD */
-	bond_dev->mpls_features = mpls_features;
-	netif_set_tso_max_segs(bond_dev, tso_max_segs);
-	netif_set_tso_max_size(bond_dev, tso_max_size);
-
-	bond_dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if ((bond_dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
-	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
-		bond_dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-
-	netdev_change_features(bond_dev);
-}
-
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
@@ -2273,7 +2182,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	bond->slave_cnt++;
-	bond_compute_features(bond);
+	netdev_compute_master_upper_features(bond->dev, true);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2525,7 +2434,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	bond_compute_features(bond);
+	netdev_compute_master_upper_features(bond->dev, true);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -4028,7 +3937,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			bond_compute_features(bond);
+			netdev_compute_master_upper_features(bond->dev, true);
 			bond->notifier_ctx = false;
 		}
 		break;
@@ -6011,7 +5920,7 @@ void bond_setup(struct net_device *bond_dev)
 	 * capable
 	 */
 
-	bond_dev->hw_features = BOND_VLAN_FEATURES |
+	bond_dev->hw_features = MASTER_UPPER_DEV_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER |
 				NETIF_F_HW_VLAN_STAG_RX |
-- 
2.50.1


