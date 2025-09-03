Return-Path: <netdev+bounces-219484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B264DB418FC
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFF9163C65
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01E62868AF;
	Wed,  3 Sep 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQAtw3Ro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431421DD877
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889244; cv=none; b=TCem1r5BCj4atk9RGqeXqXa1ssxmd8oon9M/4JCqDRvQ3UIplynFrbB0p91iqOCNB1lrvkmdz6GDjC50JI9T3YrxxQISry/d001ZnAorXg/29wHIGF+a3h7t7KcigGnOw9HEdjct6IdSKLsZl+2OD5T88/5sOTZJCKRDiYE8XrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889244; c=relaxed/simple;
	bh=ZXJT/6JxumP7oBE48MP8RQ60Mkhe0hhEKiBXAHIHBaw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TJ5BWyYAgQMO5qMtkN7r2opzhFPN6qzgkHEb8DQ8RNpgz5uxrH9vSiXjejxSq//UscvH+HH5U3lQkwskdD/miEHC5mRKdpmrsb75iniTvGTAYZGti6ZETwH23xdzhB5P7iZFf96KWngCVOme+gH49BAYPcecYVecbc9nt3a4Oxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQAtw3Ro; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-52ae22973feso599011137.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756889242; x=1757494042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J0i9YJY4pWsIji81M8kmfkmeIM1SxPrmw48BqNVGnOc=;
        b=tQAtw3RopxloscGK4xrPDNA3JzACnW414pTwN25F7Z+Xec+HKooxzIMq9GlHXkcNkD
         rqBjA2UGrKDRvkqk4JwqBJzZsUjBpFaE7k9TuEeotsHv9vL9HUiM98Jdi+wTk/bSC/7T
         1o4O7R4f4YIvFFKYMXVVMafo1Phe3YwNyIsjEk8U/j4rxEcYOzwbDUcediIfPmenqhTQ
         s1zzUd/WcHRckcxHJ7WiZ/oEKNLBYRNw/5EuTwWM4TcWyOokhC98irNpAxTM9KVUkjmE
         i/gEVhjxmo9lXdsq4bpCKaQnp+S7Z3OB4BxWDNnwgpMJPNyFA812v1/Gn19s3xP8kVqY
         f2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889242; x=1757494042;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0i9YJY4pWsIji81M8kmfkmeIM1SxPrmw48BqNVGnOc=;
        b=NlQyi6j82c3RkyXZ1y48SHgjwLrI3xA/Vm/wMBRsbioFUZn3piAyD1w2rjmT2sKk3e
         SclkZ+v0VfUgN9RU1sgKH9JnVneRmJmL1uZrfdDHre/lvr12QNjjIWJbHw+16+y/1tZh
         6EdZy9MaGuaoktuFv9FRVD2g7Y6ctZRCVZbSiggJofxJlV6AtLMq+25iGXm6eDZtlWRO
         wPbnkazei0HYT7UIMwrFEzVGNiOSYXgRyehkd8iN6pLypnVOzLEYqCmNwN7GTF2Hgtf/
         7QI/qZSGtmM7xRv/ZPTa4SF2GWvnhx4kyXiErwsZzfPaqwrOWlYTEjEGOUNwkR6mPQO/
         u7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWewofqL6QVLpxUwlRN1Glv7+gogRzPw15/q5a2Ffgxsx+/evqcH3ExcFHmnProJhzM7eMkkXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1gEabGb8mOS1O5OVs2aL3m5jrI1XzC6UQsCcOS28tvhNrvldu
	K1juvw/df1lDKso2t5Wfzq4KUDuQ0P/kl/6LPbucvKtihf0F18P8oIsv2tAWJUyEnAiZmg1C7xV
	Vkz2WJEr1HAj7bA==
X-Google-Smtp-Source: AGHT+IEUKCycOl+OZGf0gW6HetoeTMEvjdETQK8FCvHrU6iW5FofHV7T9/psP4eD4lxLgTpcebjvZ/pdeaRSwg==
X-Received: from vsbdm25.prod.google.com ([2002:a05:6102:5a99:b0:530:e8a2:1031])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:ccb:b0:523:712d:44a1 with SMTP id ada2fe7eead31-52b1b6fbac3mr3618260137.19.1756889242119;
 Wed, 03 Sep 2025 01:47:22 -0700 (PDT)
Date: Wed,  3 Sep 2025 08:47:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903084720.1168904-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] tcp: __tcp_close() changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch fixes a rare bug.

Second patch adds a corresponding packetdrill test.

Third patch is a small optimization.

Eric Dumazet (3):
  tcp: fix __tcp_close() to only send RST when required
  selftests/net: packetdrill: add tcp_close_no_rst.pkt
  tcp: use tcp_eat_recv_skb in __tcp_close()

 net/ipv4/tcp.c                                | 13 ++++----
 .../net/packetdrill/tcp_close_no_rst.pkt      | 32 +++++++++++++++++++
 2 files changed, 39 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_no_rst.pkt

-- 
2.51.0.338.gd7d06c2dae-goog


