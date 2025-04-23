Return-Path: <netdev+bounces-185278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FDAA999B6
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7C01B638C8
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 20:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF2B27A129;
	Wed, 23 Apr 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlMxAG0g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B127935A
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441454; cv=none; b=nzyahGrPd6vGgwh45x02Aj2aQTmwx8TA6Oh7u6Eda7uYhdOZEoWiksldbmYEbh6kSv5piZtnmQnlnR8++GRr9dvGGSB6Z2kn0vAT3j33faFzYCrry1xsimf69FWhTu4+8accBvXwG6GBu85omBUQrkmCvY5xxGv/hYuQGR9+DNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441454; c=relaxed/simple;
	bh=EPkRvXmwlR3RU4qVGBNgoF0s+yoQC5cc73SAuhZGqlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia8ejMqlBf+En4oFfMZJhB68rVm4L/ilsXA0YQvQZf72accbGSRm602+tliLuSa3JT/poAnIsgfPVutPKATDlx44PmoC5GmkeZkJHNTKcJ8f1SLeMjKGGzktlc90VJqU/yO4mrdF4qIkESRrdqY96S08P925YygYjjeZqDoxPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlMxAG0g; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so412953a91.3
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745441452; x=1746046252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUBkm1IOr6p2VHqzMvkmLagJkrXpfHVpkWga12/AYks=;
        b=XlMxAG0gFGlDIlMOYHud4IEUes2b36MzjCfT0Btovh2RCdZ2nVtrh9+wCKjd0kj1ml
         CVITzxJI7BXCXxT/8pWlTrE45jTs00WeSAS7TMGVZ66pp3sXAykdC0RO/QQ2Q2dnIDDl
         YxT6ZQh3TYCJ8/mdK/Kad4qn5AABcBDJNTzLjF5x3etIcwav0QlOz3h1ykUY7BPQSLDg
         IFLkj8TgVVPqu+xz4lMQwKSmRmhhQonF4uVir4+9qI6CcBS+4wXLZaAYZiVyCEa0Fk0u
         k1DIl/utfidz7xY53/CHRNSRIsThd4VSLITb57KqkJs61bHVa7M//MCaMzKvFVRneTUl
         bdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745441452; x=1746046252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUBkm1IOr6p2VHqzMvkmLagJkrXpfHVpkWga12/AYks=;
        b=Thgc54xgAU1MO7i7IDyz7Fk9Gq/azT/NZ3GoB5RMrM5YCHWFQE0mymoDD3udnGjNQF
         PARWUzyuqHXqUh+eiXIjlvI9XkhbjdtFV8bc7+wYUnW0OFVVmKYhJG4FD8fR8m2MCW3d
         QylBFaG2Ij/pF8co2ay1LoK5RxaUEaG2qkvqYh263YiZFFxv1Bapb95wDwh8IlXqJXI4
         ykGelbwefrzZV+5v3oeI1Qirk/kWSHE8PB9Glqa0wzTivJiLLzRQWFwB19c6yRVvQsFb
         1vlBiQKChabttPZT1YYWsCRz8OexhyxxVavx1Hcf9XCJi5EX8u4A3ICpdUzyWKVQ8EKU
         IIPA==
X-Forwarded-Encrypted: i=1; AJvYcCUstrCsfhk8JjS9geqcfeYGpAT1YJFScRyroE/S2osRPofv0jNhxy0HD4FZp258lSnM4knAJfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEw7cWYnRo65aNIxxXB/RvW12ruHADvZYUSrsKRHoqM3pc3Nwf
	wSZHlXlzSK+2NCyFiKJ8BOEj/+QWMQTplNaj6LEQsIhyy4jkJW747kNWAH6K
X-Gm-Gg: ASbGncvqkYwq26IQY3xwjkeOnclXF5/ycM4SBCZLGr/jfhckYJlbGQmXGg96jhtMRsA
	ny9AOqTn8vyfDxew4dzzzxoa2HogGWOrq+D8fPFJxJmlzmBS0RWDSLc7yR7oIzCZY4pGOe10bPy
	nIqYttLG/E/CIbwdiLazBfIDb3T70Hfg704gDDnesJyZYtemJ4DOA/QEsyLZbSHbFJq3qUciyiZ
	KBvtvSDHso1v7ihsdVlbLtW5KEZUKfq/wRVW3TlNpyo94WM0LnhHGc84+l67yh81ZibIkAtwZ4X
	hTwxlGlWfZhMDDhPxOU1igyc9buOHeH8TzZznBf3skyI
X-Google-Smtp-Source: AGHT+IHksSQWm2zN6VzQa5YMR14iHgpLwRUqaP4pqJNvZr87iSwsfv4EOaomnysSOCvxBvq9Xlt2qQ==
X-Received: by 2002:a17:90b:2dd2:b0:305:5f33:980f with SMTP id 98e67ed59e1d1-309ed312ef0mr336408a91.27.1745441452176;
        Wed, 23 Apr 2025 13:50:52 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309dfa5bac9sm2119334a91.33.2025.04.23.13.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:50:51 -0700 (PDT)
Date: Wed, 23 Apr 2025 13:50:50 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org,
	jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, toke@redhat.com,
	gerrard.tai@starlabs.sg, pctammela@mojatatu.com
Subject: Re: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant enqueue
 cases
Message-ID: <aAlSqk9UBMNu6JnJ@pop-os.localdomain>
References: <20250416102427.3219655-1-victor@mojatatu.com>
 <aAFVHqypw/snAOwu@pop-os.localdomain>
 <4295ec79-035c-4858-9ec4-eb639767d12b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4295ec79-035c-4858-9ec4-eb639767d12b@redhat.com>

On Tue, Apr 22, 2025 at 01:21:22PM +0200, Paolo Abeni wrote:
> On 4/17/25 9:23 PM, Cong Wang wrote:
> > On Wed, Apr 16, 2025 at 07:24:22AM -0300, Victor Nogueira wrote:
> >> As described in Gerrard's report [1], there are cases where netem can
> >> make the qdisc enqueue callback reentrant. Some qdiscs (drr, hfsc, ets,
> >> qfq) break whenever the enqueue callback has reentrant behaviour.
> >> This series addresses these issues by adding extra checks that cater for
> >> these reentrant corner cases. This series has passed all relevant test
> >> cases in the TDC suite.
> >>
> >> [1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/
> >>
> > 
> > I am wondering why we need to enqueue the duplicate skb before enqueuing
> > the original skb in netem? IOW, why not just swap them?
> 
> It's not clear to me what you are suggesting, could you please rephrase
> and/or expand the above?

Sure, below is the change on my mind:

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..000f8138f561 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -531,21 +531,6 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return NET_XMIT_DROP;
 	}
 
-	/*
-	 * If doing duplication then re-insert at top of the
-	 * qdisc tree, since parent queuer expects that only one
-	 * skb will be queued.
-	 */
-	if (skb2) {
-		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
-
-		q->duplicate = 0;
-		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
-		skb2 = NULL;
-	}
-
 	qdisc_qstats_backlog_inc(sch, skb);
 
 	cb = netem_skb_cb(skb);
@@ -613,6 +598,21 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		sch->qstats.requeues++;
 	}
 
+	/*
+	 * If doing duplication then re-insert at top of the
+	 * qdisc tree, since parent queuer expects that only one
+	 * skb will be queued.
+	 */
+	if (skb2) {
+		struct Qdisc *rootq = qdisc_root_bh(sch);
+		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
+
+		q->duplicate = 0;
+		rootq->enqueue(skb2, rootq, to_free);
+		q->duplicate = dupsave;
+		skb2 = NULL;
+	}
+
 finish_segs:
 	if (skb2)
 		__qdisc_drop(skb2, to_free);

> 
> When duplication packets, I think we will need to call root->enqueue()
> no matter what, to ensure proper accounting, and that would cause the
> re-entrancy issue. What I'm missing?

The problem here is the ordering, if we enqueue the skb2 (aka the
duplication packet) first (as what it is), the qlen is not yet increased
at this point so the qdisc is technically still empty (as we test qlen).

If we reverse that order, that is, enqueuing skb2 _after_ the original
packet, qlen should be increased by tfifo_enqueue() _before_ skb2 is
enqueue, so the qdisc is not empty for skb2 any more.

This is why I think (meaning I never test it) it could solve the problem
here and is a much simpler fix (0 line of code in delta).

Thanks!

