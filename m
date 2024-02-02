Return-Path: <netdev+bounces-68336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9AA846AA2
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E561F25DF9
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B0B1864D;
	Fri,  2 Feb 2024 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ1QjPWj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791717C6C
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862138; cv=none; b=iUwHKc3vah3p5bM69qz0Qnzm298a/9J9zKpxS/QFPqjfmnI9cjMiOWr4mGzlh4NgIvkKaRRTFq+n99MSeuZb5C5MZr27TP7qu/HH711loRBduJE73/VL4c9qM+IZziNhDjk5ftbPBbLgVV+KhXBRaEXWVmVRJ4ConM10LX4sIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862138; c=relaxed/simple;
	bh=9Q7dIWO/up+Z+zGT7zjSYYeM+tBMW5qlYmi941jKS2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DL4+UWmEz8Horva+qNPrd2LLR87PUTJuqWmG7T57WyUX8Rne+4m8eOmW2a+Y+p5v+OPBJkK9A83YNtiv6Dw80kemJb4XYr22voivcaJOwaNPaxTvX1UCkFGka2Uh4IjhB8Ctu/E02dhKZTSth4/Z7ZPIqAbbWBfiqJ823RusQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ1QjPWj; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6002317a427so16603287b3.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 00:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706862135; x=1707466935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPABcs344aIEO6XlzzqYh/8aI4dOCp92Q8NZDEsORFE=;
        b=TJ1QjPWj8NFAkazHWUekFrAtPyjJHdqrWQQeVO4AnBn7zazAGfACOq+4QhfJ8iEqo9
         J8MrpSC/pgE6yT6wUEI8pqo6d13Wgu5t6r7KI9mdWoJ2ZyEl64UwbWicmAHpeCxVqJlc
         91Syw4EHnT1I6BrPzlgEpCHx/5KGi1jUjlXJ9LWp99JUuulfEi9/Kn/kT2oepTZfoRdB
         O1/rZ518rkUOdLdS5d2jkMqCwLue/mfF5WjvXYkjkQ96nu+S1Juwkou5VeUQGVZAzYo8
         iTjljL5WthnU533rjDpqBY67LSgCsRZqk9cEieoJiCUVMwEoXmHbm59/deeZvXFK6sZ3
         dGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706862135; x=1707466935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPABcs344aIEO6XlzzqYh/8aI4dOCp92Q8NZDEsORFE=;
        b=rfZexT/mdjqsxvWWfGKrGO3cVwKVI7Ci4ze5/2CNhS0NdujU77Aw+8/UuCZgc4bVdy
         a0vDwC/ItKbvMgv6wymu6REqkUKB0lqn0n7PsjOehEPO/if7tItg3hiozPMPF3QbRmEF
         bd7w0Jz/gLJSdlgrR4OLLIxeNftQPy8n2V97iEpt6cRr15DC9Fgg/7S2byHPyyyoz9EK
         rwPcLIWXiEmEHhwJGVnr3CfsmsfdFbsYmRiCQqSha9PZxcgt9ExJXBn+5BhL3skU3gI+
         8DIalvt2l7JcKFtHQO6zyXw/tJnx/ZsEJF+uHF/XJTBzkik1pc1XZFzSJRGucb9pj9bi
         n96w==
X-Gm-Message-State: AOJu0Yz8y4JGq2148rfH7UZjbGMcqE9AaH3uZCp5Pl9khkCWxxI5Un7w
	NrKNE+syRXqU0DiU9lVQ5qiI9V328Kfhfu3Hj4U8qvR0EtJeG1cZZqWsaaJPGDU=
X-Google-Smtp-Source: AGHT+IFUvVFVsmXs5THFD7rRdiArCigOzSIlki9YF0ufx8LgzMZ4Ejq8SGm/wF8bxTFCmBrmbeC1Pg==
X-Received: by 2002:a81:bd13:0:b0:603:ebf7:947b with SMTP id b19-20020a81bd13000000b00603ebf7947bmr7929045ywi.48.1706862135626;
        Fri, 02 Feb 2024 00:22:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVI/3UlVCLp8CP32aobTXwyL7LN5jBG4GZnwvU5MSmXBoEFJaNI9nQwAnf3lBwf1G1SAseIQOTZ4ERjUd6CYebLVabW1OoTYZcY0xGR+JiqL/Fty2az3oEWXO5kRyoikzcFlFIwhPBwAnmg46mPtRaSOg9/ixoVpCNIw6+cuvHjHbh2EP8mSQsz+21uWPJqVEsRzJ1DDRcVOStak6I5Oj5QfwIB3H5SvLoW6lWXgdi1k5x/oxmzE2rK6rtQX70xYkmEDyNpKd9lOXCP8BHwjnyNw9NLbh0015BwZj7VgEpJ/HQ62IAZzuU4z4LyPl3CymiUBZKqI2qIa5yoLkdANc6uk9AosnuuqtGSgQ==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1486:7aa6:39a6:4840])
        by smtp.gmail.com with ESMTPSA id w16-20020a81a210000000b0060022aff36dsm299679ywg.107.2024.02.02.00.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:22:15 -0800 (PST)
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
Subject: [PATCH net-next v3 1/5] net/ipv6: set expires in rt6_add_dflt_router().
Date: Fri,  2 Feb 2024 00:21:56 -0800
Message-Id: <20240202082200.227031-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202082200.227031-1-thinker.li@gmail.com>
References: <20240202082200.227031-1-thinker.li@gmail.com>
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


