Return-Path: <netdev+bounces-114811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F01079444A5
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7431F21DCC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9105613D8A6;
	Thu,  1 Aug 2024 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amu4/OBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A52745B;
	Thu,  1 Aug 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494718; cv=none; b=EYWt2wYi4HZkfHRytQ1GJ3JW5N8wmSFfdkoxk3JcOKpQWIfNE6/T2ZEQAOpTZXY/kvKSclkK8LzAzXEsfJhXMF/qElIsofyP3dg5jcp7sN/z4sf2tbKI9Fpkczpq+RHBZx1GrvSTeLxqVvHv9vwLR3tgMc+Ru6KeqZCpAuiiqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494718; c=relaxed/simple;
	bh=5sWP90VwEaVg4UjOMzi1vQB0KH1aObsNYJEkxg3dFMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhhZ8wtnKTANDowKGPC8XSQXswMGxaSG/B0At3ouRm4WWBjXF7LxTkewcUyb582Qba/M9+9It7had7CZlXWbYJ67/V9FzIxcQaxzfyRXRwqJ51SwOyPlqydxhNQ7UOMwgWCFjlOAYx9RJzrNSvvuP1i5oHj203ThrV3SvBc2hrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Amu4/OBS; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7093705c708so6734294a34.1;
        Wed, 31 Jul 2024 23:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722494716; x=1723099516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWK4fqAZwTPXPLYR4LC73NJ1gf7ojeoCGlC/cqWqdIw=;
        b=Amu4/OBSkPMCFk/Kxr+qo9PjZtZhzBikZtOAR+uSifyJ9PzMMg/0w+ksoz807qgIEg
         orZhrA+jiS9hOd8NAxQahoDxoYU+UfmldhOWRlmyT94ngCf1QG3OMy3ebOjgaUgDAFVA
         L+WPJIhkA3Xw5W2AyOJXwnML3zRHrRFChn/+M8sUIykIydbTrURsg/dhAeDr7h22vICy
         TYXpxOBir41joSWp77f5UycYjrBs1tXMSWnx0NU4fznDf1y+tcmuAz99tb8e9orYhTpR
         xF/VH0tw4lcujeXTQV+RlO1BFmiXPK92Nn0dvXFF5iLZqoEFzc754Mf+Kfo6FNriISzL
         ijjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494716; x=1723099516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWK4fqAZwTPXPLYR4LC73NJ1gf7ojeoCGlC/cqWqdIw=;
        b=eTXcWMA7bJC8yGMq6HvrEmBkDlDL87Qj/vIuZInNjSMTyMEENThNQNy0VPJ7x92G1m
         cpGO3J3FLJLm7PgcDDjTsSI2+ET79fphc6qcpSAks4nIlSrqZPPgm5ohvb8OOQRCmtBD
         Mo+BQbWtghxYHZG3evooHsJWjQ0yUgiPHlwR3KoCRz6IZOtZkxuniX5RcJP8glvTtcS+
         Vaovr4LM8XOV1DTBF/PxAslVV4CsubFrLYUGUG3ZGxKol2dxe6++d1rjuL4PmUDufnjv
         c3VOiJF9dv9TFLPZmAmVGW58VW2aeSOuJAwOHK7QCddLisjXHQYw2qQ+kd1knuq0Kl4K
         DhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMK6tX7Su8KwMTruCb/DTxiJyepgyhSpUm6qunOlollqHQl12z64AAajebYYyNvNXZqfpqwO3Hflbe+xhPn0R/Hb5aiY+O
X-Gm-Message-State: AOJu0YwayTv/EwvDmvSSmCr+v2ESi8U7pRlwMf9M0ugm6ZYHb/123+ZW
	TN8+TzzaS8fHkttKp26mLiTiW0MkGQXhNth1W5AdrGJxoGYwtofGBy3Y6aybdlUa1k9kpoKOCfq
	uVQN+/9G60CGCmI2MhGGG8Slp5iQ=
X-Google-Smtp-Source: AGHT+IHqF7CGNuKr1aJQkaxweEgbq2lW90JHx9RUeU/R0pX/uFFR+nBaCvZRWjxZ0QPJJ5lROx6JxUrR4bjO7bQQnu8=
X-Received: by 2002:a05:6870:9a15:b0:25d:fab0:b6f4 with SMTP id
 586e51a60fabf-2687a375c86mr1753352fac.1.1722494715945; Wed, 31 Jul 2024
 23:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731103403.407818-1-vtpieter@gmail.com> <20240731103403.407818-3-vtpieter@gmail.com>
 <20240731201038.GT1967603@kernel.org>
In-Reply-To: <20240731201038.GT1967603@kernel.org>
From: Pieter <vtpieter@gmail.com>
Date: Thu, 1 Aug 2024 08:45:03 +0200
Message-ID: <CAHvy4ApG3XhOmvn-0kT-Uvdd8yir_O72zSrFLA+CHKhm+z6XEg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] net: dsa: microchip: move KSZ9477 WoL
 functions to ksz_common
To: Simon Horman <horms@kernel.org>
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com, 
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 31 juil. 2024 =C3=A0 22:10, Simon Horman <horms@kernel.org> a =C3=
=A9crit :
>
> On Wed, Jul 31, 2024 at 12:34:00PM +0200, vtpieter@gmail.com wrote:
> > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> >
> > Move KSZ9477 WoL functions to ksz_common, in preparation for adding
> > KSZ87xx family support.
> >
> > Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>
> Hi Pieter,
>
> This is not a full review, and I suggest waiting for feedback from others=
.
>
> However, I think this patch-set needs to be re-arranged a little,
> perhaps by bringing forward some of the header file changes
> in the following patch forward, either into this patch
> or a new patch before it.

Hi Simon, thanks indeed I missed this! It seems difficult to respect both
patch requirements [1] for this case:
 * One significant exception is when moving code from one file to another -=
-
   in this case you should not modify the moved code at all in the same pat=
ch
   which moves it.
* When dividing your change into a series of patches, take special care to
  ensure that the kernel builds and runs properly after each patch in
the series.

I can make it compile but by moving the code, the KSZ9477 WoL part obviousl=
y
won't run properly anymore. Any suggestion how to tackle this?

[1] : https://docs.kernel.org/process/submitting-patches.html

>
> In any case, the driver does not compile with this patch applied,
> f.e. W=3D1 build using allmodconfig on x86_64. While it does
> compile just fine when the following patch is applied.
>
> --
> pw-bot: changes-requested

