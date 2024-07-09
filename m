Return-Path: <netdev+bounces-110208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D592B505
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5B9B2294F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAEF156875;
	Tue,  9 Jul 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BBBsXsxY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DD215624C
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520399; cv=none; b=lusZl6hNr83wnnXDtyDQ+ZHv+vDVBdAiJ5B39yVJrajbQ+GCpsGQPlYtvIvuWSSH01rPkqSRFYS8RAnEC30ijLpYSUfVtqQDmhZOedVPNK89Xtx2/rNWTG6OvxAa1Z8Of1zZvUuIK78hArldCEk6lZXFm60LvUiCCS3JpGAfw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520399; c=relaxed/simple;
	bh=3+if63iRSqAEU6I5Y3nhD7iFeNlLCM9zqx6XOO3DeGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nMHYVr54jdA1PPIDrtjDqwFMlvf93I0iRCfZE9CSrwrAkAD5JaXzKPZ5ZmAZjtbDRCW9HFgBcXD1GvoYBqX6JKHOxs9kSbNHK4OU1q6fJCP/HHlREdKNrPykW44a9qvOKA0YaeU0BsWQjWDtgsP8FIJRHnHMq46olmZnL1nUha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BBBsXsxY; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7036815bde7so1314547a34.3
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720520397; x=1721125197; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6kRwgy2gxPVHAQf9c/hwWzmj8UvPpQq2+Zt8yqh85MY=;
        b=BBBsXsxYiU8khxbrQ8sRzdoJL8hEpeSb0voGv7WQhrmRycjwRCZH2zlKDSqF/c1O1M
         JbrHC1kAuSUYW9Svjk3IO77xuc6PWpc2DDjeqw/h/WUCK7HA905n4YK+ipA8H99JRF3n
         P6RJpjznme5FLpxaOasozlrcG6lSA2FUIiDYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520397; x=1721125197;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kRwgy2gxPVHAQf9c/hwWzmj8UvPpQq2+Zt8yqh85MY=;
        b=e2QG3fj+r/OU/i/f9pgwVOK5OliXVjJ4lCJq6cHY8crrV+Hxm11ACM58Bs5lnCwH45
         5vhydTSiaI3lPkQdRtvdzGez0u1Plzlj3HHa3ekgk9wb2x+WX5VLRHXpHWju7j3LlCB4
         GrxlhRR7tcB1uqgcE9deDdBuQ1s10Aavg0wKYmF5x72ZNZN6T2X2ApKWFg/hTfUwZJgv
         mn7m6zTy6x7xZkskkeJfxBi3KIMiUmGB7W9CJVbC5HWdWjWIYczvygzcxY+L7fA0BdMA
         G8pPuEUwKt1KB8RZeD67yr5kIQAxR6s+qxPcb33q0UJ75C+Ev+sbcueo1CT3hR3jLovP
         Fjdw==
X-Forwarded-Encrypted: i=1; AJvYcCU/DlCqg2MxngmTtJQaPIIXCIST7TqZpbXaNre39TT4i1peEm2KPlyU8oSPYRKlIRWcyxIoN5d13IhFFvNOWHHRLx7HFqmA
X-Gm-Message-State: AOJu0Yw3ProBWOMLxIyMdGgu+ceLfkW2F8I/bG8tkEbQHvSRu8MO5oXE
	Ouma6XeW0lf+/yZ5ZYVvGDWcfTqhwGI14oiS8DlcaDtK8ToMW+JGtXRUuIV+6A==
X-Google-Smtp-Source: AGHT+IGsxDZQ8bz5yWxr5s3vrF1xH5qsmcVJy37FvwwYluI32DK0QUXio1fVDB9VKHEj5bhPkhb6wA==
X-Received: by 2002:a05:6870:d0cc:b0:259:80dc:13e4 with SMTP id 586e51a60fabf-25eae7cdff9mr1852815fac.10.1720520396607;
        Tue, 09 Jul 2024 03:19:56 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967345sm1426016b3a.112.2024.07.09.03.19.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2024 03:19:56 -0700 (PDT)
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
Subject: [PATCH v5.15 1/2] net/ipv6: annotate data-races around cnf.disable_ipv6
Date: Tue,  9 Jul 2024 15:49:43 +0530
Message-Id: <1720520384-9690-2-git-send-email-ashwin.kamat@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720520384-9690-1-git-send-email-ashwin.kamat@broadcom.com>
References: <1720520384-9690-1-git-send-email-ashwin.kamat@broadcom.com>
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
[Ashwin: Regenerated the Patch for v5.15]
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
---
 net/ipv6/addrconf.c   | 9 +++++----
 net/ipv6/ip6_input.c  | 2 +-
 net/ipv6/ip6_output.c | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index a17e1d744b2d..ba22470b7476 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4131,7 +4131,7 @@ static void addrconf_dad_work(struct work_struct *w)
 			if (!ipv6_generate_eui64(addr.s6_addr + 8, idev->dev) &&
 			    ipv6_addr_equal(&ifp->addr, &addr)) {
 				/* DAD failed for link-local based on MAC */
-				idev->cnf.disable_ipv6 = 1;
+				WRITE_ONCE(idev->cnf.disable_ipv6, 1);
 
 				pr_info("%s: IPv6 being disabled!\n",
 					ifp->idev->dev->name);
@@ -6277,7 +6277,8 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 		idev = __in6_dev_get(dev);
 		if (idev) {
 			int changed = (!idev->cnf.disable_ipv6) ^ (!newf);
-			idev->cnf.disable_ipv6 = newf;
+
+			WRITE_ONCE(idev->cnf.disable_ipv6, newf);
 			if (changed)
 				dev_disable_change(idev);
 		}
@@ -6294,7 +6295,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 
 	net = (struct net *)table->extra2;
 	old = *p;
-	*p = newf;
+	WRITE_ONCE(*p, newf);
 
 	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
 		rtnl_unlock();
@@ -6302,7 +6303,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 	}
 
 	if (p == &net->ipv6.devconf_all->disable_ipv6) {
-		net->ipv6.devconf_dflt->disable_ipv6 = newf;
+		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
 		addrconf_disable_change(net, newf);
 	} else if ((!newf) ^ (!old))
 		dev_disable_change((struct inet6_dev *)table->extra1);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 32071529bfd9..c1c29432367c 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -164,7 +164,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	__IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_IN, skb->len);
 
 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL ||
-	    !idev || unlikely(idev->cnf.disable_ipv6)) {
+	    !idev || unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INDISCARDS);
 		goto drop;
 	}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7205473ba28d..770ee7ffb0d5 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -221,7 +221,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	if (unlikely(idev->cnf.disable_ipv6)) {
+	if (unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		kfree_skb(skb);
 		return 0;
-- 
2.45.1


