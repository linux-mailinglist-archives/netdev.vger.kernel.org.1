Return-Path: <netdev+bounces-300075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IwQPF3xdMmppzAUAu9opvQ
	(envelope-from <netdev+bounces-300075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B999F6979EE
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:40:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=Xb8hVNsd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300075-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300075-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BED3330316D9
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E43392C46;
	Wed, 17 Jun 2026 08:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCA392C56
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 08:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685623; cv=none; b=o7HZ1YKwBd/dM2LcRpCZmHT6i1zSKylAYW4IcnAdXp1n0o9JsVzNTH/kWiQBEJWp+su64nT6b8MVCBFlJEHS4RAswcs32UT54M39aW6gGahkn4h8AKD6/Ec+bKOOIJTw1c9Oz3NpK62Tmaivy+vJA5AcmBUYXe2zfVv74lZJMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685623; c=relaxed/simple;
	bh=De2vm6RyRU0iSQKNzaduSyNa+wrDdzJVxawvD4Hxjh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJAecaZ8xXYTEoTopFbOWwOk8hc4Pmb7aAIwXk1HOoRH9sDPTXMS1n7rmmlsSYcWFjWGxpoZF8ZldIcBuMog5c8nVY13o+cZsncprR24BPoZFQoU9OI0aECsTFqMgq8rF68gvEebZHt8a2JQykTdD5qMbxcvLfTJysXJz3a2SpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Xb8hVNsd; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45eeea039ebso3130113f8f.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 01:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781685619; x=1782290419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=idF8TdiXvEwuoIpI0e/Gphntv25+7UUd8M2Ri2FF3/I=;
        b=Xb8hVNsd0pwgKsfFiLK7+3VOli8GpzDnzdgpnPkDOoFzmWHBBPELf+T3YKx5d4fNQZ
         zl3LHwyfd3ouRxec19H9VrMAnKDVZO5fHH9dYnbS48saVkpIEt6QNWln5InyRpEAt4pS
         xfF/DspQFSDXAiQaZAcuGZg4igyWZfr888GX9rvTfWISZZ+nDrDFJBmZOe5+aCAk68MP
         HGgV/HaDISem5CgufliWUK8lJ2SGYg7/U6h6iUQjp3mGLAdPXUDlNuL1EKRzXSUuJ4em
         59jqBsAt9DUSJ8FUUuBHXLoxI+OHXHjKZnKAd4YrFVYtX6J0qg0pf/8ycJfBfr+pXhdZ
         0p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781685619; x=1782290419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idF8TdiXvEwuoIpI0e/Gphntv25+7UUd8M2Ri2FF3/I=;
        b=cFNitiu9DfEgMBJDqcKIZKZY/IeD7VWm19sQ0TbdGCQvMSZjTLgDf92qOoIpNQyo7D
         DpB7KnadZ1cFIU+IIPrSh6FqIsEYnJtfPSt759aky1lVYFDjntl7ZRb9zhyL7dWAaNu+
         6IVZHfje9m7vXEzllHJZrax+nFDwyJAVNJOSzAnx0LOfn13jq9dwn1d7sr1bxsmdBlhp
         O1vx/4DgIiUi/wv2tVTMPRpLNc0vxNXT51awDnXZnMAqqHq5ckSLulDm+BOd7wDYc3EE
         JUwiWsxFJsUaof1f2N+2uG4yb6BHMdkaTJbhCe8ifwMz7sSnmGx/n+I/h3v/9fo6D4mS
         zWsA==
X-Forwarded-Encrypted: i=1; AFNElJ+uwWFbYecvyh2oVH4Gv/b+wZO6l5XDu2NR7ydiULThhD7bcKKatdZJ+VCTodGC4nlZF8F2LoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIO0dF3PaKSPmAJ0qZ5jPtJWNDUqVw5WNaEgSma9WBAamAVIfH
	SFhskn3x/FGwHkbNrLgSqII4s5DaWyw4EtJsquHIEMyAqiFlpCBEQIL5R5HzZgyHJPo=
X-Gm-Gg: AfdE7clQoXdEeyJ+n/O2vpv9V9f/95x0rcBU6q5xNZq9tZTlb/n7rWWuhk0DlgN6X9E
	9PsCiCliH5bOm9NrefJ+HZSGzOPOKSA+mFSejnLXwoXbsAAedGBu/XN/BEjRHPNxL53KwfUIYEP
	GCGogW0BgEyJ2PSnAU4crfZ+Y3kgrIiNfCh5x/CmtMa6qJokPpePO2MaDqSQVK9FNBqCvz7xWcx
	aHcMVvmaRLsDz4qwABMYEJMpOKPGxutqps4Pub9zmW0mTmcf3sgpW5aeHGJLqk2nxKq67xcK302
	GkxOEhe5uESkkr1knwhqarhKlCxiKlE8pmxX+hnP8uiIMjARp5uDPpZ7KiGI8RQJFqD9AitcibB
	eMBuPx8Tdb5MWljmTGiz7e0jaxmqKOQDaxtCZEuZ2TV1ICGyIoCtCKtlafFAMEosAPb8xofh120
	IiYIzLmsAiGngz6uesv7TXX9uX99RVe+lnPgjyoKSYP4jkZ8D0a8JU9pId9m2Ecqz/A4XddVlA1
	Lqs
X-Received: by 2002:a05:6000:1889:b0:45e:f31a:7ae6 with SMTP id ffacd0b85a97d-46238f97e32mr5037115f8f.30.1781685618753;
        Wed, 17 Jun 2026 01:40:18 -0700 (PDT)
Received: from localhost (p200300f65f47db04bc2080ea3c93ea6d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:bc20:80ea:3c93:ea6d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-462236047c8sm7325308f8f.10.2026.06.17.01.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:40:17 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:40:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com, 
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch, corbet@lwn.net, 
	kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org, pabeni@redhat.com, 
	vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, edumazet@google.com, 
	enelsonmoore@gmail.com, skhan@linuxfoundation.org, hkallweit1@gmail.com, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v18 net-next 01/11] net/nebula-matrix: add minimum nbl
 build framework
Message-ID: <ajJbmSZpmvOtYnG7@monoceros>
References: <20260611044916.2383-1-illusion.wang@nebula-matrix.com>
 <20260611044916.2383-2-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a23ql32okbup4l6b"
Content-Disposition: inline
In-Reply-To: <20260611044916.2383-2-illusion.wang@nebula-matrix.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:illusion.wang@nebula-matrix.com,m:dimon.zhao@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300075-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,monoceros:mid,baylibre.com:dkim,baylibre.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B999F6979EE


--a23ql32okbup4l6b
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v18 net-next 01/11] net/nebula-matrix: add minimum nbl
 build framework
MIME-Version: 1.0

On Thu, Jun 11, 2026 at 12:49:00PM +0800, illusion.wang wrote:
> +static int nbl_probe(struct pci_dev *pdev,
> +		     const struct pci_device_id *id)
> +{
> +	return 0;
> +}
> +
> +static void nbl_remove(struct pci_dev *pdev)
> +{
> +}
> [...]
> +static const struct pci_device_id nbl_id_table[] = {
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_OCP),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_OCP),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T_OCP),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T_OCP),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_BASE_T),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_OCP),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_OCP),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_BASE_T_OCP),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T_OCP),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
> +			 BIT(NBL_CAP_IS_LEONIS_BIT) },
> +	/* required as sentinel */
> +	{
> +		0,

Please drop this zero. The most usual style is `{ }`.

> +	}
> +};
> +MODULE_DEVICE_TABLE(pci, nbl_id_table);
> +
> +static struct pci_driver nbl_driver = {
> +	.name = NBL_DRIVER_NAME,
> +	.id_table = nbl_id_table,
> +	.probe = nbl_probe,
> +	.remove = nbl_remove,
> +};

The pci bus probe function has (pci_device_probe() ->
__pci_device_probe()):

        int error = 0;

        if (drv->probe) {
		...
	}
	return error;

So given that the probe function does nothing apart from returning zero,
you can just drop .probe(). (There is an additional check against
.id_table, but I'm pretty sure that isn't relevant because
pci_bus_match() already makes sure that there is a match.) The same is
true for .remove().

Best regards
Uwe

--a23ql32okbup4l6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyXW4ACgkQj4D7WH0S
/k4b1Qf/VkdAm0QAaJj1mxlAEWnW5vEI6PU2OQ2r1Zpjz5AtXue+SZQKUYEocLkO
vfpxbrIRBEdWfRwzDD6nUSVHdrskz0thY+6sMBKApTmS87u0rZ2XfowILGKC/Eaj
W29cjxuTVBQCqJ2uaUA2mULbwsA4aSPN0OvBFdKlA6zsfr93M7LZjTCi05nPEnnb
sL7Kucgndltp43joiX3lRh3Mn9Rp9cQ/Gvpd47ndkS/af8MLqTCNVA6kiqX3n9fb
sbw3evzS4V+U13JMFtF2JlBdsD01ikSJqo9MxQSzBf0zBZ3i+Zo7BR1b9xZcoPju
ifnPegSEJcnE5swPqal9zV+L0MiuOg==
=2nso
-----END PGP SIGNATURE-----

--a23ql32okbup4l6b--

