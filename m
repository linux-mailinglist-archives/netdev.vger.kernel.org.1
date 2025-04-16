Return-Path: <netdev+bounces-183401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510F1A90951
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69298445AEE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90319207E05;
	Wed, 16 Apr 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8lzS+S1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B16F53E;
	Wed, 16 Apr 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822044; cv=none; b=MAbOPJY5IRoww9Iw0Tg9p84jWrE1B4/lavKg2JgjdAbb3PiA8JAccsSD6aJpK+7UJKS0oXDWPbhwaanCceg+yHG46oXHH5DPdQH+pBBVnlGETLDyivhSHNYo6+70aqIySTxoy9YO2xh6ds99MKc0vLPYGFbhq92GH58daQIZBII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822044; c=relaxed/simple;
	bh=39BxbZJxzOc2j51sx2qrVfV5Kq0/9tpMcS2gikzPL8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZColySRT0/QdCwL+jyKqoN6fG5616L77I+3ySUipJCHTfGHsNFdfMQCNtCjnfGUgBgH2bPKy1oOn2l51GMUGe04oZs6HMBzNJfIFcyQyI1wejWWJep5QCse24g7SfEw67EO4oEg/tUGDTVCO9huChglvBO3HlUma67j19CmBQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8lzS+S1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so7096487e87.1;
        Wed, 16 Apr 2025 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744822041; x=1745426841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39BxbZJxzOc2j51sx2qrVfV5Kq0/9tpMcS2gikzPL8c=;
        b=f8lzS+S153v4Ww5MS+50qnQ16wTlWDWA/cph8NT16rmvDzR5pZEuCDVf2CKUh+5sxt
         rGdm7DHXg9d1fQXDtstcpva+qdszUEPuBNzKy2rC9SzyCj/WBWAZHaa/q1+OLdmfDBJu
         y0t1fkxNWYcgleKB8+O8QLGHZZzesaEXcn5hW0gXeTNJSavEi8f/G/g4WIvCBRioLSK+
         0ShZOqvgnq6jVT0bj4X09lpECdMi1rwlnZtrPStrO9TIxpxd4tOl7agks4EMlZQovuip
         MZbo1/7QPafE7YPbi82QQnA+3EPbMp0e/5H623gfajNTkgBFxLPIf+SOI9vH1nWcd0TG
         U+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744822041; x=1745426841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39BxbZJxzOc2j51sx2qrVfV5Kq0/9tpMcS2gikzPL8c=;
        b=v6grcK+8BxVuYjbT8Wb621U27xmAyCiogQjflgQcOMMT6i4dLrot1OfD35UoXqmCMH
         gvb35yo4EoJGMpsVG/yQADzhL6sTcrwnBIgfk4p/1skw+vzxaZMVK1M6Jy4G8oAyHctL
         czW5TMRM005P6smDcQNuuJDmN2uEEC9QZY9udf/IcwiUBMn92svEEeqVxEE8r2ZNGKs7
         c1MxysVjgjCjNWEMHhYHiy6SeR6ZpDtv0TDk2mcP8FTUHJ5y3YyQY/Nhgkg+JPk1AQz3
         q/WJsr8iYO2KcN4ubzfUEKGhoJJSyG9gTzRjuRWzhyqyhKm3S5xme4ytv9il23R1SNK5
         Zlpw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Pj9Y7mbCAYqvL1xv8cz65LrVSSppC+SWq5jYSgPpXI8AMoYCBrcGUjT7nEKAku5/8VQRKSJZ@vger.kernel.org, AJvYcCWgbjDRPiZQOndCM+2flTsirpPfSoxqBPhw90+yXB/AIlCKauaRQPPyqWgoHXQ4yumVe1eBWX2sY25U@vger.kernel.org, AJvYcCXk58tdG0AWbCu0rFpVWWLZHQBq7T+mRhBUNduW/A/jQzsaOYj7jmHjhfwU9eKJYpGaZ7U6vv6Km/FbuQan@vger.kernel.org
X-Gm-Message-State: AOJu0YzNOMLPzm1g0pHNxq8qJ2/t40wI82KKVF3m8UVpDVjP4U0pQuuF
	tVBhWJluK0z/rPt5sc5Mxsc20dZsr8VsB9hlQZ1st1QKu1+bApmMuX9SecHfLIcCaRrQ3StwYfI
	jhJVbYWuZjVqskdXYt7LnAfYxi8c=
X-Gm-Gg: ASbGncvRgJOIAu+wdQWjEPqwKekULy36hgOm5z5POa6z7bgPM1eOMzhr6oVsDptU3YV
	/Qb2OAkeq8Jvxjy4stlzQaEZyPbzcZy9ZplZbGySHYGV0l0Jy34EkU9nQf6dYVGxiffMe1d/i2p
	AQJeZvVYhrwIxAVcbI+5S0kOUEXXdlTykUO6HuKGWZwd/g832iCrg+fopqOUWDWRck
X-Google-Smtp-Source: AGHT+IG8lZZ6TzRpkafiDqZuJb6IdgkKcm718c9RVf9XNRQH9WAewHR/NAdfrRWL4fICzAbGf7ZhyLgzY9E0+gg7jUk=
X-Received: by 2002:a05:6512:23a8:b0:545:381:71e with SMTP id
 2adb3069b0e04-54d64aea47dmr805238e87.40.1744822040616; Wed, 16 Apr 2025
 09:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414140128.390400-1-lukma@denx.de> <20250414140128.390400-6-lukma@denx.de>
 <41ea023e-d19d-40f1-b268-37292c9e15de@gmx.net>
In-Reply-To: <41ea023e-d19d-40f1-b268-37292c9e15de@gmx.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Apr 2025 13:47:08 -0300
X-Gm-Features: ATxdqUGIOgXds9JKSX6cp4bYSDFF-AKiQ6t09fTbUcUeMyDb0_oZvm6DwfBTF4M
Message-ID: <CAOMZO5D+OZ6C02n4T3tJnmzJd9hTWtZA9o6-LXcFh-UmTdVb+Q@mail.gmail.com>
Subject: Re: [net-next v5 5/6] ARM: mxs_defconfig: Update mxs_defconfig to 6.15-rc1
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Wed, Apr 16, 2025 at 11:41=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net> w=
rote:

> This is unintended, even it's not your fault Lukasz. NETFS_SUPPORT isn't
> user select-able anymore, so it's dropped. AFAIU this comes from NFS
> support, so i think we need to enable CONFIG_NFS_FSCACHE here. Otherwise
> this caching feature get lost. Since this is a bugfix, this should be
> separate patch before the syncronization.
>
> @Shawn @Fabio what's your opinion?

Agreed, your suggestions are good ones, thanks.

