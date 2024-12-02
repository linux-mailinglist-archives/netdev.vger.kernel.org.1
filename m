Return-Path: <netdev+bounces-148147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345ED9E08BF
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4604016B0D5
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3521925BC;
	Mon,  2 Dec 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9/Aq6fw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22571192B65
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156582; cv=none; b=tB+zcRYOtNB+wK0LC5RvKfxwNcOVkrF5JMRssISvsS8rwq6hm748WS5BTCDYHS+uX7qZXy14bRTLZZHpq2+mr7SE92j/+t0mImSM8LsKL8NSB4nWuC6fXTMOIIBeqKbyJSN4A5WektFtF9EFvv3jFUsTr1Q5TWTLvjEOgbFhB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156582; c=relaxed/simple;
	bh=Zsms+C4NOXG/Dy3KLtJWWY/xMoO7EcT/34IHBJcUaRc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Su9q8XmWfLPdhK+gYKDEtl7x2Z/RB45qXoxAsyLTfXvChopDZ4ounXPVpjQpVvwNxS6DZOQUyTAJ7X2gpvEOzQBqtk5F85D4D4vv3LRpP/uq1sMLrTic2pOLqAZ+Oh+N9i6JQu1UnV8QPb5wp9mbmi3iujS6nmDRRrVEWUM7uOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9/Aq6fw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so41385385e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 08:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733156579; x=1733761379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YxeGxBXYGXTZb93lQ9kig+HGhN+3cwpXcO70XlpyaE=;
        b=O9/Aq6fwA1vF5+W+MbU/1/vu0BggBMHjcI7HyYGw1+t2R2BX8/qRcRDfIE14eZNhoT
         GXQSC36ziFv5zVdedDi37MiI+QUktI+kbwOlqZgHArckkBOZGw80c6+jwDBTV/GWwUgT
         iuKAeYvnAvEzviVUII3UBbaKf4WR1PRc/fWUBacnxjoNN2DSYSIw5dA7P6HTuAT/LrwP
         7un5YgNoJIuBuwRzn9EGBEafZH64ckFm2UuGtfUuUkNC7YWmX3HJFdaDSLQeVPvlymrX
         t4TikPfdyfnA7nJDLtm27+KiVmJYkoiBfrUiLm/KZdtoTfhkzUV08imLSzFMmp95W7nJ
         ydWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156579; x=1733761379;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3YxeGxBXYGXTZb93lQ9kig+HGhN+3cwpXcO70XlpyaE=;
        b=meD05P3uvhKwPfcKFdhZzI8mwOlTpT1Od8UpjhaDu1W0DiKfQLEF3DUJKqHf1Sd5w8
         qNwbkP1TUs6gpbNO/i9uNJnXRKA7Sd3r0FT3HgXFHhu8TKO8kyYZpds7Fbb2X6iCKBw6
         L/tTKjsoLfKcK9HjNxbuLJEZLps1s+WRk9yhuOf/3vsRv+VBbvRqZyRc2kAHIFPJ5aag
         wDpIouDlMEKfXct/mPhveyDwhbyGwrucNfgZVir4/VRh978nzSlhA9r96n5SLrAH6/Mp
         lVx9UUFLwum1eilljfI5DprCz2TKJs3Idfk14A45j97XXnZ6TtfHWLmlGp6SZk+4efyJ
         GxEA==
X-Gm-Message-State: AOJu0Yxzng7+zxMqU1zGGdlYuG74bO1IbzBsn68G3V3TmrgKBbVLvE3H
	sJ8p6+6ih7FH61I+hy4+2uJ+o7+QtpTSF2E9QijSLBheLa/4w4BKjy8jTxu+
X-Gm-Gg: ASbGncvoMq6fq64SeC+HxJV8eOIfiuuifrgvcGDvfMwvl6wTRuExpiyJssZR2bisxRg
	Bb/54n2JK9kxHSq+Px3Pa3IQGKQxOi3BZShw6DrfINgbsrjnUAvXYgjIAbgJ31zg8XlPt+rHBdb
	Alybr/R2s2xpkciA3dL239kAtTxXBaZcdWWrpvRD/KXAOQ1Zxbs6k0b+2zH3kcPWLZ0/d0661Yb
	eerAHXs0aOYVRQ0+E61e654eVBN+i9wnmAwHgagDmtShbpS81nE6jnjTskquX2Z+mfdqUARUp0o
	Ds3/HtzdyX8+f3RpZ0r3dK37waD0zvrdVmZEzbk9dOud/Rsisy1PIS+1AR1y/oM3++kVbOGjh10
	p/Q==
X-Google-Smtp-Source: AGHT+IHJMnMvpKq7Hj7JyQcmDN/8Ny6qODY6Et1O1ZBQY+4XeadXXH4b5DxlcqU1ywMejxBx32c+8Q==
X-Received: by 2002:a05:600c:458b:b0:431:5f1c:8359 with SMTP id 5b1f17b1804b1-434a9dcfd5emr222330845e9.15.1733156579093;
        Mon, 02 Dec 2024 08:22:59 -0800 (PST)
Received: from ?IPV6:2003:ed:7731:2315:f8e3:ac9e:6d58:8a90? (p200300ed77312315f8e3ac9e6d588a90.dip0.t-ipconnect.de. [2003:ed:7731:2315:f8e3:ac9e:6d58:8a90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e2c84d52sm8119292f8f.49.2024.12.02.08.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 08:22:58 -0800 (PST)
Message-ID: <6c7ae1c8-8573-4f4a-96cb-0a75eab21516@gmail.com>
Date: Mon, 2 Dec 2024 17:22:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Lion Ackermann <nnamrec@gmail.com>
Subject: [PATCH] net: sched: fix ordering of qlen adjustment
To: netdev@vger.kernel.org
Cc: toke@toke.dk, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, nnamrec@gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Changes to sch->q.qlen around qdisc_tree_reduce_backlog() need to happen
_before_ a call to said function because otherwise it may fail to notify
parent qdiscs when the child is about to become empty.

Signed-off-by: Lion Ackermann <nnamrec@gmail.com>
---
 net/sched/sch_cake.c  | 2 +-
 net/sched/sch_choke.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 30955dd45779..a65fad45d556 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1542,7 +1542,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	b->backlogs[idx]    -= len;
 	b->tin_backlog      -= len;
 	sch->qstats.backlog -= len;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	flow->dropped++;
 	b->tin_dropped++;
@@ -1553,6 +1552,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	__qdisc_drop(skb, to_free);
 	sch->q.qlen--;
+	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 19c851125901..a91959142208 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -123,10 +123,10 @@ static void choke_drop_by_idx(struct Qdisc *sch, unsigned int idx,
 	if (idx == q->tail)
 		choke_zap_tail_holes(q);
 
+	--sch->q.qlen;
 	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 	qdisc_drop(skb, sch, to_free);
-	--sch->q.qlen;
 }
 
 struct choke_skb_cb {
-- 
2.47.0


