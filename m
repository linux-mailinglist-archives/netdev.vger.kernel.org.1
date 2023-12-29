Return-Path: <netdev+bounces-60607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789818202CA
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 00:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349412837DF
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 23:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A9A14AA9;
	Fri, 29 Dec 2023 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5MhU2b/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D514F61
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5efb0e180f0so12299927b3.1
        for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 15:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703891871; x=1704496671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wI8xKLQeBYqRSaxiLeTVqBBYWT5UTjG/lH+ggSmaBs=;
        b=H5MhU2b/FHBA0iVFv3fGOeanPGxanlu9Pxn+2DGDbEGwcxQXnuRL9gQOwfp2W1Y8BG
         g7FuK8NsGaW3kF+QJIoEiHONqRYY69xMFMfRRVpiIg2Np3OoNfNGT29m4jZQ2tcgCOJI
         s3sgi/EoiX1npMhvFRdlAxHeXzwPnK2+QwJ07/S83qIfWizWvfiN0hxN5vdGuYjP0Fch
         lmxg7DGu0kepkcTElyyKAB+Ed+JLicJEyAJoAGmcTwQBuRhSIcfd3gBQCx/XcIbM0xEi
         BeJxO04hm5LadsUtTzLjbgRcGRlxyECFi1T/k/b+SZfKadWGbSXAooM6evsx7+RD+NXR
         FAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703891871; x=1704496671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wI8xKLQeBYqRSaxiLeTVqBBYWT5UTjG/lH+ggSmaBs=;
        b=CNm7FAPQLa2YpuZeo7wXENHJ3U5aXo8h6muDK5IELSLxwkR5YzEkLUBfqltbUKPve9
         DA3SjIRJ5ddbnhuyd7P5IupsUhO9luMP77/UdXZpejewdbzz6cWT9pc+jg4BEw7v0ZMQ
         4yHOEUZ9iFosg3uAVZZhICv/8aa2e5GdfmJmWjqIuReixigPBw7cA3NqoEHktafZczUh
         MZf/Rw5Kaq0pE5NPdlLOrNMpRb/PMdooz/9gIWfLkJYMRH1BSoUb1jXB58+pv/Gy6Y1n
         RBxSkkvF0I1brdR5o2sRXxmoIIMsmCDNTYuzCcCzLTM7Fka0gdTDVweTfrYARx2WIHBL
         btKQ==
X-Gm-Message-State: AOJu0YwZUi7wFHMEvDKnmSm8xi9R8mKhVIIkomRipkcH1z8poz0HY6r3
	Bz4EOhP8mOE6bc/9tAS1d86Bd5AqiM+BhUU6BNrorq6vMoE3kw==
X-Google-Smtp-Source: AGHT+IHT+vAqiejg1jfpcyWd+J5ZfmDZM5SjfAUvf8zQb8yoePYVuWk1v32t5NtdAfTOqfIyvaH73lZf6qvxCuTaLDY=
X-Received: by 2002:a0d:ed82:0:b0:5e9:461:d191 with SMTP id
 w124-20020a0ded82000000b005e90461d191mr9743279ywe.53.1703891871183; Fri, 29
 Dec 2023 15:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222-new-gemini-ethernet-regression-v4-0-a36e71b0f32b@linaro.org>
In-Reply-To: <20231222-new-gemini-ethernet-regression-v4-0-a36e71b0f32b@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 30 Dec 2023 00:17:39 +0100
Message-ID: <CACRpkdYQ-vm0cURfHGa=HbKMYc9tyEPBnzwkr9=Zx9MAeyMSKQ@mail.gmail.com>
Subject: Re: [PATCH net v4 0/3] Fix a regression in the Gemini ethernet controller.
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Household Cang <canghousehold@aol.com>
Cc: netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 6:36=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> These fixes were developed on top of the earlier fixes.
>
> Finding the right solution is hard because the Gemini checksumming
> engine is completely undocumented in the datasheets.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v4:

If no-one is actively against the v4 patch can we merge this?
It's a regression.

Yours,
Linus Walleij

