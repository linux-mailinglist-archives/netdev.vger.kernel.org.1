Return-Path: <netdev+bounces-171379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE83EA4CC38
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 20:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266D33A59E6
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 19:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D8F233132;
	Mon,  3 Mar 2025 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3C7Fn64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E5D230BEB
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031509; cv=none; b=AZTrnAUIRxKyO1XHkGtVaAX94Y6Z0yejOiEueXNYAJkS5vzfEtXYg41p7+mslGbGI8hJhEuKCdWKZVyAkGEXh9WrRm82mPQP5o42eMHaQGjBd8+wdZIPvugBxP/Dgiu2YuI2y/Yo4YEAICvN+UuoJPfAu3w33ZwLneE+3226ezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031509; c=relaxed/simple;
	bh=GsQ4AlMHXflwhjl3qlPbMr5mgvvbV1JUiFvFXS4uYGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQKR7Y9L+6CdLUwhZwdh4+Ls0Jn+tXmDo99r72tZqGb7Kh69vs8X4SGd/IUjQzQ3OiWKnW2Djo8OfPuS/rhVL+OKIt+i3nkUBdVCqSoQQtXmNJC7gVGpptU2pS/UjUGalRWheAvG8Yv5r7+F7CLtDvjU1D1koc/pygo9zj4IFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q3C7Fn64; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5494bc8a526so4192154e87.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 11:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741031505; x=1741636305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOeEe/vKXmfGXFSe4NXDP7rT5PatmaYJmBeo1VUXgeM=;
        b=q3C7Fn64y2JLH/pjzso65AhmdA9PZr8/Mnc2Rbg666gGcfMoD7MELHt7Q4vqPovuhY
         3Ny89+/JGVfkJFUL0arRtdihgM1uqn9YUhr8Y9LLgx2Z2xK9IemRHM5BNt5sEh7CHxPA
         0pE6mbQY2hpnA0sxMZnE1JbH1LPZIXEjyjo2ey0AHOD1RtlwojmWmiQSTPVlNQbotq5I
         rfK+rGnb+D7uVMrGogozAimvBdxTPQZYTtvcZUj2eFO7DLCtnu5C8QFpaXJE1AtcECkl
         M7npQKwglNKyz3cB5J5kdaxLxc2lM2dX+1CPCUWvos/8vyEp1jeCCzYIHof1KIKU8BAM
         onfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031505; x=1741636305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOeEe/vKXmfGXFSe4NXDP7rT5PatmaYJmBeo1VUXgeM=;
        b=ne1CB1U3kYzxTrvel46BmUo3DovNH6CPbXPMbm7BbuFRS5c6Gi6P9B7ryzEk2L0Z4c
         y+cgMp+YMf+m3x0OTQsxcjS+avUhahAQFtiSOSN/8F7VuRJxId+qrR8r6IFka9c7mb4H
         IJN9ANnQFZrZNdSglMewWT+m+ZZQm1VMHT+z3ZTc5PdfLBrfczGEYoQDnRU7VIGzzcKP
         YyDuH0rpStqRbjIjoyeU701kGSuVnVRgqhRBD3hUVDAaFuuQBhrom1jJTp2w8OypslRb
         jKo+jQWK24aOsc5SXuraJtQcx1tjtk29ar2wfTPTJgYbgyUcSqQVpXRkbYF37KaFeWlm
         fsOw==
X-Forwarded-Encrypted: i=1; AJvYcCVGWIpBRnuB9A67gEi06jzk2xXp0kPfKNnY+DNkPCvuMZyOMH34p+yIO83jL82zCUjq1A8dJTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+cuM3H5F6HhoARKgbhaHLhljoY6Wo1zwprGIicKXBfyAhlsc5
	L3K+ZwKZzYO5O1KBoxGHjAjb6Q/2vWZcr3/cN0qeKnXdNKLAlkRuFs8vzKyTooPZVmbQINzLD8X
	ohxLYiKbU7yPlvBIEJ3rc+a99XVVMj/UEp9T6Yg==
X-Gm-Gg: ASbGncthd/RzYBT2XrTYrKeshrkE43yYyOVBHDDb09FSgVo6zdoGnbqV7GKh9DHr3g2
	W37i+bb8q8uj6UwAoJNYbrUvYdZ8eIWbiGtp5sdOZr+W/RjYGHm6FFynpphTx/FIoU0Tg939VVR
	Rc4q5zCFtD6UKRKUeVKOs/e8npMg==
X-Google-Smtp-Source: AGHT+IFsGbvesnjWbfEk8+qcnhMhpwSK7rY1/+23lfk9h761ve12/onnm+C+Kg2oHwbcpQo6jWrgj2PsmOSffLjO+Lw=
X-Received: by 2002:a05:6512:124b:b0:549:7145:5d25 with SMTP id
 2adb3069b0e04-54971455f79mr1443819e87.34.1741031505444; Mon, 03 Mar 2025
 11:51:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303164928.1466246-1-andriy.shevchenko@linux.intel.com> <20250303164928.1466246-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250303164928.1466246-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Mar 2025 20:51:34 +0100
X-Gm-Features: AQ5f1Jr4_oqgGu33I-byOxU2dX3oyVoLqRbYUQ6KaoKwKXnjUNMYEaKqTtmoBw0
Message-ID: <CACRpkdbm5RQ-YOAaU7Mu2dyEjM12v8mP7rTTmW9-V5EbOPTJPA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] ieee802154: ca8210: Use proper setter and
 getters for bitwise types
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Sparse complains that the driver doesn't respect the bitwise types:
>
> drivers/net/ieee802154/ca8210.c:1796:27: warning: incorrect type in assig=
nment (different base types)
> drivers/net/ieee802154/ca8210.c:1796:27:    expected restricted __le16 [a=
ddressable] [assigned] [usertype] pan_id
> drivers/net/ieee802154/ca8210.c:1796:27:    got unsigned short [usertype]
> drivers/net/ieee802154/ca8210.c:1801:25: warning: incorrect type in assig=
nment (different base types)
> drivers/net/ieee802154/ca8210.c:1801:25:    expected restricted __le16 [a=
ddressable] [assigned] [usertype] pan_id
> drivers/net/ieee802154/ca8210.c:1801:25:    got unsigned short [usertype]
> drivers/net/ieee802154/ca8210.c:1928:28: warning: incorrect type in argum=
ent 3 (different base types)
> drivers/net/ieee802154/ca8210.c:1928:28:    expected unsigned short [user=
type] dst_pan_id
> drivers/net/ieee802154/ca8210.c:1928:28:    got restricted __le16 [addres=
sable] [usertype] pan_id
>
> Use proper setter and getters for bitwise types.
>
> Note, in accordance with [1] the protocol is little endian.
>
> Link: https://www.cascoda.com/wp-content/uploads/2018/11/CA-8210_datashee=
t_0418.pdf [1]
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

