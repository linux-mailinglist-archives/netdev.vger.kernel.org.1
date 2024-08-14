Return-Path: <netdev+bounces-118527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE70951DD2
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1543E1F22817
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6C1B3F00;
	Wed, 14 Aug 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VRapPLjd"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2881B3751;
	Wed, 14 Aug 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647317; cv=none; b=IWa2hg339yADNHhzKoYSlpUQu9UImNw+p3yZLm3E4E7e5Yl0IHKDPg1WNmdjdffMskpKhSDzFv9tEcfHZo180BNEr62RXtHPR0HVKLxaMH4by13wzAPtfoB6Tvo/cgkqvyvCb5Tts4Ej8t0grA4el1XoJVqBT6bFQi2s0WzaYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647317; c=relaxed/simple;
	bh=nRAOER802nlB88wvK8OEIuGFAdVWWGLk9gBBmqdzD00=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bvIhNVj305FopGOFrRu5dyGDjEoPNRof6Vh1IcJjaHTgt/tW66FxwPPQ8i3ffCPgO0h22atRwdXeSAHKc6VSEphZKlrDJy0JyFXgGPs++DYIKGgG6et04hO5JxatrV4U+YjAfKqGwI6gfjGNP0JSoU4uFH6zklGPo4gcVgNvFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VRapPLjd; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EEstXT129962;
	Wed, 14 Aug 2024 09:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723647295;
	bh=rWTEUJRtgSy4CET9OGLSQp+hQnVZUyLBSD8X3BF++70=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VRapPLjdOLmcCyyQf8yADGmTlQy1JQR2SOkhOAwVdDHiEcUYo+JlZbJv2opEz+Lg+
	 qeO9Lh2TBS9u/1/e4AePgwe2r+Uc1OHzEeIYm+ZI8T/E6ecXL1CvYyEFkkyVyVuf2G
	 7+eEC0mbcaBlSPeYzQopkNKZEBG/UYARv/YhGv4Y=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EEstpE046392
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 09:54:55 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 09:54:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 09:54:54 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EEskIl030815;
	Wed, 14 Aug 2024 09:54:47 -0500
Message-ID: <c1125924-bf7b-46c5-89d0-e15a330af58c@ti.com>
Date: Wed, 14 Aug 2024 20:24:45 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: Andrew Lunn <andrew@lunn.ch>, MD Danish Anwar <danishanwar@ti.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-5-danishanwar@ti.com>
 <082f81fc-c9ad-40d7-8172-440765350b48@lunn.ch>
 <1ae38c1d-1f10-4bb9-abd7-5876f710bcb7@ti.com>
 <5128f815-f710-4ab7-9ca9-828506054db2@lunn.ch>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <5128f815-f710-4ab7-9ca9-828506054db2@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/14/2024 7:32 PM, Andrew Lunn wrote:
>> Yes, the icssg_init_ and many other APIs are common for switch and hsr.
>> They can be renamed to indicate that as well.
>>
>> How does icssg_init_switch_or_hsr_mode() sound?
> 
> I would say it is too long. And when you add the next thing, say
> bonding, will it become icssg_init_switch_or_hsr_or_bond_mode()?
> 
> Maybe name the function after what it actually does, not why you call
> it.
> 

Sure Andrew, I will try to come up with a proper name for these APIs.

>>>>  static struct icssg_firmwares icssg_switch_firmwares[] = {
>>>>  	{
>>>>  		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
>>>> @@ -152,6 +168,8 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>>>>  
>>>>  	if (prueth->is_switch_mode)
>>>>  		firmwares = icssg_switch_firmwares;
>>>> +	else if (prueth->is_hsr_offload_mode)
>>>> +		firmwares = icssg_hsr_firmwares;
>>>
>>> Documentation/networking/netdev-features.rst
>>>
>>> * hsr-fwd-offload
>>>
>>> This should be set for devices which forward HSR (High-availability Seamless
>>> Redundancy) frames from one port to another in hardware.
>>>
>>> To me, this suggests if the flag is not set, you should keep in dual
>>> EMACS or switchdev mode and perform HSR in software.
>>
>>
>> Correct. This is the expected behavior. If the flag is not set we remain
>> in dual EMAC firmware and do HSR in software. Please see
>> prueth_hsr_port_link() for detail on this.
> 
> O.K.
> 
> 	Andrew

-- 
Thanks and Regards,
Md Danish Anwar

