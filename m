Return-Path: <netdev+bounces-44214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6767D71AE
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CAB4B21077
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DBC2E64B;
	Wed, 25 Oct 2023 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHbDK/H/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57A2869A
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:28:11 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802EB184
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 09:28:10 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b2e330033fso3646624b6e.3
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698251290; x=1698856090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IZJF2CVsi/63FinLxTsqyhHETh4y3KTxD8GwibBgu4=;
        b=SHbDK/H/ifIstKhSD2rPToQn2x1GGirz6o4vutre+IvzR9cg/1PAsIMUVev0XAXxYP
         UVD9tNcWLL1ZJ7Dzrt2yPe64XxJog8PG5QfWGEttWgrTJTbLlvYJzLv1058iuEYGAwqh
         6wxMmgg9GDTfpDczDLRYpHhzxGhfalQaKQ4AgzU9STnIKvouuOAYeIujN5pCCSzjfjLp
         l5uma//5oMabbiKEDn8hygA6CvqBBiQ5gdSFYA3CRvAsc8ATDk4GBmqoX4H61GpesKE/
         zeNjqIlWh9MImiqZAR0F8AZb+0xcsQl58CtY/LnXaAVpXomgBKObgPuINF0mlBf8tc0q
         Bfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698251290; x=1698856090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IZJF2CVsi/63FinLxTsqyhHETh4y3KTxD8GwibBgu4=;
        b=bh+r8M4q93zo/4Ho9Smp7aUVC3GcTnpHO7ZCW/x1mbkqB6wrQrKotkSlaQUY89H7eD
         cqioX4gNrJfoln1zc8oPowtV+2wc3Ce713eaXrXz6EkLOaoGV7AR9Lf2Y22NsdxbycWf
         aiyax2iUJW8XOm7ly4Q8dYt5pnYxbMEQXFf/7pP7iKFuijtYOoRFx/DJuy0aDk8nOg+4
         fY8jdidq9stQ4TmFNxvt9iahdGlHcNCA5jnQ2bV0chxS/6oR/uZ40FibNxpQNp9Vtuzh
         vtTfnRIjm2gJ0wqxE/2mMl52QQ85wL9bpuljbbzdVuH0fymn00zpKbQEorY0mmq68fbN
         Rbug==
X-Gm-Message-State: AOJu0Yx6L67cmePGL4mJc9zFDMBK/NHRIoY8uTyouPze3mAgEinXNvZ0
	JJE/E8M+oBmCJh3aoMmOaPMa+JMZBYiojjWJvyY=
X-Google-Smtp-Source: AGHT+IHn+AX++JboUNSM4fqH/4J0s3fXt7Yx6YwxDGdOExlE6/GtmUwuHnduJDelPAMrVL3fe1/Kn2xrAQhoBgo0L2w=
X-Received: by 2002:a05:6871:419c:b0:1ea:aa9:9b00 with SMTP id
 lc28-20020a056871419c00b001ea0aa99b00mr20993726oab.57.1698251289712; Wed, 25
 Oct 2023 09:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024212312.299370-1-alexhenrie24@gmail.com>
 <20231024212312.299370-2-alexhenrie24@gmail.com> <ZTkIwIFKXe9aEkY4@nanopsycho>
In-Reply-To: <ZTkIwIFKXe9aEkY4@nanopsycho>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Wed, 25 Oct 2023 10:28:00 -0600
Message-ID: <CAMMLpeRcM2iv2oUDk4=zPehS_+qPh3eD1aa1adST300N_cHS5A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] net: ipv6/addrconf: clamp preferred_lft
 to the maximum allowed
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org, 
	davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 6:23=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Oct 24, 2023 at 11:23:07PM CEST, alexhenrie24@gmail.com wrote:
> >Without this patch, there is nothing to stop the preferred lifetime of a
> >temporary address from being greater than its valid lifetime. If that
> >was the case, the valid lifetime was effectively ignored.
> >
>
> Sounds like a bugfix, correct? In that case, could you please
> provide a proper Fixes tag and target -net tree?

Paolo requested no Fixes tag, and Jakub seemed to agree:

https://lore.kernel.org/all/60d9d5f57fdb55a27748996d807712c680c4e7f9.camel@=
redhat.com/

https://lore.kernel.org/all/20230830182852.175e0ac2@kernel.org/

Which is fine by me. These changes are not important enough to backport.

-Alex

