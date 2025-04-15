Return-Path: <netdev+bounces-182533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A90A8904B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE32189635E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9F383;
	Tue, 15 Apr 2025 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="BjBaEA1y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A48E545
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675413; cv=none; b=lDtwjEVzwJFugyaDB9iorfbvM+F3NEnGE/BmFapXOZ3m1tfQ5S2IknnQTc1tkVJlHA6Y9ft9WZQpDXr5XiEBmW9Ub+zlqiokxEc/FRYvvjhlSyodgopFcOgMLJIzp6GhuikwGyJiJXev13wa5gPmR3swMBwcowOvLe3xO1Byd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675413; c=relaxed/simple;
	bh=a+iJZd+L8SZAnW6nDfZHQxLb933Mz3yviVhL2mm5yPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/IuB8oQeDSpDoJeIpfQOntOBZFUALRu2DGxkVqkwQQ5zhv1sOOUax6xXfmPyujvQ5DJ2arfIpZ5tzC/+uAyrRx6apbhVgUsm1EihaL/wqZUhawHB1KCXL9VAeasgqrb73uIW1VMtEWI+tChamtXU2tDxUAtbMsFC4m9SX0qsv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=BjBaEA1y; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso4801749b3a.2
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744675410; x=1745280210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwJgUKVfGZqGUsk73GoXi8+5/Vb3HBObw8lKIXSUiA0=;
        b=BjBaEA1yKdZi1UR/TPL4CDlz8VYenKA2w9pPUGJVO1VqdyQ9QQP7TofoOabsLSSTcl
         74RlWlyAr2wvfRMJwmrIzvpgyBYJOYoikPnBN+XD4WU7AYgcDG0B6m/bV7mNtE2sXbSD
         Z5RD11tdzMThEWipJC69w0CN4u/X/VS2s6zfeqB8MAWVbUjkALxORH8pUhi5H/+pex74
         prMfU9Qwb0wU6lbvTRipCMcmhh+0kfV7FdmEVko7JGKHTDxMqj15U8roDH8+3nKANOyJ
         u1UNBNmM6zsADBLx/rYDC5PpVvQKEj5TPqWRq7MAFhZzHo93EGcu880cTn5PpE2XekAo
         ahKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744675410; x=1745280210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwJgUKVfGZqGUsk73GoXi8+5/Vb3HBObw8lKIXSUiA0=;
        b=UFB1Ky+f6nKYpLeHP5KcYBJz6xNZnNyPOgZ3eW6McgtrwYboCTOrIn68+ISXa/XlES
         +Xs47EmriQJc5kjbLaiofRMtB0RXIrFAoOext55Q+S0PNZe31EqkLn8MBRZHb6Yn1WCA
         Qp0CHdagKKs1iARCyootDrxCcjdJM2MiFyisJN75hZHCj8aAHgaMGIs4+PMd8w3Ba940
         20OqkGI1khuAsFyGs19uKipfmPJoU9Jt4sz+T7aCx4x4itvHGqPRNnTPYT5R7luqV5oE
         jn2V8+kZgjzwTzep0OmdC7eK153yk6mynpsJgXWw5MELmTk8AHTAD1hjOb5611tf8xgt
         JzEw==
X-Gm-Message-State: AOJu0YyKebuIIPaDJFHZcg83vIfvFOtksV6WrK14dTRb+cxH/GqZaO9N
	7eR5Fb84VAZwKWGXRrGqVc0xjHZB8k83+zp8wHUwL9n1qtMUgpLsJ9vqL5XzU0iJ5WIZoQujBpY
	=
X-Gm-Gg: ASbGncu6tZ36sFPPXLCG+Vgnhb7HONR05lmQ0kPVdEhZHTxU8DHQMDEa9HAigLCraG6
	tqhA9nanJ5UDEbnar4P0f+xhrNgnjCiW7Ateux4HAGY5UXGfdbiuw+AMQLh37nXnZDfZOnqCl7W
	/yxo0xTpkvh8bRqlmQ2/+NiWGO5VXUFcvnvIA2p9DdcjEmyX9YlmEZMW4a8SYHzaJVFPfVumSqM
	OmdcUOZ/vcwCWBoNXrITKY30reMdB6afTx5A1YiRR5mIINHd1w64F9wLYFwCPB95f9TT1NRGn4+
	yQJI8zMcMsGdHiQzFHXaHGgEwEcQatJnJ/k+/kDpg04IhoskQ/w4SseL+GWTXrcJFyT4ay4Sha8
	=
X-Google-Smtp-Source: AGHT+IE+sy8Y/4t9Y4Vi9ofMmXwnuGvNsyheVLaC9pBa8wdFoTB3Zmw4gg46QHOCw3PMMVlVi1KIQA==
X-Received: by 2002:a05:6a00:1410:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-73bd11aa324mr19746544b3a.3.1744675410030;
        Mon, 14 Apr 2025 17:03:30 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c4db9sm7445615b3a.58.2025.04.14.17.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 17:03:29 -0700 (PDT)
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
	pctammela@mojatatu.com
Subject: [RFC PATCH net 2/4] net_sched: hfsc: Fix a UAF vulnerability in class with netem as child qdisc
Date: Mon, 14 Apr 2025 21:03:14 -0300
Message-ID: <20250415000316.3122018-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415000316.3122018-1-victor@mojatatu.com>
References: <20250415000316.3122018-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in Gerrard's report [1], we have a UAF case when an hfsc class
has a netem child qdisc. The crux of the issue is that hfsc is assuming
that checking for cl->qdisc->q.qlen == 0 guarantees that it hasn't inserted
the class in the vttree or eltree (which is not true for the netem
duplicate case).

This patch checks the n_active class variable to make sure that the code
won't insert the class in the vttree or eltree twice, catering for the
reentrant case.

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_hfsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index ce5045eea065..73b0741ffd99 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1564,7 +1564,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
-	if (first) {
+	if (first && !cl->cl_nactive) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
 		if (cl->cl_flags & HFSC_FSC)
-- 
2.34.1


