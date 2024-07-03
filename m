Return-Path: <netdev+bounces-108768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46627925500
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0CF1C21B08
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 08:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555D213A24A;
	Wed,  3 Jul 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eaMrDwAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83591139D03
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719993607; cv=none; b=AbPm4afkjCLvJY/i8gVZFAu3PN+CPCumvVpr/FxhcD2LxAsJLppIzkLF7QcieENfAbmUCoHBRbNpD+reOEie3tVLwandM0f4vDBLSGBHRSEwYnbVNyl8+3Py90q8dUja95p22YWkVu5VnfcsaVBw3msl0kXgpWrRn2K0L5jFlX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719993607; c=relaxed/simple;
	bh=CkLTNry7yU/uuwFkqFDOD2cX0PPHh08s4HKDUGyRcCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhjjAzO+S2zKO3mLtclsiK5YgOlH2a7B30AsLewKPoGEoxgzf/nkiRtIKQK6ZTqjrSSHANe4Z7VUvcTI+K+GYkpu6hxEYSJuFg+EVNpSIVZl4yXfNtT/eWCPHDK6r0jSM8s1dCdGBuQ2DunsDq+Zl7pGhDr/yTqX32MKCV2l/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eaMrDwAb; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e9944764fso253036e87.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719993604; x=1720598404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkLTNry7yU/uuwFkqFDOD2cX0PPHh08s4HKDUGyRcCQ=;
        b=eaMrDwAbmo2AAWKUJxgz00KYJCs6OoOx/CZ/3I5iLTE/ObtPcZVmpXkq8vTGTYYaW9
         3n9hpf3EekKWzYbD02HfwoCeHjJVM/myh5Kzlt6Ftke2ZwrYbF0wp03gzTx+FHiKjNLW
         nksd3Qws9sD7hhXo0PHFrjq6rTOjZXf9L4Qso2LBPysfbW1YwLtFqkKwqpNKZvKIp3v3
         ULVNkqmahiUhi607+bM59YZQuGGWWsoaebTISgisysZETk3ggMhYy3txnjWy6ewD03Ha
         uFhHFySu4maRbM7LLsUkn2ccEHbTyd6Pgp913anqZVDE50fazKJP6A+Jpn9NMgrp9pC3
         yXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719993604; x=1720598404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkLTNry7yU/uuwFkqFDOD2cX0PPHh08s4HKDUGyRcCQ=;
        b=uoQOsMXB9r9him8i1JY7YsklN8XGyId0bZ/zDJzK0yMdoSFU+Kw3+OjlgVDuwCydBF
         PoU93I1EVaMw5pkyZfjuBVb4UgQU+NbF2EQPgBJOtwSEoz7PTZIWas/6Yi4NVSAUjOF9
         9n9CFSYO3yRiFExLfezUnDZ2GMURrRQE1iNjFF+Tjj/Di65zlGdSAOobPgUHGba7KxDG
         ujmp/UUG/GPJ+ketn4Dvf1aSYU3XZilqkcC1TuafKRquCJOTpyp4lpmy6GBxEm2nZlgY
         qDPR+oy82ABUtGdP/ijPtoHaG2IOVf1y3qTCTx52dptVYGWnGiVYxXPF70tyUG3Xg9qK
         52NA==
X-Forwarded-Encrypted: i=1; AJvYcCXSfveNdlEu20RXGsSw8WPEW84MEs67rDHQgDvHkhww+SOPgfS1axbVDoS7W17VjuRQERUzcHoKgYKG+0nEC33IydYOiLam
X-Gm-Message-State: AOJu0YxRwu1zm3ojXobQMmcmrC3rIlf1nNzJkcK0MSjeLD6HJON/+kcx
	1xm08AIh+tlaiGmQtSGYUJAaUrWBJeSc05VWwkobM/7GMICLP0TO1HGmPkqGWUjIFU0/YzIS9DC
	BKkSyYj/hwNfUMvoJ6L2Xp+kzkHkmIFaK+UhYkw==
X-Google-Smtp-Source: AGHT+IHr2vBqgrcFtBtrFIjitcAzlZk/XsN2VnaBSkBodd21GrpqWwe2mqMxd3GXsu2MabphGy7pE6MPdBpPzBixzec=
X-Received: by 2002:a05:6512:3056:b0:52c:dea8:7ca0 with SMTP id
 2adb3069b0e04-52e8270faf7mr6755061e87.55.1719993602685; Wed, 03 Jul 2024
 01:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
 <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
 <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com>
 <b15b15ce-ae24-4e04-83ab-87017226f558@alliedtelesis.co.nz>
 <c19eb8d0-f89b-4909-bf14-dfffcdc7c1a6@lunn.ch> <c8132fc9-37e2-42c3-8e6b-fbe88cc2d633@alliedtelesis.co.nz>
In-Reply-To: <c8132fc9-37e2-42c3-8e6b-fbe88cc2d633@alliedtelesis.co.nz>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 09:59:50 +0200
Message-ID: <CACRpkdbNevzCd-5n5ccgJ5HZpg0JEMd47a0PNiWPBr6r1mok6g@mail.gmail.com>
Subject: Re: net: dsa: Realtek switch drivers
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Andrew Lunn <andrew@lunn.ch>, Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, Florian Fainelli <f.fainelli@gmail.com>, 
	"olteanv@gmail.com" <olteanv@gmail.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	"ericwouds@gmail.com" <ericwouds@gmail.com>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"justinstitt@google.com" <justinstitt@google.com>, 
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>, netdev <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"sander@svanheule.net" <sander@svanheule.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 4:39=E2=80=AFAM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> I've just found is that in theory the RTL930x
> supports a CPU disabled mode where you do connect it to an external CPU
> and the data travels over SGMII like you'd get with a traditional DSA
> design.

The Vitesse VSC73xx has this as well, it has an internal Intel 8051 (!)
CPU so the switch can be used stand-alone with a smallish PROM for
a random switchbox, or it can be used over SPI or memory-mapped from
another CPU as a DSA switch.

Yours,
Linus Walleij

