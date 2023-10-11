Return-Path: <netdev+bounces-40146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8037C5F29
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05114282482
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 21:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFCB21110;
	Wed, 11 Oct 2023 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J6+RQtGu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17D1BDF8
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 21:34:04 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0359AF
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:34:02 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6c63588b554so216852a34.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697060042; x=1697664842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQIwabRI/uNovp4wm52uUbIH+HnR4FRH6bY2+vy0apE=;
        b=J6+RQtGumTMkfg8tgi7jcQS+eWbAO24O99KVnh9jaKR99+ZJZY6JAio7wsqBvUe15e
         1NjEniI4g/pQjCqBFo9Ge5bmiAISbilAmNwVssdZGvGbsGbk3hQLCTnstwRhkaiwuMIm
         XgxrDvYSvt7senZaIjSD9IqGyPhBYgOkLCWuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060042; x=1697664842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQIwabRI/uNovp4wm52uUbIH+HnR4FRH6bY2+vy0apE=;
        b=PvOxjz5nI3IVNgp0JlBIT1hRV14rA8USyMZRg4LCRQ1bFuHprZvW/ruRCK6dM0FnCt
         wcJBI5OOZUJPgPgE66uOB3i0KeYbdjudzlBjEKdw3fZYE1DQztxc4siUDiMQN+Rulhz0
         0i/A9T1ZQgXc1P3M2mPy4+QqRU8nuJKaEw8hlz6LH7V7wZBCrMIxs3VVaidYih4rQV1B
         AOrXgz9dZFZLvEC9q/Ek90LeDeWP6xM19NFgyEZ6jHNYZ8lUgX9m2jNv5J5SW+8/de1r
         tvUWIJHJpD4Zu4c2MuNp/fOY478ktrosQLKGBrT3XZciQzkYfjzlwnzmYOCSzJ+GJC5D
         gSsg==
X-Gm-Message-State: AOJu0YzfqG//iEYxtR/up+2SWbicYHHdAwQkC5Qfnv67N2kmtN2PCaWz
	Dom0WADZJvPeMPv5BcNSjHQRiw==
X-Google-Smtp-Source: AGHT+IEY6hpryGK3ZRZpCZ/wGDkglUCLj6tPg6/csEmrRfqziDqNEb+8M1nyBYqN2l4rpesyafwOOA==
X-Received: by 2002:a05:6870:7ec2:b0:1e9:7037:6445 with SMTP id wz2-20020a0568707ec200b001e970376445mr5055718oab.20.1697060042036;
        Wed, 11 Oct 2023 14:34:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r27-20020a638f5b000000b0056b27af8715sm320743pgn.43.2023.10.11.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:34:01 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:34:00 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: simplify mlx5_set_driver_version string
 assignments
Message-ID: <202310111433.9BCCADED@keescook>
References: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx5-core-main-c-v1-1-90fa39998bb2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx5-core-main-c-v1-1-90fa39998bb2@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 09:29:57PM +0000, Justin Stitt wrote:
> In total, just assigning this version string takes:
> (1) strncpy()'s
> (5) strlen()'s
> (3) strncat()'s
> (1) snprintf()'s
> (4) max_t()'s
> 
> Moreover, `strncpy` is deprecated [1] and `strncat` really shouldn't be
> used either [2]. With this in mind, let's simply use a single
> `snprintf`.

Yes, please! readability++

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://elixir.bootlin.com/linux/v6.6-rc5/source/include/linux/fortify-string.h#L448 [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

