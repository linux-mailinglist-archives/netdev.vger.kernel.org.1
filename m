Return-Path: <netdev+bounces-281010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKv3H6WS62lGOgAAu9opvQ
	(envelope-from <netdev+bounces-281010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:56:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE99C4610EC
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42F5D3008D0D
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAEE3C2794;
	Fri, 24 Apr 2026 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZhC0SGd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0EB3CF697
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046169; cv=none; b=ILiXLSajOAV1u44PXfCfpu5dm4F0ZlNE1Gxh9u1AYRuwYlhzjWjeU6BMP0OwcIieRy/BWkrhmitwLBss8OMOiwdcqNNiaAJ7Dx22tYzvj4reEF/l21jscnCzV7sE74/V+dihHmxkZxLPHEmPWT82/vQWDCBhnAAjuxX1f3AGskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046169; c=relaxed/simple;
	bh=8/pA7xf/cW18UNiyVoPNBFYLDRY5aiSy+Q13RphUShg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmqkeEIWR1aKG0U55n6g/709gqsd6cmx+DcDiKoBa/qhwoe61BGKo6Q+4XjCbrIvJzdS30Os5YDiVUPnLI2n/BfwhOSJBvkroWZGRAoNz6WSvUDqv1TIk4WOjw9DXPorfbUP+tDqZqNgmHeI4Nqxts/FQlj97k7S+JSDLR9OtCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZhC0SGd; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c7971d0d97dso4739295a12.1
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777046167; x=1777650967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6apAuausA1UMgxW+RA+bbqT9q3F9cbab1NfTivqhaU=;
        b=NZhC0SGdXHWnQ15lirxbe7C9HBMFzZXG3eciYRML0F4BmkKSHpfaHS9Aub5fOoZfc7
         rPAatT8qS+S9ZU7TekpNFsXU+66mMuAGibTuQlPGd6a0uchnVUGzvLI+wQihFJ3kiLnD
         NiYUck204rdTtz41xGFuJPPtLWmcpNQ79671hC7xWlF0VcbHJyN2ewFBTnoXUeTbU2Tf
         h3SeSLiKLL0k19hF7kzFJDQbr+vy+8UzCdq7B+Zb/KRhtkdWlCfaLMWPo+8aSf1gmy9A
         4Wo0hW8uub0un4nI4zaNe1NFtMxQ1n0r+8d0v4oVr2xWrR07GW+kk0bmNzcafPwQJdxk
         vw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777046167; x=1777650967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6apAuausA1UMgxW+RA+bbqT9q3F9cbab1NfTivqhaU=;
        b=DfnY35xTn8aBje3Yh6wKsVnZYMpLTTgHOX09r2MOM93HrZphLu4LHaVHgFgQIcE881
         DqmokwTLba15uAk7ra+RbG7LB0Dh4wnfAHU3q4Fs7FFXJo7o5CFUwGFihXYxASldZiLO
         MYgGKa3gwlL/38WOlJnWc8VBXwZ4QHOw/eS4t7Txi6ZRErwB48412nm55tflhhNHKgNz
         Ycd4elnog1P/Yv2v+R79uwNTgFlk3KnXL4VtfzceFs/xXZ7aI26M7FrUKeBmUadkHkqo
         6dzmMVdxZOTyuFZi9TDLgcA62CEbGlfpyQ6iKGcwrC641bV3tbo/fmBHlQNOnXiV4+cw
         3Lkg==
X-Forwarded-Encrypted: i=1; AFNElJ9nGABIEXX3VAW58V8iGd8BWdIQ/upkNbxNNkxG9pxU6xTv6NL/1xMTjIeS86KFPbTFMFHb3/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT5JtFBr1Gw9BeMAlS0Vv2a6lmyi5XkVwLQ0rncRd6mtLbNZNS
	L3HbuA4XXrDSHgEHlCWvEJ6pGJdjMFb2wEFQOmeSUO9KhKrAScRW5pi4IfLlhQ==
X-Gm-Gg: AeBDieuMG+6HrSRm3uvnmauGmn+eh2j0M2qS/tIjsiptQPOrCWXykD5qbc3aclR/JH2
	VRcKYT03NL/H+SERDD1nqyZlZTxRDEDFeORWMSlMrixD4ucJ4KkGkBIBRPyy+7D+BGjPZaRTOCp
	OcKVAb+HrV8TrfU8J0+xXEI5zs2W2pxNmDMt1DLz50V2sMlGtu3G+wqAaUGgZW90FopEcllqJjJ
	2Ln9owEc9HvQS9EKB5tktdWVqRbmDz7gwh0poNr8r+0/uuhWIKE2K3I9AUPskYNPhAjmiTeWfmM
	/CZE+Wkv2RmejY/YCzlimUVZYjzUvcCJ7Anm5CPeckm/77ld1TtSVlX7FdLADylJnxn0yrhtDq2
	a5wFRnTdkWBMcOkbTL+Sz/1qp1YVLakuw3gode/YeCIBVKtuGkPsslYts3yh/cOWyAR2LXPS2zs
	HAB3jmncrIXMKiP1r5EJ5vM61+Yss2k0YqRU6ZhesjJazN7XBwRWz8cCxHHVDR5Zx0aHztkJM2/
	8Ai3tqrLg0uUJhjmCQzZA==
X-Received: by 2002:a05:6a20:9149:b0:3a2:dfb2:f03d with SMTP id adf61e73a8af0-3a2dfb2fe0cmr24796895637.56.1777046167242;
        Fri, 24 Apr 2026 08:56:07 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec037e1sm28692658b3a.54.2026.04.24.08.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 08:56:06 -0700 (PDT)
Message-ID: <ca04bbdf-c964-478e-9ab0-cf5ee5452348@gmail.com>
Date: Fri, 24 Apr 2026 23:56:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
To: Paolo Abeni <pabeni@redhat.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn@mork.no
Cc: ericwouds@gmail.com, frank-w@public-files.de, daniel@makrotopia.org,
 lucien.jheng@airoha.com, albert-al.lee@airoha.com
References: <20260420134506.35164-1-lucienzx159@gmail.com>
 <2f6fd850-e187-4e63-9a32-6b4b72c09905@redhat.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <2f6fd850-e187-4e63-9a32-6b4b72c09905@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE99C4610EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281010-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,public-files.de,makrotopia.org,airoha.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,vger.kernel.org,mork.no];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


Paolo Abeni 於 2026/4/23 下午 07:19 寫道:
> On 4/20/26 3:45 PM, Lucien.Jheng wrote:
>> AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
>> Assert the MCU (hold it in reset) and immediately deassert (release)
>> via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
>> through a registered mdio_device at PHY-addr+8.
>>
>> Add __air_pbus_reg_write() as a low-level helper taking a struct
>> mdio_device *, create and register the PBUS mdio_device in
>> an8811hb_probe() and store it in priv->pbusdev, then implement
>> an8811hb_mcu_assert() / _deassert() on top of it. Add
>> an8811hb_remove() to unregister the PBUS device on teardown. Wire
>> both calls into an8811hb_load_firmware() and en8811h_restart_mcu()
>> so every firmware load or MCU restart on AN8811HB correctly sequences
>> the reset control registers.
>>
>> Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB support")
> The hash is incorrect, should be 5afda1d734ed
I will fix it in the next patch.
>
> [...]
>> @@ -254,6 +267,31 @@ static int air_phy_write_page(struct phy_device *phydev, int page)
>>   	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
>>   }
>>   
>> +static int __air_pbus_reg_write(struct mdio_device *mdiodev,
>> +				u32 pbus_reg, u32 pbus_data)
>> +{
>> +	int ret;
>> +
>> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_EXT_PAGE_ACCESS,
>> +			      upper_16_bits(pbus_reg));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_ADDR_HIGH,
>> +			      (pbus_reg & GENMASK(15, 6)) >> 6);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr,
>> +			      (pbus_reg & GENMASK(5, 2)) >> 2,
>> +			      lower_16_bits(pbus_data));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_DATA_HIGH,
>> +			       upper_16_bits(pbus_data));
> Sashiko says:
>
> Will writing the lower 16 bits before the upper 16 bits cause the
> hardware transaction to fire with stale upper data?
> The __air_buckpbus_reg_write() helper triggers the 32-bit transaction
> using the lower 16 bits as the execution trigger. If this hardware
> behaves similarly, should AIR_PBUS_DATA_HIGH be populated before writing
> the lower 16 bits?
This is an8811hb pbus sequence. Therefore, it doesn't need to be modified.
> [...]
>> @@ -1175,10 +1281,22 @@ static int an8811hb_probe(struct phy_device *phydev)
>>   		return -ENOMEM;
>>   	phydev->priv = priv;
>>   
>> +	mdiodev = mdio_device_create(phydev->mdio.bus,
>> +				     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
> Sashiko says:
>
> Can this create an out-of-bounds array access if the base PHY address is
> high?
> The mdio_map array in struct mii_bus has a fixed size of PHY_MAX_ADDR (32).
> If phydev->mdio.addr is 24 or higher, adding EN8811H_PBUS_ADDR_OFFS (8)
> will result in an address of 32 or more.
> Neither mdio_device_create() nor mdio_device_register() validate that
> the address is within PHY_MAX_ADDR. When mdiobus_register_device()
> executes mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev, could this
> write past the end of the array and corrupt adjacent memory?
>
> /P
>

