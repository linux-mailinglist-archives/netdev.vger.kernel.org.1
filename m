Return-Path: <netdev+bounces-275913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KpBJ0nJ1Gk0xgcAu9opvQ
	(envelope-from <netdev+bounces-275913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:07:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A0A3ABC01
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A3A7300D44D
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8539B979;
	Tue,  7 Apr 2026 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stgpB9oZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F5538E5D7;
	Tue,  7 Apr 2026 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552824; cv=none; b=Fjqn5F3tvwdbpjlztTpPGuT06IHr/SKijnLgT5w9K/of2l5+7WHfUT8hj9LxMZMBmxvVbSwBDLoFrcKSGiJ0dH4492GZ01nhs8+FDajWkfnWKOUjdUxG+/NTHI4mo+G7B1NO3T+W7/EQp7NS8geTaDY0P1UhIzUlbro5/6ItaSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552824; c=relaxed/simple;
	bh=4NERHreOtOHtxPxrg9hJfCL0sb0Gtcuiwi8WJRXUxIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFtxhR/QJQxqgQ2dNubztVIMgRaO1lz/GLGxP1nkGZHOW58RH2sCnk5ZZ4cm5Ct4HgZpTnd5hVEUF5Ry1vat0sl3IoB/Kp2zL9j9kI9jpsY59u84CzShyeu1zkgkktC64z1TZ7Ec9Cl0XeL8RVufip268nRANd0iDKFDP89Hcyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stgpB9oZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41DDC116C6;
	Tue,  7 Apr 2026 09:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775552823;
	bh=4NERHreOtOHtxPxrg9hJfCL0sb0Gtcuiwi8WJRXUxIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stgpB9oZ+np9GYARlzUA9ZMs/QvN4KIBqwa1qRYDAwyfYPqyHDzuHCzXPSnlyzgtg
	 EAHXWcSv4E0rrXHIwU/F9B+i1mivT8/hiuEewvUz63bUM7ytEH5SQzK2thj+lYKQTs
	 o2tisu8aVFvQIZG+/d8iAyn9lfuaOQqIZdUeq7k3DZiLr0hgqrYjSRZ2PwzXfNPDL4
	 eowKFIJwq3yekc5lX5NoSnG1UiqaPzINQrHDk6adQBuAm9YxWQDDa+YyftbK/zR8JS
	 kxyiSzhZcnKMojNpglf1PuMqJl8hSj8Ux7HAXRlz/T13loQq/CWQfn1V+eHwkI8KMb
	 5kNMKJjzp6Bvg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA2Oi-0000000AjGf-2EeN;
	Tue, 07 Apr 2026 11:07:00 +0200
Date: Tue, 7 Apr 2026 11:07:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>, maz@kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Mark Brown <broonie@kernel.org>, alexander.stein@ew.tq-group.com,
	andrew@codeconstruct.com.au, andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com, astewart@tektelic.com,
	bhelgaas@google.com, brgl@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, driver-core@lists.linux.dev,
	hkallweit1@gmail.com, jirislaby@kernel.org, joel@jms.id.au,
	kees@kernel.org, kuba@kernel.org, lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux@armlinux.org.uk, mani@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, robh@kernel.org
Subject: Re: [PATCH v5 8/9] driver core: Replace dev->of_node_reused with
 dev_of_node_reused()
Message-ID: <adTJNMhsghRs3qwy@hovoldconsulting.com>
References: <20260406232444.3117516-1-dianders@chromium.org>
 <20260406162231.v5.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406162231.v5.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275913-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,rowland.harvard.edu,ozlabs.ru,google.com,lst.de,arm.com,intel.com,ew.tq-group.com,codeconstruct.com.au,lunn.ch,linux.intel.com,tektelic.com,davemloft.net,vger.kernel.org,lists.linux.dev,gmail.com,jms.id.au,lists.infradead.org,lists.ozlabs.org,armlinux.org.uk,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26A0A3ABC01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 04:23:01PM -0700, Doug Anderson wrote:
> In C, bitfields are not necessarily safe to modify from multiple
> threads without locking. Switch "of_node_reused" over to the "flags"
> field so modifications are safe.

This flag is only set before registering a device with driver core so
there is no issue using the existing bitfield here (with the caveat that
PCI pwrctrl may have gotten that wrong). I haven't checked the other
flags, but I assume most of them work the same way.

But apart from the commit message being misleading, switching to using
atomic ops and accessors for consistency is fine.

> Cc: Johan Hovold <johan@kernel.org>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Not fixing any known bugs; problem is theoretical and found by code
> inspection. Change is done somewhat manually and only lightly tested
> (mostly compile-time tested).
 
> diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
> index dab8f1ab4450..40e0f1a7ae81 100644
> --- a/drivers/regulator/bq257xx-regulator.c
> +++ b/drivers/regulator/bq257xx-regulator.c
> @@ -143,7 +143,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
>  	struct regulator_config cfg = {};
>  
>  	pdev->dev.of_node = pdev->dev.parent->of_node;
> -	pdev->dev.of_node_reused = true;
> +	dev_set_of_node_reused(&pdev->dev);
>  
>  	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bq257xx_reg_data), GFP_KERNEL);
>  	if (!pdata)
> diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
> index e66408f23bb6..8297d31cde9f 100644
> --- a/drivers/regulator/rk808-regulator.c
> +++ b/drivers/regulator/rk808-regulator.c
> @@ -2115,7 +2115,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
>  	int ret, i, nregulators;
>  
>  	pdev->dev.of_node = pdev->dev.parent->of_node;
> -	pdev->dev.of_node_reused = true;
> +	dev_set_of_node_reused(&pdev->dev);
>  
>  	regmap = dev_get_regmap(pdev->dev.parent, NULL);
>  	if (!regmap)

These two uses are broken currently though and should be using
device_set_of_node_from_dev() so that an extra reference is taken to
balance the one dropped by the platform bus code.

I'll send two fixes to Mark, any merge conflict should be trivial to
fixup.

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan

