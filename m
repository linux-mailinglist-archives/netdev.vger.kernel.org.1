Return-Path: <netdev+bounces-74503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE186187A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE3E285B1C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A20D128391;
	Fri, 23 Feb 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zWhaWIgx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1A85921
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707266; cv=none; b=XYjdWjbfSQOTbSHpIp623yCUg8MK2Qf3yW4UTRn6A65rlXhsw9gWyNVWdIy1xBwbSz5yi87zbXEFFsuHhARgnHgFI6A/g0DygkJ4IsyttwqCyanR6GHrbS2QCnikGaHhi7ONC1WN+/Ty4RbzsmhFxQ3cvOjnEwAQvenZ64CFWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707266; c=relaxed/simple;
	bh=ENABmiOJK9f0aTz8zpAbrJ7jwTiC1MtfDZUP7ZLR4Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lW1WmHRqOBKvXzQ28PScnWnEyDO08l9CuOifp8vmD9OXCcWw0eecGilih6tzPXoDYR5oPgEQhPz/4zNBnA/Q1Y27OdxrPQ2pP7z28d4j+WN4RiPLQulWwUBZ7XHhOcITOQlA99XurXNP67MgS9SGNCRpaN2L9CT2KGMymjEQ4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zWhaWIgx; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6079d44b02bso11709347b3.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708707263; x=1709312063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Be4o53qg9IjORx3qCWTOp328iufYXNqENlXn+m4qD8=;
        b=zWhaWIgxui3Eb/CqPmq0+qOaDV9QpDnL/kYE3YzALAn75nB75L/39+ZgtO6tcTi5DZ
         Fsb5Nr2fsGAWIr74CEHkXjXjhZgvlbztfD3p5TIebp0N8t/yjDjeI0Di2j4ikoaI6z3e
         I4pf9WFTf6fhb5MIPdGpw9ABPbSurStHQQAbj6Nd9X8WQlh4EXDBH1HzVF4vc1OrlvMw
         wEUCSFOHQsy2wCrjEFcTdwEOIcWwlsRBmU+GadbMZPh5aNb6zw8V9mGjbK8BkXyZNSnm
         +XVCls8wJnQAiF4Q2/Ksv53/1v0HKRz+uDBniEQ9ZttFiH0P7A1OnPX2kp9Ta0Nh6ZEL
         WlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707263; x=1709312063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Be4o53qg9IjORx3qCWTOp328iufYXNqENlXn+m4qD8=;
        b=K7fZpCD6NhatM7IE1xNAcDdtqt/roU0g2AeqPpnzve89MjQmO7UWNOMUbyy7cN4T8J
         vIgqJeZN2keL0LDckMliGQ9vzRh11REEcHSqthJN9WxSS0k6FvNJhAE208HPfJyiyK6j
         7j+Ow5986HDO1IwlGLnt1Q1flTbP8tVOj8XY/0buGETVScZAwO/SIn8lkPtMIxthd6EF
         WvSkZlyUj89BuQR68UK6PUU32Knv+vMbX+NJcuKPo5ukp8Hx3lQW5mKAO6xeDWhJ0RDu
         Uk0qKMogMyN4V6AX37/iMDdv3ReOWeKKopkrRsGYhjKNa+L8kB5gq9viE6RXihrBm4xG
         GfCA==
X-Gm-Message-State: AOJu0YyXgf2UoKugwz1xX0jPhxdac0uABTjK5a2hcnoyOt+msgw6qNSv
	ISMTBT97f1T5Fbd+YFCG25pGA3mPxVjcwCOG6BZ/Rgogxk928WCmOhqozz+nSzsZoJxf/NoPcyT
	l8lP3scAiMxplmYjzV1bnPzRNPym8ZUqRR+3+p60bTV1s1nHBtQ==
X-Google-Smtp-Source: AGHT+IF0/9oau4fCk42rll3Q/uCSAl3qxFiqr47RtnftxC2/3hAbLdI3ivQNZfcwPu0e/8iMrt9X44nXky6ad3kvF30=
X-Received: by 2002:a81:ae60:0:b0:5ff:a9bc:3893 with SMTP id
 g32-20020a81ae60000000b005ffa9bc3893mr350572ywk.12.1708707263461; Fri, 23 Feb
 2024 08:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223131728.116717-1-jhs@mojatatu.com> <20240223073802.13d2d3d8@kernel.org>
In-Reply-To: <20240223073802.13d2d3d8@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Feb 2024 11:54:11 -0500
Message-ID: <CAM0EoMnWdcKtyW_yPkGkan=NYO6To+PeUDV5a5CUi3BLouhLUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v11 0/5] Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, daniel@iogearbox.net, 
	bpf@vger.kernel.org, dan.daly@intel.com, andy.fingerhut@gmail.com, 
	chris.sommers@keysight.com, pctammela@mojatatu.com, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 23 Feb 2024 08:17:23 -0500 Jamal Hadi Salim wrote:
> > This is the first patchset of two. In this patch we are only submitting=
 5
> > patches which touch the general TC code given these are trivial. We wil=
l be
> > posting a second patchset which handles the P4 objects and associated i=
nfra
> > (which includes 10 patches that we have already been posting to hit the=
 15
> > limit).
>
> Don't use the limit as a justification for questionable tactics :|

The discussion with Daniel was on removing the XDP referencing in the
filter which in my last email exchange i offered to remove. I believe
that removing the XDP reference should resolve the issue. Instead of
waiting for Daniel to respond (the last response took a while), at the
last minute i decided to only do the first five which are trivial and
have been posted for over a year now and have been reviewd by multiple
people. I had no intention to make this a conspiracy of any sort.

> If there's still BPF in it, it's not getting merged without BPF
> maintainers's acks. So we're going to merge these 5 and then what?
>

Look, this is getting to be too much navigation (which is what scares
most newbies from participating and i have been here for 100 years
now). I dont have a problem removing the XDP reference - but now we
are treading into subsystem territories; this is about P4 abstraction
and the infra around it, it is really not about eBPF. We dont need
anything "new" from ebpf i.e none of these patches make any eBPF
changes. This is a tc classifier that happens to use ebpf, whose
domain is that?  The exhausting part is some feedback is "you do it
our way or else" thing: I apologize i dont want to lump everyone in
that pool, and it is nothing to do specifically with ebpf people
rather a failure in reaching compromise within this community.

> BTW the diffstat at the end of the commit message is from the full set

Yeah, sorry - this was last minute "should i send all or just these
five to make space for the remainder 5 that we havent posted since
V8".
We have 5 more patches on top of what we posted on V10 - merging these
would open the door to post the rest with 15 limit.
I can repost all 15 if that works better.

cheers,
jamal

