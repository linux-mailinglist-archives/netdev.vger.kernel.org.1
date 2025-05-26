Return-Path: <netdev+bounces-193521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6754FAC44F8
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 23:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311EA17C6D2
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28571DFD8B;
	Mon, 26 May 2025 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of8JEfnF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2619DF8B;
	Mon, 26 May 2025 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748295961; cv=none; b=A68MqJiQZHgNJVX/5GbRgGGyDAEC0BAozqqOsL3xZ8NWX81+pbkeuHvZ9qdX138dMOF3cX5G2dD9sRagEcnvMDojdDOn6pQ5InrtKFvx9y9eu6YIFX+5NVWa3/ugVw/ODdYdv660WZ523+Ze/BUW3S7YDzowcpS2tHkY0wVShm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748295961; c=relaxed/simple;
	bh=/IH4DYCOkaSE0nxb9v7Wn4qg7ALcjOOJbsMAOSjnx5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dnvj3ejzsUB2xPAVfhz07eS3jC6G1Iwie9yq5COuNz+cLa+30p3iKDMdMJ/GuRnmIUmKUfqSnLqYEKftDLNYwYxGFp3ZBqqsOMfB21a7zCXMQTNjF9Y+xG4JrBPXWt/fmHnkwjPXAc2bN9hkETpysgQ6DsrzOEb5yddzDngOtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of8JEfnF; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4c34dcdaf88so818173137.2;
        Mon, 26 May 2025 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748295959; x=1748900759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19reQAH/JFXrmKGSfsIuVcMSe5tUTaIhAmGB+5EzAyU=;
        b=Of8JEfnFp3XWCxMaTSx91Wv9uc5w5iTATPMQdU/y5dOSxGHU5PmL7Ya56IRhTVVcaC
         FT6g1/iWPchKBmmf6xx+sBHdhEuqdke297nJoXYp2EC1Wb4RU4mCeRzDMaBS762eDCmp
         G6MSwaVkP+pjv5dmFnJWGg9jVe8HphpZbj9AwxDmK7Z1JjkyULbR4xjl5dIssXjfgTK4
         ni4A4vvFoiKhGvMqKGjgfyKwwZ7cmg1W7ka9a+VpSY8YXqQAFs+fC7VhRFjjyHcz7yEJ
         ZeGUv5S1ORa3/VeAlQKwm/3UGf14OmfF1FFGiRf0cvJQFwdE4u07lou7RT2vmRbmzAQT
         FMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748295959; x=1748900759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19reQAH/JFXrmKGSfsIuVcMSe5tUTaIhAmGB+5EzAyU=;
        b=tEbdJS2yJEi/doebTXsSS11n68+pW4GN0781Du5qZt396Vlvv6OkZCVELSFQnSMupZ
         qL6EjYkz7xXpF32zHeRnEqvW/6v4Uqbe5hovFABE76uHk6xJ+QxJ9T/08QOa/fVuf+DW
         Xj1hZ8tS6BKok9h8+B2Ap0zgucM8EyA35EDzhChq18W9q8gBjufdvYJaqS35ssFXf+vP
         nFERhlYEtW+um6upQa9d5lLf/gUYXpkmQW68u9BqH8LIXkfqXFZCu0tdpwFFHyU2DloQ
         KFCGaW8rhkofiPrUqg+bVNi2qvAIbZ5Kqz4ZZXtA25oxcxDhFVaqHe3bCrvJi8WHSYnt
         Oqaw==
X-Forwarded-Encrypted: i=1; AJvYcCU1SRjonzH6Qo4oUIFTzevf4da0bY+gIgXTdqYj2c0KSfIpqd6rWc08fvHxmm5m5f25gD0fM2RTqzrfA1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRu/jQpW/QsIrnReFP61oCQipo6xirTjA0p53A0UgIl2J0dwTB
	xMa3kOf9vU/8C1CVR58wN6RlvF7/EkrJKziIbaS+6WHdfUgm7raaw7Ed/z5ZHE2V5DxtVVYvK5G
	Yh6H58Zcq7YuIbkt3emSgNWKvaIE/mM8=
X-Gm-Gg: ASbGncu1xNdYheLSYrKVbdZpSh0BX/fW3qEfwO1994UHXJl0ozSFwHF0+J8mRLDLfHA
	BF7zulXMq7+4QZGeK9VkSRlQpDcYbRnmtE77zUS7ZWQwUCr7G6bSJGwNk6fKY7/i+KXxHSWMbCz
	QmwFCXffoJQEJiHkeUvc/7hbYW+5ika31ktw==
X-Google-Smtp-Source: AGHT+IFotR6RyxU/ifwJ8AmbTwSsnUIU6QL7qlKuPNmt94jWJ9smNJz+SAYTONBfXHAq+tKlLbtbIPgWrf25oFYgN6o=
X-Received: by 2002:a05:6102:5244:b0:4dd:b82d:e0de with SMTP id
 ada2fe7eead31-4e42415fc45mr7977719137.17.1748295958811; Mon, 26 May 2025
 14:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-2-james.hilliard1@gmail.com> <a2ac65eb-e240-48f1-b787-c57b5f3ce135@lunn.ch>
 <CADvTj4rO-thqYE3VZPE0B0fTTR_v=gJDAxBA3=fo501OL+qvNg@mail.gmail.com> <5b7bf54e-4838-48b3-a357-70f117674523@lunn.ch>
In-Reply-To: <5b7bf54e-4838-48b3-a357-70f117674523@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 May 2025 15:45:45 -0600
X-Gm-Features: AX0GCFuEfLkt9AfTQ9ECVkRYk1pIwbklJGqsNyxbFKVvoc0OdxtNfymBf0iJQt4
Message-ID: <CADvTj4pt48o0wm-69WfkOtp0c-aP64DSwPFo=znY2Hk_N2ft1w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] net: stmmac: dwmac-sun8i: Allow runtime
 AC200/AC300 phy selection
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Feiyang Chen <chenfeiyang@loongson.cn>, Yanteng Si <si.yanteng@linux.dev>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Paul Kocialkowski <paulk@sys-base.io>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 3:22=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > The normal way to do this is phy_find_first().
> >
> > Sure, but there are problems with that approach here.
> >
> > The initialization sequences are rather different and the devices
> > won't be visible on the mdio bus until after they are initialized.
> >
> > The resets will be specific to either the AC200 or AC300 so we
> > need to choose the correct PHY based on the efuse value rather
> > than a mdio bus scan to avoid a circular dependency essentially.
> >
> > AC200: i2c based reset/init sequence
> > AC300: mdio based reset/init sequence
>
> O.K. so you need to post more, so we get to see the complete
> problem/solution. It seems to me, AC200 and AC300 are not compatible,
> so should have different compatible strings. That might be part of the
> solution. But it is too early to say.

They will need to use different reset drivers but the mac part is
largely the same AFAIU. The mdio part is similar after initialization
as well I think.

These are the vendor docs(I only found chinese version so far) that
have some more details on the AC200 and AC300 EPHY's:
http://file.whycan.com/files/202304/V85x/Linux_EMAC_%e5%bc%80%e5%8f%91%e6%8=
c%87%e5%8d%97.pdf

Translated important sections:

For AC200:
ARM communicates with AC200 through TWI, initializes EPHY, and then
MAC accesses the MDIO bus.
EPHY, PWM module provides an internal 25M clock to EPHY.

For AC300:
ARM communicates with AC300 through MDIO bus, initializes EPHY, and
then MAC accesses EPHY through MDIO bus. PWM module provides an
internal
25M clock to EPHY.

So the MAC to EPHY connection is more or less the same AFAIU,
but the initialization is quite different.

>
>         Andrew
>

