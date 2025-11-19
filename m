Return-Path: <netdev+bounces-239878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCCBC6D878
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD74EE4A6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4C830101A;
	Wed, 19 Nov 2025 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vroafa2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB952FF140
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542097; cv=none; b=My6GoYjVypvn9R2DhisPmOS9PEFGUiE+ccNPEL5lKZXMiqJvF8Wby56o3W1c7IrylqE6GLh+KyF2+6vOBFfkgZ6pO0UBKCDeRGyaOZg5DqZFjH8mHokWcWd4sTxsjI3+lFaNRI5Nm+gorQFKO+ctt80wawtRQY7gSOOjKUlqtYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542097; c=relaxed/simple;
	bh=clxegaGK9GFURBRD/eSo3Fjncz2KuVsq+bGv/DuUE0Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HE2nEkTOZMOcBvdxgPab+reMoSp4oYAPnJSt0Cf4dDdeIkjjdkza61lnDIxnaFyGoWSCTZma2j3LPUwZ7SIHYUWPp1gjifYHrtD+zU5Xo7YgcL8TJu6ujad6r1AG5AH/Nq5Am7Q3IdJp+8fmi+FKyOrE13CBevubBNae2WEhi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vroafa2Q; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b29b4864b7so1942702185a.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763542095; x=1764146895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MRFEpRxjDirkXHdVXeO95at4r1WDry31ItejlJ7qW1E=;
        b=Vroafa2QE1bLgZ4jW6/w8ckKe81Q4+YscWbBgKmQDhZwu2+pBBiVDVsJP3KynlXdxb
         pwjrv18v41CTh4CGp40LqWUzVD3JX5HnBtoYyc1V2sbxEoHN9lR/TYsVUw1J0wm5SUEp
         AWy5oOxFe/BGJbjzJMN77Hsiktn12EfVX2Yc0LbaKzY0WPptl1cgpcxxFXpr0ENB5Tda
         ab+1pNsl1u63ZmvPkETs4mHkVHf0aojUfHr6IkMNiG9N6aRB6xhwi+pLp8HpKxEInr2O
         /ViITBVQa1197s6smfasQHb7NYW357cMi98rgRKMRBEAUUua9XS2Z2LernOvsysTFzvP
         kJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763542095; x=1764146895;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRFEpRxjDirkXHdVXeO95at4r1WDry31ItejlJ7qW1E=;
        b=FCrObY7qpBA3rw57MyjRf1UwUX3xEa5E1SzUniZnc5WE7rdd/ZUle+aOglEz5qei++
         Pdrc8Jf1wg3EeCP9TPgizclQ7tie2CHx7JyORw4/38B8rfFlTwRXe/gS3iuXC/XHCQG/
         HsOyn7S4FqMKCh9T7olJQsMthBa3bJauqP1sv2U3tcLLTnHuk4kb5cMK54kOkPCC8oXH
         ICniB7nE8xwR3eZ7LkHIn9XyMsqx03mwqtHumADrZvxqrIsPa15DcPlrOF8xnWpNiKSP
         mftArtqfijjnTLYWkXGqQKdjiyE4OLfo600gjRy7qtR10gianA7/I0hx3X2eGqGM+5wA
         oUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBRnoZ9QL4KY5yF+ObU1IyyFLdm7PWGMf1rqt8pYpeewlZZkiHsfuaHodssAVKdOv9Y0OAuFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9zKpwjLZ8D3DL5OUdYY1j2t1d51s4rCZp9R9MUP1f8wgXAHm
	Vyb7yqHRTOS4/jF9e583sapesqSeSF2uj7jWok2cmfaKyPIblRs/Y9x88HWIet0di68b7Fw4DD6
	CrY2F+Mi+CkcKyg==
X-Google-Smtp-Source: AGHT+IHoAH1ordXt+dP7dhmnW1YzWKovYN35IWGNShOmAlaWcpbpbhCCHEkkpyMOwSUeI2r2UUpKfUY3enEX5w==
X-Received: from qknqj6.prod.google.com ([2002:a05:620a:8806:b0:8b2:f2ce:8209])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f04:b0:88f:c0e1:ec2 with SMTP id af79cd13be357-8b2c31c4166mr2257702885a.60.1763542095286;
 Wed, 19 Nov 2025 00:48:15 -0800 (PST)
Date: Wed, 19 Nov 2025 08:48:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119084813.3684576-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/2] tcp: tcp_rcvbuf_grow() changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Rick Jones <jonesrick@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First pach is minor and moves tcp_moderate_rcvbuf in appropriate group.

Second patch is another attempt to keep small sk->sk_rcvbuf for DC
(small RT) TCP flows for optimal performance.

Eric Dumazet (2):
  tcp: tcp_moderate_rcvbuf is only used in rx path
  tcp: add net.ipv4.tcp_rcvbuf_low_rtt sysctl

 Documentation/networking/ip-sysctl.rst         | 10 ++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst       |  3 ++-
 include/net/netns/ipv4.h                       |  3 ++-
 net/core/net_namespace.c                       | 11 ++++-------
 net/ipv4/sysctl_net_ipv4.c                     |  9 +++++++++
 net/ipv4/tcp_input.c                           | 18 ++++++++++++++----
 net/ipv4/tcp_ipv4.c                            |  1 +
 7 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


