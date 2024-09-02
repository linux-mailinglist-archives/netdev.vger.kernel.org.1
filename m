Return-Path: <netdev+bounces-124085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F12E967EF1
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50B81F22593
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 05:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D444E14EC7D;
	Mon,  2 Sep 2024 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wBUFu7y1"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A7382;
	Mon,  2 Sep 2024 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256299; cv=none; b=iEo6DFfRiXEBlh6nd4cnfTybuhwi6RF9NMYw+O8tvFqLOp2cfLu4+3UhaBRGbEMkEA1Pw4t3ftWJxXbQztI9navLLPZEm5KTPxXNsaeDX8mOMrzLtt+j6YFPdHwAb4ojyQrudF5WHtqlT+hpl50yHWNoVW19PNzjjL/OQ1F5ILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256299; c=relaxed/simple;
	bh=Gj55G6lKu7n2NTnDEeH4khTSGvxEJMBnE3JGgtlxO88=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Agd0gxKx823BacnCruGwz6wNdj56htCqv9PlJjphgNKjbUGX2LZM14UjzWK/rZtNPPQQjf9g4czXRBRMWbrgBsroa7zGRb12C319WZPftJ6tVXiVt3GRs+g6tKUZp46ow7n47nfI1FLezht3uUTadQ+KVfRRnmtZXohzz76amTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wBUFu7y1; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4825pG4D125643;
	Mon, 2 Sep 2024 00:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725256276;
	bh=cLRmH+kA6kXQ99zzZv3DTHnhkab52gAqrsPA8vh6zi4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wBUFu7y1B+QKOl71jXftrZnXwAHIzOqNupw2H97FdCTp4Bejr+VG1LGtYjzH4Tj+Z
	 XIHqzQYTdF/fQCuYiOnv4vDgnJag2zeqe61qVHnM8ju4BSGdLLgK5wcUuB3bBxfbGP
	 V4VBf9H0lt5rnkMwSVgZLZBBjofmXhbqtj80JZtw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4825pG6V064283
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Sep 2024 00:51:16 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 00:51:16 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 00:51:16 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4825p8Lo075490;
	Mon, 2 Sep 2024 00:51:09 -0500
Message-ID: <040b3b26-a7ef-47c7-845d-068a0c734e61@ti.com>
Date: Mon, 2 Sep 2024 11:21:08 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>
CC: MD Danish Anwar <danishanwar@ti.com>,
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
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <177dd95f-8577-4096-a3e8-061d29b88e9c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/30/2024 7:30 PM, Andrew Lunn wrote:
> On Fri, Aug 30, 2024 at 04:27:34PM +0300, Roger Quadros wrote:
>>
>>
>> On 28/08/2024 12:18, MD Danish Anwar wrote:
>>> Add support for offloading HSR port-to-port frame forward to hardware.
>>> When the slave interfaces are added to the HSR interface, the PRU cores
>>> will be stopped and ICSSG HSR firmwares will be loaded to them.
>>>
>>> Similarly, when HSR interface is deleted, the PRU cores will be stopped
>>> and dual EMAC firmware will be loaded to them.
>>
>> And what happens if we first started with switch mode and then switched to HSR mode?
>> Is this case possible and if yes should it revert to the last used mode
>> instead of forcing to dual EMAC mode?
>>
>>>
>>> This commit also renames some APIs that are common between switch and
>>> hsr mode with '_fw_offload' suffix.
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---

[...]

>>
>> Can you please check that if we are not in dual emac mode then we should
>> error out if any HSR feature is requested to be set.
> 
> This is where all the shenanigans with firmware makes things complex.
> 
> One of these options say 'If the interface is used for HSR, offload it
> to hardware if possible'. You should be able to set this flag
> anytime. It only has any effect when an interface is put into HSR
> mode, or if it is already in HSR mode. Hence, the firmware running
> right now should not matter.
> 
> I suspect the same is true for many of these flags.
> 

Andrew that is correct. Ideally the current running firmware should not
matter. But the firmware team only recommends dual EMAC -> HSR offload
and vise versa transitions. They suspect some configuration issues when
switch -> HSR transition happen. That is why they have recommended not
to do HSR hw offloading from switch mode. We can however keep doing SW
offload as suggested by you in v2.

>> As you mentioned there are some contstraints on what HSR features can be
>> enabled individually.
>> "2) Inorder to enable hsr-tag-ins-offload, hsr-dup-offload
>>    must also be enabled as these are tightly coupled in
>>    the firmware implementation."
>> You could do this check there by setting/clearing both features in tandem
>> if either one was set/cleared.
> 
> Software HSR should always work. Offloading is generally thought as
> accelerating this, if the hardware supports the current
> configuration. When offloading, if the hardware cannot support the
> current configuration, in general it should return -EOPNOTSUPP, and
> the software will keep doing the work.
> 
> It is not particularly friendly, more of a documentation issue, but
> the user needs to set the options the correct way for offload to
> work. Otherwise it keeps chugging along in software. I would not
> expect to see any error messages when offload is not possible.
> 

Yes, and I have already added this in this series based on your feedback
on v2.

I have one question though, in emac_ndo_set_features() should I change
these HSR related features irrespective of the current mode?

AFAIK, if NETIF_F_HW_HSR_FWD is set, the forwarding is offloaded to HW.
If NETIF_F_HW_HSR_FWD is not set the forwarding is not offloaded to HW
and is done in SW.

So, I don't see any need to enable this features if we are currently in
switch mode. Let me know what do you think. Should I still enable this
feature irrespective of current mode and later handle this in
prueth_hsr_port_link / unlink()?

> 	Andrew

-- 
Thanks and Regards,
Md Danish Anwar

