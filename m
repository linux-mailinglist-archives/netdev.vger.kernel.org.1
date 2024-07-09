Return-Path: <netdev+bounces-110212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDDF92B521
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1387B284D7D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575FC156899;
	Tue,  9 Jul 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PpyeP+XR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E615664C
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520582; cv=none; b=Khr50JULyQVxuhpME/LTRsQ9TodruomtYCG0Hbvz1wYk4vlkkju72dDI1UfFGzN6dwZ7Rf4wGwOButB+PD5r5zSEu8VdsnB53jsxXcJWmkIeO6cTkJHK0C71mQ+qkk2l3ealGoAlGftwgYnVDH1yyGjdPfZpnfgS3AH8M3D74gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520582; c=relaxed/simple;
	bh=t3ktN30j/Nl4DVQj56HC2jt4SMhpQRaAvmoZWag+v6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lNAsjxPaKdxDcYwYLoe5+8TbYNxAENpSVJsGb7LwVCiCsa/pOUY6w7IMod8dy54mptrxVskf9bn7BcuN2R1GqZeLg8XGKf5Nq7Qh07/no1/QlhJwahx9/w5IORO+nt0zmwsNeLRlLuilfHZuDRe5EgVmcE7KfmXMhRJjRoQz5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PpyeP+XR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb1c918860so39394965ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720520580; x=1721125380; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J49mr4wBfKGvFZpeynG8VWdgsfS1hxcRradZg/Blw3Q=;
        b=PpyeP+XR46AKKMDDx2WIKNtYq7/O+8IuYfiqQHA9Xy13pfFgXAFMgdLOmbbroB/nTI
         /U6My/fks3jQcfwFAxUtnT+J6Vn76OOFCQjCZT/WOLyY+3vttE5Es/qyRomlp0w6ax+4
         CuCvH0h9jt2NEWt2MyC29Rq7X0QJv4Ptjmvps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520580; x=1721125380;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J49mr4wBfKGvFZpeynG8VWdgsfS1hxcRradZg/Blw3Q=;
        b=kD4SRCWb1+xKfz71wmLXmGfgDXz18h0MCJ2vphd5mzlTfz5OAW+/fVyDZhNJPOUub9
         J0Q0LfbND2dpNwTHvlA84hb/nSpubH76ILZdyi3e2qwykKQOyvk7vMv6XJcuxXVab4qY
         4nGlgufhwBoO8KOI2H/bJyN05wjxbtAxPAlzYHCzA20j1jdVsM61lk7bl9tQBbl6ZjkU
         cKNe1sk1qgtUlYr9hbOJrn0lGpGqaPZxBNFOjCthjTMFAiztPEj3ZCcJG+HRRFFAa5Xq
         l+iI9/MMpoLCwLXTV+gEDnNO/OtirKVGmX3pn9FMfXdBGLXsskafhXWH7iP0HvqtPd92
         aMKg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Fs09cz+E9VV59sG5Oo3ClgG0xDMAS3lbGsoz6ZBg8aA49OQPRXD6jlrq/eC57BRVho5oakpZEJ9Pxwa5g8Og2qydB2DU
X-Gm-Message-State: AOJu0YxFqHA6s9OT5C2EdcxWu4VY18vLXAIK5d0xELvmijeEYbxXBV3l
	6C6Cbh6QxXTif8bi4HKcKd6XKU6K8bRCyZbRRn1m/v3w4aEtiY7P4LiyFRSHBA==
X-Google-Smtp-Source: AGHT+IEPjmE2ZBJOuHljYOtyjx3FbXtNj5ugD93oXIW1HDB8Wm1gdFzqPT8AuWCDWbIwUGELOBzAqQ==
X-Received: by 2002:a17:902:f70f:b0:1fa:97ec:3a4 with SMTP id d9443c01a7336-1fbb7fa31ecmr29448905ad.8.1720520580121;
        Tue, 09 Jul 2024 03:23:00 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a11757sm12832525ad.35.2024.07.09.03.22.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2024 03:22:59 -0700 (PDT)
From: Ashwin Kamat <ashwin.kamat@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	davem@davemloft.net,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	florian.fainelli@broadcom.com,
	ajay.kaher@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	tapas.kundu@broadcom.com,
	ashwin.kamat@broadcom.com,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v5.10 1/2] net/ipv6: annotate data-races around cnf.disable_ipv6
Date: Tue,  9 Jul 2024 15:52:49 +0530
Message-Id: <1720520570-9904-2-git-send-email-ashwin.kamat@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720520570-9904-1-git-send-email-ashwin.kamat@broadcom.com>
References: <1720520570-9904-1-git-send-email-ashwin.kamat@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Eric Dumazet <edumazet@google.com>

[Upstream commit d289ab65b89c1d4d88417cb6c03e923f21f95fae]

disable_ipv6 is read locklessly, add appropriate READ_ONCE()
and WRITE_ONCE() annotations.

v2: do not preload net before rtnl_trylock() in
    addrconf_disable_ipv6() (Jiri)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 4db783d68b9b ("ipv6: prevent NULL dereference in ip6_output()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Ashwin: Regenerated the Patch for v5.10]
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
---
 net/ipv6/addrconf.c   | 9 +++++----
 net/ipv6/ip6_input.c  | 2 +-
 net/ipv6/ip6_output.c | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8a6f4cdd5..ac09d4543 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4107,7 +4107,7 @@ static void addrconf_dad_work(struct work_struct *w)
 			if (!ipv6_generate_eui64(addr.s6_addr + 8, idev->dev) &&
 			    ipv6_addr_equal(&ifp->addr, &addr)) {
 				/* DAD failed for link-local based on MAC */
-				idev->cnf.disable_ipv6 = 1;
+				WRITE_ONCE(idev->cnf.disable_ipv6, 1);
 
 				pr_info("%s: IPv6 being disabled!\n",
 					ifp->idev->dev->name);
@@ -6220,7 +6220,8 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 		idev = __in6_dev_get(dev);
 		if (idev) {
 			int changed = (!idev->cnf.disable_ipv6) ^ (!newf);
-			idev->cnf.disable_ipv6 = newf;
+
+			WRITE_ONCE(idev->cnf.disable_ipv6, newf);
 			if (changed)
 				dev_disable_change(idev);
 		}
@@ -6237,7 +6238,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 
 	net = (struct net *)table->extra2;
 	old = *p;
-	*p = newf;
+	WRITE_ONCE(*p, newf);
 
 	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
 		rtnl_unlock();
@@ -6245,7 +6246,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 	}
 
 	if (p == &net->ipv6.devconf_all->disable_ipv6) {
-		net->ipv6.devconf_dflt->disable_ipv6 = newf;
+		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
 		addrconf_disable_change(net, newf);
 	} else if ((!newf) ^ (!old))
 		dev_disable_change((struct inet6_dev *)table->extra1);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 4eb9fbfdc..8cf5b10ee 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -165,7 +165,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	__IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_IN, skb->len);
 
 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL ||
-	    !idev || unlikely(idev->cnf.disable_ipv6)) {
+	    !idev || unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INDISCARDS);
 		goto drop;
 	}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 4126be15e..2b55bf0d3 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -240,7 +240,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	if (unlikely(idev->cnf.disable_ipv6)) {
+	if (unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		kfree_skb(skb);
 		return 0;
-- 
2.45.1


