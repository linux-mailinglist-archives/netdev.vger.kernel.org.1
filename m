Return-Path: <netdev+bounces-238662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22233C5D09D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784833B05ED
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27E93128C0;
	Fri, 14 Nov 2025 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJOkFsmt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA102F744C
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122367; cv=none; b=bzJwt4a15GKazKAtXh/p2BhG+DQkEeVXGZ3/aW8Jc89Ylo4Aa6jg/1CAe+SOe4t+0AJbF4KMaKyRo55T67z0tMrLwoSmeBG4ZN9wo01Mn154QEA7W4d/5+N4fylu4ft4yLffab2CS70/OxjvP5QM1dN8TUv7Y3fPgra2b8o98Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122367; c=relaxed/simple;
	bh=0h/4LAmb6g7DfaD3euF/jAhRVi+DDixsBDwFDDYx6kc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nFZwifb2j2AxWm0rBdwBE+rmN3G4cf608RWAWbPZoMqm244FD2t0KKtkn4xmvmVIJMO+up7c8aEwBBC83IrZ/92fWd2rAGIBDIeFLTykoQTMle5GK1Gtlz1FSkSMx5RlEHmhh0BAWevCvIxrS1itNoLsfRx1DrGY5nvw3R8Esng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJOkFsmt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-78933e02c1bso2791937b3.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 04:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763122365; x=1763727165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NpC/PCuWdReHRRuJko8rFdYG4zq0pVC7Lc1YJ44CzCc=;
        b=oJOkFsmts1ZRL+gONcRz3RKH90c4TWZhMRCUSXdHhzto65EB29qBAl7tPeOjwlNRnD
         NfsaEDbnxl1eOvvlpbxIv3esGAEwQxuW8UobtmkuYRck6pv5tx/8pwkeFPpaVYtVuCAn
         pKucMXYG0EYruY8DDsZw2vFDIUeKtRdBSWmLYr4s2if9grS1lcKOv6Pppb2t4VkHzQGz
         JavvcDSjYdP00VXxIksm4/+IA1K9RsdTIZAJsDA4tn7Cj+k3/j0iHlL5LHaj9OAUrBoG
         ya8wTC3GFQ6t5vJhtuzWZKkU0Kih+3zMRT8Uy+KL49A3s6CzwYOWEjKOo4K7MBl8biCk
         WPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122365; x=1763727165;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpC/PCuWdReHRRuJko8rFdYG4zq0pVC7Lc1YJ44CzCc=;
        b=gVd7xFeI78Q7Bfll9pclKC1/eqk5LXhkb+u0GCQvYC58JhIFPBOsoN3eScOwZ8Fvg4
         sLbIyGx1CSikffGxPf42tjciPHbwCZ5LB/2LinjB4GRmJsqysZb/qkwzqH12yClGwYru
         t5X3A4YUuPhHLydp/7pWEhvaq5pOB0j2qjKfMZsQNEuvVLdDGzV3Q+jTUPkzl7swy6Ma
         jAgECTcq2Z4sl+TSNWP+yCBOpRxd4WP/9+KvaF5SvUTZhGR83VHZuYc56BZcPn0V7kPd
         SyCkgCvgeqcnglVwAWfwwbH79GjzHx+muov4tzC871Y4DfPQqHPmKM4vWEiq14dxpS/m
         lvJw==
X-Forwarded-Encrypted: i=1; AJvYcCV+9W64MyMyMu7bmfI/lY7TrmI5mBmps9QUvF2KnHNTJhI+RHWaFNQdhbtFfGrynQcvFoEbgEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPjeXjH2ma0svPU52cGUBtOpii6OBaGlLwcogK/NPSBL+zv0L
	ZFteJjjjIkhNyAsFgnzCSQSSkfoF/dJIcCSMhN/oZfZC1un3NKJzrvNgUmkVjuxNGWTKRpLjYTy
	VlwXnoexv4oRphQ==
X-Google-Smtp-Source: AGHT+IGe7c7CM7v2HWJoBvjRnKobc2S42u30GGsGmFFw5sn1c0VYdBZ60hhnP6d72ina/qVZMC7ZBPhzT9tyvA==
X-Received: from ybqe15.prod.google.com ([2002:a5b:88f:0:b0:ec0:c545:8002])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:660e:b0:787:a126:5619 with SMTP id 00721157ae682-788205edd78mr64481877b3.11.1763122365006;
 Fri, 14 Nov 2025 04:12:45 -0800 (PST)
Date: Fri, 14 Nov 2025 12:12:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114121243.3519133-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/3] net: expand napi_skb_cache use
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

Eric Dumazet (3):
  net: add a new @alloc parameter to napi_skb_cache_get()
  net: __alloc_skb() cleanup
  net: use napi_skb_cache even in process context

 net/core/skbuff.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


