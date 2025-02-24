Return-Path: <netdev+bounces-168901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F32DA415B8
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E257A3BF4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D481FF7C4;
	Mon, 24 Feb 2025 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DLwDeCPa"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA31EDA34;
	Mon, 24 Feb 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380360; cv=none; b=NJLzcb5yGJHn2hIP+W9mNqZjDR879PHtJzMpHoUQo1W9TRpRRaojMPEWeJ9a1mF02DcHWFDz7pjdUJSHZkUl5ffIaULpEqTUQHSzeOR0W1q4/CkNeCZ2E302NAt41kxfTEkAewM0JsH4bkqy2heSCVCbzKB0PEEPJ5ArpJDq6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380360; c=relaxed/simple;
	bh=lz4hc6q//MKFxLxGXs6bM/9sXsPdoap6JpCxegUgct4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A7LFiiNp6Mlvo1xdBJz6LdIGrfAGaUITJ9YXpbHrCwpPdksSt0KehsG2U7OZWUsiLdBeZIaPJILxrTPEO9Rx2eLiuYXiJ9UhOrTSp9QcOYvqwAZFLcPxgtmwaeMPxVroP1Rr1mZMcNh49hSALNTD0T7iXBlWh+dfgM6d05oYQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DLwDeCPa; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51O6uT1D1418694
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 00:56:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740380189;
	bh=wmlvYthI9rLnavogJy8VmVfruK+HaZBcgG26Wf6LOSA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DLwDeCPa3O6HTmUb9JBKR3z6VaKYR6jMfbFoqSjWIeircUdFxtLnybEY6gqLcrXf8
	 Eg0IwKxxxZ84x2nDRvekpknOJTweIHy8fWY5uarrUQ6TUvY1gCz1I57of+EeIt5bJL
	 X8BiqRKkCOdfgQJgt+Rzyajr0d8REHIulOYCtdQA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51O6uSao088291
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Feb 2025 00:56:29 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Feb 2025 00:56:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Feb 2025 00:56:27 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51O6uH5Q099717;
	Mon, 24 Feb 2025 00:56:18 -0600
Message-ID: <af1d819a-4782-4b56-9e60-20263930bf19@ti.com>
Date: Mon, 24 Feb 2025 12:26:17 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 00/10] PRU-ICSSM Ethernet Driver
To: Parvathi Pudi <parvathi@couthit.com>, Jakub Kicinski <kuba@kernel.org>
CC: rogerq <rogerq@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>, <richardcochran@gmail.com>,
        basharath
	<basharath@couthit.com>, <schnelle@linux.ibm.com>,
        diogo ivo
	<diogo.ivo@siemens.com>, <m-karicheri2@ti.com>,
        <horms@kernel.org>, "jacob e
 keller" <jacob.e.keller@intel.com>,
        <m-malladi@ti.com>,
        javier carrasco cruz
	<javier.carrasco.cruz@gmail.com>, <afd@ti.com>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, pratheesh
	<pratheesh@ti.com>,
        Prajith Jayarajan <prajith@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <praneeth@ti.com>,
        <srk@ti.com>, <rogerq@ti.com>, krishna
	<krishna@couthit.com>,
        pmohan <pmohan@couthit.com>, mohan <mohan@couthit.com>
References: <20250214054702.1073139-1-parvathi@couthit.com>
 <20250214170219.22730c3b@kernel.org>
 <1348929889.600853.1739873180072.JavaMail.zimbra@couthit.local>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <1348929889.600853.1739873180072.JavaMail.zimbra@couthit.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Parvathi,

On 18/02/25 3:36 pm, Parvathi Pudi wrote:
> 
> Hi,
> 
>> On Fri, 14 Feb 2025 11:16:52 +0530 parvathi wrote:
>>> The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
>>> is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
>>> Megabit ICSS (ICSSM).
>>
>> Every individual patch must build cleanly with W=1.
>> Otherwise doing git bisections is a miserable experience.
>> --
> 
> As we mentioned in cover letter we have dependency with SOC patch.
> 
> "These patches have a dependency on an SOC patch, which we are including at the
> end of this series for reference. The SOC patch has been submitted in a separate
> thread [2] and we are awaiting for it to be merged."
> 
> SOC patch need to be applied prior applying the "net" patches. We have changed the 
> order and appended the SOC patch at the end, because SOC changes need to go into 
> linux-next but not into net-next. 
> 
> We have make sure every individual patch has compiled successfully with W=1 if we 
> apply SOC patch prior to the "net" patches.
> 

If there is any dependency in the series, the pre-requisite patch should
come before the dependent patch. In this series, SoC Patch should have
been the patch 1/10 and the warnings could have been avoided.

> 
> Thanks and Regards,
> Parvathi.

-- 
Thanks and Regards,
Danish

