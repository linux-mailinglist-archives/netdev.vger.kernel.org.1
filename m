Return-Path: <netdev+bounces-65550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE49D83B03D
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF141C21B0F
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F91B8120A;
	Wed, 24 Jan 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZKQrTUX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA917FBDB;
	Wed, 24 Jan 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118170; cv=none; b=eQsETdX/2qufsAbCfIqu/A7H/QkGOmrjFXEcsIWq1YY9Kp6L7g4ZjvObqSwBzuiMDQLJGLCFcrEV1UssE1WI/FIUHjlhF7RGc03f5RS390oVNKuJc5j3v2xKCFldXR3tlSKsIdn1q1dG559Uw8URaVi4NevWyL1zsjnnFwM8IJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118170; c=relaxed/simple;
	bh=PLWBsCkLYsbafwsaHSqQm4tKlFEVvf+dhwDrIHZyKk0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Aw4Q+IwJRr/4MVsZShLKGthESynL5Nv+liHvyr8Totn29qPwHFVEgxZydYcqiihYUwn2+EYCA/AJQ3IgS5PVn7DTlV31YI+KpwG5NgqvCCsyvXPKqd/NBtq89zGPPIR1xE9nIotOmmLp4DiRkG9qGfKflcuORrj29Hs7l78T4Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZKQrTUX; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7831806c51bso517529285a.1;
        Wed, 24 Jan 2024 09:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118167; x=1706722967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRv4XDCsUQ+cfbQs+OXFf1c33H6MltIS+A5o5Z6RFKM=;
        b=bZKQrTUX3NOousVMvvXusVTjw8x3qrX44k5dUmEfxNz2yglS042WccwgKKSj9xoGCu
         pY76HEJ0+nyZxJl83JD8tiLL1qGK58h/NrsyeHnd9w2nqbepgVqdXvXdWeIL4UhCK610
         adfxliRBoTWRZTTBk01wKvW3K3+zhSbW5ySvxbMOnEWeMEE1q9LcixN3mlxy/ZSVP/xv
         euG7FkrQqJMIfbbXn/J9j7dVN03+8KO4Khwr8unYKIMyYwAIC5jAeUAWzDUGiOPM/c3W
         z97DrZCzwiJP3oTEa9+nJhE4EASn4VVCZi5PHERBDjGfo10ev3XZxNTWwln14ju0pHfT
         f2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118167; x=1706722967;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cRv4XDCsUQ+cfbQs+OXFf1c33H6MltIS+A5o5Z6RFKM=;
        b=qjJk3esZ8fTTrMhqFvIIZAvOD0gYyFxtBXiFC0SBm+DrXbzoXrxrSlm18FcxBjFtk7
         +cCKZLaeLDw4d/ZfT2Vv2cPcuHBih8RhQNbnvtSs5VgSv9jueaQPhXKS2O8T3gqXw2id
         aaZ24YMhRMcLiEx7Xn6sjWKZhLelS2cYNVqQ1IWtHFqW0DHGIT2F6/QJuori7ZwxOXUQ
         fQKypNLspHDTEga89reakWLVnWGuI1yDguJ6jpFBit61mkh2fA8P1fYM1abyC9Yn74Gn
         Bz1JNSuTIol7jgV8UJMpfl34hQ718TJzKtf0iQ0sx8T8MO5qdHJDi6JEZLnSZ147WJ9J
         7oEQ==
X-Gm-Message-State: AOJu0YyYnl3ETvYa3yKnOCt0eNrmUJZ8MiQ4P5NGzGmurZKg28i645bI
	6M6R1p7v8RE7SotMKHCYQrly3AbKaUffJNN9ofz6RI3QMFCKXDuHaq+Zwdg5
X-Google-Smtp-Source: AGHT+IEN6agBVbPynwmeUCZqvse09BFEUEPwofJn1fnNqex73i96MnIrnaRQZ9w8frjZdqa4cZ0M0g==
X-Received: by 2002:a05:620a:1599:b0:783:8d71:e4e6 with SMTP id d25-20020a05620a159900b007838d71e4e6mr8694382qkk.76.1706118167209;
        Wed, 24 Jan 2024 09:42:47 -0800 (PST)
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id r1-20020a05620a03c100b007815c45cdc5sm4232217qkm.95.2024.01.24.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:42:46 -0800 (PST)
Date: Wed, 24 Jan 2024 12:42:46 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, 
 Hangbin Liu <liuhangbin@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>, 
 pabeni@redhat.com
Message-ID: <65b14c16965d7_228db729490@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240124082255.7c8f7c55@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
 <Za98C_rCH8iO_yaK@Laptop-X1>
 <20240123072010.7be8fb83@kernel.org>
 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
 <65b133e83f53e_225ba129414@willemb.c.googlers.com.notmuch>
 <20240124082255.7c8f7c55@kernel.org>
Subject: Re: [ANN] net-next is OPEN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 24 Jan 2024 10:59:36 -0500 Willem de Bruijn wrote:
> > David Ahern wrote:
> > > On 1/23/24 8:20 AM, Jakub Kicinski wrote:  
> > > > It groups all patches outstanding in patchwork (which build cleanly).
> > > > I'm hoping we could also do HW testing using this setup, so batching
> > > > is a must. Not 100% sure it's the right direction for SW testing but
> > > > there's one way to find out :)
> > > >   
> > > 
> > > Really cool. Thanks for spending time to make this happen.  
> > 
> > Just to add to the choir: this is fantastic, thanks!
> > 
> > Hopefully it will encourage people to add kselftests, kunit tests or
> > other kinds that now get continuous coverage.
> 
> Fingers crossed :)
> 
> > Going through the failing ksft-net series on
> > https://netdev.bots.linux.dev/status.html, all the tests I'm
> > responsible seem to be passing.
> 
> Here's a more handy link filtered down to failures (clicking on 
> the test counts links here):
> 
> https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-01-24--15-00&executor=vmksft-net-mp&pass=0
> 
> I have been attributing the udpg[rs]o and timestamp tests to you,
> but I haven't actually checked.. are they not yours? :)

I just looked at the result file and assumed 0 meant fine. Oops.

Technically udpgro is Paolo. But it is derived from udpgso.

But I'm on the hook for a few more. I added fq-band-pktlimit, our team
added gso and txtimestamp I supposed is owned by the maintainers by now.

