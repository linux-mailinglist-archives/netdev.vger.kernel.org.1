Return-Path: <netdev+bounces-147606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37C9DA96B
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 14:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66254B211EB
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872461FCF57;
	Wed, 27 Nov 2024 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgpQY6qV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4361FA165
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715737; cv=none; b=FpmVqEi7iofVMfbstd/cfD80DcxFhkBm0CMR/RPZjaVEFPm41PXWUekp5Wwk5NgvyN7dUyrBILkx17HsyMHMEAsXXEwWFIToZrbLaUVNbUGBCwqrMhB9jYM+ICVVYPZo7bwHHw/5GAsnU2u5+pbn3FQCM5M7xrG27cYCdHwmjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715737; c=relaxed/simple;
	bh=4XjHRBUfd9IDatyBHdKZqpWJUDX3CV3U4KyxPjZrbDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CekGIDV7TBoKmp8qOqxIFsVgUe9P3L7j3Yf8yQfZketosHNkuDuOGYKlnOlVMZJZeRrYGnoV51snBi50jXwdXyxfIL/qensfVSqUbaHcWkulbtt2ezh1aM2n5rh0ffnLb6mOdJ5ZwHldAz8Rbko4nqsuFTSh/AA6oQb1KF8kQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgpQY6qV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4668e48963eso25683481cf.1
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 05:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732715735; x=1733320535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phDKT4Qmzsc6KoBiJvw2JobVokShbNGEtfRViw+X9Z0=;
        b=UgpQY6qV1+6YhlIQA/I1Vcq/cmdkte+vfUNTY+shaL2aA3y4lBadoFKbiurMztynyC
         5MWlckfNKKvSTrnh/q80Dkn4NkPHnh0pFaL4BRfMMyrZWaI2RNy2+JKGxe73zblNuIo6
         w/HswVVsXtSP9oqJF6o1yLGO1VYCfqr+gw7BTcWb/wPMwJdE2inKAwgDH7pWhXgiizzE
         U8OT9Ab6WPNh4BJ6CNx9EPbbRAARsgO7zUf4okZiMtUTGT+yo4uuJrVdcd9IYa/VIaD8
         lDXwjdqSITzDnUVgjiRD0f/xj6qKIsLjJcagDThRbBQYyxlZ+0lgIoXbK0PWTGobP6gm
         57iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732715735; x=1733320535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phDKT4Qmzsc6KoBiJvw2JobVokShbNGEtfRViw+X9Z0=;
        b=qBb1ePX43Co129K8Ru2JRWyT7PZ9CwptCv4UkWDUiaxs8rbZohH9xcfBJ71M8hEl7Q
         WjZXdTtKfY2rnXI4uJizAPyc8OF3VOisk0oim0IwfgzByuB1Nmp5HsiTz8avltiBbaiu
         HLaPW3IMMCBi2KtiOMYQyCXUgaUOgRDd8EGUMqNbQmzjF+wMj5SiHE3U2jSslmNiJNtQ
         cMtEhtAD1S85AlHM7Uu2n8VHAsQXmKe8lDudLHAD7RI/cYsRO2RyHF2srFuoBj9Nllfw
         p0+WU4Lg5/oXDZzmeD1bHT3KtVvAS6AQRPrwfNUAym8MfWVsNGCTJE4f0ugdtJ3GFham
         ur+w==
X-Gm-Message-State: AOJu0YwkS7703A5nNbt4jeOTnQByqwpnMFdZKBFyIKdxTV5m20s8/Rlp
	X+0ukXDv/8iOi+Si212ObBJMMzMmAJOggv/r496Jyd8/Dk6ozIqb
X-Gm-Gg: ASbGncv7tTIfYIJw1E6fYbeU6Zk5VPCWCp7zfJXQolUmbDn6V/yq5ku/O+SkkgSZoM1
	0U8waMapYgRlxCEftksv+UrMGU6ysbFtG87eAz82KqrjQLYPTtItJifaGX2gk3l9cYgM94qb4Mw
	4EHZxIAXkgxaETh7sqDG7BH6ikXiY9uYtmHoBlhbdum2Hcf9aOXMqXtVj2JzQwVd7380kc5chzz
	wb5nHxhFOdxHJSkaxwA1uYivkW3mYo030HdNrVKttoRJCC4tppmPIX0nO3Ri9Dj
X-Google-Smtp-Source: AGHT+IHLGLVoULEWdbvaTTKKhrzAUFbUHOqSMb+ofCb/uMqta77juq2H2LHizCZBXlFjpUrfTKT9VQ==
X-Received: by 2002:a05:6214:c2c:b0:6d4:1530:a0a6 with SMTP id 6a1803df08f44-6d864d0375fmr37907496d6.9.1732715734768;
        Wed, 27 Nov 2024 05:55:34 -0800 (PST)
Received: from ?IPV6:2620:10d:c0a8:11c1::107a? ([2620:10d:c091:400::5:2c1c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b67ae4322bsm93834985a.111.2024.11.27.05.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 05:55:34 -0800 (PST)
Message-ID: <f3272bbe-3b3d-496e-95c6-9a35d469b6e7@gmail.com>
Date: Wed, 27 Nov 2024 08:55:33 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC ethtool] ethtool: mock JSON output for --module-info
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "mkubecek@suse.cz" <mkubecek@suse.cz>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
 <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
 <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
 <cd258b2f-d43f-4ae6-bd7c-ca22777d35e3@gmail.com>
 <MN2PR12MB45179CC5F6CC57611E5024E2D8282@MN2PR12MB4517.namprd12.prod.outlook.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <MN2PR12MB45179CC5F6CC57611E5024E2D8282@MN2PR12MB4517.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/27/24 3:11 AM, Danielle Ratson wrote:
> Hi,
>
> I am attaching the dump I already have implemented for both CMIS and SFF modules:
>
> $ sudo ethtool --json -m swp23
> [ {
>          "identifier": 24,
>          "identifier_description": "QSFP-DD Double Density 8X Pluggable Transceiver (INF-8628)",
>          "power_class": 5,
>          "max_power": 10.00,
>          "max_power_units": "W",
>          "connector": 40,
>          "connector_description": "MPO 1x16",
>          "cable_assembly_length": 0.00,
>          "cable_assembly_length_units": "m",
>          "tx_cdr_bypass_control": false,
>          "rx_cdr_bypass_control": false,
>          "tx_cdr": true,
>          "rx_cdr": true,
>          "transmitter_technology": 0,
>          "transmitter_technology_description": "850 nm VCSEL",
>          "length_(smf)": 0.00,
>          "length_(smf)_units": "km",
>          "length_(om5)": 0,
>          "length_(om5)_units": "m",
>          "length_(om4)": 100,
>          "length_(om4)_units": "m",
>          "length_(om3_50/125um)": 70,
>          "length_(om3_50/125um)_units": "m",
>          "length_(om2_50/125um)": 0,
>          "length_(om2_50/125um)_units": "m",
>          "revision_compliance": [
>              "major": 4,
>              "minor": 0 ],
>          "rx_loss_of_signal": [ "Yes","Yes","Yes","Yes","Yes","Yes","Yes","Yes" ],
>          "tx_loss_of_signal": "None",
>          "rx_loss_of_lock": "None",
>          "tx_loss_of_lock": "None",
>          "tx_fault": "None",
>          "module_state": 3,
>          "module_state_description": "ModuleReady",
>          "low_pwr_allow_request_hw": false,
>          "low_pwr_request_sw": false,
>          "module_temperature": 36.00,
>          "module_temperature_units": "degrees C",
>          "module_voltage": 3.00,
>          "module_voltage_units": "V",
>          "module_temperature_high_alarm": false,
>          "module_temperature_low_alarm": false,
>          "module_temperature_high_warning": false,
>          "module_temperature_low_warning": false,
>          "module_voltage_high_alarm": false,
>          "module_voltage_low_alarm": false,
>          "module_voltage_high_warning": false,
>          "module_voltage_low_warning": false,
>          "cdb_instances": 1,
>          "cdb_background_mode": "Supported",
>          "cdb_epl_pages": 0,
>          "cdb_maximum_epl_rw_length": 128,
>          "cdb_maximum_lpl_rw_length": 128,
>          "cdb_trigger_method": "Single write"
>      } ]
>
> $ sudo ethtool --json -m swp1
> [ {
>          "identifier": 24,
>          "identifier_description": "QSFP-DD Double Density 8X Pluggable Transceiver (INF-8628)",
>          "power_class": 1,
>          "max_power": 0.25,
>          "max_power_units": "W",
>          "connector": 35,
>          "connector_description": "No separable connector",
>          "cable_assembly_length": 0.50,
>          "cable_assembly_length_units": "m",
>          "transmitter_technology": 10,
>          "transmitter_technology_description": "Copper cable, unequalized",
>          "attenuation_at_5ghz": 3,
>          "attenuation_at_5ghz_units": "db",
>          "attenuation_at_7ghz": 4,
>          "attenuation_at_7ghz_units": "db",
>          "attenuation_at_12.9ghz": 6,
>          "attenuation_at_12.9ghz_units": "db",
>          "attenuation_at_25.8ghz": 16,
>          "attenuation_at_25.8ghz_units": "db",
>          "revision_compliance": [
>              "major": 4,
>              "minor": 0 ],
>          "module_state": 3,
>          "module_state_description": "ModuleReady",
>          "low_pwr_allow_request_hw": false,
>          "low_pwr_request_sw": false
>      } ]
>
> Please let me know what do you think.


The formatting LGTM. It seems like some of the fields from upper page 
00h are missing: vendor name, vendor pn, etc. Are those elided because 
they are null?

>
> I believe I will send a version about two weeks from now.


Sounds good. Thanks for the update.


