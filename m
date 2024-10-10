Return-Path: <netdev+bounces-134361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99795998EB9
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410F31F24FF7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486A319A292;
	Thu, 10 Oct 2024 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Elm/IpL5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5C19ABC6
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582501; cv=none; b=P+Asx9UPEQ3dmZYtjFBCxSck7gZcHSU/npYMB5yXa0wBNPtD941zsWSYin1dBHKZ7p7NvNRF/fWD0c1bBJ7DM2+Wm8Y5XO/ouvO+Ey3xRgHhrjQBAmi4SppHwGlIP9utpc0JDKBaiQvKSWbvt7UOHasei2hyq7pTMg7k1W80830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582501; c=relaxed/simple;
	bh=bCTFl/7F8LbeaJIpj3Udlkvsge65XDuwy/JgySGN0oM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OJ9+T9yAW4LKRH6+0FjHCamDeRkc2cz6TS6Z7gSHtwwAcSAcgfMM+iaA7gGzLgno+QAIlJaQKBLLCLcftns+6A5JaMBbQtUxztJg39cNZQ3yUkLY2agG8rr15D3r2+0yMqsrH2s/z4UO2YNiVZKE66l+2ruyUsk3lLwUfewdhGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Elm/IpL5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e29b4f8837so18295997b3.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728582498; x=1729187298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uo4jSsmbYIDoMRuJl6rYrKS3viZC0aPbs4SAjrDDDJY=;
        b=Elm/IpL5nWdidvM+KtJsqyGPxYxP4ji0qB2Cxw6C5cGHuBb8SzmmeHvxNU0us57dRx
         y5LHs4DMDdG0uAW1Jw4PS5kOQnWr3KmmZAQ34uBFTJD6crc2gA3wjOIgEYY+Exz/+Enk
         sWiyiW+ZJZZxMFX7lhp3+FEAuwiW6swvbm3XnpTRTlWWCI3uDtiE5u/O429ZmX9R+Uof
         cuCwIWjwPefoYQ+bF+vfgYKF0r3sryI4WzgJxDpeAcCrzxIUwygj2esykty6Sphm6TaX
         1iJJP3Puu9NRLkWLnOUOWIDsj3Mw3Lj9BTaU/DeIXK/yYX5Bvg9fWvyNn/mJzNR8GXAr
         EWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582498; x=1729187298;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uo4jSsmbYIDoMRuJl6rYrKS3viZC0aPbs4SAjrDDDJY=;
        b=c9mbaRCip8K2Ui7+289LocxC7zgVuSsoeqMg5EaL+14IPQ6Pji0+0B9EPc3AKEwO3k
         uA9Y6mjlH2O6/8ET1CpH3bHLuaFksaG1ZccajWdtx+FWJ1ZVxUx72n7mGTonp2rpgM91
         I7uyFC81fTVKiNgm3ikk8EXAxJLX2hVsSrLuqjnnCZT3ORqm/ViSNkYi5IQXw08UuItd
         scioKN6UdrDugkOTxykA2zNVL3L8eKmdpjOty4zRe5sayu0ArrG/B+q/UPFrVbMzoWKZ
         8/Z+R5XWruLhCzEGJrNpnXJB3CrbzTzAbwoFqbPDWDEZz6ghzWGhBn1p0dBrlGQp1QwA
         dWuA==
X-Forwarded-Encrypted: i=1; AJvYcCW/WMgYnRpbdpFAtJKOn0wz8PlaKMbIFqDtJ0DucqKgDIyrpAiPBdZ7KCLGBiyEaziPNVWeNqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZeQHo3STAc4fmxKDuBCWIL2g8SqmK34fVY0a8fpEyI8FiPAT
	YCz9Eq801TaH/hgdfVsqtvFeoblrZ+FJMqOlZvh0jbb+7TAjTEmnz0Q805ACydj6PcfleF7Tg7n
	egBR6hCtogg==
X-Google-Smtp-Source: AGHT+IH5ZBhyPC+DKfAr/R1mcvjLHqfVvfrbarGAaTM+JWoguc0fCG2eAyiz6fSjmeJJm4ZMLOlrM78BDjMtBg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:2881:b0:6e3:ad3:1f19 with SMTP
 id 00721157ae682-6e32f25e97emr594667b3.3.1728582498655; Thu, 10 Oct 2024
 10:48:18 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:48:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010174817.1543642-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/5] tcp: add skb->sk to more control packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Neal Cardwell <ncardwell@google.com>, Brian Vazquez <brianvv@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, TCP can set skb->sk for a variety of transmit packets.

However, packets sent on behalf of a TIME_WAIT sockets do not
have an attached socket.

Same issue for RST packets.

We want to change this, in order to increase eBPF program
capabilities.

This is slightly risky, because various layers could
be confused by TIME_WAIT sockets showing up in skb->sk.

v3: also changed sk_const_to_full_sk() to address CI splat in XFRM
Link: https://netdev-3.bots.linux.dev/vmksft-nf-dbg/results/804321/21-conntrack-vrf-sh/stderr
v2: audited all sk_to_full_sk() users and addressed Martin feedback.

Eric Dumazet (5):
  net: add TIME_WAIT logic to sk_to_full_sk()
  net_sched: sch_fq: prepare for TIME_WAIT sockets
  net: add skb_set_owner_edemux() helper
  ipv6: tcp: give socket pointer to control skbs
  ipv4: tcp: give socket pointer to control skbs

 include/linux/bpf-cgroup.h |  2 +-
 include/net/inet_sock.h    |  8 ++++++--
 include/net/ip.h           |  3 ++-
 include/net/sock.h         | 19 +++++++++++++++++++
 net/core/filter.c          |  6 +-----
 net/core/sock.c            |  9 +++------
 net/ipv4/ip_output.c       |  5 ++++-
 net/ipv4/tcp_ipv4.c        |  4 ++--
 net/ipv4/tcp_output.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  3 +++
 net/sched/sch_fq.c         |  3 ++-
 11 files changed, 44 insertions(+), 20 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


