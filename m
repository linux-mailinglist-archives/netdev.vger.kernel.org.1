Return-Path: <netdev+bounces-188552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A827EAAD5B0
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4127465B98
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694A41DF247;
	Wed,  7 May 2025 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSKIX9DK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D81F29A0;
	Wed,  7 May 2025 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598163; cv=none; b=ChhRYoTiKDfJ/pepYaNsyRdcsrE2wHgdmrRIgP4Ncu1wUJr6M/HTV7sIIgSXXX+Z4ChQnB+Bjc7EZENvEjH2InpDj0wSarihBQU98/oLEVjH4MXhV0b+hnNvc2z+SCSs0JwgcRvmSTaMCkzNXdlagsfShzNUiNmuwVUxBGy6cDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598163; c=relaxed/simple;
	bh=xFcTlL22R5QJsTK3+aEOn17WGDr2m3xGp1yDc5abibs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yq8fe2MAMlaT2xCe91jlZjb1oUtom2Bp2h5KBXgtD5i94XtYLy+5ZoIFvx0WIjzw5TL6jHjKzOZqtQuDpcdG09jp9EmMn/Qjo1pbWV2Gc0C5bYKHyVMTy3HQ93BNFUQYWjm7fw7dmcuIAjVeCegBPE7f3baD2v+UNLck0dh/MlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSKIX9DK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so36614925e9.1;
        Tue, 06 May 2025 23:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746598158; x=1747202958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hJzuWdwY7mlFX3iGebzuAvBtJ9SboR8DqUFDAi4KB9I=;
        b=SSKIX9DKuDPzEe2roL13792XVz2WBm9TiQ8G3/BdSV+qKMP2JfB82lVVxV5kFjzByU
         FkfTigPWCFe1FUd0KUF+XvfAP0wr2spvx6HGOYlCUx6+QjVrTlecPlYtkqNTHX3o5EWj
         pvSH4cO0Dbads4OWFY8XrytU4LfJIC3Mjgmr1mXDt9XQTaDV2YqmF11Sj8dI0gyVE3Fl
         Yr1obx/K64muNGk8JMeImMeH4Qwkcd4BH2SqNINof6v7sd6f1iNfTNF6hLOwrhNB37Ck
         4spS5YX0K7Y5JDimztkkZtSDirig6rt+VNPC1obckRagRbpTX63MkBfuoeLquHwZs8Oy
         gB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746598158; x=1747202958;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJzuWdwY7mlFX3iGebzuAvBtJ9SboR8DqUFDAi4KB9I=;
        b=CZbTe3eOVdzVCYkBp9+lc7j80t87cJedm34MnQ5+lcoBfFpMymjSpAeyCDVYcEEwwe
         F7fC6P6+qhPvIvxRVxnHPn2hetYagAUsGZ2iOfba8Xpa4DaVsaKoLuyfByk07SXwPz7E
         7KLG9WLBmE9b/ZLNODbMNeO1Rt9ZCwzp1yTWYpvqkLn40DY+XQR0SD3C0rfpVwGoMgOe
         HpMzF6+tQdgv+WNhYAjNgNEf/cjys7+tvMygAalCqTRkqo4rD9Aw4EMV/3rVfv3GdPes
         CMNgDiFRj1tZAR4eRd+Vfu+YX/+wwFGuUOsVWR6QfUuDbcCLWjL/3YlAUFr2C5D/GS1V
         8Z4w==
X-Forwarded-Encrypted: i=1; AJvYcCUy2jov/QdF4IsohKIEWr3AX15bxtw3Vnf+moZnhUbU7R8nis64xYaV47VEKbtfGn4NukuG5p3wtaVbShs=@vger.kernel.org, AJvYcCXs+BqyT6tNxAzYd2HEZTvP0SFVNz4VG92FL2AGLooesCXb8vB+UEYuWq9MX54xTgZS94LYU93L@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2EjKgVCM1i6sZ+2O0IEQntGomHFtgoHk/o7Lv698zaevY/VqX
	hQXAKn8XFmfbqccE0meoqHTwyaVkS1hxIBopDTMEc+aocqNDOgN3qTGFog==
X-Gm-Gg: ASbGncuY8md1VRA8oNMMlbGZRdglmTGYoIjkdY14FOKFr/FouN4abvBgs3gmeEEqUke
	dfSHrsilPToW1DQHYeuMtSz1d7KFU4O17upHURb+4Ytf2mDJnnIuXAHGXoclbuM1Q1fKOzNyalU
	NzJHnQUNoRJUeEOpGxH/9DY05CqPjN7/vic2UVljlUQMk0HviKFbbhtJxwKyq++W9TSGggfrKPf
	RXSojrpRcN6qLJQ3R0/W2a92ihQdFm3qntS0PaSk+FdlZhI4iD0r6GuYLSlBmkxho+Hku0/6YEs
	OeAbORSJCmXNDv3zlSgK6JJ2JQ/i3a7XkyIX+xrnJqYslsvIc7OIXSMjjjby+xPk42m98nwoHUF
	9I90rN7lWFK3nT3kXEWL9NMO97IMzHDdvypKIfSazwB3q1Is0rvM/bZ3Ti8NMj7v9QvmoWFaU01
	9Gx3Qc
X-Google-Smtp-Source: AGHT+IGL3HHcnr16xc6MeJAYpQlZMrEQWptIxzVxKTxpjMdDOGnD352ModyQw9jSsN2/1T7751VbRg==
X-Received: by 2002:a05:600c:c10:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-441d44c7c36mr11947165e9.19.1746598157714;
        Tue, 06 May 2025 23:09:17 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2d:8d00:d1ed:f1f1:dce9:7a6c? (p200300ea8f2d8d00d1edf1f1dce97a6c.dip0.t-ipconnect.de. [2003:ea:8f2d:8d00:d1ed:f1f1:dce9:7a6c])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-441d4350e5dsm19030535e9.22.2025.05.06.23.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 23:09:17 -0700 (PDT)
Message-ID: <59109ac3-808d-4d65-baf6-40199124db3b@gmail.com>
Date: Wed, 7 May 2025 08:09:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regmap: remove MDIO support
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Sander Vanheule <sander@svanheule.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c5452c26-f947-4b0c-928d-13ba8d133a43@gmail.com>
 <aBquZCvu4v1yoVWD@finisterre.sirena.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <aBquZCvu4v1yoVWD@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.05.2025 02:50, Mark Brown wrote:
> On Tue, May 06, 2025 at 10:06:00PM +0200, Heiner Kallweit wrote:
>> MDIO regmap support was added with 1f89d2fe1607 as only patch from a
>> series. The rest of the series wasn't applied. Therefore MDIO regmap
>> has never had a user.
> 
> Is it causing trouble, or is this just a cleanup?

It's merely a cleanup. The only thing that otherwise would need
improvement is that REGMAP_MDIO selects MDIO_BUS w/o considering
the dependency of MDIO_BUS on MDIO_DEVICE. REGMAP_MDIO should
depend on MDIO_BUS.

