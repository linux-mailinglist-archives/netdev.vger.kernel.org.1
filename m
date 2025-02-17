Return-Path: <netdev+bounces-166858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CA1A37952
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 01:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EC33A9520
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 00:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8ADDAB;
	Mon, 17 Feb 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OehdSTFo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF2C8CE;
	Mon, 17 Feb 2025 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739753913; cv=none; b=QQaHZG4NH8IJdOItj/4vMYxr51s8vmQi8cA6edXOjGoKU6ELJeQuyufazfYyv+pnxfQvabcBOtP5BzIhI+E+9B/7CGSP5N5FCkm7tZsbew9/855XnC/i8eOaXawWHrdDzIDs2hyfeeV0ntMY3v+Qg3Qk1XA4N2LxwYEFJg/kQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739753913; c=relaxed/simple;
	bh=Jp8o8qVhIJkaOVn8N2q451ecCoVBAtz9pozCbiQhoPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUz27Pz06A/v/kONO4itffh2DzDm9e6Q67OPgIhDsXYS6Qy+/+DG71kAdEXGOMaSHDQf8Dfv5MBlwVGUETebxyEkJQSNbMtmvVKyYUjpF32u8llDnQ2PICgu8lGqX5mC9bvJ5+7FOX/avBkLDpj4CnB7QpWBQGXP8zMBz45amVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OehdSTFo; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dd049b5428so32352936d6.2;
        Sun, 16 Feb 2025 16:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739753911; x=1740358711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXn7orZMrPjYfNUMRy6CXAqwRe5GzTPX3oZy/iJZ4Gk=;
        b=OehdSTFoA+x0qPeb1XdusX7gQiQUVmXwlVlkkefsN8Ak1ahGfcP8RmqjJfWJx6bMCY
         1SoMheek0W0VloIIUvDiWk2Yqb0OkIV9THZR5CH7EF/hs7jdJxs2m203GaBrlSnaPdfg
         t/c/VpOU/CUwZW+2/1J4/+03qm2J35hpaR5YSMoHEljDnzD60DLrthEjh0CjbDUnjAcR
         RwKUGwO8N4A+rNlL91FKVc1GlmxkXM0ISjEOkpMmGPpPfQwqTj8HoRBmlYw8eegEDl9W
         Nd9Wv8bD8ikyLwX0jXn7DYIb9C7JD1KsvjpYrBrjuxCMSsesnbKcOmzE10SJYAwTMeav
         3vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739753911; x=1740358711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXn7orZMrPjYfNUMRy6CXAqwRe5GzTPX3oZy/iJZ4Gk=;
        b=J4+4JJix7mlbSJMj1p+FNJT06+wB93zTh2+EopdztuayATRscQwwpxhlQ0nIPQ3BKf
         l13QM4sG87VFqg/73HqKyEdTrzD6/WD4Zlmtb8aPjm3WT1sZwZiKyaYAVOoDubTBnGT/
         A9qcz++jRh8drzAsvh7FwJVIUB+TktRX4TXkubxnfgMluaJQnrINlebeep26KvdpMQs0
         6ZDf+5XJOiSXUH+6MFpzPBVgj5Ig51BLqWIiPGC9TLG0Y02/Rq02R5fXo3f/u4XzsfJ5
         uzmKR131GqXc3jHNjZm73TVEiPLEVUnUtnIn6itnxJNBMAY8O9eC4rVSsPqOsQVHw+QB
         gz1g==
X-Forwarded-Encrypted: i=1; AJvYcCUKK3/I27Dilwopv1+0Ku/Y83Kpx02fsnzVSuQFs6qyPuVkrCQQxNB3pJeTb92JELDIs9dA2dTRz71E@vger.kernel.org, AJvYcCWR1abx9mXThjXYNQkMrL+Iy8qyOe4/551KeTNqB/naC3WFMoY/EamkHIbrh1ePkoXQO+pWJronZDZd@vger.kernel.org, AJvYcCXFEU2z50zT/fqo4a1XH6fVq7KRcMQlVl70zcb2T/gigRdB6uMBjOnBLGjpY+oCXuAPSTN+ZDWi@vger.kernel.org, AJvYcCXXvPT8W4AcQmLx0FywrGWk6Ih5FV/vVm1qO7HdHIHI5WDZcXcabNjBDpg9XiI9gFscaKQeDLg8yztWw44n@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZZ/F9VZknFcjSNtfPJxj01cff3Hs+ungPcoFgbgmImWD9bxC
	KCogGGBEDoxbmSRrVWz6hZqVXE7yF/F9wRD6yuiokBGWO37pSM95
X-Gm-Gg: ASbGncvgTsp9X91OvZ3E8jG0BJoJinVqwg7GREH58itNtPv+cj+WiV77CgdZ6jCzk2Z
	rzpDvH7pni6YtrmK384wJPuVuZTf8U/CbPH1BuWVeBlEEaO8WYhAaKpc+R8F2Jt2xMiB8WpTZ3o
	bBl625GKIf83BLH86pZeNWke3VnJFtqAlQ4RUvK6895M5uQYOWqzIYxyXbm8s3X5RiGx1UW6NWs
	shwxGDYIXhmgYsy8L+AAb6JpQ4Q3YeHCogWRJmX2y46hQKb0eeivVkmSakyAenGH5s=
X-Google-Smtp-Source: AGHT+IEgSQyQW3zA8QJefSJEenw/B9cty6/ifR4qhZM8XgSTbrQMgAJJkDUDnzQXeXhRPzlbR81NSw==
X-Received: by 2002:ad4:5fcb:0:b0:6e6:69d9:2bc0 with SMTP id 6a1803df08f44-6e66cd0dea0mr102261396d6.37.1739753911143;
        Sun, 16 Feb 2025 16:58:31 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d784e99sm47187946d6.28.2025.02.16.16.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 16:58:30 -0800 (PST)
Date: Mon, 17 Feb 2025 08:58:19 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Richard Cochran <richardcochran@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 0/2] clk: sophgo: add SG2044 clock controller support
Message-ID: <pxej4mmrhvfpvbj2mxy6zoa65tfqpxrkul5amebwjtuuebrixf@mzpcxq7zc47h>
References: <20250204084439.1602440-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204084439.1602440-1-inochiama@gmail.com>

On Tue, Feb 04, 2025 at 04:44:33PM +0800, Inochi Amaoto wrote:
> The clock controller of SG2044 provides multiple clocks for various
> IPs on the SoC, including PLL, mux, div and gates. As the PLL and
> div have obvious changed and do not fit the framework of SG2042,
> a new implement is provided to handle these.
> 
> Changed from v1:
> patch 1:
> 1. Applied Krzysztof's tag
> 
> patch 2:
> 1. Fix the build warning from bot.
> 
> Inochi Amaoto (2):
>   dt-bindings: clock: sophgo: add clock controller for SG2044
>   clk: sophgo: Add clock controller support for SG2044 SoC
> 
>  .../bindings/clock/sophgo,sg2044-clk.yaml     |   40 +
>  drivers/clk/sophgo/Kconfig                    |   11 +
>  drivers/clk/sophgo/Makefile                   |    1 +
>  drivers/clk/sophgo/clk-sg2044.c               | 2271 +++++++++++++++++
>  drivers/clk/sophgo/clk-sg2044.h               |   62 +
>  include/dt-bindings/clock/sophgo,sg2044-clk.h |  170 ++
>  6 files changed, 2555 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
>  create mode 100644 drivers/clk/sophgo/clk-sg2044.c
>  create mode 100644 drivers/clk/sophgo/clk-sg2044.h
>  create mode 100644 include/dt-bindings/clock/sophgo,sg2044-clk.h
> 
> --
> 2.48.1
> 

Hi Stephen,

Would you like to share some suggestions on this patch?

Regards,
Inochi

