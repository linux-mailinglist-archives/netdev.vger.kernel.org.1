Return-Path: <netdev+bounces-76186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B086CB20
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 15:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B931F25021
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0331361B4;
	Thu, 29 Feb 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iz9+wZrf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF061350DD
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216058; cv=none; b=CP4tAGrCYQAaDFycLNXC70q+AkxfbJQV5MoCadcXyUe1GlXnTveb7R2ENZjix1knH1dpryUcYqvQ6VnCjt0AgKhuKaufczbVOZVdQ+LrRDQQWgWSYo3d4LKOPgSEGyipQW83vQ2qB53f2i2axuw9q+dyoRJtrok73cv4Piq4R1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216058; c=relaxed/simple;
	bh=LzlCXQZmFHhLJ1DjG6JRBVcR3tnpUJ4s13B8bN/dIdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYA5j4I3P200HWW7lTkbgo6Fb3hQsm4rx3G/nS2F4Z8E81mXAApzjK8OWMdT9mUCQ5ji6xMiHvGjvnVO2OKSxEmH1r6qGyW+C0DRs/kci+NJCEgSkcxb5i6wSqMqZekuhzXXTDbiZhtEXkdsxoo3jpSKdE/Fq+NSbYpruZ5QAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iz9+wZrf; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so1010717276.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 06:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709216056; x=1709820856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzlCXQZmFHhLJ1DjG6JRBVcR3tnpUJ4s13B8bN/dIdA=;
        b=Iz9+wZrf62US6H1dCKS35gpZ+9cETucD8k+EOVQiHXxOQspsvcw0fby/GWTuAjp/Kh
         hHbEKnZ7Xk8TgEkxXbwThliiEhjz9bCCGvwAX6Z6WnglH5QpEx/MaAGhcPeCevMJNZ39
         ZXebT31ewsjZ04eTlm/IeF+i6HjTN9ZQ+k1T93ud5tq07ieVfpFEZtOh26Nt2sHey95r
         dzXusZlGRRyFTvYJJ01SVJ6YtViA1HiCEZKp64kWXHJgffB6IFiLpZ7u08rBQwT8LZeN
         5h4eAhJZHT0v7uKj6vzDn22uFDaWL0byLXN62TUq9LvVwIS9KO94Sc/GGGHpfk2ptFQU
         J8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216056; x=1709820856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzlCXQZmFHhLJ1DjG6JRBVcR3tnpUJ4s13B8bN/dIdA=;
        b=bNf8TqG/k7D94GnzPEjUlDkU6uuhu9HcUAXnfdMVJ+2bWo/tSpwHl0xeMjOuI61nTc
         Hp99jDDkh5F4ek5OB/SW5G2NUI0t+sMBXuu7m1pOz/dt6rlPWUUmlv7ErFygKiD0hXgq
         H39BD0gol5Q4uLmvDincSEElxpKf89unGff1bZSg3RT1AVYw8qPADMGJH4veaQeu5SIm
         31hMwfBfzcL4opP/hPTDDK9uYKvDE20Qu4Wmsi8V+EvFjtGkC8xfr1bJDbODJfP2ey8s
         TgTy5LYcQY+uZc0cgBBX0pTubyfLk570q1QjKcGMqCHv44JfhLwHow8RDadQfsSD3Hes
         7GBA==
X-Forwarded-Encrypted: i=1; AJvYcCUL66CThrFdc/6zdhrlse6BTHwFMTkNAOH4s4W4pNdozDzADB1fNplBmjhRQE9NId6bYta4Xy/LRam08IG5McvfcmG8fRSf
X-Gm-Message-State: AOJu0YwHi56q/ZfD7iXGyxOpdEp8x6LWkuqIs2Q+49UwrY7XKbMP/txa
	zKaCx9r1iVLPFDP4tYRcch+NWJkRZDGJ01U1z2qRpToOr5B/Ym1HQMbz8VOnCFcJJLfF6M5aGeU
	cpyJNeP5cytazEDfDp1YAWGRdyM16OFffa2PVsg==
X-Google-Smtp-Source: AGHT+IEHu/G/RhbOGKUNEO2WjqaeGbfVkPM+qKPD0bGUq5f2BIYPRcqqhijch3RLX61Osl7GsvNx9tUYDJLBmHsC+NA=
X-Received: by 2002:a5b:f05:0:b0:dc2:2e01:4ff0 with SMTP id
 x5-20020a5b0f05000000b00dc22e014ff0mr2149084ybr.45.1709216055678; Thu, 29 Feb
 2024 06:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com> <20240228204919.3680786-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240228204919.3680786-9-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 15:14:03 +0100
Message-ID: <CACRpkdaEzexhCYFf-NKnbcagXc6Tqcn4J+sFWk94mbJG9LkpVw@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] dmaengine: ste_dma40: Use new helpers from overflow.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>, 
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> We have two new helpers struct_size_with_data() and struct_data_pointer()
> that we can utilize in d40_hw_detect_init(). Do it so.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Wow really neat! Much easier to read and understand the code like this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

