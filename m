Return-Path: <netdev+bounces-123785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AEA966803
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B195282DB5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F721BA279;
	Fri, 30 Aug 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2aSvnhr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0FC1B78E8;
	Fri, 30 Aug 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039142; cv=none; b=JGl422W6YCeD/E9NEYkznMszWfh3rThlU9yj5mLF3Z0IjYc1lsSKPNX9vDZ3XyvAmAYLlbbsNCT3MUnh7RqJgsGqBOlsSlY0tzpWaaMyQS9gvPbncmba1Zhy/bF5tdJfzPNtI2IzGcUQPNYacagCPTNQPJ3eh/asC+pIGhtqT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039142; c=relaxed/simple;
	bh=NDJl+lPXxNV2dYrtvaZCUmmE6IZCNIPk89n8/aJ4StU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy0ADrZGGWhvUQZ5vJAYEmnX8ODcsW0bcW9L2Go2+hoL8tZqaM/bWEVClukaqjazzlnKV4ZdI10nXV3uWsyBoq1DjWQTTOkImijSjsWhsBUrFG89mjvinFb4x8igVQhu70WUClg+cUCT3nQA4EJDDgK43XW9PsiP9kOKdHRw1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2aSvnhr; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6d49cec2a5dso5273047b3.3;
        Fri, 30 Aug 2024 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725039139; x=1725643939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDJl+lPXxNV2dYrtvaZCUmmE6IZCNIPk89n8/aJ4StU=;
        b=f2aSvnhrh4tlT88E9niulfyoZUnWb+8BsBdR4PTE179yMZ6UMSoahJkhKfPY2Sd2Z0
         Z4xBGvItBdepB1lLeuzHnsr43kC9GEY85fCiT4XFaj60BWhiWa1c740KVf6SvFUaGa/6
         GtH0Erp4fRAsZBJ+faSqMe4MsPjf6jXQkmgBodfV8CcxyhLkIQvMIR1ZvWNRefQu8lXL
         RzLcTXA/WFxXWMAXiUbXy82wAFreFzLwnvbRbyMEQc6efW8z6HtdrQEQJsFDw+i++TxY
         AzqvMWH7mWzqD5AsC3YNp7cPurRUiOTeF9PfJO5LhgIFbfzgXXnqScvb98yRrefCbeW2
         nMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039139; x=1725643939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDJl+lPXxNV2dYrtvaZCUmmE6IZCNIPk89n8/aJ4StU=;
        b=dQ08zIk9HC5pM20m/xaEOG5G77TEZFx/sWr5zwgTGVBOQn7Htz8MXjskn2lPT0OpHa
         hrwyJcGTyXgiYr4B3Ws9uZprqjixmoRC6uc2Ce/BsCpr6XaIuuJQz6Oud52yDtMMIg+U
         e07/7RnulY/nabEtdMVzPibsd9ELHwl0PG8cy9J7BhFaV8nqNa/a2f21XUFS2bkD1hlm
         nES4JJr3u0BHwvdpiitG/rUfrSRjpBz9xPtHTOySdu/N4101f8Uzjiv/2a53dLlOjG82
         lh7mCCw/zgG8NQoH69lOQEcd9KrsPskNzceA8ixMoe3mB7sq+TLw1YEMTQCwetT2ejCs
         guoA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Tbyq9yH8WW2MeoYjfCnfslVIXD1GAaa6VwuBBf+WuOv/EoxnVAgwYwS/qUwz4FeUxV04M03HAkNrWIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+jr4BJnLxFRzuLzZht2V/NZ3EaERJFSJOeNB5tkXkQKCBU7c
	zwcHw9vbUhFlFUnZKNp8LqFRvgQBV+sLgfmlFZZLdbDuVmZ8XKoBY644zmvrhI+ExOlprPRZ/ZJ
	4Fv8p5M30nDG9yTjo91k7VDt0vZYYDzYK
X-Google-Smtp-Source: AGHT+IGLGnGCiEiLQv9NgUpvndIRDrrchHCg22LQ2xP8WwDtHhBAgcgZLnE8PyZeeZTzY6zthBeWENdhRou6O67dHXg=
X-Received: by 2002:a05:690c:67c1:b0:64a:d5fd:f19f with SMTP id
 00721157ae682-6d40f81e20emr30944467b3.18.1725039139424; Fri, 30 Aug 2024
 10:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829214838.2235031-1-rosenp@gmail.com> <20240829214838.2235031-2-rosenp@gmail.com>
 <20240830154942.GT1368797@kernel.org>
In-Reply-To: <20240830154942.GT1368797@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 30 Aug 2024 10:32:08 -0700
Message-ID: <CAKxU2N_ao94KNa+wZFmx+ZMRjTc5UXD0PgqXF=pb27w93xh9Gw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/6] net: ag71xx: add COMPILE_TEST to test compilation
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 8:49=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Aug 29, 2024 at 02:48:20PM -0700, Rosen Penev wrote:
> > While this driver is meant for MIPS only, it can be compiled on x86 jus=
t
> > fine. Remove pointless parentheses while at it.
> >
> > Enables CI building of this driver.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> Thanks, this seems to work well.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> As a follow-up, could you consider adding a MODULE_DESCRIPTION()
> to this module. It now gets flagged on x86_64 allmodconfig W=3D1 builds.
v2 patchset?
>
> ...

