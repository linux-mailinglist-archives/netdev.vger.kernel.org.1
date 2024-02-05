Return-Path: <netdev+bounces-69263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E8384A8BC
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF6C1F2E734
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698CC59179;
	Mon,  5 Feb 2024 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0Im4TbO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2211AB809
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169243; cv=none; b=iesDtJvaavgTZl1u1Fhb7C0k614sLeJOOp9+mLR+2bt6CuoU7zYZEjKpHNfx8/ZthZj/Bn8m++dNAO9M0q/bsSxpDhEIdSauKptgK3/R23C8XVpsAZWWHn99aR4Wmjh4xZd0vRorOGmv4hWN3EBELNYxfGKz/bLveOaveUuk3Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169243; c=relaxed/simple;
	bh=4tSVrc3lDD9aUoYxlltfLeAwJNFQSEcmRZdoZavUtrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2a/hItWXJnbSHx9tvP4HBpr/bkokk8RZv/k5joC4akNVR25hRd74FpZ8Wexn2kRXNGtEuA9XZWvYcoXVrruaDjsQ58bGzLj7/Ty2fTUMnmKxDkQ4K0U6W/YBKbmMdeU/SRphPZ8LpoBk6d9uycP8QxY/hI38NBQW7zA4+U2uFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0Im4TbO; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d5206f18so257101276.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 13:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707169240; x=1707774040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8gr/KnM/VeL15b3iiujnM+2BUtml3tCCqm7xonJUZI=;
        b=j0Im4TbOAakpylAV2tFGDiBWJKCdJdKO2Fp1sSbpcLLRkSgO5SMsbGS1+4DVRZSqsv
         KBPY+x3Qu4gZuHW2f9WJWo4DiO2XsoY0YGjcESpjjwRpubJG3AbYW51xr+TghlE2Eg92
         9Uq6nYEAhtylJGEc2xT9KGW+d4yAjMmZetyPs0LncdyMewXdxgbJT0WMMOUU3C4oz+iQ
         ri3kowI+XulPAW4mbkm6V98DI1CWjm4IW0HEM/5LsSbjlk4o9ZvT12lvZrkLUg+kVgbe
         OLel5yTP9qBgN6T+NzF/XrNzrjgHwL5OvbVgFWNuay9vWSLlEFjHM73yFpXKh1gyKvJ2
         LvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707169240; x=1707774040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8gr/KnM/VeL15b3iiujnM+2BUtml3tCCqm7xonJUZI=;
        b=hoC+Lk1E2xYTON2mUsqbiQuURPYRvMhqyDFd9PZ1ux707bD/UHIshZmWsA76NS6NOu
         Qqsl0RZxBpkY0aWM/cQsINdj3SyYtfEnUNMuEU8k18d9Gy5d9CMC1MDAgRaqN6joqTFa
         GRXncZmuO6bqlo3PiHxiVb193s2ja3cvUUVnhQMnUcBTZvhxU0J3aMXl50uSlq1+toYe
         /aUFXipqvVy8T8dtlWRnFx9CanpPqAEwMT4yqdnDwsODM/rvu8bjq8cMx1et7wDVnm4S
         9AgZmFgBq+zIoQ6whgJNLFRdHJiOtULALxMIzeSmltU6ziE7eBw+JAI5lylhtZ94yvSN
         RZSA==
X-Gm-Message-State: AOJu0YygfNGXOCoxcB/u7h9A8RW9ofahiho3sU0rJ3qPxHeYb7WDIXRY
	20cgGJd9Iefx1W7+Dit+nT+nqGXNm2CM31Qw3Yjis7xiR/OAqe8Wx3i2VrnfcJ4=
X-Google-Smtp-Source: AGHT+IHiQftbmH2tt7yabB8Bw/dOeIed9WkrtPfzxSz6vlg71e+AbZgeAaFPFaVTSfBpN52dQSzTyQ==
X-Received: by 2002:a25:664d:0:b0:dc2:40d8:ac5e with SMTP id z13-20020a25664d000000b00dc240d8ac5emr778978ybm.1.1707169240432;
        Mon, 05 Feb 2024 13:40:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWJMGiwnQtxcvPLAIVimyyshiQ4jGyNtADpYAv4OR5eFQrMHuDXraHvKT1eCj4HvZlR8OSqrgwARaX4cnop3aTTFTcoJyM+XQyBnNsTrnJs35xvb0+AqyWmb32jJ83TKYduthzWIuIGFcyTGMM3Ic6qFvDzDhYoWa+GV2Mljd5HIXtUUOPDdTM0OGCNQRRZLo4nj0h5c4okOO0GM+ubptsR4o8tR6GBVNmyY7vDKPyAn5H73kgQm1s3p/R7GYWqYbnd5I6pS6PW+D9L/t4+fKg7hy3khKHjIoRZe3S4vhRpuf4PAoKZiunK9iQIT9ekT0k0LXCt+ljYGrz5HLDqvhDEZAp5bS5ouU2tTg==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b69:db05:cad3:f30f])
        by smtp.gmail.com with ESMTPSA id d7-20020a258247000000b00dbf23ca7d82sm160936ybn.63.2024.02.05.13.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:40:40 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v4 1/5] net/ipv6: set expires in rt6_add_dflt_router().
Date: Mon,  5 Feb 2024 13:40:29 -0800
Message-Id: <20240205214033.937814-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205214033.937814-1-thinker.li@gmail.com>
References: <20240205214033.937814-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Pass the duration of a lifetime (in seconds) to the function
rt6_add_dflt_router() so that it can properly set the expiration time.

The function ndisc_router_discovery() is the only one that calls
rt6_add_dflt_router(), and it will later set the expiration time for the
route created by rt6_add_dflt_router(). However, there is a gap of time
between calling rt6_add_dflt_router() and setting the expiration time in
ndisc_router_discovery(). During this period, there is a possibility that a
new route may be removed from the routing table. By setting the correct
expiration time in rt6_add_dflt_router(), we can prevent this from
happening. The reason for setting RTF_EXPIRES in rt6_add_dflt_router() is
to start the Garbage Collection (GC) timer, as it only activates when a
route with RTF_EXPIRES is added to a table.

Suggested-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/net/ip6_route.h | 3 ++-
 net/ipv6/ndisc.c        | 3 ++-
 net/ipv6/route.c        | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 28b065790261..52a51c69aa9d 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -170,7 +170,8 @@ struct fib6_info *rt6_get_dflt_router(struct net *net,
 struct fib6_info *rt6_add_dflt_router(struct net *net,
 				     const struct in6_addr *gwaddr,
 				     struct net_device *dev, unsigned int pref,
-				     u32 defrtr_usr_metric);
+				     u32 defrtr_usr_metric,
+				     int lifetime);
 
 void rt6_purge_dflt_routers(struct net *net);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index a19999b30bc0..a68462668158 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1382,7 +1382,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 			neigh_release(neigh);
 
 		rt = rt6_add_dflt_router(net, &ipv6_hdr(skb)->saddr,
-					 skb->dev, pref, defrtr_usr_metric);
+					 skb->dev, pref, defrtr_usr_metric,
+					 lifetime);
 		if (!rt) {
 			ND_PRINTK(0, err,
 				  "RA: %s failed to add default route\n",
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 63b4c6056582..98abba8f15cd 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4355,7 +4355,8 @@ struct fib6_info *rt6_add_dflt_router(struct net *net,
 				     const struct in6_addr *gwaddr,
 				     struct net_device *dev,
 				     unsigned int pref,
-				     u32 defrtr_usr_metric)
+				     u32 defrtr_usr_metric,
+				     int lifetime)
 {
 	struct fib6_config cfg = {
 		.fc_table	= l3mdev_fib_table(dev) ? : RT6_TABLE_DFLT,
@@ -4368,6 +4369,7 @@ struct fib6_info *rt6_add_dflt_router(struct net *net,
 		.fc_nlinfo.portid = 0,
 		.fc_nlinfo.nlh = NULL,
 		.fc_nlinfo.nl_net = net,
+		.fc_expires = jiffies_to_clock_t(lifetime * HZ),
 	};
 
 	cfg.fc_gateway = *gwaddr;
-- 
2.34.1


