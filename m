Return-Path: <netdev+bounces-171425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A8DA4CF99
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C303AABEF
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C73234;
	Tue,  4 Mar 2025 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EqdAS/SX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD9D29A9
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046636; cv=none; b=T5FAByO1yYpi8I1+wHiYKYoe5vscM1+YH1L3mPO9Ldl2AtW8eetEQLKhHAZRavxD3rjg1xg8pcRBfWKPxgOte5TqQLEozNYd57OJz3jCdFVntt6X4QO3VWP9ERW11lUL+wbKjTldxs6ZP/J8E3j43MY6a9inCGtMazKK8fDFBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046636; c=relaxed/simple;
	bh=C/LfSpekGkcQBqzcVBoT+8ef+/NIGmgDTXMdDSp2KH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZEybC0fujh8I1zmTJxOFi28aNp2DVrJrMJkY3L4OrEVYxmOrxvvws3oztYh8Zuj4wXoXHW5kHmHx6WawNIyDoqQuujMdfJL4k7a2d2qoIlLGyBJBmrTMBGqSRk/Vqy2A/EZe7wyyl72yWt7skEDSgDWDfHAccdbFGHx1bPfDgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EqdAS/SX; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bb75492e4so17602261fa.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 16:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741046633; x=1741651433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/LfSpekGkcQBqzcVBoT+8ef+/NIGmgDTXMdDSp2KH0=;
        b=EqdAS/SX1cNZTPEopGRn/ftTbaYzlpkYYur946VDRWoj00RW3RDDO8j/ft3yZdOdth
         fwKkbezcExtBYnOFIGVBOnMpIdFg6pvId4WvJpni43+cy/ieXkBk7HZ7mUO/GKJzeacV
         3ilD14W0in27CViA/3KtXcrWyRxCa3IJ3CnWQ7z8Ln+HPa/UUxlXT4iU0ldPZ9gqdzE4
         kBdvGA5OkZcNmK77gZFYzyrSu8KDlMuX0Y0PZPdDG295qR4uS9LTPIUOjlO1jDVJO/4t
         2nHIv/3zuQjN1hLi/I6VDIte/+82buQbCgfGEofT4f6F8nOE1zw4pZOIAU4W9Or4i/kL
         Aw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741046633; x=1741651433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/LfSpekGkcQBqzcVBoT+8ef+/NIGmgDTXMdDSp2KH0=;
        b=Qwl4/jqkMi094dV8NFE0ekbcgguWQPQdTQx5PQshatSbhw5hl/ViuHd30o1AEUwOvH
         fKTidOiF75huXGrrRXy5/sU9PfGHHZJTPtLAds4FJm3dppchawlI1pUlukv6Ge+JKotQ
         5P+PIzxxKfFtNUtCskYafG+fCd3HWQDpgJCdwjenWmFjbl+E5bAjTPDsvSKmHO8Naoa5
         rglw/0FKKUpf3P+MhHOqE5vvZIMEcTzpx/XR+fmbyNBwCswvnqjfsNjMJGbHKtRjR60V
         T+TqLjdzWq+tYR45EZdcirVvv8QSAOk4mps/0cjWPMeWFj9Zl1xtW9kI22NY4/NPjjYQ
         g5jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWZFbqeOQbPf6TYi+TkovP0H2DSxuvqRsh727/o/DesuN4LLY7txZKD96F91pm8oKgH887B3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTbjll8GSzITVBCP1TC5JWpI3iY36th8o29CUsDW5vcT+wIKjH
	cY426lknb64cNk3URGB7NP7z4RFQZVVhj/X7b4QqxoHLh+kMPaWUpw+yLNbyaKoDnyswMRJfFJk
	4sKr79faWk7TIgLr4huf7pRyp2W53uKkawkwu2Q==
X-Gm-Gg: ASbGncvMjOFlZGYj70lAN1yyt/xJBv3uQkXfT0HdfSewtiXbHle/tCl0p3Ra/9scpfK
	BKGoAuPdLX47ZcjUbRMB5E9WnYCYdxgFl+NE1bvTX/17u1lZMNMo2PCruaOz6//5nyVkqtgRw6e
	3OIYngFqnOZWAA9MacNoZJRKGnpg==
X-Google-Smtp-Source: AGHT+IGrydCSg/lI1uzAKwGHugbQGvBBzjG9s3mdXfZC6EYIplaWRQ795GqrXmFtWsW5Su7ME7vIhfLoaVp40Qd8SR4=
X-Received: by 2002:a2e:be03:0:b0:309:1d7b:f027 with SMTP id
 38308e7fff4ca-30b9320f37bmr66066201fa.9.1741046632848; Mon, 03 Mar 2025
 16:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303164928.1466246-1-andriy.shevchenko@linux.intel.com>
 <20250303164928.1466246-4-andriy.shevchenko@linux.intel.com>
 <CACRpkdbCfhqRGOGrCgP-e3AnK_tmHX+eUpZKjitbfemzAXCcWg@mail.gmail.com> <Z8YThNku95-oPPNB@surfacebook.localdomain>
In-Reply-To: <Z8YThNku95-oPPNB@surfacebook.localdomain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 01:03:41 +0100
X-Gm-Features: AQ5f1Jpd0GEUB6MlVioV71j1v6rfMl3pu_k3_4FUFebcVwfwl0boXwZuTwUA1vQ
Message-ID: <CACRpkdbqYoY1vYGii1SyPL1mkULGXYX7vFwu+U9u2w9--EYAsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] ieee802154: ca8210: Switch to using gpiod API
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 9:39=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> > Maybe add a comment in the code that this is wrong and the
> > driver and DTS files should be fixed.
>
> Or maybe fix in the driver and schema and add a quirk to gpiolib-of.c?

Even better!

Yours,
Linus Walleij

