Return-Path: <netdev+bounces-288310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPzgBnQjB2oEsQIAu9opvQ
	(envelope-from <netdev+bounces-288310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:45:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8D8550B14
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE8F130EC10D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B97E2E3709;
	Fri, 15 May 2026 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1rErwQnr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB542DECDE
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850004; cv=none; b=kOtTz4cYvxKwW7SwyLG9B+n2iw6tzgXF/hSOFsIh5MSJhOa0RtQ2aDOuc/DZ/BGQendnSIn6gbzP8aEaruIsCYTDU0zYSJ5VdNhjmH8ZhI5PLv1DOuGvg7tDI+NyDDFyA5k0sbnCxtHcmz1KRT/CuYoAM3sVYkU62F7/T6Z459k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850004; c=relaxed/simple;
	bh=UJLvqzSDwwLyRjZD5gG5mNZYATJsWtjrmnjoryulM9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzj7D8QzYl3HedLbf4JZlU8DAoGy8Uszlfi1+wNaiL9T08az/14ECRGx+zZGrzGomB7oIRR2qO70F3yabwmqU1EoIrXK6+LaSifDSxitLBbVouTBiXQ36X8pR/Y1ojSc411tFLaaksx6NEgwf8I+Klx6v3DZX4A9kvep1I0dWh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1rErwQnr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bqFoJAYhOcuPQCiA0z9gbzKqgyvvr8P1ckx+vlPg9E8=; b=1rErwQnrXYp9q2OgCgxhihLojh
	XlkYmosB0V/6pL6/phT5eos3i1WubhPncSDdzzFozilUWrcpK6yo/uffXbZ0jhypCBwj6eX5TZGT4
	IgU9QyPSKH+K5Dnjv1r7IZxueEoGGIX6q1gjewbK+82llajNB8tqTBRJjzPskDgeHz0w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNs8w-00343Q-BI; Fri, 15 May 2026 14:59:54 +0200
Date: Fri, 15 May 2026 14:59:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liu Xiang <liu.xiang@zlingsmart.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v4] net: stmmac: avoid repeated devm_gpiod_get_optional
 in mdio reset on resume
Message-ID: <4a2c3023-ddc9-4729-a609-a648f1a052de@lunn.ch>
References: <20260515065652.46998-1-liu.xiang@zlingsmart.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515065652.46998-1-liu.xiang@zlingsmart.com>
X-Rspamd-Queue-Id: 5D8D8550B14
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288310-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:mid,lunn.ch:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,zlingsmart.com:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 02:56:52PM +0800, Liu Xiang wrote:
> During system resume, stmmac_resume() calls stmmac_mdio_reset().
> This results in repeated calls to devm_gpiod_get_optional() for the same
> GPIO. The second invocation returns an error since the GPIO descriptor has
> already been obtained.
> 
> Fixes: 7c86f20d15b7c113 ("net: stmmac: use GPIO descriptors in stmmac_mdio_reset")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
> ---

Under the --- you should include the history of the patch. This is
version 4. How does it differ to v1, v2, v3.

> +	priv->reset_gpio = devm_gpiod_get_optional(priv->device,
> +						   "snps,reset",
> +						   GPIOD_ASIS);
> +	if (IS_ERR(priv->reset_gpio)) {
> +		priv->reset_gpio = NULL;
> +		dev_warn(dev, "No reset GPIO found\n");
> +	}

Please read the documentation for devm_gpiod_get_optional().

There are three different cases:

1) A GPIO is returned
2) No GPIO is found in DT, which since it is optional, is O.K.
3) A real error happened, which should fail the probe.

Also, see what happens when you pass NULL to any gpiod_ method.

    Andrew

---
pw-bot: cr

