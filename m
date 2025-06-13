Return-Path: <netdev+bounces-197330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F528AD8215
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F73189905B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 04:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1857202963;
	Fri, 13 Jun 2025 04:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K61t750I"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59272605;
	Fri, 13 Jun 2025 04:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749788853; cv=none; b=G1xYK2Mil6n+T/zMaxOQBuEIh1jN1wbB1HFGOj+BRuCaIVjmSL2lD3YDYw1EUx5sU1eEUpXDFjl5jiiIPj5LN54v4hq8AJdhdCBmFsubUqBvsBocBeoVhqiiyJeWRxz2ZZ65OjeJjA7csM6v+ZAQ446moqLI3JZH3G9ceOmsiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749788853; c=relaxed/simple;
	bh=GR//q8gjUIpqkRswYNl3pFV1eKpDj4qn1tocucHPedM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=glfSwZFsI2TPDcRZ9UFdYvfH/ojd0B0E6NZ6Njbs839mPHePPJkqTqJG3+QvPaR2lvtWof2PnwL+Sw4aYgA3G68Xn4LnFFDCEjEAbseONcS02uwyZb0BUBYajOJ11cMKRS0WJThyV7m07K3ubj833R2WMJeY/JoBGdj+8/wCyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K61t750I; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55D4RGGb1874765;
	Thu, 12 Jun 2025 23:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749788836;
	bh=d1d38w1Imrmh3Pi3ni2I/umfUi6bMxTp9ma4T10tvRI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=K61t750IEZD5XZ6kBse6w2Sw8IqkvwHHQQXNxndVgo2ZH25TKXNixas4EfJLlk4ga
	 MpF8jIOniPO7EhKOSY/zez6J6c4FCKL7NfkYSHDDfv0GUwT9tSnSvYYDM8qjppALgV
	 lVFIOdZcCyM4cjxzj+zSp+zXymMm/Ph30+3MKvug=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55D4RG7i3153743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 12 Jun 2025 23:27:16 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 23:27:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 23:27:16 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55D4RBk53185800;
	Thu, 12 Jun 2025 23:27:12 -0500
Message-ID: <5cb496cc-7b0e-471b-8698-10d26f973cc5@ti.com>
Date: Fri, 13 Jun 2025 09:57:11 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Read firmware-names from
 device tree
To: Jakub Kicinski <kuba@kernel.org>
CC: Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
References: <20250610052501.3444441-1-danishanwar@ti.com>
 <20250611170211.7398b083@kernel.org>
 <03555d09-e506-4f48-a073-b06b63e1af4a@ti.com>
 <20250612073708.69902ffc@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250612073708.69902ffc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 12/06/25 8:07 pm, Jakub Kicinski wrote:
> On Thu, 12 Jun 2025 10:49:17 +0530 MD Danish Anwar wrote:
>>> You seem to be deleting the old constants. Is there no need to keep
>>> backward compatibility with DT blobs which don't have the firmware-name
>>> properties ?  
>>
>> ICSSG-PRUETH driver is only supported by AM65x and AM64x and both the
>> DTs have the firmware name property. So I don't think there is any need
>> to maintain the older hard coded values.
>>
>> AM65x -
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso#n28:~:text=pru2_1%3E%2C%20%3C%26rtu2_1%3E%2C%20%3C%26tx_pru2_1%3E%3B-,firmware%2Dname,-%3D%20%22ti%2Dpruss/am65x
>>
>> AM64x -
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/arch/arm64/boot/dts/ti/k3-am642-evm.dts#:~:text=tx_pru1_1%3E%3B-,firmware%2Dname,-%3D%20%22ti%2Dpruss
>>
>> Let me know if this is okay.
> 
> IDK much about embedded but what you say sounds convincing to me :)
> Just also add that paragraph to the commit msg? (without the links)

Sure. Will send out v2 soon with these changes to commit msg.

-- 
Thanks and Regards,
Danish

