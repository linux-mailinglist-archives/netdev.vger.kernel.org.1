Return-Path: <netdev+bounces-115418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B19464CE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E3E2831A7
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD5A61FF0;
	Fri,  2 Aug 2024 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRR1SkjC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331C219FC
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632858; cv=none; b=VbXFYqslqJgKMFsyAOEPnq1pTkkveAPA1ooxiuot5CmkNWg96v1xxhcnDeW34CwSXis/1zE8yoapEKpEojgfcE7LZrkRolnT7iXBSKRoIjyAeXI2B2G9apQLN5fk9eNtwIENd8Q2gmHtKmRTTC5aZKkF/Vu3Zf00/vyySBl3Tlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632858; c=relaxed/simple;
	bh=3IBCpDKASkgUWXZNH96TfA1Kg5XghuUUJPGzs/5NcVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OswEqkh3Pn1Kn0Yb3x8W8S/ah1bSJB/oJ376Bjy+QgXDmu+trR2dr+XAh9yuW9zraTTdY/59u8bJxhnspTlBROm8eZ6EmYX23KLjhHY7cHmXBrtsDBsdnxSI1NhYDdNm4Y4rFQDmflE4ZcPnfn34XtdkHGIKPB2uzPcG5mDRa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GRR1SkjC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f035ae0fe0so98884471fa.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632855; x=1723237655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IBCpDKASkgUWXZNH96TfA1Kg5XghuUUJPGzs/5NcVI=;
        b=GRR1SkjCbLOKnkKxlw8gTbVc9A5PgBDM5OpLmYWFaEfm6FI1g5z/JodvRnnIug6KqV
         wk+JwgUN7LPJpSkLXKaIh2OPSsKUh+Q9G9erwU/7By41fWJ92ycTgDNY9tzQsCM8+dmA
         cwmZl/sZicr645+gi2Eb4jPboyeiJIn/J36dbx78g/smPXduDknh8iHnLJQYpNV5Uj5l
         MRLTEflrr7uKkvSz7zsmlJ4UbCEyLeYD47NPepLH1PU1rPEziWlvCVAVEkwpJ2BlCvV1
         mBBhtjycH2KTWiKiYMwAm/ycTnDGP0NfpgiwLUm9ZBElbjkffl7BCtrUSFwYl/qkYgNA
         XqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632855; x=1723237655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IBCpDKASkgUWXZNH96TfA1Kg5XghuUUJPGzs/5NcVI=;
        b=AL2tn5NtvMILmoXaE0nFdbG1GxtUXCx3UShEcBfkJag9AZXfErHpczGp2ikScGXsJU
         8maQEua/x2B/5rT+Vvh1MHAHtk2oODaD5iDL/H26rr1V0fMStKqVmNU/oJnrrM22HP9y
         2exQLGxG7MJ8YPyTl0nodseQVditamK+djKG0ow/RoVA44jXIWyt6/uxxN+imC+8CeUo
         8QRb/QgabexY04yDGECiahe25JrVQIhF8Vj5O6D41itYzYnmDlxIKsOSgd8l+GJM4oeh
         PglzJVM4tbCwhCzQT9eU2kMr/zxF4wdtBeZwYAc8jeqeWLApkZ5a1fuzQYDiyqTTpKZa
         6iRA==
X-Gm-Message-State: AOJu0YwZR8QrY9vcVX4F0KA1z2Iv33MoV0MWYPYOHBnQjONmvBGTa0Ql
	c/28H36rzQIlaEBN/uwOqDwFPaefn66HGq5WxYvEJ1KdGseVM/kKE28/+x62UcdNSiy5EGl64ms
	Dg1AahDNI3TQ9HjDwwoWP8Fqwz/oynuz4gHBm3Q==
X-Google-Smtp-Source: AGHT+IE7hFc1H/dZ8sBI7S/rf48tDmVRYcqd9lHO9wKK7clV7JzcwwqMIYpfn4V27LAhBUoFoLlkKUr2/Q26nLL9qPc=
X-Received: by 2002:a2e:91d0:0:b0:2f0:32f1:896d with SMTP id
 38308e7fff4ca-2f15aabce68mr35889961fa.23.1722632854934; Fri, 02 Aug 2024
 14:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-6-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-6-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 23:07:24 +0200
Message-ID: <CACRpkdbY1V3Kw-Otrp=dHH6Q4ABnyHY8aP2bSF1UNHKRmDzRnA@mail.gmail.com>
Subject: Re: [PATCH net 5/6] net: dsa: vsc73xx: allow phy resetting
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:04=E2=80=AFAM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> Now, phy reset isn't a problem for vsc73xx switches.
> 'soft_reset' can be done normally.
>
> This commit removes the reset blockade in the 'vsc73xx_phy_write'
> function.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Like Russell says, it needs an explanation.

I think it worked because since the phy write operations were
not properly implemented, the PHY relied on power-on
or firmware defaults before, so things just happened to work
on some systems. We were just lucky things worked if we didn't
reset the PHY.

With some explanation like that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

