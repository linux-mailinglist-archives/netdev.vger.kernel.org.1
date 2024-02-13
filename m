Return-Path: <netdev+bounces-71567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CE853FB3
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 00:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF9E1F25221
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 23:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507036281C;
	Tue, 13 Feb 2024 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIj0CLI2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31262817
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865733; cv=none; b=uWgRSVIp8L/oybb/noK+YpqHlDQHBVwdzwFolmXemdf2SD+l+atm2PCpKq3J5lsnAGTB4BnQ/deCNXiuWtRBm8jHeMYz3Hk9glXcl8xBhaPtHiY4MJonmvVwcwJEkXBSZBujauxkU3je7RI3t8P+Dx2xXoVp2b95mmYtoKsgzDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865733; c=relaxed/simple;
	bh=tVloHGKUehuApsaPOPySRHcT35thEmrZ6ArHLcRSLjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqPUVi68zZn3SCb14TKr/Z6z4BiBxRAt8M+1Xv3owx1UjviBXpkXjhTrRltfsrr6nmNN7Y/hWnEBJQ9Wxn5OzQYw9EcLVfDye2jmh8DU2Y6HAhuraECbWzGN6b6t3w75bmr0b7tOi6p6SWtgu/d1Nj0MMk1lEoa7I80+ZeXK3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bIj0CLI2; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc745927098so4132645276.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707865730; x=1708470530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVloHGKUehuApsaPOPySRHcT35thEmrZ6ArHLcRSLjU=;
        b=bIj0CLI2rk3m/mXn1xYEKjbm/NdhNO19lFjMy6JWhpx1uRzbk05QMoLGsI+X72P3i0
         wOOcPj/Gdih6N0DdmvZ7xWd+rnqq6hpUUo8gMWjpGDcVR1qMaQWDjLGd5fcQMUYhfEh8
         TabmRU9kNtrmkCJ8yf9hq5yYWXtPSpz/RFd2GZnzbVeBLVIRgWlJeSNK9ngO3EkZZSha
         GIT25PKmLwXT3PYJ864BK8N+TpN4GVM3pswQ5Htr4dvoFyZjD518yznaMAOJG6NhKSyy
         m0yuhcOR+EOCR16FvW4LM87vsLctti8c/tGcY4zO7w82dCebl+bZBSgSrgoDTUVmzdWg
         KBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865730; x=1708470530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVloHGKUehuApsaPOPySRHcT35thEmrZ6ArHLcRSLjU=;
        b=FkI6fcYWhfeJGUQaMI82pvVp7z38bZBRITFiPQbF3RkB4Mb7geJSai3T6rlphw/6F4
         pzx9TcMShmDI0PNChWctP3opkWc89/ecQnl2tWk4Dw/04z9sYV6sDZrrEsH0Ft32FjMq
         aH7Njh6I3u24S56HPcD0D6BFRpH+PnXMnnVLq5iKBk+QcTu6H8tB36GsaGtZj9ym+zd8
         RPGomlMp9WhEnHAN4Zp56x19yGDEtZHQ7FztxZyhd/3g2LkmUlNTCGnpNRE6mcaHdGxO
         uipEz/3fPrDzcUeTO0Ay5LHJ8uSKlRq1ir6n6+cBhvRwE465xNx8TmPwsNhB0ayWCvO/
         unKQ==
X-Gm-Message-State: AOJu0YwDLlina43n1TU8MDNqqNahYfXXAw1LEh0u0oxTX2dwgTA///QH
	mSSGNbc8gBTZMP+risGZ4FWKSIHQfDrMlSPkD3K40zDMo5ZlVG3aMm/hN+mNarNlqUZOYx+PQ2L
	6uAkxjtRNJiwGQ/f6DzL0LXd73H13uNWrJXUAKg==
X-Google-Smtp-Source: AGHT+IHldCihTNKaP18UJpjk4/sdZtLc1mDrS/RakLJiAv29JiA03nQSoi7wCPuxhOwqi6f7UndIkebfjzz7mXhdkpY=
X-Received: by 2002:a25:684f:0:b0:dcc:8c7d:970d with SMTP id
 d76-20020a25684f000000b00dcc8c7d970dmr534160ybc.47.1707865730573; Tue, 13 Feb
 2024 15:08:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com> <20240213220331.239031-6-paweldembicki@gmail.com>
In-Reply-To: <20240213220331.239031-6-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 00:08:39 +0100
Message-ID: <CACRpkdbY+pbU76VpneBC6h4HJ9gjn5YPe7gh9iOcPFJt2FBVkA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 05/15] net: dsa: vsc73xx: add structure descriptions
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:05=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:

> This commit adds updates to the documentation describing the structures
> used in vsc73xx. This will help prevent kdoc-related issues in the future=
.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

