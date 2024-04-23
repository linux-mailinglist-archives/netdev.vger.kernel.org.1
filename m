Return-Path: <netdev+bounces-90553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2BF8AE777
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1E328725B
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA25135A48;
	Tue, 23 Apr 2024 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqMNts0R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B513540B
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877692; cv=none; b=T8iRD7P2GI6gcKPGvBIEtLBVrRB+WIe/Gf6PyzrQZU4IbFnVttRr4y9S+NOaqKxcvbBvwt/dJ83pZcDp8U+eI93SxegQIcQ80/x4KDoIXxpaQBRAp7gvakmmuP5ISbQZ7iatCN4GtKckAxkr0FX0P6s72QsOAf/9xozbC2evIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877692; c=relaxed/simple;
	bh=DIofB15Qivmzs709LA/UCNNp98ddCcOIPZm7noqNGaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTr/zuIhpxGYfmHeCCGgi15UwR7dTJo3KNiqK0gHDMcleM7mBDGKWSe2fy393PeTEokV4VMgG1jpPP5nvYw0OOh/TGoWEqbJTQP7WU+HmpcTrD6FVURyyDnN1FoNVEnvXU+nnFY4evodqTJDB7NKAPc1PyJLZeEs9IF+V1mBIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqMNts0R; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so13303a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713877689; x=1714482489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIofB15Qivmzs709LA/UCNNp98ddCcOIPZm7noqNGaU=;
        b=YqMNts0RkTxGf4PE44Pbu18mzP0+E5GwVdik9HxBvAYppbNLpSd/s7gl5tHUkfDviL
         3gITSn+zH27wtApquJeXJ7I+43T53MVseBejuDEpQ4EhyQAC/Ab3SnxKL58CxJdPlpcf
         wq5I5Gn2HmAbElbQVFTJGOa6JNbKxE+uNY3xW5Nqr/45xpy0UNqIkOrRJziKjtVSLjon
         WnOhvLS8T0BsvIPzhoXeSCEwnC/4qRayfxfn0f8qQ4M5sfyl5a0rgVf2Rv0jyB6/ebrm
         89PzHiHnUaQKQM1U+NzzUcK+XksjSju2svGQeccwfAHwNfyDdjYJEqopV9go68d+Dy6r
         bjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877689; x=1714482489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIofB15Qivmzs709LA/UCNNp98ddCcOIPZm7noqNGaU=;
        b=oOGgCZB+Y4H5bVCLEuYDPlJ0/q1fykQudnjh6cKwLIgDpzUtATipPVUepOrmRsc5iH
         NqqWAAZgSBgCbkQxzDpRt+M2k6KKF0tk7/xkOThesbwQQt76CDuYY3cXxiTCysHRaq6g
         t5/1YQZaPZLTOr2n83YlBHhXRTOwoZHO5cMY7i0GOkSyCfF7lMCtX1gksUPC6RXS12te
         AceomHni4vWYsycwZBSW3ART1Lp1QwCdUVbt6SvVD9D9ayM8b5sWnmIgGq8bkP12nZ4x
         3mbY7l4KYsqFzba1dOnnYCDCNB1VMKQPGD8nrYr1JwgvhzeiEekwV8A2fF84jG1IOEX0
         FFWA==
X-Gm-Message-State: AOJu0YzTZR/DyFTce/LQq2eLc0yG+Rr46A/wcNYmdTRAQgfKuMAN5LtM
	h+rnawzy7CsgVpIkm2lSvEHJD+gNQZYInLmTY1I5AwImNXWOIGuW2RC7Hkzaa4k2V8tWsVnS/3B
	fiB92/LPd2BTcSYL8Kz5mcC/eWrF93g+0p2LB
X-Google-Smtp-Source: AGHT+IG1CqMYXDb6MmvohfvHnHDpajO9sP+RZzdX7WxKkEgj20SOdwCh4rNvJCngR9zCOPE9b1XHP8y3Qyb/r0YiJug=
X-Received: by 2002:aa7:df98:0:b0:572:2611:6f38 with SMTP id
 b24-20020aa7df98000000b0057226116f38mr18681edy.2.1713877688658; Tue, 23 Apr
 2024 06:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423094117.93206-1-nbd@nbd.name> <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
 <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name> <CANn89iJZvoKVB+AK1_44gki2pHyigyMLXFkyevSQpH3iDbnCvw@mail.gmail.com>
 <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name> <CANn89iLddm704LHPDnnoF2RbCfvrivAz0e6HTeiBARmvzoUBjA@mail.gmail.com>
 <ebe85dca-e0e9-4c55-a15d-20d340f66848@nbd.name>
In-Reply-To: <ebe85dca-e0e9-4c55-a15d-20d340f66848@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 15:07:54 +0200
Message-ID: <CANn89iLD1JW078L9hkex+WZdAcA5unC5_J=JjUG1ypZM_syFtg@mail.gmail.com>
Subject: Re: [RFC] net: add TCP fraglist GRO support
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 2:23=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> On 23.04.24 14:11, Eric Dumazet wrote:
> > On Tue, Apr 23, 2024 at 1:55=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wr=
ote:
> >>
> >> In the world of consumer-grade WiFi devices, there are a lot of chipse=
ts
> >> with limited or nonexistent SG support, and very limited checksum
> >> offload capabilities on Ethernet. The WiFi side of these devices is
> >> often even worse. I think fraglist GRO is a decent fallback for the
> >> inevitable corner cases.
> >
> > What about netfilter and NAT ? Are they okay with NETIF_F_FRAGLIST_GRO =
already ?
> >
> > Many of these devices are probably using NAT.
>
> In my tests, nftables NAT works just fine, both with and without
> flowtable offloading. I didn't see anything in netfilter that would have
> a problem with this.

This is great !

