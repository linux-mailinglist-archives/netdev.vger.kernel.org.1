Return-Path: <netdev+bounces-100866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD108FC52C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BE41C21AA0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CB418C350;
	Wed,  5 Jun 2024 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Pwsf9cUx"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD418F2CB
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574044; cv=none; b=E3i/mZ9lh3a5yiH+g/hYzXnGWJInPdk7VSHgsKwBzG3TtfBKY2Og1MCYeVyqDNluLTIrAzRk5TBAgtt2vkqB5dnf57ogqos58BppBiBGiP0Au/53rs6X7tc2EhY+e1uTvdXvSWKNz2JlsSppzu7ffpV6GPo7zBlCxiKcUTjo3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574044; c=relaxed/simple;
	bh=+tqk/84dKYl1VSbe56iUDgsQWATkwIGHwy1BU/h6LTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6Kw0O6u239NeCX6gWUHC+RMNC0B5+lLCB714Q8kKyFdWuo0rW2fDzb3yM9FubzSf2j779z/BIpJFDIYG2cDRlAufrB1Z28BdIFWmiL/KpOQxz8Qr18TIQgzLbwfK9wBKe8axstmbj5yC9tDEJOA32NpkiFrqwxAj/GPISppB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Pwsf9cUx; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 52CA59C4798;
	Wed,  5 Jun 2024 03:53:59 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id uWQyYWrCFRjZ; Wed,  5 Jun 2024 03:53:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B6D739C59AE;
	Wed,  5 Jun 2024 03:53:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B6D739C59AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717574038; bh=y7h/HV1CoQZ0BDXpjjuYLD/5ySSq0tQyE+s2gaXuzdg=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=Pwsf9cUxgWDtuZKO7N6yx4UA/9Ja7enVBbQSF4HNrrshuT97jAaTFaEi1/ttd+JgZ
	 eOnlvPYDucqWYCScrWStiIPGTUMSgwEcdHMG050oo7PwKBTqZqZAW3qNQ0j/hNmpme
	 H3M+gGN+G7gCd8Tt1+n8XLMhVeiQ+fcNcYUhdjCNQPSQxjUaqucEx04jAb3hRQPFyA
	 gzKqXxPg5Ag6fySkxdRQbwR8l/MqAPhWuk1kzBON2lVNCbZvUasKPYTXTO5V16meq1
	 6IBKsNEAQV3cM6L4D5RWHWTrvvNeWj7fw04JS55kO1ARTEaYg9xih86F2ZDdpWLEiS
	 LEs59kALDZmNA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 36aIY9M0Vz4C; Wed,  5 Jun 2024 03:53:58 -0400 (EDT)
Received: from [192.168.216.123] (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 8DAD29C4798;
	Wed,  5 Jun 2024 03:53:57 -0400 (EDT)
Message-ID: <50530d02-ede9-4e59-bf97-5e3c9c8debe8@savoirfairelinux.com>
Date: Wed, 5 Jun 2024 09:53:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 4/4] net: dsa: microchip: monitor potential faults
 in half-duplex mode
To: Arun.Ramadoss@microchip.com, netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, horms@kernel.org, Tristram.Ha@microchip.com,
 Woojung.Huh@microchip.com, hkallweit1@gmail.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240604092304.314636-5-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <4a3070182e56ca21d9e07e083f30f82c1e886c3f.camel@microchip.com>
Content-Language: en-US
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <4a3070182e56ca21d9e07e083f30f82c1e886c3f.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 05/06/2024 05:31, Arun.Ramadoss@microchip.com wrote:
> Hi Enguerrand,
> 
> 
>>
>> +int ksz9477_errata_monitor(struct ksz_device *dev, int port,
>> +                          u64 tx_late_col)
>> +{
>> +       u32 pmavbc;
>> +       u8 status;
>> +       u16 pqm;
>> +       int ret;
>> +
>> +       ret = ksz_pread8(dev, port, REG_PORT_STATUS_0, &status);
>> +       if (ret)
>> +               return ret;
> 
> Blank line after return ret will increase readability.
> 
>> +       if (!((status & PORT_INTF_SPEED_MASK) ==
>> PORT_INTF_SPEED_MASK) &&
> 
> Why this check is needed. Is it to check reserved value 11b.
> 
Yes indeed, 11b would means that the port is not connected. So here I'm 
isolating ports in half duplex which are properly up.
> 
>> +           !(status & PORT_INTF_FULL_DUPLEX)) {
>> +               dev_warn_once(dev->dev,
>> +                             "Half-duplex detected on port %d,
>> transmission halt may occur\n",
>> +                             port);
>>   
>>

-- 
Savoir-faire Linux
Enguerrand de Ribaucourt

