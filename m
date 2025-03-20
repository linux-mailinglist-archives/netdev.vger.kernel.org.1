Return-Path: <netdev+bounces-176617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55AA6B19E
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4537A7784
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE3D22B8A5;
	Thu, 20 Mar 2025 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnQk+wRn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B722A80A
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513158; cv=none; b=D+kLJvlgaIXgZ9Gt2+J7G7wifQ+JcE57jKV4uW5MzPkQSJamF1pKggCxZysWXSviaXqwRLWYZXsahFEzvDFmChvKWccqmUVem8IARXivZ7/Wt0M6i2oWU7QKMG5F+eeOuULRYo03H6Gc9T4P5u8cbgkjLy5o3fbxWdzDRBQupUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513158; c=relaxed/simple;
	bh=t6tu05ly9QjPCEx8sdlAFw0widD9kgarU7JHERAbJmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PhBZzv5M8zGyGB8HCkRMrk+nXgXgKHSmpxFQhznfyV7m1uJ7iL4TyHuKSJTi4zfP3j1hZOSnxqnk22EIb6JN3CTVTdDLYj3c1Wfy0YIjk5/fpWDqtUBfXjNCkePZNs3sUJeYbQFkKHGWiI1N7iaCBIERdwl84wuLRR3kozr1o64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnQk+wRn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224341bbc1dso27340935ad.3
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513155; x=1743117955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzYxyoe/a5YlwqrwUSKlRYIYxamKo+68GX21nB8fjLs=;
        b=LnQk+wRnEfhf9T31+9Ktu8hAsfcwzcq/amNiwEvW1Tmg6siCIIOzmL+Xva0euafei/
         OFHiLnZ570ZudVOrhPu+XN8tH7/neuAyE35rll1Xm3ByCelRPNfFqNGC0GEQNSS9QzkA
         5OTp8CHdznIjQEEAiXC3RH+e2K2hv+Sxm///NSImziQ+QLfWWf/9ncnvw5gobyhoc6Sd
         XGzKZQKAFAWx1JRYvFUTHy9KCmWF8So4MzYIjfTj0AAc8Sq1op6NjJHALMvKv4GowB9H
         TWlbDydxLrq2Mf4sIncyUc0jmpC0qmX7Yh45xgh0F0I4JHoFUr6ZCk7hM0jP88kuL2Se
         wkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513155; x=1743117955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzYxyoe/a5YlwqrwUSKlRYIYxamKo+68GX21nB8fjLs=;
        b=ZihGXLHfR4rHxK+RzWrJpTDE3eQWFpiv+9nPh8v6P9/EJoDDhQJzrL8q1EJuCNwTYm
         nzM+TN/H7BpvAYzna0TGj21AncFkdmJ9S+TbDwi1J5evqJVeIPAcX1Nc/fVVHNUQ4zpI
         3pyJ73LtrrW90hAyVOMOdlZjWj2jeEQPsZAoG/2OMCbZGxGcWngbID8g8T24oyi3tIHK
         Py9zilwtjnIlHXN/CLVxvUEiYDyDuQ4nV1VvoZvlisHEV6ybogJShroV6Jc7kaUBPu//
         fF/dqYLn/dljE0ilJDCv/HBFB6GpWEGj2IxY4OiTn6IyB1XyvUF7Qm2/X4tYIsjxUS0B
         zVdQ==
X-Gm-Message-State: AOJu0YzwEtloMmgcAsomhnwouzE+8bIXLJNJQbtZqIzP1+TcjBsCLcKM
	ZQ/1OUaGl5kM8qAxsG1rcGP8bzukfyZHI3du3utXTIgRPjeEwMyAgkr93g==
X-Gm-Gg: ASbGncs5CD5491xJksHSpshqOrbK2tOqhwq7yM0TQHBXUcb9NGy2OtDgML3WJu1x/+s
	izIIwpFutclOScsYkfC1f3gpCh/Zcqq0pRpW9vXMrbm+7cg6Scla2ORhUIAG/SmlFu7g2uaVLKL
	08/wNJ4EQZVwKiVoGB+guRAY7kD96jEONPT5N0fPiZc5fmht3GZ/iWsYc0XdSwTBHATLgKUj8Pd
	j35X5vHL4EWTd2ouQdB0k8RvBkfJgxy76JX+e1wyVts+eLalGG64+15TihdtcVpViQ5whIb40SP
	KSvodGpePXqnlgJQdGKxcjZE8WkGaj8/pT2rXx6U/+AzyRQg5gHDDto=
X-Google-Smtp-Source: AGHT+IH9OJmEgMKEdQnlc8d/v29kXNmX4hHSwvtHRnS4bj9aNUyQq4s1RIHNpd9w7S/zJFL6pXbcaQ==
X-Received: by 2002:a05:6a00:1886:b0:736:ab48:5b0 with SMTP id d2e1a72fcca58-7390596681fmr1699027b3a.2.1742513155107;
        Thu, 20 Mar 2025 16:25:55 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:25:54 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 06/12] codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
Date: Thu, 20 Mar 2025 16:25:33 -0700
Message-Id: <20250320232539.486091-6-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320232539.486091-1-xiyou.wangcong@gmail.com>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After making all ->qlen_notify() callbacks idempotent, now it is safe to
remove the check of qlen!=0 from both fq_codel_dequeue() and
codel_qdisc_dequeue().

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_codel.c    | 5 +----
 net/sched/sch_fq_codel.c | 6 ++----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 81189d02fee7..12dd71139da3 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -65,10 +65,7 @@ static struct sk_buff *codel_qdisc_dequeue(struct Qdisc *sch)
 			    &q->stats, qdisc_pkt_len, codel_get_enqueue_time,
 			    drop_func, dequeue_func);
 
-	/* We cant call qdisc_tree_reduce_backlog() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->stats.drop_count && sch->q.qlen) {
+	if (q->stats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->stats.drop_count, q->stats.drop_len);
 		q->stats.drop_count = 0;
 		q->stats.drop_len = 0;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 799f5397ad4c..6c9029f71e88 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -315,10 +315,8 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
 	}
 	qdisc_bstats_update(sch, skb);
 	flow->deficit -= qdisc_pkt_len(skb);
-	/* We cant call qdisc_tree_reduce_backlog() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->cstats.drop_count && sch->q.qlen) {
+
+	if (q->cstats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
 					  q->cstats.drop_len);
 		q->cstats.drop_count = 0;
-- 
2.34.1


