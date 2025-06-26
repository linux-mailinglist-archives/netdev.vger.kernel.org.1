Return-Path: <netdev+bounces-201550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040DAE9DAD
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E7B5A5174
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38FA2E11AF;
	Thu, 26 Jun 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KE8G8rZt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137381EB2F
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941461; cv=none; b=D/vUPwyioYgEH7mUn0dDmCgJnW4ZnWMbLyraKU+r/79m9OqYMBD92J/Cy9uUaJTKExXufTAuE0ERAgWncaY6BE6dr//9dVWc8nFHzzgEppe1J2t1shQF/FTQRt4FFZmX8dwaCAGq6gNwv0e9ESfm88DoKkgUDyl2xVE8iDonnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941461; c=relaxed/simple;
	bh=9ZroLMSAku3Nmyo7S6YpAFX1MMluW9ApbJ82sN1muAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=beRwudMb4M9vO1VmPhMzccSDMUvtKrLdSIyR63L2E5X1GpIsehhPCzBcv2mFDOJyPPKezeLicREDcgtej4NbBP8PQ5zmOJlm+VXR0K6seWikyq5zBLhUGd5ezzyjiWkXDP2jX+NVyWnoLH11Vs0/NKARir1O23yijf9G2OW/gFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KE8G8rZt; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fabb948e5aso11605066d6.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750941459; x=1751546259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2XxUKbjZoXZPMzDnRnsGXkAjThjpFRVcO3GfQ4PW2A=;
        b=KE8G8rZtoejomZ7Zx9WS+b7/r2ygm8JcuT72ieb0fxpz8qKPXAUnY1VNPAalNRThK6
         MgjwPFigLXxvYw1ckk4KSMdlvXGx2H53ij9+5gIvoVGjpujxU+ueOKSFTua69CtlIFM+
         D8iODxZHY75MdwWK4yTdam81TNFTzTj6an+gS/V97f08wLtxGk9Vt5c8hXsyQYPBrbDM
         BE9UttIXFP4CZXbtXxys2sQpumLBR5yhbJ3XvBoMclbV2DzpvoTSAL6FIwKl66cDonwE
         dXyOSjOwqzRynjtMWs0s8InCKd6ijNh2C6BTZ48Xsrjcj2WWPetUV/gpCTem9GFYTV5r
         nWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750941459; x=1751546259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2XxUKbjZoXZPMzDnRnsGXkAjThjpFRVcO3GfQ4PW2A=;
        b=QNomsVB+vxazSzCHCCRjncpgZhnPwdC1do5ajAwSrWF/6L+U7aIHYuq7Q3pr53HK7z
         FPByPdxfW6fshhHlsrCdjOwAr5IEgSr5lXTAW1xvJwEhnNv7VVN+jkUgAMUU4H+666xc
         7CQdIRVnfRl8+kpe+Zg2deE4CKtMljs48xr1fpQfYG8WmKFBO6g+iCy0acLJ0s6NM3FY
         yx8PUrR0kg89zkO7gEjAwBFvqtcpLmz2wrfdZZlb9yujBho99D3Jo2qcrwsCiVx+fSWb
         m2ONq1vtkJbAjNhfqts9/16cTqoDageDkk5tmBCsnIPpKQtLVUgB3FvjQDloskNU0TkG
         NoQg==
X-Forwarded-Encrypted: i=1; AJvYcCVPcLYELEBtPG8cnJEv+AX4syLAHDkar2ceMUidafBVxnrZm0r7cZIE1xy9++shgGbvDnCEvGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7F2CqHfYZ+SrCfmDAD3P9xTrsUC4dGwspV9raFgcnREenJD9a
	hig0M71JMuU8xP00wcuTY2g4xOqAxFK6kpoHI2rNyxmocas0od0rrS98
X-Gm-Gg: ASbGnctd+eKBiOrrMfiTSK5/vXewasLRps9UhTR86StgmY59T3NEuhcL1BkNwj+yAto
	cJOP/YC4sJ5E90kXITm3+xuh5aFn2GDXrLtoFjR1cpTrYp+jPJAs7PAAcbmFxl5ts5hXYJr2iEf
	8Umv8lqBM+/r7S7RUEywX/Hv7RWb+fS94ZLeuFnKgGj8SAUuwqWePOKFsYcK2tdaip96tB4Xx+M
	Kcvqn0+HrN/aLHBwVfqAERXpuh7i/NcJPuk8/z4LK5xPqvTFPeML6J6gBSC6BiT/6CVhmzuDiVj
	0wxCRiSpbl/WDmM1YM+73FfNhovj5knqawtHD+b8TpI4njUQE8lR6tR1MULKisDwi8Ge2VapY/h
	GC8wzYK3p1JGu6l10QsKZ6209G5rpqL7ybBnli2oQ
X-Google-Smtp-Source: AGHT+IHFpzQtLmiUsrWlTFcYiWcHRir25oaIhrZ6EB4GXnBW7JtHvmvWRG0CTk/G1b/zEzOOY2R8Mw==
X-Received: by 2002:a05:6214:4607:b0:6fa:c41e:cc6c with SMTP id 6a1803df08f44-6fd5ef6dec2mr112870516d6.15.1750941458608;
        Thu, 26 Jun 2025 05:37:38 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e3f38sm6697826d6.61.2025.06.26.05.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 05:37:38 -0700 (PDT)
Message-ID: <d898c363-7f6c-452c-baef-adb2585f16d8@gmail.com>
Date: Thu, 26 Jun 2025 08:37:36 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] net: psp: add socket security association code
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-9-daniel.zahka@gmail.com>
 <685cac7163d82_2a5da429488@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <685cac7163d82_2a5da429488@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/25/25 10:12 PM, Willem de Bruijn wrote:
> Daniel Zahka wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>>
>> Add the ability to install PSP Rx and Tx crypto keys on TCP
>> connections. Netlink ops are provided for both operations.
>> Rx side combines allocating a new Rx key and installing it
>> on the socket. Theoretically these are separate actions,
>> but in practice they will always be used one after the
>> other. We can add distinct "alloc" and "install" ops later.
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
>> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
>>   /**
>>    * struct psp_dev_ops - netdev driver facing PSP callbacks
>>    */
>> @@ -109,6 +145,28 @@ struct psp_dev_ops {
>>   	 * @key_rotate: rotate the device key
>>   	 */
>>   	int (*key_rotate)(struct psp_dev *psd, struct netlink_ext_ack *extack);
>> +
>> +	/**
>> +	 * @rx_spi_alloc: allocate an Rx SPI+key pair
>> +	 * Allocate an Rx SPI and resulting derived key.
>> +	 * This key should remain valid until key rotation.
>> +	 */
>> +	int (*rx_spi_alloc)(struct psp_dev *psd, u32 version,
>> +			    struct psp_key_parsed *assoc,
>> +			    struct netlink_ext_ack *extack);
>> +
>> +	/**
>> +	 * @tx_key_add: add a Tx key to the device
>> +	 * Install an association in the device. Core will allocate space
>> +	 * for the driver to use at drv_data.
>> +	 */
>> +	int (*tx_key_add)(struct psp_dev *psd, struct psp_assoc *pas,
>> +			  struct netlink_ext_ack *extack);
>> +	/**
>> +	 * @tx_key_del: remove a Tx key from the device
>> +	 * Remove an association from the device.
>> +	 */
>> +	void (*tx_key_del)(struct psp_dev *psd, struct psp_assoc *pas);
>>   };
> This Tx driver API is necessary for devices that store keys in an
> on-device key database.
>
> The preferred device model for PSP is keys-in-descriptor, in line with
> the protocol design goal of O(1) device state.
>
> In that case, can the driver leave these callbacks NULL? And, in the
> driver tx datapath, access the tx key from psp_sk_assoc().

As it is now, psp_dev_create() will complain if the tx key management 
functions are NULL, but that should be changed. From the driver tx 
datapath, psp_skb_get_assoc_rcu() should be used for both 
keys-in-descriptors and SADB implementations. For SADB use, the SADB 
handle can be stashed in pas->drv_data. The mlx5 patches demonstrate this.

