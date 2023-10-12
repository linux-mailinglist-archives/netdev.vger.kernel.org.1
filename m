Return-Path: <netdev+bounces-40401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758747C73A0
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B61028294A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50C31A6E;
	Thu, 12 Oct 2023 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+Dim5RP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4F200AE
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 17:03:47 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB98D9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 10:03:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c1c66876aso196731066b.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697130224; x=1697735024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bpj60L1giOhZDrev97o25zjJHzefVjPnm5rNDXRL1v4=;
        b=w+Dim5RPaej0Tkizr6QijIiVS19PbHFaqUExEpuN1hh/F/B20uAoVnCcr0K0oZ7m/2
         ABLeQ6TMp+6a2cmG7YOaUIveKHyMpPBM5oxCl//v1cEGd88l68pssauqNzIRLSe4g6LY
         fuW7AGtz/JFF2c/V5hZua+Y5voLL+AKqjsfuLrIdcmQbkAS2IbMyUHs40Ffr1Jr2JzfI
         ybe9SLssOXj01zJNsMlcsOkRtKFcOyoaPOC8uvQWG+SOeix+kdJdIR9ZXcwd1fB8SuaF
         09QPFEBIdDC5zYXdUPGb6gD7GhS/Hhm+tKInl0uRgV9emxbbQ/fkngnyeqzYNnDp5pmO
         5yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697130224; x=1697735024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bpj60L1giOhZDrev97o25zjJHzefVjPnm5rNDXRL1v4=;
        b=EzdZTOiLjoW8kK69LSzgjuRR2kpJksfJodzkjg/OR11WHwGlVYf0VyFO+8vVehDciT
         QqTaS+Tcyuk+EY1RS6qUJz0QpLSZQ1tz820HMVtU+FDZ4loPB2szi1l8sFO6Z7F7MHDO
         p7gPQK71HBBgdugtCJvixaqshm1v2RBWOw6yC/uPwEVPPmeDBs0rLnKEKNCGUUtc6T/h
         aeH7adf2Mvdye7paLZcqPUsZoDDX1Swd1QtEF+UdG5zHYD1nHHvFjgeUi5hb4kZhj5Uc
         KMovj8P85wB9rKXPcfMTABW3hdLYVjql5bBHZ0RA6Qy1CqsEmVOrwhahXtAy0FfeMlbN
         PA7Q==
X-Gm-Message-State: AOJu0YwT4oxgICNaXXvUOcjExjH1jNt9ikCnlj6GRVr6LBEiKuzq2O0H
	mKoYN9LYv93Roq0ZcHHrDKePC3tPWdvQxby/oA1nvA==
X-Google-Smtp-Source: AGHT+IHnItZqj3WoRz3s0Uyjg3a1IGBWvjSwLhRqCZLGtotHoQvNSkjH2MugZe17HhUqAfVikbHBbvc6y+hxZvjZCKk=
X-Received: by 2002:a17:906:845c:b0:9b8:f17a:fbc3 with SMTP id
 e28-20020a170906845c00b009b8f17afbc3mr19609420ejy.64.1697130223912; Thu, 12
 Oct 2023 10:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012043501.9610-1-m.muzzammilashraf@gmail.com>
In-Reply-To: <20231012043501.9610-1-m.muzzammilashraf@gmail.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 12 Oct 2023 19:03:07 +0200
Message-ID: <CAMZdPi_RY7H8owUB=6-G3fnhXBVrKHjv6O5iLmLwu8bZUbJa3A@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: net: wwan: wwan_core.c: resolved spelling mistake
To: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc: horms@kernel.org, ryazanov.s.a@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Muhammad,

On Thu, 12 Oct 2023 at 06:35, Muhammad Muzammil
<m.muzzammilashraf@gmail.com> wrote:
>
> resolved typing mistake from devce to device
>
> changes since v1:

Change log should not be part of the commit message, simply drop the above line.

>         - resolved another typing mistake from concurent to
>           concurrent
>
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> ---

You can put your change log here, e.g:
   v1: Fix 'concurrent' typo...

>  drivers/net/wwan/wwan_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 87df60916960..72e01e550a16 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -302,7 +302,7 @@ static void wwan_remove_dev(struct wwan_device *wwandev)
>
>  static const struct {
>         const char * const name;        /* Port type name */
> -       const char * const devsuf;      /* Port devce name suffix */
> +       const char * const devsuf;      /* Port device name suffix */
>  } wwan_port_types[WWAN_PORT_MAX + 1] = {
>         [WWAN_PORT_AT] = {
>                 .name = "AT",
> @@ -1184,7 +1184,7 @@ void wwan_unregister_ops(struct device *parent)
>          */
>         put_device(&wwandev->dev);
>
> -       rtnl_lock();    /* Prevent concurent netdev(s) creation/destroying */
> +       rtnl_lock();    /* Prevent concurrent netdev(s) creation/destroying */
>
>         /* Remove all child netdev(s), using batch removing */
>         device_for_each_child(&wwandev->dev, &kill_list,
> --
> 2.27.0
>

