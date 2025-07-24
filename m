Return-Path: <netdev+bounces-209626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050CBB10125
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25143BCA2D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 06:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A01FF5EC;
	Thu, 24 Jul 2025 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N2kX8jwu"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D69186E2E;
	Thu, 24 Jul 2025 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340175; cv=none; b=e7+HDrtfML2uQDSsLJT59Tgw6iZnmkHI+V9DrPSczcH3J8MetjtJ/Jhu8gRCDRfAZUsaD0M327Y7TAcXQ21ZikWhX5pSp26CwevnJTbHYj/QOxK5+Q/IPDb8WwNurQHLRZFwuhzqfTj7GwPj+pG7K17U3rQank9EFizznjaoFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340175; c=relaxed/simple;
	bh=8Xnyn6F3J+6N3ZoAWpn47q9S4V+9YNTWSvrZ3zY3jpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iWz60i71dCYLi0pPfGVoFaCF8NfhDW5A5Z1u8iuVQOVXIW2EA3ZZ4tF+EfVEhL6LOCRLbuPUPdLWxV3GShmcb4bEcnhGI2AlKQp9xpCsJH6i8DfHxh/rO0CKWz/2Zv/6q7L1MzxkD9Ef/LOOEhiBvSB8qxDb4mEHzPZb/gDNu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N2kX8jwu; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56O6sRss1439614;
	Thu, 24 Jul 2025 01:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753340067;
	bh=hOc1q4h2DdgZveLq/ie+ow6+3RIYzRAV3p05yW0fvLU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=N2kX8jwuYkhgzG6LEy5g1tNb05z48U8jpcmbH2yHHGPpXqOVJHPaxvqF/BIOdCJLe
	 yWvdC/2jho+huPaN3rCxyQjMPcOyaMi9dZgnT3IZCCq75cR+ehkRL6lsjpKpxPJEio
	 npQVk7/rRn79EG1drE+bfpWDIVimcyA/yckGsECU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56O6sRpN3359445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 24 Jul 2025 01:54:27 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 24
 Jul 2025 01:54:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 24 Jul 2025 01:54:26 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56O6sK9K033297;
	Thu, 24 Jul 2025 01:54:20 -0500
Message-ID: <db4e65a7-bdb6-4e96-b9d0-eda4b30e4e71@ti.com>
Date: Thu, 24 Jul 2025 12:24:19 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation for
 RPMSG-ETH Driver
To: Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Michael
 Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Fan
 Gong <gongfan1@huawei.com>, Lee Trager <lee@trager.us>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lukas
 Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cocci@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20250723080322.3047826-1-danishanwar@ti.com>
 <20250723080322.3047826-2-danishanwar@ti.com>
 <20250723064901.0b7ec997@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250723064901.0b7ec997@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Jakub,

On 23/07/25 7:19 pm, Jakub Kicinski wrote:
> On Wed, 23 Jul 2025 13:33:18 +0530 MD Danish Anwar wrote:
>> +   - Vendors must ensure the magic number matches the value expected by the
>> +     Linux driver (see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
>> +     source).
> 
> For some reason this trips up make coccicheck:
> 
> EXN: Failure("unexpected paren order") in /home/cocci/testing/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
> 
> If I replace the brackets with a comma it works:
> 
>    - Vendors must ensure the magic number matches the value expected by the
>      Linux driver, see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
>      source.
> 
> Could you make that change in the next revision to avoid the problem?
> 

Sure. I'll do this change in v2.

> Julia, is there an easy way to make coccinelle ignore files which
> don't end with .c or .h when using --use-patch-diff ?

-- 
Thanks and Regards,
Danish


