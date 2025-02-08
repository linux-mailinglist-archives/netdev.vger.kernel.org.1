Return-Path: <netdev+bounces-164381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FB9A2D9DD
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 00:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E676D188854E
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 23:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E11243397;
	Sat,  8 Feb 2025 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDbOGcb4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D724338C
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739058426; cv=none; b=tYVq+5mSSjx0MLESX8wD3IyrN5Zr6fSUxJpEIvYVsGK418xFtNlj5Zujy+gVdwPOMKfIzU9z7AqxvAkr4+oL8GCIimfYolPRJQazFXDHj1byY56AaSLuZ4wQJJgQbEBpMim0i66OyFDRmw2HDpt4uPAXQI15bunqhNRbcZmZIhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739058426; c=relaxed/simple;
	bh=334opNX6pBAaMQNpVWwCpyPXEjFoP+ZrcpwHENmxV3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggauh/UnJdBVR/VG+WMcy8DKomqMQrqNOPlQxx7NMKR8GR4drpLNSOQtr4ZxSeqU/fWNSb/VwN5CTaKYJMFQow6ISo9i+ipteBXdNg5r5g3TcJ2EG+F2wS28fFrW7K1dl7NGf67YpB3g0U869L02RMbCPIhoC0UzKukQIIVuq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDbOGcb4; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4679b5c66d0so196931cf.1
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 15:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739058424; x=1739663224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=334opNX6pBAaMQNpVWwCpyPXEjFoP+ZrcpwHENmxV3E=;
        b=pDbOGcb4M1GrZBXy0FiaoM+G609d0T3cUoDBUgzZHjFBnwilsOHDHjD2Vmm6JKDutL
         HU0kGzSLTx2hXcpGSZQHe2QR8RRWT9kJC3oa2oYfBOhNwl4d9zM9Amd7gkr1436L/s3D
         5pWcdxTPmuWdl4+OfkfITEtMZfxjqdoalYV7cl1WkmosNX5ThPmhGDj9qGoDrfYjLJnS
         Qxi+Ip1dwnYN8UIAMfhF8jDgPM0cqvMgLPplrL+k9isLvSKVIbmuLFlIuQ/JhVN9YypT
         gxEukdRWALB3zekBSepRWFPMlLG0pqqpg0JsGYg/ML1xFQ7hnGIoLU9kTR/Cv31xEd4g
         eQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739058424; x=1739663224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=334opNX6pBAaMQNpVWwCpyPXEjFoP+ZrcpwHENmxV3E=;
        b=FHQM8JYfrU19gwKFl53+5jjFGLBxRNTQR+GOJ+skzMJlFpGf//9craibdm0+376DIs
         hifYUI0hS95+74WA4zUG3SUi2YwLof0RNy5rqzwoHaG0Dx4HxlhvSL9AP0AJEuWIJuxo
         +QUQmqzlwILPCEX/VhuAWWkJRFsos4weZXQR4wHFia451JxKAVdcuzdhp9F6TlLUveDh
         qhR4IrO2DFgsNRizgXNLJYa4PEsaBEE7LPtnh7VeZCbwdhw353JAl9dN4Co/Oqlpe8p4
         L47JoXB2geWTWVrinjGGinSg455CFrNEQ7I1htdp9LdsUlgGojrawkYtDKGd1KGJ3hVh
         IJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl8EVi3zJtBCA/8OuwesAVuLg/JC71lnbfd1jIs5pIVHkdUsqKoODPd6sDM2UthZBxiCUG/uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3NXtbLoqsFtGKOr+O/Zx1RrEmf8v0fMb6IQ3gBtpCrHn6hB/
	ayzsVgCpMM49RfTrMhR5jkYERnRxU0GHLpCZgyzHir9DkHirePqRGvfb8dB37KYvy2weZB32tAj
	nuV2Hay39b/2C5vFXZzeXv6WBYL2YSKiYHJPk
X-Gm-Gg: ASbGncsCXltkAOs9cRFVMxXXjfXITAstLsVnjFe0+1xMMJn9wYhGBL8w3fmhDprk5fx
	mYWkumZDzo6v0yl0cNLxbuRD+uh7el+W/hRoHkvpYPFkZoUcEO11EqdJiSed5rHlwUYoPyoo=
X-Google-Smtp-Source: AGHT+IFqJgVcBPsGLsAoTKblFEPyMAW/j0oyUQQkeOwUccHXec0v+slfw0DCVaR7uhrYxQA+7xKj1pbJynTsnlsVZL4=
X-Received: by 2002:a05:622a:4117:b0:466:8887:6751 with SMTP id
 d75a77b69052e-47177eed5f0mr2742341cf.23.1739058424216; Sat, 08 Feb 2025
 15:47:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-3-edumazet@google.com>
 <CAL+tcoBo3Sa76KDwJ1tjB+kPmmC0HyfLKXLCH7FmvTwxO34U9w@mail.gmail.com>
In-Reply-To: <CAL+tcoBo3Sa76KDwJ1tjB+kPmmC0HyfLKXLCH7FmvTwxO34U9w@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 8 Feb 2025 17:46:48 -0600
X-Gm-Features: AWEUYZnREFAXH9h_K4abU0CSblZL_-PeV37AzORVK-cd4F0u5rFotcgGItdRv98
Message-ID: <CADVnQy=XOdoS8b=h6i3V39BJ=fC_-hBS2L91FsExFqwJi-oErA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] tcp: add a @pace_delay parameter to tcp_reset_xmit_timer()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:31=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Feb 7, 2025 at 11:30=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > We want to factorize calls to inet_csk_reset_xmit_timer(),
> > to ease TCP_RTO_MAX change.
> >
> > Current users want to add tcp_pacing_delay(sk)
> > to the timeout.
> >
> > Remaining calls to inet_csk_reset_xmit_timer()
> > do not add the pacing delay. Following patch
> > will convert them, passing false for @pace_delay.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

