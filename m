Return-Path: <netdev+bounces-133142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFABA99519A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0B21F25EA8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330201DFD9C;
	Tue,  8 Oct 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBRGQV6R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2E1DFE03;
	Tue,  8 Oct 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397486; cv=none; b=Zf4h4S0IJGHWvHPGz3jHvZUydci3W2uO6jUo2knRvCQF/VCBH5LrIfJHe3la5TOu4vPRDhq3A/LN3aBTTs/NYoF5hS/s73P6l7TG0hfajjhP010HWmRNXrWjlUyIkIYAgWWOl3x23HnVR1OF6EEOGDE7qY20AY3zBR+LgHrlRoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397486; c=relaxed/simple;
	bh=4xIH7Aio0f4PBcaIE51Qch3dJo9N/MMWAobYuTWQmmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAVSLjBo5gZsYsYVb8NZpOZ6HYxpoCN4y5OfK2I+FCCgoJ/h3i4JHNn9jfFplpeFBA3/Sf3+feZcSE5PqPZPvTKoXDDrITEC1gftlKC5BZvCN3bKGRJpq+w1QcTVPNdROKir60f8DgCTvYqhkxluUE2oQjXcQbcyRvTCyZ0IAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBRGQV6R; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2e18aa9f06dso4076549a91.0;
        Tue, 08 Oct 2024 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397484; x=1729002284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQoyYqReGxg6xit/tJWU0LNVGXnn5CuHq60bShXa6OE=;
        b=iBRGQV6RzDZ6IpHbHPf6mGSkVVsN8BJQNqy9I5wDmOhTUyEkMYi7tXBGo23LwanlGN
         s4PFHylzhQ8/DpTMxNaUZf0ZO/erF13jsI9OBmJTNxKLLxfQ70IF45RzzQ+t7ZkEmgGQ
         i/5cT86ufZCa7nMtw3lUg802PPF0woVWFWFx5X4X/nn8ZCH0gxent+Kt5qtkg7CR8zsM
         8WxbPMrz0XM8LshDfoeADhjdxgfkztGGXr7NcpWhVhz1vtcZXNQonbsFXvoRjjY0dFDP
         NakccIybXbOPVDb9hnrg1OIpTJrWtsqsE84eEg/A/Vax3vKHGKCW+fLKWCJ4/DsgImBA
         vLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397484; x=1729002284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQoyYqReGxg6xit/tJWU0LNVGXnn5CuHq60bShXa6OE=;
        b=OZZOhl1R+Y4rSPavgCXeuZBeK6Q/EhxVyHTjfQQB++ehcNn3FOZ/4NsvdHuVMfxbMi
         AXOlfFVAeKZVlmyiqjafXnPZmwdsYl4y+uU9HxeF4wmchGKPPl+nWIa9WBVpcRGtvDym
         vi+Mty/vdAQypAO3O/4kUdhyZLPecRmNw1S8yvniHDQGjh0wIp+uka5onDVmqENXnm2Y
         ZvcdkDBaBU6a2tHRGKykL/+u1JZYDrxqiXEAaIJkLyj7Ly8ZfoMFQKCJrbS9Id7+cAQG
         pcApnzSr8+9vjiEYEthE2LYhqNYqMrOAExcwStBoI1VBsIPvwtiCWTW2emte61BFjF0w
         vjWg==
X-Forwarded-Encrypted: i=1; AJvYcCUo1u3Pp50WUS2hvUZLPUZDu1yaJUsOqqQTIi30BH5quJLkLGNUU5RQbeDeDqHc8mUQ6+co9ZLH@vger.kernel.org, AJvYcCW91HE4+Gb1yJh2sNv14LepF6MHxZxY+jpnn/prdYIamV9RNv3eY+Ycp+hLC/Vmeg0l+LpduIc2yzGLKIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1Emp93HAPd6uLztAlmnbjfgk2Qdo3/FMaNOwUlXsNLGC9eKg
	g0CAVhKvsvzaaZ1ffrcr+8LY17rGoOA2YWQZdtZspU+JaQ986izl
X-Google-Smtp-Source: AGHT+IFsKeuviJmC67BERfupvIjcmWh0fjkX6ZNBHS/mw3bApPLGr41y+B7mXbZzVdGy5XSBtUwemQ==
X-Received: by 2002:a17:90a:7442:b0:2e0:a9e8:bb95 with SMTP id 98e67ed59e1d1-2e27dd3c32amr5159501a91.3.1728397483840;
        Tue, 08 Oct 2024 07:24:43 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:24:43 -0700 (PDT)
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
Subject: [PATCH net-next v6 07/12] net: vxlan: make vxlan_set_mac() return drop reasons
Date: Tue,  8 Oct 2024 22:22:55 +0800
Message-Id: <20241008142300.236781-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008142300.236781-1-dongml2@chinatelecom.cn>
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return type of vxlan_set_mac() from bool to enum
skb_drop_reason. In this commit, the drop reason
"SKB_DROP_REASON_LOCAL_MAC" is introduced for the case that the source
mac of the packet is a local mac.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v5:
- modify the document of SKB_DROP_REASON_LOCAL_MAC
v3:
- adjust the call of vxlan_set_mac()
- add SKB_DROP_REASON_LOCAL_MAC
---
 drivers/net/vxlan/vxlan_core.c | 19 ++++++++++---------
 include/net/dropreason-core.h  |  6 ++++++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1a81a3957327..41191a28252a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1609,9 +1609,9 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
 }
 
-static bool vxlan_set_mac(struct vxlan_dev *vxlan,
-			  struct vxlan_sock *vs,
-			  struct sk_buff *skb, __be32 vni)
+static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
+					  struct vxlan_sock *vs,
+					  struct sk_buff *skb, __be32 vni)
 {
 	union vxlan_addr saddr;
 	u32 ifindex = skb->dev->ifindex;
@@ -1622,7 +1622,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 
 	/* Ignore packet loops (and multicast echo) */
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
-		return false;
+		return SKB_DROP_REASON_LOCAL_MAC;
 
 	/* Get address from the outer IP header */
 	if (vxlan_get_sk_family(vs) == AF_INET) {
@@ -1635,11 +1635,11 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 #endif
 	}
 
-	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
-	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
-		return false;
+	if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
+		return SKB_NOT_DROPPED_YET;
 
-	return true;
+	return vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source,
+			   ifindex, vni);
 }
 
 static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
@@ -1774,7 +1774,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (!raw_proto) {
-		if (!vxlan_set_mac(vxlan, vs, skb, vni))
+		reason = vxlan_set_mac(vxlan, vs, skb, vni);
+		if (reason)
 			goto drop;
 	} else {
 		skb_reset_mac_header(skb);
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 1cb8d7c953be..fbf92d442c1b 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -97,6 +97,7 @@
 	FN(MAC_INVALID_SOURCE)		\
 	FN(VXLAN_ENTRY_EXISTS)		\
 	FN(IP_TUNNEL_ECN)		\
+	FN(LOCAL_MAC)			\
 	FNe(MAX)
 
 /**
@@ -443,6 +444,11 @@ enum skb_drop_reason {
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
 	 */
 	SKB_DROP_REASON_IP_TUNNEL_ECN,
+	/**
+	 * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
+	 * the MAC address of the local netdev.
+	 */
+	SKB_DROP_REASON_LOCAL_MAC,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
-- 
2.39.5


