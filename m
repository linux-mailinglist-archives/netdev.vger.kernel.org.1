Return-Path: <netdev+bounces-195344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B65ECACFABF
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 03:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6377F7A403D
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 01:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDCA33086;
	Fri,  6 Jun 2025 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za9LNfoa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF914286;
	Fri,  6 Jun 2025 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749173542; cv=none; b=PC0iKm9gij0ow3t/c/q6aNz9mew3goW1mV09MuOP6YwcRatq2R9wZpVTnM+mBKHJeIiA0ueiF216fmx3Dkns1AQP1QXasRPaKG3SyTNgZBs30kKMLJQkkWL2SGrpU2vWqHXeL5UebRUzby1S1YIItYm8EP6DS3Xd1O1DlLy2PwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749173542; c=relaxed/simple;
	bh=usjHo3a3Onjh88f0YaGS0D3CtdBMIoHOMahg0MhHQOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmyLb7XOOmid0dDdQUNZT7mblU8BoBA+M3gHH1uA+B8RuHdk3Ifff8NWF7PbvDXAo20NaBjtygA9JWrggvo/9giTUhAeiOQ7Gk2R65BAE8Cmm0xXLvQ8GL0Z86jMtBcuD7lI2g/QokW4vYiK4EIOAoTHmL89w6z3wfrBJXUsZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za9LNfoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311D3C4CEE7;
	Fri,  6 Jun 2025 01:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749173542;
	bh=usjHo3a3Onjh88f0YaGS0D3CtdBMIoHOMahg0MhHQOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Za9LNfoavOoK+/3s1iRK9eiLPy1oM0eFzU/nH6RLIHumNAlC88jRQJC3DgtfDI1La
	 nG5b6Vk+VuT738s7cKpOuEvsYnTDbTYDaEg4HYoT5QdgrbK99cPgj54hy9BB+1zYGr
	 fwp3/ts/xpDwfHsxOplwud8IqnVnBXaMStBEomN8xIrEZ9gQRdbBAkrlfKGFayrdl9
	 qxnfLzTPH7tCiifj+FKSy0tuPMo+BmElrgrBl02ush5L3tb5YbhgypW62ELi6G6Y1O
	 atLCOE8Zjh00UdaK0BeSSwr+a5x+ITjbIQg/LhkOSfG3bDzL3hQYuHKsma4oBR4uoH
	 LRaiv+qr1YR4g==
Date: Thu, 5 Jun 2025 18:32:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v12 05/13] net: ethtool: Add support for new
 power domains index description
Message-ID: <20250605183220.1cf1b00b@kernel.org>
In-Reply-To: <20250524-feature_poe_port_prio-v12-5-d65fd61df7a7@bootlin.com>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
	<20250524-feature_poe_port_prio-v12-5-d65fd61df7a7@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 May 2025 12:56:07 +0200 Kory Maincent wrote:
> +	if (st->pw_d_id > 0)

nit: here..

> +		len += nla_total_size(sizeof(u32)); /* _PSE_PW_D_ID */
>  	if (st->podl_admin_state > 0)
>  		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_ADMIN_STATE */
>  	if (st->podl_pw_status > 0)
> @@ -148,6 +150,11 @@ static int pse_fill_reply(struct sk_buff *skb,
>  	const struct pse_reply_data *data = PSE_REPDATA(reply_base);
>  	const struct ethtool_pse_control_status *st = &data->status;
>  
> +	if (st->pw_d_id > 0 &&

and here -- it's unsigned so just if (st->pw_d_id &&
no need to add > 0

