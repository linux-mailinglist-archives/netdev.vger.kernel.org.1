Return-Path: <netdev+bounces-88583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C729B8A7C94
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029F81C20B7F
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 06:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1442B6A33D;
	Wed, 17 Apr 2024 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/p2A7iB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF56A325
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336775; cv=none; b=Ud/+9aR4zkRavt/siNPYsVgi2cMZS743D0boCGhljnTR3C8Tp/vIoo+nwEwip8heN/AJqdehAdUVzTNyd/saG/VhojD/hEHkt5A/MkflVkZh/H0mXmuI07a8P/5ed47TKG9LrS1ydy5795GC3lPLQimbYerdgZOWvqRCLzOneP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336775; c=relaxed/simple;
	bh=CWmxHDGHvwKLlTrAo9tcQkBkOjqsjCVQtIgPBHR9YPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxbMBH7arko1I0IWI55IX3WE0Sjwe3+juk602esARQ9JpmgsFbUJBKHDJoNuJQbbCAqR2LW0NRoNVMMJcm8Vq+qy29G7Jm48wyVPd2/Pm4nOOH1RX6UNwnwqxhNQ6bZprCP35gIPfdeHZw1dPV0DlZkYqEDqsnZYV2kVBhKIk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/p2A7iB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51addddbd4so605597366b.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713336772; x=1713941572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWmxHDGHvwKLlTrAo9tcQkBkOjqsjCVQtIgPBHR9YPk=;
        b=C/p2A7iB3+Zoggdy6gchDoqvFV022H6fzCazn4/Kr7pJmConn3m2Q8zWpqETFEU7Sp
         FprYzihA0aD6H/JGqqxIUOJwTOnibLNaZ+vTmuDhyZTEjzjPLMZkWXSn/ZFfwGcEdV2L
         FopxqoxFexwDpedAbnCRZqYn+mvGTBdgjXD+80XlGGsTtiB2QFEkLlwvXjEvFQ2W/sdx
         PN6MSvd/b8C81qstlPiKivGd6/iMyO9EOIkGzcugonyICCPxMSD+pEa9ajWmLQAYOyJf
         rRCVod/8mvE0CYHEypEruLHOtw+1aQMCieZ+IpE3ennCGygaSvR3S55QzCTRCvHNu7EQ
         Rq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713336772; x=1713941572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWmxHDGHvwKLlTrAo9tcQkBkOjqsjCVQtIgPBHR9YPk=;
        b=QD8utO+79WD7gDf/dvqCiFUESn0mo1guSP+po8sp7fKoHpdqY1gCBy/cSzDqVydbEa
         MIEvdKJFfcrTQ9Mddif9ZQMEKarnWLA1mrD3gbgAviOVKC0ZYnMx3x4dMuj6zNwDdxxM
         74t5Cbt+AWhsEBgAx3zw1fM4HjsLlBzETuVSJM1vP3dtLZ/jldRJ9izYynnRAsLZasa9
         mjidxyk7rPpN/K5828bNuV9ve+N3SsRJW0rmK/j9vb+j41xbmN+m4PPSDXbXk/y5hFT+
         KSribcWn6qijCZONRQYuSPaQrfPJpleqkP1f9oKQZdh7jue5GUsySFXX+yGkE7v6zPQr
         BtpA==
X-Forwarded-Encrypted: i=1; AJvYcCU22184TU67AY71UlUKBbkMBFMCXMVFlpm+ozlw2AWb1DhasLN42/j58M+RyyUcc5SG6QjAZBQ5VR0sRlpdZAvWUpLbWApF
X-Gm-Message-State: AOJu0YxM1qoyzvxi53q4dy0jARvAp52yoVZEPmWSLZwlgcWnIoCdG5bd
	VESWzhxSh038GlzM90YXOfxvCrxs4JZgw9AW/VFmp1viFI0gV5aC/mZLVrva+mPg4KhOyjL/iG4
	qWTybaNCJl13J2SGxAXx24U7xWheKdXnO
X-Google-Smtp-Source: AGHT+IEK6SyzNHNLWDVG9m38qQ/cHS9V7n27oz4LHCwjU2ANrSRhqTNprA8tBP8e2Pnl2lRCtgn8TgKrDQcQAHb5pLg=
X-Received: by 2002:a17:906:3913:b0:a52:2dce:64a6 with SMTP id
 f19-20020a170906391300b00a522dce64a6mr9081354eje.17.1713336771469; Tue, 16
 Apr 2024 23:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
 <20240416173836.307a3246@kernel.org> <1abdb66a-a080-424e-847d-1d2f5837bbc4@linux.alibaba.com>
 <20240416192952.1e740891@kernel.org> <CAL+tcoDj11Y7o2f0Eh8-FMk0BxjtAwCupWaW7n7bOXTUVgAWSQ@mail.gmail.com>
 <26755c1e-566b-402c-a709-eeebe11352aa@linux.alibaba.com>
In-Reply-To: <26755c1e-566b-402c-a709-eeebe11352aa@linux.alibaba.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 14:52:14 +0800
Message-ID: <CAL+tcoAS81uW_aikoWrDhO-qF-aFD5rU4GsEAy2hHbC9ex2q5w@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/4] ethtool: provide the dim profile
 fine-tuning channel
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Simon Horman <horms@kernel.org>, Brett Creeley <bcreeley@amd.com>, 
	Ratheesh Kannoth <rkannoth@marvell.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:35=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/4/17 =E4=B8=8A=E5=8D=8810:53, Jason Xing =E5=86=99=E9=81=
=93:
> > Hello Jakub,
> >
> > On Wed, Apr 17, 2024 at 10:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> >> On Wed, 17 Apr 2024 10:22:52 +0800 Heng Qi wrote:
> >>> Have you encountered compilation problems in v8?
> >> Yes, please try building allmodconfig:
> >>
> >> make allmodconfig
> >> make ..
> >>
> >> there's many drivers using this API, you gotta build the full kernel..
> >>
> > About compiling the kernel, I would like to ask one question: what
> > parameters of 'make' do you recommend just like the netdev/build_32bit
> > [1] does?
>
> Hi Jason,
>
> I founded and checked the use of nipa[1] made from Kuba today. I used
> run.sh in the ./nipa/docker
> directory locally to run full compilation.
> If there are additional errors or warnings after applying our own
> patches than before, we will be given
> information in the results directory.
>
> [1] https://github.com/linux-netdev/nipa/tree/main

Great! Thanks for the information:) I'll try it locally.

Thanks,
Jason

>
> Thanks.
>
> >
> > If I run the normal 'make' command without parameters, there is no
> > warning even if the file is not compiled. If running with '-Oline -j
> > 16 W=3D1 C=3D1', it will print lots of warnings which makes it very har=
d
> > to see the useful information related to the commits I just wrote.
> >
> > I want to build and then print all the warnings which are only related
> > to my patches locally, but I cannot find a good way :(
> >
> > [1]: https://netdev.bots.linux.dev/static/nipa/845020/13631720/build_32=
bit/stderr
> >
> > Thanks,
> > Jason
>

