Return-Path: <netdev+bounces-166024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F57AA33F5D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E17B7A2FDC
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054D23A99D;
	Thu, 13 Feb 2025 12:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A341221735;
	Thu, 13 Feb 2025 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450582; cv=none; b=oHHhtsMxIKqokx3+i2KQWQcWLNWMZI9OLdYVczXAx3R6NIeHsx99BFSyCoVHOkoQIYCLapSjSiwtIBOUbtFdxGs2Uk4+FHjbrU3HTXyu93ZTCIZw78bzzUAF3/csNW4lh3YzHHgGPC15bv3HOLGpKkviOEiBpIEPK6kQysrkYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450582; c=relaxed/simple;
	bh=3pma+BrFPlIdrBIvQwZVmV7DCgLXxG/0rRTk4CsT/Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZ+RZE0i2FOfh0p7fKQyYY6YxRv8uy6aLYjB/tpsLDINkIEkYBNgr2KqjzU302UN06fNU4DXLjv2uoWfUFwXAWEsKEPV1QIdI5vYnrmol6JBBkq9s/b/U+ZRHmc8nInqtl+/jHe5N0odECMUFfD4hT6EbyPgAox19cvBoSei+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaec111762bso167212566b.2;
        Thu, 13 Feb 2025 04:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450579; x=1740055379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0y+AufEj80dUW2NVFeJuaDteTVuYPqimU4ue0JsmwBc=;
        b=da38TDdNJEIUUmg1aZoRuzMpRFMG5z3B+jz5wIfOJSUK5+qeFpDxoxYZE08jFBHiKk
         pc1NbK4HtjUDaDjA8tvwYZN1D3hOciIUa0cop8XPVTWBdhjlxttLhtVnnQwwEZop5H6g
         Z8eRU4DS7zmpGHKv0jK5qRgtsjcb/mH+jCRHWx7nZ1pPjo88Y8L5yuV3xbqx0IGeXh0s
         Eyo+2IqW9imXWSKOsY5Tno40copCL3QtkqqHEe9er5rm/p7B8tctCn8VsiZBDWfma4V0
         8SuRvAF7FTl7pQcQ4dkpXyF/O5WRke3B0vePSYRf0aZE6BJSGoU8hGUrOe3KroNQRoub
         pQeg==
X-Forwarded-Encrypted: i=1; AJvYcCU3pb1HIvbjCoQ/LDvCzZuClODra1+iDSeeMqzimdWUEnhDT7j4pvEPM7oWPwr9xDQVTX7cFtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2TFYb2+rF8hExYiu/jxZW6IS011URrDvrHjvwUAhguqYEb5m
	sGSefPndLc+BXQKHy2O3rKhuJmD3klhHIBTJS197mdYQJl/ZAMjA
X-Gm-Gg: ASbGncuxO5TpOPMRnZSM3Yw64skYP1ialSCYQLVcDg79l8ALLjJwMgWcZWIsXdJ0wmu
	qoOD5LEHkySZZ9IfZmN5EPqX5wLrVPoq2VllExkkc21vlG9uwEXd6vksyRcttevgbZ1rAJfzRkq
	ffea3zHgsUCJjd2KiEDZ2j4g4qXXpniHLNCkuIy093c5HzrWRx4GD6yYB/CYP4j5zinSN6hOl55
	xXiiMbge6B3CNlxdIyNGn2LP//dYoE5tjchuVcv5ldbg3LNBWVforTfWXGurkC7K/pXQg1gWLic
	DXyYQQ==
X-Google-Smtp-Source: AGHT+IGsJ9pn1u1Bgh4xEbSVVtu1OZSnB1QwdCwRfVuBjpJ1N4wQWt716mJU9y5l5vDIbMcTOf55sw==
X-Received: by 2002:a17:907:3f8f:b0:aaf:c259:7f6 with SMTP id a640c23a62f3a-ab7f347a782mr773191566b.45.1739450578420;
        Thu, 13 Feb 2025 04:42:58 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d349esm1124501a12.33.2025.02.13.04.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 04:42:57 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 13 Feb 2025 04:42:38 -0800
Subject: [PATCH net v4 2/2] arp: switch to dev_getbyhwaddr() in
 arp_req_set_public()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-arm_fix_selftest-v4-2-26714529a6cf@debian.org>
References: <20250213-arm_fix_selftest-v4-0-26714529a6cf@debian.org>
In-Reply-To: <20250213-arm_fix_selftest-v4-0-26714529a6cf@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, Breno Leitao <leitao@debian.org>, 
 kuniyu@amazon.co.jp, ushankar@purestorage.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=leitao@debian.org;
 h=from:subject:message-id; bh=3pma+BrFPlIdrBIvQwZVmV7DCgLXxG/0rRTk4CsT/Hg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnrejNl5LpnXD/mW2SCZ2tdJf+5Hg5INOim1MSp
 m6w11Hr6EKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ63ozQAKCRA1o5Of/Hh3
 bYvKEACaRpvBlJ382hd/xGCIOWmKZD+A09xab2RS3rfuv58RNYnml37QkhNo4SrvBY8VfdxIjPM
 f5ng6XnzJZOs2pSGmkDaktqmdsWGL0Yc3VyWRLdbrHrNMuAzXqCVObT9ELGjgS/x4S2L/wzh30z
 xYjMddBk0noMIT1Ms4eLKyeRj/8QEe9NaN1Mx6pMk9G5cPEharsuLbI/zB2CKnSDg6b+e+VGD91
 43KXK599JoY8c6t/dapp5x3qCnEhoun9TbQd/Y5MZ8u5RfL9kaPB+wqHYXm/CcKo7GcHoNfx3mC
 LlyHykLMl7sF9N8Ob/cfMtgEaOEkByzq8d5SbopEghpXNMhq0bpjJJKoNoiIsLJ42eUG/j33MD4
 sTuLUUNEOWwKtulKe4Rz9nIVCvYQjx2INoPETX6PhDiVZ6VeJL/uduAx9GOSC6lChR8FbH8mte1
 NxeOA0EmuTG+EWFExJOzM4+c3tAraZKOK9EICtwBdCLvLvqC6REV4akoGRg5NIG/BhKmukiVrcH
 1SNGr/mQmyJo5WTHgAky42CBq11sfZQUQrvteYWXZf+RiAAnazSafsbhKJxDTNAoj3vATz7nr0X
 a5DpdKAHMfqEzmNrX4xqbTJFHPWrT87gweOPyqrXTXsUsC26kVG8xU0excixGe9V8fRhr2knng6
 ickU82LL+t/AKMg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The arp_req_set_public() function is called with the rtnl lock held,
which provides enough synchronization protection. This makes the RCU
variant of dev_getbyhwaddr() unnecessary. Switch to using the simpler
dev_getbyhwaddr() function since we already have the required rtnl
locking.

This change helps maintain consistency in the networking code by using
the appropriate helper function for the existing locking context.

Fixes: 941666c2e3e0 ("net: RCU conversion of dev_getbyhwaddr() and arp_ioctl()")
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/arp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index f23a1ec6694cb2f1bd60f28faa357fcad83c165a..814300eee39de12b959caf225f65d9190594bba9 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1077,7 +1077,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 	__be32 mask = ((struct sockaddr_in *)&r->arp_netmask)->sin_addr.s_addr;
 
 	if (!dev && (r->arp_flags & ATF_COM)) {
-		dev = dev_getbyhwaddr_rcu(net, r->arp_ha.sa_family,
+		dev = dev_getbyhwaddr(net, r->arp_ha.sa_family,
 				      r->arp_ha.sa_data);
 		if (!dev)
 			return -ENODEV;

-- 
2.43.5


