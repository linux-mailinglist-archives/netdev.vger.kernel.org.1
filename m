Return-Path: <netdev+bounces-100053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4028D7B60
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8921F21529
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649AB2261F;
	Mon,  3 Jun 2024 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZkPgl4wG"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0020DF7;
	Mon,  3 Jun 2024 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395051; cv=none; b=JZetaY5NJBHorFG8jEH7eK+/XD3tMchCx8Y7QTz60PmBvpgiTEa5EzdgLs6Eb8RhxS3DtcsDXSkrxSik6RwjpvP364olmy645f/MNm072UhZZ+SgMgNPeLWFhOiIgfxOhMVfjneXNB5pJC+eyfgbtNlMATP4vXoO8k0jZ/qQlj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395051; c=relaxed/simple;
	bh=uYpdfx3kMm5g/g2FKdfezvIgSxQLsLUR2GNoRzVh11E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SFSHINfzgww2tOs9vWVw6an31UZFqdu46gQmP3AIgO3lwzmfQzU/nmGqZ6bXTpEpj+QpWGrdVYPUT/Pwf4uX3ukeCQfhwMxWnhRabNFye5IdMi4UBMYoA+JvDRQjvfedszsk2GlF4J684ukVbrzNm6x/oaA5BtIRksUWZuE3/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZkPgl4wG; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4536AKMa070463;
	Mon, 3 Jun 2024 01:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717395020;
	bh=LTVjqH4UcI1XPjmJDIl5xU6qanEA2w+6GkIqA6wZ5Cs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZkPgl4wGEhCLFwycyXqaiy1NP0iVEpRCMOGzNXmer6n5P/fa4uTLOzsyXplptDSS3
	 +8lPrp339jg0yuiE0UGXH7RGhRLoWB+0Uq543mhh9cvT1V+5+zfPLX6GW4RRgStpFc
	 khhN1j9YT5WXO5pN7L9btq110ix6wnC2AuzEvP4o=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4536AKXm011256
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 01:10:20 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 01:10:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 01:10:19 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4536ACrp005024;
	Mon, 3 Jun 2024 01:10:13 -0500
Message-ID: <744979dd-fc6f-40c4-ac21-25d26f49563a@ti.com>
Date: Mon, 3 Jun 2024 11:40:12 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/2] net: ti: icssg_prueth: add TAPRIO offload
 support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, "Anwar, Md Danish" <a0501179@ti.com>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Simon
 Horman <horms@kernel.org>, Diogo Ivo <diogo.ivo@siemens.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@ti.com>
References: <20240529110551.620907-1-danishanwar@ti.com>
 <20240529110551.620907-3-danishanwar@ti.com>
 <7143f846-623d-465f-a717-8c550407d012@intel.com>
 <a5895c1f-4f89-4da7-8977-e1d681a72442@ti.com>
 <e0fe45c7-ea81-4d5f-bb42-6bec73a7d895@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <e0fe45c7-ea81-4d5f-bb42-6bec73a7d895@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 31/05/24 7:04 pm, Andrew Lunn wrote:
>> When I had posted this series (v8) the ICSSG switch series was not
>> merged yet and I had rebased this series on net-next/main. When you
>> tested it, the ICSSG Series was merged and as it resulted in conflict.
>>
>> I will rebase it on the latest net-next and make sure that their is no
>> conflict and post next revision.
> 
> This is what i asked about, what are the build dependencies. Please
> always state them in the cover note.
> 
> In general, we recommend what when you have two or more patch series
> for a driver floating around, mark all but one RFC, so you get
> comments on them, but it is clear there is no need to try to apply
> them because of dependency conflicts.
> 

I undertsand that Andrew. I will take care of that from now.

>        Andrew

-- 
Thanks and Regards,
Danish

