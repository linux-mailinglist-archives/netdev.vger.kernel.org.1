Return-Path: <netdev+bounces-79929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2888387C1C2
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEC11C209EC
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DEE71750;
	Thu, 14 Mar 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP2ATjot"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3907316C
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435723; cv=none; b=aUbYqj09AMtKrYeAkay7MlCfs8sHYhK8EAREp8y3SuBt1dQ4qUQC2uVDV+u6mXVuntMFDxKNJ2UnmgYwiSQ/dbbMdDDP5xS8ug7SFHtGTOWFhib4nVH5dOxwmNvrPH7m6LYLNlLhiVDIuQtJpY7j8gljUNyP2zCxfvQqSicJ47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435723; c=relaxed/simple;
	bh=TnBsISUWC2qlv8V8tprDZhAAqFTVtbXiMF1wHw2KojE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nehRJISfPnwSMF7qJuiq5l4DrKSnpDj8ixeogUp1bhpn+vu58fwoMufjNHXblfJMb45AXAp0hRGrqDVRfMzg10FhXqJnkpzSm9Hjy4+AxDpPTB/n3rXeuMw/UUgYLyb9S7XYzQuCU7lZXDF50X1BJx131O7jK5Xaes/wzDS/MoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bP2ATjot; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412e784060cso14308475e9.1
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710435720; x=1711040520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XjcADWLsDuWyyG5SreWRYKWkkzeL4Tg0NMQEOz56dDA=;
        b=bP2ATjot413PbWkHARjQG1463Kn0rpfAWA3LETCHvPNQ8S0zyyU1QBhP3yUrYHEW9Q
         +6wWIvNGPT4x6BX5b887U6HVC6ftsv3UlseS6uD+sB0iSqeAJ0yDgrWLj6iinSUGKfVm
         mF0V3FdgV/FrsVcFwGioUAG2HD51LEhq+2r/ZwywQf7PYi8mJSqE41cpZ2NgRtnq6hPE
         Ooo7DNPsKN9QkE02fTw/pce2W9vf1dnLFPB5rRceG+7+PWp4QeNAiOmY9E7ONHXW0G+d
         OwOONa3g1FQ/ENGPYD9+hrHysoDcGWroBU9CLCCg4e19zXLPqPX6gP8boDI1iI8iOnVK
         5SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435720; x=1711040520;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjcADWLsDuWyyG5SreWRYKWkkzeL4Tg0NMQEOz56dDA=;
        b=uE4WfbvgJcA8yxhT1sTYPN8beNxkfVF/vyfdtRtEh7DPpXt0ooVMuThqe7ha2SLw+k
         2fQbqzrKnTHvKF6yKzX7yFlkGk9c55p10nCZ1tBWtARkFElbDxc2DQ66uYUpnEIRfEqt
         5noR5DzAdRlR+jc35+bmReBVN0Lb76kl2hKK/Mu2ZXWgkcrHdZE+Zd1n1avlUppSkM13
         C4qZKc2uoYTaVygOpoCH6zs4jYwZ7V6CbmeW1WHG0IXB2Zad1BKKH43EEPFLVmTzOXct
         nW2rQG8gFNOOoxw94BWYyVj+orKeGxWxZMicaAOXWA6ETpRe2/my62fFtRse3o4lz5ER
         o2kg==
X-Forwarded-Encrypted: i=1; AJvYcCUwKEaHjQamKVtFo3kUEQeAS+n9wHUL5uem6BX987ZRkj9xldBzV0BK+AwVhYZtDvC+vhvY3u62nGUdVv9Q59hzYf9Ti2YU
X-Gm-Message-State: AOJu0YzXyIlufRR/jkUTDdHqJa99ALovCNBLht0Do0BctjjKQl8LTJ96
	uLtKkcHeuwHuKFFeukNkBA1HINOyyAcSqy268d/Fm4sjVEeE4n8L
X-Google-Smtp-Source: AGHT+IHS7h1upUTW0+dUXDNpD71vkVtZNpMltU1FrYRnL3eO+puXxn2MWbv5/E+y7coSnaeG0jwQQA==
X-Received: by 2002:a05:600c:1c9e:b0:413:f157:f677 with SMTP id k30-20020a05600c1c9e00b00413f157f677mr2390756wms.0.1710435719462;
        Thu, 14 Mar 2024 10:01:59 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a90:7b00:844c:788b:a2cb:c2b7? (dynamic-2a01-0c22-7a90-7b00-844c-788b-a2cb-c2b7.c22.pool.telefonica.de. [2a01:c22:7a90:7b00:844c:788b:a2cb:c2b7])
        by smtp.googlemail.com with ESMTPSA id j30-20020a05600c1c1e00b004133825e6cfsm6150563wms.24.2024.03.14.10.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 10:01:58 -0700 (PDT)
Message-ID: <80c585f5-4c79-4c97-8f14-5ff4a24fbaa9@gmail.com>
Date: Thu, 14 Mar 2024 18:01:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Energy Efficient Ethernet on MT7531 switch
To: Daniel Golle <daniel@makrotopia.org>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 netdev <netdev@vger.kernel.org>
References: <5f1f8827-730e-4f36-bc0a-fec6f5558e93@arinc9.com>
 <ZfMQkL2iizhG96Wh@makrotopia.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ZfMQkL2iizhG96Wh@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14.03.2024 15:58, Daniel Golle wrote:
> Hi,
> 
> On Thu, Mar 14, 2024 at 03:57:09PM +0300, Arınç ÜNAL wrote:
>> Hi Frank.
>>
>> Do you have a board with an external PHY that supports EEE connected to an
>> MT7531 switch?
> 
> Good to hear you are working on supporting EEE -- something which has
> been neglected for too long imho.
> 
> I got a bunch of such boards, all of them with different generations
> of RealTek RTL8226 or RTL8221 2.5G PHY which in theory supports EEE
> but the PHY driver in Linux at this point does not support EEE.
> 

With linux-next / net-next also 2.5G EEE should be configurable for these
PHY's. Or what are you missing in the Realtek PHY driver?

> However, as one of the SFP cages of the BPi-R3 is connected to the on-board
> MT7531 switch port 5 this would provide the option to basically test EEE
> with practically every PHY you could find inside an RJ-45 SFP module
> (spoiler: you will mostly find Marvell 88E1111, and I don't see support for
> EEE in neither the datasheet nor the responsible sub-driver in Linux).
> 
> So looks like we will have to implement support for EEE for either
> RealTek's RTL8221B or the built-in PHYs of any of the MT753x, MT7621
> or MT7988 switch first.
> 
>> I've stumbled across an option on the trap register of
>> MT7531 that claims that EEE is disabled switch-wide by default after reset.
>>
>> I'm specifically asking for an external PHY because the MT7531 switch PHYs
>> don't support EEE yet. But the MT753X DSA subdriver claims to support EEE,
>> so the remaining option is external PHYs.
>>
>> It'd be great if you can test with and without this diff [1] and see if you
>> see EEE supported on ethtool on a computer connected to the external PHY.
>>
>> Example output on the computer side:
>>
>> $ sudo ethtool --show-eee eno1
>> EEE settings for eno1:
>> 	EEE status: enabled - active
>> 	Tx LPI: 17 (us)
>> 	Supported EEE link modes:  100baseT/Full
>> 	                           1000baseT/Full
>> 	Advertised EEE link modes:  100baseT/Full
>> 	                            1000baseT/Full
>> 	Link partner advertised EEE link modes:  100baseT/Full
>> 	                                         1000baseT/Full
>>
>> I'm also CC'ing Daniel and the netdev mailing list, if someone else would
>> like to chime in.
>>
>> [1]
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index b347d8ab2541..4ef3948d310d 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -2499,6 +2499,8 @@ mt7531_setup(struct dsa_switch *ds)
>>  	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
>>  				 CORE_PLL_GROUP4, val);
>> +	mt7530_rmw(priv, MT7530_MHWTRAP, CHG_STRAP | EEE_DIS, CHG_STRAP);
>> +
>>  	mt7531_setup_common(ds);
>>  	/* Setup VLAN ID 0 for VLAN-unaware bridges */
>> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
>> index 3c3e7ae0e09b..1b3e81f6c90e 100644
>> --- a/drivers/net/dsa/mt7530.h
>> +++ b/drivers/net/dsa/mt7530.h
>> @@ -299,11 +299,15 @@ enum mt7530_vlan_port_acc_frm {
>>  #define  MT7531_FORCE_DPX		BIT(29)
>>  #define  MT7531_FORCE_RX_FC		BIT(28)
>>  #define  MT7531_FORCE_TX_FC		BIT(27)
>> +#define  MT7531_FORCE_EEE100		BIT(26)
>> +#define  MT7531_FORCE_EEE1G		BIT(25)
>>  #define  MT7531_FORCE_MODE		(MT7531_FORCE_LNK | \
>>  					 MT7531_FORCE_SPD | \
>>  					 MT7531_FORCE_DPX | \
>>  					 MT7531_FORCE_RX_FC | \
>> -					 MT7531_FORCE_TX_FC)
>> +					 MT7531_FORCE_TX_FC | \
>> +					 MT7531_FORCE_EEE100 | \
>> +					 MT7531_FORCE_EEE1G)
>>  #define  PMCR_LINK_SETTINGS_MASK	(PMCR_TX_EN | PMCR_FORCE_SPEED_1000 | \
>>  					 PMCR_RX_EN | PMCR_FORCE_SPEED_100 | \
>>  					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \
>> @@ -457,6 +461,7 @@ enum mt7531_clk_skew {
>>  #define  XTAL_FSEL_M			BIT(7)
>>  #define  PHY_EN				BIT(6)
>>  #define  CHG_STRAP			BIT(8)
>> +#define  EEE_DIS			BIT(4)
>>  /* Register for hw trap modification */
>>  #define MT7530_MHWTRAP			0x7804
>>
>> Thanks a lot!
>> Arınç
>>
> 


