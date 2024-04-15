Return-Path: <netdev+bounces-87950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1271A8A5146
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D48B206B8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C485882D7C;
	Mon, 15 Apr 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUHV6LCG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591378289B
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187262; cv=none; b=FKBPxehLRF3FjKTG2ZE6KlVuWBuqtD7xGIYq8OpVS/mxnOlsOpfZpMCrGO4ip6TDS0GMQ9nohIIrBgKC8yiaNfCv8TYAh64rv1/PcYAgT0QVhpbnjvX/b/ynSOE81vu5MVfaiRgc6s6eiQcp234ibJUk1QNTkpS37HWFX/Xri8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187262; c=relaxed/simple;
	bh=ruvLiSlq3Dc7Lz8ZO4NMF69SqHjGjfB/FNswnLKViKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ktTLQveGeIs0+EKnxZlUZZBA8EXmsfhz0KwyHnNYB98aDI4Nhimo3LD4gkzf424Yq353ZYysSNsi2KnNX75OlGlTnHDXP1xk2vBi5htkfkdf/BuemPoYps5nIMV+81wiqNOnLoRsiB7byX/NyTCzPZf+8nciaqeG6LTG6b7eW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NUHV6LCG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso4572354276.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187260; x=1713792060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvUVpVUdw8ikpyFUAyziYlm1LIWlMR1iKHn0hu++PQA=;
        b=NUHV6LCGtmtGJ13YOhQz36wlJTFLWqCFZ9WC9/rG5OHMTUqoXzaZtGeaN0/RUytv68
         SxQHgLSB4PBKf5bH02W58idNhKmpsh6LzN9ceAdy9hzpXxD0ZA056w+WTJDFTdHS9Vxe
         sFh5uiuHMDD69BvUm0Q99sq1+2FaEH26p94EI01TfIbBbvF0r3mNOeLE9vkWcih/zvx+
         gddTrlUFs4LrnK/Dg9SXi+FXEYsULJiJR4e9Kdjt2MRx99mTUf4pAe/TtDoiKZAfPA8c
         NeSbLLzidT/4Skv0Sc7KmeeHdwwjYS00/hH9RoBGxZs+7tjeklcB4G+08phkVHCbw6uS
         fi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187260; x=1713792060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvUVpVUdw8ikpyFUAyziYlm1LIWlMR1iKHn0hu++PQA=;
        b=Yp24zmO1WI5dr63XrPC/DvJ3T282/r/5jOPXEjbSvwUCQufmHTtwS2Cpjw8nk1pqCX
         KqQs13WB8KuFpboTUpdJBzNQqZgVHSKOun2UQyYxCRE5NC8NRKYLEnZXC6zAeMRkmi8J
         DOV16z3adsST6mluOR2Q1Th6jx+TQCZTCimuzMuqKtMrGAQJxuPw9x178TPCsrAYNi6m
         mMqVYcauGvom/G7VFR5rfO1ySTYA85NRWQOcrRyvvb1kZUh19IvbfIQRtSPr0UZ2svZH
         eGpHyVDQV3ct+HANlyXNlgtJY3grahJ/GQOfIgBe7peeUVwvIAW1AN4TcUiST1g/2PnE
         wbMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9SNf+p/S80rN9gJMWrEqJEf+l6dMuNDtkQ3D2a8iIJLRTU6Zt6//70Wreab+ps1JWnaxYk6EWAQZ/6mTbbKxiRQ122N9K
X-Gm-Message-State: AOJu0Yw1ZqQDap0Nsjs5ucr/amjaD3Kei5pPFNcx9jDiQ1EgvPT7fUIL
	+BMCS8Y/BVg82DoOnPqnl6qXutNLB8zuBdOyGnQTbPcmaoa4yMHnWSZFqaJOJh6td5WStg87Vba
	nZ5GM9m+jDg==
X-Google-Smtp-Source: AGHT+IH4k1v0Z5g1XikuWk8mkJFLq6tUk/3EPeBXwJM3W01nXus5oBdKN+72E9PHflRnXuFbPGFtpCbIFB1OpA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:120b:b0:de0:ecc6:87b with SMTP
 id s11-20020a056902120b00b00de0ecc6087bmr784102ybu.1.1713187260269; Mon, 15
 Apr 2024 06:21:00 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:43 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-4-edumazet@google.com>
Subject: [PATCH net-next 03/14] net_sched: sch_cbs: implement lockless cbs_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, cbs_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in cbs_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_cbs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 69001eff0315584df23a24f81ae3b4cf7bf5fd79..939425da18955bc8a3f3d2d5b852b2585e9bcaee 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -389,11 +389,11 @@ static int cbs_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	/* Everything went OK, save the parameters used. */
-	q->hicredit = qopt->hicredit;
-	q->locredit = qopt->locredit;
-	q->idleslope = qopt->idleslope * BYTES_PER_KBIT;
-	q->sendslope = qopt->sendslope * BYTES_PER_KBIT;
-	q->offload = qopt->offload;
+	WRITE_ONCE(q->hicredit, qopt->hicredit);
+	WRITE_ONCE(q->locredit, qopt->locredit);
+	WRITE_ONCE(q->idleslope, qopt->idleslope * BYTES_PER_KBIT);
+	WRITE_ONCE(q->sendslope, qopt->sendslope * BYTES_PER_KBIT);
+	WRITE_ONCE(q->offload, qopt->offload);
 
 	return 0;
 }
@@ -459,11 +459,11 @@ static int cbs_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (!nest)
 		goto nla_put_failure;
 
-	opt.hicredit = q->hicredit;
-	opt.locredit = q->locredit;
-	opt.sendslope = div64_s64(q->sendslope, BYTES_PER_KBIT);
-	opt.idleslope = div64_s64(q->idleslope, BYTES_PER_KBIT);
-	opt.offload = q->offload;
+	opt.hicredit = READ_ONCE(q->hicredit);
+	opt.locredit = READ_ONCE(q->locredit);
+	opt.sendslope = div64_s64(READ_ONCE(q->sendslope), BYTES_PER_KBIT);
+	opt.idleslope = div64_s64(READ_ONCE(q->idleslope), BYTES_PER_KBIT);
+	opt.offload = READ_ONCE(q->offload);
 
 	if (nla_put(skb, TCA_CBS_PARMS, sizeof(opt), &opt))
 		goto nla_put_failure;
-- 
2.44.0.683.g7961c838ac-goog


