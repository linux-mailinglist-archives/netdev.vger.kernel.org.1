Return-Path: <netdev+bounces-70175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5766A84DF85
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8AB1C26F88
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BBF6D1B8;
	Thu,  8 Feb 2024 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="un32bYck"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988767E73
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391010; cv=none; b=Wg1xxpzsyxjSxUr+DiH7L1si68Yk7jjxPPv1OJQ2bs4E+NftdWYSC5bmhWaGlM2gtrkwZVtEVt3lwyZzjaDjHxwe6kOjYHLHvfLvXmIjyf5ehEqCLNOLvQmgdfXNydzmMCMBz4vKrQSVjPUGsdRPdajts0Da3oExTONFlOD//pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391010; c=relaxed/simple;
	bh=U0LXCffwDVtv0fOyGt1apVCzEVr3+honsS+KArAbCiI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EQrv2znpwmTCGfCPR1LULZQsz09OfCXEjhPWCNmG+9s3zTMcPiAto7InFjFSgUo5P5dHlLQWWChE07lgMrNYL8AQUvQYcz8oVxyTSOjPa0Nl3OatWQaoGQZujGodwmezUQ+MecS6b4oLQ4DKL8LFRvH4cCOT6R90KBBi4Q/MqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=un32bYck; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-42ab8a525aaso15289431cf.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 03:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707391007; x=1707995807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F/r/kiBaFg79sf5mBRwjCLioJWz/lYUhpGWa9kAf/ZU=;
        b=un32bYckA2O7knIhr970NPjPQdnx3GqLzJnbgYTj8UgbNazlD1Vd1kqpocgBuQWebB
         q1vQtaKmPl2VTAlcGKSWM8Rka83O6VQYjptnKW3+O76sUJhf3Q8Cmoq3M1frquxUKsM4
         zfsOwYsUPFocHXH0txAKvwF4lajC5YgNSJ0PLtU6DhUvrnlNKzc9eegF5mxpmhOlW3G2
         K9rEkiAxpZGl4BFdjP02H264fMMVxfxkZh+H6ffPGWDqPSmjV7D6zYwrCJYMDmnSoIfY
         irm7aeA8fr4DdX8A4v2UGOI/EAtOVU00VancZbpA8oj87L4SI4tJVmN+7RU8dnQyYS8W
         WvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707391007; x=1707995807;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/r/kiBaFg79sf5mBRwjCLioJWz/lYUhpGWa9kAf/ZU=;
        b=kYQpOyh/tPebsTKdqtANeAA5GaEJ78Enh3S2bzwJ9cqXRCaUV6Il2s1yejwMW+HmjS
         fTjBlTafSUh3ws1YG9BU3q3EIqZUN4Vnlz+xEZ9UMZF+g9Cgeeg8SF3bHqAehNtLYx06
         xWWny+GooF/Iemrk7yi8aTp5P+01bvn3kL/dwAPtVHhHezxqgzDlegfie3B3zcoP8qeQ
         kyDxCyM3UAkELG7WYGx/UfTWKoIQ2mEetLLIZJ6aHZSi0g8SNKTIXJSJPRpCeVSYG9rE
         wu2TjWCzLth6Qq+tvJCE4E8aF5RzAGuKG7BW5qslnYVusYu3T4WPPVhkDnSJjZnX/UI7
         SgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwXqBxqi3/Goxl5X5WlE9KA2eyZ4yJQnJweRvAlQwFhpd6dzH6/+0yajUFvhRdjSXzeVgTtNzcGB6236rV5D/M6vPkBC0F
X-Gm-Message-State: AOJu0YxG3ZWZjrJLCrcrK4JM9PWmaKMhCkb5GO/SckfF0tc4wmDalK5D
	QRfZ5THzKoG7zrkEuoXkcHwY8WJ0rUND552imK6AZYeJOqswDd4GQtW0r4WZXoK6m1Gt+mwEfqV
	jpfknXGM8wQ==
X-Google-Smtp-Source: AGHT+IEfCW8MuX1XSCRm41vY5JoHOpoXUD44Ni9qp0hm57bcPAFvnqqyFb20OhKoYwJSJ6l0FbnoNAd5FiMI9g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:2527:b0:68c:c345:db94 with SMTP
 id gg7-20020a056214252700b0068cc345db94mr14381qvb.4.1707391007452; Thu, 08
 Feb 2024 03:16:47 -0800 (PST)
Date: Thu,  8 Feb 2024 11:16:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208111646.535705-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] inet: convert to exit_batch_rtnl
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Even if these four modules exit_batch methods do not unregister
devices, it is worth converting them to exit_batch_rtnl
to save rtnl_lock()/rtnl_unlock() pairs in netns dismantles.

Eric Dumazet (4):
  ip6mr: use exit_batch_rtnl method
  ipv6: fib6: use exit_batch_rtnl method
  ipmr: use exit_batch_rtnl method
  ipv4: fib: use exit_batch_rtnl method

 net/ipv4/fib_frontend.c | 8 +++-----
 net/ipv4/ipmr.c         | 7 +++----
 net/ipv6/fib6_rules.c   | 7 +++----
 net/ipv6/ip6mr.c        | 7 +++----
 4 files changed, 12 insertions(+), 17 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


