Return-Path: <netdev+bounces-175807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D1A67830
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3228806F6
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C26720F09F;
	Tue, 18 Mar 2025 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sM7ZbP5U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C920CCE2
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312647; cv=none; b=bHJHTxz5mfQDt/IAUG9PR7vx0oWWNLd/Vp1Zb2lqauumrGwczLqewawwABMVJwQjQfOdLip9hG7TES6NclU0y0RZsxuynRFgKTYUMS8rlIGzv5OD7ryyDQm4juAyHnhUTUXomuEUr/qPh8BC9GCF/+jKVF9vXsQijz4qf3ZCgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312647; c=relaxed/simple;
	bh=yHKsHGFFPFyqRnWb4v7Y0Qulro+ESkXBfjACpFNoXg8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PwPi6kiC9X0Bvd49IraZUJM6i5ZOd2+0h7bX/o3zLAsEAU9x2jZnyoy7S3oZTRaWXq0Z2+39fnJ/1pjLefnLU60goQF+XyaPOc0p/ctSQPzS7ofr3E6EMC2rCmndnPeC0PYP2eqFpzyR9CL+/9YoHpVTTCgfZj90pM6HPIo03Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sM7ZbP5U; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c0b7ee195bso1021202285a.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742312641; x=1742917441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bwKn1vBFJmriv2bxrDVMGZWbLJHXFUUNyZ17goUfX3U=;
        b=sM7ZbP5UxnCpn57wrd9yTqrTp1lXKkw15Gk5osH4PRFQLBdY6KoGwSld4amlmeCJY+
         RAelwwCRYkqQ3wQj55z/hSuzsP5suxWJO4tMZDyp1svPEsVO0KMcazo/Wh9lC2FHJjkk
         ShWE864ljIos+hpZo32IvDhoyS8bayWGIbOqN9t/OOGbqNKlp2epnINNoAcSMlaXXMln
         Bw44HW/4Iz9rM14+hL/4KUim1zNADuVEjHDrvsKiil/NHGi30naxG2qI374/WNotccT0
         OutA+RqZOXZM82gBji1vNI+x9gxNffKobsTTsZqflYgyarDFwleDJOEBG+7aS2sNxC95
         l0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312641; x=1742917441;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bwKn1vBFJmriv2bxrDVMGZWbLJHXFUUNyZ17goUfX3U=;
        b=PDpDtFDhUIjWqfjeXji8dXN3BfLfV4zZ4NQ5OYNIJGQKzUKx7iG6dVgzdYSG1T6lP5
         X8X7bODz6c/VfMq+dJfYnq1kz7wUM/yaIlYRz6ukaRKK4Ka7SkLAnwEdJxGLnMi8dAVg
         FNqZ7OyENX5rGSdFnKE2N7VZ6AxnE4GbK/TyWga3xNchyWUtfJG2bhJWXP1ZjET+qmqw
         SIPZh7BaAalwKkNt1sx6fORsc5HPzHkkajlOGZ0eD17/JbtQ2R6wDQAFbxX5/2sbWgug
         a8G9CjbPQxbFl6DDoBiT7Z5IipJTIDY+9RpX8jZR9I7cva1/60WkyfWths66z4FEe+A5
         G1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXJBFTl57uEu96JRYQ4fqHFxs3d1w1w0XiHmsj+ZtUseinba2OeHZijLjc8yZ4zLHLQrHYpHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysgfrGNOwU4cPqGsM3P6pX52E8DGthf2w3HZvn9178UZDWgJit
	Ai+JlAcXwPl7ll+YxNPRFGHUcYrxt/rf/5oAxibbjzbs37VNltmHAzPmZqVJ3pUhpN8D9KsiM/x
	1qLDse17pvg==
X-Google-Smtp-Source: AGHT+IFpUF12kP/53dUsnYIIiOm4RgFuJ8k92BXRS7zMTFomrS3NE++deElUKLu4ktWSztTcSsduMmoS8H34Qg==
X-Received: from qknpz7.prod.google.com ([2002:a05:620a:6407:b0:7c3:bcf1:4d6a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a0a:b0:7c5:47c6:b87f with SMTP id af79cd13be357-7c59b1b4e45mr578009485a.19.1742312640725;
 Tue, 18 Mar 2025 08:44:00 -0700 (PDT)
Date: Tue, 18 Mar 2025 15:43:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318154359.778438-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/2] tcp/dccp: remove 16 bytes from icsk
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icsk->icsk_timeout and icsk->icsk_ack.timeout can be removed.

They mirror existing fields in icsk->icsk_retransmit_timer and
icsk->icsk_retransmit_timer.

v2: rebase, plus Kuniyuki tags.

Eric Dumazet (2):
  tcp/dccp: remove icsk->icsk_timeout
  tcp/dccp: remove icsk->icsk_ack.timeout

 .../net_cachelines/inet_connection_sock.rst   |  4 +---
 include/net/inet_connection_sock.h            | 22 +++++++++++++------
 net/dccp/output.c                             |  5 ++---
 net/dccp/timer.c                              |  8 +++----
 net/ipv4/inet_diag.c                          |  4 ++--
 net/ipv4/tcp_ipv4.c                           |  4 ++--
 net/ipv4/tcp_output.c                         |  7 +++---
 net/ipv4/tcp_timer.c                          | 16 ++++++++------
 net/ipv6/tcp_ipv6.c                           |  4 ++--
 net/mptcp/options.c                           |  1 -
 net/mptcp/protocol.c                          |  3 +--
 .../selftests/bpf/progs/bpf_iter_tcp4.c       |  4 ++--
 .../selftests/bpf/progs/bpf_iter_tcp6.c       |  4 ++--
 13 files changed, 45 insertions(+), 41 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog


