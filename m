Return-Path: <netdev+bounces-158598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32804A12A19
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 18:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6813A3429
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C87158DD8;
	Wed, 15 Jan 2025 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNP2ljS1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C935951
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963201; cv=none; b=P30qDTWTFRGzmCXAM2bR/rc8Q5Tsek53/Pe0QrvFu4aIwhtzou8+zIFSs2bFMe2k0m5n1+2bpFEQw0cWgDirUXj/M+EQLreu1lvldKij8AkZF41+2HOlt22q/oHvV+In7WbcAZtwG9qZtb0G7xCopUzj70xHKD5RoVwK+Oi2qOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963201; c=relaxed/simple;
	bh=lrrP110SvOjDzb9Jq8HpGnNuyrmoptHnWtrlRo8PutY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uy9UfxWWnflgdBxlW4e7yZdE1bTNNJPH4nBXmp6gDCsZHt0J49ZpemxFNYBr2785RFE7kCAWJ6EBKmxHuAP+ltcROfjOSVa2nzLBwX41vd0gJiw8J4bSTYyN/bWxT8KrbUIAMiyEXdiuvx2AEkPDPoKwlUZYT9sJXh3OrkpCqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNP2ljS1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862d6d5765so32324f8f.3
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736963198; x=1737567998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pR/Z7L43wZQwqtPxJadn3lcU02bcGYcTLe+fj8N17qA=;
        b=XNP2ljS1A6Ezm/irt4pquTMyDCUAYyxfAfGBVold6SaY8/I1QDcPe9M9/7kkxvrKqp
         zpRryRm8PcOYFesQ9zfS19lro634AscF0sRtfA3RDXqTJcWh0vlK17XoKedobev0D04G
         7SAsbet/w0B9duqgaGRy9LF9v08GRx4kHR6jgVlV3OIna7B0W8Q7DvSiQMx3lhOC100v
         EK+bDfpWFIoWbyjUktvxbgUbQPqVaakTVEVljituRCbvYePxW65H30gkjTLyRdljK0CM
         1qcngodcjQDXhj4pBeDw7MEprXSbumYL8GbfP9FQAWtbQH2pQ0tBLtI1hqleY4DJAUs7
         JCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736963198; x=1737567998;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pR/Z7L43wZQwqtPxJadn3lcU02bcGYcTLe+fj8N17qA=;
        b=pfV6QKiIgmFLD4oPBn1w2m0XL6Nxw2EY96xqm4+U7eEHyMWszOYJ3ClxLxi0KJTj5F
         pju1Z2OhjEQmGONdDRNCSdMmt4IGNyPt2x7dw1mZTdvC2cXPm+T0CLOvAdm42wHWIvP+
         lXPDYYnHwV5Z5P1f1aMaz3SHZ6talB4tq262i5UqhnGO1bHN4wgAeT9egDXPizUwZorx
         2jLM6oz95TvoAUg+pEU/+oz7Nq4t/qe0od6sGFEg9dVhklH/IYNJ8GaOfKj/Xiz+t11u
         Um0LtT7SExnQLn9KDvx4WnVpd9hG77DG4hOWnaAApuuRcmOg2RVKLGKxSRfsdz1JBnJF
         94JA==
X-Forwarded-Encrypted: i=1; AJvYcCXd/MCyVDlFWFOXSn+41sz6oyjcjAQnm0Pu7dzhs9CYYXWOKKyBO0XE/mtGzz1Qj1bCdtzldM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4iZ58HAyofnXOMrMGse9QlQpA+kWLer8q19raIBQ03IDMKPZ
	c8+XA1FEc2Zo9o3wWHSvrYOmrp92HLKeXPLoARjXweLOprJ6kf1H
X-Gm-Gg: ASbGncs+tbvjtE3pLP4NtMuoyYzHKnlFWuspK3sD7i2c7XhZOK05geHUX2wBOfDDIpE
	oDhBX6ixhEOuEe1vgMy8OWRq3BzowWB1snOaUhUC+7MdDiBQvrcm07Sx48dQ3Jla0xC8y/38IIi
	mDF5MpxWT2KDCBXFit4SKSxASEQu6HEoX+EdjkXbtpIeSD700PI+euQKHh6+HsfICSQdlRes/Ic
	ft/nEvaU6dXDTcRKjxXz6pLzO8VfkJD4JoTABnoT0w0jP4aK+K/VZbxUgQlGyqCECm4nXUD2Wom
	heb0lYqnoi4Z1ErObgs6ct0GA0cQhm00pKPKbDnZ5oJdYzMTDZR9o65AoZZ8+UBF/dau38Ek40u
	pOxZ2O3NxNiBNK/liRBG+H6I7yhpzAwofJWk3DyAw2/luPD94
X-Google-Smtp-Source: AGHT+IHPKg8znewdEVih8WMRVIqFZaDi2YZUL+D1Q724kJ2Pnkcb1GQFzS5A1UtehgTUOmot9Mn/lA==
X-Received: by 2002:a05:6000:4607:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-38a87315bb9mr23056110f8f.53.1736963197823;
        Wed, 15 Jan 2025 09:46:37 -0800 (PST)
Received: from ?IPV6:2a02:3100:a12d:8800:31e4:b62b:fba8:4627? (dynamic-2a02-3100-a12d-8800-31e4-b62b-fba8-4627.310.pool.telefonica.de. [2a02:3100:a12d:8800:31e4:b62b:fba8:4627])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e37d472sm17876400f8f.1.2025.01.15.09.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 09:46:36 -0800 (PST)
Message-ID: <545f25c5-a497-4896-8763-fe17568599ef@gmail.com>
Date: Wed, 15 Jan 2025 18:46:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/10] ethtool: allow ethtool op set_eee to
 set an NL extack message
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
 <e3165b27-b627-41dd-be8f-51ab848010eb@gmail.com>
 <20250114150043.222e1eb5@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250114150043.222e1eb5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.01.2025 00:00, Jakub Kicinski wrote:
> On Sun, 12 Jan 2025 14:28:22 +0100 Heiner Kallweit wrote:
>> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>> index f711bfd75..8ee047747 100644
>> --- a/include/linux/ethtool.h
>> +++ b/include/linux/ethtool.h
>> @@ -270,6 +270,7 @@ struct ethtool_keee {
>>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
>>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertised);
>>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertised);
>> +	struct netlink_ext_ack *extack;
>>  	u32	tx_lpi_timer;
>>  	bool	tx_lpi_enabled;
>>  	bool	eee_active;
> 
> :S I don't think we have a precedent for passing extack inside 
> the paramter struct. I see 25 .set_eee callbacks, not crazy many.
> Could you plumb this thru as a separate argument, please?

I see your point regarding calling convention consistency.
Drawback of passing extack as a separate argument is that we would
have to do the same extension also to functions in phylib.
Affected are phy_ethtool_set_eee and genphy_c45_ethtool_set_eee,
because extack is to be used in the latter.
Passing extack within struct ethtool_keee we don't have to change
the functions in the call chain. So passing extack separately
comes at a cost. Is it worth it?


