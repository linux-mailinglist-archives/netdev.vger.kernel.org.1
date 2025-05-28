Return-Path: <netdev+bounces-194026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC8AC6E83
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 18:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4134E5425
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E0428DF32;
	Wed, 28 May 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTBY3yOx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC228DF28
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451417; cv=none; b=MU5iz/KMgOEARG8E4jcf4E4BQaFJnZV+pRjh9UtoXKNZabC9ddWwZlPM14aSBXfOvBXGxCK2oHGSrfiegpGYkkWtdS8LvnRgmQ+FPKcyZ6rF1bV4mnyIuBUc0HgbtT7tDCYqr0oJRGnsUEZDPLpWcEPIAxcObfu6fM1L/K/JPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451417; c=relaxed/simple;
	bh=eOFTOo5zmCZsJoZUgSE79lX2yL7uavEKR146eGIK2pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkJtCpGe7+yphA0a9fPbvtk7ckOwB0W306D4hgsxUqsQdeAbDSYgihFZFsPyEhvwFl68qufowZPF+sHLHz16kMyetMCYl+GSgwwLdfQ2vx1rqtii817qE4/hJIBR1NpAb20HXDZqC8Us6/BqJ1HPoHvfq9u4w68SpGtbKQrQBBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTBY3yOx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso815e9.1
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748451414; x=1749056214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1kt9Dt95V/eRXDxBRTKBLtP8PVxYRKcv0rN2aIoYv8=;
        b=RTBY3yOxU79kDkextwq9z1CEf3BVuzUk03/qVThneEs+bUumb7Dd205ybNY0uJmLCi
         WGcWilqmknXscGoiIFSRvknxEtSPrgqT41nsdvwNxgzEmImYi/PZGpD1mbDwM/rNMZ8m
         oQudH4rpXDmJ7exriQdKpK7H8N6GzcvlEV9JRjowuz686iDYr7x4q8AT9ZHh0yNY+Qn2
         ZhUjrYPnGzc2FtbpQP6cR5P8suj9yUl50imhERMu0EzKyLsgPEMietD25CuixFO5p3M8
         R62wYJunIpIXGg4o54NsOz2bnwZHgsNZymx7PI5g+rYvOyV0bCglPd9jKGBGPdrt7plN
         sF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748451414; x=1749056214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1kt9Dt95V/eRXDxBRTKBLtP8PVxYRKcv0rN2aIoYv8=;
        b=PubTa59IkbvQyhWuYGHfu4x+pP5THSNzvODFmeEv/gFwLB+cqfa9gTNew6FEJYEPby
         6nekKaqC8BMusy8ozW4Ntk/o9aK4pAXIcTtXN7l4g7dHPlRImQAH5I24JTBV/xSpK/ql
         Yc2cSmGBho7NTLI/WEMFV2V2uuZNqzamms4R4bS2ooJox8+FDXQM2xF9yquZWCP93TAa
         eAhxZU9qhFTT8jiNENl551RSTMV3OjpTLKRtinMVLb3x1Dqt/bwqgM60FWXkMr5AAoxy
         gVsgcLquKMX5udt8j4C1jyHYBESp2rrhozGzsuK+qktsr85sP2SmaurQn7wGeMeea3lM
         ilXw==
X-Forwarded-Encrypted: i=1; AJvYcCWazpYULjJZ8OxdE4v15Msd2B7pRthujLR3Y+Kyl7czkfx8lNjs9jZIgG6xyX85/QA9Q3BO53g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfwyanVfDuwhfU74xBg0DKbl95l4tMoENPbbgQ9KU/N4LCmkW
	OmKa3Un1baWO0n8Hdh66nk4Jgq4dyd+XdKTqWhvNLZ23ORdqlBDLhYYDMoACKQA0br0S+CqePwo
	YIJ9NNtndZr0I/CTYI5KvNWaLl1OUjrmU3LYkJobY
X-Gm-Gg: ASbGnctnDg3OBXExSp5Nby4RWc9l8jnrFVEuJBhSYWK4DzIY6pyJOBP3zgI2m5nitIC
	F2fjaXz8yCCQIO1xTGDURk0jd0C+/+V3VsuMYQPOr6yLqhotpiu9FeARJBLV5NdAe0Hzeg3G5nd
	Ra8V5JUmhBu8bbM/OdGZ8Ag8eALrcAgUOg4RXO1txHWatZ16ex2XtboQQZpNKVPyU2j7K+dKG0P
	faU
X-Google-Smtp-Source: AGHT+IGqNNyAdIrmeJn9gWkLURDbutnwBexLXJ91leR3aXf5DBQNLXD2WLOnBrgCYtd3axsOqlIAmmjmmOoxJ/BlCME=
X-Received: by 2002:a05:600c:1ca1:b0:43b:b106:bb1c with SMTP id
 5b1f17b1804b1-44fd30df1abmr1997695e9.0.1748451413458; Wed, 28 May 2025
 09:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522235737.1925605-1-hramamurthy@google.com>
 <20250522235737.1925605-6-hramamurthy@google.com> <20250527191240.455b6752@kernel.org>
In-Reply-To: <20250527191240.455b6752@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Wed, 28 May 2025 09:56:41 -0700
X-Gm-Features: AX0GCFvnWbkPHZjYonuLle_IHf7Sq8_rnYuP3Felz5Cme3QxGDkryyuJFAL6r70
Message-ID: <CAG-FcCMK73jqjQMhktk8_pVmSPmN6R0BgGLVTLOujspWBe6ENg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/8] gve: Add support to query the nic clock
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jeroendb@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, pkaligineedi@google.com, 
	yyd@google.com, joshwash@google.com, shailend@google.com, linux@treblig.org, 
	thostet@google.com, jfraker@google.com, richardcochran@gmail.com, 
	jdamato@fastly.com, vadim.fedorenko@linux.dev, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 22 May 2025 23:57:34 +0000 Harshitha Ramamurthy wrote:
> > +     err =3D gve_ptp_init(priv);
> > +     if (err)
> > +             return err;
> > +
> > +     priv->nic_ts_report =3D
> > +             dma_alloc_coherent(&priv->pdev->dev,
> > +                                sizeof(struct gve_nic_ts_report),
> > +                                &priv->nic_ts_report_bus,
> > +                                GFP_KERNEL);
> > +     if (!priv->nic_ts_report) {
> > +             dev_err(&priv->pdev->dev, "%s dma alloc error\n", __func_=
_);
>
> missing a call to gve_ptp_release() on this error path?
>

Thank you for pointing this out. Will fix it in the v4 series.

> > +             return -ENOMEM;
> > +     }
> --
> pw-bot: cr

