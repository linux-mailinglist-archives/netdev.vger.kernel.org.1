Return-Path: <netdev+bounces-280727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOmyEjsB6mk/rQIAu9opvQ
	(envelope-from <netdev+bounces-280727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:23:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FB54513C1
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21C5E301AF6B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734563E714B;
	Thu, 23 Apr 2026 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CW8wzeyJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t0PgTL0E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D93E3D9F
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943179; cv=none; b=ptw+oAF4NEQl6caQsxIpNANTYwu5ZXK4tY6qpRZATgI7kxwTlutc/GMlmJAthUSj6UlQdpLj1jEc8aYJGdFsxNdyb08+SpsHIU8te1aTSM+Xpc7+9kjZuyh23vFydcJIg0+vDRcwinxsR19RcMQrvYv2PB2DTPAJpxtddebST6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943179; c=relaxed/simple;
	bh=YzgqUvEkB3ELb/c4huxqlPLApTouDPjH3572wtEdlXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i31pM1YLSm16e+en4eTMQI/lrBEYFLhUrtXwMnDICvlLmWeOIXtD2pDj0snSnST21dcxBAss4or0EGmyWYGW7kZAV3s9qoWatM4CoivtG2yyNR3+rQkX6BCqheiuZ1kumCO/xc3KFB90NoqomsXyESw+zOhibw+DPF10IIsoELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CW8wzeyJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t0PgTL0E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776943176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kv1JJ0H+OUXUHdzQ3o5oEflmdhWCO48wnsej6Wx4hYw=;
	b=CW8wzeyJfE8N5vs18emwg/+PrXGOVtBmcB9lWv87PLT++Ibke9c2nYsKX4efCJ2W+wVeVk
	/Ny1t7NqJyQW1ZEbVO17y9zgZCT5qcHmPcFB22jDhw9eBcSQR8QZ7x9JwtCrFZUpEscZid
	yEdYZYEJj7Nikno9+HDc3p99t3maeEs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-2xEJ_TsZNCW69uxyAk13xg-1; Thu, 23 Apr 2026 07:19:33 -0400
X-MC-Unique: 2xEJ_TsZNCW69uxyAk13xg-1
X-Mimecast-MFC-AGG-ID: 2xEJ_TsZNCW69uxyAk13xg_1776943172
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35fb6cd0879so6257852a91.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776943172; x=1777547972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kv1JJ0H+OUXUHdzQ3o5oEflmdhWCO48wnsej6Wx4hYw=;
        b=t0PgTL0EBwZJIFhx4XQ8yc/CEUgYFq2BfqhSFIdJwtrgn5jbjqn3FZy4xPZ1HaDZl0
         Ga8KAnZ81gTOlJoHd6o1pLC1RkvyKJrjdYKJMv8gT6aHjZXx2o14/al6oc2j6PkbYMr+
         LSLJuiCVFhtyKZzd8ifH1Qzr3fS4rTcFapgE1j7yBSD3xdQrmTmQCOksq/9VrNDwkqkA
         xLBOvoJeUpNqaNLHyJ9QMAevzrba/HZ4PehytOiXjClp1FrtUCsA4qq8DYhxFHsycO2x
         DbQQccEyghcOuADcIsggfnREq+JOuZ3vVJacbHFDdSBCgH/W+FWqYSkjPhXJ51xKljTz
         M5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776943172; x=1777547972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kv1JJ0H+OUXUHdzQ3o5oEflmdhWCO48wnsej6Wx4hYw=;
        b=O6Sb5ljWdaSC6iq0W9SacvetP+/ja/kjSHHTemD5Kfpl1kSEbIBBmc1ceYPIJlW+ji
         yKHRgUOEk7gvGFLfh+NoCSnqmoVvGRHg+BySWLQdUOQzgfwJ8xOyKx9ythJDi6ue+qyq
         p9IEONB2FoAQvwy4U9ri1p0sDLhqOhjhERRhER2IGzFE7W0XJWfnD6i1GqHHouA+mq3K
         /fmzJm+DrgF6VAzOOvsWJpLwoxb0Ug4fl4MHUrnvB3LAjq03N4CB4r9ISkqdQYdlNPtE
         /SlxW0gYvjw9qhFzr9bkYUUufUOmuNtQCaGVvFG4jkt9yIEY8zmU79UMnxBf+pbvKCTv
         Zg+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/s/zHwbn4ybqCmTY3yRLBSGi+ELOrBMPG3QyRcxDB9RescFk/CIdeTT+29GF4pNbyhHfPVRzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/qys+GYNL2XDfSAa10kTQ27bWC6bUn/c1r3qMWKhneLAr6/G
	QqpJrv7JSl5LgtNJaU4wO5jdwfG4jpFg05d4J4jFCJjw4g0yUFMBsdMH1THc4XceZY0Uyhq7OFD
	AaepZ6jODnVl4ed2VABRu7mhDc/MprLN+/rDl+sR9Bl/M+RvE8QBAEt2j3w==
X-Gm-Gg: AeBDietw2Es4bu7xvymfc0TA+V49cmZGs+fIVxoNP1/BIsprLt8byExIWVGHfInULBT
	akebigRGZYI7awdoovIxy2NixfPh+H3NUdYDjOJhn2vQ+guBstpS3i4z8CA6PRhHEwAjZTJCoyX
	LXLq1DpTXNwPwFzH22QnBJ7GOv/EzOB15oqIFGFZjglmFCNijUnGOwskdZUf+xYHlzamFLscSCD
	M3BujJOwL7q0o9Zd5YTk07+mSm17K/gGKNW2eagKok4FRCyE25TZ1mOSKfDKPXzgfuduhSzSTXe
	mZLhSWzsKiv81b3RUPwGcxR7PxSsukXbkyNUwnpgf0kCMXlSC2xVmiPfFH4LFPgyCI4AilvuFzp
	7P2CTUaLD3yN2PuwapE3pTyCit8zbz14EAl102ayirjcxeANm5SU+4hf86lOBSqabYgQ=
X-Received: by 2002:a17:902:8603:b0:2ae:6092:8d93 with SMTP id d9443c01a7336-2b5f9f9469cmr215400645ad.28.1776943172244;
        Thu, 23 Apr 2026 04:19:32 -0700 (PDT)
X-Received: by 2002:a17:902:8603:b0:2ae:6092:8d93 with SMTP id d9443c01a7336-2b5f9f9469cmr215400385ad.28.1776943171748;
        Thu, 23 Apr 2026 04:19:31 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0db13sm205281755ad.53.2026.04.23.04.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 04:19:31 -0700 (PDT)
Message-ID: <2f6fd850-e187-4e63-9a32-6b4b72c09905@redhat.com>
Date: Thu, 23 Apr 2026 13:19:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
To: "Lucien.Jheng" <lucienzx159@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no
Cc: ericwouds@gmail.com, frank-w@public-files.de, daniel@makrotopia.org,
 lucien.jheng@airoha.com, albert-al.lee@airoha.com
References: <20260420134506.35164-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260420134506.35164-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,public-files.de,makrotopia.org,airoha.com];
	TAGGED_FROM(0.00)[bounces-280727-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,vger.kernel.org,mork.no];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8FB54513C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 3:45 PM, Lucien.Jheng wrote:
> AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
> Assert the MCU (hold it in reset) and immediately deassert (release)
> via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
> through a registered mdio_device at PHY-addr+8.
> 
> Add __air_pbus_reg_write() as a low-level helper taking a struct
> mdio_device *, create and register the PBUS mdio_device in
> an8811hb_probe() and store it in priv->pbusdev, then implement
> an8811hb_mcu_assert() / _deassert() on top of it. Add
> an8811hb_remove() to unregister the PBUS device on teardown. Wire
> both calls into an8811hb_load_firmware() and en8811h_restart_mcu()
> so every firmware load or MCU restart on AN8811HB correctly sequences
> the reset control registers.
> 
> Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB support")

The hash is incorrect, should be 5afda1d734ed

[...]
> @@ -254,6 +267,31 @@ static int air_phy_write_page(struct phy_device *phydev, int page)
>  	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
>  }
>  
> +static int __air_pbus_reg_write(struct mdio_device *mdiodev,
> +				u32 pbus_reg, u32 pbus_data)
> +{
> +	int ret;
> +
> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_EXT_PAGE_ACCESS,
> +			      upper_16_bits(pbus_reg));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_ADDR_HIGH,
> +			      (pbus_reg & GENMASK(15, 6)) >> 6);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr,
> +			      (pbus_reg & GENMASK(5, 2)) >> 2,
> +			      lower_16_bits(pbus_data));
> +	if (ret < 0)
> +		return ret;
> +
> +	return __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_DATA_HIGH,
> +			       upper_16_bits(pbus_data));

Sashiko says:

Will writing the lower 16 bits before the upper 16 bits cause the
hardware transaction to fire with stale upper data?
The __air_buckpbus_reg_write() helper triggers the 32-bit transaction
using the lower 16 bits as the execution trigger. If this hardware
behaves similarly, should AIR_PBUS_DATA_HIGH be populated before writing
the lower 16 bits?

[...]
> @@ -1175,10 +1281,22 @@ static int an8811hb_probe(struct phy_device *phydev)
>  		return -ENOMEM;
>  	phydev->priv = priv;
>  
> +	mdiodev = mdio_device_create(phydev->mdio.bus,
> +				     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);

Sashiko says:

Can this create an out-of-bounds array access if the base PHY address is
high?
The mdio_map array in struct mii_bus has a fixed size of PHY_MAX_ADDR (32).
If phydev->mdio.addr is 24 or higher, adding EN8811H_PBUS_ADDR_OFFS (8)
will result in an address of 32 or more.
Neither mdio_device_create() nor mdio_device_register() validate that
the address is within PHY_MAX_ADDR. When mdiobus_register_device()
executes mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev, could this
write past the end of the array and corrupt adjacent memory?

/P


