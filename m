Return-Path: <netdev+bounces-86104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45E089D8E3
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD7228165F
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D412BE8B;
	Tue,  9 Apr 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kpEGDTOH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8767612A14A
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664468; cv=none; b=eCKmc54C4shxSlrkfDb1AiuX/XDTTJmYEqEWZW3ISQP6ajF/uk1rqpgBKSiK/VS+AhgoC2wos72R6IUgWBk+8r/mXaTkkxkzqgYobtQGEWcOiBwmSJ+JAiDjxUcDzpRSHG1NnpPv5GEIGiiCegBig8Y0Pm0A/CwIuSZ+vnZBSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664468; c=relaxed/simple;
	bh=l5l43CTGs4TRsZBMa9+0NJ+7WZiGMwQpgrkBUU52NkU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j4XOaqoQ6e7NRn830vSAovb9K7+IeeU+8NtNc1BsDENvt6kQRkqNTBLyNmmOs96vhwApsovV/7UCjrz/Vno97onten2CqzOLcbRgh7MwVIu+e2l3gn/PCM0v7Gner/RRj8qozooB2boVIFWoOsRzf4xnHMCh+YsNsVsHSlvk6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kpEGDTOH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd933a044baso7819619276.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 05:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712664465; x=1713269265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vwOIo5EyE2gpBidCPc6JSquLxlgRn1jmXrlTCb7YzQ4=;
        b=kpEGDTOHE3i9ppJRxt+fUMH5ipWArbYDIAjAYkwwpAg/957kka3VbOdacX0GqNEbQ3
         lbe5YZeER2mCirizAlYBsEDeTYsOf6Lq8pAWwIHd437JgSnGk3psIbMv0sHNu7oAObuI
         30LsZXhBW6OX7uOjYEvFKOw8uAFoSEESd8/LwKPnCvNjGq3gXpKvibucLWZ0OnhD33Pk
         gwm27VW0z1jfsuDZ7Bf1Qu9VhpWLjR6uRtcUuhE1i2zp4BnxAga5cVTlvsk4GrFbu3L4
         gvQjUnVS89WhC77eKJKaMUTpZ/5WFLdFY4R4FUiHmcejicjC4G10BAKw7Z/DNIVNIUN0
         Sl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712664465; x=1713269265;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwOIo5EyE2gpBidCPc6JSquLxlgRn1jmXrlTCb7YzQ4=;
        b=Ajn2mOOcFMZgyBY9JaHiN7g/POEqNjr1K2HMLZFz04CuJHkpPPXDqCxpwcxSnHAX3+
         n55iqBLBqwZqn971nTUyky6hHiBhMLRIm2Bxnkve9zTeVAbqrImXil66XRAcBgS3niF1
         F7tWY7tjSZNGR0gOV8MozHgeFFngYJVryVQ/C3lCSbfjqbx0TzTKki6mGWSKmPn3RXmN
         o1hFTVNGISFLMkCgbd+e3ytNDKfJSReXy45vWTBTUJc4U4T4TnksmHozXdSxwDqm2R/K
         pzV4V7O6vvNwYEB9TK1+SbFsClOUE5iX7zaxW6XLSg1RaSxmw63fxSvxMaxk/bX8rMG1
         pMbw==
X-Gm-Message-State: AOJu0YzlCdOCiq58MzpWT0RPxJea102kunFa4qJ2ylDJniutz1u+yIDH
	K0N1VE0f7nu1xoTYgGSNOnyj8NqXA+AsL7uD1BIRDb6CcIpH1DG3QdHVQBxytZYl1gjvbdZywjn
	eKFEa6VvyZg==
X-Google-Smtp-Source: AGHT+IEZ/p+1Sye8Qw8C9x1uzuZWJX1qMx0WaJodivY2Y78eM5sjMxJ8ou6KDGiK3e8vkVdFBtHBQYPyhINENg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1001:b0:dc6:e884:2342 with SMTP
 id w1-20020a056902100100b00dc6e8842342mr815876ybt.5.1712664465563; Tue, 09
 Apr 2024 05:07:45 -0700 (PDT)
Date: Tue,  9 Apr 2024 12:07:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409120741.3538135-1-edumazet@google.com>
Subject: [PATCH net] netfilter: complete validation of user input
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

In my recent commit, I missed that do_replace() handlers
use copy_from_sockptr() (which I fixed), followed
by unsafe copy_from_sockptr_offset() calls.

In all functions, we can perform the @optlen validation
before even calling xt_alloc_table_info() with the following
check:

if ((u64)optlen < (u64)tmp.size + sizeof(tmp))
        return -EINVAL;

Fixes: 0c83842df40f ("netfilter: validate user input for expected length")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/netfilter/arp_tables.c | 4 ++++
 net/ipv4/netfilter/ip_tables.c  | 4 ++++
 net/ipv6/netfilter/ip6_tables.c | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index b150c9929b12e86219a55c77da480e0c538b3449..14365b20f1c5c09964dd7024060116737f22cb63 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -966,6 +966,8 @@ static int do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
@@ -1266,6 +1268,8 @@ static int compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 487670759578168c5ff53bce6642898fc41936b3..fe89a056eb06c43743b2d7449e59f4e9360ba223 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1118,6 +1118,8 @@ do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
@@ -1504,6 +1506,8 @@ compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 636b360311c5365fba2330f6ca2f7f1b6dd1363e..131f7bb2110d3a08244c6da40ff9be45a2be711b 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1135,6 +1135,8 @@ do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
@@ -1513,6 +1515,8 @@ compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
-- 
2.44.0.478.gd926399ef9-goog


