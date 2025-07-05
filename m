Return-Path: <netdev+bounces-204269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A02AF9D00
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 02:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3145422A3
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 00:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C25621348;
	Sat,  5 Jul 2025 00:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJUZtmO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7242EED8
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751676496; cv=none; b=Qfqwqj6zcYNIgJ9DP2O28EQkENX/2oukHjAi937F8VQkWwOVImdbAzcpKRCB99OMX07JDYaZ4IwbS4TKFaNMmu++1yXbrnaIw3ZcqMEqDOKXtXdpqGoJVUlCkU9VocFI8kOp6xgixIZzNqE//zeX8MKCfjh9XvkbANhZJUvq3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751676496; c=relaxed/simple;
	bh=CdvPjZAjx/92Jfy4Yqqcxcpnrd3RXwYZsPlPzXC0/PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G47C0vA4bIaKRZcjVXFbzDpwMzZkCQFXH43XEPKPF1UwEe6M+1Ts4V8nmmwihiTrLDu+T5595V/94mdWZaFQbr6+19JOr3QjzmpEDbLTguUApVh8jJTdoay6SdycgFHON44n8Q5SO+9uHc7QrZY0yRqUcsV0zW/DByS/YDosktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJUZtmO1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23636167b30so13501855ad.1
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 17:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751676494; x=1752281294; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kh/R74pyHyhrcRODL8p10TZyV918DFQKuUqR0nCt+4Y=;
        b=BJUZtmO16OVCMqz3jEFphplB3AXhb3XTPrCPVbG0asolPnAsZ2Axsq8K9bXHV1uQJZ
         3aSUvHyQITtLHHt/P2r80jmI88WaUq61XwoB3PLZ60nIQZjE4T3YHePMQuRH3fia4YRy
         Hq7MPrM9+Xt2zMdRhoU0FBi82ylQ/3jYvewIMIvKjqMMs7eTqte1ofqzJ+MGgykHkzWY
         bV5BAyv7F1gNHAbrrNKcieXGQiZq9QO2xm3YRUNCBFoxPFKFI95ezn2oAyviDNQwfsgo
         t2tt/BnB5KoZcYpNInKoZl7WQfLfTHM0mxx+/sKFMG/MNAV7dyCa0mPYXdyAkKQ7bx9E
         O2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751676494; x=1752281294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kh/R74pyHyhrcRODL8p10TZyV918DFQKuUqR0nCt+4Y=;
        b=Rr+7KZNB7zXtyAfW5q8TISpZH0aKHwNlHH1wdUTjpUpSXTjs60q1FxG6XP1+XQlumJ
         B1VaRvhgcNcQ5H6FOpQ0H1oHmTtRR5vSvRmJDDHW6wzmt5T12LGov1L/W5Xk+ycW0uTf
         jKHKIdj9MHsWrYo9Q1H2Xi0HWNAgNPPA5UaVwr8LjtHbOIM3bbgnNAiYc8wOoxomjfPD
         vyQn/rp+kE7F1JmMxWa3x/TLxM1dJEzhOCE4DaQ0x3M5sXKWo2qoSKWRWFovSvpt+wmw
         aARnJxZoMEuVykEnhqAhJJv8PZZxzXSuFTRPFZc60Z6/CeBiBO9YfMD5R1TTyXvWxQLf
         nbGA==
X-Gm-Message-State: AOJu0YwUGgmQaNUevcSoSW2o9wDQvqh0wUAdWvxFv+4DGtjlkPoZJtYb
	5wteSGZLQI+GiYnT3hELGFnGWuaxpaxOs3tCemtuTBuEaRRSQ/MT7XVQ7xYivg==
X-Gm-Gg: ASbGnctBuoWrpW0UDQ6fUCy99zPW75Io2HY14h2oKzIfQh4v+2yiqoPUDwyIrPMyMZx
	F4jvlwv9SNy2FjRWNAL1uHas7zJUb5cUhVtDPjU0CyphURRsc+fCXRxXelQVi2XOmDIFviSxbTJ
	9VGK+1ZlXCvzWePmvuDw6uT9/jVI5+mfhUPK+nrQazKDRsJItIEqS9VGOPzx3acEjmj1HXtk27X
	znEwcEjvUgrqajAV5BO6cqQvD2OccMUP+NkNKTx4Mxf6XMrs6ihHrTqjxmO55ShWYZKNZAIlwv1
	7vFuR+aJKD6fRwMNvbrfpcqF6e78X9fgjEP2xpiXxc9+hPxHZ/wGGOxL6G6J7cMHG1cv
X-Google-Smtp-Source: AGHT+IFSlsi3zOCzRftnjWS08djVmNdpCtMxC6g0jFbFBR5S/Vgmq2P9+x8AZwRaoxmeRsexAen3UA==
X-Received: by 2002:a17:903:1aed:b0:237:de7e:5bbc with SMTP id d9443c01a7336-23c85ec7ba8mr62576975ad.49.1751676493917;
        Fri, 04 Jul 2025 17:48:13 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:4a21:dfa9:264b:9578])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84351a69sm29192925ad.63.2025.07.04.17.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 17:48:13 -0700 (PDT)
Date: Fri, 4 Jul 2025 17:48:12 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, will@willsroot.io, stephen@networkplumber.org,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
Message-ID: <aGh2TKCthenJ2xS2@pop-os.localdomain>
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
 <20250701231306.376762-2-xiyou.wangcong@gmail.com>
 <aGSSF7K/M81Pjbyz@pop-os.localdomain>
 <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com>
 <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com>

On Wed, Jul 02, 2025 at 11:04:22AM -0400, Jamal Hadi Salim wrote:
> On Wed, Jul 2, 2025 at 10:12 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > On Tue, Jul 1, 2025 at 9:57 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > >
> > > On Tue, Jul 01, 2025 at 04:13:05PM -0700, Cong Wang wrote:
> > > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > > index fdd79d3ccd8c..33de9c3e4d1b 100644
> > > > --- a/net/sched/sch_netem.c
> > > > +++ b/net/sched/sch_netem.c
> > > > @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> > > >       skb->prev = NULL;
> > > >
> > > >       /* Random duplication */
> > > > -     if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
> > > > +     if (tc_skb_cb(skb)->duplicate &&
> > >
> > > Oops, this is clearly should be !duplicate... It was lost during my
> > > stupid copy-n-paste... Sorry for this mistake.
> > >
> >
> > I understood you earlier, Cong. My view still stands:
> > You are adding logic to a common data structure for a use case that

You are exaggerating this. I only added 1 bit to the core data structure,
the code logic remains in the netem, so it is contained within netem.

> > really makes no sense. The ROI is not good.

Speaking of ROI, I think you need to look at the patch stats:

William/Your patch:
 1 file changed, 40 insertions(+)

My patch:
 2 files changed, 4 insertions(+), 4 deletions(-)


> > BTW: I am almost certain you will hit other issues when this goes out
> > or when you actually start to test and then you will have to fix more
> > spots.
> >
> Here's an example that breaks it:
> 
> sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0 0
> sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> netem_bug_test.o sec classifier/pass classid 1:1
> sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%
> sudo tc qdisc add dev lo parent 10: handle 30: netem gap 1 limit 4
> duplicate 100% delay 1us reorder 100%
> 
> And the ping 127.0.0.1 -c 1
> I had to fix your patch for correctness (attached)
> 
> 
> the ebpf prog is trivial - make it just return the classid or even zero.

Interesting, are you sure this works before my patch?

I don't intend to change any logic except closing the infinite loop. IOW,
if it didn't work before, I don't expect to make it work with this patch,
this patch merely fixes the infinite loop, which is sufficient as a bug fix.
Otherwise it would become a feature improvement. (Don't get me wrong, I
think this feature should be improved rather than simply forbidden, it just
belongs to a different patch.)

Thanks.

