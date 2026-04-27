Return-Path: <netdev+bounces-281320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J5oI6xd72njAgEAu9opvQ
	(envelope-from <netdev+bounces-281320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:59:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD5F473061
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4066A30022B4
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B28355F36;
	Mon, 27 Apr 2026 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nHmAfCGj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D630E0F8
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294490; cv=none; b=feaszmsKf8of6e13trfabu5+Nev7xg+2jodbvcqP3NMXI58XV1QAYpBasVkvq63eWI2LbkP1W7xsXcwwBDoQ7N8AAzw6GNcB8nlaIXmJd3qzTSpORAeH/A/PqAkrh90BbAy1XmJdLMa+LCs5oh4W+jLlKemudfQJxC2IETnfaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294490; c=relaxed/simple;
	bh=Y3zdBii9jLf4CJ8nTegVSlBuH2ASjzmHCb8/46CogcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzK6Z88EDYl1IsCOgp+qY1BYx6X068Qp437wey5XpaxGEbL8QAReC2qd71Wzs7KvDu9QwRC3ORZbCs3RV6ua+1unj31QJBDrWfy3jKNCVfk0SJl7JABfxSe2BKYZvliQw5Ip7rczl3U0Wf4+ZY5Ja1H6AwmMCMly5yj4uB2sZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nHmAfCGj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZoycNY8oXT+d+FPMZ18Xk6yJ6FCE5nMNcpYetdV0NDc=; b=nHmAfCGjJRl+QsmnKfJTgJQ9iH
	0ILI7loTOkkcJ7IvYXMWekVA8aWJNTR+wlzFiilRse1F8emHbVzWeTUZ7KU/8mqXmJh64JYh7yGln
	BD+g4DQRGZzQxH7yGKyk+03sBncnqt+4UIGurfCRp1WCOJyd3Jn5Lw8C+WTLRZOsBH9E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHLU4-000A53-5r; Mon, 27 Apr 2026 14:54:44 +0200
Date: Mon, 27 Apr 2026 14:54:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liu Xiang <liu.xiang@zlingsmart.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v3] net: stmmac: avoid repeated devm_gpiod_get_optional
 in mdio
Message-ID: <20472367-4e8f-457e-a87d-4c3ed8c2cad1@lunn.ch>
References: <20260427075032.10442-1-liu.xiang@zlingsmart.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427075032.10442-1-liu.xiang@zlingsmart.com>
X-Rspamd-Queue-Id: 6FD5F473061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281320-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 03:50:32PM +0800, Liu Xiang wrote:
> During system resume, stmmac_resume() calls stmmac_mdio_reset().
> This results in repeated calls to devm_gpiod_get_optional() for the same
> GPIO. The second invocation returns an error since the GPIO descriptor has
> already been obtained.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>

Should this have a Fixes: tag?


>  #ifdef CONFIG_OF
>  	if (priv->device->of_node) {
> -		struct gpio_desc *reset_gpio;
> -		u32 delays[3] = { 0, 0, 0 };
> +		if (priv->reset_gpio) {
> +			u32 delays[3] = { 0, 0, 0 };
>  
> -		reset_gpio = devm_gpiod_get_optional(priv->device,
> -						     "snps,reset",
> -						     GPIOD_OUT_LOW);
> -		if (IS_ERR(reset_gpio))
> -			return PTR_ERR(reset_gpio);
> +			device_property_read_u32_array(priv->device,
> +						       "snps,reset-delays-us",
> +						       delays,
> +						       ARRAY_SIZE(delays));
>  
> -		device_property_read_u32_array(priv->device,
> -					       "snps,reset-delays-us",
> -					       delays, ARRAY_SIZE(delays));
> +			gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +			if (delays[0])
> +				msleep(DIV_ROUND_UP(delays[0], 1000));
>  
> -		if (delays[0])
> -			msleep(DIV_ROUND_UP(delays[0], 1000));
> +			gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +			if (delays[1])
> +				msleep(DIV_ROUND_UP(delays[1], 1000));
>  
> -		gpiod_set_value_cansleep(reset_gpio, 1);
> -		if (delays[1])
> -			msleep(DIV_ROUND_UP(delays[1], 1000));
> -
> -		gpiod_set_value_cansleep(reset_gpio, 0);
> -		if (delays[2])
> -			msleep(DIV_ROUND_UP(delays[2], 1000));
> +			gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +			if (delays[2])
> +				msleep(DIV_ROUND_UP(delays[2], 1000));
> +		}
>  	}

This is not obviously correct. Sometimes it is better to change less,
so the diff is smaller, and so you can look at the diff and say, Yes,
this is obviously correct.

What is actually changing here? The devm_gpiod_get_optional() should
disappear, and reset_gpio is replaced with priv->reset_gpio. Does the
indentation need to change? Does u32 delays[3] need to move from
outside an if to inside an if?

So if i stare at this long enough it looks correct, but please try
again, and see if you can make if obviously correct.

    Andrew

---
pw-bot: cr

