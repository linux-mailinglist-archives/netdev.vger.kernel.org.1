Return-Path: <netdev+bounces-203560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370BDAF65C8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6594179C79
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5082F5C45;
	Wed,  2 Jul 2025 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO3XFrff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8152F5C2F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497348; cv=none; b=bIk0b0W7iyKEnc9BQkcxsUkN4n7UK5NhJnhgI0Y1vjlsf9gD0wLXmw26CMj7jlq12/yP3Kd28fKpSwk2duLaA7Ktc6ZHp67a+BSbpRIYYQ2XdXehcgpqp9PMP7AcGeKc7vlPmYi8RV5jVeJJ+t9TVI4DWgF4vZpGro8o4Z6a+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497348; c=relaxed/simple;
	bh=P/lx8ftIT9RHL1V3W21EDvvd5UY/SkUZAEVpvUMDGYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdyMCv+25hdtBDkI3YNlPeQ2dTimd6Oc+PiwrXObb2L+GQx/JZ1EH2LMS4ZeRvnJXHscvfLFyK9LfvR0O1sjUFGxGJ0V3qn0nPajRCy4UEW/+hjUBQbheVw4y5oT12uUlmtuCkU6hHk4TRlau3QmJAhcevf4Fy9V1AqyuqAt5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO3XFrff; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3508961d43so3189547a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497347; x=1752102147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGvza/1L7pXDPwn+rmAX6mrcZXp+cfX3sMg3CMfbHeU=;
        b=aO3XFrffZmeGpZQArmiBvuEdEve/ZRhmaVTeQIZ/Axn3UKVek/w0FD3Slv6l+3UeUl
         fAuX1Frr1x8flvB2o9VQF6TuS/a4PDud0l6GzT1hnp2/OFgFmdOE9yVBHkR9ch4xrIb2
         SUz3zu7cLmbKWRUaL1GN00CJUvN7/VR63SsS0ikJKZi/jZhDU122Tqug84H6EZdZ7qow
         i9c5YN5w2ecv1QsRSALcqLpucEh0Is6Lkjd8cf9OoS9t0lRf3/XoUxQLJUB6OrjWnFqq
         8kANWRLHF1G8AYsq5mn9gy5T6DjFrSgrG/F4jgy9JCU1cha8NEo42s9TbK/zgGbRKevx
         tT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497347; x=1752102147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGvza/1L7pXDPwn+rmAX6mrcZXp+cfX3sMg3CMfbHeU=;
        b=wjd+ukDZWzGGGqW7F0NryKQOK9Z0pInEIWLqAJx5yFh4PS8iFF28Htnfl7IEpIiOnQ
         YCOo0D87EJBh+V+DWURvdupqjmgGzHmSZ9ly23JnJnVlj8reO00zrD+XpdSROuwRSFDk
         8ItWXN/0pHvKi8gVVaXh6m7AemqPaRrDMKcIQubo/PvdGmHNyrQP4W4c629uraBrQpCt
         sIcJVFjJZD60Mdhn0O1QaHskiHD20XazF8Qau0n9ELkq8fPGM2ldFcRYnrk/HHcCp8Vu
         b2z20mG2e9VvhBfbRW//AAePcVBFPfSP4cWqOIpgFb+A1hy0T7RsfndtDfgqwo1B/ytj
         3xMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpHoLU0cXW/soAROPa/bm4d89bWthmmUhBJbOSGa2ZBPnhulh5IVY6B7MdiEZRaGrRBF/j0i4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2xpUYVm0IDP5x91mJRhmpp3FNw3w6cGBV46wo/T/sJD3bpDRr
	DchkuRg3u/kyvbA4mK/XSdSw5yjYpBk5dITbIpP5sJrEcOXnlp+Ko1w=
X-Gm-Gg: ASbGncswA6r4Hs3iz+dMudLKik+dOtZ9csq+BthLX4LDxHM1O0OiY2QUT/kIXTaD/4i
	CajwZEigtFmGzKRrI5fUBrh2uUkDxINmR68ig8TJq+C6Y6XPQdK7WmnMdxwDh/3ANAi/I7YMjpn
	zJptQDX58GYj9yCVtBwPGdYpaJDcMuMefL2eL76/0Kiki63tTbPUsH5+CNyHnODpdpjJBDX7UgH
	TkzmmjAZlgDOamWfgVGxSiLPUyVK4HTtSJIFu0taxVOH2zdvp/lJSI1XHcKjqCZF6r412sgG9bP
	+UdCDkSr6vevwX3D2FU6/AROLhznSTYHjKyY9Xg=
X-Google-Smtp-Source: AGHT+IHjQIUgdqOlbxuOTsAsZn3V5EsJgW4aRtqaaGVYvxX323bK+5iWmnEVBGXwiXqFFMUeJI/mmQ==
X-Received: by 2002:a17:90a:fc8c:b0:312:e744:5b76 with SMTP id 98e67ed59e1d1-31a9d64e47dmr1206118a91.33.1751497346728;
        Wed, 02 Jul 2025 16:02:26 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:26 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next 10/15] ipv6: mcast: Remove unnecessary ASSERT_RTNL and comment.
Date: Wed,  2 Jul 2025 16:01:27 -0700
Message-ID: <20250702230210.3115355-11-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702230210.3115355-1-kuni1840@gmail.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Now, RTNL is not needed for mcast code, and what's commented in
ip6_mc_msfget() is apparent by for_each_pmc_socklock(), which has
lockdep annotation for lock_sock().

Let's remove the comment and ASSERT_RTNL() in ipv6_mc_rejoin_groups().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/mcast.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index edae7770bf8c..6c875721d423 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -605,10 +605,6 @@ int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
 	if (!ipv6_addr_is_multicast(group))
 		return -EINVAL;
 
-	/* changes to the ipv6_mc_list require the socket lock and
-	 * rtnl lock. We have the socket lock, so reading the list is safe.
-	 */
-
 	for_each_pmc_socklock(inet6, sk, pmc) {
 		if (pmc->ifindex != gsf->gf_interface)
 			continue;
@@ -2880,8 +2876,6 @@ static void ipv6_mc_rejoin_groups(struct inet6_dev *idev)
 {
 	struct ifmcaddr6 *pmc;
 
-	ASSERT_RTNL();
-
 	mutex_lock(&idev->mc_lock);
 	if (mld_in_v1_mode(idev)) {
 		for_each_mc_mclock(idev, pmc)
-- 
2.49.0


