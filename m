Return-Path: <netdev+bounces-196749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8E7AD63F2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 01:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D8917FABF
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FED62C17A1;
	Wed, 11 Jun 2025 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnxQdsx5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16E91EDA02
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749685281; cv=none; b=ZJXdZMoHtfNQ2sdYzJE7txe3MjWOtwB0C8fgmaD7qAFqlZqbON+ZDslQ2BJ8ffl9IS2eeJOYRNN6GoFsHoMWHtNHrIRwvr1ACQt/dSg+yKL7w9mZn3C14ajHgXITEXAhi7eIP8ldoD7blEzWYGVzFBF/1FGYx8YNv7fR0PD954I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749685281; c=relaxed/simple;
	bh=kTjXdiUU0uz8DY8+/rLWqtPAVHSUlHMG7bi7fWmNw8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rjm1c/G+dZh9ZPcQkF0mDltO1cHsbhQ2OI/h863Zfh64qboNn9YRQ5CQXQJaIEjcBT461zrqfFijyo/5RIX+OMrWmehsfYiLdOJMlpp+XrsjRTTJTUthxJ0RNU+ZsLywHsfpdRPSgH5Y8zi06JRVI1iNKzJ1ExzbK1FZwJtQoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnxQdsx5; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47e9fea29easo84251cf.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 16:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749685276; x=1750290076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnwvu7/fKFkzEdGXspXaHEY/ygF+zDGWlZtFYDo91z0=;
        b=TnxQdsx55rPDt/6EUBIWPDp736iF5pbpcQRZp6OUeDGl7AvIhMBpRQf3HFqTXLLk8M
         oAYY00pgtteYY2SqRB/q9PDAg4FtpoaU0o2y4eCYqBFUi1/sxWlh2QSj+tZ/MsCDscof
         9VSycEgXfpWsGVb6D6krfRcKXXe91p1h2LOuFVCIf/YwDUU5M+DBUdPYYkJhQLJaPbiJ
         64/BtaXtAZz1aeJwgFwecOc6DcRGwftZDZYugjM32IXWivDmx+zXzN9J8FqGWU/LpBuK
         OKc71tH7q2igPG/VlmCADdC9TMn8kjaLtmhE117JCJHIT92/+lLk8JvkzPG9srtP3PxW
         63Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749685276; x=1750290076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnwvu7/fKFkzEdGXspXaHEY/ygF+zDGWlZtFYDo91z0=;
        b=oNU+0gP7jKG44QcQitDiaVlbOwMCISS12lmZLPjc7FDNZKLIB0fiDL/Rr0q0gfF/uI
         vLultF3XZ66NPZZVnq5eQ+3cnCWD2JNgwBBC6FNK2bRzrF4sg+HgFz4cAmkrAvvZoxeJ
         3bv71H+jiP1h/yqPoWVP2qtXbwrlBkqWQHq7G50+QdQ7jg82dV8nJ+4069L7mqJErC7r
         XevHsJZlKTdreaD7FnGpzo2EUxxk3eJsYlDAAbXnvcbH4uNJxQZb8mvCRY/EjAfuXzrb
         SbtEK7DOWfZgVDYr7cgQJDLGrc3xyqi79R+tixLaICanRYsuMsZrJTLa5N8WLB4dmGaU
         6Clw==
X-Forwarded-Encrypted: i=1; AJvYcCXx14ktf9hXT3RDiOQyOc4q4cTbOUkTMNvuVulu8b7beqqCqztuExtRQMFi5iy61W/4tLhqmig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiBXbBm4M1wj+KICxGKI1xQhitIb/hxUlCEErXwyeSkrRFgu9i
	YGT+OkBtmv3YWTKsyr7KNnXUzs1/JZqkZUin+2PWUEC3Xv85VYhOVRmHoT2KhH/w9kmaU4JDoQD
	9dne9iCsTixuDfyR58oYi31Up+Pt5B6XNRYjH0r/S
X-Gm-Gg: ASbGncuoGf7gXFSQdr3zTt8mVh8qytJ+FMKprojFOWjhfyfyoCH+xpZ3nZ/b9OCoGpR
	Ny6axAHV7q6rJNOU2O07rBexOa++UWqyo/tOU8AFyeS0j+6JQrsyf/FXY23pKNz1eAST0cbPefj
	LeZ4besqVCwTjbxbpYTZlZ7ufRLjnZqWlhGY0WE0M2+YDhrYw+5A2F1mJipVUlMTZq2PDeCe+Zo
	1w4nwG7Z+rH
X-Google-Smtp-Source: AGHT+IE8VXJ0lACkCQtSqAJ6+lw38b1R52arM/JkN26dV1XojC/+5OQduLUE8A/SijvJokeBDWTCK+sl90zsPAKPX9Q=
X-Received: by 2002:a05:622a:1345:b0:494:b06f:7495 with SMTP id
 d75a77b69052e-4a7242e8646mr1211031cf.24.1749685275160; Wed, 11 Jun 2025
 16:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609184029.2634345-1-hramamurthy@google.com>
 <20250609184029.2634345-6-hramamurthy@google.com> <20250610182545.0b69a06d@kernel.org>
In-Reply-To: <20250610182545.0b69a06d@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Wed, 11 Jun 2025 16:41:04 -0700
X-Gm-Features: AX0GCFudQlLirSQu_pfgV-l62e-RT51p_3WK5BG7S3Kaz7L2GVzeN9WeWjFqHhE
Message-ID: <CAG-FcCPwJVw_8MyMyUkjwwTcotQyWa6_g1U6_WGf1YQ4_0n9Ww@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/8] gve: Add support to query the nic clock
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

On Tue, Jun 10, 2025 at 6:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  9 Jun 2025 18:40:26 +0000 Harshitha Ramamurthy wrote:
> > +     priv->nic_ts_report =3D
> > +             dma_alloc_coherent(&priv->pdev->dev,
> > +                                sizeof(struct gve_nic_ts_report),
> > +                                &priv->nic_ts_report_bus,
> > +                                GFP_KERNEL);
> > +     if (!priv->nic_ts_report) {
> > +             dev_err(&priv->pdev->dev, "%s dma alloc error\n", __func_=
_);
> > +             err =3D -ENOMEM;
> > +             goto release_ptp;
> > +     }
> > +
> > +     ptp_schedule_worker(priv->ptp->clock, 0);
>
> Given the "very dynamic nature" of the clock I think you need to do the
> first refresh synchronously. Otherwise the config path may exit, and
> the first packet arrive before the worker had a chance to run and latch
> the initial timestamp?

Thanks for pointing it out. Will add gve_clock_nic_ts_read before the
ptp_schedule_worker to do the first refresh on V5.
> --
> pw-bot: cr

