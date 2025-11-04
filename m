Return-Path: <netdev+bounces-235501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 536B2C319EA
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 706174EC762
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38C02F6191;
	Tue,  4 Nov 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpK9nyZm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0524679F
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267706; cv=none; b=rjDc2NlGnKwA8kpmKa2cmrmGo/ZIUNpc7HsRDqMpTXtu+w0qSs5XqTM/qmoVe7H5QPGBxuOYDAEhHMdyrU65EFt1ZUU6tKpni3xLCULXLbI1nV6APSpq/cW2Z3iUWSFLCmpU8guyeevPSx3dGotxqVZzPLZAQ0F+wK4tU4Ku/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267706; c=relaxed/simple;
	bh=JMLaYY6hZzPARYlgwS336pFX+gMN7vDHCCMc++BjmpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8bqr9XKfIQywwDtSkLmfxmJpvXHPB0fvGv960DeCnKQM9jUfS1bteMrxcwnNKYPwhl7Yl1qJxy49nJ+HxlU+8Ga/Wy3XFEMtWbQcUz2TwpfwzhaGzy03CA4SHNE9rh/sWrUa3wuMOsjOdho+cU1p9Cp+Y9yEbxQ6+lu32kYi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpK9nyZm; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-891208f6185so520792585a.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 06:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762267704; x=1762872504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYbk9wPxk/JA4+MxrrdLZ/GfKAsrpCoWC70+eUl4rp4=;
        b=lpK9nyZmhhKVs4MaUwGdwSTH3jpjY2avo4MDRIQ5wFbIO5Lp6laDw2X1rj5LQe5QjX
         5+0H0RAvSiwas1GTdRFBdguxoK1vTrKbzQ568DJ4NHWmgPF8uNoG2GCBOzQDD6N86uHE
         k5f52xGDpxZ0N6i2WVXnCR8BP5E5dB/V/IrTkcOsjeEfGAIBvYA243u+4OrTCqa8nP8/
         toWL2tFpt4wLEgr5wwVVT5kuIPp16zavB0wD7+OLpk2t7UVal3Q00kJgm33k/HeCzmkW
         gJ6yReeDlpcXjJ3A7UIQ3IFOcgpEYckbC0fCC/e77NJcxwwrtR5ONlGW5oc69M+D4iqQ
         9lCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762267704; x=1762872504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYbk9wPxk/JA4+MxrrdLZ/GfKAsrpCoWC70+eUl4rp4=;
        b=mgsSM2oJcdYijMe/dLa5WRpYe8Vi2ELBOE8hWNAzjEB/gACTJUjOIZ7n5DYVlLPAz2
         Rt3XxfcWn7QhjqC9jk+9i3XXi//6m6uM305NGMGSifRzu9XWLag0oumojuQ0nE3uISkX
         O0B3nQmkf2ph47WZOK70Aokkgri+H1+YhFGNS3CYwOi3S4wk8DR5aquMc0xLIFxQXHv7
         dxvIHPkEt8O1EfHivtEwxFqlpoTN9vCCllupjeHjFDH3ecdzyTPGRLF+FtLzidYQeNXX
         KQNOE34aCxShpBA0xTskUU+lCx0B3X7kaAczpEVlENCKFV4sUhmVNyVkXH0Y7qFFjtjV
         5Bsw==
X-Forwarded-Encrypted: i=1; AJvYcCU19P0SAMKZGO9cccXPwvDpGq1jSJF2WmqGg9UDNI/+/P4Yewk+jSPot2pUvDzY1hjBMGGOjgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNB4g9X6WkKvPVxi+2lU6b+4NR+uAQ1AsHPeAd0Y8PR67WUTju
	M81r3patTHBg+4KNPuUH4PrAGmx5267duFZpBffwp+Dzk5EhhJB0Mz0W
X-Gm-Gg: ASbGncsOGErQ/tp5IBL/IwmyiV+CkLE5bJMtSz7NRQCzUD25p2nov8XQeWK4++/asc7
	v+8jN7iOg2tBn/5Yd2ILwdJVr1PKFRsh4J3IrsH7OIcoT/MyMxOLdRUD/LZ6oXy3sWOok8czjCi
	xzh5l/JpjarI3U/htYMvTOWlvDJMUdWfOtV+/hNWWjahLUUBma4YAoEnu5cezw/n26OmTt/QWV9
	s1ry0c6RtIFHmBlXMigPHQoZ6jHC5D16+t+PzAbe1QqrP9cQ4depipqWYINZDV6sVFuh0wrMm6p
	9XXKnv5iH0tQK2BY9N/uZc9d6SkSGBfNXAe5err5kmEi7XWVA6BBO+uH7dvkTIKWbUVLvMBmmGN
	OetX6+MyMdrV5leIpFrWnoTBx44cX3PRB2GQwD5UWn51cvhm3ssuGgcCU+OHRj7ytDFR7qGywBk
	cMCqZXsMbGMrVv8Sui4On6pQWon4IjeJ6necGNl0JDUjhE24llE+oB60+iLnEU+vKZ0w==
X-Google-Smtp-Source: AGHT+IGmraHbZP2E2iRwXxMxNgGXM9zhZedCgpJV66vhLBH8PzAO8Dn4btILshzP2e0cEKgwNzEvBA==
X-Received: by 2002:a05:620a:1a27:b0:886:173f:1b4c with SMTP id af79cd13be357-8ab9ba6fd3emr1982205785a.80.1762267703489;
        Tue, 04 Nov 2025 06:48:23 -0800 (PST)
Received: from ?IPV6:2600:4040:93b8:5f00:52dd:c164:4581:b7eb? ([2600:4040:93b8:5f00:52dd:c164:4581:b7eb])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f543d90csm198693785a.17.2025.11.04.06.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 06:48:23 -0800 (PST)
Message-ID: <78db1fab-e482-4ebc-82ce-ba84b3f561e2@gmail.com>
Date: Tue, 4 Nov 2025 09:48:21 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Manish Chopra <manishc@marvell.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vladimir Oltean <olteanv@gmail.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
References: <20251103194554.3203178-1-daniel.zahka@gmail.com>
 <20251103194554.3203178-3-daniel.zahka@gmail.com>
 <mhm4hkz52gmqok56iuiukdcz2kaowvppbqrfi3zxuq67p3otit@5fhpgu2axab2>
 <db5c46b4-cc66-48bb-aafb-40d83dd3620c@gmail.com>
 <6aa2f011-3ba5-4614-950d-d8f0ec62222b@gmail.com>
 <p3pj3mu4mabgninwowqikegeotxgzhc4yptf7qrfhns37bnkoz@ugkbgvlkxqxb>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <p3pj3mu4mabgninwowqikegeotxgzhc4yptf7qrfhns37bnkoz@ugkbgvlkxqxb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/4/25 9:39 AM, Jiri Pirko wrote:
> Tue, Nov 04, 2025 at 01:51:16PM +0100, daniel.zahka@gmail.com wrote:
>>
>> On 11/4/25 6:38 AM, Daniel Zahka wrote:
>>>
>>> On 11/4/25 5:14 AM, Jiri Pirko wrote:
>>>> I did some research. 0/DEVICE_DEFAULT should not be ever reported back
>>>> from FW. It's purpose is for user to reset to default FW configuration.
>>>> What's the usecase for that? I think you could just avoid
>>>> 0/DEVICE_DEFAULT entirely, for both get and set.
>>> I find that 0/DEVICE_DEFAULT is reported back on my device. I have
>>> observed this same behavior when using the mstconfig tool for setting the
>>> parameter too.
>> e.g.
>> $ dmesg | grep -i mlx | grep -i firmware
>> [   10.165767] mlx5_core 0000:01:00.0: firmware version: 28.46.1006
>>
>> $ ./mstconfig -d 01:00.0 -b ./mlxconfig_host.db query SWP_L4_CHECKSUM_MODE
>>
>> Device #1:
>> ----------
>>
>> Device type:        ConnectX7
>> Name:               CX71143DMC-CDAE_FB_Ax
>> Description:        ConnectX-7 Ethernet adapter card; 100 GbE OCP3.0;
>> Single-port QSFP; Multi Host; 2 Host; PCIe 4.0 x16; Crypto and Secure Boot
>> Device:             01:00.0
>>
>> Configurations:                                          Next Boot
>>          SWP_L4_CHECKSUM_MODE DEVICE_DEFAULT(0)
> This is next-boot value. You should query current (--enable_verbosity)
> to show in param get.

I am still seeing that DEVICE_DEFAULT(0) is read back:

$ ./mstconfig --enable_verbosity -d 01:00.0 -b ./mlxconfig_host.db query 
SWP_L4_CHECKSUM_MODE

Device #1:
----------

Device type:        ConnectX7
Name:               CX71143DMC-CDAE_FB_Ax
Description:        ConnectX-7 Ethernet adapter card; 100 GbE OCP3.0; 
Single-port QSFP; Multi Host; 2 Host; PCIe 4.0 x16; Crypto and Secure Boot
Device:             01:00.0

Configurations:                  Default             Current       Next Boot
         SWP_L4_CHECKSUM_MODE DEVICE_DEFAULT(0) DEVICE_DEFAULT(0)    
DEVICE_DEFAULT(0)


