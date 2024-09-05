Return-Path: <netdev+bounces-125512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D2396D75D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91DE1C22B5A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1355A199E9F;
	Thu,  5 Sep 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnhg0Bb4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54464199E80
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536406; cv=none; b=ErXKfQFcnlnzWyUNQ2vAsv1s6QtYrN+zn0A6Ll/WZRkzucAmnKgAE+UyDSVOfAQlhdxq37ygHwxzWHcuRsKPMa9mbCPPmOSSh+KKBv7u/+2zIqCda7l1FB+VeO/bVs7EuzqB0IUSGX6QSff6FnABNI+aushXKr7isbCYQUNlVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536406; c=relaxed/simple;
	bh=zrVvUahKZA1Ly+gFFCpv1OrY4hxvtMfOO87dPXkzcrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1lBbc9dyAnrikYMrYe8cNpA7z7ICEeeII6xrMZml1IwiMJZRQvvXK3CAW4Qreeq4Rs2gOz1gpjY3eYqq5ErOefP0uge5mdjn2jG8QnwR7WlA4PPt4w8VpJu7KKTvUVmmKVvm2gkcSrABujkgancmzl9hoaxDCa1fr9sbXrJsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rnhg0Bb4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5353d0b7463so1000861e87.3
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725536402; x=1726141202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrVvUahKZA1Ly+gFFCpv1OrY4hxvtMfOO87dPXkzcrQ=;
        b=rnhg0Bb4ttm4Yx1kIQrFVRXhXF3V0gqGlfHAA2LxxRYAL+gQM8mpw0XP1Tc3PKjUpw
         9GCOPrdY6BAVdRT7Hq+PGSXTt3nKAVcGxZtSmilfyq6MHo/E0Dmr1aNcKYyMO83L4+Vd
         t4HJkeRCINjEEchOZrGGoEa3A/wqLe71wlLakHxm7lKqxNnLVlXlbX9UMe1kOfg3rbct
         e3V8YbEsxR4yEvFnvDSVV5loUzeYFap49xUSGL0lKz2+xt70ACxTvHS7Ky5s3IzoGlcN
         HaeyyxZp3W7ewMcCpXFXwYPVHF+Eazj0EonDroz9Lwuj1Sj5OcaVTe8I29DPPI1qMp6k
         8Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725536402; x=1726141202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrVvUahKZA1Ly+gFFCpv1OrY4hxvtMfOO87dPXkzcrQ=;
        b=gwdQUVaKi1LgSuBfpIgAAW/ve/eb+XKWQzTHw4by1ZgDBpgLkcPv4iXjHTPGmT6Gm9
         iv2wMZKZMIUEKXP6DzHeTEKz4/XBG50xOday2L/HyQVuRlEE7OcDXI3hIAEEAsqhEzYX
         0nABZjlmiKIc/vT8V3RIq4FD8Ws3qhBMWPFy4h+svJDd7FEdhYyCtEOWZ6w+dhvUyxsS
         iorkv38Na6Bn3VMYMH812yQGoWKcs7C5hNAYiAErBhoNorlW3/r440DfZd4fcp8i0n8D
         YbbAb7PzP8ybCs4MWufAwKXHRwFrd0LI1yW72AvAhfAyFoKIwakujtWxCEDJ5JrLEtDc
         hpRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs0LFviwbgqz45ROJtpKLMSQCCRGsxN3Gn5PLUHRXv4XXnAZSX2UB4N/l5/nVQQuEQDDPprLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7Sj0wD3t7isrZgzz6ODo8QTfrxQnYwzCbK07kF9UAOpfBeyo
	j6ywkRRSveAUTQX0B7vMxBshLTXrMt6GsxvnmXpbQiI+QGzzUkeg8VJcPycrwP1cZdekEwcWA8A
	oSlD4w5Wc9t3IU1tJ3P3RUpbag1cjhBF4tWfOVg==
X-Google-Smtp-Source: AGHT+IEwZ/cUzkI93E/6LKm6cGyhHb8XA9AkNg8OpqoeSXVfyucD7/JsivArkGPITQJzkXL5zLtM+8AMY4ZU3v65zm0=
X-Received: by 2002:a05:6512:108b:b0:52c:df83:a740 with SMTP id
 2adb3069b0e04-53546b54df6mr16785064e87.30.1725536402123; Thu, 05 Sep 2024
 04:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902225534.130383-1-vassilisamir@gmail.com> <20240902225534.130383-4-vassilisamir@gmail.com>
In-Reply-To: <20240902225534.130383-4-vassilisamir@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Sep 2024 13:39:50 +0200
Message-ID: <CACRpkdbjUe6aM0nHvEEEWaT1AG9kieiUuTx0M6G12Pnsvgcd6w@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] net: dsa: realtek: rtl8366rb: Make use of irq_get_trigger_type()
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux@armlinux.org.uk, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	nico@fluxnic.net, arend.vanspriel@broadcom.com, kvalo@kernel.org, 
	robh@kernel.org, saravanak@google.com, andriy.shevchenko@linux.intel.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 12:55=E2=80=AFAM Vasileios Amoiridis
<vassilisamir@gmail.com> wrote:

> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type(irq).
>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

