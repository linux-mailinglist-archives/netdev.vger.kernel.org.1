Return-Path: <netdev+bounces-213240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1D5B2433D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C363B1BB3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E602D663D;
	Wed, 13 Aug 2025 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IPi8sKZV"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ABE27E05E;
	Wed, 13 Aug 2025 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071560; cv=none; b=Vd5kQjthUJyfrhbLGHW3mCXps/OtqnHj3Y8+bgGF+cXJzUgwCdbQcdVODSVwsh3o4DnONNO+G3VeiNRba7RAvgRN2x7NCYsQCKxWUQiC5Oyz9LpXToZq7kB8/2fAUayNnHYosngQVXHxJNLEx13CC/XehH5E3P6Ey+ABt5MO2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071560; c=relaxed/simple;
	bh=XlFq4Sgus3oQVPGHzXvXgTDE9t8jmHYL6F+kNSEKiPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mj253TP4du5Az44TCiqpcIV+fcTgUj53lgzRtDTZ5l7WgyzqW5EaTWkDSSV2z3whOMmp6DITp0Wzmuh0D3e9IyMII19dHG6pWilYdMG6tlxslZ65k4xXyCBghyqgfv+oNQGmaFLwMYDMGsVAsaE1Iluof5qYEaKe4or4tuh9YoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IPi8sKZV; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57D7pYMT1600946;
	Wed, 13 Aug 2025 02:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755071494;
	bh=rJa4YbPLmwHtQ5vYaRplxOBKhYAcebYKOd1/PHvF9Rw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IPi8sKZVyBFUyA1jBcIN7qegHeqU4NgvB0m7TW8js9bv4wlWetdgTtpDMzvTU7G+X
	 Rvv4dHysOQwh2JPhPemQJtnCFFJHqbU7z6KnB7mISjp1dc5jZcUx8CxxVck+7sKizM
	 mi/T+sC/kQs0SKyCJlqPjaI6SuxhxrUgbH8h+oR4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57D7pYZK4090251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 02:51:34 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 02:51:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 02:51:33 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57D7pRPs1978735;
	Wed, 13 Aug 2025 02:51:27 -0500
Message-ID: <d0c2fcb1-578d-443c-949f-860c94824ac9@ti.com>
Date: Wed, 13 Aug 2025 13:21:26 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] net: rnpgbe: Add build support for rnpgbe
To: Yibo Dong <dong100@mucse.com>, "Anwar, Md Danish" <a0501179@ti.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <corbet@lwn.net>, <gur.stavi@huawei.com>, <maddy@linux.ibm.com>,
        <mpe@ellerman.id.au>, <lee@trager.us>, <gongfan1@huawei.com>,
        <lorenzo@kernel.org>, <geert+renesas@glider.be>,
        <Parthiban.Veerasooran@microchip.com>, <lukas.bulwahn@redhat.com>,
        <alexanderduyck@fb.com>, <richardcochran@gmail.com>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-2-dong100@mucse.com>
 <5528c38b-0405-4d3b-924a-2bed769f314d@ti.com>
 <F9D5358C994A229C+20250813064441.GB944516@nic-Precision-5820-Tower>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <F9D5358C994A229C+20250813064441.GB944516@nic-Precision-5820-Tower>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 13/08/25 12:14 pm, Yibo Dong wrote:
> On Tue, Aug 12, 2025 at 09:48:07PM +0530, Anwar, Md Danish wrote:
>> On 8/12/2025 3:09 PM, Dong Yibo wrote:
>>> Add build options and doc for mucse.
>>> Initialize pci device access for MUCSE devices.
>>>
>>> Signed-off-by: Dong Yibo <dong100@mucse.com>
>>> ---
>>>  .../device_drivers/ethernet/index.rst         |   1 +
>>>  .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +++
>>>  MAINTAINERS                                   |   8 +
>>>  drivers/net/ethernet/Kconfig                  |   1 +
>>>  drivers/net/ethernet/Makefile                 |   1 +
>>>  drivers/net/ethernet/mucse/Kconfig            |  34 ++++
>>>  drivers/net/ethernet/mucse/Makefile           |   7 +
>>>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   8 +
>>>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 +++
>>>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 161 ++++++++++++++++++
>>>  10 files changed, 267 insertions(+)
>>>  create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
>>>  create mode 100644 drivers/net/ethernet/mucse/Kconfig
>>>  create mode 100644 drivers/net/ethernet/mucse/Makefile
>>>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
>>>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
>>>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
>>
>> [ ... ]
>>
>>> + **/
>>> +static int __init rnpgbe_init_module(void)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = pci_register_driver(&rnpgbe_driver);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>
>> Unnecessary code - can be simplified to just `return
>> pci_register_driver(&rnpgbe_driver);`
>>
> 
> Yes, but if I add some new codes which need some free after
> pci_register_driver failed, the new patch will be like this:
> 
> -return pci_register_driver(&rnpgbe_driver);
> +int ret:
> +wq = create_singlethread_workqueue(rnpgbe_driver_name);
> +ret = pci_register_driver(&rnpgbe_driver);
> +if (ret) {
> +	destroy_workqueue(wq);
> +	return ret;
> +}
> +return 0;
> 
> Is this ok? Maybe not good to delete code for adding new feature?
> This is what Andrew suggested not to do.
> 

In this patch series you are not modifying rnpgbe_init_module() again.
If you define a function as something in one patch and in later patches
you change it to something else - That is not encouraged, you should not
remove the code that you added in previous patches.

However here throughout your series you are not modifying this function.
Now the diff that you are showing, I don't know when you plan to post
that but as far as this series is concerned this diff is not part of the
series.

static int __init rnpgbe_init_module(void)
{
	int ret;

	ret = pci_register_driver(&rnpgbe_driver);
	if (ret)
		return ret;

	return 0;
}

This to me just seems unnecessary. You can just return
pci_register_driver() now and in future whenever you add other code you
can modify the function.

It would have  made sense for you to keep it as it is if some later
patch in your series would have modified it.

>>> +
>>> +module_init(rnpgbe_init_module);
>>> +
>>> +/**
>>> + * rnpgbe_exit_module - Driver remove routine
>>> + *
>>> + * rnpgbe_exit_module is called when driver is removed
>>> + **/
>>> +static void __exit rnpgbe_exit_module(void)
>>> +{
>>> +	pci_unregister_driver(&rnpgbe_driver);
>>> +}
>>> +
>>> +module_exit(rnpgbe_exit_module);
>>> +
>>> +MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
>>> +MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");
>>> +MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
>>> +MODULE_LICENSE("GPL");
>>
>> -- 
>> Thanks and Regards,
>> Md Danish Anwar
>>
>>
> 
> Thanks for your feedback.

-- 
Thanks and Regards,
Danish


