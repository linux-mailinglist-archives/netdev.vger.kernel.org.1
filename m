Return-Path: <netdev+bounces-202438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1866CAEDF01
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E66B16A3AE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FDD28643C;
	Mon, 30 Jun 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9TGjiNX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2021DFCB
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290055; cv=none; b=P7sHfPZfKR9WZI+fvNCIAkldGbXu6vqpM0OYzYfzUGwzuCbY1eIPSIqXRFx7ULJRT9V/CqhM19i053/khBku8UAAWvDBjrEWWYS/lWCsEDKiBpx29Ba99peseAJ0/Tnq9vvUq6a8M46DIhf61NA8930poGH+yA5UwDK0Z3lY0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290055; c=relaxed/simple;
	bh=AjiaCQSvB8FLaKMaqqDWMn3k4So43pcL3ZTPbYBZkdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsrpmDgv34evib/kCLlGcY6ISTvtAcSBz9nF1w9NwyKk2jNSvZ0U0HiDn9Jgcr+tJcTjk+xsYKYzd0JLdClcJHI8ReKXU76uT//8SpZBfX8Q8Ytm2LEuHmwDrtR//k+BL9JDMbXMa7VFr2xBebEjNmGvR0m5cYyp8+y6P3xrfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9TGjiNX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0d7b32322so353895166b.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751290052; x=1751894852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXInm1Y/tOusq2dm/G7otbynSjp0fxMcTpZkOQGKCJA=;
        b=Q9TGjiNXd2SbeyypdpEyu540Tf3q4ixc+SM15II6QQSjCm/JQyJ7g8v8lEp3DhzoIm
         OIxPcjNrgrlDDqI1S9sVAnYhn03jtaw67USmUG9SYEon4HcWAnD/wgZuOtfUpBlghhE2
         CBhc9FJcsyjXhCtN9Sw4J/OZeaPYmcCdvO5HZov9XN04Ncdea8vNzdaEWFzuWXXlf8Ho
         SOhQJjSVJxqSdbb7DURLwHW5EjhcaBYGrj7XRfu51dgXp7mlC3rfB3v09oHp73zgcvr2
         DyhUzwsngHCaBfPs/qEuW0cyIFmhAqTzCdAy5qEI/KuPp+jXzLQCx8E7rt6T1P/3+Reh
         dfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751290052; x=1751894852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXInm1Y/tOusq2dm/G7otbynSjp0fxMcTpZkOQGKCJA=;
        b=waNslTafspJr8sjw1atduPg59TE8OK9j0fwZJ/VVbpdak4653678qXbSYRkwvE0zif
         31ioXQ7cRq43Ywd+sD3Sd8A9/LqOtOpMXk8JbNirwPiEVBZoa5J/Zith3awWXqe2MgPo
         EI0pYW2J0JrxnmhUlU4x0qMaXfXzRJa+VSvkJSIj/z5kpuEyZxoO4/f6rXo/0mVkCFLJ
         XE8p+heXlHA1TvK59kmNztVzjGeq0oR/xIqdDQA28MHuNLhge/MKrlZUEkcXGBrgHup3
         dr/WxNZoQ7acdMoxWgWrYN4oQPlVwVzpzGAQFz+lk29Zueqaec2A+xlu6ZT8S5YSOlBd
         kruA==
X-Gm-Message-State: AOJu0YxsGnQXiNkzHeH4YpdozCl0XClt45up9+vHThPOrH6/UaHEgQ+i
	HXnL4Ah58T/19ir4q1Q8CX1apkisQYnz4gyJF+hbR8vsbVBGoWXCS+zcP1834r6Ljlg=
X-Gm-Gg: ASbGncsTrWoldBxBYmu/ES+Okf/xqFdjuUWZ5Q+f5w117LjCVMjDArfr4iV//ATqH9s
	aR+IiFvhFChFI8SZsMx0RiQEsYIitCPpg3Hq5nduvNC1n3R1LtuJkEqo/Y0UURHwe0TCS1Y/ZXt
	Jd5nDTuU/cYT59qkT2dJ+pdbavuM0/q6W4GnHuhyjwXJvycl9h/sOB+l8Rxillmg7IgIUbdhbMX
	pSIy8/73cI56fVDROHUn9JAWBKDZFKTkiHS+9nYMsk/EKMJhyDpWRUzb6/Af9mn+ppf238E/Fis
	9Rib0NERoVnXX+NpMI0wQRCSYRX1G3LJZp/ZnANa0j5oslcUnuOJK40PmarbynuLrSOej7vA8Kt
	McUyTpt5SYvmp3ryVehE4tV4Q6AY74iAxvpDpxQSitykBId5ue/bdfvR/3sPc8TZ4REZLDG8oSp
	9iMAlUx90LdLIyftU=
X-Google-Smtp-Source: AGHT+IGFey1L5cUl0APYw47SCGq+W2xOz6kkVWYfS5LwDHcepenvTFRgu9g9vQiaDNH1MS9tvqa5QQ==
X-Received: by 2002:a17:907:3d0c:b0:ade:3bec:ea30 with SMTP id a640c23a62f3a-ae34fd18410mr1103698366b.1.1751290051972;
        Mon, 30 Jun 2025 06:27:31 -0700 (PDT)
Received: from ?IPV6:2003:ed:774b:fc79:8145:5c0f:2a85:2335? (p200300ed774bfc7981455c0f2a852335.dip0.t-ipconnect.de. [2003:ed:774b:fc79:8145:5c0f:2a85:2335])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c013c2sm678862766b.102.2025.06.30.06.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:27:31 -0700 (PDT)
Message-ID: <d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com>
Date: Mon, 30 Jun 2025 15:27:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] net/sched: Always pass notifications when child class becomes
 empty
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>,
 Mingi Cho <mincho@theori.io>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain>
 <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
 <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
 <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <13f558f2-3c0d-4ec7-8a73-c36d8962fecc@mojatatu.com>
Content-Language: en-US
From: Lion Ackermann <nnamrec@gmail.com>
In-Reply-To: <13f558f2-3c0d-4ec7-8a73-c36d8962fecc@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Certain classful qdiscs may invoke their classes' dequeue handler on an
enqueue operation. This may unexpectedly empty the child qdisc and thus
make an in-flight class passive via qlen_notify(). Most qdiscs do not
expect such behaviour at this point in time and may re-activate the
class eventually anyways which will lead to a use-after-free.

The referenced fix commit attempted to fix this behavior for the HFSC
case by moving the backlog accounting around, though this turned out to
be incomplete since the parent's parent may run into the issue too.
The following reproducer demonstrates this use-after-free:

    tc qdisc add dev lo root handle 1: drr
    tc filter add dev lo parent 1: basic classid 1:1
    tc class add dev lo parent 1: classid 1:1 drr
    tc qdisc add dev lo parent 1:1 handle 2: hfsc def 1
    tc class add dev lo parent 2: classid 2:1 hfsc rt m1 8 d 1 m2 0
    tc qdisc add dev lo parent 2:1 handle 3: netem
    tc qdisc add dev lo parent 3:1 handle 4: blackhole

    echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888
    tc class delete dev lo classid 1:1
    echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888

Since backlog accounting issues leading to a use-after-frees on stale
class pointers is a recurring pattern at this point, this patch takes
a different approach. Instead of trying to fix the accounting, the patch
ensures that qdisc_tree_reduce_backlog always calls qlen_notify when
the child qdisc is empty. This solves the problem because deletion of
qdiscs always involves a call to qdisc_reset() and / or
qdisc_purge_queue() which ultimately resets its qlen to 0 thus causing
the following qdisc_tree_reduce_backlog() to report to the parent. Note
that this may call qlen_notify on passive classes multiple times. This
is not a problem after the recent patch series that made all the
classful qdiscs qlen_notify() handlers idempotent.

Fixes: 3f981138109f ("sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()")
Signed-off-by: Lion Ackermann <nnamrec@gmail.com>
---
 net/sched/sch_api.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index c5e3673aadbe..d8a33486c511 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -780,15 +780,12 @@ static u32 qdisc_alloc_handle(struct net_device *dev)
 
 void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 {
-	bool qdisc_is_offloaded = sch->flags & TCQ_F_OFFLOADED;
 	const struct Qdisc_class_ops *cops;
 	unsigned long cl;
 	u32 parentid;
 	bool notify;
 	int drops;
 
-	if (n == 0 && len == 0)
-		return;
 	drops = max_t(int, n, 0);
 	rcu_read_lock();
 	while ((parentid = sch->parent)) {
@@ -797,17 +794,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 
 		if (sch->flags & TCQ_F_NOPARENT)
 			break;
-		/* Notify parent qdisc only if child qdisc becomes empty.
-		 *
-		 * If child was empty even before update then backlog
-		 * counter is screwed and we skip notification because
-		 * parent class is already passive.
-		 *
-		 * If the original child was offloaded then it is allowed
-		 * to be seem as empty, so the parent is notified anyway.
-		 */
-		notify = !sch->q.qlen && !WARN_ON_ONCE(!n &&
-						       !qdisc_is_offloaded);
+		/* Notify parent qdisc only if child qdisc becomes empty. */
+		notify = !sch->q.qlen;
 		/* TODO: perform the search on a per txq basis */
 		sch = qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parentid));
 		if (sch == NULL) {
@@ -816,6 +804,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 		}
 		cops = sch->ops->cl_ops;
 		if (notify && cops->qlen_notify) {
+			/* Note that qlen_notify must be idempotent as it may get called
+			 * multiple times.
+			 */
 			cl = cops->find(sch, parentid);
 			cops->qlen_notify(sch, cl);
 		}
-- 
2.49.0



