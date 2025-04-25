Return-Path: <netdev+bounces-186158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017A9A9D518
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7036846854D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0781F22FF35;
	Fri, 25 Apr 2025 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="EDiLhbxN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F022F17A
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618842; cv=none; b=Hhil/Dbu2dd2wbDG4qwGnajDOeOMTIy/qRHjl91WOiTr3y1bzOKscUC+2GIBUwj91ZAq66YFVUIDVuzSeStNgtTNo9bb03YcI505azuAzdAk1+d2F3HNmuP2aeyKd8Isyj+nJG1PGtMFn2ZO9YTHSNpCWaW+JIxBa09YOb5fYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618842; c=relaxed/simple;
	bh=Lns1hrYfFO6D3OLevBFL+1BDVYdmY+X7y+YReMHHAv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1VMV0XhMIIPisbf3aMHvdidDjIGhsxQKxNY5x0BPPqAbl7jyxQVortWdz+YtlmpXZvKlcUsgmuw9wN5Nq7yy+WTMpSxzHho5HBvJaB15Ihi64xS1MotW+RpAtVkIxVnrm+qNUcUkPSSbBvFItdk6cOzoGlOZhi4dY6sLTlWEBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=EDiLhbxN; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af523f4511fso2684399a12.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1745618840; x=1746223640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg/UmhFCapDEIDydeIaLftsrz/zFJI3oiQldvf5eJQ4=;
        b=EDiLhbxNhSX0n9yjPO3MOtCu2CiMY7rqqDQGKGm7i66Z0E4buXT76gzdE7UjDIBNKA
         RcdJtW/3pk6xzkzcZMyfZT0CYY+f8ek1E0lKCuyoaXTOhUyMCKyD/EXX9k4gI9vgV7vy
         5VWd9MD8/bD62tHR19K8ZxQIXPEjvBsX4/LGvj266KtYisdlIVvdb3cJf9SyzRKQ0FEi
         07RurEEMa7Px5q7RcwI0WdwhEtLarYH7axfkaTnEPtxmqGXscZgtWNMynLfgntEjWjez
         g56tOPe0O8E5K5wgwaP8/iubMc2N7OMi3nE0cLHJ9dmeyNH3z05YCJkus0LdfYGA/CXB
         kIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618840; x=1746223640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg/UmhFCapDEIDydeIaLftsrz/zFJI3oiQldvf5eJQ4=;
        b=rxNvdng164iCGzi3k1AddmiQbDE7vhvJO39QvfGI49jd++jJz++qjnsaf7ATboc1kq
         j93rvhkyfHzF7u/ukBC8bOlrQWeFJl5nvOeTAk2F3d3pdDM1+X5yGTlHIfP+DbCXadx5
         z+3vDVLHd/Gew33xx/3ZtyKtjDNBBKn6Jd+oVyYj86v0GnRrDJ3fVAF3zmWVJhy0xkAi
         MuamPiU3DwaQhBxg9mc8o7/qcx5SMTIsYJtCUnKBJxVUJaOX0b4OJEulqBNchZsBS3Y0
         1TNlg5iVcyA4DrnJoxT3rB2oTOrQnCRfYE1QocP3Q6eAIIFALuRKVtRoBH4RnqKiofwr
         kByw==
X-Gm-Message-State: AOJu0Yy+2cs6dxRprHvyBEv/+JTmAhpDp+RSB82ck6qU9x4JxdCzsakn
	sIGryaxQGaz2WEdx/hGrWGuWzKQATYNbkuHbZ4kMbbbDaKkwDoA+iNTzMbNYU6tNAwHv8MBhPiM
	=
X-Gm-Gg: ASbGnct+ZsXypgZEFmLxClab+Kql75AZMpwMGawpqc/iEK7kS0KBH7O6UKiwCUeV63y
	YydKfhP9v3Dr37n2KgdA01YwvtaKs1hdsvGKtViNyLbqxMLllkWRzL1CGXysM3nrHNU+LJkylv5
	jeJvnxMhQjQyj//kvWTGPrL414Z73CnEy8yhMI/1DYG71EBIt0hrRuKFLG/hNCwNRBgXSQ5ba1j
	9LKSws/M9Q7kALbvYHSOaDw3W2COVY1SaSP62oG7qfaU4ug0tCUMnxSG63Gmf199pRHtpluNiiC
	pMTkLxglaUuulnYyA6oqLg46Hz9R3DFaeWMLrJhffXcxgy2OsEF6u+93Qo0J4d9I
X-Google-Smtp-Source: AGHT+IFyEopxDTbW4QU5F+Z9ULwgiYQdK8of9NC/EzOafBr5J+eY++bUGRtz6IndU/qV86lnVnziUQ==
X-Received: by 2002:a17:90b:2710:b0:2ee:fa0c:cebc with SMTP id 98e67ed59e1d1-309f7df2f9fmr5824189a91.20.1745618840471;
        Fri, 25 Apr 2025 15:07:20 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c0:73b:9a6c:c614:cc79:b1ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc3b7bsm37753185ad.100.2025.04.25.15.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:07:20 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com,
	stephen@networkplumber.org
Subject: [PATCH net v3 1/5] net_sched: drr: Fix double list add in class with netem as child qdisc
Date: Fri, 25 Apr 2025 19:07:05 -0300
Message-ID: <20250425220710.3964791-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425220710.3964791-1-victor@mojatatu.com>
References: <20250425220710.3964791-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in Gerrard's report [1], there are use cases where a netem
child qdisc will make the parent qdisc's enqueue callback reentrant.
In the case of drr, there won't be a UAF, but the code will add the same
classifier to the list twice, which will cause memory corruption.

In addition to checking for qlen being zero, this patch checks whether the
class was already added to the active_list (cl_is_active) before adding
to the list to cover for the reentrant case.

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_drr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index e0a81d313aa7..9b6d79bd8737 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -35,6 +35,11 @@ struct drr_sched {
 	struct Qdisc_class_hash		clhash;
 };
 
+static bool cl_is_active(struct drr_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static struct drr_class *drr_find_class(struct Qdisc *sch, u32 classid)
 {
 	struct drr_sched *q = qdisc_priv(sch);
@@ -337,7 +342,6 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct drr_sched *q = qdisc_priv(sch);
 	struct drr_class *cl;
 	int err = 0;
-	bool first;
 
 	cl = drr_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -347,7 +351,6 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		if (net_xmit_drop_count(err)) {
@@ -357,7 +360,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first) {
+	if (!cl_is_active(cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
-- 
2.34.1


