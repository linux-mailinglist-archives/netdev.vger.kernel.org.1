Return-Path: <netdev+bounces-219941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9F1B43D1C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AB554217D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CC9302CA6;
	Thu,  4 Sep 2025 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohkmD2BQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1EC3002D8
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992360; cv=none; b=GsJje/T+/cHv6VCsj0B6lETSuTal9d1udy6E4jEBG+D/o/kvyCIMgU1Y0uAsjc83sTlHgHtQ4/RNhNSpkPwjarnSoEgDRp1z+EGP/C9HgQvkTcLbOeMt4XRTMT14xj4pZ/d6ypV4sOjvXCro5WKMmzd3tuPp6mttzYeA55lOAXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992360; c=relaxed/simple;
	bh=sb6Kxlmejddd0tUY47YICFy6lvnT/yqueXLmemKkczQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cLkXRntjxaeuoAbyn9MkdkcnZikXOEmrH4MmxXXVxVUsM6os6EyNPSH2rJlRIbli+TbMcod+4YWoGF/rKq/J2t+rmwgD8WtvB/V7LS6PNpF7dEGR7rjX+uNvYo2LavF2VlIX2MIrvF9PNlFpcIfdHEjjC9dIRG1mkB/lb35ikmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohkmD2BQ; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e870646b11so230529085a.2
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756992357; x=1757597157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QX+rgbGC5nOPjv/m79hzIrArC65aRzslMvQnWhwDZ1k=;
        b=ohkmD2BQCzYplb7KtlS8lji06PI9aK4EbApRg+Os0JpRyY90R0PdkNesuztOCfCbv2
         M25ewjGFub7DhtLRw+e9fYYIHV/sTLHMrjAXeHXZdQ2ccxEm8GKK0LQ2ypOKHXcJPIRC
         alV7dp07iBDxzLoCdAZgbcmm7yOHR+aarXJB2S71Z8jYpCdB5uN6/cEPe1RbWTUn0yZW
         uC9HoAbQEoKBIevaawXCzQxEy6l63sf7oKTwIXhtDavNUo6GrZeN5bzzl866mw2tsvEn
         +5PTOkTMw5AS+pzm0v/+MllXZgwS9JAl4QoZ71gw2dXrSCNT+oYGvN0s+09fkQ168kkI
         2EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992357; x=1757597157;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QX+rgbGC5nOPjv/m79hzIrArC65aRzslMvQnWhwDZ1k=;
        b=aqZW84DLSgpfc1DCTIH55zVnvUgKU1nrJHb57+JXp6wEYWcVXE4ckAzkHM9eXNPCoJ
         AGnzNpBsh9m24P2J5bakl8BCAOZqtP8g/FY9clGrpYP3ct7bg2C1HJyXygB6AcmuYjuH
         81jKpXBT3CG9TMWPUoONtg1D7wvplZBIbkdHddOrLjCNfS9mtEw8/dCAwRwpcjuPylTy
         I07KD5ycMgkCKYHTFQTjemgt+TCBU+7U74AUICmewhybJRQSRVpOyIFJxyrVUcfy/1rN
         X17583ccC2CPU+TmNcgacLNbVyn248XOE3i1qFHC9BX/zdwZWV6opRo2T3cPxyxDa1+R
         gLUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVvMVUUvdrJ7CeYvJ7FR8+WCUvaxWoP98uj/ZZz+YsjuOh9GSEV+CqLzJp40H0JnqysXINKUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4URCzdnAu0D4vi5xAkCPWhyFSjnvgnaA4aLs3Omg9NpYxo145
	RziO98fsPfUtetbf4oZFHFHxwFgpMITAtch6q1bD3+Hw8aGZqxVzjBxBsWJbr/CbD8hdkSOqkwb
	uv0jkuBnX6simGw==
X-Google-Smtp-Source: AGHT+IEUXkt6paEcJeG+BbIYiuVbZff7cq/lyTwja9S/P8PUbnSEMZZsntFzjPrwl6+qSwV2j9wxLyOeLBKaDg==
X-Received: from qkpb1.prod.google.com ([2002:a05:620a:2701:b0:7ea:681:9611])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:394d:b0:7fe:71ca:a5d5 with SMTP id af79cd13be357-7ff26eaac2amr2306778685a.10.1756992357420;
 Thu, 04 Sep 2025 06:25:57 -0700 (PDT)
Date: Thu,  4 Sep 2025 13:25:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904132554.2891227-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] ipv6: snmp: avoid performance issue with RATELIMITHOST
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Addition of ICMP6_MIB_RATELIMITHOST in commit d0941130c9351
("icmp: Add counters for rate limits") introduced a performance
drop in case of DOS (like receiving UDP packets
to closed ports).

Per netns ICMP6_MIB_RATELIMITHOST tracking uses per-cpu
storage and is enough, we do not need per-device and slow tracking
for this metric.

Eric Dumazet (3):
  ipv6: snmp: remove icmp6type2name[]
  ipv6: snmp: do not use SNMP_MIB_SENTINEL anymore
  ipv6: snmp: do not track per idev ICMP6_MIB_RATELIMITHOST

 include/net/ip.h | 11 ++++++
 net/ipv6/icmp.c  |  3 +-
 net/ipv6/proc.c  | 87 ++++++++++++++++++++++++++----------------------
 3 files changed, 60 insertions(+), 41 deletions(-)

-- 
2.51.0.338.gd7d06c2dae-goog


