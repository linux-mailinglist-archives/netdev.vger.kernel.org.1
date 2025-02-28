Return-Path: <netdev+bounces-170708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E725A49A6E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADBD3B9674
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324D26B95B;
	Fri, 28 Feb 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZjD2/MA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41AF2580D7
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748973; cv=none; b=G/t91RrWTJzOZZ0Ck0rdtvfdghH8X26DjwnSGOenn7lhM/A3jn1hyqQ4Smt9vT/6FGgR5O7QB3xPK+oftpLYd/aMecjF4IqRi2EbDDsQklE9MyB/I4pOSisqngyNMJQJzTlrmWXTHbt/i8DxUQb69VR7JSHx5cpuGiktS0gArfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748973; c=relaxed/simple;
	bh=HCoFNKl4nQGtX7rI1WopoZAvzX7BNV7UILqkWwovb9E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AHIfcO7kdiCZEyUbVtIvU+feJYFjvo/NR1RQJbJfC4FXhzHG0lY8a3ojvZRgsMSnyaKOd/K4HsTQwkICX2cFrXIXtm0CF91pUr7KgASxeA6aT1ZlNsCbJcRPk489rsGaP872mpZmgrGjzQkeyyJtnB7+mSi0ZA+7V+r/ExR4nas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZjD2/MA; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d89154adabso36338546d6.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 05:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740748970; x=1741353770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/7AnlsLAqAoKCFx4NqWqzVT7ENuioWdIcANsXGvxbG4=;
        b=wZjD2/MAbn0EDit/QcVuv7sO/e6n7T0eKRlSWncQyZgh4EwSL5AgaBwzppJGyD3ZZo
         pKzoOxeh3eTt5lhpo3eIh7nOqLdp80jsjJxrl75wNhBNTezQ6i1vgnfDOfv9/VPUrDYH
         1y0w626BNgFMw92MlxcUfIJExLZljmdw4h3UCFl+CdGc6E+gJPaFPxMUQfS6zMhpFTOf
         gDUVxgDPquvt0q0ycZKAOgun7yIyNoOhGevQWYrnYrmsJ97pMcTOyD0TWnMh8UOcvHWg
         JPjApseS1E6kIc/B+lmXEJfPACiMjvlBT4XCWSv18sBbDu7cKz23jzOV/GPTfbPusVEl
         1IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748970; x=1741353770;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7AnlsLAqAoKCFx4NqWqzVT7ENuioWdIcANsXGvxbG4=;
        b=mGUEHVBE6vWoAxQZur+pJ4TH6Liqx/6cs0Ekh7QA+qYXDISojIX24dbrCPYJWnuFfR
         SJ9axENZf1dEsk82j+Yo3qFJZ+NXSKaup/hMmNfuyY30km2vQQdgiaSRrTZzjBFZOcyT
         A19JL9B1W0ScMyjkUhMo+1b9BY+u2ebTZYrLeHf2GYUtnyxXMP6BCApcPritl+cxFnh5
         1rcZ2u/GEb/A1SLPDbzyExStCTQ6Lb4LjKqiF0jsdAjKXKdksoIeUWfU+k9wZ0cuFKUw
         2RP8e3Le7eUqFjnBRHRJF2tyPPNtq0LiNtGkxMCExiV96AQ6CfUDxIhIDtS3PxrPgEMy
         MZlA==
X-Forwarded-Encrypted: i=1; AJvYcCWngzAPiORNFo8SPRHEz2Z50jCZHrJrT8WEqlRtSJlbsSQsr5lyjVzZI6duE2I6uBBtT2Uv04Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWs+jDHvwACYk3RLPtfUiYd1hfkhn3K/+jC89nzM+SdZdF4CJ+
	PxrzObrBwsdfEFv5m5kOp5lNTCBmduoAhX/Vttr6POTDhkSs26HIRj3RxJC98eoukesr7k2xSQv
	SGJ1Thm6AqA==
X-Google-Smtp-Source: AGHT+IHuQMz8TlBEqbN4iNv8P22PDP0DRpa2ZeyY6i/sHstaRj8kO+8adxEOgdLI3RTmJyjm7F1nMT95oRdgpw==
X-Received: from qknru5.prod.google.com ([2002:a05:620a:6845:b0:7c0:954c:8ec7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2b0b:b0:6e6:5e1a:7547 with SMTP id 6a1803df08f44-6e8a0cb4937mr47366676d6.12.1740748970654;
 Fri, 28 Feb 2025 05:22:50 -0800 (PST)
Date: Fri, 28 Feb 2025 13:22:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228132248.25899-1-edumazet@google.com>
Subject: [PATCH net-next 0/6] tcp: misc changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Minor changes, following recent changes in TCP stack.

Eric Dumazet (6):
  tcp: add a drop_reason pointer to tcp_check_req()
  tcp: add four drop reasons to tcp_check_req()
  tcp: convert to dev_net_rcu()
  net: gro: convert four dev_net() calls
  tcp: remove READ_ONCE(req->ts_recent)
  tcp: tcp_set_window_clamp() cleanup

 include/net/dropreason-core.h  |  9 +++++++++
 include/net/inet6_hashtables.h |  2 +-
 include/net/inet_hashtables.h  |  2 +-
 include/net/tcp.h              |  2 +-
 net/ipv4/tcp.c                 | 36 +++++++++++++++++-----------------
 net/ipv4/tcp_input.c           |  5 ++---
 net/ipv4/tcp_ipv4.c            | 17 ++++++++--------
 net/ipv4/tcp_metrics.c         |  6 +++---
 net/ipv4/tcp_minisocks.c       | 17 +++++++++++-----
 net/ipv4/tcp_offload.c         |  2 +-
 net/ipv4/tcp_output.c          |  2 +-
 net/ipv4/udp_offload.c         |  2 +-
 net/ipv6/tcp_ipv6.c            | 27 +++++++++++++------------
 net/ipv6/tcpv6_offload.c       |  2 +-
 net/ipv6/udp_offload.c         |  2 +-
 15 files changed, 75 insertions(+), 58 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog


