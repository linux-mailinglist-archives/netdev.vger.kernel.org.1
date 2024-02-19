Return-Path: <netdev+bounces-72901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0149D85A105
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 11:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE8DB207C2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5E42134A;
	Mon, 19 Feb 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3OCWy9/D"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C3E545
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338652; cv=none; b=OkQZVyar8JsQfOHr6lz4wvndPrIS/vqb4UMhDjmYb3a39F/HDhoCNshcvKRCIuMdIBj3jzmtMhRSDo7jwSa/t2btlcbKmb8sroI6DyXeAcEZLtCy10W5n2ZaJmUNONxNwrXQmBlSKY6DdSJfHYSgiGWEQuY99g3DDA/CGD4Gmow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338652; c=relaxed/simple;
	bh=J+6hkRywDJluZXL5+9c9mVQwuI9RzLyPhx0Hrh4rPU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PHXaRm28EZ8rJLxYuENIPYkHye8LXY67leRREzFzEr4GANxlMY3xhKQ3GGsynFG+9agzdPMesAFEnu8ArTZaWsJlob69nuolx3MVmEOkk5JuOai9LwK5BYAjdrKVhm6nH3Qlxo+3R8vnDPGz+lt6PGuObGeeOtLlTnzDM4oI9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3OCWy9/D; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J9TEsp008714;
	Mon, 19 Feb 2024 11:30:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=A19XVtgzHmrC1CgTzG9eGajmj6k7WbkYcd3F/9eohFk=; b=3O
	CWy9/DCZiBBSNuyc294s9GrNSP5ls7+7Qrp7B+3LB8Bgek77YU+5ziiefumfazFX
	/Rv31Tw6qi8eJ02krlpt79k/Yk06F9LDjio3Qqf+3tnTWCQxj20oMWRkPBzbdN2j
	+KiLr2jb0eMhWvBJUsQIdx8XOCKduGJhvK34w1mkV/KAYQjy78y++P/eOGGkAwHr
	/leSYe2Nu4R2c+y0sAn9DWuhoRCCV8QE86r8pUp0Epo5ScpB7UBu8VJpSASJf+QT
	lCbEHMK9hve5HxuNZZoPWV5o/aXZWmfvixqT0r+CKj4BuL1+f+rwwk+mx1lTy9Yz
	GOfx0wtK+xOfXS2t8ijA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wb784c7uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 11:30:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 288814004B;
	Mon, 19 Feb 2024 11:30:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 90F44250567;
	Mon, 19 Feb 2024 11:29:46 +0100 (CET)
Received: from [10.201.21.128] (10.201.21.128) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 11:29:46 +0100
Message-ID: <2e4255a3-08ef-44f9-a57f-6a681171c8e6@foss.st.com>
Date: Mon, 19 Feb 2024 11:29:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VLAN "issue" on STMMAC
Content-Language: en-US
To: Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
        <kim.tatt.chuah@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        <vee.khee.wong@intel.com>
CC: <davem@davemloft.net>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <netdev@vger.kernel.org>
References: <20240130160033.685f27c9@kernel.org>
 <7cfc9562-161d-4d6c-a355-406938b3361e@foss.st.com>
 <2308719d-1994-4cd4-a6b1-8ee3ec291caf@gmail.com>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <2308719d-1994-4cd4-a6b1-8ee3ec291caf@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_07,2024-02-16_01,2023-05-22_02


On 2/16/24 18:23, Florian Fainelli wrote:
> Adding original authors,
Good, you are right
>
> On 2/16/24 06:35, Christophe ROULLIER wrote:
>> Hello,
>>
>> I've a question concerning following commit:
>>
>> ed64639bc1e0899d89120b82af52e74fcbeebf6a :
>>
>> net: stmmac: Add support for VLAN Rx filtering
>>
>> Add support for VLAN ID-based filtering by the MAC controller for MAC
>>
>> drivers that support it. Only the 12-bit VID field is used.
>>
>> Signed-off-by: Chuah Kim Tatt kim.tatt.chuah@intel.com
>> Signed-off-by: Ong Boon Leong boon.leong.ong@intel.com
>> Signed-off-by: Wong Vee Khee vee.khee.wong@intel.com
>> Signed-off-by: David S. Miller davem@davemloft.net
>>
>> So now with this commit is no more possible to create some VLAN than 
>> previously (it depends of number of HW Tx queue) (one VLAN max)
>>
>> root@stm32mp1:~# ip link add link end0 name end0.200 type vlan id 200
>> [   61.207767] 8021q: 802.1Q VLAN Support v1.8
>> [   61.210629] 8021q: adding VLAN 0 to HW filter on device end0
>> [   61.230515] stm32-dwmac 5800a000.ethernet end0: Adding VLAN ID 0 
>> is not supported
>
> OK, so here the VLAN module was not yet loaded, so as part of the 
> operation, we get the module, load it, which triggers the 802.1q 
> driver to install a VLAN ID filter for VLAN ID #0, that fails because 
> there is a single VLAN supported, and this apparently means VLAN 
> promiscuous... not sure why that is an error, if this means accepting 
> all VLANs, then this means we need to filter in software, so it really 
> should not be an error IMHO.

Module VLAN (Config VLAN_8021Q) is well loaded

root@stm32mp1:~# lsmod
Module                  Size  Used by
8021q                  28672  0
garp                   16384  1 8021q
mrp                    20480  1 8021q
...

>
>> root@stm32mp1:~# ip link add link end0 name end0.300 type vlan id 300
>> [   71.403195] stm32-dwmac 5800a000.ethernet end0: Only single VLAN 
>> ID supported
>> RTNETLINK answers: Operation not permitted
>> root@stm32mp1:~#
>>
>> I've tried to deactivate VLAN filtering with ethtool, but not 
>> possible ("fixed" value)
>>
>> root@stm32mp1:~# ethtool -k end0 | grep -i vlan
>> rx-vlan-offload: on [fixed]
>> tx-vlan-offload: on [fixed]
>> rx-vlan-filter: on [fixed]
>> vlan-challenged: off [fixed]
>> tx-vlan-stag-hw-insert: on [fixed]
>> rx-vlan-stag-hw-parse: on [fixed]
>> rx-vlan-stag-filter: on [fixed]
>> root@stm32mp1:~#
>> root@stm32mp1:~# ethtool -K end0 rxvlan off
>> Actual changes:
>> rx-vlan-hw-parse: on [requested off]
>> Could not change any device features
>>
>> Do you know if there are possibility to force creation of VLAN ID 
>> (may be in full SW ?) and keep the rest of Ethernet Frame processing 
>> to GMAC HW.
>
> It is not clear to me how -EPERM ended up being chosen as a return 
> code here rather than -EOPNOTSUPP which would be allow for the upper 
> layers to decide how to play through, not that it would matter much here,
> because we sort of expect the operation not to fail.
>
> Can you confirm that dwmac4_get_num_vlan() does return 1 single VLAN 
> filter? Also, given the comment about single VLAN and VID #0 meaning 
> VLAN promiscuous does this work:
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c 
> b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index 6b6d0de09619..e2134a5e6d7e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -492,10 +492,8 @@ static int dwmac4_add_hw_vlan_rx_fltr(struct 
> net_device *dev,
>         /* Single Rx VLAN Filter */
>         if (hw->num_vlan == 1) {
>                 /* For single VLAN filter, VID 0 means VLAN 
> promiscuous */
> -               if (vid == 0) {
> -                       netdev_warn(dev, "Adding VLAN ID 0 is not 
> supported\n");
> -                       return -EPERM;
> -               }
> +               if (vid == 0)
> +                       return 0;
>
>                 if (hw->vlan_filter[0] & GMAC_VLAN_TAG_VID) {
>                         netdev_err(dev, "Only single VLAN ID 
> supported\n");
>
I confirm that dwmac4_get_num_vlan() return 1.

I've tested your patch in dwmac4_add_hw_vlan_rx_fltr, for sure no more 
warning but same issue :-(

root@stm32mp1:~# ip link add link end0 name end0.200 type vlan id 200
[   73.536876] 8021q: 802.1Q VLAN Support v1.8
[   73.539853] 8021q: adding VLAN 0 to HW filter on device end0

root@stm32mp1:~# ip link add link end0 name end0.300 type vlan id 300
[  121.560317] stm32-dwmac 5800a000.ethernet end0: Only single VLAN ID 
supported
RTNETLINK answers: Operation not permitted

root@stm32mp1:~# ethtool -k end0 | grep -i vlan
rx-vlan-offload: on [fixed]
tx-vlan-offload: on [fixed]
rx-vlan-filter: on [fixed]
vlan-challenged: off [fixed]
tx-vlan-stag-hw-insert: on [fixed]
rx-vlan-stag-hw-parse: on [fixed]
rx-vlan-stag-filter: on [fixed]

I've also try to remove second "return -EPERM;"

+               if (vid == 0)
+                       return 0;

          if (hw->vlan_filter[0] & GMAC_VLAN_TAG_VID) {
              netdev_err(dev, "Only single VLAN ID supported\n");
-            return -EPERM;
+//            return -EPERM;
          }

And now it ok to create some VLANs, but it is clearly not clean.

Is it possible/consistent to have a DT property to bypass HW VLAN 
capabilies (hw->num_vlan and hw->vlan_filter ..) and manage VLAN in 
software ?

Thanks for your feedback



