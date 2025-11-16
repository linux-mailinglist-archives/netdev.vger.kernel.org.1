Return-Path: <netdev+bounces-238979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB8BC61C44
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 21:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69813AD577
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 20:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3623E23C;
	Sun, 16 Nov 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHQii4ZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA372222578
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763324841; cv=none; b=S+46iqQGr6LfxT/vypfPOuGqVO34Ll6xHiELYgbITLvm1BKzA3l7pJ9AU9SjmrqbHPU0+Gl6wUjF/ul/Rt26GEqlzk0Obpn+wH1esXgQDAZumS72chWC19/cjrpKmta/g1xztDNiH3fFDSU67/ywTnfR9FbxDvmzjlGe0EqohBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763324841; c=relaxed/simple;
	bh=g1DbweDnbPP3XGQUVQPEKtnYJSDcr+trIW7yfslAn2k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g3MN23OKMX2we8342Pw5PHffj2PpRrDEu8nmgoyG+ppoYnqVI8ijfdFCH1zRJfecTV9sREI7uctNlfCmOYM8oZTLzzvym25d7fzbgUvri9uRgjkfG1KLJ8BjXvB/IIks1dpN6IGoKd5sNE3tpGnBwJE4V3LeABIz4jihUycN85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dHQii4ZK; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b225760181so477110485a.2
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 12:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763324839; x=1763929639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gQx/kxpokBkm1yYs1IBUbAph4a+oanJ91i4iPhyYJpc=;
        b=dHQii4ZKJpsbXXef+tg92/6TSXr0s1feq0opXadSBBfOlnIO4AyBozbud51VF7YUKU
         krklDKM7s9PyNmdB2wVLxHXBXMFhjQ42evIHJlxlggZbWJSaOqm4+cdSvCvk0qyJ+DDA
         8/w3By8oG1qhSDjG0uk84iwJ2ZhDHkt5mbc4AP6xD8FG/VaENmZl7W9x28DNtWdvx1om
         AUnsZsLJ/80K3BnSIzGK95eDOqyucxytgYub1K24S4vayZXoD2UQPIMB4xpV4zN1T0gu
         UDdW4f451UknAzKlVdnQFFr4PlvECagbFBqXbkV9LU1HQZ7FeDHP+onpBt7apqcs3gEm
         md/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763324839; x=1763929639;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQx/kxpokBkm1yYs1IBUbAph4a+oanJ91i4iPhyYJpc=;
        b=MHNH1simkdLNJrMekHJnp4AZzqdY2a6fLnoUHDiygQV4SQivf0RacKJ+XAwiN1sz7L
         wsAsyMWAlcpZy89EP5vHK/TrXyeiuKNXVUEeWCQTCW+oWBPdYGO1oS0njo9TsmD/yCbj
         u3PNZ5pfVVvVSHubw60YLqRtwLRp7+f4X49Czn5RKaiu7WY+pMhqeFMh5U8g07ctCwt9
         yVkm39W7UKhYPHTFkBbtkPWm6NeXXAC3mSyirrRrKr0Yc3xG5x2BFj0S9CCqAeZJ4aOl
         ZSYFa0vns+meFndODl/5ijKJ5QxfgIeizrxxz0f3hadp3uRfeRqtK2yl9nMf29cHksxi
         S4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUY6d2zWJ6o2A9RFwYYtJtySXJF2MoLFKJ7SSd4wQ3KR1shWQ0ild7nbMcqztIhb56nRVwW5lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWafZWgIK92Ur97maKEbA4f79pZokwuv+ux/hrs1HfE9Eh3T8M
	CZofe4RoHt+NRkJRWlX1s2mDOZ2Iin+tNz23YeM/kX73wALLKxAINBGPdJomE0Ed0FwfYGgyKX3
	x29+vNQ2FSRTnyw==
X-Google-Smtp-Source: AGHT+IGNKIKL+wEzku0KU/C0PDDZahnE1DbqelirQsqheLu2VhWrxYszkVLevMD9CrhBC2zmxeVzubvu2qYXRg==
X-Received: from qkao15.prod.google.com ([2002:a05:620a:a80f:b0:8b2:72f9:9905])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a18:b0:8a7:c2e:6278 with SMTP id af79cd13be357-8b2c31285cbmr1257499885a.17.1763324838495;
 Sun, 16 Nov 2025 12:27:18 -0800 (PST)
Date: Sun, 16 Nov 2025 20:27:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116202717.1542829-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/3] net: expand napi_skb_cache use
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb()
with alien skbs").

Now the per-cpu napi_skb_cache is populated from TX completion path,
we can make use of this cache, especially for cpus not used
from a driver NAPI poll (primary user of napi_cache).

With this series, I consistently reach 130 Mpps on my UDP tx stress test
and reduce SLUB spinlock contention to smaller values.

v3: Addressed Jason feedback on patch 2/3
v2: https://lore.kernel.org/netdev/20251114121243.3519133-1-edumazet@google.com/

Eric Dumazet (3):
  net: add a new @alloc parameter to napi_skb_cache_get()
  net: __alloc_skb() cleanup
  net: use napi_skb_cache even in process context

 net/core/skbuff.c | 48 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


