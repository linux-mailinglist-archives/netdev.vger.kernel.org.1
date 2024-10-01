Return-Path: <netdev+bounces-130733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994C898B5B1
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A451C219A2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182881BDA9C;
	Tue,  1 Oct 2024 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHAD/KqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7481BDA9A;
	Tue,  1 Oct 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768115; cv=none; b=sj9nSG5wwG5qI8CSlfjlbozfl3kV5QDEafQyOY+2/PUaO526vdgbMSLWuqmTW/twVmBwyRFodOw4zzkh0u7/tghEYISZj371wWYOu6H/OoNNpdEAOzJ7b+pRRSNyhofJKZ0Dzgtgxdn+zWpt4sx/7oidOsMidN3FTE3SdOZX7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768115; c=relaxed/simple;
	bh=CJC9MvYOXdQ0d17RtkUiHV9XKe1Pb1/kTZG5foooLsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPWoymzQL3M/4W5qC3bZ4cWf4IwDA+w4LNU6BA1uZIjwWMkpGPeN1efftPUNn7SdzhKS5Q6PX+NQegHKEPnxhqikCda9nVrqxVEMTjaiUDQSq1tH/LN3sPzWvCAIxX4k7i0FhcAZLRG8ZeXnJWPYp7sv4ikpKEsI5+7wKEh4+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHAD/KqS; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b95359440so13951095ad.0;
        Tue, 01 Oct 2024 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768113; x=1728372913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcXclLvyDz59q3EjnhNSrg2M+bwjmqEwBneCT75QXx8=;
        b=QHAD/KqSQidGE53jROfC0AC33hUhkzMvLlZo87ytst0mChwbzPGq6BLBDBImdbffaD
         KarYHfj/0Ek6mOSCz17PChPXTTIxpkrI1JdJfBIE2uo+wOCpcSXHoKQeba8VMuenExEb
         CJ/3QxSGW7Mfdvh4/qBz1WJ/6Xmw9rBm/4b6T0BjVyNoaJIusqwX5I4UPG4bri8eB0yi
         NHZZ6IQt+vYos8yvm/kDvkGmMkUJ/QMM4kY0XggbdeK82V6yQ2P7HULQFmd3JL9qnfa3
         G39Y1e5i0jAyp36oNzmZtoYCmSXzTHMMjVlEXRpUQOgKmUP/PXXANKL+q5aWtUasuQbZ
         ob9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768113; x=1728372913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcXclLvyDz59q3EjnhNSrg2M+bwjmqEwBneCT75QXx8=;
        b=Ve7Ovjs5+GbM3SsdvGFJbdHrQt9/Ku8lHTnnlhBtpDX8QetzHUTl3K2pHAeJ5+hj2E
         QM82RjkfCsboOxVEKvr9HCppoQpRIvlpdLaQX9c7l6clY3Catpa62b8tHXTT3cnvBRAc
         b28IF5gZ9g4cbcN6SKDaV5BV9SLm3AVr+q+cY9Si6sWbik6OAxDYfBH5foSSiiRMg98d
         k8MfNzlQnZNm4WRhYpcvWtWdalCndMzxcmsFgaSFrGIrX0HAvIYQ2szaagpnTK4t1zza
         fhsiVciV5nww2aiZ9irzvUUNiJoGgp9mJHdri/Q0RWzvGE4P9FeXDnEf2EpNlyYrMMHd
         vvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt2mb0uXGelA8dRzgflERJ9ZQKMxnlaOgX+d+6IeqnEjKh6ufUTpA5tJk+3DvoUSj/i/wJO6y44SK2ctM=@vger.kernel.org, AJvYcCXbIU9KiBvgwHEcsqyjnM5aK/e5ryQsWyvKKsjwfbcNLZmMPIC8f3Jo6/G0l8cZoPqRoBRDAcQv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw5VAcYRYgTEr734aqjaXocPw6EdBeqrhG+uHSyKjJybiL5rZK
	54kKSxR9pc7KncoQkg5Mepm6xb8Q55neRE5ccA1ys/F39GPQQEV0
X-Google-Smtp-Source: AGHT+IHftE1vTPnFP5mCg4w8S/nnX8TBGa5HEt0rKLCBwvwBvV7rEWJ2iPjfzi82j+q2eT504jHeWQ==
X-Received: by 2002:a17:903:230c:b0:20b:8642:9863 with SMTP id d9443c01a7336-20b86429c9bmr96228725ad.18.1727768112893;
        Tue, 01 Oct 2024 00:35:12 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:35:12 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 06/12] net: vxlan: make vxlan_snoop() return drop reasons
Date: Tue,  1 Oct 2024 15:32:19 +0800
Message-Id: <20241001073225.807419-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001073225.807419-1-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return type of vxlan_snoop() from bool to enum
skb_drop_reason. In this commit, two drop reasons are introduced:

  SKB_DROP_REASON_VXLAN_INVALID_SMAC
  SKB_DROP_REASON_VXLAN_ENTRY_EXISTS

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- rename SKB_DROP_REASON_VXLAN_INVALID_SMAC to
  SKB_DROP_REASON_MAC_INVALID_SOURCE
---
 drivers/net/vxlan/vxlan_core.c | 17 +++++++++--------
 include/net/dropreason-core.h  |  9 +++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 03c82c945b33..09b705a4d1c2 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1437,9 +1437,10 @@ static int vxlan_fdb_get(struct sk_buff *skb,
  * and Tunnel endpoint.
  * Return true if packet is bogus and should be dropped.
  */
-static bool vxlan_snoop(struct net_device *dev,
-			union vxlan_addr *src_ip, const u8 *src_mac,
-			u32 src_ifindex, __be32 vni)
+static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
+					union vxlan_addr *src_ip,
+					const u8 *src_mac, u32 src_ifindex,
+					__be32 vni)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_fdb *f;
@@ -1447,7 +1448,7 @@ static bool vxlan_snoop(struct net_device *dev,
 
 	/* Ignore packets from invalid src-address */
 	if (!is_valid_ether_addr(src_mac))
-		return true;
+		return SKB_DROP_REASON_MAC_INVALID_SOURCE;
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (src_ip->sa.sa_family == AF_INET6 &&
@@ -1461,15 +1462,15 @@ static bool vxlan_snoop(struct net_device *dev,
 
 		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
 			   rdst->remote_ifindex == ifindex))
-			return false;
+			return SKB_NOT_DROPPED_YET;
 
 		/* Don't migrate static entries, drop packets */
 		if (f->state & (NUD_PERMANENT | NUD_NOARP))
-			return true;
+			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
 
 		/* Don't override an fdb with nexthop with a learnt entry */
 		if (rcu_access_pointer(f->nh))
-			return true;
+			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
 
 		if (net_ratelimit())
 			netdev_info(dev,
@@ -1497,7 +1498,7 @@ static bool vxlan_snoop(struct net_device *dev,
 		spin_unlock(&vxlan->hash_lock[hash_index]);
 	}
 
-	return false;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 98259d2b3e92..1cb8d7c953be 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -94,6 +94,8 @@
 	FN(TC_RECLASSIFY_LOOP)		\
 	FN(VXLAN_INVALID_HDR)		\
 	FN(VXLAN_VNI_NOT_FOUND)		\
+	FN(MAC_INVALID_SOURCE)		\
+	FN(VXLAN_ENTRY_EXISTS)		\
 	FN(IP_TUNNEL_ECN)		\
 	FNe(MAX)
 
@@ -429,6 +431,13 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_VXLAN_INVALID_HDR,
 	/** @SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND: no VXLAN device found for VNI */
 	SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND,
+	/** @SKB_DROP_REASON_MAC_INVALID_SOURCE: source mac is invalid */
+	SKB_DROP_REASON_MAC_INVALID_SOURCE,
+	/**
+	 * @SKB_DROP_REASON_VXLAN_ENTRY_EXISTS: trying to migrate a static
+	 * entry or an entry pointing to a nexthop.
+	 */
+	SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
 	/**
 	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
-- 
2.39.5


