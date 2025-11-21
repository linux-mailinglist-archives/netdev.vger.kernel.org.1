Return-Path: <netdev+bounces-240701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 088F9C78011
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E17D035FA96
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89A33CE84;
	Fri, 21 Nov 2025 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zbx1jdKw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA4305E27
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715245; cv=none; b=PeX0gGzjMUgODAUDFrUwOJutU4VxWtQTjnPsOvwyoLfWkwlqdufrUjPuP6eznTFrVPxY/6iJOPBxnXRxYlz2IQNrDWYNKuROCTuwyD2P+spYZ4AdVHQeR9Kv5mIor4wsDMkTDfPVPr3R0jNDeFOuZZ4cb8I9VZoK1Wp0UoQFQVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715245; c=relaxed/simple;
	bh=5ONFbsYgwaxvG2oaqCIQcvL9nC4rsYPLT1nLoZ6TTT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KG7bNjQk++PlIU1nuFmqomjjrfma83AfnQdKj/13Z7QDQjU09GSJc6aBvYAmBmRs1ERFX+2paip1UAq7LdstCeuji1Jj587XigRyM/5ZrfscglkM4IqmFbNqVIx8rJnXYqqr0GzuJ6YDVC4ZQEau7cUq1qlKS2GgpYDzqz0bCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zbx1jdKw; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2953ad5517dso23068325ad.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763715242; x=1764320042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YTlngMcqbvauGZMeP16vkAvJ48G9EBdsHd/OECzaso=;
        b=Zbx1jdKwIcRoCdE0lCiPAlzIxMwtVnqGA1uuPrjedx2+/x7ndIQu86pRiosD9kOvxE
         +dq6VGNfahgvlJy9im/oeQnO04JQaJQA22nSfqlBW3EM8N4MBqlhtqv4LueaqR4aeazO
         MtxUqbUqNY6bVsWHBeDK1k6uVC4ptlvxt6kn7PDGKfOYpoonec7kvN3+6SRaJ8t9uJFQ
         S+vm3y5DnqoJHijA1osQrl0/KI5oVY/o2XR6rDiIZ1E3eRWyyhy0PIlderEbD4JuEuod
         uoBV9i30RJDhmxc7+5hu/Dj6kXQqHO9G3Fpni6G1Bv3V0Vr2v5KvYUETlC9bG22LRBD5
         ghfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763715242; x=1764320042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/YTlngMcqbvauGZMeP16vkAvJ48G9EBdsHd/OECzaso=;
        b=TyitUa+oBep+WP/xpuob4LVAVGoLSn3P9gUt7rOtzwJnCG26TeZBNwIrTpe0s++rgO
         eXOnZUS+au3+73r/29/6sK+hzmDgVReAyJ5D0mN6xAYiIvDLkhxjJTGUjoVRsEuLo3La
         GBKNb9zY6sb9sWezSB23QtlO/e5BZSO7YxzErHgsV29BxTcK/LJ7FOo8Xc9FAMPEarDV
         RyR5fX5JOuphN6lr+s6SgB3XBYeaU535hOhu3RE8bbsdTOsUjPywp2CM6mJgErojciBa
         lyfgiDyVPJrB/Eq/OjxVonWN3TrOj2lO6d50/p8yEb/l97n6FWrCNfoTOXmVXx2wk0F/
         vy3w==
X-Forwarded-Encrypted: i=1; AJvYcCU5oos30kAWEclETqHtL9qqVoWZW4ZirTJgjQboTQGpxLf+p+bAeYERO2kfYgw0Qm9bo9XVFA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QxTBupARr2NEHJkGYXFuGtmSzAuAe1II9HfHDOEgnAEiOLKI
	uNq8tG6YkrU+NxwwjeVQH8woNYi/BvdncBl9WrhJk2B0RD2w5WQ997Zk
X-Gm-Gg: ASbGncvujZHeDaHIwsDDn7DS3F8bAp+AJJsswB1PUUmvPtjQqSO2t9gEEpO+LsLBhE4
	PMRCybTeJGsDxr2N02WGh0dJ3fQEK07Pp2s4OwSbhVvz8xqSmUI5eh6BV693l2rIVywf5enjs2b
	6gXobCebKI7joBywV0P3Cr69QBZskw9proxvQDxzhLVN6gK2Qce+KzHlDH5pGRL2yyb2R/C8Mh5
	Rx58H3N2heT73bh3JmpPTGJNbBzpSRsfcPi2OYVE+Kw7lcDAUFsIHmb7zg72/sMTTd1aoi9aJC2
	r4fg86WczCiKEuTAigdnS6C9LxQCzpo7IRTWRoPHBJSQMa0w0sithjHiy/dZCpskAJAFgsVDkpn
	GdgY8aKQc2z/KlmyJ97Md3hxQlbb9UltmrToplas6cPkQTZzKY7tnaTbk5g9X9Q3c2MXPAcAuLn
	QeoVNazaIn7NfdL1e7Ozu+5kYAtQHp53s3LVOr/gfiwQ==
X-Google-Smtp-Source: AGHT+IHuu7fePZOfFm1BwV5Mds9oUo/keOxc859jpBRxZdakp53XXkD9VJ9ewpv9IfRTXvYaNE2Pnw==
X-Received: by 2002:a17:903:98f:b0:298:b4f1:37eb with SMTP id d9443c01a7336-29b6be9364fmr21213895ad.10.1763715242052;
        Fri, 21 Nov 2025 00:54:02 -0800 (PST)
Received: from LAPTOP-PN4ROLEJ.localdomain ([221.228.238.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274d39sm49938125ad.77.2025.11.21.00.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:54:01 -0800 (PST)
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
Subject: [PATCH net v2] ipvs: fix ipv4 null-ptr-deref in route error path
Date: Fri, 21 Nov 2025 16:52:13 +0800
Message-Id: <20251121085213.1660-1-slavin452@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120190313.1051-1-slavin452@gmail.com>
References: <20251120190313.1051-1-slavin452@gmail.com>
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

The issue emerged after commit ed0de45a1008 ("ipv4: recompile ip options
in ipv4_link_failure") started calling __ip_options_compile() from
ipv4_link_failure(). This code path eventually calls fib_compute_spec_dst()
which dereferences skb->dev. An attempt was made to fix the NULL skb->dev
dereference in commit 0113d9c9d1cc ("ipv4: fix null-deref in
ipv4_link_failure"), but it only addressed the immediate dev_net(skb->dev)
dereference by using a fallback device. The fix was incomplete because
fib_compute_spec_dst() later in the call chain still accesses skb->dev
directly, which remains NULL when IPVS calls dst_link_failure().

The crash occurs when:
1. IPVS processes a packet in NAT mode with a misconfigured destination
2. Route lookup fails in __ip_vs_get_out_rt() before establishing a route
3. The error path calls dst_link_failure(skb) with skb->dev == NULL
4. ipv4_link_failure() → ipv4_send_dest_unreach() →
   __ip_options_compile() → fib_compute_spec_dst()
5. fib_compute_spec_dst() dereferences NULL skb->dev

Apply the same fix used for IPv6 in commit 326bf17ea5d4 ("ipvs: fix
ipv6 route unreach panic"): set skb->dev from skb_dst(skb)->dev before
calling dst_link_failure().

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

Fixes: ed0de45a1008 ("ipv4: recompile ip options in ipv4_link_failure")
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


