Return-Path: <netdev+bounces-165463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85715A32292
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 10:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543E63A97EE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20BF20B814;
	Wed, 12 Feb 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1bY7ylZ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD820B7FE
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353019; cv=none; b=sKrE7kqVC9lXJg9SeeuEJB7XeVXWbXZSEbvXNqrVfbbLS32PMbIZRjQYELZQtQUd0qid0Y5Dg7+ki3sWba4F23vebcRZJwrivfw+6j/5gDuvxSChIaXulVZrfQSLKUWbc1+03U57UdKYVgPv+2vAKrs6qe/N8vgFOF1yuSohM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353019; c=relaxed/simple;
	bh=7KT0FF/FzIbIE6w2ehfIcEyeGHIB5NZeS2fUmYmWmwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0t78fda63BKLBuqvTfENIL5KKuNmw1lcASZoMk4538UkIQ8wuh5GfqnVfsNhssO2L7+7V6/s3UCh6x8UyB1A0EBVhN71iJfGI8a5gDuveZwZv3hpb8OXCD8yXslf25KLxbIKGQ2N4x718H2jSXjcbqWhGWhY5oP/q0LbnzTlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1bY7ylZ7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-439307d83f0so26396995e9.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 01:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739353016; x=1739957816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRhZaB3W6faFlCbku+LscU579s6QSzZfyLaHX9G8q1c=;
        b=1bY7ylZ78sEe+qzdUjM2zmGfl1QOFXMRsX6hXdSa68HPLuyAOu9iJXDh0S+L6QuX6e
         NGG0J80Xki52AuIezFQssR0b3LYZRjmc7w2Mi+gjGrz5fFn4u9aYZ9BEBvvJl2YQVLzm
         34JyT8vew1VSBU9l4TeMWsrWJoOSZqen1K0wrXR5UVDzay1x1nMCl2fgAkqD0yTgz+6l
         rvVXrBNSuIMhJtFa8EvuqyyKbBN1JrdwVZDhRpe+gGQDpssIr6uTkd3BnUVVRgbzh/6k
         JwBUSbRHO5tJlDdyhhgPLpTIFpDVbsOizKfSb9nUArzef29+F7UPKxezK8ze/Pok4iI8
         CHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353016; x=1739957816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRhZaB3W6faFlCbku+LscU579s6QSzZfyLaHX9G8q1c=;
        b=WSXUqHzl8IJuRX4Qz9GK/JiboXc7Tnos5XyGdH/vgqu9plszmOUTQrX9z5ul/LNLH8
         R36vkmvNI/RN0+RmL8a+f8pzDqfyO2GMwQ5aLLNtmKEb/aSunrEq6j0/oPIG6Kii3q0O
         zdL7t1qub1w7OxI6U0XzAH+gJMhbzOnqeacH1jUkG7Wm38HoLRV/7RTBpxP39zvrz98+
         0wRwrJZ+poy/11+YUS0+Su06dfmtlhZ8bbdESxYag+7KkHVP64eZy86V98HBd6mY+hdz
         SpbMDuMfh6Ft91H7HT9u0ComRtzJ9K8JjS0P/gJBuGf+vNLBkHYVcdniDsTfGhUblJpb
         hA6A==
X-Forwarded-Encrypted: i=1; AJvYcCVhTUWLuJpuVEy/SDYOVQ2SNdgTSJKsWGaa/vigLZFxSu36H+k84U97Z8lRPlttksZSDVSzN4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBaIuCsrfMRxsts+tgJJcOUBgnKemr046r2529Iu9KGBYXatKy
	o7GnriARa+CcL8mkpBdAkpW9vktr6fjNYbIZT7Bz5sc6w61Wq/qQMVUZfvb0wps=
X-Gm-Gg: ASbGncsGHkxum57NshkRS21TkOYeO7LjFPAWw4HtvAe7Nh5+qzaoBSp7YMQfzrRQGRH
	jEAbu9Vgckjed8fTmlDTpEOfysRjGyOCUxQKe4iBFq5iieKxGCGXYrUL65a3Ebvavgg48zy0IJE
	jM0djOvJwqpaph5nqdMwvrqrOnKbTbbr7nwvOOXQDRD9Zs08IGvAYKXiJTHa6KEa+bxfwQgM8Tn
	R/ROZEkbxIrNMDfGTIQB/zKcUNg1iX9cxuh5KD+oyBF1hI95FQU2S/JYmaLVU59DK0t4B9D99LE
	jVq7BKu+oegHVbA=
X-Google-Smtp-Source: AGHT+IFQnul0kNzls6ThIvi1z7bQ429pLFDaGlT/FcOXJm3pTEnq6re0+Qc4O8V8syw5sWV5sK78UQ==
X-Received: by 2002:a05:6000:188b:b0:38d:b34a:679 with SMTP id ffacd0b85a97d-38dea2cefc8mr1824460f8f.37.1739353016217;
        Wed, 12 Feb 2025 01:36:56 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a078448sm14132935e9.34.2025.02.12.01.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:36:55 -0800 (PST)
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
Date: Wed, 12 Feb 2025 10:36:53 +0100
Message-ID: <173935301204.11039.10193374588878813157.b4-ty@linaro.org>
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

[06/15] gpio: max3191x: use gpiod_multi_set_value_cansleep
        commit: eb2e9c308d2882d9d364af048eb3d8336d41c4bb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

