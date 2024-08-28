Return-Path: <netdev+bounces-122907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3A96310F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E6B1F21C41
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09AC1AAE19;
	Wed, 28 Aug 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2O9qTRrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F070433C1
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874002; cv=none; b=odyKpkjxagJvsTKeI+d72jhU92YsGp0Yjp8lfcRlHkScuCeHstsMbf+d/VcAErzqzwYTHKJd+HMZcM/PRNlXJ/wf0J85NVPz2hsq2U1Q3iJJ0qrSqZG3nUMsvemto8UiSxpkFOYPn7iLJRP1yDS74c9DJDpch7AWQlGknO52T1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874002; c=relaxed/simple;
	bh=pp4LS5OLDpwnbTmgyXABseihLB1BwQmwac5FhKUAPQ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=umosD4ZAzcDDP/Z3o6Bea1A2wykStofI4iDlokNr6DeKlDlLWp87nDhgxCNa5aevG6zKR0Qh6kihM6jfU1mr97z4MtKg0Xp1O0zRT2cQxMhUzpI1FVkzGzKgvTG1TPt6bcb6x+k6UsUnVsV215hRMpA3hXp494Bpop/4rMUHvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2O9qTRrC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b46d8bc153so136125267b3.2
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724874000; x=1725478800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ETaQUT+PPfbI9id4ycXuo8+5bQkOihsNpmgMv07doI=;
        b=2O9qTRrCPSwJvyoe5ozYQwRNJ9bbe66DPOBGKvvOB3shNZxqtnae5Y1FqEpPH95bng
         eQmMaG8S/n4CvaCCSyjNyB7LgovYCX1qKVGk8jomFV+induz/oFSgr2L3Jx55Yyh9sCZ
         uVdcThWjK3/lylK1nD+VuePXujkekpY8r/xDPF6nL+/huCd8SF94ZEcHfSceaf/oAoj4
         3VPE9tABOsWAuqtBfJeI5MmdBNjgFZ9kPhnqqMxbZ2vlOF/s4NE9e6Z9VhAKlDzKbtAt
         h5+SQvEz53+zXWk/+2ukC0Fp0yltaKbZ4Q8QCf0Lc1IXMAg6JB1Fl9l41X0qAqKy4uMi
         eh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724874000; x=1725478800;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ETaQUT+PPfbI9id4ycXuo8+5bQkOihsNpmgMv07doI=;
        b=R2EQRsU8uXCqgHiazhLbPUYTHsFOO1iF885A+FAD/LEbV9cGOJ9VX6whK6hrk679FZ
         G/SXe/uYJkrZ25YBX4o6+vzPHz60dxkteBMReYIlkER+aImoaRciTg19438XzwlW4uNi
         2LHKBl+i45qe3ChjberfNjRLCKlYo0WOrWU5IDjZpCX3WHujooZPPK9Ze7OoXF2eUcuc
         SYi06e+dJLfqkLnw1jeqv3Pgpv3l/P/OgCKw5o7JUOtDVwDjZSM01DNpyh32Vz78sxPw
         y5jEW0IhBjBYnLnnVRIb1YvVY1r6AtSaHjmp5YOQOfcXL0cbyKP9yVL1sqnfqfapodmH
         cM+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIPL7CT6KArVb1Mww/2HuxkODy7NzXwAShsTtGuSaSasOIdGvsZS7SFQt42c0ni00kcZm+HNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUT8FUTNmyOVkAsdE4zVOlfZlmPXXOSV5xx6fAdQiitOZTPf6v
	ZCscp885uBkvgZrQAAFL7zKNBDFYL/Vjq+f1Zl41shvVPIOWhqkd4cRo9Q6LFnIk4CmNuArmrIR
	G0Yy2sCaPQg==
X-Google-Smtp-Source: AGHT+IGi//vftVw5AuTC+AY7KB6bjk/NxIxgwlUQrdWDL1jM2sIKWvm0q4MM/KptMfYmJsezyAh3eqj6oDiOTw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ab27:0:b0:e03:59e2:e82 with SMTP id
 3f1490d57ef6-e1a5ae0c182mr471276.10.1724873999905; Wed, 28 Aug 2024 12:39:59
 -0700 (PDT)
Date: Wed, 28 Aug 2024 19:39:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828193948.2692476-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] icmp: avoid possible side-channels attacks
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willy Tarreau <w@1wt.eu>, Keyu Man <keyu.man@email.ucr.edu>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Keyu Man reminded us that linux ICMP rate limiting was still allowing
side-channels attacks.

Quoting the fine document [1]:

4.4 Private Source Port Scan Method
...
 We can then use the same global ICMP rate limit as a side
 channel to infer if such an ICMP message has been triggered. At
 first glance, this method can work but at a low speed of one port
 per second, due to the per-IP rate limit on ICMP messages.
 Surprisingly, after we analyze the source code of the ICMP rate
 limit implementation, we find that the global rate limit is checked
 prior to the per-IP rate limit. This means that even if the per-IP
 rate limit may eventually determine that no ICMP reply should be
 sent, a packet is still subjected to the global rate limit check and one
 token is deducted. Ironically, such a decision is consciously made
 by Linux developers to avoid invoking the expensive check of the
 per-IP rate limit [ 22], involving a search process to locate the per-IP
 data structure.
 This effectively means that the per-IP rate limit can be disre-
 garded for the purpose of our side channel based scan, as it only
 determines if the final ICMP reply is generated but has nothing to
 do with the global rate limit counter decrement. As a result, we can
 continue to use roughly the same scan method as efficient as before,
 achieving 1,000 ports per second
...

This series :

1) Changes the order of the two rate limiters to fix the issue.

2-3) Make the 'host-wide' rate limiter a per-netns one.

[1]
Link: https://dl.acm.org/doi/pdf/10.1145/3372297.3417280

Eric Dumazet (3):
  icmp: change the order of rate limits
  icmp: move icmp_global.credit and icmp_global.stamp to per netns
    storage
  icmp: icmp_msgs_per_sec and icmp_msgs_burst sysctls become per netns

 include/net/ip.h           |   5 +-
 include/net/netns/ipv4.h   |   5 +-
 net/ipv4/icmp.c            | 111 +++++++++++++++++++------------------
 net/ipv4/sysctl_net_ipv4.c |  32 +++++------
 net/ipv6/icmp.c            |  28 ++++++----
 5 files changed, 97 insertions(+), 84 deletions(-)

-- 
2.46.0.295.g3b9ea8a38a-goog


