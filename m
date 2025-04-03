Return-Path: <netdev+bounces-179181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F59A7B0D1
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C850177DB8
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6E1C84B9;
	Thu,  3 Apr 2025 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+wBhyjF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7011C862E
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743714659; cv=none; b=f2BC8khFH0Cl74XIcpKhU4IaXDdNefWbijw2pGYRB+E5asea0n3DGgsg234AHfQxbHxXtzNHiRI80fFyMxc/Rv/str75qZKqnQrxqolPD3plPITfX2513wCQJc38e5n980xlvKav0NKMazqm/23ul1ERKkDAKyXSS19IWHGOg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743714659; c=relaxed/simple;
	bh=pQeK2BrF55u/0EXsKN0Qf4SQL6dnj2ecn8e7A3L1A0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J2GSDIoXnrjLnfRi3GSg620d4rwD/5jk+7GuVO3jZp2KRe7LtT/a1hXU5pgN4TL8IYOf8xrrXLNrHQCnudMMtaXSl5QU6Nk1KnxdADt8uqy29L1JhW7TysFeSi+1/KWfsPUEJ/FBgQLVFL6g1mYIlGv7kj40A2l1wRtpT/arhak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+wBhyjF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2260c915749so10415165ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743714657; x=1744319457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moIEMrDcqnevzQAwwG+Lt8rXFaw/vlBOis0iockljXY=;
        b=I+wBhyjFEqRlleWF/QuivCkH5G7pzFe5HduE4oIPgtkfL3wTRtz/Yihg9ehz8p3mT+
         bfnqT4q69x98iGUzhbDTEnA9/yDqRNWTW8V74Ox0IIvQCrCZzp9Ssrz2MTqvn3EDdLi8
         qlzSpz4A03POc0ENvVd8WFe364noLuOm+vcJOI4iBJ/MRC35FiP3hGanfG3TvvqQQQ7c
         JpCCNmbvrTcilWFNjzAupu1ZI6yLvJgqxwUxYqjC1ofxaTwl43WvTWfbE9yqJHZTGstt
         l+KKsjj2BuRGnKfkRAR0/z3MT4UvQpvjMtg1JTICqKp9YqysatV+RuOTO1fDm1qqpDaE
         jt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743714657; x=1744319457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moIEMrDcqnevzQAwwG+Lt8rXFaw/vlBOis0iockljXY=;
        b=A68Mxaa95Gld+HsDCzQXfJtuyHbPEQOXNRTy57yiuETxI206dIq1ZveqN/4Ro84YHu
         aiLTZHLC8ufoL9/Y7Ucp9PmigGppa8AH+lv+Px7q/63BP1lDWeguyGWoQhw51uJpGB6C
         D2y1RGWecXHrQoS5I7pydTuTdhZ0f5DAv+hbW1X8CoM2kCQCFHLaGYHyPZJ9jmS/qwMr
         JPlVVc88gFXT97/gjNAfFDVVPOURzK4W/fWN2vdzeIf/xNElQfcqTEq7OMYlWdw4OI5S
         vu9eW7+OF/gKA8WRwO9Etj6GZNrbNtuxQxlJ0TR3WHUf4O3oY+IjKu9tiWlQ89fFUgTP
         XVFQ==
X-Gm-Message-State: AOJu0YzG/9iDmGtPh3C6Ll7BcIXi4hQiUNOq2VZaEDEJAr1Zd5BXT5tj
	zdgiRdHrbontQcsncENyrUR/HdnwGrQMbQH/NMhhpejTXNhFtsusFjFKPA==
X-Gm-Gg: ASbGncvKTqL4GqfEX9AM2KxG7yegxNeePmoMQv0+I+quu+TRSZ9NBwuGR6pDTUZHvUw
	3NoP8v0LfcXhYQ1sFbDIh5B47NyX915Ct4kSKq28tsEJmkrY5A11dV1fOraRd54xxTBwIFDg4jK
	OjvlkyopiDzZ2nx0FYkT2QhVtrc4ra2xdzMVwRe0G28nXMVPqnrsOdHPMYFcgvwX7WIQgHcRwcx
	t6cvATdaaHMn2eBUUL9HzX8X6i4DehGeowgctfkG1J3x/wsoz4LLF4hszKTsEq7I8EvrMajQSv3
	WAO181/rJF8YDeg5RC/WcOANKKC+9p/GDFIf/rUUvXugtTJGa3sG3VM=
X-Google-Smtp-Source: AGHT+IG7EeWsb5K3FpR1jM7reSRKDx3883R8Y6fPS3Orwg12zgq1gG5Us650CfZooUDzDrDQhvMH/A==
X-Received: by 2002:a17:902:ce8f:b0:224:162:a3e0 with SMTP id d9443c01a7336-22a8a8ded01mr5771825ad.49.1743714656955;
        Thu, 03 Apr 2025 14:10:56 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad831sm19367645ad.11.2025.04.03.14.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:10:56 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: [Patch net v2 05/11] sch_ets: make est_qlen_notify() idempotent
Date: Thu,  3 Apr 2025 14:10:27 -0700
Message-Id: <20250403211033.166059-6-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

est_qlen_notify() deletes its class from its active list with
list_del() when qlen is 0, therefore, it is not idempotent and
not friendly to its callers, like fq_codel_dequeue().

Let's make it idempotent to ease qdisc_tree_reduce_backlog() callers'
life. Also change other list_del()'s to list_del_init() just to be
extra safe.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_ets.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 516038a44163..c3bdeb14185b 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -293,7 +293,7 @@ static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	 * to remove them.
 	 */
 	if (!ets_class_is_strict(q, cl) && sch->q.qlen)
-		list_del(&cl->alist);
+		list_del_init(&cl->alist);
 }
 
 static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
@@ -488,7 +488,7 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 			if (unlikely(!skb))
 				goto out;
 			if (cl->qdisc->q.qlen == 0)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 			return ets_qdisc_dequeue_skb(sch, skb);
 		}
 
@@ -657,7 +657,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 	for (i = q->nbands; i < oldbands; i++) {
 		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
-			list_del(&q->classes[i].alist);
+			list_del_init(&q->classes[i].alist);
 		qdisc_tree_flush_backlog(q->classes[i].qdisc);
 	}
 	WRITE_ONCE(q->nstrict, nstrict);
@@ -713,7 +713,7 @@ static void ets_qdisc_reset(struct Qdisc *sch)
 
 	for (band = q->nstrict; band < q->nbands; band++) {
 		if (q->classes[band].qdisc->q.qlen)
-			list_del(&q->classes[band].alist);
+			list_del_init(&q->classes[band].alist);
 	}
 	for (band = 0; band < q->nbands; band++)
 		qdisc_reset(q->classes[band].qdisc);
-- 
2.34.1


