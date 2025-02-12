Return-Path: <netdev+bounces-165566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E32A32857
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E15167916
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC84120FAAC;
	Wed, 12 Feb 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vtn/DO64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C0209669
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370360; cv=none; b=cDXfgaPob90v1NacEiTH7XNah57Dd83Beku05Tz+JdwQdquGIHLq+r9N8vE6ToGgyfMhn6QBiwPHdsFijBeRyuizfsfZDrrsjZBOovo9pcxDzjbjBxei0cqmxbGupiTqmDikNkPfNr1hI15oBSWZnIOSyVZz+5n/Bp6KyOyjJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370360; c=relaxed/simple;
	bh=zcXWaRkaJjCIPGBiscSo1i7xmvlzhcHiUj4mQZlyTs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4WUyzNhUtu10L6eR4lTxdYBL72iNFRon5yDhmnW4/r8BDuQqXT6iSw/D4K9I+m9R3II635TfD+Ntl+UgciA9y/srPB3uFuW9VkwckQ3EthWZA24/KOApvhXTd6Bot8gw90r09Ryxrq159DgNh74khTtPHnTWXz+J3864ZhH77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vtn/DO64; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2b85d1a9091so2238036fac.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739370358; x=1739975158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2hK7UnJXH2AprjpvtJDB1m2Emp+3eQ1LxgiiYwfIphg=;
        b=Vtn/DO64WhC+TTtZ0ExQ03Rc7Pg+W/ys7IXSxP+SSI3nFvBfEBM66FS6ke3wHqfUc5
         Z/UDOIzzu8FzfF2dzLFNDK837Rq3x4PVz2C0km8wytw35F71qmJgUAPOYnaSWR1RPBpa
         ZA0cfyAPfHGb5ZVZFZ7r9ZHqduW9zsBCKdR+FXSoHjN/biQvNNBTnj0XHq/JgJQZma70
         qQ5PR6CXDm/JZgw29vKnJIaT7olsm9jPic2NAp2IcdsMIKwXEoZVELEeOGgNWbVRAXmx
         iyzgtpHRSvAMVRsI0JzZ1QYlsVlvc16S87gapN92LGJHMlR+UxEvPy1rf3kKCW3gJ1i/
         2Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370358; x=1739975158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hK7UnJXH2AprjpvtJDB1m2Emp+3eQ1LxgiiYwfIphg=;
        b=byR+tPEaARBRZ9UIiB6jxfBiNqAIbXGPt9B2At5mmxXcMVA1uudWLaC2t8MXCZF7jb
         hrd3PpsZQkr4kCBIAY/vhQmWVE/M8B6/FjP8rjn9G25pNUZUoBa+AinxotTrKkaLm2rP
         O+YuvCAYabN7m2pOlkcU6Y+BNsmqiRx1JWQVHZptUwd9tCHPL8g2Z9kyFhUTgNeIc37s
         BqEjSTeU3Xxv0eoovdmcbatd0uTdYZVoZoZmkMzi0t+cMTdgXSVdcKTghMZpBkxVrKq4
         QOa5gk8+VQrBYbzscDixeQVwSg4wXH2KVDzG+yvc8d9quSwz+8DpO7DRx1xiHpIc1tEE
         M3gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbX1X+3s3kkfFQVEJvTfg/bVnCnwB+UpXut21ax2Zahtsio9JYVySJigXsFJzxeTXR3zPChvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy216V5xkjyJ93v9Wu8IDSWfVTZBoYjGB7OCuQ46hTCANv5iXwq
	+B4QGryYTVQBAL4jvadgQj9rBMQRjDlT/t4VIVOoX9u+czmGmFaDXHDn3uqUXV5XaiRgMxXMHO6
	MHVSEktS4sTSrG5YHp0by/l3f2DeHw3E8u7ZNVg==
X-Gm-Gg: ASbGncvWwD0QDzkLPahJseOyS0BVyl1/1/E51y5NFDsq0lPn7JcmBtL+dY6kB08p/rP
	9W6Mfjp8doS1YVDlmcOsTFG/U4Qp36wEPRBWVdYuAZ6N11S0E5LD7nsZP2pDWcm3exi5zlyywPq
	tkfc7aV6VCIKeEnhGkE8XXsK0bSlI=
X-Google-Smtp-Source: AGHT+IFuyxlXlPs2e+IscY2DSB/6uY0nP0Wzf+ASbJ4AIZ/oWACpaja7G9+Khx0xEQd/fq0SR42vVSonovhGGFkMhb4=
X-Received: by 2002:a05:6870:330a:b0:29e:5aa6:2bb3 with SMTP id
 586e51a60fabf-2b8d646fb44mr2246018fac.1.1739370358095; Wed, 12 Feb 2025
 06:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>
In-Reply-To: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Wed, 12 Feb 2025 15:25:21 +0100
X-Gm-Features: AWEUYZn5XLF6zTakIKin9eoC74sCw4in5MQ3He_rxkMU8G3y_yrGsz2-CkgeaTQ
Message-ID: <CAMZdPi8pybqtKQq9irxwGwvW9y3EC=g9XkbZ4hthBkXQRUxUDQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: wwan: mhi_wwan_mbim: Silence sequence
 number glitch errors
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 12:15, Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> When using the Qualcomm X55 modem on the ThinkPad X13s, the kernel log is
> constantly being filled with errors related to a "sequence number glitch",
> e.g.:
>
>         [ 1903.284538] sequence number glitch prev=16 curr=0
>         [ 1913.812205] sequence number glitch prev=50 curr=0
>         [ 1923.698219] sequence number glitch prev=142 curr=0
>         [ 2029.248276] sequence number glitch prev=1555 curr=0
>         [ 2046.333059] sequence number glitch prev=70 curr=0
>         [ 2076.520067] sequence number glitch prev=272 curr=0
>         [ 2158.704202] sequence number glitch prev=2655 curr=0
>         [ 2218.530776] sequence number glitch prev=2349 curr=0
>         [ 2225.579092] sequence number glitch prev=6 curr=0
>
> Internet connectivity is working fine, so this error seems harmless. It
> looks like modem does not preserve the sequence number when entering low
> power state; the amount of errors depends on how actively the modem is
> being used.
>
> A similar issue has also been seen on USB-based MBIM modems [1]. However,
> in cdc_ncm.c the "sequence number glitch" message is a debug message
> instead of an error. Apply the same to the mhi_wwan_mbim.c driver to
> silence these errors when using the modem.
>
> [1]: https://lists.freedesktop.org/archives/libmbim-devel/2016-November/000781.html
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

