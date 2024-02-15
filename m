Return-Path: <netdev+bounces-72194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC40856E97
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8271F23822
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2071413AA23;
	Thu, 15 Feb 2024 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCKnplUs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92B139560
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029180; cv=none; b=uKBl6Wt9DCKp1yhXyG0S7TSffiw/2Up67EPmBd+8jXRRcukwHIu8d5oFmP6QRseEMO2mvp/gfNUcPbRtZD8vnLLOiqJdlu00pazpY1HeY7BSr8reawT+vUv0y5NPUmdqCe+HR+lPtp9v/nk3IMVtjYUQyKNK1JrAoNcJgK+Y6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029180; c=relaxed/simple;
	bh=laSyg7YQPz643rzuuYEwb1CY2iHDVt99rko3X2hSnfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=focbs2YEtSqkjD3VMbvc2NwLTKNm70oH4DO6Z+0xuXZyipir7jTvmJngjhoihqDLtK1XI2Y6e20hit5GhPYJlWNIgplkPsL+r/HQF3g5RQAlsKRY7fXX5JQzF0iSSBmx0m+o0bbT1bK+NHe6wM0rGzC0Em+0DMGI/8WUFjEpDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCKnplUs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso2549a12.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708029176; x=1708633976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laSyg7YQPz643rzuuYEwb1CY2iHDVt99rko3X2hSnfw=;
        b=zCKnplUsZl9cOHx1bsNhWVtlP0ATw6MpTM5BmPWs47sgpuz1ml51CDWFrlurYxwtRx
         eSDHVLvtnA4PEFRQG33cCHy9TvyulFK+pLb0GH9mNgEpYMIqxB68zrzN7vinbZDXHV2c
         2mY1MrfELx7RacES7icTlZgorfIXoTKZLxFQB3zatHkdqpuNj9yJPcQnnKTUDFtBg677
         MGIJvBzVyDBgKIy9YoPuUt0OPTGJzMKcJqxGaYd33+h8JzPTbRpIs5u3oEPTg7szDPFU
         xjkearPpOnufothrK+6gIik4YC4d8GwtFy9qCgApZNqk4omjgd2jLOFBsqRbeIQxLl6k
         K2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708029176; x=1708633976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laSyg7YQPz643rzuuYEwb1CY2iHDVt99rko3X2hSnfw=;
        b=J6q8dLJQhpEnBEq0BVlx+x/KcZsj+nuVcNKL2S0ZlIBCIPTcz4PyTu01Ha5eW/N0zW
         SEQ/Q5gaVkcXUWSHOV+T1oyZberoW1zUwFGO4rMgQ6dYS0i1il/wyLMOZl8qAny0TFvZ
         4kiCuHeOJQtdKy8BQXCDwhk1iB17Ub8ONCQFzMzifR2sxjjuBIYUQ5lmyf6E9bPoK1Fd
         UAJXYSbiUiQNENy4XZvcdMqjorRKFLrJQlpBs/mktUfo2uaOd/fJ/qOmk83D6CiTp8Do
         3JGZkzje0L7KyThqxAsr4BqgAAC8aQtq5mrQPJ7vlV/vXF9tjZ+RIzWn5Lf2apG4VjnQ
         YGHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXNpBIUUB1iSBGArnA1Xxuhu6s+/0QUtcHebGqIWi6QUrpyIy2hxy3td+9NXY/8lRdR9v9ziQFD3/fI1cD1kxYunafLrLd
X-Gm-Message-State: AOJu0Yx1ZdEwplbemo4djY8tmoHg1Ci3oeQCrmO3kS9UCUBqrN2crZuF
	ddnUTgvXLGvxhqvkW2qPNrhmQ2VsbnRb0byLWf84NERcwUhmLL80bPOWvP0c3/vQokwahoT3aaU
	67559G9sQdFOmiL/9ek5YnrqsiveJk8YNMtik
X-Google-Smtp-Source: AGHT+IEchM9k5jNArbj5+35xIQAzhyJ/jP6cl9FmgZLvIfjEnm9gulJ+kijAQ6eqYDiIJUnuCe8d9j548sUG4qfxPWI=
X-Received: by 2002:a50:cd8c:0:b0:561:a93:49af with SMTP id
 p12-20020a50cd8c000000b005610a9349afmr44357edi.7.1708029176383; Thu, 15 Feb
 2024 12:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124101404.161655-1-kovalev@altlinux.org> <20240124101404.161655-2-kovalev@altlinux.org>
 <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com>
 <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru> <CANn89iKb+NQPOuZ9wdovQYVOwC=1fUMMdWd5VrEU=EsxTH7nFg@mail.gmail.com>
 <d602ebc3-f0e7-171c-7d76-e2f9bb4c2db6@basealt.ru> <CANn89iJ4hVyRHiZXWTiW9ftyN8PFDaWiZnzE7GVAzu1dT78Daw@mail.gmail.com>
 <6cbbecf1-eba1-f3e1-259a-24df71f44785@basealt.ru>
In-Reply-To: <6cbbecf1-eba1-f3e1-259a-24df71f44785@basealt.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Feb 2024 21:32:42 +0100
Message-ID: <CANn89i+mSOtzxOfY=FLhQAj2bZ+a-9KdzivGhBx8_V9YwaAeOw@mail.gmail.com>
Subject: Re: [PATCH 1/1] gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
To: kovalev@altlinux.org
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nickel@altlinux.org, 
	oficerovas@altlinux.org, dutyrok@altlinux.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:50=E2=80=AFPM <kovalev@altlinux.org> wrote:
>
> 09.02.2024 22:21, Eric Dumazet wrote:
>
> > Maybe, but the patch is not good, I think I and Pablo gave feedback on =
this ?
> >
> > Please trace __netlink_dump_start() content of control->module
> >
> > gtp_genl_family.module should be set, and we should get it.
> >
> > Otherwise, if the bug is in the core, we would need a dozen of 'work
> > arounds because it is better than nothing'
> >
> > Thank you.
>
> Thanks.
>
> I tracked the moment when the __netlink_dump_start() function was
> called, it turned out that in the gtp_init() initialization function
> before registering pernet subsystem (gtp_net_ops), therefore, outdated
> data is used, which leads to a crash.
>
> The documentation says that ops structure must be assigned before
> registering a generic netlink family [1].
>
> I have fixed and sent a new patch [2].
>
> [1]
> https://elixir.bootlin.com/linux/v6.8-rc4/source/net/netlink/genetlink.c#=
L773
>
> [2]
> https://lore.kernel.org/netdev/20240214162733.34214-1-kovalev@altlinux.or=
g/T/#u
>

Excellent detective work, thanks a lot !

