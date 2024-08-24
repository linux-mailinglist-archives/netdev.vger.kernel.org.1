Return-Path: <netdev+bounces-121671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB595DF8C
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 20:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F76D1F2106F
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 18:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3BC4E1C4;
	Sat, 24 Aug 2024 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fUxhzjsV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E57757F8
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724523545; cv=none; b=p99ip5hQsDb70eTyG/+cEZ2SUV8zWfjNmmZ6xJrZkeRJE6vJe40aTBSN+bGztTKlonvGy5T+/5CqLBZktLe1ffe3+SEv4KWluMyM9vqtGbHTPfMUxYgMzihtL4DRslM90NSitISAfh/eUs8zBGKlSy0LetnueeUY3/t9A5ii5v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724523545; c=relaxed/simple;
	bh=mgLtJs1gBTtxZVcFgP52ydo6C3r7dyN2g1tGMZL2hCQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PqVG3YeREe144QQVoy9GP7PW/lNLG4G+XKrTwr4I7tlIDZTrvmwMwUxVMdf7L0Qa7OxS+NwsCCfB0/VVtti4jtj/OaWgKyAT6Vf4DkiD2qVcXwcjjybB55KuUzMkX+2TafkwGT7XqVjqts+5cD6HRtL21TSFAbdm6iLAoRCG1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fUxhzjsV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so5066501276.0
        for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724523543; x=1725128343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6dduyjs62ErsiSFfBxxirB8ys1X0uBDz33xj1k7gJGE=;
        b=fUxhzjsVEqaWh7SVZTbSD0D19Dt1gXd9DdhXCGyMwBrV4lNM72+sbNJWLf7f60SJgA
         8nmDnxuhPkdsk84uhAYZUnqcI01w5Kl09CcN3j19EsGgWHd5CO6xM2RqH9KwiID+Av4o
         mbTsEYlONypQYDEuoaMu87Cr/cJSQDgIAa0T4LG1THfailYWTik2EduuvMoLVm+cdUia
         ANxCzYFp9Pcyf22MlAIT2tv43oHzDUMW/ol7bFUtVXKRK6Ts7ShJ702OITr5NrO5nvzn
         fDsBteq5HjutctBlW3qkb+Blme4D33DL7tkCCBFrMjudqYRJ2FDMV/cBYo6yhEW8f1gP
         msmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724523543; x=1725128343;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dduyjs62ErsiSFfBxxirB8ys1X0uBDz33xj1k7gJGE=;
        b=nvuy6FeS9a8QdRaNLU/NJdslel4W2k/JnQIII22CP8qmfPDAZ+HLr9DlHSjv+fRpCs
         Sy+MjjB/SAf5aVi+HmED8fLuCgJS3I2+HBRLk0AKTnpuN908s1C0PcO+QzgNgfVsBYi1
         dV3MK9aWJ/QpW2EWZSnb2uNRO0TYuj00DLmj3JCWYmQJlkoqddnpKULZ76LKWq5I+MqO
         h6cZ8IjS5XJV3wdCV4eHc4MIEnDUzHN5ILVl9ANCXgcUNTZJf6s/JhXG/sD9w8ADIJ+m
         s61oMGXJcGPjH2a+J1Vhaty9Omuidr2Oa8Q3Grub7JMhZpPZbNd6Qe2JLXrVNCb0Clwq
         QeiQ==
X-Gm-Message-State: AOJu0YwkRG9Kxwmx9nxEu6hSJt4IWWEz0TjB9iP3mYEf7kNAevTmv4Hv
	sYYNTownjku+e/Cy6YCeBknSYr61dS9qI1K5Xj0OoM7niLreQb2t90i9vLxGbYmszSBJC6MzSj0
	k7dBSHkDwQA==
X-Google-Smtp-Source: AGHT+IFGnN5UaFm8FCq2sK1DpSFamhSGGWH6W/9Hd3EpR0nZguzJtBp/EuhslBGuOmbxc/z9yEVZMS+amS0BGQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:aa6b:0:b0:e11:44fb:af26 with SMTP id
 3f1490d57ef6-e17a83b0661mr8978276.2.1724523542987; Sat, 24 Aug 2024 11:19:02
 -0700 (PDT)
Date: Sat, 24 Aug 2024 18:19:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240824181901.953776-1-edumazet@google.com>
Subject: [PATCH net] net_sched: sch_fq: fix incorrect behavior for small weights
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, John Sperbeck <jsperbeck@google.com>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"

fq_dequeue() has a complex logic to find packets in one of the 3 bands.

As Neal found out, it is possible that one band has a deficit smaller
than its weight. fq_dequeue() can return NULL while some packets are
elligible for immediate transmit.

In this case, more than one iteration is needed to refill pband->credit.

With default parameters (weights 589824 196608 65536) bug can trigger
if large BIG TCP packets are sent to the lowest priority band.

Bisected-by: John Sperbeck <jsperbeck@google.com>
Diagnosed-by: Neal Cardwell <ncardwell@google.com>
Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduling")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
---
 net/sched/sch_fq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 238974725679327b0a0d483c011e15fc94ab0878..19a49af5a9e527ed0371a3bb96e0113755375eac 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -663,7 +663,9 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 			pband = &q->band_flows[q->band_nr];
 			pband->credit = min(pband->credit + pband->quantum,
 					    pband->quantum);
-			goto begin;
+			if (pband->credit > 0)
+				goto begin;
+			retry = 0;
 		}
 		if (q->time_next_delayed_flow != ~0ULL)
 			qdisc_watchdog_schedule_range_ns(&q->watchdog,
-- 
2.46.0.295.g3b9ea8a38a-goog


