Return-Path: <netdev+bounces-109653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BFB9294D7
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 19:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A157FB218DD
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A27F13B798;
	Sat,  6 Jul 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QtM4OxGP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D9757FC
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720285893; cv=none; b=azcmg076nJAK649WhIEWyJMYDgp9vVCpAPNLXP6uhRr0VP4jvIddXEpy5vqDyqA3/y7tar0lV+WlNhYCbMfs6X8blHqX0I8Y/zoiHNBJg1jbf5uovWUDk7cxk+wn/6uvV6kDfUKzVKiq9G6ZMcXwm9gqpao44H1Z4lcjTO3J8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720285893; c=relaxed/simple;
	bh=inUktvfJgSOtbgUhUL+dreIzZiZJPnG5VEFmMhaZBac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBwtpXSz4vUoyeatN8uLKK1BFGOIz5Emurz35apM5TXBK05TRG89jue5DkaoKoOx5itLMPb96gDr423PkssB1GSfsm7lvAFTqDTxFErSPgPKlOD2tlpJYQC1eXmDcyyBAUU6M3/Dx29YoHIgB1RedzgVp/wDbp1htyTTnvx3T0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QtM4OxGP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ccc40e72eso1533583e87.3
        for <netdev@vger.kernel.org>; Sat, 06 Jul 2024 10:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720285889; x=1720890689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x25MuoZU1squ5APBONrjutEGaNjumqsiwU//ZNvCVkE=;
        b=QtM4OxGPCMsaLnppLgDFW5XvIQCz2LMDJW1Ue4sVSz6KS2cCSYevZuxf12dsa/J7yJ
         YDLE2Gid36res+9xSdxCFz69HYhnaj1cdM3Pmi6tG916DkPxMDaevDo1p3+qBMmgEiP6
         0+Kh7qH5bCJL4g1OIAGqHWYOrq5QTdVCpCsxIxYwl8HNx3Yv7IIYMAn3O16VTw/2iWo/
         UmJKlhgKgFeeiehZEpNfZ/0Z/dMGEmNC2s9wlbrUuqscLD0PJVwYr510iHCYBs8ENv9I
         scdXPdPl0io2FQlyzKAy210eMUPGp25GCeatO6682egxe9cBAr8i6WiJ7yLik4R/JQ+J
         p7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720285889; x=1720890689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x25MuoZU1squ5APBONrjutEGaNjumqsiwU//ZNvCVkE=;
        b=P6FOS0t95gt/vjluIwrMeSvSW2ElIYtB+5Da0fuomhVPQmereAfn6SHf1GoCn+K+ZX
         kuahzTXz5pWsS8LoNZ17cg1+39Q72MM88y5ZXasSzX2FAVb52yXLWHtcaSwdrouhI7xw
         RRIlLBNYGeCBHflTZ3nFp8Dmelcz9O210JVCW1BKx1mZhl3I9slQGI+OPodLeh5YWsBP
         WASY708zBk/uYLqM7yAnsxmxhPqcQ8iKvyhUWkvTmrDj9405jzRhH8cBKAE75COq4rgJ
         mAi0KPLnynyyGCQsdrV/WhNs6KZUomMV1E3VC/+2T11EdD/eR5XcYqOgMtSjkYyxinE1
         QeCA==
X-Forwarded-Encrypted: i=1; AJvYcCWB1U1ujOskCny9PCr882bVq3IoCr4rwbJIAoUbPRVWpVw4Ko8uistPZryZviXxqf5YMvGUmf+R22mNLIgCFJ9iZ7CULXyE
X-Gm-Message-State: AOJu0YxY1oN6Dqu+o0V2cKRH8xJMx3noU/19XVq+K/+drPiXwEKYdE8a
	ziANNVBoC0tINigbUmDV+opFzk4whT10x0MqolScfbBTnmuTd4QTPClA13QXS6VmfyGT8aXPIIu
	gw8PJZ+Nhf3thV3TnOzYDFbD6ZSgWldslUmoszA==
X-Google-Smtp-Source: AGHT+IH64PoKhmoNpLNB7vtq25QpdO924HKH9ji0CciN3paZANoVLGsSX7JerHDtupwHScuwKz0WqMZ3irB5+r0iO64=
X-Received: by 2002:a19:3852:0:b0:52c:dc97:45d1 with SMTP id
 2adb3069b0e04-52ea0619e1bmr5857825e87.10.1720285889279; Sat, 06 Jul 2024
 10:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703181132.28374-1-brgl@bgdev.pl> <20240705170440.22a39045@kernel.org>
In-Reply-To: <20240705170440.22a39045@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 6 Jul 2024 19:11:18 +0200
Message-ID: <CAMRc=Mc8BxJ+8U3gs1yHX=a3ZFcfqn+Dke6Rz_LcAOeqT3Cjmw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] net: phy: aquantia: enable support for aqr115c
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 2:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  3 Jul 2024 20:11:27 +0200 Bartosz Golaszewski wrote:
> > [PATCH net-next v3 0/4] net: phy: aquantia: enable support for aqr115c
>
> Doesn't seem to apply:
>
> Applying: net: phy: aquantia: rename and export aqr107_wait_reset_complet=
e()
> error: patch failed: drivers/net/phy/aquantia/aquantia.h:201
> error: drivers/net/phy/aquantia/aquantia.h: patch does not apply
> Patch failed at 0001 net: phy: aquantia: rename and export aqr107_wait_re=
set_complete()
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config advice.mergeConflict false"
> --
> pw-bot: cr

It conflicts with the fix I sent separately to add include guards that
I had in my branch as well. I'll resend it.

Bart

