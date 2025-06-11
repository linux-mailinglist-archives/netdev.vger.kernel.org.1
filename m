Return-Path: <netdev+bounces-196547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9EBAD5379
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D49E16DA20
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1A2E6135;
	Wed, 11 Jun 2025 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DdfFJWPX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4425BF17
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640532; cv=none; b=DRUQcB7zE6OcuqsL/tOKLEs9XUp5/83KfAJ0yZInJDvWLyYC7a1fwYUzf4kFwLncmSjUqbwmyh3uwCLm86n26i/6JQRcfIWp8GATZUZRl249ZaaGAL4vYXSGIfaA0BOEh1cGHXnRdWRVFFewcFV88YGsNzSBRKpVx7q/YTlYGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640532; c=relaxed/simple;
	bh=eN/buS65e1c2gM3ZRs/2frC5zwmC8gBSEiRd2m7LMx0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rM2dLrhHs2dKhU0esSMOmJiK/sgH8hYyQvjLwAEKlU225m76A+sOHs4gODANpwLgr5lVieQMsS+1sAg+OKx7xaIXTLH2YiY+hIYk6GKCDLHGTV9xLNqpgt59d45NV/el7ED5v79UDkgEGUI4gC291tdoWsiZSXT4ILETwscT270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DdfFJWPX; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a587a96f0aso180877821cf.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749640529; x=1750245329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhBGU31Qf8tX9qqrB1w6kE4Dw6feEYCijcgIY+8QHo4=;
        b=DdfFJWPXSlWpEe3byoLd9bZB2K/YF5Bvu8c34xlgF9BeX0CFKT+Ss6ngqM0hYjfSvO
         qcBTWTHN2tFQMUldYO0blprhdQSMc6jdYZyMM2ppC35E6tf40poPcz0NAWBLc5BrdQ96
         qvtm1Tuz9NbVgam4ZVSvOWE6PfIBeoVIhyYMf+SHLWHalUnyvvo0pxJPECKYjR/9XTUI
         EJOAkgvOEj9P5io0tGA9K9IWU8ImeZTc1sNg/RuIwQbe6P33uRCm8bmf1mMVEKuA4uvD
         /ZvUAIXZC9dy6Hn/vjY7+6biurYPJemCglXryU1cC5MUL7OMW5nfZaXx0tgD+6tPisKX
         7BGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640529; x=1750245329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhBGU31Qf8tX9qqrB1w6kE4Dw6feEYCijcgIY+8QHo4=;
        b=JIelbKI1+9E2I/DwTW1UPtrKaFVUUnsPO935N2SfIxCVmCcjwPvCBIGT9c+kbjWS/m
         FDDlbA35TBkVmRHxIDKBthbZrCDjN838qXW/wrsx4j+m7/LBb8r56OgycVEMVqX76ikB
         +5WwDRVVtV15U0a5Dg9d0aOm+lAQO5UcSbem6W9QnT4ze9wNsMni5K/Go8Lg1fyBJAfv
         aSZIqMDuLqiUNrUowLc2ej4x9THTlO154F9Oq7naTykt0WskSVB76MG3MmVGWqis8fjI
         UNK8ASR3KDiTt0RXAz05DNvUatr7y1W7ZgyTrb+fSHCjoHql2ptSMOnmAIiL2dqwbgS3
         +6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGSTYoyfAtl3ypssXD8QPdVne7FO2JaC/fgR6CfcNcZmRG6eGw4qsxHyc/ZssdFAYt9j9NVbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtKCoPbDb//JONo/Ngpl53NiJb/RbEnWJXxc4nPJGivFzL3PH
	2JzGFOu0u+1upEP81QoRdRMPjz7n1Sf2DwcbR661iQ3EN6oSFcXww9mBhhKMfKloQlosuwurQvo
	tBENFhE8SQLXIdQ==
X-Google-Smtp-Source: AGHT+IGRxWpU2lOUEXf5L6V4ifWBPCrcUHS6qTfRnLyqNM+vHZUodL67KSp+33j1pDWIf5nuhi2+K1KeoOGLnQ==
X-Received: from qtbcc25.prod.google.com ([2002:a05:622a:4119:b0:4a4:3edf:7931])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5c0d:b0:48e:9e05:cede with SMTP id d75a77b69052e-4a714e08562mr41430801cf.52.1749640529634;
 Wed, 11 Jun 2025 04:15:29 -0700 (PDT)
Date: Wed, 11 Jun 2025 11:15:14 +0000
In-Reply-To: <20250611111515.1983366-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611111515.1983366-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611111515.1983366-5-edumazet@google.com>
Subject: [PATCH net 4/5] net_sched: ets: fix a race in ets_qdisc_change()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Gerrard Tai <gerrard.tai@starlabs.sg>
Content-Type: text/plain; charset="UTF-8"

Gerrard Tai reported a race condition in ETS, whenever SFQ perturb timer
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

Fixes: b05972f01e7d ("net: sched: tbf: don't call qdisc_put() while holding tree lock")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Suggested-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_ets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 2c069f0181c62b5387118822dfb7a51fc1b3033a..037f764822b96526329a4715bfcc22c502495f14 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -661,7 +661,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	for (i = q->nbands; i < oldbands; i++) {
 		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
 			list_del_init(&q->classes[i].alist);
-		qdisc_tree_flush_backlog(q->classes[i].qdisc);
+		qdisc_purge_queue(q->classes[i].qdisc);
 	}
 	WRITE_ONCE(q->nstrict, nstrict);
 	memcpy(q->prio2band, priomap, sizeof(priomap));
-- 
2.50.0.rc0.642.g800a2b2222-goog


