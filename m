Return-Path: <netdev+bounces-174102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE1DA5D80A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8381618947A2
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D261EA7C1;
	Wed, 12 Mar 2025 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FS5m1qLM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1644722FF58
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767775; cv=none; b=rUdDC8AaTYYzidWoI8PvdEmC61av0932UUMUxsu3rSXzilntEy8dOJ0lVEV/JoC7Qd7MSfLgg0FMhjnzbSGdpHrWCEkKA6JHq1Yk0ERke3yFi4il6pPl+1fCtQSpHcKyoOXCEyBJ9BSnynBzNHHfM/QXbnXj5fIsRSQByXzUbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767775; c=relaxed/simple;
	bh=W480WHRxxuv7kuTztvi1tctAlHJ7dX5pERZkltFVQ6A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C17zOHvJxjOTmkA3CaHjAlnyy6P/5ZsZ3GAOdtI7F3I+PHoUQ+umXLtsULNPwyE0Xmief/3L8lWw8uV8EwiZTIEHBllOyTljMIisPKq3GaT3ylhj/rr0LB48/QeOj72u59VYQBCbG+RM3x/QFRrY978AUyKZS2UVFCdZSWFYH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FS5m1qLM; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c3c5e92d41so1190151685a.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741767773; x=1742372573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DeGgwQpl0wSWpAJw78snAuMR6mF1sORXXQQcI7BJzT8=;
        b=FS5m1qLMZgSz1FB6F5JZ0BXLXX5hNB9oRqzv0OWcdESJjpXdk9kuW3CoEm4EqaSEsA
         zGBpy1rKSkAL6Kufdhn0Bo7jI2000S+4OgFoPEtVye8jopOKewX48eK9SutdJvIsErFR
         whmKeRmudcnDb5e4HCcpuMbb4GLaw7wb0TVeHVSl9QDbReHR484gCALzeONMaJ8+MC15
         UB46uP0g+v4z/iATv48DH71fsGsMJk9UrkrUmh8SON2R/6Xn3hzLe5+cdHYNfYtHfj/J
         +cOJViCWPUUSdR6Dc1VU4bbQQIhnD0YDfjxdjLwi9h2g63GYxRH1QspZ1Kduc7wTMjV1
         yODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741767773; x=1742372573;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeGgwQpl0wSWpAJw78snAuMR6mF1sORXXQQcI7BJzT8=;
        b=hLhhV36raaf+3PQnnKL67SxRGmBsfY0D83FYVPar3d2zMBKc9v8CQSfV8Ogxc87Bvs
         GOmJvsId2kUFy9yo8ys2pPQIbmsb8inD6SbCL1tv4x+w50iioHJM4G79ktkQBao4aZQV
         ytvjWcykB6He3v6WYgrRqGe+RaAev79Y4m4q1ntDFQfSf2GvYCvaIYt/wTLor+dOLjOz
         nZNG+pNuiHkm19gfP0lbVGBvsMcS1b8WXfkHoy0+bix1HdfYA+HOaZmA0AUyucixm4Bu
         9lsYCUTQY67xil5tk/ELh1qszCboiWEpvSumHcnSiJkL6Vd8GamfdOv54iMr4PCt/NQ9
         gzQA==
X-Forwarded-Encrypted: i=1; AJvYcCWlmoEbQ+sFGl1167uJEhlcYbu8UBQYYot/ZIz9RddNpj8pUawFFoEqNVsdyrdX95L4G2tmJ9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKuKCokqAuUuYOizYInFIeFgdvGCGWa5bUG3aP5ZgFWyUBqt0Z
	AiQKqOtHo3JrBybvWJh86x7mlPcVEuddb2q73na90l/okmHx1Y8EPD9ocHXoRwA+/y94oM0VEnx
	aLcGGTGzHYQ==
X-Google-Smtp-Source: AGHT+IGkhNzMMi2bArkt+wZRgTLvymNSpzZzTNrKu0lSrWjmE9BepsDS5ElivmNaiGnROAomyc9XkKwxp2lQqA==
X-Received: from qkan15.prod.google.com ([2002:a05:620a:a70f:b0:7c5:3d32:f6f8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:27c4:b0:7c5:4adb:782a with SMTP id af79cd13be357-7c55e843b97mr1119479185a.9.1741767772950;
 Wed, 12 Mar 2025 01:22:52 -0700 (PDT)
Date: Wed, 12 Mar 2025 08:22:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312082250.1803501-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] inet: frags: fully use RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While inet reassembly uses RCU, it is acquiring/releasing
a refcount on struct inet_frag_queue in fast path,
for no good reason.

This was mentioned in one patch changelog seven years ago :/

This series is removing these refcount changes, by extending
RCU sections.

v2: fix a compile error in net/ieee802154/6lowpan/reassembly.c (kbot)

Eric Dumazet (4):
  inet: frags: add inet_frag_putn() helper
  ipv4: frags: remove ipq_put()
  inet: frags: change inet_frag_kill() to defer refcount updates
  inet: frags: save a pair of atomic operations in reassembly

 include/net/inet_frag.h                 |  6 ++--
 include/net/ipv6_frag.h                 |  5 +--
 net/ieee802154/6lowpan/reassembly.c     | 27 ++++++++------
 net/ipv4/inet_fragment.c                | 31 ++++++++--------
 net/ipv4/ip_fragment.c                  | 48 ++++++++++---------------
 net/ipv6/netfilter/nf_conntrack_reasm.c | 27 ++++++++------
 net/ipv6/reassembly.c                   | 29 +++++++--------
 7 files changed, 89 insertions(+), 84 deletions(-)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


