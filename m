Return-Path: <netdev+bounces-96986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346B28C8911
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658EC1C20A43
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2794F69D31;
	Fri, 17 May 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tjftkaS/"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B869953;
	Fri, 17 May 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958709; cv=none; b=XSNk4hIeu9Sjh/NpotPyG36Ap4yfNekTpNs6eaSz/ABNhNeenwf9jw/AcHGfLPWeojIJhnGFGgU5TYAES8ANxf4KmHFzU8dczOQLZleF7BMe6Ft6MP8kkHX43y2NFaZUZ5VpeliFx/MlHNsa/k9mPRQUIdF5RsryCQM6qP7N8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958709; c=relaxed/simple;
	bh=SjNsK7n6ceh5K81D0gVfZ4gwulogBfesDWHdGQG2EfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tVXKacz0aOutPZLBnUGQScKKBmHzGLqyIOWG/rjU5un46/U6DFRdEFZ5m5JdSDiQkI/Bz3MFE4ue7198Pc/pzyTdd+B683A7ftaB5KxO+yVnhGoY26vJmB/4O88+ki/u8hXQ6Iq0JJEw1+QF0feLWNXBlGjlZmzI+9bt/tvGt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tjftkaS/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44HEHCJi075281;
	Fri, 17 May 2024 09:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715955432;
	bh=kt66KMrGkxREF7cMwYO1Us9NDDj6Izf4mMkTPSy7wcw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tjftkaS/AgNKcblNHzk9Ud83ecSNxlz1icFl4nmgOV9hulj7sckvUVgEDtwQ7m972
	 JRH6U3JslShjbDC/2KFuOcshIWzOb21K04eKwS9DaSzFn9QQYuyQDBUlOdZO3YAibD
	 h40h6u+hPXTzC0UuTR8nQ9RHS/zd3ieQYcdOKVhw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44HEHCct117536
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 May 2024 09:17:12 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 May 2024 09:17:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 May 2024 09:17:12 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44HEH7Sw086208;
	Fri, 17 May 2024 09:17:07 -0500
Message-ID: <7439c9e1-59cd-4d37-aab8-bc71b6a98a09@ti.com>
Date: Fri, 17 May 2024 19:47:06 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
To: Andrew Lunn <andrew@lunn.ch>
CC: <vigneshr@ti.com>, <nm@ti.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kip Broadhurst <kbroadhurst@ti.com>,
        <w.egorov@phytec.de>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
 <41e30085-937a-410a-ac6a-189307a59319@lunn.ch>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <41e30085-937a-410a-ac6a-189307a59319@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Thanks Andrew

On 5/17/2024 7:26 PM, Andrew Lunn wrote:
> On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
>> Modify license to include dual licensing as GPL-2.0-only OR MIT
>> license for TI specific phy header files. This allows for Linux
>> kernel files to be used in other Operating System ecosystems
>> such as Zephyr or FreeBSD.
>>
>> While at this, update the TI copyright year to sync with current year
>> to indicate license change.
>>
>> Cc: Kip Broadhurst <kbroadhurst@ti.com>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>>   include/dt-bindings/net/ti-dp83867.h | 4 ++--
>>   include/dt-bindings/net/ti-dp83869.h | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/dt-bindings/net/ti-dp83867.h b/include/dt-bindings/net/ti-dp83867.h
>> index 6fc4b445d3a1..2b7bc9c692f2 100644
>> --- a/include/dt-bindings/net/ti-dp83867.h
>> +++ b/include/dt-bindings/net/ti-dp83867.h
>> @@ -1,10 +1,10 @@
>> -/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
>>   /*
>>    * Device Tree constants for the Texas Instruments DP83867 PHY
>>    *
>>    * Author: Dan Murphy <dmurphy@ti.com>
>>    *
>> - * Copyright:   (C) 2015 Texas Instruments, Inc.
>> + * Copyright:   (C) 2015-2024 Texas Instruments, Inc.
>>    */
> IANAL
>
> but about 1/4 of this file was written by Wadim Egorov
> <w.egorov@phytec.de>. It would be good to Cc: him and make sure he
> does not object.

Wadim is copied.
Also will take care of copying in next version if any.


> The other file is fine, it was all Dan Murphy's work.
>
>       Andrew

