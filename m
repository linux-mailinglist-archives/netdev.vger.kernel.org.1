Return-Path: <netdev+bounces-124140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A63968456
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC079284113
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40C913CA99;
	Mon,  2 Sep 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUQeysSX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8DB13CF8E;
	Mon,  2 Sep 2024 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272083; cv=none; b=snH729pLXnvXdA7W8x9on5ikWldPO3Rs36e0T+j7JYXytnwquocJ7iCJcb38livrQcZTVi72GbPD8mQmkbAscBbeDZhP7mlgfzZAVQ62QIMPybwkoJ71eS9oBn+vdLCq1KT00P5wwF8QiCtE5MPNrKmrqxro6lgotKEFk2HUPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272083; c=relaxed/simple;
	bh=6tWzR5l3QIcJICcz+JZzUP0NIpFUx7KuwEYELN+uyRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1JcwxX4DyjJ5E9WbP+opFJpof52jtDYDX/3PxLZR1bAj8jHOLsGr0OGyviSvCHcOq82W7yEZekJSSFSp1Af+PO7aX2ZZ+xWqG2qLJZze//clf2lXxTy8xTkoBl1LWIRNRlhegyHayi1/xFhMrol/F5ah088/GpGGqzc5UYj9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUQeysSX; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2780827dbafso125874fac.1;
        Mon, 02 Sep 2024 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725272081; x=1725876881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RSrUV9tFD0oMrqEbzZElVJE3TtG5N3TjNftZoK6Fh7Q=;
        b=gUQeysSXplWgk/sr+aKrm9+LMbH3VafUqi+Otv1SYfRLqYweDLQADZ9OdtlqMS1a/+
         0xdCzlPzlvWmGDLajIutwttGDy+GSRWnRbs2hWQxY0NLc/UHZQAzquEDHxrPPKyv6nb3
         S117pYaMX6+0J1vVORzDbIkdOBf05B6n04X1qN2BFOxdpsG59G24PQfzLRBrgC6yGXeK
         A2jW3TFc4rjS8vXlV5Kq9fcyzmyLzUiPIDUUwiuU/MXE3bnB1aic+SGEQjvtXRATqadE
         ovhkhcJHiQXDXW8ee+p+qOSRc3P+4tg4VXMGZyQp4hFQYWtEaAlef1KEpmii03kzGAxa
         T2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272081; x=1725876881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSrUV9tFD0oMrqEbzZElVJE3TtG5N3TjNftZoK6Fh7Q=;
        b=kfyi3Uz+3oC52Lub102x1hO/qQnKeJfxDAnP59wXX8lLXHSFTjxE3esxoaSA8YM7Tj
         ntRo4PpOSKNvNe9SGNKqs3plyP4Im2hVT0iSi80ua4Dwt7qggUoDNkbebPEKAyu6qDNH
         Yew6odJmxFJvoQWxR34p3qciE93IcBgTjtY0hog1Z6qr5ZJErL1AAdYuVcu/U/90wj1O
         jF6H9gE9MhKpMVRsExja92OcEj+lPRpQirqtsqyrVCidkKa/RzvXrl3DCXD/CX5lJ8pe
         5ZKepvGu9RyN97tissJ6YekLln2I6s0frIonIsv4K6sYpzMq9v9DEQ8cHTWP3FmIn7Uj
         fKZg==
X-Forwarded-Encrypted: i=1; AJvYcCUCLmwVC48U8mU62gW3d9McO0SxdbRvCiBD3FCKttFnHBJxCUyJDvnE+RSRlbJO3xThF9Bz0u01@vger.kernel.org, AJvYcCUUqjGS+K+QW4zs1rDXyVY1l09Lt+QZ2wmp3c7dQjKbRQlrWjH/PETz159zlOjxPTb1K/AdH8A5QBrB5UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSoHnKAtnBUNWgfSHQ/XjRFg7vImVRsadvVjwXCfKsF/2yMObZ
	BDXMaeIGPu5D+X4+vxLDcN/jdjSjhtPwzGQUGAe3X3nPwaNZeCr5ZOBjzefw2LD4dxW0t2prLbc
	w9CO7BS7as6d3y8BJySHEFi049+inSnts8SqJlyEm
X-Google-Smtp-Source: AGHT+IF9NN3xIfqDfBxyGh7JkJLSRx4yNr19cCRvImvVrnRDzzmjSmwm4StEuhUc9+0sIXJRUgwxwwDQz2C36RHUZbA=
X-Received: by 2002:a05:6870:ab13:b0:260:e678:b653 with SMTP id
 586e51a60fabf-277d06c890emr7284825fac.42.1725272081060; Mon, 02 Sep 2024
 03:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830141250.30425-1-vtpieter@gmail.com> <20240830141250.30425-4-vtpieter@gmail.com>
 <efce22790603dff9cff21eaf39f74b6a4b5d4a97.camel@microchip.com>
In-Reply-To: <efce22790603dff9cff21eaf39f74b6a4b5d4a97.camel@microchip.com>
From: Pieter <vtpieter@gmail.com>
Date: Mon, 2 Sep 2024 12:14:30 +0200
Message-ID: <CAHvy4ApNq69g9edtmgUne4k+_P5T0xYOS-WaL5QWZin50+MMrg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: microchip: replace unclear
 KSZ8830 strings
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	linux@armlinux.org.uk, Woojung.Huh@microchip.com, f.fainelli@gmail.com, 
	kuba@kernel.org, UNGLinuxDriver@microchip.com, edumazet@google.com, 
	pabeni@redhat.com, o.rempel@pengutronix.de, pieter.van.trappen@cern.ch, 
	Tristram.Ha@microchip.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arun,

> > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> >
> > Replace uppercase KSZ8830 with KSZ8863
>
> Since KSZ8863/73 sharing same chip id, replacing KSZ8830 with KSZ8863
> is somewhat confusing. Can you elaborate here. I believe, it should
> KSZ88X3_CHIP_ID.

I'm afraid there's no perfect solution here, it's the only chip here
that can't be differentiated by its chip id I believe.

The reason I didn't go for KSZ88X3_CHIP_ID is that the enum requires a
constant as well so `0x88x3` won't work and I wanted to avoid the
following because it would be the only definition where the name and
constant would not match:

--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -27,7 +27,7 @@ enum ksz_chip_id {
        KSZ8795_CHIP_ID = 0x8795,
        KSZ8794_CHIP_ID = 0x8794,
        KSZ8765_CHIP_ID = 0x8765,
-       KSZ8830_CHIP_ID = 0x8830,
+       KSZ88X3_CHIP_ID = 0x8863,
        KSZ8864_CHIP_ID = 0x8864,
        KSZ8895_CHIP_ID = 0x8895

Technically it's possible of course, which one has your preference?

Cheers, Pieter

