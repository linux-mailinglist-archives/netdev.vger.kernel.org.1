Return-Path: <netdev+bounces-124469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E939969933
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD071F24760
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838F1A0BC4;
	Tue,  3 Sep 2024 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QED1hweB"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8F1A0BC0;
	Tue,  3 Sep 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356127; cv=none; b=j9EZeQu6WvIpPeY29EHkACPpFbI+J1/160e5zyYaS28R04AdGsxatZRsQBpoBI2p8XwkGdfkQK/508JfJGWg5uWKLT+L6K10Hf2VBjf5o3yN5OS3GHKNcTH5AGnNjl3iAnrGIc7fM8+FNJ/KpFwrRdCP+FxFe1JeNmeMkMjZhho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356127; c=relaxed/simple;
	bh=NlJ0ok5/WTY0rjvSQ6ryf27KtWkA3GAi9vyHrt6i/uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NFVcxINGg/3mBMIhRfD4709LvbvlYcf9FRxXdrssxStdu9RggEXos/apvx5mCRDqGlRc4byHZgZXbMmMcMtFnOACSbvfKaTO22vSpZs8OVnV9uGPah0RGJ+wry2w8d6jaGzhu4UZ+TSA/8W9hSh3Gv71BtcZa0OsGAZrTQPaCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QED1hweB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4839Z43Y033472;
	Tue, 3 Sep 2024 04:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725356104;
	bh=vSpGKNFSCjxGWWfQk+ywct1ygSfy18oACBNzhjz25kQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QED1hweBsvC7OpvGw7NZC7GArMRWqVvZKfxO7vQmpXqbIw+R3ZC0d22Pb6HOqreK6
	 9SBNkSMheVeN1fBm6+Jbi5uaqY9s3Ns15MmDkMqlbUIQTqaKhASc9zg0j2FVWW8DbH
	 RoX3uuFgUQFK3GZMwId0uyPCiyzGGVetvihWMO9Y=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4839Z4wA032322
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 04:35:04 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 04:35:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 04:35:03 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4839Yw6c067459;
	Tue, 3 Sep 2024 04:34:58 -0500
Message-ID: <5a2d24d6-ebfb-4633-8548-8e9bffbbfb48@ti.com>
Date: Tue, 3 Sep 2024 15:04:57 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: Andrew Lunn <andrew@lunn.ch>, "Anwar, Md Danish" <a0501179@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>
CC: Roger Quadros <rogerq@kernel.org>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
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
        Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20240828091901.3120935-1-danishanwar@ti.com>
 <20240828091901.3120935-4-danishanwar@ti.com>
 <22f5442b-62e6-42d0-8bf8-163d2c4ea4bd@kernel.org>
 <177dd95f-8577-4096-a3e8-061d29b88e9c@lunn.ch>
 <040b3b26-a7ef-47c7-845d-068a0c734e61@ti.com>
 <f2598368-745f-4a83-abfc-b9609ebff6b0@lunn.ch>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <f2598368-745f-4a83-abfc-b9609ebff6b0@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 02/09/24 6:32 pm, Andrew Lunn wrote:
>> Yes, and I have already added this in this series based on your feedback
>> on v2.
>>
>> I have one question though, in emac_ndo_set_features() should I change
>> these HSR related features irrespective of the current mode?
>>
>> AFAIK, if NETIF_F_HW_HSR_FWD is set, the forwarding is offloaded to HW.
>> If NETIF_F_HW_HSR_FWD is not set the forwarding is not offloaded to HW
>> and is done in SW.
>>
>> So, I don't see any need to enable this features if we are currently in
>> switch mode. Let me know what do you think. Should I still enable this
>> feature irrespective of current mode and later handle this in
>> prueth_hsr_port_link / unlink()?
> 
> The user should not need to know about the different firmwares. So i
> would allow NETIF_F_HW_HSR_FWD at any time.
> 
> The exception would be, if you look at all the other drivers which
> implement HSR offload, if they all return an error if the offloading
> cannot be enabled, then you should do the same.
> 

Andrew, I looked at xrs700x dsa and microchip ksz dsa driver as an
example. The drivers return -EOPNOTSUPP whenever offloading is not
possible in the xrs700x_hsr_join / ksz_hsr_join api. I think the same
should be okay for ICSSG driver as well. ICSSG drivers equivalent API is
prueth_hsr_port_link() where I will return -EOPNOTSUPP whenever
offloading is not possible.

So in the .ndo_set_features() I will not add any check so that the user
wouldn't know about the current firmware and whether offloading is
supported or not. In the prueth_hsr_port_link() based on firmware
limitation we will error out.

Andrew, Roger, Let me know if this sounds good.

> 	Andrew

-- 
Thanks and Regards,
Danish

