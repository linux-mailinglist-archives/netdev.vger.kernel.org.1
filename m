Return-Path: <netdev+bounces-202689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C142BAEEA8A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 00:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6321D1BC0BC6
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 22:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC2245012;
	Mon, 30 Jun 2025 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1veAw4A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266979D2
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751323199; cv=none; b=ZpCZR0Nkk7adrEzu0/OyZGXVHjZhqhPC+kt5GqEJMZ4UuSqIHuL45HxeTF6HrTDo2ymVE6lmGxhQ0mUnqlYENIQI9cFCq2MusWfBUyGPU0WSOkFv+4XzFnKpHrm5AfxWG7jIKsmCQzVUpS7RdXDtjQAN7Z+GRHGE3GyA6B2XV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751323199; c=relaxed/simple;
	bh=0cormQ82CtqU8JEkotBKJ5XPzBjI3/oDxIuxtnmSxLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLBsdMbdRa8yWUb8+N40H8TQ/jVGqxbpsJCiUiHNZ4mPlcEfoPZ8TKQXGj4Yt7/8D8i0rAYpAmOCXwkdEb15ngzUi2gWtzXEHdvXIekzmjQdwR3lbpqoLe+4ZPLsYFiqMGXaWDogoMvVxlHe3GjVeDL+tHIg3/QlzsG/JkzmjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1veAw4A; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-749068b9b63so3668225b3a.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 15:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751323198; x=1751927998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hXHzNECM6rBJ+H/dMao7sN9OmPB4+ek1jxBLZ6t1hsE=;
        b=m1veAw4AyOsdc2EKAxGPudysxo+5sbmu/69LERwEcPFUlaEG2Pnle/tq2vS+bOIKn9
         53/gZbfw8DCCSkjAF+EPPo/VQMSeMtVSDgkB+z3N79HMDjfLcc4yPyTXo56C7ZZZ0bYz
         6/bRyZyUgpaql6MjwWlyiopAQQlHWdHWbPMuNnmih8rv3rvqgpAI7rvxeuPOw3z5sZ+9
         PmZyg4EiiQdF8zgWiKs8/AYEHqsiOPaVaIz23DHvlUd0hqTcZPG2DdNpUHIL5SC3V/o9
         Co11UXExce81av8bWoRhZRWl7/lcEm1HltOlXWF+Z4srhEYdjGek/7jYpsQvSFSUm61C
         +DxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751323198; x=1751927998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXHzNECM6rBJ+H/dMao7sN9OmPB4+ek1jxBLZ6t1hsE=;
        b=vtlB1+fIC2PFRA1UzrhM4rR/Wn5YtHgzwm4A2iZSNNN0XB6NPFUTVDwhjPACF8W+4e
         WRKXtJdIJonPeSCcDhQgqFH+RhEpVTRHDp+i9OmNdD/ByIeeonAK8uMHb44ZRTJjTp+V
         BGyNAn4+1DO/txrHX/JIiBn0cFxVxE6jEdQ6pV6Rd5sq/Q/I5TP1sAuKfI5OJwj4NtYf
         QhO6FDPbPctGyNDva4MLqj289T080Y7MyM+BUAlp4ZS89HlbCrd6YKN4TJ13ABhoImrb
         jTB0vN+IHDGDifxD6IUDGYWb9V0Oj6Y3NheXMpa53qzrV9QYV1e72FIrgkR+6mfZ9UkQ
         e+ww==
X-Forwarded-Encrypted: i=1; AJvYcCVVa5KgTJ5F/cq2Np1QEqOUIevS7kidQFwoArT5cmqZtVJtFRNI1Z66H9wKH5AQEtI9c9myZTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/8HR/Ej6kR0jtwKmh7dGPjDAxSZM3FDitMUCcmgPw5ggKcgq
	/4PfMAxuhYal4428gRbUZuYjEXmv7uIDPElIJ2wNAmaeDzSUV8uy7dgLfkcckg==
X-Gm-Gg: ASbGnctqFNCe4h3grVCyoUZVzNRrg+BxuxROXeg+K5Tu78GQKZc5MKYIT6DAi9GOvXc
	DFa0m0GMMGTYYfFYknQlRQo6oWenRCTrwOU3JcDCGQofpA8YF1jn/uHBL4+czvZxqWGtUiNIBM5
	9gqZrg3JmNdwF7sTOyHL4ILP79DqxQBuR4ZqtErq2/1MrEryOhwg1aItFj1n/SqnwOJ3yqBLcW7
	UYiOwa5jXxpDVYJ/WEY7P8MAa4GUt3QLOPGjlDjw+Up555E4UW7kBza3o2O/UFo7RLro28FjQDS
	ufRUai3I61A5dPVwOLbeJTA6wVQvod8wDWA80KrHncTSIjJQ4Qnft+ZBVdIHCDR5Hw==
X-Google-Smtp-Source: AGHT+IGDY7Hi6vJBmH8rSSebsY+C8GFuof0AzTODg8o+yTara7d/WSgzkLYkCTLY8dReSSWsIrrI3Q==
X-Received: by 2002:a05:6a20:d708:b0:21c:fa68:b47c with SMTP id adf61e73a8af0-220a140beb8mr24132592637.18.1751323197788;
        Mon, 30 Jun 2025 15:39:57 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5409cb6sm10082525b3a.23.2025.06.30.15.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 15:39:57 -0700 (PDT)
Date: Mon, 30 Jun 2025 15:39:56 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org,
	victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com,
	kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com,
	savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
Message-ID: <aGMSPCjbWsxmlFuO@pop-os.localdomain>
References: <20250627061600.56522-1-will@willsroot.io>
 <aF80DNslZSX7XT3l@pop-os.localdomain>
 <sf650XmBNi0tyPjDgs_wVtj-7oFNDmX8diA3IzKTuTaZcLYNc5YZPLnAHd5eI2BDtxugv74Bv67017EAuIvfNbfB6y7Pr7IUZ2w1j6JEMrM=@willsroot.io>
 <CAM0EoMkUi470+z86ztEMAGfYcG8aYiC2e5pP0z1BHz82O4RCPg@mail.gmail.com>
 <aGGfLB+vlSELiEu3@pop-os.localdomain>
 <CAM0EoMnjS0kaNDttQtCZ+=hq9egOiRDANN+oQcMOBRnXLVjgRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnjS0kaNDttQtCZ+=hq9egOiRDANN+oQcMOBRnXLVjgRw@mail.gmail.com>

On Mon, Jun 30, 2025 at 07:32:48AM -0400, Jamal Hadi Salim wrote:
> On Sun, Jun 29, 2025 at 4:16 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > On Sat, Jun 28, 2025 at 05:25:25PM -0400, Jamal Hadi Salim wrote:
> > > your approach was to overwrite the netem specific cb which is exposed
> > > via the cb ->data that can be overwritten for example by a trivial
> > > ebpf program attach to any level of the hierarchy. This specific
> > > variant from Cong is not accessible to ebpf but as i expressed my view
> > > in other email i feel it is not a good solution.
> > >
> > > https://lore.kernel.org/netdev/CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com/
> >
> > Hi Jamal,
> >
> > I have two concerns regarding your/Will's proposal:
> >
> > 1) I am not sure whether disallowing such case is safe. From my
> > understanding this case is not obviously or logically wrong. So if we
> > disallow it, we may have a chance to break some application.
> >
> 
> I dont intentionaly creating a loop-inside-a-loop as being correct.
> Stephen, is this a legit use case?
> Agreed that we need to be careful about some corner cases which may
> look crazy but are legit.

Maybe I misunderstand your patch, to me duplicating packets in
parallel sub-hierarchy is not wrong, may be even useful.

> 
> > 2) Singling out this case looks not elegant to me.
> 
> My thinking is to long term disallow all nonsense hierarchy use cases,
> such as this one, with some
> "feature bits". ATM, it's easy to catch the bad configs within a
> single qdisc in ->init() but currently not possible if it affects a
> hierarchy.

The problem with this is it becomes harder to get a clear big picture,
today netem, tomorrow maybe hfsc etc.? We could end up with hiding such
bad-config-prevention code in different Qdisc's.

With the approach I suggested, we have a central place (probably
sch_api.c) to have all the logics, nothing is hidden, easier to
understand and easier to introduce more bad-config-prevention code.

I hope this makes sense to you.

Thanks.

