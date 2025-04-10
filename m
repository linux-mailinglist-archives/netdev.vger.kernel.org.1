Return-Path: <netdev+bounces-181383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9593A84BB8
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57F41897202
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C68B2857F3;
	Thu, 10 Apr 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F466lyYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7C11E9B38;
	Thu, 10 Apr 2025 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307672; cv=none; b=TgE0Ybt8VB3BwycCKdR9d1k3TOKF5VXOy6WqreCLEPgXKrODnA3zcBFZSHMBuXP+jWapLGL7bsQvs1Dl9wIXfRgfLmaAlqOMhv4uKbVmH3tKbh4EuupZQP6ynar6EpOPRkdrelIB82FD/ypPVNU0TNXWVLgcTNX6L9hgJRQ+m+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307672; c=relaxed/simple;
	bh=Pw/dJ+4Y5FkoPfIBpwwqEtEWe8AU90hgV2bIMaMLP00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CATnG6Fg72M/EmYZOs6HCrWd9d88/o6AZFwovx2R5viq4Ee0XLYdSmty/JN56Z6Vj0P3sBko4fe6fZQkJ/OOKfXMAl70yxb7PoYZkHzmRy3gVjVXxOuq+cV6gw3rDI9IoC28wuWa2fSCvB6+vBQ+lYCroHIbEhxJr3V1VEfbO9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F466lyYW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso208007066b.1;
        Thu, 10 Apr 2025 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744307669; x=1744912469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q5k58HJPb9pkGfYBHMl8erz1pohoAN5Zh0An/lVPHk=;
        b=F466lyYWBPmzIRgHdzUs2+IKV5uab5E8lPSvjwqz70mCGZt2FOm9ShMGzJJ6gZhmYd
         TsmM/1p68/wY+KO2IDteEKOwS1IEF1B2ejqJqswkjtdFxCYdPfhZsASyyaXVIQg4gK8Y
         fWGjH9IA8N29Gi3N/ofyTlKF4jQO5oesPmePzsF19u0+B18ng+J8rIFft8ZLRhIWoxMD
         y0NziFOLHbJ1yArpOoZffcW67kInKimpC6TMwsk477K8KrN3aTCyGlqmm6XS4NbIxwJb
         wd8M92jPcA6XMC7eMRkA/kMkYlgeMjlXzH+0XZYbpl4cpBK9t6sqI3KbnfLYTcIWz4ZU
         mzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744307669; x=1744912469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Q5k58HJPb9pkGfYBHMl8erz1pohoAN5Zh0An/lVPHk=;
        b=aphzToihHDmn8SLvmiOArAy6u/9as78KeJWKBajc2fuTIwBquRsGmN4AcCUfMEqJ3b
         PrK/CO258MYbFqtFlXGU+J+9QRzYnxUJylDEpQPHAH/HjZuwYHacQxVVM3qEEWuUJLWa
         hM0TwzaENucc8WX/cvYHw4mOvJKsESvCsWI1zE/htBzlSLDfa89R/snxsoloaUFsA8FO
         Tth0uqaHCIrY/ZRDpQIBin8u1gikAYGAh7Pfw+Z2HJeUzyFq2Rn3C8wwHmT6ovj9qLvl
         YBLu1SzA5G/jByMDtmv1+bch9weQCk/MSRLrAsWjd4vXeq80xTXxKXpmP6eNrVl6o1o2
         BaHw==
X-Forwarded-Encrypted: i=1; AJvYcCVByLFNCXFbPuaqPn6beRy7tk5/Na5SMjor6a/0f8dn+QR0PSMwO9MjurrKbHG5BikvdI0Zz9SK@vger.kernel.org, AJvYcCWrON+/17lpkoCk7h0n+3HL2ObQYcPyVMI2c+XF3ckhuiL5suywsWsQhwfyrqJoKu/tn5WGUGebRh/Y@vger.kernel.org, AJvYcCX6D/i7g+1BXF6VWzJbxtDTConvl4E6yUusePfK1J0r0y7eZ1w8f/KAWyL9mtkF+xr7Z1vyOP4pibqeaaHW@vger.kernel.org, AJvYcCXmvoFyK468r//piqFDus8d8Ud5qNDT/AxhlT58ydK3buGd/zVdRnfH1sQBHug9vPgYU0z6bPEtL+/Q4t8JMezw@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSOV4Z8rPo7IFpkSrC4z6ppRz3VxH/EjDt0EJfrKlIvuMdhYa
	SbkZkfF0zSSbLgKiMeGnFFr4XwrYzFpXjfYf/88QQxjcZnCPKi6EoX5omXmhtkwNEXvkH+CdVTS
	NdiNaM3KsS/EYrinuVQpRu9N9J0Y=
X-Gm-Gg: ASbGncuwd+hgtah1yVb11YQwD+HJgwg2XvCiGieQMtWAVvduepJxB7RDXB06ueSzRLt
	Qho5ZZF+4TCEvE80q5RHnF5eSmD3gtKUJx6IapiaC+QOjKHjXyFywWWFwbVb1a0x07UCuAC20F8
	KP7IcmlQLb80KIEeC3ObI+1w==
X-Google-Smtp-Source: AGHT+IFk57BaGI8RexVkNm+rOx5JzRlSl388aEL8hPkRZ3mtB/W+jjolkJ5nyPy44lQVI1rq5r2tU030TeCa7PM2WVs=
X-Received: by 2002:a17:906:c156:b0:ac6:f4c1:b797 with SMTP id
 a640c23a62f3a-acabd195902mr425726166b.19.1744307669164; Thu, 10 Apr 2025
 10:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409144250.206590-1-ivecera@redhat.com> <20250409144250.206590-7-ivecera@redhat.com>
 <3e12b213-db36-4a76-9a58-c62dc8b1b2ce@kernel.org> <b73e1103-a670-43da-8f1a-b9c99cd1a90d@redhat.com>
In-Reply-To: <b73e1103-a670-43da-8f1a-b9c99cd1a90d@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 10 Apr 2025 20:53:51 +0300
X-Gm-Features: ATxdqUEHCMWU8odrtfeCV4-CCxyAM1De6Fsa0no8YCkrp_fO_UC5x5S5KURglVQ
Message-ID: <CAHp75VfR_6gQdcBU6YDTvtX0A2NDjto4LXyjTteGLmp-u1t2qA@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] mfd: zl3073x: Add macros for device registers access
To: Ivan Vecera <ivecera@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 11:21=E2=80=AFAM Ivan Vecera <ivecera@redhat.com> w=
rote:
> On 10. 04. 25 9:17 dop., Krzysztof Kozlowski wrote:
> > On 09/04/2025 16:42, Ivan Vecera wrote:

...

> >> +    WARN_ON(idx >=3D (_num));                                        =
 \
> >
> > No need to cause panic reboots. Either review your code so this does no=
t
> > happen or properly handle.
>
> Ack, will replace by
>
> if (idx >=3D (_num))
>         return -EINVAL

If these functions are called under regmap_read() / regmap_write() the
above is a dead code. Otherwise you need to configure regmap correctly
(in accordance with the HW registers layout and their abilities to be
written or read or reserved or special combinations).

--=20
With Best Regards,
Andy Shevchenko

