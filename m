Return-Path: <netdev+bounces-243532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8EACA3377
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 11:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E436B30A5126
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1AE33B6D4;
	Thu,  4 Dec 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoOSNC2l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BT5JjZf2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19D3314C4
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843595; cv=none; b=uJzytKCn2Kp0LIpVVxMieS9PUpCcJ8mXnULuj0ppJHKSSoFc8tWhq5LnFQPcaZ3j4VH75aozZZHujPvpJ3tblUQr8xhs7qRb0oeB3l8xfEnSpDwXsxEXMh7I7/wrIEUrtDqCnl4u5frzsaOpdOXTVjIpsn+9c2CWiO8hSrjiCQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843595; c=relaxed/simple;
	bh=MwdYDcMwV6E0rh0JskgTdJjBbp38O1FnMZdUSvPDRGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP1t9E8Qp9oQZzPKcLesm3dICvDa1Mj7vrMbz86aBB2CDNilVfQdlnerboVqMrdl4h+kWovD8Way3G4oarC6iK0T7PM6ucXPFJR47RX7TcUvi9f1ADDxMWzLv8X4TktjxgPQj11g4CRL8jMV+KHZJRsMycM90AMcMfwsDd2UOSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoOSNC2l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BT5JjZf2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764843592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AGeajeZ9jV/FXOeuT5hXj1Rd1IMgLqfbDVlYAHhfUOE=;
	b=PoOSNC2lqpZZDkvvZYfivTC63C4illkJKuMNGS5utBi1SFcHTXpGRl/u+BjEWHMrsIiEPu
	LRwZoHlKg9+6kXdgmpbIkTiTj8PSun7AQYTAuCKhT4G0dWDDd9IbniY49QKGICSaCn9xpJ
	jy82ElgZHEjVUtDJfGtkryddYZDCXEA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-aqgjBruyOyesRWaZ4wn39g-1; Thu, 04 Dec 2025 05:19:51 -0500
X-MC-Unique: aqgjBruyOyesRWaZ4wn39g-1
X-Mimecast-MFC-AGG-ID: aqgjBruyOyesRWaZ4wn39g_1764843590
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so4603445e9.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 02:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764843590; x=1765448390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGeajeZ9jV/FXOeuT5hXj1Rd1IMgLqfbDVlYAHhfUOE=;
        b=BT5JjZf2tKFXieN8sGovaM7UcEolpQuICIBBDfWHWwv76iCM0zvKfpIw6b7jFh1RVH
         QEZlck/gfFEZLRTUBZWDl1rj2f0JYpaPV0pchOw7kBtGfUitffmxy/ZisLfmSOZGbbk8
         3D9EVoqYb74S5FyXiaxQm+ahDLwMlXQoamqptWLFDS/CZsJC4mgQzyQOi2joxWERndGU
         /j/rU86igibX/j0GJM8f2phUa4QMeuBsX4yjct++9edV3VszCDWXGADSdrNx6EYiuU1J
         zhfQgcgTHUXB5g7S8UngwTp2729Lq7LGA+nBtNmdHVJgi8tQEhXRczgBC+/K+R4ieODN
         qo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764843590; x=1765448390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGeajeZ9jV/FXOeuT5hXj1Rd1IMgLqfbDVlYAHhfUOE=;
        b=GRxapniCIwH0lC4j86N0XHnaVjYz9eGL8goH7UFlYNuo0aDHm5m4oPCQ1NwRhMbbBf
         uc8eZEz0mtniTsCCc0pPTizDL14LV243pOmFPVo8SjFvB8msfBw9GTKj46sIJ1n2IHRZ
         le92JwVBWIVj9DIb11jlv/32b2njoa75Ho/qLijRoL/xjIwSi75DAcKa1uZkQjgKnG8o
         Uhc3nxPyfp30fx98jDRR8fhkBS6/sYy2M8xLRiJpcCZuGjxyLHguX2D6LehGqUXD6YVH
         SoCzhN9gFYLD/Hh3NYk+kJE6wcKaF+FUUTW+qfzWCkmtRv+3Tcy5TzsODThK4zARb4rZ
         i7Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWqtFyBK8VzNcjkOHNtGv4ABsEDkpsImQiddOqDFeA0VxZN2dra1E4DZ9/MiUhOCdOP9IgpG4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/e+NaYV9SzXpouVOqEpxhOk2ph3mqCA0skL/IMM7tK8rbVxkj
	IGeNyp3QA1cj/yJIOOdVJxuG6P41lzquPKy3XnDd7Ujul/z4NjDqMIj0kLSnX4pPTNMc6Ss39bp
	RfzY3x+85TVCR280JRX1zBHL+zeR5AU0WbWDcPt6dmhrn/s1irdNnMfn8Mg==
X-Gm-Gg: ASbGnctyxSF4Q8Ky7dvYt5yA+0OtwAlpUAtRNL4pr///pN082jVkeHMt47RVf2c84Xb
	6dHsKBc8TytGC4dfDaurj59U5uHfxxcVfjkAqMljNjCkgLi9kRjn9KXBMBSCyt/g7vHBvD6tTzd
	3CmfF3NWfPuuwmt1rtHRkXWpFvdgtVsqFrMY6sHYsEfPZ1pSEEpwouRqb75u3UARefD4nJ7WgXR
	/b8rAjiexLoTIxQoO6TtPUVDp9quLerJHzGee+U8s0u422NfztRwGswU001CHMRoklC/sf88TK9
	x22ocr+WovTkM4zxQCSZBUC/GWSsLR4E1VqoDjVv/162Z6IzAZqw888Zjq92WsZghCpKP4iSFMK
	lg2v0mE49
X-Received: by 2002:a05:600c:3545:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-4792af47f0dmr63580815e9.31.1764843589742;
        Thu, 04 Dec 2025 02:19:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYyq+qlzpJCaw0xFAMGX00lGCb5FqPN5HY/r/RQ6tZhIsfFoRzYJn4iSLR/XRM78flv1fj2A==
X-Received: by 2002:a05:600c:3545:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-4792af47f0dmr63580335e9.31.1764843589101;
        Thu, 04 Dec 2025 02:19:49 -0800 (PST)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930cb6a96sm24571485e9.15.2025.12.04.02.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 02:19:48 -0800 (PST)
Date: Thu, 4 Dec 2025 11:19:47 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	netdev@vger.kernel.org, horms@kernel.org,
	zdi-disclosures@trendmicro.com, w@1wt.eu, security@kernel.org,
	tglx@linutronix.de, victor@mojatatu.com,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net] net/sched: ets: Always remove class from active list
 before deleting in ets_qdisc_change
Message-ID: <aTFgQxYZfl5MAfNE@dcaratti.users.ipa.redhat.com>
References: <20251128151919.576920-1-jhs@mojatatu.com>
 <aSna9hYKaG7xvYSn@dcaratti.users.ipa.redhat.com>
 <CAM0EoMmtqe_09jpG8-HzTVKNs2gfi_qNNCDq4Y4CayRVuDF4Jg@mail.gmail.com>
 <aS630uTBI26gLBTZ@dcaratti.users.ipa.redhat.com>
 <CAM0EoMnEU1gLNn4XNbq=rG14iVh_XqU32P3y_8K8+fvRbmWrvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMnEU1gLNn4XNbq=rG14iVh_XqU32P3y_8K8+fvRbmWrvA@mail.gmail.com>

On Wed, Dec 03, 2025 at 09:23:17AM -0500, Jamal Hadi Salim wrote:

> > the line you are changing in the patch above was added with:
> >
> > c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the round-robin list")
> >
> > and the commit message said:
> >
> 
> > << we can remove 'q->classes[i].alist' only if DRR class 'i' was part of the active
> >    list. In the ETS scheduler DRR classes belong to that list only if the queue length
> >    is greater than zero >>
> >
> > this assumption on the queue length is no more valid, maybe it has never been valid :),
> > hence my suggestion to add also
> >
> > [2] Fixes: c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the round-robin list")
> >
> 
> ok, so this seems to be a followup attempt to the first one.
> I have a question: Shouldnt we be listing all the commits in Fixes if
> subsequent patches are fixing a previous one? Example, this one has a
> Fixes: de6d25924c2a - which is the previous one? IOW, would it not be
> fine to only mention c062f2a0b04d and not de6d25924c2a?

right - I didn't see that c062f2a0b04d has the 'Fixes' tag for
de6d25924c2a. Then also the single 'Fixes' tag equal to de6d25924c2a
should be sufficient to track all the needed backports. 
> 
> > > BTW, is that q->classes[i].qdisc = NULL even needed after this?
> > > It was not clear whether it guards against something else that was not
> > > obvious from inspection.
> >
> > That NULL assignment is done in ets_qdisc_change() since the beginning: for classes
> > beyond 'nbands' we had
> >
> >         for (i = q->nbands; i < oldbands; i++) {
> >                 qdisc_put(q->classes[i].qdisc);
> >                 memset(&q->classes[i], 0, sizeof(q->classes[i]));
> >
> > in the very first implementation of sch_ets that memset() was wrongly overwriting 'alist'.
> 
> Ok. makes sense - i see it in the original patch from Petr.
> 
> > The NULL assignment is not strictly necessary, but any value of 'q->classes[i].qdisc'
> > is either a UAF or a NULL dereference when 'i' is greater or equal to 'q->nbands'.
> 
> I agree - before this one liner fix. I do think it is not necessary
> any longer, but wont touch it for now in case there are other
> dependencies
> 
> > I see that ETS sometimes assigns the noop qdisc there: maybe we can assign that to
> > 'q->classes[i].qdisc' when 'i' is greater or equal to 'q->nbands', instead of NULL ?
> 
> I wouldnt go that far. What i can tell you is removing it didnt matter
> in both what i and Victor tested.
> 
> > so the value of 'q->classes[i].qdisc' is a valid pointer all the times?
> 
> Well, I don't think the nstrict classes should have gone into that
> alist to begin with (looking at the trick test that  made you issue
> the first commit - that is what the test was achieving) and since that
> doesnt happen anymore we dont need to worry about it.

right, because cl_is_active() would return false for strict priority classes.

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

thanks for fixing this!
-- 
davide


