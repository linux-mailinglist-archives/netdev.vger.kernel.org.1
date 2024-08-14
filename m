Return-Path: <netdev+bounces-118311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 980C095138C
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA271F238E2
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 04:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12054D8B8;
	Wed, 14 Aug 2024 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWVspdyU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1611722309
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723610633; cv=none; b=L1cSw0tRLmaHN0dDcYX0qktT5qSedXxJ5KtcnKWCqwyowvTWt5iAEb4Vs+ndNTC/a+qTQ8GQ3D+QQPoJDr+2RtvyXlGBIPZNgcurvP8dtQ0wFB4GOmUgGJO/xHXakXiFRfzuEbzAzxTrInvz0JIN01DCpCqcvcmY0+xRIe036hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723610633; c=relaxed/simple;
	bh=wH8EP7X4EvbIVVJt6WX02eT72un8jl8+0EWsViuNY/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmwUOVqvaFwpvocsoJ3DwLx/68Bu/SI1PSEbCda9TXsR1cy8uUqaOdAMbuCiwaKG+nhHDtVCKJmIxBXVo4R96BiV3dehBTyaHu4Sm+/x2ILbvJEpge/MOsFJ6n95EPpefzdRlsTFPMEJoyLGsS92Y9Dj22xeOVLcAY5/PN4VCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWVspdyU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso668823766b.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 21:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723610630; x=1724215430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH8EP7X4EvbIVVJt6WX02eT72un8jl8+0EWsViuNY/A=;
        b=oWVspdyUJ7JPU41fFXylLxXITAe0bfxRYMjx/0X8C2m9Fd3t/Q2QhzufcP5ITe9SIo
         59pSOx8h10xx7RrlI9FNbHFLdEomB/Cpo9iLrCGeo3XuHi78bZYTT/lENoFBFEJw/GRx
         P7ipQ0rOxeG5uESLihgjb5fOMWDPkMPrJwTIBOZujSBBCFVcQ/FP5rcwiF/tvsI5+YOF
         Xzn6WwRw6h7NEUKygPoYkBVEFnOwFJ1Mzkk+awi8i27ZRVk5pQZtXGOixglnG8kGH68M
         Z3QWmXW2qYeAeXHuiNeCWkc5XP8kBb5gEmqGis91rJnD6XgkrC3Kd+e8tyDdv2zbcDSE
         7wSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723610630; x=1724215430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH8EP7X4EvbIVVJt6WX02eT72un8jl8+0EWsViuNY/A=;
        b=PoBdZE3ShNulIldLzqmYyAUiMxd+wJRvQjDj2k2Qq8fXb16rRiwwAEd/koIoiMDDKt
         g0jrlP2RstyDMoMyoSNzcuD/V+Zqj9qOkkucEvQLrEGBS1WNEsB66I1eoPdQOMDWDIq8
         kbaRLJ6JI3rMYBxlm3rUlhiR1Fcggdx643RTiHeufCWosEZPcDrLEKzf3vmHXHA4gWs1
         r41uK+bdkIs5zj7L1Rq4sbTi/m5TdOketyibZdh4RlsO+nuViP8zO6gK8T/zRVykjVWR
         KXguwX8lDGl2gxhGAI3g9EB+vI0H0E+N+QLQKYud9RlzeyGaJtY3WUJrxUWkYWIe6x+N
         o46A==
X-Forwarded-Encrypted: i=1; AJvYcCX5KEs0qXVZeLYnJ1mmTjzdECgW4qdHdOGGIQCRuv2Hm8i2E+HXUFuSZADf4JXWWuWbnNLJ+2o2jGDhfmtxfSghRO4fe3aK
X-Gm-Message-State: AOJu0YxWKOfLrp03f2nD3JeMVRxqo/88SMXFNJo5ETy7vCVK/WWR8GoE
	53/l9c9OP91NTHBTi3ZhHoqjQhwrV26hEa1qMSBk66i8YAX3kUQlQomYder9eBfqdubcpabKJRm
	Wr8XeOFUJ7gQ3PdzHDy9pNQx+VZDMkBWKG5GU
X-Google-Smtp-Source: AGHT+IFU4tVAwgDjxJOtN+y4G2xoazQ7Er3tFwPB4mIZjlbslZrAeIshzbMfLNYKsBMnJ0fPXimycTH/nugZadAqIPo=
X-Received: by 2002:a17:906:d257:b0:a7d:2a62:40e9 with SMTP id
 a640c23a62f3a-a8367015aebmr82799066b.50.1723610630000; Tue, 13 Aug 2024
 21:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me> <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
 <CAL+tcoAHBSDLTNobA1MJ2itLja1xnWwmejDioPBQJh83oma55Q@mail.gmail.com>
 <CAL+tcoDnFCWpFvkjs=7r2C2L_1Fb_8X2J9S0pDNV1KfJKsFo+Q@mail.gmail.com> <CANn89iLNnXEnaAY8xMQR6zeJPTd6ZxnJWo3vHE4d7oe9uXRMUg@mail.gmail.com>
In-Reply-To: <CANn89iLNnXEnaAY8xMQR6zeJPTd6ZxnJWo3vHE4d7oe9uXRMUg@mail.gmail.com>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Wed, 14 Aug 2024 13:43:32 +0900
Message-ID: <CAKD1Yr2rqFdtCNmvacEvd_DR3nGVo8+7+sbGPU=g6Gr45T9TQQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Xueming Feng <kuro@kuroa.me>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:23=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
> > Each time we call inet_csk_destroy_sock(), we must make sure we've
> > already set the state to TCP_CLOSE. Based on this, I think we can use
> > this as an indicator to avoid calling twice to destroy the socket.
>
> I do not think this will work.
>
> With this patch, a listener socket will not get an error notification.
>
> Ideally we need tests for this seldom used feature.

FWIW there is a fair amount of test coverage here:

https://cs.android.com/android/platform/superproject/main/+/main:kernel/tes=
ts/net/test/sock_diag_test.py

though unfortunately they don't pass on unmodified kernels (I didn't
look into why - maybe Maciej knows). I ran the tests on the "v2-ish
patch" and they all passed except for a test that expects that
SOCK_DESTROY on a FIN_WAIT1 socket does nothing. That seems OK because
it's the thing your patch is trying to fix.

Just to confirm - it's OK to send a RST on a connection that's already
in FIN_WAIT1 state? Is that allowed by the RFC?

