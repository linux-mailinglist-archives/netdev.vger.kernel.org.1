Return-Path: <netdev+bounces-188940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502FAAF7B3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74984E2E11
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE8B1F5433;
	Thu,  8 May 2025 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b="O6QgfjUj";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ZeEyxzJn"
X-Original-To: netdev@vger.kernel.org
Received: from e240-11.smtp-out.eu-north-1.amazonses.com (e240-11.smtp-out.eu-north-1.amazonses.com [23.251.240.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682521C8612;
	Thu,  8 May 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746699694; cv=none; b=WvZV1GK4zV4COB2nRebojEL5086eVP/hq+roLwJn6+jkYx7voXFXAU6P1nKrIobBL2U06Bfq4yjccKHoR6RA9bje6F0FS2hmN6ETj/tYvo4sFfxJj64bizYSnqASCaCvIhWyTYOPESeTuuGOFvrakxYeb88UoYOHHXuEetBMurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746699694; c=relaxed/simple;
	bh=/8u1KODPrLFiUyf+6uu0tMV6N9iXNJ4ag3Xpu+q56xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bG8huThZZlSkNHaAhQWFUcuH3X5lwzScY4dFHVpWdKZjx6k9dkhFQRilfaM5S0EPRY8RaJQel2p41ZgxPujj/uKGOWvs2ZeBLR1SwJ6yLwqxn/zZuH80kZhEb09Rpmt2LogYZyVrb5poNDmbtCREVtdnSALMEPZw6y/vSftnkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b=O6QgfjUj; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ZeEyxzJn; arc=none smtp.client-ip=23.251.240.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=iuunfi4kzpbzwuqjzrd5q2mr652n55fx; d=goosey.org; t=1746699690;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type;
	bh=/8u1KODPrLFiUyf+6uu0tMV6N9iXNJ4ag3Xpu+q56xg=;
	b=O6QgfjUjVSYPg/f6j4GfAHcTj4KwgdC2+3bdWtf+MN8INCghYPzJ/LBsZ6pcAx0o
	Mqc8i7LBaR251bpGCfT6irkwIfI6auiBtiMWJKalT6HZN6VkYQUTH4Uk/pWJwWAbzlf
	erm/2nAOcV7rgJonunzrcOcZxislmCicE3iITpyXAbO9IWLzckeoOBbUd87CMSY+ZR6
	qosHllhHoDbOLNLgkOpKCrTsSdKy/FA+RxV4TcJAfEG72JqPA+9i00YrT4rBotzLD/A
	EgB4I2NipEVEEfTNy/4h79Yr9StLX3bnre4bpu7kUXgNMn/6xMcgDy3l+h6Yq2wzGBl
	AgitIjeg6A==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bw45wyq3hkghdoq32obql4uyexcghmc7; d=amazonses.com; t=1746699690;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Feedback-ID;
	bh=/8u1KODPrLFiUyf+6uu0tMV6N9iXNJ4ag3Xpu+q56xg=;
	b=ZeEyxzJnkeMfePQufQmyftio+C4s7MYiA+fQC8gVVSRJWYVdsStKKn2tr2aVvOUK
	Rb6Ee7+fqogSPhIh1NKfuvtGa7XPYIGuliVe9weYYQ4LEAxXx/t+JVmVL8FTLBbNRSB
	B8+WqJ4I6nDVfLvGBCWFPWq/eBKqZSPWCinNIRYk=
X-Forwarded-Encrypted: i=1; AJvYcCUWYYXs7GnM1Pzb541hG/fp1LMgFfz5CYvKHmqB0QZJjY2orlK7l94b7lWEmmfaDpe9d35YxKnjs9BefVA=@vger.kernel.org, AJvYcCXroK05G17PFV3TffcRui1SkSS1kCR0ZNMzQ4dXyP0PRA7qfClXBNp03FteW92W8mc+EeLHVzB1@vger.kernel.org
X-Gm-Message-State: AOJu0YxFt4Vy1ywjcN7tSQzLgAT/sfLEWxsRRbvyd6n3lfYMQdkm33u2
	/SlV4HhmOt9nTmQ+e7HCncVhXruMzZZgt8hSUiCmZPe/D+QusmMbEhC8pMD3rHqZdTpwCKP26X/
	olnuMCTxQWNboqmMfUvQTDKjSZbE=
X-Google-Smtp-Source: AGHT+IEWWHYer6YlrEAMD9KQ9dotaFtd/lyg7ysgb7EU3ezigUEiXVfbU/UizDskSCDrYKfUSKyklj5LGEbbXIqI5Lk=
X-Received: by 2002:a17:90b:3d8c:b0:306:b593:4557 with SMTP id
 98e67ed59e1d1-30aac17a1a7mr10671549a91.4.1746699687895; Thu, 08 May 2025
 03:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvZ6EoGrp9SCvkVKEV0i=NW-7XZmxbmZkmxd8TPFboPTAUF_g@mail.gmail.com>
In-Reply-To: <CADvZ6EoGrp9SCvkVKEV0i=NW-7XZmxbmZkmxd8TPFboPTAUF_g@mail.gmail.com>
From: Ozgur Kara <ozgur@goosey.org>
Date: Thu, 8 May 2025 10:21:30 +0000
X-Gmail-Original-Message-ID: <CADvZ6Eps=cb9Cm_C92UTF6B=umrnnGVsZG+z7H3h2wQy+HXi_g@mail.gmail.com>
X-Gm-Features: ATxdqUE2usigunOejbmaJU3uCvDWQY8558XJ5AlxjSJTsyUQTWJe3cLonnDs6RU
Message-ID: <01100196af6a2191-3abcd0ea-31eb-4cb7-a1a2-ffc925cdbeed-000000@eu-north-1.amazonses.com>
Subject: [PATCH] net: ipv4: Fix destination address determination in flowi4_init_output
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Feedback-ID: ::1.eu-north-1.jZlAFvO9+f8tc21Z4t7ANdAU3Nw/ALd5VHiFFAqIVOg=:AmazonSES
X-SES-Outgoing: 2025.05.08-23.251.240.11

From: Ozgur Karatas <ozgur@goosey.org>

flowi4_init_output() function returns an argument and if opt->srr is
true and opt->faddr is assigned to be checked before opt->faddr is
used but if opt->srr seems to be true and opt->faddr is not set
properly yet.

opt itself will be an incompletely initialized struct and this access
may cause a crash.
* added daddr
* like readability by passing a single daddr argument to
flowi4_init_output() call.

Signed-off-by: Ozgur Karatas <ozgur@goosey.org>

---
 net/ipv4/syncookies.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 5459a78b9809..2ff92d512825 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk,
struct sk_buff *skb)
        struct flowi4 fl4;
        struct rtable *rt;
        __u8 rcv_wscale;
+       __be32 daddr;
        int full_space;
        SKB_DR(reason);

@@ -442,6 +443,17 @@ struct sock *cookie_v4_check(struct sock *sk,
struct sk_buff *skb)
                goto out_free;
        }

+        /* Safely determine destination address considered SRR option.
+         * The flowi4 destination address is derived from opt->faddr
if opt->srr is set.
+         * However IP options are not always present in the skb and
accessing opt->faddr
+         * without validating opt->optlen and opt->srr can lead to
undefined behavior.
+         */
+        if (opt && opt->optlen && opt->srr) {
+                daddr = opt->faddr;
+        } else {
+                daddr = ireq->ir_rmt_addr;
+        }
+
        tcp_ao_syncookie(sk, skb, req, AF_INET);

        /*
@@ -453,7 +465,7 @@ struct sock *cookie_v4_check(struct sock *sk,
struct sk_buff *skb)
        flowi4_init_output(&fl4, ireq->ir_iif, ireq->ir_mark,
                           ip_sock_rt_tos(sk), ip_sock_rt_scope(sk),
                           IPPROTO_TCP, inet_sk_flowi_flags(sk),
-                          opt->srr ? opt->faddr : ireq->ir_rmt_addr,
+                          daddr,
                           ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
        security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
        rt = ip_route_output_key(net, &fl4);
--
2.39.5

