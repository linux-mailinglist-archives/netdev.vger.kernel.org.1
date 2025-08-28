Return-Path: <netdev+bounces-217977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D67B3AB23
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5613D985B20
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF5D27C84F;
	Thu, 28 Aug 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TgUPOODI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040F2797B8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411108; cv=none; b=USmPISi+CjTEPBYWGkG8wIxzpqoL/cNQB0qvcVkhwsohza+N0ciTYhvLRCJOi/mkXvnbBEK+ap58EsrLZwZc36B3i3Kn62+dOfxlw48ZH9I6UuHiNiizbHyj3I7RBc9FbI7INeUpn0hWANTzwAaEk21fdNUg6q/mnm5p56azDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411108; c=relaxed/simple;
	bh=BlwdfEfYVh0Zp0ukv/UNsLqYliHNCNv1s0cElKIp1ig=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OBU0LlS9IhoGOLY7zpbK8JfliPZIziAmMS2PQ0jyMnOuDaNV+QeFM6cLW4hNHWEEuIIln3/H6DzZNpg4Gq1K/WUbnpNnBZKZH3ALj34rM9URC5lYqCVeeSI0f0TNKJQQM57mh5DzS7Ig6PDCqguKi8Z66SweFvdlEOCVtJwMYiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TgUPOODI; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e87069063aso482973085a.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756411105; x=1757015905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GtAYNenQUBOed2WhlmFT+uQ3DR/xTBaYOwEQpvUes9g=;
        b=TgUPOODIKehMSTNJYUjeY/E6MDaINRA4SO1IH8Nxg6pkE5MrvpPbP2QfYJCHUWw6er
         ADwvLDikrm1wZlYhlFo36IXY5Ar5B7VJ0vYk2hP+D6FLrxqS/286/E4lRExIYoJOSLPY
         S2hqtOwv0ynGcEq8UAo/c3yVfaOR8sT4kDZXWeL6bLQi+G0/GGFNHaW/oeR4RK4vDerN
         dnwpRLPJ9HTnGx+A525XS60bH+SmzHUJIFW8M3NwoDCzxtrPYRFBZtkyrgoP/QEQ9kZE
         ySDvP1YiKFO3IfjYm3ZRnEj0MLGVJiY801Ows9B4dhAgU6Do61oTKAMh3SUOopzYkmPG
         kujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411105; x=1757015905;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GtAYNenQUBOed2WhlmFT+uQ3DR/xTBaYOwEQpvUes9g=;
        b=fP0s5+g8JWXAf6yz3Xugcbw+qLbK0OLsVeKUwdzc31tN1ELCT00LkMGGXnjEgM1zHT
         FFuUZqOtfuSu5W2OImaUTsXWO5n9r2qsJqHw7cZGfK9PU19/Dya62BglKdg/CVCHiAC6
         JzxD/RYm6Su9oiPOzA1DvCITGMqgTHPP0OBwIFX+418LuujRKW+/CHVaK//G7xOeA0M9
         hIuwlffGZ/+5VoYHbRfckMR82bbAYkmWNWv5kIFOPuKGD5I82RAdx8i/yp3vfaqDBkWq
         dHyfC7IJqEXguTAjrBRPkCSlgwnQGxoLb/BtLATePGfpdVbWnyoMoJ6PpS0/O0ViAk59
         uOqw==
X-Forwarded-Encrypted: i=1; AJvYcCXqGY9FD0Kdy3knkjaIoa/67azBBdmaQjcm+YL1uriPMDc8brHojUIZ3JBVpMl6pf8clzdkIao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1v4SmYjqj+0i/QSLBOcGrbi44qTSSya6/XtmIpW6XOjVeGS+
	3FYbyoseJR3606gHhR8Skwq2LHIF2K2FehUvwOt1pRxEd7wMGpVrSE0/iYdHo3yNuZOkRpeyiiA
	dDS9UUz/ll1f8mA==
X-Google-Smtp-Source: AGHT+IF4mM2ZM50jbYSxYgHX8R+V7mansjeIUhJBpZ90UPHLRwJmpeX9Kj3I2dgO6hc5sjMb4dbKVbknt0IG/w==
X-Received: from qkpb39.prod.google.com ([2002:a05:620a:2727:b0:7e9:fd78:237])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:ab13:b0:7f1:1202:4be8 with SMTP id af79cd13be357-7f1120251dfmr1615673985a.45.1756411105362;
 Thu, 28 Aug 2025 12:58:25 -0700 (PDT)
Date: Thu, 28 Aug 2025 19:58:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828195823.3958522-1-edumazet@google.com>
Subject: [PATCH net-next 0/8] net: add rcu safety to dst->dev
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Followup of commit 88fe14253e18 ("net: dst: add four helpers
to annotate data-races around dst->dev").

Use lockdep enabled helpers to convert our unsafe dst->dev
uses one at a time.

More to come...

Eric Dumazet (8):
  net: dst: introduce dst->dev_rcu
  ipv6: start using dst_dev_rcu()
  ipv6: use RCU in ip6_xmit()
  ipv6: use RCU in ip6_output()
  net: use dst_dev_rcu() in sk_setup_caps()
  tcp_metrics: use dst_dev_net_rcu()
  tcp: use dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check()
  ipv4: start using dst_dev_rcu()

 include/net/dst.h       | 16 +++++++----
 include/net/ip.h        |  6 ++--
 include/net/ip6_route.h |  2 +-
 include/net/route.h     |  2 +-
 net/core/dst.c          |  2 +-
 net/core/sock.c         | 16 +++++++----
 net/ipv4/icmp.c         |  6 ++--
 net/ipv4/ip_fragment.c  |  6 ++--
 net/ipv4/ipmr.c         |  6 ++--
 net/ipv4/route.c        |  8 +++---
 net/ipv4/tcp_fastopen.c |  7 +++--
 net/ipv4/tcp_metrics.c  |  6 ++--
 net/ipv6/anycast.c      |  2 +-
 net/ipv6/icmp.c         |  6 ++--
 net/ipv6/ip6_output.c   | 64 +++++++++++++++++++++++------------------
 net/ipv6/mcast.c        |  2 +-
 net/ipv6/ndisc.c        |  2 +-
 net/ipv6/output_core.c  |  8 ++++--
 net/ipv6/route.c        |  7 ++---
 19 files changed, 99 insertions(+), 75 deletions(-)

-- 
2.51.0.318.gd7df087d1a-goog


