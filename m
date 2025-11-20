Return-Path: <netdev+bounces-240535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3DBC75FF7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 20:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0808B34650F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 19:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977A1347BB4;
	Thu, 20 Nov 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxqdVQAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0199C2E88A1
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665402; cv=none; b=Dt+YoDRkZa1BZmtaO8TrPWMDXE+EU3wKx1Vm2bcejJ0Ry73pOifEr999+55/8ODEfesfZ0xrHqYxgPMHaiMdUtp9+h7c7xgPifCPqyEecP8tX3UKnde8Vbyoqwwn/sMEnwS0jXUqDh+SMV1YmNO7h+xwtM9YaabkiTUesYb8Nrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665402; c=relaxed/simple;
	bh=6gFrKCbAcy6kRd8XiSw3F2iI7S8yL0YFLmNjHC9x6TY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=J0Xgn74DcMDMC8CzvhVJjO5ie6TBVo7ohtgpEx/z8l3Wcau8gOKU6eKGn5zdnhSUfzQ0UNbCkvh7y+FxEOVKbP9XFrLR/GDcWU1KOZICGhsLPSrNrWSKa67p0eqV9JmPxOM4Vw3FGj1FuYshxeRm84f89qbBTzWGZd7divRTb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxqdVQAr; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-343806688c5so1099125a91.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 11:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763665400; x=1764270200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiXBoIlfkxgy5K5gOmytq6h3l2fPtBb4gN5snMvR0ac=;
        b=XxqdVQAr/Dmtul6u27HUJLf3LJfJ+RwUksUA27CFxvqT8Kw0/H4QwzwtxHUdmWQ7KC
         mKBzhvV8YQ7bMu2lRYyiYUlxdpxF0kiSVafp2RMV5JU45pc0pTwjIqSPG2TaV2tAnd5G
         vv0CVgGbeAeZ45RIgGHTukfT2cbuzhKIvaLayNy3hfFAtSdY8wEehPjbus1fdZ58zVsq
         /x7lFLj8E67MMCcUhcHsXt08HZndaV+x4gKeJsuV66865Nxb3O7T1T4Sv3bDEVawy88a
         a2xd27cG57WG6hVBRrwS8kKvumamqTjiU2d0RQ+kLEiYm5Zy5/HxdhksSCgxUsMMWVMv
         6CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763665400; x=1764270200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiXBoIlfkxgy5K5gOmytq6h3l2fPtBb4gN5snMvR0ac=;
        b=Awld/9LJ/hB0uMjsfn8iIGvbBei6sqvxVJLnYuiqSI6ZEo9BjxIdxbcpMZY0ITP3GS
         E+Adzju76Ty2+ca3iuy0hjEbwdV2Vt7FUp9tTDzUkVcMJY7eJdzzCMIdZhQzJMQTyBff
         KwdJod82lKeL2dwHoPo7c7l9bXFz+kaJdWex7ps0ofX0boTBRHD3NfN48tXVr19M+mI1
         cGiJQdM/Ri0DxIWwQJ/09oLIQLCAWqTGSePWArPMcJUeoNpHtJLkhxOYzMiIavYDJVz6
         Pb4MYiy9nB2CBKMOHxQHFgE9Gn9a9j9TmiMEnsN53PgqQrQrjwq030uWHMXwYmcqW0ah
         J4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVHTC6wQP1G4sLUIwi5N+b+w6nAruNpjiTsOm0O2j4YmPrsl+qtpkvlNOWLhPSigEY5BA0FLbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcLLC1zLcqa4uwSjWvctXXLqkwzKDPoPeyAjRDAw+pfNwzdQNT
	5OCq+NXdEs4yxWWBho/Viq0tbHG/DJ3NW4yCDtlzOlWuBurYTDFGja/A
X-Gm-Gg: ASbGncv+Ddm7ePUWxebHPHB0vbW36hK7V2GxYzW9mQM6YMhH94tvxUZz2d9dPaHufaw
	JUOX1A58SD42Y6AJqWZyrEXee51n2WBhkWFZjqM649tNA6oOsM2h/gtG6FXgL6gGrHTRdRftM46
	RvRoBWFyH6OGlvZa5zJ/gNHQZa0Nuh1EDSOFRCMKFj3Gb9zkyWZ4uubEEXvZ/Esa7yT6gG13IYO
	Hc8FE8ullPrxSOQn8zFCqGNdG17n1DDBilkzeQp0D4TTuNCPRR/pwYp8PYW9IWQutZ7LN3Ff7uf
	yRKwiXST3gbCjYyYm09In14x1XK/p64/bS0ANnhZfeIlsQI6JZefNLwXt21aa44LbpLlxjQf5yA
	SatOZRBP+twLGdKK12IoCooBw40X/GfVqQu3NijfdOoVAHyT7UcHZjmOgaGnu4dIsXVCCRAmcc4
	UDiwBsVBpzTKs3AWnDM5GI7B6/GmEob2oD
X-Google-Smtp-Source: AGHT+IH+rToo7xjeD/PPsygp3QyoAUPViKx7avW5w7J+Cl5H4zTAIzrSTK7efMTmKY+A0Aef+n2fZg==
X-Received: by 2002:a17:90b:4d88:b0:340:2a18:1536 with SMTP id 98e67ed59e1d1-34727d70d00mr4417773a91.25.1763665399994;
        Thu, 20 Nov 2025 11:03:19 -0800 (PST)
Received: from LAPTOP-PN4ROLEJ.localdomain ([222.191.246.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b03971fcsm4934849a91.5.2025.11.20.11.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:03:19 -0800 (PST)
From: Slavin Liu <slavin452@gmail.com>
To: horms@verge.net.au,
	ja@ssi.bg
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH net] ipvs: fix ipv4 null-ptr-deref in route error path
Date: Fri, 21 Nov 2025 03:03:13 +0800
Message-Id: <20251120190313.1051-1-slavin452@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The IPv4 code path in __ip_vs_get_out_rt() calls dst_link_failure()
without ensuring skb->dev is set, leading to a NULL pointer dereference
in fib_compute_spec_dst() when ipv4_link_failure() attempts to send
ICMP destination unreachable messages.

The bug was introduced in commit 4115ded13164 ("ipvs: consolidate all
dst checks on transmit in one place") which added the err_unreach error
path with a dst_link_failure(skb) call to both __ip_vs_get_out_rt() and
__ip_vs_get_out_rt_v6(). The IPv6 version was subsequently fixed by
commit 326bf17ea5d4 ("ipvs: fix ipv6 route unreach panic"), but the
fix was never applied to the IPv4 code path.

The crash occurs when:
1. IPVS processes a packet in NAT mode with a misconfigured destination
2. Route lookup fails in __ip_vs_get_out_rt() before establishing a route
3. The error path calls dst_link_failure(skb) with skb->dev == NULL
4. ipv4_link_failure() → ipv4_send_dest_unreach() →
   __ip_options_compile() → fib_compute_spec_dst()
5. fib_compute_spec_dst() dereferences NULL skb->dev

Apply the same fix used for IPv6: set skb->dev from skb_dst(skb)->dev
before calling dst_link_failure().

KASAN: null-ptr-deref in range [0x0000000000000328-0x000000000000032f]
CPU: 1 PID: 12732 Comm: syz.1.3469 Not tainted 6.6.114 #2
RIP: 0010:__in_dev_get_rcu include/linux/inetdevice.h:233
RIP: 0010:fib_compute_spec_dst+0x17a/0x9f0 net/ipv4/fib_frontend.c:285
Call Trace:
  <TASK>
  spec_dst_fill net/ipv4/ip_options.c:232
  spec_dst_fill net/ipv4/ip_options.c:229
  __ip_options_compile+0x13a1/0x17d0 net/ipv4/ip_options.c:330
  ipv4_send_dest_unreach net/ipv4/route.c:1252
  ipv4_link_failure+0x702/0xb80 net/ipv4/route.c:1265
  dst_link_failure include/net/dst.h:437
  __ip_vs_get_out_rt+0x15fd/0x19e0 net/netfilter/ipvs/ip_vs_xmit.c:412
  ip_vs_nat_xmit+0x1d8/0xc80 net/netfilter/ipvs/ip_vs_xmit.c:764

Fixes: 4115ded13164 ("ipvs: consolidate all dst checks on transmit in one place")
Signed-off-by: Slavin Liu <slavin452@gmail.com>
---
 net/netfilter/ipvs/ip_vs_xmit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 95af252b2939..618fbe1240b5 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -409,6 +409,9 @@ __ip_vs_get_out_rt(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 	return -1;
 
 err_unreach:
+	if (!skb->dev)
+		skb->dev = skb_dst(skb)->dev;
+
 	dst_link_failure(skb);
 	return -1;
 }
-- 
2.43.0


