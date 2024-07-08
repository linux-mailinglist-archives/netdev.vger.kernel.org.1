Return-Path: <netdev+bounces-110053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664CC92ABFA
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 00:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A9F1C21F06
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9853CF63;
	Mon,  8 Jul 2024 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="wiQdq33/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763C479FD
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477181; cv=none; b=J+RqAB23xMDwasvkkTsxIBC6Z2sNR4VVOCIFzmM2sImjBgiEFNuBAvExPKF5b1xdUY8Scm6SVoxTVa5uvqfTORBMjA7QwIHYsi8KHmzVVcffoIL17ugCknPIEnB4Cz+PaDoCM9U7viwg2no3mrIgVplwgEaLft8LI6Q+ttvuJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477181; c=relaxed/simple;
	bh=1LmLyvqzAPtt8WUQXm9wHeSSmhq2IFSC76HkHIt4AsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLgEoHUfOB6DfW9zlRYac95Iu8cBm00V8RZ7BWc0l31G+ctetOsM5W60bDhBRdxznQ5x9JqZuyXOer3C5wfNxPvhGYDVBU0kHiL8c0TSYP5UuvnXUXMi+C6ZPC4CTgPmV8O36Expr4JCdjImocoJTEHvN+ue3IH1TK1SeD9ApjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=wiQdq33/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af48692bcso2743263b3a.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 15:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720477178; x=1721081978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+j/fJz9jGxnXmxiiU053bF6Podrk7Fq13EE93KKktlY=;
        b=wiQdq33/E+fqyCKt8QpoqHVJ+5cgH+k+Y/P9fnz3lAuKrm9K65BjpJYR+9PJp3Ab3p
         XJen3flglAOcnUIwuBN/D34PTdP6g1B7PfWqFLh/19iOsBfKePWs8pivzxjaUZqIqupT
         390lNlWrxhNgSN9ykLg7Lp31Rq0yrT/oCglsOkZ3UmujyG5EP3AIjLJVH01mWTi9pPWb
         994BRQZ2NcXMZBVnsOE9T9ck6e8v1qzloA9UQIO7DNoRfW9tepfs65f4/YYk/Xj0g33u
         qaz78PavFFuDwA9me2Ab6DLfhLpF8ftaQBDsRBs4YXt2GvVToXMQyGJ+M7xbxdT+cnae
         IQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720477178; x=1721081978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+j/fJz9jGxnXmxiiU053bF6Podrk7Fq13EE93KKktlY=;
        b=cB+D6crxR/NRqdcn8aiqRikkbdwOP4M1lvJK9q+bFrBjTw4UXrJp3U3BwtXjOKyZve
         AmCpT1mCyKhC9m1yjLqy99p9bu2IeZHHPFemQsa0ohEH4Si1WUQ2zaEed501IEPe1LEY
         zfvCrQL5djkSSb5V+pGhfw+a/kc5clIUZ3uhXLBwBFiuB0NqQtAzxwm13WrXBJMxVWVa
         I0gtW3ti+TEQq7iHTF9M2PxHn8gQ8mNEFIkihVo3+Xs9H8oCR3jmWVBhd5IkC3IQCZBL
         8fQPMEJDYtQ6Yh1r3QGhxI73KfHk2X/9lgaCJiszfqymJDnS4i9+Q7825sLhot9t7vUc
         R5fw==
X-Gm-Message-State: AOJu0Ywf2ImqgFyaYJY/oe1PgBAmtMByVXDr4GSeCWSPC2FWHLW/UpPL
	f4H0gBPb8KhLrOPOfa3p9eevUnVaregUjKKxKxOq6K4U08SUNvO7HRZqwNcuTWS4gWpBxVg3v28
	BPns=
X-Google-Smtp-Source: AGHT+IHVg+TlQ8T5PH5yd74Nddt3GGOwyEIjiQsDQs+6E//rQTvcFPJsH1qVU/ddSl+eJtkJ7eVZew==
X-Received: by 2002:a05:6a00:1c93:b0:706:8cc6:7471 with SMTP id d2e1a72fcca58-70b4365329amr1184028b3a.34.1720477178561;
        Mon, 08 Jul 2024 15:19:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c6c6dsm388187b3a.80.2024.07.08.15.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 15:19:38 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:19:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] iproute_lwtunnel: Add check for result of get_u32
 function
Message-ID: <20240708151936.331d1096@hermes.local>
In-Reply-To: <20240707154928.20090-1-maks.mishinFZ@gmail.com>
References: <20240707154928.20090-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  7 Jul 2024 18:49:28 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  ip/iproute_lwtunnel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
> index b4df4348..2946fa4d 100644
> --- a/ip/iproute_lwtunnel.c
> +++ b/ip/iproute_lwtunnel.c
> @@ -1484,7 +1484,8 @@ static int parse_encap_seg6local(struct rtattr *rta=
, size_t len, int *argcp,
>  				NEXT_ARG();
>  				if (hmac_ok++)
>  					duparg2("hmac", *argv);
> -				get_u32(&hmac, *argv, 0);
> +				if (get_u32(&hmac, *argv, 0) || hmac =3D=3D 0)
> +					invarg("\"hmac\" value is invalid\n", *argv);
>  			} else {
>  				continue;
>  			}

There is another unchecked call to get_u32() in the same file.
Please fix all of them and add more detail in commit message.

If the get_XXX functions are modified to force checks on return value get:

iproute_lwtunnel.c: In function =E2=80=98parse_encap_seg6=E2=80=99:
iproute_lwtunnel.c:972:25: warning: ignoring return value of =E2=80=98get_u=
32=E2=80=99 declared with attribute =E2=80=98warn_unused_result=E2=80=99 [-=
Wunused-result]
  972 |                         get_u32(&hmac, *argv, 0);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~
iproute_lwtunnel.c: In function =E2=80=98parse_encap_seg6local=E2=80=99:
iproute_lwtunnel.c:1487:33: warning: ignoring return value of =E2=80=98get_=
u32=E2=80=99 declared with attribute =E2=80=98warn_unused_result=E2=80=99 [=
-Wunused-result]
 1487 |                                 get_u32(&hmac, *argv, 0);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~


