Return-Path: <netdev+bounces-217927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E24F9B3A6AF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF751883A3D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C85322752;
	Thu, 28 Aug 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ld9Czs50"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AE722FDE8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399313; cv=none; b=BNTN/1MEnWsoYOpYpcPJ41iHqR4kjJP3YCQ7ubLJNKM0vqZlqAzshY5ZfRRUniAzY205Pf0xpGQwqYcBpxDtjmkX5Ut3m2DXxgOeKknbo5nO9jQT0V6zmAALPdATnwxkNPpuXMwNfhxEx98uPQ8wZo7MkwBo2yn+43dMf9Ir24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399313; c=relaxed/simple;
	bh=so1A3mDCuncqlKYv7XbSoIYlY2n2IfjQwSz9iLa5+bE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cKDhi1/5Gw5nywvy1Is/cXck6MihgUPJCoj2F+y2xjiVhH4TrdGIZe3zM3QLN3F8h3kpBJS04l8H/nQVf7LhHyAfeu6UEQUtfjizjR71RpQ9HMXuEQ9R+oROVLGkCei4+3ViCFIsWvxnsd60R3+j4+FWaEKefbqHHvhMItnbnq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ld9Czs50; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-71fb88c78afso8698477b3.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756399311; x=1757004111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EJFHXAt0fmpEY7DZVLq1Rn3e8L5MH6nfI7/TBpOH8q8=;
        b=Ld9Czs50ZYwxckvomF/4d3MKKc8riGFEr0ROO4nmL0ZmW8YeSm7Npymc5/lnXQ6SMD
         XQhoXD9UMc1TZEV6++cikmxEM1QIbl0EZzPwM6m1TShv95BHH071gs7SlSYsJtBrN64O
         TdoI+rYswJE9UndRtGx3PxPD8ByyLzt0T2iWkrgQ5MluO8E/q4FIcFMnOCmfKAIvb12T
         FSl+eoIrS3m3xbwzGhbAspqW+I/GW08s8huhS/HaZnjdBEiiNiT+OhgZ2MTbuxPumdh/
         LrAyXgGgGN6nU/SD4Bo7V+K+4Ho0UcZ1AgvW0M+5nomnyODT7GGNYAeHN4Vpgdh4JHmd
         1oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399311; x=1757004111;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJFHXAt0fmpEY7DZVLq1Rn3e8L5MH6nfI7/TBpOH8q8=;
        b=b7Tvkh2rhwh5QS/WhypsNd99e0Y3795vPAri3sZ08JNU6lo+xR7/H1nfY5hlDXt/46
         H8HE0CEnLPklTWB3xwDBavst4EF1Q8MXmDcO4++ueSJK+KDhGxgu1HfizXNrF/366th/
         So6TG/VLy8zB6Gpe2dJY/Y+85CvQ8W46lszDpR1dH2tefWBuiGFLOh6IYLZeoGT/Z6jm
         SoBF+cqmLBs5dSZCYPFrv0mJY43SnMKxYB07r41Ap7nWkrrVh4vBSJWgDJS6TJ1+bFks
         3wbLyguxQEfKEIfI0kOR9fTSx6RJgg7gNvoKm8e+aGuOHdGzHWEG22K/eu0SKmVZaQNB
         aZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUCGg3aNsqViDML+uK1citkZIXhe9rK8H1PgBFq5EgpzxYAwS2y26R8Pnq+tFDnNv2XTuYhf2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjk+vT4VYcjTKoqZwTQHfFWeSlu8DcG4OJ3MfNgWE3GKPuVufm
	dl6+Z+iTEXZ1YTVmhj2IkBhTSiEelwEsoc/Pp1rFlemEaJZw1rWmTiZ6fzzV1Vg1eEdtSNnND+j
	fmow/cqmhWQssbQ==
X-Google-Smtp-Source: AGHT+IH8mTeInFcLF9b0yz21xflS4dQlFWg7tEaMg3TRPjxD1uiIIHpjar30iXdwc4zu2n+MwRsRbqGt82WcYA==
X-Received: from ywbfq3.prod.google.com ([2002:a05:690c:3503:b0:71f:ea49:b54f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:250a:b0:721:369e:44f3 with SMTP id 00721157ae682-721369e654amr118504247b3.47.1756399310851;
 Thu, 28 Aug 2025 09:41:50 -0700 (PDT)
Date: Thu, 28 Aug 2025 16:41:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828164149.3304323-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/3] inet: ping: misc changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First and third patches improve security a bit.

Second patch (ping_hash removal) is a cleanup.

Eric Dumazet (3):
  inet: ping: check sock_net() in ping_get_port() and ping_lookup()
  inet: ping: remove ping_hash()
  inet: ping: make ping_port_rover per netns

 include/net/netns/ipv4.h |  1 +
 net/ipv4/ping.c          | 34 +++++++++++++++-------------------
 net/ipv6/ping.c          |  1 -
 3 files changed, 16 insertions(+), 20 deletions(-)

-- 
2.51.0.268.g9569e192d0-goog


