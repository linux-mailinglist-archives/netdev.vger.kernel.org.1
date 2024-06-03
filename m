Return-Path: <netdev+bounces-100089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2E48D7CDD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0111F209A5
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3C4EB30;
	Mon,  3 Jun 2024 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="r3XkzYpL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13E4F8A0
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401235; cv=none; b=uM24V2Le5uVxS2oFX3/oQbsYwd2pnvsMMZ2b9xkIWgkn8fZtP3rGYf9gr7TmRGWac2285+byGm8k0bicQ/jTiC9Oq9atBS//VmeR0KlpyQcavs2hUkNUowfrAIa+vXWqgIrrDlpNb6Zvmn4zoOQ4KISQ/PX3bLm5Fy6wFRVV+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401235; c=relaxed/simple;
	bh=tMA0PLVEVwuXNqcMFfJ3pL550AbyLmJTaj1FeqlHJ60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8hQCb8y4s3CPEYP+iBPMOGsucE0Cb4Z5C7Yqb+LAHIpem9OWr7D2H/iUoPFxyhvREzo3ughzG4yPJ4CW4fwjGmco0VsRh5TVLC7BevRgrvQe6jEUJX9mU6i0K5sw93TZGFlRzgseiMDfNDQnS7YAnEltvrbJv2F6QkNqp4lnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=r3XkzYpL; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B1FA19C5763;
	Mon,  3 Jun 2024 03:53:43 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 6sZYtQQ032Tu; Mon,  3 Jun 2024 03:53:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BF1AA9C590D;
	Mon,  3 Jun 2024 03:53:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com BF1AA9C590D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717401222; bh=QGSouRqOjqHsO//WD6mtds2J+tveNEzXkUmSdNQpnNA=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=r3XkzYpLp1ddA8A7h1MMZMWP8RWtFjTCensjqmdYXvq3hF6LK2uG6g89UTlFt5iqd
	 /fI3/w39xbjijV5oUTMEi5Aub9JR8EN7jBhFGPC6sBQFNqhYwVQqTuIJTIajzk3xo3
	 PwHnz/0Mjg/Z+OEuNed/dqc3cFJGgjTnl7sqqAfUiUpivbxYe4JFhB3A9SA9P/G0Fx
	 l1bHCS8qUjVeHsSalWoVZ3MrL3ufBZRIxKe9oRBu/UEipNF8k3yyUvNPZ3qNShzMkm
	 T/WyNYZyxSjA8uYh/eqta3fHBuIjeKpy1OKgf8zI7F2cQQ0voolksKTP9jFdDgGSq5
	 DuGqewnLQTFIQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 0wl_ASQMgV_H; Mon,  3 Jun 2024 03:53:42 -0400 (EDT)
Received: from [192.168.216.123] (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CC57A9C5763;
	Mon,  3 Jun 2024 03:53:41 -0400 (EDT)
Message-ID: <3f9457f0-b71a-4f45-a045-65e02cd00af0@savoirfairelinux.com>
Date: Mon, 3 Jun 2024 09:53:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/5] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
To: Tristram.Ha@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <BYAPR11MB35582B2BF1C72C8237E96C43ECFC2@BYAPR11MB3558.namprd11.prod.outlook.com>
Content-Language: en-US
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <BYAPR11MB35582B2BF1C72C8237E96C43ECFC2@BYAPR11MB3558.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/05/2024 21:39, Tristram.Ha@microchip.com wrote:
> 
> 
>> -----Original Message-----
>> From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
>> Sent: Friday, May 31, 2024 7:24 AM
>> diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
>> index 591bf5b5e8dc..81cc16dc2ddf 100644
>> --- a/include/linux/micrel_phy.h
>> +++ b/include/linux/micrel_phy.h
>> @@ -39,6 +39,10 @@
>>   #define PHY_ID_KSZ87XX         0x00221550
>>
>>   #define        PHY_ID_KSZ9477          0x00221631
>> +/* Pseudo ID to specify in compatible field of device tree.
>> + * Otherwise the device reports the same ID as KSZ8081 on CPU ports.
>> + */
>> +#define        PHY_ID_KSZ9897          0x002217ff
>>
> 
> I am curious about this KSZ9897 device.  Can you point out its product
> page on Microchip website?
> 
> KSZ9897 is typically referred to the KSZ9897 switch family, which
> contains KSZ9897, KSZ9896, KSZ9567, KSZ8567, KSZ9477 and some others.
> 
> I am not aware that KSZ9897 has MDIO access.  The switch is only accessed
> through I2C and SPI and proprietary IBA.
> 
> It seems the only function is just to report link so a fixed PHY should
> be adequate in this situation.
> 
> MDIO only mode is present in KSZ8863/KSZ8873 switches.  I do not know
> useful to use such mode in KSZ9897.
> 

I'm using the KSZ9897R from this page:
  - https://www.microchip.com/en-us/product/ksz9897

My CPU (i.MX6ULL) is connected to the CPU port 6 in RMII, listed in "Two 
Configurable External MAC Ports" with RGMII. This is for network 
connectivity with the switch, while I'm using SPI for DSA control. 
FIGURE 2-1 illustrates that architecture. However, this MDIO interface 
is indeed missing some documentation. For instance, it's phy_id is never 
listed (Section 5.2.2.3 only for ports 1-5).

I use a fixed-link property in the device tree, but the link would never 
come up if I use the KSZ8081 PHY driver which was selected without these 
patches because it emits the same phy_id as port 6. The genphy and 
KSZ9477 PHY dirvers were no better. I found out that the KSZ8873MLL 
driver was compatible though, which seems to make sense given your 
explanation.

-- 
Savoir-faire Linux
Enguerrand de Ribaucourt

