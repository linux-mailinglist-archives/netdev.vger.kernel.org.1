Return-Path: <netdev+bounces-112626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1AE93A3BC
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291F01F24170
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB17F156F4D;
	Tue, 23 Jul 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04TNb92N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066443D55D
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748382; cv=none; b=ZTpHFC34kpWUmWI48J7xjWGvNF//CSTht8z6+cifz1Z8Hpx8kac/fwri8hwOkXIxqMahSkmAwi69L4pAmOmwypfj2KNythPL/BucsqJALmTDF510O9JBwwesIeCz/l1cZHUofPVmGooIootKOwzQrvVr1mXYTxYMGbYc00ui54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748382; c=relaxed/simple;
	bh=srzNmF6J9gBMi9rNO0TUXYo3B2NQIbrp0PsLSN5rh2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEDvyyr4UvSimEsIhFnDQ7X8YRVOZexfq6+FEG3+Cc2nGEJxuTpkFUHUD3XFb775tkUwnhp+MouuRVNI9+wB8kt44iZDuUYvrf2m0sMDykLLOLIOBbxD7zKVrAiUchgcvEiC5Il5qDhR0Ap8jCMchFYxFDAIYeanndvtX4oSNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=04TNb92N; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso20612a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721748379; x=1722353179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srzNmF6J9gBMi9rNO0TUXYo3B2NQIbrp0PsLSN5rh2M=;
        b=04TNb92N+7z2vMDUejPPsCOmHyIStVlOI6LmlKGfxGTqWVRGeFmE12lbeh+cvz7HRz
         2cbA7NCkSOsfEpl8eKn4NIizOZwxs5l0lLC/+rRT5uObcJB9pn6D8Y2lDv7aYu23aOQT
         Ywz85qeG2/bdD9J3Zm3lfAIcStlxStWBZm9zTWwQqCCdjWEBbiqejufBBoUWtV8iHg23
         daqXzxGVM4jvZDJwC8QnrTeMLCwuxMRnVGvTiKFpNUdpCsaFq0U7VvMTmlAPesUAyoMo
         pPRtsKz/nNTnTO9wMCF99gf37bPtrDQkdefRmwfCAg022D/PcWsCW3XvwXIHtKyWJPvb
         ZpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721748379; x=1722353179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srzNmF6J9gBMi9rNO0TUXYo3B2NQIbrp0PsLSN5rh2M=;
        b=wT8K6gxei+aZFh3uB6k5nyFvSpvfYDNYmwcZ5hyxhFL5ihjn3yxgagca76UY/8eaSM
         NFuDtDywS5s68FPO5B9fAoqnc/YiNfVM0TF53TPUXU7Z37W8EwkSZulxmbb3vuZ9a1UQ
         WOvKSYyjYOwx8T6Osd2oqhEKr74dAsVwNOn9coHVZnFwJmVJOvUrxJPZ8XpX2FbSo2ow
         j+BVhtf2RDF73E5Ia31gOn2PDAL3rqrUe4Pwmh1COKLsgSLdmUD7axmy9HuOJ2jooyy2
         vYnqrvDYDS/QfRR5lbWMXCUpKfL5ns2WUKM4Igxi3uJRP0Dkr3fPhNDPDVUorFQcH6b8
         WThQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFgvCJN827B7qwWzfGKuz85w9S/Ep/9jnhJWHWVoR51d+0VT24pOLsGmpm6fsVfNxCJubeUl2d7iOmXOVkErr9MmP3NdOi
X-Gm-Message-State: AOJu0YyvAYx/SgqtYxfuwF0qG0nYbZ/l6v1zg/Z9ykfK273NV3C9/7Wz
	lP74V2AONUjb2UNEjMirMK7Z2+jfIydWya5u8YSd0kzmavfz1D/kgUcOA+nLhe/ytUekyuJypvo
	grQeG0qWyGdpgrgUL8Xd3UXeA5gr8t3zAC0TJ
X-Google-Smtp-Source: AGHT+IFKBMaYSvQn1HJKG016Yb5ZwkKV5+V5vV6M55x5q6uPSk/7HYQR9fxODCLOI9Dj2o1y130JIFNHOurJbOKYPWI=
X-Received: by 2002:a05:6402:2547:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5a4a842853dmr577500a12.3.1721748378960; Tue, 23 Jul 2024
 08:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723135742.35102-1-kerneljasonxing@gmail.com>
 <CANn89i+dYsvrVwWCRX=B1ZyL3nZUjnNtaQ5rfizDOV5XhHV2dQ@mail.gmail.com>
 <CAL+tcoDZ2VDCd00ydv-RzMudq=d+jVukiDLgs7RpsJwvGqBp1Q@mail.gmail.com> <CAL+tcoCC2g1iHA__vr8bbUX-kba2bBi2NbQNZnxOAMTJOQQAWg@mail.gmail.com>
In-Reply-To: <CAL+tcoCC2g1iHA__vr8bbUX-kba2bBi2NbQNZnxOAMTJOQQAWg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 17:26:05 +0200
Message-ID: <CANn89i+3c3fg1SYEpx02yCKHfBoZvYJt=wTqgZ77nCWzN0q-Wg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: add an entry for CONFIG_NET_RX_BUSY_POLL
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 5:13=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, Jul 23, 2024 at 11:09=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Tue, Jul 23, 2024 at 10:57=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Tue, Jul 23, 2024 at 3:57=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > When I was doing performance test on unix_poll(), I found out that
> > > > accessing sk->sk_ll_usec when calling sock_poll()->sk_can_busy_loop=
()
> > > > occupies too much time, which causes around 16% degradation. So I
> > > > decided to turn off this config, which cannot be done apparently
> > > > before this patch.
> > >
> > > Too many CONFIG_ options, distros will enable it anyway.
> > >
> > > In my builds, offset of sk_ll_usec is 0xe8.
> > >
> > > Are you using some debug options or an old tree ?
>
> I forgot to say: I'm running the latest kernel which I pulled around
> two hours ago. Whatever kind of configs with/without debug options I
> use, I can still reproduce it.

Ok, please post :

pahole --hex -C sock vmlinux

