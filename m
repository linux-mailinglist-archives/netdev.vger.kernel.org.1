Return-Path: <netdev+bounces-83887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5240894AB8
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90300286B5E
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78B18028;
	Tue,  2 Apr 2024 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKQ2fQqV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA11918651
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034085; cv=none; b=sOsJqka3vMJ1GSwfuvd8er8ErBUSpvccp4xKU36e2Xte2Hijgff/ZtXKTqF80J1qFLNVnU2WAdKfUlpMBgaXj9lDFwJQqJMSV2uwz3wFCswLSIGr8TtZUpK21FJYMJOMrKUqTF4eMbydxVmHKMYX6V15daV5jGKt5/sAaqxDIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034085; c=relaxed/simple;
	bh=NlyBxPHAyNv7/T8iQ/z8RSMGympsoOOW1QAfZRFQQYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbrVBMljrd9By557O0YFNWSnZhwK5wwiUSKd2xYqW1l8LUymmPPs1gNM5WwIbbKDQQ1MBQ+9b+ChuY2sWeIDAWZCRjtzZ8u95MJH95yjHm3b18Z54yKUAggJlR/ybB/VTAznOYseY7x4RxsMxW19O+d0GT5sDnzog1VfFmJMlTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GKQ2fQqV; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d44fb48077so1719034e0c.0
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 22:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712034083; x=1712638883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1gSlS8fLmBzxegVrsxC5VK6VZWbcNLQNxJqECmZ5UM=;
        b=GKQ2fQqV2eSfPoBaW8hY1Sqrk08lLy85JT6OGGNhs7KxkFJ20EtcBM0FAYx/q7XNmm
         V8pAcO0kdGSE5yk1Kpw1gjJIELD7LO/5Cqc17zZgbKrhMAlM4PPhEasSyRPJJwrqIemi
         Ar5sF0Ux/1vXUUnsvWGWYVNpsrnUuuaqa7EWljbWCgRKCMGlejzZsMb4d5iRG9XPHmPE
         EHtKRyQi62w1xWlt1Ge4jPJfhsaubao+LYCCOftNgF7ENPiLZrXwqibmOkg71uzqjHaV
         XrcCO3hhxWRwux+eHF0CAZCQM9eZS8ZJB44yCmbSLSycYo9sGjawuOffFhgO4SEFMwE4
         XRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712034083; x=1712638883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1gSlS8fLmBzxegVrsxC5VK6VZWbcNLQNxJqECmZ5UM=;
        b=PJ3URJKYMbXryxxmaR8U7kRHUyFhft5sdMiVpvG52TFLT1CnpEGLDL33NJAe1TwIO1
         /5DqQDGk22aSVVAUuJEsNwkt93xaYR2oe0wrmTy6pk5qmNrEcTTOmBakRmCSOtO/aL4f
         hZv0d7AthsayzrrV4mh+5HtrNvMo29wqbnlSlAWFtpy/MeKkHKmlxsnfOG2J+4Al+LW2
         t4Rl0hg9VZbGPIFQIhLbKNsW5Xlfo/OpUZ21R7QQAam9JEjL2Z7AKZI6UmOn0l7rhwpm
         m19BL2ONQo4z8Pjax4uwEsmi/HVmbeKqbBX3+XeKJb3owhFIjA+pj+2F/hKpmVJ8UUf5
         TrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjuaPWM1gkHbhzm2eJqKT/yv6F8djThHnIRYmryrc5sEC8cR/6qX19bFCe23FlmG8BsD8NoynIG1yF+4IUCzJkjvCgxzXh
X-Gm-Message-State: AOJu0YwJjENCdISGkssNLN8jjm0N3yCn3snIVasovGf1/CHE6+m1DtPX
	zLrzHLdDgus5x67o0lWVc2Dv5+XWes+Ys5RLkRt10B3f+ca/unB43YvXzp/bcJI7J07eiipNGzL
	I+aDVjjdSoK076YbQ0Un5KbzMUaap8YmXBZk4Jw==
X-Google-Smtp-Source: AGHT+IFbWd87Vw4lUKJrcGZtFq6L8tz7Pk5A3fnIVM0X6MCy+GrJJQRDnUgtXO3nhQHsmMS7Qn2OwbW+bWyfrDvPcd0=
X-Received: by 2002:a05:6122:a05:b0:4d8:787c:4a6c with SMTP id
 5-20020a0561220a0500b004d8787c4a6cmr9108749vkn.5.1712034082741; Mon, 01 Apr
 2024 22:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152549.131030308@linuxfoundation.org> <CA+G9fYuHZ9TCsGYMuxisqSFVoJ3brQx4C5Xk7=FJ+23PHbhKWw@mail.gmail.com>
 <20240401205103.606cba95@kernel.org>
In-Reply-To: <20240401205103.606cba95@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 10:31:11 +0530
Message-ID: <CA+G9fYu+U1kkxt+OGyg=qSr3PfZipuazaANNTdfKvdY_zQBxyg@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
To: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, 
	Netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Arnd Bergmann <arnd@arndb.de>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 09:21, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 2 Apr 2024 01:10:11 +0530 Naresh Kamboju wrote:
> > The following kernel BUG: unable to handle page fault for address and followed
> > by Kernel panic - not syncing: Fatal exception in interrupt noticed
> > on the qemu-i386 running  selftests: net: pmtu.sh test case and the kernel
> > built with kselftest merge net configs with clang.
> >
> > We are investigating this problem on qemu-i386.
>
> One-off or does it repro?

one-off.
I have tried reproducing this problem and no luck yet.

- Naresh

