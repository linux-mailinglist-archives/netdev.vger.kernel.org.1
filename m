Return-Path: <netdev+bounces-72960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FE485A640
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 15:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35ED3283C45
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42CE1EA90;
	Mon, 19 Feb 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSE3iKHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0E1E89E
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353772; cv=none; b=UIls5czHHz/s9DiWBOmBPeX1ot5rsk+FgeqlbpCgoUxAxaFphdFOQ/fiqPzuXCLBW1iX+FhVswevAPEwolUxAApp4JuQlI6OL9KIH7fASDx4TlNh2AS3u0kp596zJ/oiVBk0CWXsBRJiXLyumeRLiTihBRu6FNb8aSUw8maBfoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353772; c=relaxed/simple;
	bh=pAQ36Mouu5LBU9w/qPkLQEX9p2kwmTFAJ2rFQbxWzyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8P/KpOi9MFoUdjDYaittWQR5dV/opeoBVCBJXnf3UCiYQfBdrubCD1tJILDLtJjNN/Ut84aMULOxpSfkyLRRk1w5iEXL8yt8uf98aYhQhAfl+aZSx3i4RIzInTWI0Ng8UIRCWu791QjNmW0J/tMzEfGpTShFCGKJgpVC4sH2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSE3iKHm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso13742a12.0
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 06:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708353769; x=1708958569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QK6TJ1NiFtkG4ibJWHZitNlZraEYM47hN7HesdXjSmk=;
        b=QSE3iKHmoGpXseBVKAYWaMMwr41vY9ifkCHKdzm5WGSeedcwHNIL1QSLMtyn6dyUkm
         SwYqRkY5iJU9X6PQnsQgQloOskR3MkfKDEJkRvWom61X34cVgH65ecqQ4HHUhVHHSteC
         9b7MU9htDrwUXtF0edX1FZzmwduIJyDE+xA8SuN8A1Cq61wZznvsNJMwzn4f/+g3RqLg
         KUHZY/hSeuWJjcX6jYzbQC3MLN0tzK9mrwV+wHTGHOxES9J6hOuUV92VIXGv2XRbFx+H
         7cM5D/TgmqOZH//tsrWNwHSTPIuBRx1xnykvLlKcNnMDZ4KJnkOr3FK9nJ+J/+81ASXH
         9jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708353769; x=1708958569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK6TJ1NiFtkG4ibJWHZitNlZraEYM47hN7HesdXjSmk=;
        b=PBiZXdwo41VUWZYWkuDoIml4HLBtgRI9X9IyaiLu1xwS5xoIAGqQiyvJwqj6Qjmhpc
         CIonnpuXzTvy5gR2vXwOmHFrIIl0v7xN51KFxF/NJL0iODQ3TILq12V1xcFEAqebicKD
         dRoWFupbku7CrLQK5YHAgPpWUrcB/sFqCzWeZafYuNgPM1P6D62w9cvsA6LaM/uxelm1
         GuxOMLumwecPisDNL8uHggN5lHa5gvjp5REKCXbFJi71dTkpe5NERZYF7icBeqYzDlGs
         FCeBnVUNdl9vqyTcCQ6rVAI0aPrRrEfYVOHQnfgSgRxWhc7SpDJAsAsnjfU4mJkmW5+8
         TXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSVsAeN083gLXV2C5sawEgqVeDA2slIV6CKRqOrrOr9TwcMxwP4hgVJ8Cer4+0F/NP/uuI/3GBUlqURcBuemiu/IMKncaB
X-Gm-Message-State: AOJu0YwBlzpNrSWocQmhO515LtapwsO42ev1vkXOPZPdmM0Kj8DG0qbW
	KNvLs9LNni+jusqgTJVwoBQhjIxpk5tkGSjFK8NONO0Afde4Mitfx6ks9Jc8uB5F2V42qH3EEiD
	i/+O2Z2QnkZM0H6I+S2s4xRdBivQ8KANJ+LMW
X-Google-Smtp-Source: AGHT+IETr5Fg0KJAZlnaeDsbnQhKIQl70L4uyU1bEvQGzZr716e4ct6UKPj1TKwF25G19fVSf9HT3kKxRf0iELr+aGg=
X-Received: by 2002:a50:a697:0:b0:563:ff57:b7e8 with SMTP id
 e23-20020a50a697000000b00563ff57b7e8mr298755edc.1.1708353768955; Mon, 19 Feb
 2024 06:42:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219095729.2339914-1-vschneid@redhat.com> <20240219095729.2339914-2-vschneid@redhat.com>
In-Reply-To: <20240219095729.2339914-2-vschneid@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Feb 2024 15:42:37 +0100
Message-ID: <CANn89i+3-zgAkWukFavu1wgf1XG+K9U4BhJWw7H+QKwsfYL4WA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
To: Valentin Schneider <vschneid@redhat.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, mleitner@redhat.com, 
	David Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 10:57=E2=80=AFAM Valentin Schneider <vschneid@redha=
t.com> wrote:
>
> The TCP timewait timer is proving to be problematic for setups where sche=
duler
> CPU isolation is achieved at runtime via cpusets (as opposed to staticall=
y via
> isolcpus=3Ddomains).
>

...

>  void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
>  {
> +       /* This can race with tcp_time_wait() and dccp_time_wait(), as th=
e timer
> +        * is armed /after/ adding it to the hashtables.
> +        *
> +        * If this is interleaved between inet_twsk_hashdance() and inet_=
twsk_put(),
> +        * then this is a no-op: the timer will still end up armed.
> +        *
> +        * Conversely, if this successfully deletes the timer, then we kn=
ow we
> +        * have already gone through {tcp,dcpp}_time_wait(), and we can s=
afely
> +        * call inet_twsk_kill().
> +        */
>         if (del_timer_sync(&tw->tw_timer))
>                 inet_twsk_kill(tw);

I really do not think adding a comment will prevent races at netns dismantl=
e.

We need to make sure the timer is not rearmed, we want to be absolutely
sure that after inet_twsk_purge() we have no pending timewait sockets,
otherwise UAF will happen on the netns structures.

I _think_ that you need timer_shutdown_sync() here, instead of del_timer_sy=
nc()

