Return-Path: <netdev+bounces-250894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FB3D3976F
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0073530019ED
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66BA31ED66;
	Sun, 18 Jan 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqwhWPO6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB7339857
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768750184; cv=none; b=ZFRZeooB8XM9/e5Xwzn6S1R4XeL13c8VgRX0OT8+wJ147x4obBs1wqw/cX+48oOSjwlMg90rGSgEZvn1+rs7VPzBuYgjPKTK4HPZSRJQ6W92Txx7sIh8Xp4CiScihwEeGKFKJwI5bARfu13GibghBaBy0zDHgkrXQFb8fAIageY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768750184; c=relaxed/simple;
	bh=bShlVpj4pB52s2txpgx0hP1V22Ovxrd/vun45LLiAJ4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pSaN+ZOzUecsQDfvZrkt2UAtACG9PSt//xPUIhsVVh+SvrLmDkBRp6CVomqgzFctOK47SGnW57kl2naibqrm++pi7cIDg5+Px+b6GDiUB4ZBHb5SA+9LrQS86RP48jjsCgPvsfx7+x6YJUt3dwi/+afm1/vedMEFf8cjeeLzfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqwhWPO6; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-648f70e3483so6045925d50.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 07:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768750182; x=1769354982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nIBB0Ti9FT7xMDL0AI4YSly1VfYPMeTn0yKoc96NmF0=;
        b=YqwhWPO6w0gFZWdJ8nqKw0CbSIVH8qLayhVjcPTHXKyMjcQ5StvuSp8oLt1GK3Hnph
         ibUkh2Z4KskJ0vTeYBlJTWlOLTk+u+qZgz/E9eSY8bkNAr4AIFlLh0WR/WMrabPbj5Ws
         tvl42zHkDzMD8+MjPXspSQWkssk0/VIXZJ1iWsyLsF718WXVY3CoYhlsY3tlICNspz4a
         r57xVhkui5Aq0xDIe+o4k8M3PE7WE8wKAIMCu6aZzhpLx6gnoY3uGdLtrMzS1g30sasG
         FTbnoytvLkdXlFmDdPFycXLl5Vg9t+7QdsrGfMCma4NwftwkBYYERPrX+Nqzxb+cLiMl
         Ul3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768750182; x=1769354982;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIBB0Ti9FT7xMDL0AI4YSly1VfYPMeTn0yKoc96NmF0=;
        b=lVdtfqSmvc5z0410N2CsUR60/Z25Mr/B2eNgF4YnWkcCUWhMwAQDlwp3AfhFfR3DG7
         YHmjXJ9CgWfuWZyny1+VBGTuM1iZ3w6HRKWkQZvA72E3D8/+LHXynPoAmIAVm7zTdcUj
         c3BhlLM0hXqW1pmvc7JRmrIqz9Majcm4JmbPSO1Ga5FOTfrjHBLyQCoQE43i9Cxr/G47
         szEqKgB38k0W4G7SKlnFFLi9xLaqtmDQjA8PniDrL0w2gr2n8huvBG2fP3IBMsBke2by
         4mYWjn3RHxHp5N08OiDB4gbwTRwJVN/b1Ok6Q8owSXkW81kC2Aru560E7DAoOvEti4tp
         88UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5RjOFH44vQ/pJN+LQOcaXJfKQxxW/2xEFg6xbCbizIZEx15BznKE4pISKJxHuumsMpnFFmUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfSkPqZMmlRxWNZcBwmBjn5TOF29sUq0CRouHGk6WqWg5rBHok
	2vSZdXBN8DPmd5qkZ215kiIuHsgh6J6GBpEamVms7X0IFudweNEKrx3Vo1qCxZzqdYpmo6nSL0y
	ZNL5tLnVUovxK+w==
X-Received: from yxup2.prod.google.com ([2002:a53:ee82:0:b0:640:d681:9c24])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:bce:b0:645:5207:10ef with SMTP id 956f58d0204a3-6490a605415mr7620793d50.18.1768750182033;
 Sun, 18 Jan 2026 07:29:42 -0800 (PST)
Date: Sun, 18 Jan 2026 15:29:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260118152941.2563857-1-edumazet@google.com>
Subject: [PATCH net] ipv6: annotate data-race in ndisc_router_discovery()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>, Rocco Yue <rocco.yue@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found that ndisc_router_discovery() could read and write
in6_dev->ra_mtu without holding a lock [1]

This looks fine, IFLA_INET6_RA_MTU is best effort.

Add READ_ONCE()/WRITE_ONCE() to document the race.

Note that we might also reject illegal MTU values
(mtu < IPV6_MIN_MTU || mtu > skb->dev->mtu) in a future patch.

[1]
BUG: KCSAN: data-race in ndisc_router_discovery / ndisc_router_discovery

read to 0xffff888119809c20 of 4 bytes by task 25817 on cpu 1:
  ndisc_router_discovery+0x151d/0x1c90 net/ipv6/ndisc.c:1558
  ndisc_rcv+0x2ad/0x3d0 net/ipv6/ndisc.c:1841
  icmpv6_rcv+0xe5a/0x12f0 net/ipv6/icmp.c:989
  ip6_protocol_deliver_rcu+0xb2a/0x10d0 net/ipv6/ip6_input.c:438
  ip6_input_finish+0xf0/0x1d0 net/ipv6/ip6_input.c:489
  NF_HOOK include/linux/netfilter.h:318 [inline]
  ip6_input+0x5e/0x140 net/ipv6/ip6_input.c:500
  ip6_mc_input+0x27c/0x470 net/ipv6/ip6_input.c:590
  dst_input include/net/dst.h:474 [inline]
  ip6_rcv_finish+0x336/0x340 net/ipv6/ip6_input.c:79
...

write to 0xffff888119809c20 of 4 bytes by task 25816 on cpu 0:
  ndisc_router_discovery+0x155a/0x1c90 net/ipv6/ndisc.c:1559
  ndisc_rcv+0x2ad/0x3d0 net/ipv6/ndisc.c:1841
  icmpv6_rcv+0xe5a/0x12f0 net/ipv6/icmp.c:989
  ip6_protocol_deliver_rcu+0xb2a/0x10d0 net/ipv6/ip6_input.c:438
  ip6_input_finish+0xf0/0x1d0 net/ipv6/ip6_input.c:489
  NF_HOOK include/linux/netfilter.h:318 [inline]
  ip6_input+0x5e/0x140 net/ipv6/ip6_input.c:500
  ip6_mc_input+0x27c/0x470 net/ipv6/ip6_input.c:590
  dst_input include/net/dst.h:474 [inline]
  ip6_rcv_finish+0x336/0x340 net/ipv6/ip6_input.c:79
...

value changed: 0x00000000 -> 0xe5400659

Fixes: 49b99da2c9ce ("ipv6: add IFLA_INET6_RA_MTU to expose mtu value")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Rocco Yue <rocco.yue@mediatek.com>
---
 net/ipv6/ndisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 59d17b6f06bfd19f4a5e0457f4f20ce7185894c1..f6a5d8c73af9721741c11b543e5abeecdbf2079f 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1555,8 +1555,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 		memcpy(&n, ((u8 *)(ndopts.nd_opts_mtu+1))+2, sizeof(mtu));
 		mtu = ntohl(n);
 
-		if (in6_dev->ra_mtu != mtu) {
-			in6_dev->ra_mtu = mtu;
+		if (READ_ONCE(in6_dev->ra_mtu) != mtu) {
+			WRITE_ONCE(in6_dev->ra_mtu, mtu);
 			send_ifinfo_notify = true;
 		}
 
-- 
2.52.0.457.g6b5491de43-goog


