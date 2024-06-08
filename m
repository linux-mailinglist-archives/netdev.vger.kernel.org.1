Return-Path: <netdev+bounces-102032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0107F90129D
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 18:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43071282F91
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32EC17B427;
	Sat,  8 Jun 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSf2rYdz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52C17B411;
	Sat,  8 Jun 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717862296; cv=none; b=t/Uh1C3vsWUblVngS3URxScO68j+0y94MjyFOvhHQXFaWFaQPnUQR5abkb8HcssKxYqyrac9zKS4tYv63TbDpd9cjb94PoCq/Pg1xR5wdaqqyI+HLztVWTtZnMeBkVU9NaEnMLDHdRFPwTU08pkEN84mHQHUj64DsKcNJQEVa0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717862296; c=relaxed/simple;
	bh=GxZ4fij4mVUARHtBye6BxKbMg27/PfglqxhWb8ZY9i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLsKi5TfWLgfDfl690jaVF/3YDHXuC9fB5rInhWTdnBuA/E3+d0UB0xcuZfosvt3bMVz+sqfMVS+Ap/AQXtQSRZbFV4YB1ZUJxgNtSoY0Pu/J2EBPLNCGFsTEQmIOy7kXxbKO0rDiHS7xa7mMESkaVg5DBslXMrh8dlPJ8R3oYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSf2rYdz; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c6afa1839so362437a12.2;
        Sat, 08 Jun 2024 08:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717862293; x=1718467093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XyzI0WQ3X5zI+IJy55iWPtVVJ4faSHAnX9GezP/s9dA=;
        b=BSf2rYdzwTJjYzDxAyv3eYt+JOPMOJ5VM7r8DE+wJMVnXt5zrNgcgTJbLQAZIHEXr6
         jQ+6FKDMEElbZgpPB+U6XjGBx3sYPyfRB/bac5HvDTA0abchXSV6cmCHbVkH1mcGNhHn
         jYFFX6tVZIOqxyM9K4aIco+LhBMNrFqMb3cfTI7a2DPmAqxAfv+2HQ8mjaIyoSKCkpwm
         A9QugOxE/i2b6DQsIG4DCzzAAMzlFLLgYc+slsE0a6JbCfhVLLddi5q74AW1FKlLkQrW
         9QHTMVF6DUgsiYepdapVhBp4v5Ws0/hOtRJWDPBHWVl3h7DkzQR6plHXFSwbKlqpkXpy
         R1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717862293; x=1718467093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyzI0WQ3X5zI+IJy55iWPtVVJ4faSHAnX9GezP/s9dA=;
        b=f3xp019qe+teY6T3CMsvMbIn1iJNxwsz5AiB/6VH8LJr7z86btAbyIMS9zPJvFGngu
         Dvgm15CDAk+iEpHzLtEyXM71QcMRBpLGCHqCAEC5tMC5JOu7zNo4dXCeqyJr6Ebitm2+
         akQyHiZEFPx+B5p+UDcpJgzAEaPe0I/gGVK2DJoob1qxa4vx2KBrEN5J+Xh0jWM/WNHG
         5KFu8gR1wddsxWHAFSUE6NsUKfV3zBctywckTb9y+9JH8DaG5WonS06s0Y2hVIgnISPw
         BSIUsVMH1cU6T0pQigpHL3HOVOjd35NWCkcKNHSisAL2IXlRQhWAy6GfDcdQeR130Sbo
         Tr6g==
X-Forwarded-Encrypted: i=1; AJvYcCWd2dqHariJGG/gnJIi4hKeQYGPSDaBk6TTSrBq+N4o2v9Mki+juM5iRNawnBXbmGklVxt7QmJARnme36FSBWrd9kUR4l21QDDjIcIn4/BqM99Y7YJFivuhWwa47sBbdkPrQfH4
X-Gm-Message-State: AOJu0YyLlq/Uzph5m9Ag0T/d0u8j5Cu8IeXqloxz2knrnJx8yl/dUzR3
	PEb6ar6NEyEG1NFLo0GoOdTJ0RlRTP3aIwn1JMZJrie++6HSBPz3LfOwpVi+oZyJnGTvC+HGB4v
	LXBURE+xduu/Lg2IE9DW2fhex+6g=
X-Google-Smtp-Source: AGHT+IFUJvN5ap7ddufLT8K2gEMRRgmu9LzavhRK9OZ2aGcx+J8/6xVP0Nxf+xpkOh6TSfHYVabtZ1Ie30YJ9DAtMm4=
X-Received: by 2002:a50:8d5c:0:b0:57a:3046:1cd8 with SMTP id
 4fb4d7f45d1cf-57c5085eb2bmr4230851a12.7.1717862292888; Sat, 08 Jun 2024
 08:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607020843.1380735-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240607020843.1380735-1-chris.packham@alliedtelesis.co.nz>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 8 Jun 2024 12:58:01 -0300
Message-ID: <CAJq09z7XGgLo=JdyYfLu8D3W5Sh=wu0K83LK9KmUU0VRWPNyLw@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: Fix typo in NET_DSA_TAG_RTL4_A Kconfig
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  net/dsa/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index 8e698bea99a3..8d5bf869eb14 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -129,7 +129,7 @@ config NET_DSA_TAG_RTL4_A
>         tristate "Tag driver for Realtek 4 byte protocol A tags"
>         help
>           Say Y or M if you want to enable support for tagging frames for the
> -         Realtek switches with 4 byte protocol A tags, sich as found in
> +         Realtek switches with 4 byte protocol A tags, such as found in
>           the Realtek RTL8366RB.
>
>  config NET_DSA_TAG_RTL8_4
> --
> 2.45.2
>
>

Thanks!

 Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

