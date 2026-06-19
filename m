Return-Path: <netdev+bounces-300721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9jEEI0pLNWpyrgYAu9opvQ
	(envelope-from <netdev+bounces-300721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:59:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C85096A639E
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:59:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=TtJGaiEr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300721-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300721-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A41C3021B08
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C0030676A;
	Fri, 19 Jun 2026 13:59:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF142DCBEC
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 13:59:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877575; cv=none; b=kHjcWPiZ81EQW/DiEuxLYIx3lHqQiKY2ryZ6k4yhdwdNdQT3fYhbxkoOAJRRxsdrOPDaoskpBWmICX7S0OPT2M427e5Wmn2yxVrwpB4Amoz6LlKSD4gSP1LxeIEfrJSe2XWL7y7vs+rTMR+Ul2C3pmjwDcRzdMgAwyi+BN1EkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877575; c=relaxed/simple;
	bh=M6XOBVqYNCyAP2+UukgzLFzwR8WmlzWVSsGzneKY1Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT8M6cpXs+FbM+LGVky1q3bTHU5EXCVLLsa3od3WqAygTqRdc4ZZaQs4dilwxrsEuTpRViU8LXEgFwojjGjz9uymRLVdipDfhfSGRq2MeFp/LyBZm7l8Z3xAKE2qeIAbzohPnz5+L/8o9/VPZ8e5/0qFpvQZv+E2f9L5FaGIne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TtJGaiEr; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso1524453f8f.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781877572; x=1782482372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFmcgWo6u0bUP8TJiUQg2GCEaR02GLGc4w/zuv0CGcI=;
        b=TtJGaiEr+E4AM8Dqd9RNvM3VZvErBB+WUxnQQ6Pz73m7JQtitfPK/bdFXT2RIx1/IP
         Hu7Q3UAQU2FQNvTfppWMcVVi4MpQSlO6qD3JWpA7UdnBxQXyv52+bVMuPHcQGO3sML37
         hwprvGZWZUZdZeDbhfC4W7Hy7wto8jKQojuekDSEGJuZK4l5BMNisoHxkbz6NCYQEVzC
         CJKL09jBE682+PO03uJrcA+/aWo9a7DfJA/m9Myi784dQdxOKoCfxRvD0bdmEX82dtHd
         +54pV98H1++414qQTGcYndYr/3x74y+h+BJ6AsqKmnaJu1KA8yN7qYU0/g28ldsDY8kV
         ZMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781877572; x=1782482372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFmcgWo6u0bUP8TJiUQg2GCEaR02GLGc4w/zuv0CGcI=;
        b=MtWst74ZSAf/w6AkR3RtknLvTHn1t/nm2FMPmveZgbb/DH8clfeEQtQeYxdSYdyD+h
         A3z0sEWBBeOCb9lSkgES3PTyYkZihq7iUXr6DtPI0dtmHPZ8CM8UK6YtKKiDSrQ0AIeT
         bZf2uytjdOfshMgUQ8CQii09rw7lkvvj2tAAiH/vAVMUcLGoW+MHJk0yRO90lg0suoxJ
         sD5k810JGS9OmS2tdHYmAWh7StwKWq4QU+j6qj7aanklH88usYMcGBZHmoYz+HzJpsWk
         Cvo4F9+s1w4Z3Xy7dYaKmeIs4IPAW2wlu3lLA5XFTU8920YTi/4u7tmA95T/xaiiiFyN
         euaw==
X-Forwarded-Encrypted: i=1; AFNElJ9qbfmhjpnZsx18ZUlT18wdnQDRWxdP8xTs+IKObCrByeUo8IB9rJIM0n1a75J5KMfT5YnVeEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAo09viYtBwwQ9yhvccf8xmq27AuoLbwzTIlHvllxGKkF3AKDz
	CpuboCc2VgowA10zOCEU3aCvBUfCjUVhIHV4pPWSOSY8MDPBxx4cHk68l+USc1QYIm4=
X-Gm-Gg: AfdE7cnUNhNCvvVTLjsXSZggo3bMTi19Ysyyh/5Kf7xqlXqwmpMcbxhsUM3wIVbOq4T
	+C7hFcQtP5WgO6f1TimQ6K8otZx9ddcpNQy3zRgp4oh2hq7VVYx+KEfoW+KvSFxHsEQ1kgzH32+
	bVxZtv/BXNF+E2kraHUzCoZD2iYwLanpzu37fuY5DY6OO2lk8XJYvHyoSuOHIsV43eEZ7H16TdP
	x9qGxp/9fh1JN2PHUHgZj94D/B067Mwo2hEUxwM8lLWVYK8mWZnKZqMoq47nXXEj7qlrhDr/ZxD
	tGNk2Z5ZyTgwsoNoc4GvYzqgnnrMhVPO5Mj0NQW0KqcSRhidvvi8W4SED0Xbfg1ccPM/Fcjtbwj
	wOAbaJx01Uk4zMuFMnJocJX12rCR3xGExd4NH9x9RQ0uWYAoA3R7JFOeydgQrWGuafOE+p9lPOT
	2gt8ODjd++Z0Yc+4Ub79NAiEGlPz6CF1fMQt2IB/UtsdYzDdkyErkuZF28MbUXj0V9j8ianKeqF
	0k=
X-Received: by 2002:adf:f6cd:0:b0:45e:ec17:430a with SMTP id ffacd0b85a97d-46507102de3mr5698705f8f.11.1781877572252;
        Fri, 19 Jun 2026 06:59:32 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4650bc429a1sm8133882f8f.30.2026.06.19.06.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:59:31 -0700 (PDT)
Date: Fri, 19 Jun 2026 15:59:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Selvamani.Rajagopal@onsemi.com
Cc: Andrew Lunn <andrew@lunn.ch>, 
	Piergiorgio Beruto <pier.beruto@onsemi.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v5 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Message-ID: <ajVKfBKPuNk9zN7b@monoceros>
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
 <20260614-s2500-mac-phy-support-v5-12-89874b72f725@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vgihchiky4pi5wmr"
Content-Disposition: inline
In-Reply-To: <20260614-s2500-mac-phy-support-v5-12-89874b72f725@onsemi.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300721-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[monoceros:mid,vger.kernel.org:from_smtp,baylibre.com:dkim,baylibre.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,onsemi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C85096A639E


--vgihchiky4pi5wmr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH net-next v5 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
MIME-Version: 1.0

On Sun, Jun 14, 2026 at 10:00:28AM -0700, Selvamani Rajagopal via B4 Relay wrote:
> +static const struct of_device_id s2500_of_match[] = {
> +	{ .compatible = "onnn,s2500" },
> +	{}

s/{}/{ }/

> +};
> +
> +static const struct spi_device_id s2500_ids[] = {
> +	{ "s2500" },
> +	{}
> +};

Please make this:

static const struct spi_device_id s2500_ids[] = {
	{ .name = "s2500" },
	{ }
};

> +MODULE_DEVICE_TABLE(spi, s2500_ids);
> +
> +static struct spi_driver s2500_driver = {
> +	.driver = {
> +		.name	= DRV_NAME,
> +		.of_match_table = s2500_of_match,
> +	},
> +	.probe		= s2500_probe,
> +	.remove		= s2500_remove,
> +	.id_table	= s2500_ids,

Tastes are different, but the idea to align = is usually screwed by
follow up patches. Here it's broken from the start. If you ask me: Use a
single space before each =.

> +};
> +
> +module_spi_driver(s2500_driver);

Usually there is no empty line between the driver struct and the macro
registering it.

> +
> +MODULE_AUTHOR("Piergiorgio Beruto <pier.beruto@onsemi.com>");
> +MODULE_AUTHOR("Selva Rajagopal <selvamani.rajagopal@onsemi.com>");
> +MODULE_DESCRIPTION("onsemi MACPHY ethernet driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--vgihchiky4pi5wmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo1Sz8ACgkQj4D7WH0S
/k50xAf/Zh/5TUve8B01NSTYsEN/FHNN2Ll/KSVNoRTgKx8ImFNr2/o/BEgi6GhK
pfNVfy1Xf+GanFXibebKU1VQX7LuHvcyYGXnkzwA+qObF81/JvZWwiqHK6NykReC
tPMNc83BEKNMA764MoqvoZaSukhGUvby5CBMSqupfKgxZ+c/b2FC6E8Hk977oKEZ
J1nZQGEdCQ+b2/m4sQLbwxIZpra7CFVd9q6ke8JkqV29pA0koqFQwfaB1r0LGIIr
jTGPN/so0SIMhZulEk/kK3T0f3Z71a3YD7xc3O9tJE5MYexsTK49ZJNV+aGtvirE
zLZ+IsKQC1b+FCzKBDKhYFsysIB2Mg==
=Joyu
-----END PGP SIGNATURE-----

--vgihchiky4pi5wmr--

