Return-Path: <netdev+bounces-99243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609108D4330
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B0C1C21713
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E561758F;
	Thu, 30 May 2024 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="CR4n58z9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8617984
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717033995; cv=none; b=DLZbhiuK6EPF3JDUTD5QT0qZdrTZ2CIwsDGKRvDtLs/1FX88G3fjSGA14Nn7gfoOewRfhpyRguS/2LKu2wkzjH1Ali6EtaywegmT7OBz/BCAxvAaqK9y3zqfUwgwolI063rXso6ywG7BqVpp5fEJB1ambfH78vX+TgmhJn3ANMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717033995; c=relaxed/simple;
	bh=9BOfbVH8YA2QTNgwedZWI9JmpJBM9n4R4yer8Ay9b1k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ncQXq1rgWWF9vz93aR+LCct5RDEzHWuUyS72MzhxpILiZmp/d0BtRjd/mZnImK/+e2UhTs4Ol1DfE+y5CEXWXUtEWfASI2i5NlsV3GBCYGqBEeeGZbXwxO8jUudY/eg9Tp3+GPTK5LcAihtq4p5u1E5dV+8DEQ/f58U9J813zM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=CR4n58z9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35dbfe31905so407656f8f.2
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 18:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717033992; x=1717638792; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BOfbVH8YA2QTNgwedZWI9JmpJBM9n4R4yer8Ay9b1k=;
        b=CR4n58z9nNcoh/v/nEYdkjCOjHcVvnFezAmpaQ5ILSa1/OWAiCnq1mrx5dYVfLpgYt
         6SzlVrfBmmnSSxlC48EL08MqfA13eSuV9COK58Ej9Nk+ulLi0AgLlBRCOwuXqI6/pQAK
         yN4XF1+9urH48Te+oKerprAJhYwt8XwLzgBkDk7TD7kv3m5q691NxTOSjkJRk7kSyH9Q
         VG84ROawH7FtDdHI2GKPClwerTXTZv/bWcN32sY6/QPmpsKW9vb04AjzzVzXEmsOzGyv
         F0cz0HwLlfTNfwySVNyzbXABiP7Wbk+mRVXUYZ8loEyaSGsCX7UYrgtMxtjHiPteTHox
         V/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717033992; x=1717638792;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BOfbVH8YA2QTNgwedZWI9JmpJBM9n4R4yer8Ay9b1k=;
        b=qp4mvA/ZNBzvqj1mihp6bH+JBBO7dKo6UtSiW1ogwjXnewKbGwiMQ/E2TY4AkGR4rI
         qDyvrGkST7JyAWyzGfz9euNph6l0TCVDVKyKES3fMheJxEddLwQYJ6yA5TYlbn+ts9L8
         ypx6rCkF38bgrfSqqD7GtM+RpOdj7224hUFtl8QJA9BqXVK7Lp2pCoYWcTcoLY1Nug4b
         Xv3lXyAE1IqiRMW1izs5YT/6vEAVm2FrPsRZaag8Jbi2a57XOI5mT162/H9Wlot54T+w
         Cp79BAOu2S5JwFShuoif8hLWQ8rhpMXgZx9O5ecS6I0PDbOJqBpSw1r3JDy1y9DahRjK
         iWmw==
X-Forwarded-Encrypted: i=1; AJvYcCW44khQ9GxuZRogtQq5knYPALgtvNUWdE1hzjUfZXh5zjLszfXEqnmcMGb3/7ymr9tMGNAMQcKUTRM3B2F74T5Ob/YnyJE+
X-Gm-Message-State: AOJu0YwfZZzL1IJ/Well/D6tNb0S1ja4WcwYjWiuuUqvLBWX9siY30wB
	5tk9bD/W9ulWbRAX3gCGffsA4ibJ4DiavsxTlHo6e+iX/NOiEdGKZ/grDNeEJq4=
X-Google-Smtp-Source: AGHT+IFoU4QteZZNYP/I6fo4kLvwP2gOPoNDRwhPgjxxb+EGXffmiDaGtONVEP08x0ijp1efXdcInw==
X-Received: by 2002:a05:600c:4ed3:b0:420:e4b:d9df with SMTP id 5b1f17b1804b1-42127819e09mr10547205e9.13.1717033992346;
        Wed, 29 May 2024 18:53:12 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1083:f101:dcff:2f3d:64d3:d269])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5786450bb13sm7415110a12.72.2024.05.29.18.53.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2024 18:53:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH net-next] net: smc91x: Refactor SMC_* macros
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240529171740.0643a5a1@kernel.org>
Date: Thu, 30 May 2024 03:53:00 +0200
Cc: Nicolas Pitre <nico@fluxnic.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Breno Leitao <leitao@debian.org>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andrew Lunn <andrew@lunn.ch>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A004D09E-E9CC-4DD4-ADE7-791D63D962D3@toblux.com>
References: <20240528104421.399885-3-thorsten.blum@toblux.com>
 <20240529171740.0643a5a1@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

On 30. May 2024, at 02:17, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 28 May 2024 12:44:23 +0200 Thorsten Blum wrote:
>> Use the macro parameter lp directly instead of relying on ioaddr =
being
>> defined in the surrounding scope.
>=20
> Have you tested this, or just compile tested (please mention what
> testing has been done in the commit message in the future)?

Just compile tested.

> What's the motivation - cleanup or this helps remove some warnings?
> (again, please mention in the commit message)

It's a cleanup suggested by Andrew Lunn [1][2]. His suggestion might=20
have been for SMC_PUSH_DATA() and SMC_PULL_DATA() only; or to add=20
another macro param for ioaddr if lp->base and ioaddr are different (as=20=

in smc_probe()).

> AFAICT this will break smc_probe().

Yes, it does break smc_probe(). I'll fix it and submit a v2.

Thanks,
Thorsten

[1] =
https://lore.kernel.org/linux-kernel/0efd687d-3df5-49dd-b01c-d5bd977ae12e@=
lunn.ch/
[2] =
https://lore.kernel.org/linux-kernel/f192113c-9aee-47be-85f6-cd19fcb81a5e@=
lunn.ch/=

