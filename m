Return-Path: <netdev+bounces-211956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739D3B1C9FA
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 18:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECCA3ABA39
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F0A29ACCE;
	Wed,  6 Aug 2025 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkpfckko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF991273804
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498952; cv=none; b=N47MSYwVUhpyW/0Ip9c+Zoot7QHTPfeuS44Djj1+RFZKhhY007fOxFSttoH/+tUnXNsw8lVH4NGip4WM9wLHjBi5NmADLJcoL2iiT1ayebyhgQggEkk+nXQoJiAGGlgHWWYjW1zsoejsA6gwvI5v2asoc9A2Vl7o1WoC0SE52QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498952; c=relaxed/simple;
	bh=ZeSXh39h6xtD2zkk9H9FdoX/x3k8q9HT+wNdGyALMGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpcEnQExJU3tyo/dfsxZPyCdNANtRPePvRcUJme42OphPX55z0iP+eYwJaoxXJ1eMvHL5A1/P0gLfOoIV9kmcXeo5v/Bf/bVVTu4Ww4jMrcBn9YsYPJWyxec5tIpNfDBUJU640kYxt39q9ymT4IxNuirs9Dv+7EIGeX1PCFfurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkpfckko; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b7bf0a8d5so208e87.0
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754498949; x=1755103749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B3mKu8ZyXZgyldx1ID9yYSp8otWO+26YrXQxjyJZvw=;
        b=gkpfckkolCpFpVjcD8liMZ9zH/viIv458SLSDPxqCMCNYq1dPlmV4N9OH6wC7qNyII
         b3IQ3zqm1KtCWnY2Co7+yQ8e+qG+THw19ryc0JDRDo/gDuCcSuxn2hZmeR7qzD9ppaF/
         Vzh5tV+XdIfEFKMqOt2WoLooZFC9tsHvjj+mhGO7YUC3mgsPcHJzCqPnUSHDVQjIyAR2
         K2NZ6OzcMH5HK/LFOzTVwZNLshJFutXVqx++6UhSb/v8h61fOcQbAAK5p2EPOqZ5Tf1O
         m+HliONRN2az34P+nKBelULmkcKdVbiIe3amgj6yK9C1f8vdjmFClfotMVjT0Xb1UCak
         7PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754498949; x=1755103749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+B3mKu8ZyXZgyldx1ID9yYSp8otWO+26YrXQxjyJZvw=;
        b=d0x8eIyhpov17jLFghCQYMhswb06DaHjYrHGTtDgkNZ3+9lMDLXMOqFj1sos1Mb5lO
         HxjUVYej6/Ym+BBLj78AxqM/Fc81yCA/7hNBZYtdErFgiezhn3Lzy9HVuf6R3n4796Qa
         XOra87hvfXCXr0dDsaZY9kcRt535NIRKKXTKD6fm0qoaqlTfDIbT8RtnDJj0hoW7J6Ju
         LTGCiaKEp/gPJgbKDut8eOeHstNkCuWAkt63Vue4IFHPco6jgpEnGHH4AmSfgUdvLgbb
         z1OjyGWZoeD+h04iqezsp+YFEjJMs7UEumnEXF0cBA3+0gp2hjm/UjMhScRKm/XiKcqJ
         xUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVqpdGRD3i6ZBPilVwllgl+81/O+sBz5V+pa75pPWNzWsxMIYurL7OoYRX5diTx2vBJBtbGg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3z2MykTLeY0ocQhbCg/8hr3h1MVl0UQlzgllk3F0iiSiaYS7
	hhCMa3qAFgjoslfVSZZPvcVVe7sPIooRNpd39nyAyv6K9sDtUaA2zu3b84jPnjIOtV/5YGxAMef
	HgQb11FkoEaD1IsE2YLCSBFInBkt8XG4uPro94qgN
X-Gm-Gg: ASbGnctixbjOjL9JrM8DpUX9q79M4uN6vhHICO87UZA+4i6s+XbOC3Aj4p9ryPsRU/S
	QbfhBHvMZzllFVdm88RrBgRuycBodQ70NndsmYJFouk+DMpCzr23E7gLSe/Vvs91FU+RrfiikWI
	8lj60HPZzg2Djjc3xw0H+QedqR8wpT4AJ4R5EzQ6aCRqX3mTBCELBA27Yx/0fUiRXINESfCdYlx
	TvyjiQcieVX8+YSBsT2fYRV7Sm2F3hBJYLVRswekJmURCQ=
X-Google-Smtp-Source: AGHT+IGOkbe9dbWGnS6+1s7Wq6OW/Qhyhn3uo+RLlUMybsqoGGjikVLHhoAhtv1rxFzxt9dArPaa1GD+Gkz5VfNZjqc=
X-Received: by 2002:a19:3844:0:b0:55b:99e4:2584 with SMTP id
 2adb3069b0e04-55cae73fc3bmr344237e87.2.1754498948708; Wed, 06 Aug 2025
 09:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753694913.git.asml.silence@gmail.com> <ca874424e226417fa174ac015ee62cc0e3092400.1753694914.git.asml.silence@gmail.com>
 <20250801171009.6789bf74@kernel.org> <11caecf8-5b81-49c7-8b73-847033151d51@gmail.com>
In-Reply-To: <11caecf8-5b81-49c7-8b73-847033151d51@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Aug 2025 09:48:56 -0700
X-Gm-Features: Ac12FXybC97X31wROsEYSpZV1hSDgT6IyYQ4soYHYXhWxQfaz8IZ0d2rVCtC95M
Message-ID: <CAHS8izNc4oAX2n3Uj=rMu_=c2DZNY6L_YNWk24uOp2OgvDom_Q@mail.gmail.com>
Subject: Re: [RFC v1 21/22] net: parametrise mp open with a queue config
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, io-uring@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 5:48=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 8/2/25 01:10, Jakub Kicinski wrote:
> > On Mon, 28 Jul 2025 12:04:25 +0100 Pavel Begunkov wrote:
> >> This patch allows memory providers to pass a queue config when opening=
 a
> >> queue. It'll be used in the next patch to pass a custom rx buffer leng=
th
> >> from zcrx. As there are many users of netdev_rx_queue_restart(), it's
> >> allowed to pass a NULL qcfg, in which case the function will use the
> >> default configuration.
> >
> > This is not exactly what I anticipated, TBH, I was thinking of
> > extending the config stuff with another layer.. Drivers will
> > restart their queues for most random reasons, so we need to be able
> > to reconstitute this config easily and serve it up via
>
> Yeah, also noticed the gap that while replying to Stan.
>
> > netdev_queue_config(). This was, IIUC, also Mina's first concern.
> >
> > My thinking was that the config would be constructed like this:
> >
> >    qcfg =3D init_to_defaults()
> >    drv_def =3D get_driver_defaults()
> >    for each setting:
> >      if drv_def.X.set:
> >         qcfg.X =3D drv_def.X.value
> >      if dev.config.X.set:
> >         qcfg.X =3D dev.config.X.value
> >      if dev.config.qcfg[qid].X.set:
> >         qcfg.X =3D dev.config.qcfg[qid].X.value
> >      if dev.config.mp[qid].X.set:               << this was not in my
> >         qcfg.X =3D dev.config.mp[qid].X.value     << RFC series
> >
> > Since we don't allow MP to be replaced atomically today, we don't
> > actually have to place the mp overrides in the config struct and
> > involve the whole netdev_reconfig_start() _swap() _free() machinery.
> > We can just stash the config in the queue state, and "logically"
> > do what I described above.
>
> I was thinking stashing it in struct pp_memory_provider_params and
> applying in netdev_rx_queue_restart(). Let me try to move it
> into __netdev_queue_config. Any preference between keeping just
> the size vs a qcfg pointer in pp_memory_provider_params?
>
> struct struct pp_memory_provider_params {
>         const struct memory_provider_ops *mp_ops;
>         u32 rx_buf_len;
> };
>

Is this suggesting one more place where we put rx_buf_len, so in
addition to netdev_config?

Honestly I'm in favor of de-duplicating the info as much as possible,
to reduce the headache of keeping all the copies in sync.
pp_memory_provider_params is part of netdev_rx_queue. How about we add
either all of netdev_config or just rx_buf_len there? And set the
precedent that queue configs should be in netdev_rx_queue and all
pieces that need it should grab it from there? Unless the driver needs
a copy of the param I guess.

iouring zcrx and devmem can configure netdev_rx_queue->rx_buf_len in
addition to netdev_rx_queue->mp_params in this scenario.

--=20
Thanks,
Mina

