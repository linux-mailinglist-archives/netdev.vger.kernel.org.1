Return-Path: <netdev+bounces-250339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0E5D2905A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9B8B301636F
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F93032AACD;
	Thu, 15 Jan 2026 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTpB7aly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1509328605
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516199; cv=none; b=BnG4G4ScAYHSOmwWnexCRwVn0LQph5wvfnFvCl3DmdOt57X1FLsgUzIsu+rQoA+qFB17XyaWv0zdt+Q+2Hea6DkVXEykVBGnbLUXHn95A0TeoycfiwqJwSv9CVznMT8nuT3+Uigql0/WGVrv8Iyg7ZWjoAqDxlZV5T2nubV1rpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516199; c=relaxed/simple;
	bh=vSAT1AP1JJIbCDoT48GuJjdNmp0gbOyUNgv3GnSj4Io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIkdImbQ7p+Lqyt9extolPPYNWj92jbUDxavuAo4+nUAtPmVKbHjRol29av7OnEKN8xOUKhN9N9CEkSKHsQq1GraXP4co40clSSfgosvbxw0ktUg+TpC7Jf8soBIE5LTJR+2R3NwTliXZx08O3qWpmy2Qmp6vlzEcEgfZWdag5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTpB7aly; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso9674485e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768516196; x=1769120996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hf4B6fGP4oFjPT37meJREuj990SvUGPD1AZa9THo2ZI=;
        b=ZTpB7aly1VVyD7KaNo2jPOHhY0R6k/lVLK8wzGeWZ1m/cjSfZmwjUpuj4Qef+Ii/GA
         ad/e9KqNuvwwXTk8VKtbfIf8oa9dlMKbqyldfoaN84/hNEGjDuNOv6UTNZv8htlEXke6
         oMZRqc5lDbyshC/eD/7uSCgFXG40gR/WdPtihjCMQ+94QuSpxySINUJ8KC8iwmCpKqd/
         hlhGkKTXMslqZ1CZttMOFic79+EiEIL25Up285bB9orwnAXf41Tt2XFfuKGwHRbxsmb8
         kTA8tEU4fEdzBfgIrpPKypH4GtRAUumOMPSELFBjmeW+YyGvSWR+Bcx+0MEvLz1/3Ki/
         BamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768516196; x=1769120996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hf4B6fGP4oFjPT37meJREuj990SvUGPD1AZa9THo2ZI=;
        b=t91syNjch0A/P8Qt+eTPuojTtTVSHxvEJE8QR266q/QsC8Ny6e2UsAXK5WZQR+G+/q
         rUSBaeQAeyY4qlsD8IdzfpRs1DR0vNk877nVfgtg4LwtNqkfZBmD3wk5OciWmhem3k43
         qgZiJNe/QLPU+EBLT697o+ILUhE15+Y0fmlBczSslI0Hq0dBgk5+CVXodbNexmod51Ya
         C1Ks8+IuLIN1ilY58IDXGjhcVEVSVcQKT3/UkT3hWQYbUSQrks/rSf+ph6gqL1Ha7KCg
         tVSkA+HNitwiJ1QPJiyYPyT2mdsCFjSADjZaMnq7qMMiiaG6YXWWqE14JsQ/vwIPXdYS
         Agxg==
X-Gm-Message-State: AOJu0YwhQXe1krh5UZn2qlX2IeoxlTquFMd0AmVDCcIBXf1LizfUYp5Q
	AfHXrI2XqcyzTrSVKzCnkSSAJPfz/g7EHaNDGrVPATVUtw2SZalyfl/0
X-Gm-Gg: AY/fxX75tqSuUfu+yGRqpySyKlAJsMjnO0vUlXbjDtQlrCTqu0tZ43z4ooc03DDSr7v
	jQUEWh3XlwV0CRgdF4CDp9Qz0X+VBBOltmc7De1qHr3G/gLCLmWI2Tejac5i7F4cff42Giga8w2
	FJBqYpj8/3Zs7YoOiFjBwNlsB6L5eXNSetRQsyZoMt+y0CeBz9a9F4Eu4PUntj+9z3InDEBfArv
	3Tu8yrNZqRAJDM1AZtqfjFfua53dPaW6tVcuxminOZDNK4N6g3v378TsT9noQUP+UNBdX/krtyd
	ypkmwMKLayGMlvttL55FRDgdZnjJKaQd2rRvw87VvdSDdaTsavlTC5/kDCxWlmuNMNip+HwLCZw
	qOYfQx0a8A3U2e/8WNxKt8HubT4TSYS9BPZi8/ZX3y4Wo4bs2dhBa47OZK3Q/4y8ifdZRDOZO2a
	1geBu/xPzxibGNDwd0dXa+BOb1a4cigqnI3IUX8F9DfVNeI1uUm61hZpm5IFL4kvY=
X-Received: by 2002:a05:600c:3593:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-4801e547d1bmr11557645e9.8.1768516196010;
        Thu, 15 Jan 2026 14:29:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e80c477sm15938445e9.0.2026.01.15.14.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:29:55 -0800 (PST)
Date: Thu, 15 Jan 2026 22:29:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] pcnet32: remove VLB support
Message-ID: <20260115222954.248e9f79@pumpkin>
In-Reply-To: <20260107071831.32895-1-enelsonmoore@gmail.com>
References: <20260107071831.32895-1-enelsonmoore@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 23:18:31 -0800
Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:

> This allows the code managing device instances to be simplified
> significantly. The VLB bus is very obsolete and last appeared on
> P5 Pentium-era hardware. Support for it has been removed from
> other drivers, and it is highly unlikely anyone is using it with
> modern Linux kernels.

That device bring back memories, but only the PCnet/ISA and PCnet/PCI
variants.
IIRC both are basically AMD 'lance' ethernet chips with a built-in
bus interface (the ISA one is ISA pnp).
So have a limit of 24 address bits (I don't remember using a different
ring format than any other lance variant - just for the Sun HME).
I don't remember anything about VLB - just ISA, EISA and PCI.

There are two variants of the PCnet/PCI - the '790 and '791.
Each had its own quirks, I later thought that the 791 might have
been intended to support 100M - but didn't work.

The ISA variant needed one of the ISA DMA channels put into 'cascade
mode' (the kernel didn't really want to allow that), but was about
the only ISA card capable of saturating 10M ethernet with smallish
packets (IIRC in a 33MHz 486, but not the similar 386 box).
(And 'fun' to set to fixed IO addresses on a motherboard that supported
ISA pnp for a kernel that didn't.)

One bit you might disable is the probe_vlbus() code.
You really never want that sort of probe code, it can have a disastrous
effect on other hardware at the address being probed.

I didn't 'steal' the green datasheet book :-(

	David

