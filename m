Return-Path: <netdev+bounces-243183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36408C9B01B
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 10:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61CE7348E69
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2921302CD6;
	Tue,  2 Dec 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7t7ei6s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nKzKUywn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14E307AD7
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764669404; cv=none; b=DYvQxAc2JFFUErkhysZUeuNSLyypKFRvjJPjfqOwLap0b2lNBZOv7+vh7iNFxAsoTmY0RvX66icguzjGtuoo9ac93gPMCeZu+wabcDhGdI8Y8rtpW0tXVAXt/MN/AvmT/fCRS3ALxY4/ThbmZxxELklZ2MZWeceXZah1uyFGF+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764669404; c=relaxed/simple;
	bh=G6gdsRTd/IkNP/6JndFqXaYdTefFzTwNlyC+vHBz7EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRWORTCcMX8fvxNayZo6FBncbJkkPMZO3Uo2IYxTr5aU/U1ThsKsKSWHQSMwGIJr9pmMKfcbF4qAl4WkpP5D9foemO6eZ1UlxVRZymKqOpack6AtYeYTUObgVuMFSlzkGhU9mFr5Whr99ut26ZA0MdAGk4YN2CsiMyui1Nyfak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7t7ei6s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nKzKUywn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764669401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmwzETEQqhXxzpCCx4pVQ+bcy6i9hDAdjenY6lRWznM=;
	b=R7t7ei6sT7XVZ111KhHom8yaCbFPyPbz/unDoIkzLToGVAQ3wis/MsqdsIdCVvqbosnhZH
	PI3Zp4fkJXGVs82XrAAv7S6Y//GfkWczbbvRw0E0ebI0Sslt+S62OuMXQxS7M4zUvgcx3J
	Mv0apVMgwKZ7izuXfEHhd2A1sXvpb2U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Df-wJrkkPJWA6Lyd2Fpgkw-1; Tue, 02 Dec 2025 04:56:37 -0500
X-MC-Unique: Df-wJrkkPJWA6Lyd2Fpgkw-1
X-Mimecast-MFC-AGG-ID: Df-wJrkkPJWA6Lyd2Fpgkw_1764669396
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779b432aecso29214035e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 01:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764669396; x=1765274196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BmwzETEQqhXxzpCCx4pVQ+bcy6i9hDAdjenY6lRWznM=;
        b=nKzKUywn6bT4FCMVFEpUN/iuICuxkAS3BdMxu2ak0ejh6PlRgROuWggmtHTTRRk1cD
         uHVtJL7milwjRTMin+irJYi1eu2fYAu8jiZZp5epGViFw9wjmhmZ0J/BUTIuCa7Qqkn6
         1oLHnWoypX4KxDG31aYmBxmF074CmSV5/3JI8V2d7jC7dabDqtRjRaoexu0gohA9ouWr
         NjfEfOnsCslu4XnRlCgSe6cq37LzN7AocSy8tLrSGv6zH7Py1as0nCgYqR6e4FwQClNB
         bMW9MdlVnEplPc5ex5mG2kuugeilgzBvbUP6/u7E6JlF1xUKfaUUBWdzPDk3vmGVgETu
         HJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764669396; x=1765274196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BmwzETEQqhXxzpCCx4pVQ+bcy6i9hDAdjenY6lRWznM=;
        b=M/NBbaKQ51HN6sSj7NN12bEmBcQD0dtydeSQoTnbZmcTJO8e3kxjzlVmKNBzSXPwAS
         XycvK0QW9pKrFAx9Yiod5qxeU83Ty8YfHfLdGvUEo7nmQyBOYMEGbPaLvniraeqTBEVY
         LuWvkQRpdf+h4O2CxtqXc+WVqkiKeRyrJJPStPInSEspOwfQa93tioUaTzzhktbOl7TC
         Vkb42nv5LnE123rPS8EbkvVMfJmyJ/WFOerDzd3zjBetQCs+MZaKhc0udMnUruYiM6kD
         sa+x1ByBFlvF5gmoQfQ6KTBqRpKex86QCOmPqm388v6o8Zcnj8p3OsZU4poXg0TgdbuE
         Fjgg==
X-Forwarded-Encrypted: i=1; AJvYcCURF6GZh6bpMtcFrohZRCChHWF3Zy52R3a/vYChXhrQXI3bdM19a1+jvFXWgZpeiuMHHOF2GkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjLffQPC2+S51zlC1+nzfs8kvmLfz42gI8f3cpU/FSRz/gH08b
	dWh/5eaVjlK5Zl4eaLab+orqZkDwAmQXoGMrqcLsu6A75B0CBYQlOGdWT1fH2SMxu163W7FBHgP
	HWYdx5/1tCx0X5R04SO8CbK8F7ovAMtNamnqf++YlENsZr4qzd7UZ8kgoHg==
X-Gm-Gg: ASbGnctCGNXOt7VI+0Xz+bU5EMIwWtOXO6u5fvrI2LmXK5mMjwq2PpXafgC40tiahEv
	4NUAKVF64+TC+N92qGcSCk6YwJbG4Z30aosSKn8SswEbJ4J8wOSCaYKuOMxCXsu3yywYQIsk7xX
	IRqPDZzkFaKRXO1tmjnL0BqIh8aJrIMm0evDONfCIadZhJ/4Y9al8zUvmsFeWtkG56FulgO70lo
	cHjfmx7rxStzYiKwbuVwCbw7UvXWzclJCAxGdFMi2ue6jLRwKHrZE0HHKx54SL7TZ8WaGSpWi4I
	InAUCjVwByuDZ35bnOvste25JNMCcvh5pACgohjNyXTHQUvrZw5QUzLPspkPlzYJOMdUgrBbAlJ
	eDW5vlqk3
X-Received: by 2002:a05:600c:5249:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-477c10c858bmr410796035e9.4.1764669395908;
        Tue, 02 Dec 2025 01:56:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG58SCtiR1pzGqTLv2910co9Rp2YwzTMnymsiXLlAtGgzryQaAGax2I8C/nRfF7mbeR78nhbg==
X-Received: by 2002:a05:600c:5249:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-477c10c858bmr410795735e9.4.1764669395398;
        Tue, 02 Dec 2025 01:56:35 -0800 (PST)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791115caa7sm283351145e9.6.2025.12.02.01.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 01:56:34 -0800 (PST)
Date: Tue, 2 Dec 2025 10:56:34 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	netdev@vger.kernel.org, horms@kernel.org,
	zdi-disclosures@trendmicro.com, w@1wt.eu, security@kernel.org,
	tglx@linutronix.de, victor@mojatatu.com
Subject: Re: [PATCH net] net/sched: ets: Always remove class from active list
 before deleting in ets_qdisc_change
Message-ID: <aS630uTBI26gLBTZ@dcaratti.users.ipa.redhat.com>
References: <20251128151919.576920-1-jhs@mojatatu.com>
 <aSna9hYKaG7xvYSn@dcaratti.users.ipa.redhat.com>
 <CAM0EoMmtqe_09jpG8-HzTVKNs2gfi_qNNCDq4Y4CayRVuDF4Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmtqe_09jpG8-HzTVKNs2gfi_qNNCDq4Y4CayRVuDF4Jg@mail.gmail.com>

On Fri, Nov 28, 2025 at 03:52:53PM -0500, Jamal Hadi Salim wrote:
> Hi Davide,
> 
> On Fri, Nov 28, 2025 at 12:25 PM Davide Caratti <dcaratti@redhat.com> wrote:

hello Jamal, thanks for your patience!

[...]

> > > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > > index 82635dd2cfa5..ae46643e596d 100644
> > > --- a/net/sched/sch_ets.c
> > > +++ b/net/sched/sch_ets.c
> > > @@ -652,7 +652,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
> > >       sch_tree_lock(sch);
> > >
> > >       for (i = nbands; i < oldbands; i++) {
> > > -             if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
> > > +             if (cl_is_active(&q->classes[i]))
> > >                       list_del_init(&q->classes[i].alist);
> > >               qdisc_purge_queue(q->classes[i].qdisc);
> > >       }
> >
> > (nit)
> >
> > the reported problem is NULL dereference of q->classes[i].qdisc, then
> > probably the 'Fixes' tag is an hash precedent to de6d25924c2a ("net/sched: sch_ets: don't
> > peek at classes beyond 'nbands'"). My understanding is: the test on 'q->classes[i].qdisc'
> > is no more NULL-safe after 103406b38c60 ("net/sched: Always pass notifications when
> > child class becomes empty"). So we might help our friends  planning backports with something like:
> >
> > Fixes: de6d25924c2a ("net/sched: sch_ets: don't peek at classes beyond 'nbands'")
> > Fixes: c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the round-robin list")
> >
> > WDYT?
> 
> I may be misreading your thought process, seems you are thinking the
> null ptr deref is in change()?
> The null ptr deref (and the uaf if you add a delay) is in dequeue
> (ets_qdisc_dequeue()) i.e not in change.

I understand this - it happens to DRR classes that are beyond 'nbands'
after the call to ets_qdisc_change(). Since those queues can have some packets
stored, in ets_qdisc_dequeue() you might have observed:

480                 cl = list_first_entry(&q->active, struct ets_class, alist);
481                 skb = cl->qdisc->ops->peek(cl->qdisc);

with a "problematic" value in cl->qdisc. That's why I suggest to add

[1] Fixes: de6d25924c2a ("net/sched: sch_ets: don't peek at classes beyond 'nbands'")
 
in the metadata. 

> If that makes sense, what would be a more appropriate Fixes?

the line you are changing in the patch above was added with:

c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the round-robin list")

and the commit message said:

<< we can remove 'q->classes[i].alist' only if DRR class 'i' was part of the active
   list. In the ETS scheduler DRR classes belong to that list only if the queue length
   is greater than zero >>

this assumption on the queue length is no more valid, maybe it has never been valid :),
hence my suggestion to add also

[2] Fixes: c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the round-robin list")

> BTW, is that q->classes[i].qdisc = NULL even needed after this?
> It was not clear whether it guards against something else that was not
> obvious from inspection.

That NULL assignment is done in ets_qdisc_change() since the beginning: for classes
beyond 'nbands' we had

        for (i = q->nbands; i < oldbands; i++) {
                qdisc_put(q->classes[i].qdisc);
                memset(&q->classes[i], 0, sizeof(q->classes[i]));

in the very first implementation of sch_ets that memset() was wrongly overwriting 'alist'.
The NULL assignment is not strictly necessary, but any value of 'q->classes[i].qdisc'
is either a UAF or a NULL dereference when 'i' is greater or equal to 'q->nbands'.
I see that ETS sometimes assigns the noop qdisc there: maybe we can assign that to
'q->classes[i].qdisc' when 'i' is greater or equal to 'q->nbands', instead of NULL ? so
the value of 'q->classes[i].qdisc' is a valid pointer all the times? In case it makes some
sense, that would be a follow-up patch targeting net-next that I can test and send. Any
feedback appreciated!

thanks,
-- 
davide



