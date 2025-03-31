Return-Path: <netdev+bounces-178446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92B5A770E4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5608F16852B
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BC1DE4D8;
	Mon, 31 Mar 2025 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pzkxfby+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762F155725;
	Mon, 31 Mar 2025 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743460288; cv=none; b=o1Dac8OFhiQ/m12TEX5OAOyQlmSUMEBoiwc52gN2BYlZlC9lNjEhAjdPOBOLUPh6EL+guIsfwbXnIvN2C3sI0hzXnaVlFsuDKhqM0fmN3Zbj2OdmdTTc/SioBQW4nOCBrB3aPXBpdAOghtlGEu+TE1NNRJ9tDtm4vYhvwGh7XjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743460288; c=relaxed/simple;
	bh=/eph3P8RyPGameA3eIwpoUcHG51qfNue0hkqn9BsHgo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hqg4rELJO/WXmuvSibtBnjfA4o9L1wzNbHTqad2xzuziWMsDn/CFHOE+LYu3YVnm7ibLBy9Fr799tgP6XQeURxf8xn8gtY2XNGVZ7Q42HawAYazUK5uJpPQo292R3Hkfk599kV8JzUG+wg3QItrc3hq9zwR85ydUIhLb6PwoyTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pzkxfby+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22438c356c8so96825865ad.1;
        Mon, 31 Mar 2025 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743460286; x=1744065086; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/x38y9D+bvULPl9mRXR1jnQ3ZFxCTMyxYRseHkuGiqE=;
        b=Pzkxfby+RQTalq3Y3tkHx3msbH5Ph60wdFR2w33E0URk0fnf0jjtELd8EbvY57pqN+
         j9kH4+T561NmR6bd7HhYeZckniff9QkzD8K8TJGx0Tz46sO7SqizmWbq16BI9oKA13ln
         AMpj9UVbKjETdHS4/XqSSOCdPBbesUaX86iNeIJgJHYMHmLXCu3M4vrMtgS9yiJFyANw
         ttxb4K22nR4CQTulQzGYWfRnwJltot0QcZDQy2RR26JKoUew91dogFiuTOv1PViMb1hg
         JH9xbtG/9GTzQyhLXKnRr55VhEc1aEsQPRd5TLmy/W5g8Drgt59ocqT765cUqdMk2zRg
         NaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743460286; x=1744065086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/x38y9D+bvULPl9mRXR1jnQ3ZFxCTMyxYRseHkuGiqE=;
        b=ruZ1hkIm6ZvSsHAf1tHf9sM7ahUulJiC+Mr7aRNg4JaP6rdZCRNSRJ7TkH1P/Y9Vts
         bBA1VyrDAFk6o67yi9SqP0aBZBhUxlvbPwPgrC8/nbRFVKb7ELBcOtrxF7smp5/wm2Hx
         NcQj2yXXfLwZZ5TUsV6kI3isaeE5KfdrrehITFOvtPhyh4cCDBJKUW3ZUyP/zX9enofD
         otmoq6goOcD/TpdFJsb7Gz1exGM4T0WB2R9/H3bKLKAE90dlu5ZzDL1fGdIIJCFg6T7z
         I8c/WaKbznHbiK1WlZsxGqIUHJQml3fiW1GlkePQXYPu1qvg+c2QWErwm3zkkHCRTbk1
         NBeg==
X-Forwarded-Encrypted: i=1; AJvYcCUJD6ZLEt+3yqkcL+sg0wpPShokIIgpLMWMQ4/daXeApD/xqbXFfcYJCwONrQtJ2T4fbIscxu/4C171cn4=@vger.kernel.org, AJvYcCWxuH+mYk9bVDZqSkS1pGDCbxeKotGL/MAOXEPe4h7Wm1FY6+eZH6Lf0Plpoo9aEPWSgXjXblBd@vger.kernel.org
X-Gm-Message-State: AOJu0YzlGbJkOECL2yDBC5c3sF8jwDWW1SaHSuppuXyf9JxhGhL4mtyU
	VuU+/VVJa/LrPkW9Fq24gsvDEC1in0XxXUUUpWgASUfZULQrr3ds
X-Gm-Gg: ASbGncvPvY9YVrucApt50hLu4clW0XPn3jYUU0f8K5Db6WIUinGxZbgNaKqmiLlPD3T
	/pzg6mWz15cSYDCsH+9RnbdIFmePozHvI3DVoM8ZAekjKh3A3hCtAhGBwNOwy4tfs+/ezQ3qz4z
	QS8mz5vy5GVWALZp9Qh0PhTCjpIEECk8fohmYm1/3vNftlFOkaPLR7svAASBKdvQVAtJBtvCRg3
	u45yS34tEfBrbScWBMqVlROfBFkgYxgTcZOClMGjlUK29ejMTC3EJRAqf1OPgSd7q3feNbY8KzV
	fZ3WLCrDMD7hOR9fPQ6io08R2WQ+nza1jVz2b1QSJTtDs4IThpAKffKfxyGKB0b6o3iINWjGI8G
	GFvpMoeGFBmltusAitRcOA6cBmjfqwGUU7uo=
X-Google-Smtp-Source: AGHT+IF/JompVVPMEUWrVSbGF3Fm7fHmvyqZCfgc6BpS0nNlvNEwE++JBwgxQucv/KQpsd5yTnFYyg==
X-Received: by 2002:a05:6a21:7a4c:b0:1fd:f48b:f397 with SMTP id adf61e73a8af0-2009f649022mr18125913637.23.1743460285791;
        Mon, 31 Mar 2025 15:31:25 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73970deecbfsm7536215b3a.33.2025.03.31.15.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 15:31:25 -0700 (PDT)
Message-ID: <44f5c55e5fac60c118cb4d4e99b49e6bf6561295.camel@gmail.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,  =?ISO-8859-1?Q?K=F6ry?=
 Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Date: Mon, 31 Mar 2025 15:31:23 -0700
In-Reply-To: <20250331182000.0d94902a@fedora.home>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
	 <20250307173611.129125-10-maxime.chevallier@bootlin.com>
	 <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
	 <20250328090621.2d0b3665@fedora-2.home>
	 <CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
	 <12e3b86d-27aa-420b-8676-97b603abb760@lunn.ch>
	 <CAKgT0UcZRi1Eg2PbBnx0pDG_pCSV8tfELinNoJ-WH4g3CJOh2A@mail.gmail.com>
	 <02c401a4-d255-4f1b-beaf-51a43cc087c5@lunn.ch>
	 <Z-qsnN4umaz0QrG0@shell.armlinux.org.uk>
	 <20250331182000.0d94902a@fedora.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-31 at 18:20 +0200, Maxime Chevallier wrote:
> On Mon, 31 Mar 2025 15:54:20 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

...

> I was hoping Alexander could give option 1 a try, but let me know if
> you think we should instead adopt option 2, which is probably the safer
> on.
>=20
> Maxime

So I gave it a try, but the results weren't promising. I ended up
getting the lp_advertised spammed with all the modes:

    Link partner advertised link modes:  100000baseKR4/Full
                                         100000baseSR4/Full
                                         100000baseCR4/Full
                                         100000baseLR4_ER4/Full
                                         100000baseKR2/Full
                                         100000baseSR2/Full
                                         100000baseCR2/Full
                                         100000baseLR2_ER2_FR2/Full
                                         100000baseDR2/Full
                                         100000baseKR/Full
                                         100000baseSR/Full
                                         100000baseLR_ER_FR/Full
                                         100000baseCR/Full
                                         100000baseDR/Full


In order to resolve it I just made the following change:
@@ -713,9 +700,7 @@ static int phylink_parse_fixedlink(struct phylink
*pl,
                phylink_warn(pl, "fixed link specifies half duplex for
%dMbps link?\n",
                             pl->link_config.speed);
=20
-       linkmode_zero(pl->supported);
-       phylink_fill_fixedlink_supported(pl->supported);
-
+       linkmode_fill(pl->supported);
        linkmode_copy(pl->link_config.advertising, pl->supported);
        phylink_validate(pl, pl->supported, &pl->link_config);



Basically the issue is that I am using the pcs_validate to cleanup my
link modes. So the code below this point worked correctly for me. The
only issue was the dropping of the other bits.

That is why I mentioned the possibility of maybe adding some sort of
follow-on filter function that would go through the upper bits and or
them into the filter being run after the original one.

For example there is mask which is used to filter out everything but
the pause and autoneg bits. Perhaps we should assemble bits there
depending on the TP, FIBER, and BACKPLANE bits to clean out everything
but CR, KR, and TP types if those bits are set.

