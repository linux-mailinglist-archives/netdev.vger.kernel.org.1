Return-Path: <netdev+bounces-165384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4719A31CA4
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 04:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B02F188B3FD
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDB31DB933;
	Wed, 12 Feb 2025 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdKzuA8f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1041DB12C
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330455; cv=none; b=QeRv9Qedwcg3+4ASAokpLKeMPUQpNKkiLAl4GvDe+2lel1gI/exUP8lIJLbM1MMr4Z3wk68N/jBluA3jG042286SXfDzEjIDOuc9hcOMH2/c3ZXVBS42O8GlwX7OpwvDBpVwO0HNHbQrHH5j3tesLQlbSB36epfyFw6y8fBqXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330455; c=relaxed/simple;
	bh=cmm8VAOwV1rRmH2hsI79mnvg5/5HzMuKwZY5BiIZ0KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BitgiP28BC4RVpglNS7po1YxAJuUyGnFLKPySHUv8EKb1oyPpguVB42joAAvx9w8otIcmLnTkzX76SGiKC6ZiP9bwBN7Ck39czy1INhwO5qnNI8JPEL15/irTdKSYBoq5S4u5erxeGksqqhA/CCOYrtl6iwgrpf2OOFZ823FMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdKzuA8f; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d0558c61f4so1258725ab.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330452; x=1739935252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQzBx+qaBvNU11IXFwzJaWzvD9Xzsz5ZaSIbsA5MzyA=;
        b=AdKzuA8fNhh+hvxRxKjPE3qPL/VQY3ok5moGNF/gBu6/HSC5kSoxWsd4Qj31lTErar
         kF4Hn3j3CPI7a5Tiviz9thooasb+flGU2aWO8TBJmJ1nsIP0oPlp16AP9/mBTfBBQhOG
         UlJ7TnnVifKUFs4eUTTogT5r5rx2q9OFM22lqbTtCo4irTr3O/Px/n0bFoNZDql+qhN5
         uvsrDxcwWDM8zbRbp1CUIBBL5BKlrP1fI6/Yr5+HxEqNZ/jldIKL7VlkuKf09G42N23A
         OcAOxAFelX6CCydLJjeBz+VPwJHyn4aKq4PKAzxUSpgtmtKNstaZKQO6MZuQh986rJIJ
         c9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330452; x=1739935252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQzBx+qaBvNU11IXFwzJaWzvD9Xzsz5ZaSIbsA5MzyA=;
        b=WxxRRnFx2IQSpnohEM8mWnc2NKd1r9CB7N0DOr8lWXzUpb1M99hGjarDdaJlhnXoYc
         Ubf7cCOeAUiSl+nhIAJuQGkgeFSVtH3Nq+fv2VFnNpwYSIEBI6P8KKMGj9gALzxxTKc4
         rrpOJrxA9uxDA9UZDhHPtJT/q0ROKfnhcQyo5CwCcfi0gzT/DKLWdzXMl46z6zpAtovG
         vVZwnNM35bvRrnU8cwbwyIMpFANTPQTdcTmrcwZ+COTUpGV1g0h+iI4QeU+Jv3/b5U50
         HwVtLg14NSVNbKXKapMkc89RIRJpC09ULWrFHCqWnnXuLKAtfvWcipFNTDI58Cdf/Ezr
         BVug==
X-Forwarded-Encrypted: i=1; AJvYcCUdrgNuqrzosj8/VduO4H4YEgikD45O7TBRNzZ4mwbcxBJs3sBWvyvMNL7uWiNg4dM2K3Tu39g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7/f2zt2CglRA2LFT7/rgkqyghvZngks0MhEZAc/4HSf2A+Nk
	sMvRDoXC709C+iAd1m+LbTZ91p/NSUGrdZ7BubUx+ghRulYeCzdBWEFWVevvm4PcMb20VEetAKi
	KWVKVOkAR9gKNbCGiEO7N2GtJrJ0=
X-Gm-Gg: ASbGncvclgcw8bE58GhQdnmVXKC2CH9827kPiK5lbrhaJpADR+4ucac6k8chpryb2HW
	SPxxQMUnGdRk4xDjA+r5PzEkgMW2PIFAe0EudHIgEbWsvuZBELPnS7bocCbj9D7puuldQPCgM
X-Google-Smtp-Source: AGHT+IG/LyHPfjV8GDGYo+P3WU3SqNP20BPOb09z2HF8JClegVqg/evtfMoN1hFX3pSGaTIHbmEpjxR/mdAznxFty/o=
X-Received: by 2002:a05:6e02:4a8:b0:3d0:59e5:3c7b with SMTP id
 e9e14a558f8ab-3d16f513c90mr45823235ab.8.1739330452632; Tue, 11 Feb 2025
 19:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210130953.26831-1-kerneljasonxing@gmail.com>
 <CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com> <20250211184619.7d69c99d@kernel.org>
In-Reply-To: <20250211184619.7d69c99d@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 12 Feb 2025 11:20:16 +0800
X-Gm-Features: AWEUYZmC-2pPGyu0wJiVjtO2BYb-apDJerOTYPHS1tmiIa3THwmvzEe0_dWprzs
Message-ID: <CAL+tcoA3uqfu2=va_Giub7jxLzDLCnvYhB51Q2UQ2ECcE5R86w@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 11 Feb 2025 18:37:22 -0800 Mina Almasry wrote:
> > Isn't it the condition in page_pool_release_retry() that you want. to
> > modify? That is the one that handles whether the worker keeps spinning
> > no?
>
> +1
>
> A code comment may be useful BTW.

I will add it in the next version. Yes, my intention is to avoid
initializing the delayed work since we don't expect the worker in
page_pool_release_retry() to try over and over again.

>
> > I also wonder also whether if the check in page_pool_release() itself
> > needs to be:
> >
> > if (inflight < 0)
> >   __page_pool_destroy();
> >
> > otherwise the pool will never be destroyed no?
>
> It's probably safer to leak the memory than risk a crash if
> we undercounted and some page will try to return itself later?

It's also what I'm concerned about.

Thanks,
Jason

