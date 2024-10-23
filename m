Return-Path: <netdev+bounces-138395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639889AD4CB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 21:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE37CB21996
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5A21D5CF1;
	Wed, 23 Oct 2024 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L0KhIVa4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600978C9C
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711681; cv=none; b=pLX6D8UB2ceDYhVz42OSYEYSqoQ91ewS/HmM+baelyqrgLzTTCjc7LuoVkNnluPJM1axC/dF3Fe39ZYWLJJueRaFd6rjmFtrZbHuD+v1DE1bzw2zg1zwnELlUvrx6SIF0ZJvqYX9zN/HIgnMA9fvc+3a1oAOOr7afh2If+RO1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711681; c=relaxed/simple;
	bh=jVfaEMDiqxEbMojHP9PBFB3cC/z3et13Xb9WEIyCI8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7psYtsbSNVjtWZ6oScgZQ9wyBMiEjVpxHtUtuP3d7wou4+NULs8OInzylhfQI+DhHQqZb9YO3jKWZ4mFM4/BW7Cb8NDFGv5UYvJIURmxMhGRDuVJGlaG+QQDaHn9+B4lPXUX+Ih2zMsx5IbqNSponiFkvTMALTeD3V8e6Jn0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L0KhIVa4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso198029a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 12:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729711678; x=1730316478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=L0KhIVa46Ivx7gfKJWlfzwJEd/Q31I2+tGi6wxUgF+xvtA5oMJsRNxkGQvQtJhH2x7
         bhyIypsgHnX8E0z6yh3hGlltPSr+Tc5KqKBQM1zfyh5wALbSbQpymcnGlTdQE6peUjfx
         QN4M3DeXzAwwaG+e0f4PTZuisvv8qpD0uKwag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729711678; x=1730316478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=Zvkxs/ZbU4YR2/KCh24rljzezoLyCR3qGk65zejQvpBiRbAZHRisIAHPsv7ihqN1mg
         mnCqZOAiG/Mq9kOTdnIqlSEP/2PhnSVQu8kee1soqbpDwh4O+JI1n/BL/rIaagIy3IVv
         vd3a/mUBYa4kRQOBtWBH9gLM9YM633BFdTFROj1AHy3oKrM6s1oVzrFUUSh6vWK9t/gR
         Us1vay3Il9KR4Gi+7j2fZcQ883M8X50cpwP1Qw84CYoHINkb41hXB2DhGiPzIp03saJw
         uzybvScHm8Ub45duoIPyAHx+EuRvLqqo2cqBYTA44t6JsjFccsgHEXJaTJk9buO1i1OC
         Z4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlvZ8bidG0XoAz6NpNUadCb2BqQhMP04xCdg8tRLxByEJJn0JRVIzL0wHGqssnvSIxfEQ7B3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb07zwQFqicN3N9raUU17BKtq/Q8+mm5uLDj3NIUWc0sAj1VYK
	lBxVIwFJHpZFlV/g7TNiEBVlyPYaWZEvGLUAXIwe7kWKhf3WcM9lA5Ud9Z2k9KTnh8DEtd/Evdk
	u5x+gKQ==
X-Google-Smtp-Source: AGHT+IGasmRvPYCof1wAfa+Gg8weNXFppX9Tb/++2pn3FZ9r+uMbJJ39fidZoWTpU27BVEH5Hn6aVQ==
X-Received: by 2002:a05:6402:42ca:b0:5c9:6f8f:d7c6 with SMTP id 4fb4d7f45d1cf-5cb8ace953fmr3228597a12.13.1729711677917;
        Wed, 23 Oct 2024 12:27:57 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6a45dsm4990971a12.42.2024.10.23.12.27.57
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 12:27:57 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so12757466b.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 12:27:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWK3kf4ThOwSobKPDkppQL1zIVhTBxnzAsX8/p+mQeHLggfH+8U9wseUMm6DQPV9TqrXWrgu1w=@vger.kernel.org
X-Received: by 2002:a17:907:72d5:b0:a99:f4be:7a6a with SMTP id
 a640c23a62f3a-a9abf91ed4fmr407338266b.47.1729711194415; Wed, 23 Oct 2024
 12:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org> <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
In-Reply-To: <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 12:19:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Peter Cai <peter@typeblog.net>
Cc: Tor Vic <torvic9@mailbox.org>, Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, 
	gregkh@linuxfoundation.org, wangyuli@uniontech.com, aospan@netup.ru, 
	conor.dooley@microchip.com, ddrokosov@sberdevices.ru, 
	dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com, 
	geert@linux-m68k.org, hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org, 
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru, 
	ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org, 
	s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru, 
	tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 12:15, Peter Cai <peter@typeblog.net> wrote:
>
> Again -- are you under any sort of NDA not to even refer to a list of
> these countries?

No, but I'm not a lawyer, so I'm not going to go into the details that
I - and other maintainers - were told by lawyers.

I'm also not going to start discussing legal issues with random
internet people who I seriously suspect are paid actors and/or have
been riled up by them.

              Linus

