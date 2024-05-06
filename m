Return-Path: <netdev+bounces-93815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB03E8BD460
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 20:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E9B282964
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760FC1586F5;
	Mon,  6 May 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXriRHbE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664C14293
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018887; cv=none; b=j4Ixyrua1HE213HiLiHPtRztKgB6BgEmQUIffJ3+DsiUdZhqxD+dDf1+uExzYviHndmmbt4ljYf7j90UBHtALd1A7ETvolsHkV9d/E1rIH6iutYPzmSSTiiF7xQwAcAMKet5Pjt2uBj+T18UfvTpbZYUaenFt6xlXGJN7Rh0OKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018887; c=relaxed/simple;
	bh=QP6FRxG6izbbETvcs9/jzLHheE3s6g4CGohTi/a49lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQ70nIeHkR5QGjIIWp9R5f9QQusOpgEJlu/0auJdVcdSRKyt5PGyDJrOpGRbxWmJLukeqXEVxccXiGBHimCqfx16OiQ+QXIkewEhnrbVPAjTHiV5P8Nc83pRPjGcHwy9iZZmy1qZnitl0Ta1/ypyswHpAtKNnhPYJMhhOpm8sbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXriRHbE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b239b5fedaso1772538a91.0
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715018885; x=1715623685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP9dyoQZ5fA2mpoQHygzS0WYvlyAhM1QTGT8OrcLdU8=;
        b=gXriRHbELK8CRPsFK1/laUJT8OEww7PGXBeoDk2NZV3MjvQ3v/RR3XVCpDrmO7tKuC
         fDmaNBRv4jlptnRcg+k8d/5qNIxj8rBrEx6k+ZKdPSFxnRJRvGBc0Co0hSEr+lr5pOcM
         U6RkNzoEqrix3Ryt97bZXN7X2mi6s1K4iGKkzUU00MYdrHp6oqzYQtovWleuL3DZ9jhA
         PI24LRClQR2ksJRyXHMkVp3ockrar1UWipg9yKhCFLZ0d1aDwYqJ0N0BSC0FPrxW76/4
         FdbtW3rQZC1waWRSDpVOVeHpc78LaQDnVAECnVEjv3A+RQq4fGycPqnzClv0OAi/Hv6r
         S/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018885; x=1715623685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP9dyoQZ5fA2mpoQHygzS0WYvlyAhM1QTGT8OrcLdU8=;
        b=Tbb1jF4NSzaFr4sNvJwxBcQAvCFNnmtGf5npIizZF8bKLRVZglZnLQl8wODXxccbel
         XhiTerWymgnOU5P0RQOxNz/x9uKcKAadYIf/io9+/zuib5Ros4d2KjmAG7DAo69weMqN
         p9w6SVDCAdLm8PNP3H6+U8RgOVjkIhtxU/3nfONbnSE4ABalWtqdnmdpxD7r7AhjzjOh
         klJHOF9RmSF1vP7cStkHNPbkFikR9kdY3E9X2+oQ0Gu6KpFUryWM8YK/pUFY6/sfbX9z
         ofzRgFdJlTwFPvhMlNrwEt7nbo8tZzoS0KQd4Jv0wFI1ZZAQs6n8kcfhow6hwM9ItOgD
         dhyA==
X-Gm-Message-State: AOJu0Yxpids6J7vBgTTRhwf9VSRUgv5ce9e1Wfvnrwdm+NYomKDCPblu
	5Hr8JM60SXZDaAP2ib9lqkd6Csj92o+7nErODlbzBIixo2h9XQXr+loR1rW80D9rnZ0lkz3g35A
	OAEeYwYU/As6MX3MHiaU1PN5MUFENpIGykSQY
X-Google-Smtp-Source: AGHT+IFbxkwXDaKGwMkB6EpnS2NAsZy54b96oMIudF9Dg7BdW41XUab2WsG7IIsGX+2vIeJrAd9/FYf3WxcSMSUsJQo=
X-Received: by 2002:a17:90a:c284:b0:2b1:8210:56bb with SMTP id
 f4-20020a17090ac28400b002b1821056bbmr9064564pjt.3.1715018884851; Mon, 06 May
 2024 11:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com> <171491642897.19257.15217395970936349981.git-patchwork-notify@kernel.org>
 <CANLc=autjsuVO3NLhfL6wBg3SH8u9SsWQGUn=oSHHVjhdnn38w@mail.gmail.com>
In-Reply-To: <CANLc=autjsuVO3NLhfL6wBg3SH8u9SsWQGUn=oSHHVjhdnn38w@mail.gmail.com>
From: Shailend Chand <shailend@google.com>
Date: Mon, 6 May 2024 11:07:52 -0700
Message-ID: <CANLc=avO2Xmkjh=VsvCkN=jUEOpSFN-74MkbtByicsRs+GANNQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/10] gve: Implement queue api
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, pabeni@redhat.com, 
	pkaligineedi@google.com, rushilg@google.com, willemb@google.com, 
	ziweixiao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 10:41=E2=80=AFAM Shailend Chand <shailend@google.com=
> wrote:
>
> On Sun, May 5, 2024 at 6:40=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.or=
g> wrote:
> >
> > Hello:
> >
> > This series was applied to netdev/net-next.git (main)
> > by David S. Miller <davem@davemloft.net>:
> >
> > On Wed,  1 May 2024 23:25:39 +0000 you wrote:
> > > Following the discussion on
> > > https://patchwork.kernel.org/project/linux-media/patch/20240305020153=
.2787423-2-almasrymina@google.com/,
> > > the queue api defined by Mina is implemented for gve.
> > >
> > > The first patch is just Mina's introduction of the api. The rest of t=
he
> > > patches make surgical changes in gve to enable it to work correctly w=
ith
> > > only a subset of queues present (thus far it had assumed that either =
all
> > > queues are up or all are down). The final patch has the api
> > > implementation.
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [net-next,v2,01/10] queue_api: define queue api
> >     https://git.kernel.org/netdev/net-next/c/087b24de5c82
> >   - [net-next,v2,02/10] gve: Make the GQ RX free queue funcs idempotent
> >     https://git.kernel.org/netdev/net-next/c/dcecfcf21bd1
> >   - [net-next,v2,03/10] gve: Add adminq funcs to add/remove a single Rx=
 queue
> >     https://git.kernel.org/netdev/net-next/c/242f30fe692e
> >   - [net-next,v2,04/10] gve: Make gve_turn(up|down) ignore stopped queu=
es
> >     https://git.kernel.org/netdev/net-next/c/5abc37bdcbc5
> >   - [net-next,v2,05/10] gve: Make gve_turnup work for nonempty queues
> >     https://git.kernel.org/netdev/net-next/c/864616d97a45
> >   - [net-next,v2,06/10] gve: Avoid rescheduling napi if on wrong cpu
> >     https://git.kernel.org/netdev/net-next/c/9a5e0776d11f
> >   - [net-next,v2,07/10] gve: Reset Rx ring state in the ring-stop funcs
> >     https://git.kernel.org/netdev/net-next/c/770f52d5a0ed
> >   - [net-next,v2,08/10] gve: Account for stopped queues when reading NI=
C stats
> >     https://git.kernel.org/netdev/net-next/c/af9bcf910b1f
> >   - [net-next,v2,09/10] gve: Alloc and free QPLs with the rings
> >     https://git.kernel.org/netdev/net-next/c/ee24284e2a10
> >   - [net-next,v2,10/10] gve: Implement queue api
> >     (no matching commit)
>
> The last patch of this patchset did not get applied:
> https://patchwork.kernel.org/project/netdevbpf/patch/20240430231420.69917=
7-11-shailend@google.com/,
> not sure why there is a "no matching commit" message.

This is the v2 patch that did not get applied
https://patchwork.kernel.org/project/netdevbpf/patch/20240501232549.1327174=
-11-shailend@google.com/.
The subjects of the cover letter and this patch both are the same,
differing only in their number prefix, maybe that could be triggering
some issue.

>
>
> >
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> >

