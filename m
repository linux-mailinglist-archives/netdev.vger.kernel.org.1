Return-Path: <netdev+bounces-69737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BC384C72B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF4228486D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4020B34;
	Wed,  7 Feb 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHu106qS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71304224D0
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297728; cv=none; b=ESA6p3foJCe+sl/sPHR9fHL99DgaSr7BLR7EaldX/TDQenXtNxQ0LTxnw1p3ZEXGaR8hgMa9wnX1uUiVUSCJLaUAdpmv8ZuqjwQJmrnnoniNUes5UGTbsW1OVE6wTAgcuxTIDD5DK6mMpi4o5B1OeUj9Qt7GDhclOX9QeqN9gNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297728; c=relaxed/simple;
	bh=QhdM2+Xhggsmm2ezCwxAIvuC5ui7npY/3Cs4Pre4RIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/TPO8huznrE7OO1g9RH6EjaruEgX/SOLy/RVyw7YGdA+/Se/nxDDTStUFM2YNGVyI05ht0z/hQ3J3VYuhVDmPOvQwCddcuXRTatWT44nGadpG1htgqhV8QHdYWxpRWJXUVg9Rb+vue+JJqDGGqQegIJhYGBer5PjuL9IWgay5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHu106qS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so2369a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707297724; x=1707902524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9bgOSEH/lYxqRjBoXPOa6QNn3wkWr1gBJ8h9myxpXo=;
        b=PHu106qSm03F2wnFoyayc6jGwlXSRiMbCRBBQC4rita55Nv1q/mooWWoDujxrf/kTb
         LMiYgloHra4NbQyceJR6xd6AyheVY5/Os0L+Ltvhltx2nNGwvGoUJnRn5zuyo+BeBPT0
         zMmOAT9yhoLMILzwabO75qGaurIP1feGhJmArGFC0ituon6yeS3g2hoo7dpOwbJXfXRQ
         DECHCzZ1UAu7wyJKAru12isHZITSbztqwgtnlJMhiAhrvQWG0Bn19zvJvDn0rTrutnKZ
         m7dMDGaJNi+hLVoFmHXZrimabQ087F5+dqrr3kqWwLmw2eS851YsWaDLhLMqRxQZAD/f
         hJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297724; x=1707902524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9bgOSEH/lYxqRjBoXPOa6QNn3wkWr1gBJ8h9myxpXo=;
        b=SNVb6SlIg+Po2S6zsHE9HBDndrr68TOMq1KPXSWlLtbM94TxXKOzgqz251jmr72sun
         9H7rPviia6PyqbqrYRoUDaV1cOLiiHSh0io1djheLAdyS5bUk81dzeNQbtenGzLGbNcm
         gRWy7x475h6LCaZ3I7r2pII8j25/B948pCiNUba2ZA+L8gNi/6T499D1evNeyDn7oRtb
         FzdEZBB6X6iRUUGtaCbRHJ8dGfOd9PkxGuOO7rVFPHcClnyRUy1duL4h+EtCMIWsHaZ6
         uYJloVAybaDm9p5CFP+6UEUFi+QsTfCtPJR/ESiLH0KrnGDEM/R4cTatMkdSuxrvElkG
         aSKg==
X-Gm-Message-State: AOJu0YyoqJJwoJLddhEo+CCcmMcc6+LSOXXp5ryLM9MzHFj+j83pGKzw
	CFYlRXNkyTHJXajelbw/pRBqvgzjiUSgLq28+cIAf5d8nRPy0r49/X0E7L3hf2X9BfyqKZ1Tw2h
	TFnreB57sqbPGYZRk1Qk16vxHzsFwmC6xMcJu
X-Google-Smtp-Source: AGHT+IGl4poXY5ezL4n0udkgsbsJ8iCVp2IATa8WcVYZnGT+dWar7PzcP6+TshF0WznY9xgXQXk45XtsaNYN6f+X+PM=
X-Received: by 2002:a50:c05a:0:b0:55f:daaa:1698 with SMTP id
 u26-20020a50c05a000000b0055fdaaa1698mr64923edd.6.1707297724303; Wed, 07 Feb
 2024 01:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204104601.55760-1-kerneljasonxing@gmail.com> <CAL+tcoCZG=SCPZDd3ErxFCW6K8A_RHaYR6vJTQJB_BOkhsg-JQ@mail.gmail.com>
In-Reply-To: <CAL+tcoCZG=SCPZDd3ErxFCW6K8A_RHaYR6vJTQJB_BOkhsg-JQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Feb 2024 10:21:49 +0100
Message-ID: <CANn89iKRCxmMH5f_NxDCXHNzRvk+oKT7t9m3r_=hOwP5rSkwTQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] add more drop reasons in tcp receive path
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:24=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Sun, Feb 4, 2024 at 6:46=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When I was debugging the reason about why the skb should be dropped in
> > syn cookie mode, I found out that this NOT_SPECIFIED reason is too
> > general. Thus I decided to refine it.
>
> Hello, any suggestions? Those names in the patchset could be improper,
> but I've already tried to name them in English :S
>

Adding &drop_reason parameters all over the places adds more code for
CONFIG_STACKPROTECTOR=3Dy builds,
because of added canary checks.

Please make sure not to slow down the TCP fast path, while we work
hard in the opposite direction.

Also, sending patch series over weekends increases the chance for them
being lost, just my personal opinion...


> Thanks,
> Jason
>
> >
> > Jason Xing (2):
> >   tcp: add more DROP REASONs in cookie check
> >   tcp: add more DROP REASONS in child process
> >
> >  include/net/dropreason-core.h | 18 ++++++++++++++++++
> >  include/net/tcp.h             |  8 +++++---
> >  net/ipv4/syncookies.c         | 18 ++++++++++++++----
> >  net/ipv4/tcp_input.c          | 19 +++++++++++++++----
> >  net/ipv4/tcp_ipv4.c           | 13 +++++++------
> >  net/ipv4/tcp_minisocks.c      |  4 ++--
> >  net/ipv6/tcp_ipv6.c           |  6 +++---
> >  7 files changed, 64 insertions(+), 22 deletions(-)
> >
> > --
> > 2.37.3
> >

