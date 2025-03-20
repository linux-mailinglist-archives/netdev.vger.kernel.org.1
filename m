Return-Path: <netdev+bounces-176563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A5A6AC99
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247D2487D81
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BC722759D;
	Thu, 20 Mar 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLqs93Zz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3E22758F
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493606; cv=none; b=ESIMBrzz/yO/ah3UWsoVtb6zqr+WoxOQ64D5uipLNG3bNjZnMZAetZFMw437FKoir2G5dVDeIILcWbc4qGq24fkt9elWcPygHnMoq7M8daFoBECOAlJs0at06a2LJqNExbX0RwXII27qBmKeF0iVuVOuCpDePjwpye8YyBr9xfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493606; c=relaxed/simple;
	bh=VeEeR469sj7L4GRpXvMt19V8ohmjM3e2pvyA2tz/Sh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRiPy9C9P1O5IQtpH5yj/9JGzoJkNySl1M6unSnlok7LATeZj2IKNhuKw2H8zOAgH2ghjHtfeMp/trIFGZ7EsbwYk34jXoo/hrisJ5IBtndBdmnUAJXoGC8iEDKBbtu1JFAHOaf8Yc4BIlNckwW5XVbvjDIBYZA69IbfXmo+rWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLqs93Zz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240aad70f2so27315ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742493604; x=1743098404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXL0k0DZqQ07N/e8NPA/s/pW9MUWCeBqdqXSku9l8Os=;
        b=LLqs93Zz5A7ZJimmaaJEUs+BFqbrFrbjGibWW+LC3rwt0n0aExNuZEQ30mdySNkGSr
         TSevtd3x2v4qDhIjSEV0XE96lR8EkavwZ+tCpZmpcEwtT6pxYl+4usrdPwOy0Iq/MK8V
         B4e4JnM/Rz7TnNNiK8S4dOOCtJKNyC1za4C0+f28uR1xYTcjnevN/pgUuXbvpRg6QdOm
         lOmarRTfCgn3DMmvdShyU1/vxbO6UmIvGY8VQKevuz7INwZHhppmHp3/vODDNCzT0odZ
         wDYVPzBFvGzJIbxVXFLpxX4JVejlXeccqzkR0eSvpGRemRoYIx+YBFIdV2slEhGY8MQ9
         vopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493604; x=1743098404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXL0k0DZqQ07N/e8NPA/s/pW9MUWCeBqdqXSku9l8Os=;
        b=UjfSLesy+G2kmZVphAC8PdmgUUjjzjapI1ScWSDAxbnCujOo6GbDwhK35jthSdn5RM
         54FilGkUxeIjgtjPJWVaqiJ2vJdtLM5GGFFIz+vebfD9RIkVb7K22hWQJh5ni6YKH1ad
         sO8iU4WKJXIzOTQjfLj6VxJTrcJb6P//YYbLiXq7ydBUNHP6KZOlne3ia3oG0z7QIuq5
         ENPITBAwjOtD59wOtLEAKa/8Z42JxarbBMkjFORJMba7srbJerYrmMdYDmmUX+9irTcr
         efn4Yh4QHCctGgiKVZWFeWOaAD7RI0UQ6j8c6g++sl/ylHKmylNlNsNkndTesOAxbtHz
         7d+w==
X-Forwarded-Encrypted: i=1; AJvYcCUw3wiF+lbS1bx8Vz+cH6QonarwwmJUGwZeonLSzNHp0f8map8sTQsI12nYC6gOsRTy+4jzMZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEa/4TSRcHemxLZ6WOpIIHMJnoUGzdUt0CRd/nie1zZiD5Xdu2
	CtMNkdlyiIAtYyLOuEnDfAF5ZkhHSP/QtymMw0fu5ZQmWCG2mAxXH5yA0tXRUOQd6IrHX5hIj6E
	W+p6RFqPZOLlOF3qUAbfRXgQXVBui/G27aqHU
X-Gm-Gg: ASbGnct/jo9Tn49qKcUAqzpC4y5dL1v3RPtSQRii1YWhLmbnX+XkwScH9uL5ULTwflW
	DDMnpUQL52zSzoJQBkghLLHEShhinotLMl4s1DPEfP/bYpN04VRCw9zhcJtjthA+qRi/hgXuUqe
	oB3lO63nwbgf8nlga9lImBUV5eSeI=
X-Google-Smtp-Source: AGHT+IH57DH0GSZzyJh8T8Bgi35URSrHKvYal863TDyoHEw3Y8lB3ymGrCjzzE1JAKvOQ2Uv5lZf9PKiuo8MDKtuodU=
X-Received: by 2002:a17:903:1744:b0:21d:dca4:21ac with SMTP id
 d9443c01a7336-227819e9b92mr168015ad.6.1742493603418; Thu, 20 Mar 2025
 11:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318061251.775191-1-yui.washidu@gmail.com>
In-Reply-To: <20250318061251.775191-1-yui.washidu@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 20 Mar 2025 10:59:50 -0700
X-Gm-Features: AQ5f1Jpx5oaTubkkaiHB-p1nUhcKkWHhsLFCwXVsZ7-aKeMv73KpkrWBcKG-6qY
Message-ID: <CAHS8izNn+D=E0E2y5-gCGyyKSJgxTq63K-kthjFCwhQd_Tw0tA@mail.gmail.com>
Subject: Re: [PATCH net-next] docs: fix the path of example code and example
 commands for device memory TCP
To: Yui Washizu <yui.washidu@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, sdf@fomichev.me, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 11:14=E2=80=AFPM Yui Washizu <yui.washidu@gmail.com=
> wrote:
>
> This updates the old path and fixes the description of unavailable option=
s.
>
> Signed-off-by: Yui Washizu <yui.washidu@gmail.com>

Thank you, I think when I updated some of the implementations of
ncdevmem I didn't update the docs:

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  Documentation/networking/devmem.rst | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networki=
ng/devmem.rst
> index d95363645331..eb678ca45496 100644
> --- a/Documentation/networking/devmem.rst
> +++ b/Documentation/networking/devmem.rst
> @@ -256,7 +256,7 @@ Testing
>  =3D=3D=3D=3D=3D=3D=3D
>
>  More realistic example code can be found in the kernel source under
> -``tools/testing/selftests/net/ncdevmem.c``
> +``tools/testing/selftests/drivers/net/hw/ncdevmem.c``
>
>  ncdevmem is a devmem TCP netcat. It works very similarly to netcat, but
>  receives data directly into a udmabuf.
> @@ -268,8 +268,7 @@ ncdevmem has a validation mode as well that expects a=
 repeating pattern of
>  incoming data and validates it as such. For example, you can launch
>  ncdevmem on the server by::
>
> -       ncdevmem -s <server IP> -c <client IP> -f eth1 -d 3 -n 0000:06:00=
.0 -l \
> -                -p 5201 -v 7
> +       ncdevmem -s <server IP> -c <client IP> -f <ifname> -l -p 5201 -v =
7
>
>  On client side, use regular netcat to send TX data to ncdevmem process
>  on the server::
> --
> 2.43.5
>


--=20
Thanks,
Mina

