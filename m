Return-Path: <netdev+bounces-196544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD6AD53A9
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F017188D9CB
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34556239E72;
	Wed, 11 Jun 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="15owc9Ng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6372E6134
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640527; cv=none; b=dYNlrAuZ7zLYY6gt4rGTSYmsZol7yykCshmDsdnvDXfiq6DELw8AgMaEskNQhOVcahXKDC450/KXOxWfhmFEbtYorT6Kmtc523dN5pVl9Cq4MSrQGnSK6Qi541d1hR7U7p6JaAXOUWucCg2PJmy3g8i28iFzI61A86gWuv6jUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640527; c=relaxed/simple;
	bh=mpJX67UARFLWKGCFiOBDV0BnZqpCCV9N5k1Ho3dHLjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pLHm/2G5QldUeuZV63nVTytzmYCO9Ylm7XBz0V5VCz87v6TVIEnWPVQL3C5P+RuSSDu271uV9MKL7RhPY1jKvyDf7dt+q4I1Ja7eD3KKZeq6eRPboRHIi2q+MoxCE4sc7CGM7Wpog7FrXbPsW6cJe3bIAWfeNGT8OgxayFZirYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=15owc9Ng; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a6f2dbdf84so66080441cf.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749640524; x=1750245324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=doR8jFOsTWGxbSAA8FIyU8ln5P3Cz7PlBDy/7CACM/A=;
        b=15owc9Nglu4HDC9QwDINW+dedJuHfE8ilnAhb2M5XkhWIEhJ/O5uyxd2NkKEVJBaKR
         6ZvqZ3W/Yox+G9kX6hDI8l5WjclmIPB8OKDdgq+xELpxvUrHZLCWeUwABEMoropY3OXA
         MKsbP30Nze+XGG2flwr14CzNucaT1ln58eDR9RLawlf+zFrM+xalBjqpQWYQ81UKMRXa
         U5jk1hJK7uufOmJ3AC/9NLBPW95ogLyBWEgDmor4hLFxGOoeyLLL0veU3Zx+1zMjnAsx
         a8jnZJ/W3oQWOP6t4XXjaE83jiQWOq1jNczmTss/mF/xvoqEAE/CGeaeuh66CvtOQ6y0
         mJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640524; x=1750245324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doR8jFOsTWGxbSAA8FIyU8ln5P3Cz7PlBDy/7CACM/A=;
        b=VC+lYKrzShpPxruXxjPD+ZgGKfFHl6/zUo8Sc8A8qky9V33rSKRbnOnVxZNJY64r9b
         CTAAOU4KdM+fdMsb7Cs93bJ8kNOW1XTSIUvSAZHjnsrPXzAyo7782ooNqgqI32lsXQIi
         gs4xm0dBX9whl6e12S6Gwowl+Z1lvLpkTamlRHOV0OW+fUSr3OA1GtTrJPj4iF49iSgu
         N2QXM0FHnuNXXCRS/GZoViKybChd8SL3uv86FvtF5ZspgOZaAPORumihiFUhri3JGwqV
         wSVt7jGtdNEl+RvZl48lBHuyM7TWaPapNH5HqRGPT40Tudsve1epAGRhyQUfLMbEpHJp
         pGFg==
X-Forwarded-Encrypted: i=1; AJvYcCXdzrYXeAag8Jik+JLI47ja21Fxd4BnIvuqQkFrzpUZvfVO+A+vy/8zvzgN6FlI7UGgpczlhEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlrZrQE7RxKCCHxS4+Hk5PhMFGMofWjm69EExYWHL6tybbymK
	SShj2T2uF0R3aEPa3r65+ck3DeMyjQlm9oCQ8wZj8VzzgdaR6pzNycKG7/aZOg4HvNfonVtH2Ub
	W25jC3G68CzHGoA==
X-Google-Smtp-Source: AGHT+IFrT2ScoDHFpFL1BECFp6RbsUD4Xv3UyWMJ0i5dt0W3rWarksPyTmXYAPilAtMrEGtZq2zyuy815ffJxA==
X-Received: from qtbge27.prod.google.com ([2002:a05:622a:5c9b:b0:4a6:ea91:5345])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:260e:b0:4a6:fa8e:50a8 with SMTP id d75a77b69052e-4a713b952d7mr52625011cf.2.1749640524510;
 Wed, 11 Jun 2025 04:15:24 -0700 (PDT)
Date: Wed, 11 Jun 2025 11:15:11 +0000
In-Reply-To: <20250611111515.1983366-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611111515.1983366-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611111515.1983366-2-edumazet@google.com>
Subject: [PATCH net 1/5] net_sched: prio: fix a race in prio_tune()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Gerrard Tai <gerrard.tai@starlabs.sg>
Content-Type: text/plain; charset="UTF-8"

Gerrard Tai reported a race condition in PRIO, whenever SFQ perturb timer
fires at the wrong time.

The race is as follows:

CPU 0                                 CPU 1
[1]: lock root
[2]: qdisc_tree_flush_backlog()
[3]: unlock root
 |
 |                                    [5]: lock root
 |                                    [6]: rehash
 |                                    [7]: qdisc_tree_reduce_backlog()
 |
[4]: qdisc_put()

This can be abused to underflow a parent's qlen.

Calling qdisc_purge_queue() instead of qdisc_tree_flush_backlog()
should fix the race, because all packets will be purged from the qdisc
before releasing the lock.

Fixes: 7b8e0b6e6599 ("net: sched: prio: delay destroying child qdiscs on change")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Suggested-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_prio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index cc30f7a32f1a786fa1c3937a1b9d5c96a52e56e7..9e2b9a490db23d858b27b7fc073b05a06535b05e 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -211,7 +211,7 @@ static int prio_tune(struct Qdisc *sch, struct nlattr *opt,
 	memcpy(q->prio2band, qopt->priomap, TC_PRIO_MAX+1);
 
 	for (i = q->bands; i < oldbands; i++)
-		qdisc_tree_flush_backlog(q->queues[i]);
+		qdisc_purge_queue(q->queues[i]);
 
 	for (i = oldbands; i < q->bands; i++) {
 		q->queues[i] = queues[i];
-- 
2.50.0.rc0.642.g800a2b2222-goog


