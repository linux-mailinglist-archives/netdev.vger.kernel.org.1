Return-Path: <netdev+bounces-126385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F249970F9A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096102834CA
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6931B29A0;
	Mon,  9 Sep 2024 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzSR0EPW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7661B012B;
	Mon,  9 Sep 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866614; cv=none; b=eijBb7Mt2ERPUEBp+Ufxaq5rhYcVfZqi7K9OVjbfi1LGZB7DdfuVNuFGr/kkadIfNcbIuuU9gKuSpjlNf3FxJFCGyCmNVzXPmKqof5L1rlQyY+bRRO7jfVih+6teSbKSVYkuTzld4GTL3gYPj5ApLW6YTiOhAF1Rurw/9KCX/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866614; c=relaxed/simple;
	bh=1Qy23l5ssKeKkewft6Dohq7iX8iCWlOdllvRz1XBS8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z8rnImh3wn4IhzuKS4aCqB0dbkw4nWNaXIuiFqoyBhIMI9k7V29xjMs+BXd72QoaH+kqTQey5UKF76z6nAotn9IoWH/pXI4or5aVRedL8aQyER4IiMCyQlYQKPb4IEFr67ZbSX3t7cWYh76g24WMCLfVv0gDI9Nc6eApuIaRqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzSR0EPW; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-718d79fb6f7so2239231b3a.3;
        Mon, 09 Sep 2024 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866612; x=1726471412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlvfeid9Q1xCebGaSBORoDLqRZBLxsFNr9K+AKcG+yo=;
        b=DzSR0EPWpbKXGcfzLPMYNcrvXI05P116CSi4Yk37q3wTBYatTANrFdNvQstcBO38Im
         zsrNkb/tSD+LsB//CwHTtGlyYkfwTn6GuPQi9VHoHc2+/RIme7Iz0bRbhgfCFr3R+jeZ
         xCmTqy1qVUlHSczQwVXsIqlSogxCocI+CvmbADffqJKq6m4tcFUPESg4iMWSliy8eXf7
         367rMeoN7i3ONrv6r8EeS0zTQNMJiZBqiIzFUhPoMZJLYeqc7UVQUNNra4B20AdVgKqH
         chReLq12nmTuaVp9QE6OyKEw2aW3YEg2GjUND4gOtVUYYR817S0LmcrcImydPfpc3mWh
         Yv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866612; x=1726471412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlvfeid9Q1xCebGaSBORoDLqRZBLxsFNr9K+AKcG+yo=;
        b=JO0iBYb9eF1TTG0evKq14BSjlu+vmsyi+8DBI37kWVsiZuj42fA+j0MfkIvSmB6IgT
         OAeobwcMfFzCmNmwVU+ulfR+KskScc4QTkjdYTvr6Rky0euzM8fGbWYUaNSgvQ4wMJ34
         trG91+8kTKabCg0ZIxuzJTuHXv7uBlV5Cfakmwx4QAevNWt0A8i4UBdue3zyeX1OkTB+
         gsoIzPoX8hulbnl+FiTr09XBBb4Rp51It4BrH2cWGjvkP2dUrPuvmRzItVFJ8Q7Fv72M
         jL0CWcV1/LbZclOfk30qnVeydScveU8GOLl42VrENuUCRdfAerh8meS1wQMXXdhoSf6R
         QH8A==
X-Forwarded-Encrypted: i=1; AJvYcCVc82Zzxzm0xGiK7QMyrDbe8MJxyDDptGljfIjnlc0xFMT3xXqeMbPj5qR+gXnb+VqF3DTt7nVb@vger.kernel.org, AJvYcCWfMRg/e9Ebug/sfibcrGUN8ZnYmy1ijXZEDpw3yorTZGBbOopzZaR3oFnVYdEvWP2mRtZn7EpxdSzDwkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/IJEkmwJpUY+pMLAfXU7bNe1tbVQ1FkGaDftFkWG9OLrRVPB
	rsmsyD075TeqZdDoz7d8qMOlgfRTZAM2ETMBCTq6drP+W08PxYVD
X-Google-Smtp-Source: AGHT+IErFuqI1lzKsH4+ypSIWJI5pKlNKnYY9F6d5Bbd14Qf/s1TVOkAjiv4ZH6vzCnPMXyV+fOGzg==
X-Received: by 2002:aa7:88c8:0:b0:714:2cea:1473 with SMTP id d2e1a72fcca58-718d5f12932mr8319643b3a.23.1725866612086;
        Mon, 09 Sep 2024 00:23:32 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:23:31 -0700 (PDT)
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
Subject: [PATCH net-next v3 06/12] net: vxlan: make vxlan_snoop() return drop reasons
Date: Mon,  9 Sep 2024 15:16:46 +0800
Message-Id: <20240909071652.3349294-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
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
 drivers/net/vxlan/vxlan_core.c | 17 +++++++++--------
 include/net/dropreason-core.h  |  9 +++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 03c82c945b33..2ba25be78ac9 100644
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
+		return SKB_DROP_REASON_VXLAN_INVALID_SMAC;
 
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
index 98259d2b3e92..1b9ec4a49c38 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -94,6 +94,8 @@
 	FN(TC_RECLASSIFY_LOOP)		\
 	FN(VXLAN_INVALID_HDR)		\
 	FN(VXLAN_VNI_NOT_FOUND)		\
+	FN(VXLAN_INVALID_SMAC)		\
+	FN(VXLAN_ENTRY_EXISTS)		\
 	FN(IP_TUNNEL_ECN)		\
 	FNe(MAX)
 
@@ -429,6 +431,13 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_VXLAN_INVALID_HDR,
 	/** @SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND: no VXLAN device found for VNI */
 	SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND,
+	/** @SKB_DROP_REASON_VXLAN_INVALID_SMAC: source mac is invalid */
+	SKB_DROP_REASON_VXLAN_INVALID_SMAC,
+	/**
+	 * @SKB_DROP_REASON_VXLAN_ENTRY_EXISTS: trying to migrate a static
+	 * entry or an entry pointing to a nexthop.
+	 */
+	SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
 	/**
 	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
-- 
2.39.2


