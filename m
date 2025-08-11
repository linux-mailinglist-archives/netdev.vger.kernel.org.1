Return-Path: <netdev+bounces-212412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16583B200C0
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8BB189E012
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477042D9781;
	Mon, 11 Aug 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qWd8sVoy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FEA2D94AC
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898595; cv=none; b=RCqC8EioZ40GHSNHAt8ZrK1eRfXKhvW2MbLBkJj9bK8DcvQxFot6+QiBgbXLjoJZpHd2i4ixGXgs1Jc9EI3RpAiKJuvKybBzD0wvnurmhxLnNToV69rBGiB2c4BkWHFpti/l6MkA9weRxWj+r4/ggvSGwLdm9XmKB+BFz8ibXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898595; c=relaxed/simple;
	bh=yqjyOKd6429hO6MonfOfKptAd85Vob6P0aiaBpcrRho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLO+3sL9UBR3jK6587X/jsl09ufxrjzpc57k3xw4bmJ7zlxSsGBwMRaX+n/pzbstc1ukV5BzxsSOGcTWuXIOnJ7oENHyfREoTl8KSEIJAs/HoxpT8/lcT7kzzvvnb3PBBKnnWKA+QDuThP1ywA4c/r/PkLHsxJ6XgJIBMfxoxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qWd8sVoy; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333be1f3f46so9171571fa.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 00:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754898592; x=1755503392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqjyOKd6429hO6MonfOfKptAd85Vob6P0aiaBpcrRho=;
        b=qWd8sVoyQ6tgF8+EMPkESFCWnM6qUhILvTC4Rav5DwEHJVSDIiMNONZ0USg6ZCDjnR
         ZeWk+5LJe0+lcHY/6m2lsTNKkIKcOTsGE6p/xDIBsX1256msemrwZlFYk41KN7KXZ620
         wu+jhZyWG5+IO3a35EukFezDFrH0xU/XX4OxCYduJ48AuW/aMFBLeNrM8v4RUA9hvT0s
         QC8NJzq+AzoXs+SlEHKOQtntSxE0ppv2VLaXwEAsixgEjC9ZvbBmlPPTdX0SLs69ygaO
         55kzl9la1lZAcYFO9StdDu3063CXQ36/Wcgj6KopEhSc18NGqzCA1mOy3uLd7s/dLqQw
         BjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754898592; x=1755503392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqjyOKd6429hO6MonfOfKptAd85Vob6P0aiaBpcrRho=;
        b=k5Y6Ffm/g1WI9JDfiOYJBiWbQEKfqZ3uJqfYxrXb4nCvdO1tNvZE9eG4G/75PCzZAM
         hHJDQDCaXnYjo9qpzeS9VcmxNRdiONCphHm6S7azbw5e4NWNsvzRR/EDqFihYc10vgrw
         qpmBi+Sn2nJHapI+qf6avg/CBybPOgM9kk9amucqhaOhfcafCMP/ZfUVq+nI+reZHhv2
         gRQEAO3pBOpsbLMGz3HZFplU/dl/z5BBuggO5h9RKt7cGJtRWInllvv4VNcw/GXcY25w
         7eSUOfRSOcNIAv8Uq6PIXxnAIEN+QHXxkEsPjB1pru8rFL+dQwilCMc9XR4Na/Of8uXr
         o/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHk2Bo67Vf572TB5U8oXkz2lpJFu+CU26cb3lvwusxh5ufkohKuS29lkZOuOsw9FVYGNy2rNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIvYohKqBN34yCxTxk7SJbvUvav2Q/gSs0H67hKBSMWrT8GKez
	Q29N90fVNXueDMCBdPVqyp7aYJ4afgwkLzysHxaFBAJTHMfqNk0KRq2Fb4NQjfiMZGJDfxFF1X5
	yc11AF6DOeRcQLY5djOlMi6Ui5t2wTVeuWI26XkPmuA==
X-Gm-Gg: ASbGncsgKbOk0867L56PvFThH2UqkdF+KkiWZ5xjD53nvrNkZLcJtxHyPj1kyGGHWzn
	dbDnmNwrUKEqYk0KaRWHqyRUCDbJI8kaZe4uvvAwT3QTWIiyXLX/gAp0DfpftgBT00bp1HQ/tnK
	k8+0rKHqCjgkzYascNijWTPYsUsn93UQnFRWcOf0SRBBSur9Hd0OsK6kTWkehkGkoCjiQnxx4Rs
	VserUw=
X-Google-Smtp-Source: AGHT+IHdOgrBI2nlxGCIpTQoHYX8dfA650k3ilE4vjuKz9r49GGUkVvbCc0aDx5dNyq0ns9FZtEo9GSVsT+5ZIVLURo=
X-Received: by 2002:a05:651c:19a7:b0:32e:1052:5437 with SMTP id
 38308e7fff4ca-333a22ee2b8mr31470241fa.22.1754898591879; Mon, 11 Aug 2025
 00:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808151822.536879-1-arnd@kernel.org> <20250808151822.536879-18-arnd@kernel.org>
In-Reply-To: <20250808151822.536879-18-arnd@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 11 Aug 2025 09:49:40 +0200
X-Gm-Features: Ac12FXwizJhPa95k0G5kFLrgvIhDZ9cr20VXPTgVVNAz7S9edqHQ4xOcKRuNguc
Message-ID: <CAMRc=MexS0+qHuwpipPMkKgK6f++mrsGbxY-SAxFxehSWAxAFw@mail.gmail.com>
Subject: Re: [PATCH 17/21] nfc: marvell: convert to gpio descriptors
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 5:24=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The only reason this driver seems to still use the legacy gpio
> numbers is for the module parameter that lets users pass a different
> reset gpio.
>
> Since the fixed numbers are on their way out, and none of the platforms
> this driver is used on would have them any more, remove the module
> parameter and instead just use the reset information from firmware.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Yes, please!

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

