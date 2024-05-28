Return-Path: <netdev+bounces-98539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E5D8D1BAA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0388B22EDD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C4A16D4F2;
	Tue, 28 May 2024 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNkIke9z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0216ABC5
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900781; cv=none; b=Dtd0kHugL97AXgCwv8v1/3mnYSwfixv/5b6xH1EJimzERIB+MolDrwprooFbaRjuhm0bGo3lJfUYhnEt/7a6MaVEb8T2xT6bEfxI2GUYzCUvNtG/8Ky29hcASPxKE/RSyUFsnpxUoKXPk5VofIKoM35DSdIeWZRHMYfZtwSjOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900781; c=relaxed/simple;
	bh=+86PAOfs+uvRijKPh6k7L8mc71g0C3ow7EPQ48aR9S8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uYFlZgYRkVNHw7ZdvBO6M8TGn1StytqtTOEpb3OOmhQNxatGM3SsHFVK9kN1XaJJyhuyIKMCScMqYQZos96Hr0or4iq3U11pxWo9hkEGTM5vQGHJQoIRrf43LXOx78BHEHodqON+kX/FxLpc8eZChuqEQ6JwEian7tPOexvU80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HNkIke9z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-629f8a92145so13367707b3.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716900779; x=1717505579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QS4IDDig/eb3q5KtRYZvnOx28RXxiCEvYFC5LSzZDmw=;
        b=HNkIke9zgIf/atrK0xRIhyvb+FPD6JHhjYsNDq3vIuTErot38Usrwj9VCG/OZiEjlt
         hUgxeXTNOzIORyuroN55CotMxfV3eFdAIKYuilW66QhUADZsAZic38LGNIM3890Mm8cy
         MfZIGLfY4S/QAzI6E2/JVNzxyvddPHGMI+5W0INzAB3Jz6DeObVLYx4sXnr8c8i7kDat
         Gp/watz87xfS1fUfCeoe9Qy0F4M8G+dKWydf5rdB91aMRF87wkRphs2sGY7EmgzivdcB
         gtrRmduLIrbnkr3YODtXe8bsUWMWrcTUaBU+tPNsywYeQXKwpIzadTWIjAk3hn4sAc4s
         kzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716900779; x=1717505579;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QS4IDDig/eb3q5KtRYZvnOx28RXxiCEvYFC5LSzZDmw=;
        b=erAI0c3yrQfU/JksV/+zkfHyli7whKtoKnTlYeY3H/v0Lkyw0/ybXyh3BNlnjaBihI
         pknvbEQGmYD+8gJJS+8LbOb4FHddGTq3/SLCtEscLMK0ibzbAZOVwNTCTu/VF5cu+p1v
         Vdao/bWyOF5aXIMzz4sa55edFKeKIuRYV9qyJOS/5ZkewZ6iTt2ZOr046cPZH1I6YAkG
         Dy5MWj1yniYkzFSM9GdJU1u1Q6H27Vj0GQ/8cxX26hNXZHbFQH81eQPAaofbFT1qLo0y
         wNS0F6mcVUMpAL3lYkypDNIVcDWfJYKcHjHxk7nZ+5jpwH+i0BYwIaxqiC2Z3krQlqBC
         dT8A==
X-Forwarded-Encrypted: i=1; AJvYcCVDeXi+Koe8GvA1GEODI6R0UPDV3jUf2h2Gm5bchDs9bmUiGnU+RXh3X9XpVJm3StdgzjliqcB46T3zHbnqaG6ZQL7Da6Zj
X-Gm-Message-State: AOJu0YyzjOv44GGF/Y/o69v3ThdNetM//MWiQ7ffw6bH+aiaZfwhkFTW
	ZZ4jLGN41luBhbPGD4oFzPUeRKl0SN86tfHKzWaGcxK9P/BC/K6WrQdfW2a24jqD4eRgDO3VLkK
	P4pU++Ia8YQ==
X-Google-Smtp-Source: AGHT+IHk9o6hhbvbo7fqq/9JuCwRt7DCGupkaprnqFqv4iImvE9qCKEw34zw0bnadfSnMHr3y6dLcsfgV6YHwA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:722:b0:df6:5027:d1f8 with SMTP
 id 3f1490d57ef6-df7721488f6mr1140799276.3.1716900779436; Tue, 28 May 2024
 05:52:59 -0700 (PDT)
Date: Tue, 28 May 2024 12:52:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528125253.1966136-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] tcp: fix tcp_poll() races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, David Laight <David.Laight@aculab.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Flakes in packetdrill tests stressing epoll_wait()
were root caused to bad ordering in tcp_write_err()

Precisely, we have to call sk_error_report() after
tcp_done().

When fixing this issue, we discovered tcp_abort(),
tcp_v4_err() and tcp_v6_err() had similar issues.

Since tcp_reset() has the correct ordering,
first patch takes part of it and creates
tcp_done_with_error() helper.

v2: added @err parameter to tcp_done_with_error()
    as suggested by David Laight.

Eric Dumazet (4):
  tcp: add tcp_done_with_error() helper
  tcp: fix race in tcp_write_err()
  tcp: fix races in tcp_abort()
  tcp: fix races in tcp_v[46]_err()

 include/net/tcp.h    |  1 +
 net/ipv4/tcp.c       |  8 ++------
 net/ipv4/tcp_input.c | 32 +++++++++++++++++++++-----------
 net/ipv4/tcp_ipv4.c  | 11 +++--------
 net/ipv4/tcp_timer.c |  6 +-----
 net/ipv6/tcp_ipv6.c  | 10 +++-------
 6 files changed, 31 insertions(+), 37 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


