Return-Path: <netdev+bounces-196546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44104AD53AB
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BFF18963B1
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5B12E612E;
	Wed, 11 Jun 2025 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uS/qfUkR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78425BF0A
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640530; cv=none; b=kot+LeUlnAyyRzISDY83IXbhUbyo5iX+gax36gcqk9MplsT3xKfrU/7D7K0xUFg+vA0X86We2Km4fT2seqIAXgWHtq/zY/8uDZXPm4eoWQ4IEZKLUgxR21Lgk+OaxyrQVJPhYH/G+62RCcEt1TIlM3kXLb/eLmCWOkU8cTAFBr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640530; c=relaxed/simple;
	bh=a+H1iMJY88f46G4DEPlyyOTTI2ICd+AsKEngFtGUyx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pwd5PABEVTSUhLVRrFJExnyTOdxoUbDO4PVIdjGCvCMN82WgXHhPgCJMqxgX7QzeqOIdyxI8tTftW07H+ajyvfN3VsNpGjqXrUPQMujIRBFz9xe7dc8wKbRqWvOXt279CCSlvdZqJl8xHSo64zOgmkwpq1M8sC7zs1/UH42dGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uS/qfUkR; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7d0aa9cdecdso596651785a.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749640528; x=1750245328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAovi9FUrvw9xxO0KBf0qOAHXi5Oed3FddFlR74+apQ=;
        b=uS/qfUkRkiU43alrPu3ZD1V9mIuoET7rzmQGctPSEPY+7sjP1BazxSAKDTgIXktr5D
         0qEVtXt3nQfKY9hX/+cc+XFGK0DfODKoBsnxLVMVLX5IEsbWjrMtAuh2B2Uz8QPwtiwt
         4sz5uf4Kkk6KSHXvTT0EM7GnhkQ2yYntL5pkoYe/DrDh8zhKGmkVxCzIMJ4OihQzdDNC
         jrVfgyV3WHy+wZFn/qBqI1MMA5AXQK9k4uVCG1BfSkruMdYaQamkQGDP62yFbxSqYWwG
         D70itu3HCLkTOwwJI/Fq2fNm+hKNMHvfntZM7/HKQmvYVhSB4Cif+5tZWVb3Qsh+nLJm
         Z+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640528; x=1750245328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAovi9FUrvw9xxO0KBf0qOAHXi5Oed3FddFlR74+apQ=;
        b=AQJXBY2kyIWK8TYOZjU6UTeNvfw4oskQ3yLtJrd3YXZXHc7cTYdKPZ317x7t92CGE8
         mUd/Wb+My5eJVnWZZxYZKPj/nDVPHfyQeDB2D/BN0qe70NAfi8KRScJ9vfySInqBwq7B
         rlVzBQDNu4WAdCWcrfTjGe3RBSpeFAVYQZvS0TeDepjQSkieqZWMsVKOM3M6AA0MFXLP
         xSebHqBGMIIQtV058PVA8YniLBwU+xjT92XUDDLBIGOV4tlQheyeExOKSKR4zMwBIUTh
         06gBGJl43W/sfXdVljY5QPML47K8UN8JdpoEOeP1pcxEYefLdbeS5qHpW8S9mkFBTUfg
         34LA==
X-Forwarded-Encrypted: i=1; AJvYcCXf6ZMxDcDLjLmqOHm86MoeaTH7dLT52IB2y9OtztOwnbZtjexxle6zfMytnwO2tkw9dctyTVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyabiYqAJjAHBEwtdfKznnGSCe4eUSTgBysCfPP5HIIfKOM1Wb4
	Z+PLez3jxYaDT2sIGugjCEvHQqC9j7wvHBk++nBAXF+6Yeei2+dQauksLQv5vjwfqQoVtKygz6R
	ViWx+498ESBGBfw==
X-Google-Smtp-Source: AGHT+IFWicWh1blEIYnWWXYXdT1tHjNuR5yP13EklQ066nj4siXsaCjssS6SbjmswNuoz4pLaBqXUZXqp+9FtA==
X-Received: from qkmm30.prod.google.com ([2002:a05:620a:215e:b0:7d3:8d91:73c0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2617:b0:7c5:5670:bd77 with SMTP id af79cd13be357-7d3a89ad33fmr432634485a.55.1749640527735;
 Wed, 11 Jun 2025 04:15:27 -0700 (PDT)
Date: Wed, 11 Jun 2025 11:15:13 +0000
In-Reply-To: <20250611111515.1983366-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611111515.1983366-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611111515.1983366-4-edumazet@google.com>
Subject: [PATCH net 3/5] net_sched: tbf: fix a race in tbf_change()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Gerrard Tai <gerrard.tai@starlabs.sg>, Zhengchao Shao <shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Gerrard Tai reported a race condition in TBF, whenever SFQ perturb timer
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
Cc: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/sched/sch_tbf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index dc26b22d53c73461c6f6d64f768136ad3f334143..4c977f049670a600eafd219c898e5f29597be2c1 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -452,7 +452,7 @@ static int tbf_change(struct Qdisc *sch, struct nlattr *opt,
 
 	sch_tree_lock(sch);
 	if (child) {
-		qdisc_tree_flush_backlog(q->qdisc);
+		qdisc_purge_queue(q->qdisc);
 		old = q->qdisc;
 		q->qdisc = child;
 	}
-- 
2.50.0.rc0.642.g800a2b2222-goog


