Return-Path: <netdev+bounces-195299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B92ACF530
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 19:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8104F3A3C71
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A827C15C;
	Thu,  5 Jun 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwAyXaEw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B227BF83
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143766; cv=none; b=eLeO33q+7UqDN46D3faXN3izkAvr+AuGTm0F8N8yQdlg6JDSJW9ucExatTIt+Zux3VsGrF8hoOyHchjsBGhpnYPxKsgQNAq8Ovkk/yzo/Cza8kDhG+ukr9qaSS3p5+cDMhPxDVr2D9eKacJ6enSAsIwoIVliadNMu/zohq5QTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143766; c=relaxed/simple;
	bh=BsygIKSp4Y3uOUd9YvjvTHCT2OkAn7HB5ddVxCuXJEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GD/6+svThKXu63IKLIudi5ubjYjcyyeJARsS4AkRNbRziEx9cZvxvOYDpwTOIYwWj6no9bZh6v8wnC5C5movnS7qa2/GPKuFbs6Qi+k9XNtBnyJOIaW0ncpIriaqsy4B5RcLVXnIBFHvHsiHt5JC8ODs6E2IeTx9BsLrr/JWAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwAyXaEw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso634a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749143763; x=1749748563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPVE+qJAV6lF2hHXHMzzV+2De3yTj5blSt0gISYXzwA=;
        b=MwAyXaEwlZ7Nxrxm/X6cB0znXJd7O7WKJzf2NblihAy3Ww9LpVGuJtoIsh4BW8CRAX
         1Epaq2CeQzEsTahYiq0LArwfoMvR3WlIuTUvc3dBJYzVdWkaeOc5HP9h4yiDgMkHTphT
         cdz/srYV1XFjAFAcHK0iC79USIKJTN/kyKgrV/koT3pUbLuIXO6E4nuWycE7JLE/G/QP
         3w6oXGuOH4dRw5cvDXnru7LfvM2Z+1yyZI8bSt5CEtBuIVY3Ad1GG8TdEoiiyjPGvN5R
         mL0Z6rShShxT7tIr3JnrIdQP8FGHF2KOAHbU0PNG2i95oblAB5Dajimsf6tin2zbkZ9V
         qYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749143763; x=1749748563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPVE+qJAV6lF2hHXHMzzV+2De3yTj5blSt0gISYXzwA=;
        b=sDibk8TmktMTCPKDmkH8kNCJt6X2Qc4118TGrnxwwYDq34CNFgEy/5MJbpkd5YY243
         OjqvsiNna6WPOnw2q66bHyMcXkRgv24zf2BbBXE7dVBQiZ46yxezbPy5A7VViDbcTZRO
         iI614iFJ2zvCCtl3gwS7EGXmcH8zkC8MHJ4+yBGXQwjHtR4v2a3X/p+BUG5LfFjsEXYl
         Qi2Gu1FKNgWhQnjZKLsiN0zN/deT3vFgZYjtVoC7mIHpJjjLAYrSozSCXiDSnmEJ3lc1
         rza4qoiqssTRBKKD6YEGYkK3vFXLyto/6LN7yZ2Yo4gSpsnyxBR4EPq2KNLWjwkP0FK8
         fyuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2zdDzYKUhfzPcb+YtQvHf1WUPU8Oz9wG5ZXlwlmHKNy8Byobv7hgLpbqZgHDRQzrMkznlpg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhpszXccDHnJH1yw7YISeuGxK5e6DAOphHGguRx8QxGj0/Hl/
	0fyrMLvRaaTi9GSNg6Wreczp4D4n/2Ch+UZzI16MS1LgGygGlhrddni7+CSy+XW8fDWG8sdfK2P
	dPjIRi6i1k+cpizA5Cr7Q1fD7BUg4KoEI3nPI/of1w2P4UDvJ+agpAhXz
X-Gm-Gg: ASbGncu4XH5C+am44V2yRmmA6xyWN86DlCLvdVzKc6VU4Hl70AmaSdJtqBKgYm7ZAd5
	vNem7wsk0cStksrflaKGw2LwgxviDUtYlfoQ9g24GdEr32P7YW15vG/8sT2YjNEbcq79k91c0cn
	5Uooxz5cBYpLn5wuVCa5JpEbOYv9rxEfZ07lsuKsuz2oXCOlDaGwmLdo4DP8HLBLh559nV08j6E
	Q==
X-Google-Smtp-Source: AGHT+IEsgNzktdJh8pc4Dp3J6fwwrOaLSQOcszvs7/V6sLuXQttJOIsOGPFSPRrS9VKP14E+I/IdyLbh1uIoYp0lGsg=
X-Received: by 2002:aa7:d9d3:0:b0:604:58e9:516c with SMTP id
 4fb4d7f45d1cf-60728a7df98mr100839a12.5.1749143762656; Thu, 05 Jun 2025
 10:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604201938.1409219-1-hramamurthy@google.com> <20250605081301.2659870c@kernel.org>
In-Reply-To: <20250605081301.2659870c@kernel.org>
From: Tim Hostetler <thostet@google.com>
Date: Thu, 5 Jun 2025 10:15:51 -0700
X-Gm-Features: AX0GCFvU2CbYecoDIb-s7wGpB4WkLnNVAMUQD6Cou3zqyUzrgIjk7T8up8uY8kk
Message-ID: <CAByH8UvMV94aVmmwb37f-wT8HpPKB3Nf8AF+67FM87XBz7+pww@mail.gmail.com>
Subject: Re: [PATCH net] gve: Fix stuck TX queue for DQ queue format
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jeroendb@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, pkaligineedi@google.com, 
	joshwash@google.com, jfraker@google.com, awogbemila@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 8:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  4 Jun 2025 20:19:38 +0000 Harshitha Ramamurthy wrote:
> > +     netdev_info(dev, "Kicking queue %d", txqueue);
> > +     napi_schedule(&block->napi);
> > +     tx->last_kick_msec =3D current_time;
> > +     goto out;
> >
> >  reset:
> >       gve_schedule_reset(priv);
>
> gotos at the base level of the function are too ugly to exit.
>
> Please refactor this first to move the logic that decides whether
> reset should happen to a separate helper, then you can avoid both
> gotos/labels.
>
> goto reset should turn into return true
> goto out should turn into return false

That makes sense to me, I'll refactor this in v2.

