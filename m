Return-Path: <netdev+bounces-186551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C006A9F9FC
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 21:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74C07A2718
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA92951A9;
	Mon, 28 Apr 2025 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIL4U9OC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067ED42AA6
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870033; cv=none; b=OUoN9+3f52NHWdBrBpBggaWSEQQWRbobYqyhA7I05T+sDwHhKRN6s+mDJZwDdK8TFBAaZ06tv10oajY4qJ2Rzu7XNj64J69PZw+1lGvX124rnjSuclk4xqOw/oAxnDDayKTYehWqVT6dPvvZifT4SHuXuvwCnVxnzOKFnpi5PbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870033; c=relaxed/simple;
	bh=RH3Efm76eu7ZnuFTMdg/XPD3M3JO+DHMqucHRSGnAg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGyHOcLkBvdWlD0ljm08+ZF7jbGhu5pMjQGksf+U1EepoG6NT9qEEdY6DPv6xjdf5Hji46f1QhAhWr/egvTvgkuYptuFFvEokhd4U/QI0FNjWLQfesPyyPxLUO+RKnAR0d8E10z7Lg3moXXZgUJS7WY4YDR2BPi0Pxu56eYLqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIL4U9OC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224100e9a5cso63636885ad.2
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745870031; x=1746474831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SpdGJjnsSwwmG68ERmNMyjNRpTnG1J41eQ2Ct1pjNr0=;
        b=QIL4U9OCy5xCXHJ4hVpft0zI/DeRqNoaxPxkYGvYk36xqdj1nEIuXbcNykzJNizJg9
         X3gABnGcRolUdvqj84uFBHTt1ft3cq2nz6nVfeH8VbNnHajGhGBjoZVodS1hNEBbtp5O
         COkCCU20FS5701UGTgcIqSHBUsojXD+dF6e2oPWZlmi1FPaPWzz4lWSY6nHmzKJK2hga
         oEG87mYKi/9vUZuPxHLQo0BCnSqijBiFR67+k69Yh2uIMrFxw8ModRIcMOqdSvq/e2cS
         aXE46wziFUJ89n5j3z1hPzcjNMVsSW+iLszMMP1QY6PV+IbrvdGd8igx4wsnU7tKZV9O
         UdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745870031; x=1746474831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpdGJjnsSwwmG68ERmNMyjNRpTnG1J41eQ2Ct1pjNr0=;
        b=IPrVwxFx4uwyRLWRDPRqI/wwfI0oKjJjlMI/2yycV2gpUK2fUo5r3Ck84D4FAK9pdW
         EDjv6AG5UiNcXIBOv0PwiC3x5iLUQXe0Tp7XNomNl4v3ygzVIxiEjMO+S8D2Ira/pd+o
         OZ+VNGEPAbSBXKKF4s9uQ5SKtvPTuQwmASIIH2e7ctsBcw/PN2IZJun1aCrDGy6gqbGh
         u/5GkjIMPz0fvkOcjO9QKq+pU7KTVwAYkGlaWEghw++4O+3jROS3ijycF5amesBEglo/
         1c7NkgzLc59e6fwe4zRmoZMspKMseW2I4FLNemkIIyrf260aAse6wqMaizeO8/H0tprf
         ZqWA==
X-Gm-Message-State: AOJu0YxreoVFEwUasdp4UigVecOFgnfuoHZjFxUbLo9g0Q/q3LKV4H2Y
	tnk2WC601x6N1qiXVuIiaHyNku4KQVR7cSQHxJkJlepIiKsmBxM481V0mqBo
X-Gm-Gg: ASbGncvkbmEVoxmptNYymN0vu1ZzGBCFeCbk5gf562o+ka5Oszah6wC2QEuLYkc6aV+
	vrhWXjsvGBlaltH7KnAVCk7NdzydvVkbr3Vx0dC2iHyX62+96XLGxdZFoptpZPoqqWMrT6rc/b1
	CRXsV9G7zLlkj24FrKGelKjCdswgsC/J6fPwmSoL5NkdDTvig//Gr3uCHldYL7rlp2Up0GC5NQW
	+B60uquE62X0jjCzB7eMOPXSQWvQXdRIfEMRlo6Vw0y7SUYvVmkLwlC+ceYYsK4y2IJ/ewcbS+Q
	G/O0s3xu1qDFZFAoaDoaUGtgUIZ3myxnaoHdr19BCZdH
X-Google-Smtp-Source: AGHT+IHmGiMsGUGZ+c6Nfgir3sLJ8nU5rsz25H5tW9lQAnQEpCPWMSOprPqrcfhzWFoz+ePnyr5kMg==
X-Received: by 2002:a17:902:ceca:b0:224:1781:a950 with SMTP id d9443c01a7336-22de5fccc75mr13192195ad.14.1745870031068;
        Mon, 28 Apr 2025 12:53:51 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d771b3sm87122035ad.36.2025.04.28.12.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 12:53:50 -0700 (PDT)
Date: Mon, 28 Apr 2025 12:53:49 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Will <willsroot@protonmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Savy <savy@syst3mfailure.io>, jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [BUG] net/sched: Race Condition and Null Dereference in
 codel_change, pie_change, fq_pie_change, fq_codel_change, hhf_change
Message-ID: <aA/czQYEtPmMim0G@pop-os.localdomain>
References: <UTd8zf-_MMCqMv9R15RSDZybxtCeV9czSvpeaslK7984UCPTX8pbSFVyWhzqiaA6HYFZtHIldd7guvr7_8xVfkk9xSUHnY3e8dSWi7pdVsE=@protonmail.com>
 <aA1kmZ/Hs0a33l5j@pop-os.localdomain>
 <B2ZSzsBR9rUWlLkrgrMrCzqOGeSFxXIkYImvul6994v5tDSqykWo1UaWKRV-SNkNKJurgVzRcnPN07ZAVYykRaYhADyIwTxQ18OQfKDpILQ=@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B2ZSzsBR9rUWlLkrgrMrCzqOGeSFxXIkYImvul6994v5tDSqykWo1UaWKRV-SNkNKJurgVzRcnPN07ZAVYykRaYhADyIwTxQ18OQfKDpILQ=@protonmail.com>

On Sun, Apr 27, 2025 at 09:26:43PM +0000, Will wrote:
> Hi Cong,
> 
> Thank you for the reply. On further analysis, we realized that you are correct - it is not a race condition between xxx_change and xxx_dequeue. The root cause is more complicated and actually relates to the parent tbf qdisc. The bug is still a race condition though.
> 
> __qdisc_dequeue_head() can still return null even if sch->q.qlen is non-zero because of qdisc_peek_dequeued, which is the vulnerable qdiscs' peek handler, and tbf_dequeue calls it (https://elixir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_tbf.c#L280). There, the inner qdisc dequeues content before, adds it back to gso_skb, and increments qlen (https://elixir.bootlin.com/linux/v6.15-rc3/source/include/net/sch_generic.h#L1133). A queue state consistency issue arises when tbf does not have enough tokens (https://elixir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_tbf.c#L302) for dequeuing. The qlen value will be fixed when sufficient tokens exist and the watchdog fires again. However, there is a window for the inner qdisc to encounter this inconsistency and thus hit the null dereference.
> 
> Savy made this diagram below to showcase the interactions to trigger the bug.
> 
> Packet 1 is sent:
> 
>     tbf_enqueue()
>         qdisc_enqueue()
>             codel_qdisc_enqueue() // Codel qlen is 0
>                 qdisc_enqueue_tail()
>                 // Packet 1 is added to the queue
>                 // Codel qlen = 1
> 
>     tbf_dequeue()
>         qdisc_peek_dequeued()
>             skb_peek(&sch->gso_skb) // sch->gso_skb is empty
>             codel_qdisc_dequeue() // Codel qlen is 1
>                 qdisc_dequeue_head()
>                 // Packet 1 is removed from the queue
>                 // Codel qlen = 0
>             __skb_queue_head(&sch->gso_skb, skb); // Packet 1 is added to gso_skb list
>             sch->q.qlen++ // Codel qlen = 1
>         qdisc_dequeue_peeked()
>             skb = __skb_dequeue(&sch->gso_skb) // Packet 1 is removed from the gso_skb list
>             sch->q.qlen-- // Codel qlen = 0
> 
> Packet 2 is sent:
> 
>     tbf_enqueue()
>         qdisc_enqueue()
>             codel_qdisc_enqueue() // Codel qlen is 0
>                 qdisc_enqueue_tail()
>                 // Packet 2 is added to the queue
>                 // Codel qlen = 1
> 
>     tbf_dequeue()
>         qdisc_peek_dequeued()
>             skb_peek(&sch->gso_skb) // sch->gso_skb is empty
>             codel_qdisc_dequeue() // Codel qlen is 1
>                 qdisc_dequeue_head()
>                 // Packet 2 is removed from the queue
>                 // Codel qlen = 0
>             __skb_queue_head(&sch->gso_skb, skb); // Packet 2 is added to gso_skb list
>             sch->q.qlen++ // Codel qlen = 1
> 
>         // TBF runs out of tokens and reschedules itself for later
>         qdisc_watchdog_schedule_ns()
> 
> 
> Notice here how codel is left in an "inconsistent" state, as sch->q.qlen > 0, but there are no packets left in the codel queue (sch->q.head is NULL)
> 
> At this point, codel_change() can be used to update the limit to 0. However, even if  sch->q.qlen > 0, there are no packets in the queue, so __qdisc_dequeue_head() returns NULL and the null-ptr-deref occurs.
> 

Excellent analysis!

Do you mind testing the following patch?

Note:

1) We can't just test NULL, because otherwise we would leak the skb's
in gso_skb list. 

2) I am totally aware that _maybe_ there are some other cases need the
same fix, but I want to be conservative here since this will be
targeting for -stable. It is why I intentionally keep my patch minimum.

Thanks!

--------------->

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d48c657191cd..5a4840678ce5 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1031,6 +1031,25 @@ static inline struct sk_buff *__qdisc_dequeue_head(struct qdisc_skb_head *qh)
 	return skb;
 }
 
+static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch)
+{
+	struct sk_buff *skb;
+
+	skb = __skb_dequeue(&sch->gso_skb);
+	if (skb != NULL) {
+		if (qdisc_is_percpu_stats(sch)) {
+			qdisc_qstats_cpu_backlog_dec(sch, skb);
+			qdisc_qstats_cpu_qlen_dec(sch);
+		} else {
+			qdisc_qstats_backlog_dec(sch, skb);
+			sch->q.qlen--;
+		}
+		return skb;
+	}
+	skb = __qdisc_dequeue_head(&sch->q);
+	return skb;
+}
+
 static inline struct sk_buff *qdisc_dequeue_head(struct Qdisc *sch)
 {
 	struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 12dd71139da3..e1bf4919d258 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -144,10 +144,9 @@ static int codel_change(struct Qdisc *sch, struct nlattr *opt,
 
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch);
 
 		dropped += qdisc_pkt_len(skb);
-		qdisc_qstats_backlog_dec(sch, skb);
 		rtnl_qdisc_drop(skb, sch);
 	}
 	qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen, dropped);
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 3771d000b30d..b6ed94976e69 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -195,10 +195,9 @@ static int pie_change(struct Qdisc *sch, struct nlattr *opt,
 	/* Drop excess packets if new limit is lower */
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch);
 
 		dropped += qdisc_pkt_len(skb);
-		qdisc_qstats_backlog_dec(sch, skb);
 		rtnl_qdisc_drop(skb, sch);
 	}
 	qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen, dropped);

