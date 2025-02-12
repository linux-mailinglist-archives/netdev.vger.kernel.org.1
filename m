Return-Path: <netdev+bounces-165462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4AA3226E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 10:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B53A6D8E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF93C209678;
	Wed, 12 Feb 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QrIgjLpE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81B2080EF
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352989; cv=none; b=BQIQ34hsBLBGt6d2wDoL8Mmnj334K+aE9k4UgcmUgitkhlE/3TszTM9KPvwIvxk3+o+S5+Yhz+zaVjqD+srUvdIc/5lcgd8M83sV7bDwoUFMGeM+nIh6JWeP3iWPE99Dx6ar2VBPjrbM/yeNInbbnuE+D/ug5axGRH8/fif74pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352989; c=relaxed/simple;
	bh=I7CFgTkt0jzyGzG4M7RjYnnbGhlCBrEk+jlNQ3TAQts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzJQ0wCoeXAioPkZkdsO5eC4mlU3gDVlExq2FW2UDFGELKuh2AmLZMMtaQYZb20KRD+F2pMmM+4Y4pz/GoZPRUIieJkpQrQUkvtjat+PFAdmiHDBnab637xpcc2P1ZFbBysIIOceUuLpyoV668xAt025ROZcbZ6AilJ2KM2xTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QrIgjLpE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394829ef0fso3651845e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 01:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739352986; x=1739957786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrbuHpRRCn2ojY6FY2MTuNNVYvVFb7ykFJzn4YLtY68=;
        b=QrIgjLpEkIg4TvIfUDn3FaU9UtGn68UJuWXMMFjnw4pJIp7q01+sRhx2F0VZ4ntyrb
         DTrq8sVzdwrJu4TaGKOY7n4aBTY3xdvnVEV6RW6DqZIv/2RDmCOBhHwewUPWzzIrta00
         6z6P91/vFUQ0zF8LZCpJr9M3F5EY9/g8LjPGBEhOfymyTWlJxA4VzKyVrx12AKeSF+YZ
         N7DVbbx7q2oHHAL1uMEw6zDoSO2LbkqwINA0HKNuZ2PGQp0DLiZj+skDYbmiuEAiXFsf
         A0t/Z66W3OLN9cEEH23FX16CE5d+yhQDNxfHJo+KiM/hL2ihtEeKhNQeTCl+gYpINcHO
         cFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739352986; x=1739957786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrbuHpRRCn2ojY6FY2MTuNNVYvVFb7ykFJzn4YLtY68=;
        b=VgQobMNjzMDrgvf0m63Cy9tCTz3e2KmaSfdYBTTMj26IT4FQI+gRiVNyeSKGvjloZ0
         CEjIJ39/C2QBgz/pTRx/NA+Rj6Eux6ij0plP7T7hA9mLrC7DWmTIK5tEfeoPyv496YQd
         7tq0Rw7kaW6KU9Bim0xEhrH6gkr35hy2tQXyXKLu15f0o5nOzFtxjxl1GVmAD7dQ2GAf
         ciUTtPVC9PGeHOFzsRvzS5HsEDMdkNr1ut7p8rKDQ14uIn52j59JsCv5rLGTKHKCvd2r
         jWrAK+luHs/PvEqKjkSEndVlyr9KN2Kbj39sx+h94+y3Alv0/7kkFVFRPuc53czLuWYj
         /56g==
X-Forwarded-Encrypted: i=1; AJvYcCUMSni2Aqy8NjQNx9+FyMpqLxdZXU7gXzDzpTfQNwummTqbswW0XumclqMH2JGNfYTEDdHduI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy587u1KVO7FPfQnXZAKveoK5V7vr/q9g3kDkXvza7fA0xqr9en
	9QaxHRlTfs4eljPBoBuHtYTRkBobpKO2Y2SfVgxaerdE/ieCwh8ZPlZLmbtRoi0=
X-Gm-Gg: ASbGncu02z2JJXf61KeEYHlcZknpV9TvuJkfD8jLXsMDXD6A9jvOp1uRCy+9xbXsv/l
	UY+vQjhZCT+JrpQA8nVqUhpVaLNwtUNrQyMrqJd+KIjEXrQz94uO/5qU6KAq+ecLzNFRp4LGQhG
	A423s+hYAfNZMz74KlzG6oomhJiTrYnqqj2L8TVxZ8BGbd6JDjRBZqEoiSD2pmBeYXDVEAVUGcA
	8O0XSTSpNFJ2xFze9WFup0RW/x7x/SS0Beg3UL+LARBn4SgmYjA1ayq7EbFT7XblgAlc+qx9Ok9
	cxTcsykvA4mpObc=
X-Google-Smtp-Source: AGHT+IFudfgBGV0+IDygsdoLTA/5igyJSZtMJXjbCQPeBSc7oN4L55kdXKAZLq0JA2599sk+IrdqDA==
X-Received: by 2002:a05:600c:3ac4:b0:434:f9ad:7222 with SMTP id 5b1f17b1804b1-439583b4e03mr18452935e9.7.1739352985575;
        Wed, 12 Feb 2025 01:36:25 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd8dee385sm9918965f8f.61.2025.02.12.01.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:36:25 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	David Lechner <dlechner@baylibre.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add gpiod_multi_set_value_cansleep
Date: Wed, 12 Feb 2025 10:36:23 +0100
Message-ID: <173935297467.10817.9536577313319553775.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 10 Feb 2025 16:33:26 -0600, David Lechner wrote:
> This series was inspired by some minor annoyance I have experienced a
> few times in recent reviews.
> 
> Calling gpiod_set_array_value_cansleep() can be quite verbose due to
> having so many parameters. In most cases, we already have a struct
> gpio_descs that contains the first 3 parameters so we end up with 3 (or
> often even 6) pointer indirections at each call site. Also, people have
> a tendency to want to hard-code the first argument instead of using
> struct gpio_descs.ndescs, often without checking that ndescs >= the
> hard-coded value.
> 
> [...]

Applied, thanks!

[01/15] gpiolib: add gpiod_multi_set_value_cansleep()
        commit: 91931af18bd22437e08e2471f5484d6fbdd8ab93

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

