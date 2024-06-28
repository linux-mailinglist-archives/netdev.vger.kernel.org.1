Return-Path: <netdev+bounces-107573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C061D91B920
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C94DB21821
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854714373A;
	Fri, 28 Jun 2024 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jH9ffnN8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F197514375A
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561405; cv=none; b=BgQ8fsMKHZQfO17klQ9Sq96ryRhXx7yeNtO/jjS2n4JR4/NqeNUYrYBBE4Jd9kxjNhzQx4dS5mKH/mdGBbWLEoqlkTqh0U00KTnxiXqVwmSVoRlq0TT8ywOb7HcOGv2zMCygQX/sO42zKvuRtzMARc+5f8r8Smwudza2MTtjtH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561405; c=relaxed/simple;
	bh=pLdRKPad+qH/Af82g0rGTcCOO2LFZ7H6w8wLhBUk47Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn4ijmfTXShVeYvVrtcs9dJgyXHWdXW1kioIcY0zIJuz6SYkntAR6JlCRtCmZNUJAiCNR/oeJhxt8xzICO7erLfRhAIzRoUqs8TkP3Eq20Vq+5MDagDp+0xf9KqYHDyiY3SkWoslNn8vq5tDF9wPe/IIyLBT27ZImZe7BEapq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jH9ffnN8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so3900141fa.2
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 00:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719561402; x=1720166202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLdRKPad+qH/Af82g0rGTcCOO2LFZ7H6w8wLhBUk47Y=;
        b=jH9ffnN8bA6i3PVEa5JFw90tu4vKUaUWX31ki9FRZ5VDa7v2cYO1LyBvTscoTlj+cG
         BWWeiRYRbHTsdKKKrQ7uvrsBZwaW37ECrDbvpmpc3FRAYqLeNO1PLqJrnNUDmdYeL6om
         B/Dn74GRdjMdPTiYIeaLQgpw/f9Vpfuy+asYx7RVxgK64olgbDLte4BLyZC7WSmKhVc/
         3VAS8H4M+d6/T541TBY5SYNMnSE0GxFFx7N9C7q/ADSNIjRcsK2g9ipM35uolJfiw9Em
         aKu1H076ZJLLiBH68OMeWWSVL5hng2Em8LI1Dzn7wjpmvHqptMR+QoeibJYO0Nq9t2E8
         eI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719561402; x=1720166202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLdRKPad+qH/Af82g0rGTcCOO2LFZ7H6w8wLhBUk47Y=;
        b=ErtT+t9c8+zPmpIMT573nBCNVDLR7ZU3nfQT1Aai8Vqk45Xe5r+eSVJYZrHrlW+cb4
         Br+pPnzh4lKmCAxDYXF7ix4WBFVYNBHKgHoIOqJ9ML0CFIMpMqIERVul4h0HdEymM//r
         cnwr0i29/2wVXi32jtJApCrhzagq81ksM9Nsv/U095Bi2hk58P83JcrsdCmX3l3cvPmQ
         Q2HeIdGd/gK5kzTZ+x6pPiJ2rO4QSS3E4isbzbf2QLMywwzW+UkPPEc6A14ZaV4dIhGa
         oNwQOCcrzxuqfk7FQj6wKnkg1BCmEoWD44q7nUIoMO/o4XSNnNmz1quzxYUXH6N08et+
         E0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrBZQJGf73Lcfpsd0/H9Z6zPHXI3N4PXloWFQsi+uyX9R2FAEq/3GFwqXILbR4cbCobon3+8GYNEf59vrRVvn5GGMeT+Lg
X-Gm-Message-State: AOJu0YygTOpoaJvPwvb0XlwwyTzLZjsr2MZeJLoFPtGrqdKvIsx4SuXo
	844usFwylLhTUTJV7RcU05SWJO5GJOZMWFifSFVbJn8uNQUFfLbUaSPP0XXmxkBojKBhZ7Br6Pj
	Qq7GNRyvmQqbuQHVVv1qpBdR1Kgu3btBQ9Qq48Q==
X-Google-Smtp-Source: AGHT+IEi/rjt/tzx5uveY9ZwgtWvUEmQ5C2WIaWtTQQNIKzh7YcTed2emx/1O+64wThFP6b9cP45dhqOdy9b5l+trV8=
X-Received: by 2002:a2e:9684:0:b0:2ec:507f:7319 with SMTP id
 38308e7fff4ca-2ec5b36a98amr123270921fa.43.1719561402304; Fri, 28 Jun 2024
 00:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627105846.22951-1-brgl@bgdev.pl> <20240627145931.480ad134@kernel.org>
In-Reply-To: <20240627145931.480ad134@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 28 Jun 2024 09:56:31 +0200
Message-ID: <CAMRc=MdmDezxbug461brRRq-zc=ubnyDya3dQzsmuH_6X5Pb8g@mail.gmail.com>
Subject: Re: [RESEND PATCH net] net: phy: aquantia: add missing include guards
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 27 Jun 2024 12:58:45 +0200 Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The header is missing the include guards so add them.
> >
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Fixes: fb470f70fea7 ("net: phy: aquantia: add hwmon support")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> You say net but it doesn't apply:
>
> Applying: net: phy: aquantia: add missing include guards
> error: patch failed: drivers/net/phy/aquantia/aquantia.h:198
> error: drivers/net/phy/aquantia/aquantia.h: patch does not apply
> Patch failed at 0001 net: phy: aquantia: add missing include guards
> --
> pw-bot: cr

I resent a rebased version. However I noticed I forgot the 'net'
prefix as I split it out of the previous series. Sorry, I hope it can
still be applied without resending again.

Bart

