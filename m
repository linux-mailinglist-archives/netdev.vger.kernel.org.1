Return-Path: <netdev+bounces-73419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E1C85C513
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 20:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270171F252B1
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 19:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A91E14A0B6;
	Tue, 20 Feb 2024 19:44:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937401386B1
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458274; cv=none; b=Ebx/4j71Awb89pIdx2ZC4ANLBRAMp78agCqIxUAg+1dYELEJ8qmDcHP1apWRIWfrp8vRO7lCLcGHms09gJ7cLwUcKYz7plT2Kb3xw5qwz94CGab6hmA2dEQHP8Pt2QqimbJlmqoXJ/wU5rqWIkLUcoEDagyAYEocL9UgIUok5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458274; c=relaxed/simple;
	bh=egCrOOr50znuDik3a84ddfinZziKeyqdeCwPLOkPRHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgcFsoelzF8iez43c47CLZvbO/1XimWaAwHz21wts5ePNZsHqnG6FF5QGVBX1BPxOMg4dVllyQsdsA+cdWTQJ2lV+xipL98GhKuRwnTOICcm5r5vqXAvXbbukvA+AZ0TbtskTgsbZBOpGuiOvOQAg6QInPWrhY2jd4fi6V/2WWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7877468beeaso43111785a.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708458271; x=1709063071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf7nxv/yoeRZAIg/mVYOoRIe0Oc63BJnhI64NvPgd3U=;
        b=vmmZ5JDYA3oNKRkF3xLlhCTQb1DtgOWXGxkcjef1ldazNTigAEPrIduGVRlIb7Whyg
         GXhSapU9t85fUPeGTk6+UXBsC3YB2U8Hzj7no/3ttWKvFqxrbWdLycgHuufJsZnBknep
         40/aNL70ojUl/EkEGKeShXz/eLRmgVLvacy+PCTstVgOSr+k9cgqhao2iFgauN692o7C
         HVPbFyP1Nj5Ji9DYK3QDHPSGO5JTSQy2h5lIYMQAvWP4ec3qkdIA5sJFdKYrMZUD8XjI
         xXLpNBLwBXZgHpkR3DjFz5hgyhF+/vvmLzvc+rRyp18q9hzLRLbajFZt9YWHi2ciXfgJ
         FK+g==
X-Forwarded-Encrypted: i=1; AJvYcCWsOhI898IDUQJFIM+1jdpDUlIOWqRQ9Z59hrUD94qKj8T4WBA7fYyKoqrzeEhzWD6cedkkQMTmUuATvj6+BCnf2j9r9FkI
X-Gm-Message-State: AOJu0Yz2YGF9bVXN1qTZ1Ezb/kIYBlK1mQsgU/8M1yFWuJ9+V1SgVXxu
	E3cf4K9kDlqVXqGerqjcbkoAImPaL105WXFZf8wM4O72puWap9nS7EX8WJgUiQ==
X-Google-Smtp-Source: AGHT+IEegqxXmIvsjTN0+qK/zSYbjr1IoWgnZe1NVExgdR7HP3eQ5gheVb9ulNmXqL4KYReh+e0t+w==
X-Received: by 2002:a05:620a:201c:b0:787:6c11:7d76 with SMTP id c28-20020a05620a201c00b007876c117d76mr6064988qka.10.1708458271439;
        Tue, 20 Feb 2024 11:44:31 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id x1-20020ae9f801000000b007873c82f0easm2905146qkh.113.2024.02.20.11.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:44:30 -0800 (PST)
Date: Tue, 20 Feb 2024 14:44:29 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mikulas Patocka <mpatocka@redhat.com>, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com,
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com,
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com,
	Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
Message-ID: <ZdUBHQQEN5-9AHBe@redhat.com>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>
 <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
 <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
 <ZbrgCPEolPJNfg1x@slm.duckdns.org>
 <ZbrjhJFMttj8lh3X@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbrjhJFMttj8lh3X@redhat.com>

On Wed, Jan 31 2024 at  7:19P -0500,
Mike Snitzer <snitzer@kernel.org> wrote:

> On Wed, Jan 31 2024 at  7:04P -0500,
> Tejun Heo <tj@kernel.org> wrote:
> 
> > Hello, Linus.
> > 
> > On Wed, Jan 31, 2024 at 03:19:01PM -0800, Linus Torvalds wrote:
> > > On Wed, 31 Jan 2024 at 13:32, Tejun Heo <tj@kernel.org> wrote:
> > > >
> > > > I don't know, so just did the dumb thing. If the caller always guarantees
> > > > that the work items are never queued at the same time, reusing is fine.
> > > 
> > > So the reason I thought it would be a good cleanup to introduce that
> > > "atomic" workqueue thing (now "bh") was that this case literally has a
> > > switch between "use tasklets' or "use workqueues".
> > > 
> > > So it's not even about "reusing" the workqueue, it's literally a
> > > matter of making it always just use workqueues, and the switch then
> > > becomes just *which* workqueue to use - system or bh.
> > 
> > Yeah, that's how the dm-crypt got converted. The patch just before this one.
> > This one probably can be converted the same way. I don't see the work item
> > being re-initialized. It probably is better to initialize the work item
> > together with the enclosing struct and then just queue it when needed.
> 
> Sounds good.
>  
> > Mikulas, I couldn't decide what to do with the "try_verify_in_tasklet"
> > option and just decided to do the minimal thing hoping that someone more
> > familiar with the code can take over the actual conversion. How much of user
> > interface commitment is that? Should it be renamed or would it be better to
> > leave it be?
> 
> cryptsetup did add support for it, so I think it worthwhile to
> preserve the option; but it'd be fine to have it just be a backward
> compatible alias for a more appropriately named option?

Hey Tejun,

I'm not sure where things stand with the 6.9 workqueue changes to add
BH workqueue.  I had a look at your various branches and I'm not
seeing where you might have staged any conversion patches (like this
dm-verity one).

I just staged various unrelated dm-verity and dm-crypt 6.8 fixes from
Mikulas that I'll be sending to Linus later this week (for v6.8-rc6).
Those changes required rebasing 'dm-6.9' because of conflicts, here is
the dm-6.9 branch:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.9

So we'll definitely need to rebase your changes on dm-6.9 to convert
dm-crypt and dm-verity over to your BH workqueue.  Are you OK with
doing that or would you prefer I merge some 6.9 workqueue branch that
you have into dm-6.9? And then Mikulas and I work to make the required
DM target conversion changes?

However you'd like to do it: please let me know where you have the
latest 6.9 code the adds BH workqueue (and if you have DM target
conversion code that reflects your latest).

Thanks,
Mike

