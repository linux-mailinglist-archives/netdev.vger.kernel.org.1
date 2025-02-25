Return-Path: <netdev+bounces-169384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC2CA43A25
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4A342218C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E80267F57;
	Tue, 25 Feb 2025 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cQaedq5U"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1EB267B91;
	Tue, 25 Feb 2025 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476576; cv=none; b=jch34xT6kelOq2DUEYg+LmYRtz5B6e9PYUdGedoKFtEoBqKsdOy6us32f0s40AV6zlZHm5/QgOlz9EzINpy7lItgBMkbk7ADAsY2MxdsQP5N264jKHEIiHsrkwVq35epUMalsulWga2xqIV0qAN6Xp1LnGStNs/OqsAHpyc0ZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476576; c=relaxed/simple;
	bh=QCL4qJ3PE1ixBwCHBOMcmpoONqC62sO+cxjJFE2jveo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CxYW7EJjGlmS5NO4zLlRYapTTQFJlTo6zwW5vlsofGVioYfL6mi+2uCTmtOeuLqprcBQTOWN2TjjhDOGdv0MfoO6DRnvqk8FPLCTfcRWF15Ns9MkoOa6FJGSgmodQkwz6Ox57+9NtQe+JBcNf5PzG7OEHVBjMxlGU0U15FqceFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cQaedq5U; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51P9gZKL1191019
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 03:42:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740476555;
	bh=DQOBEpOmo/uOaXGxG+Mjsq1EExMqwVoc7fNvsKF+UVE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cQaedq5Urlpaa5FzI3jSwV2H49PpiFpi3LaPuCVh6wmWEqNborRzJwzmA7VVEUPr5
	 LXxy33DvSVxw2asWsHoxaAxxP2/i6uKtKY7dK6so5SeNIgn/wE7Xy8MKN9QQ8vyliC
	 ZB/JsJFn2yoSqdSfzzdsyqLWWOLrwvO1y1lvyOnQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51P9gZ3r013415
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Feb 2025 03:42:35 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Feb 2025 03:42:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Feb 2025 03:42:34 -0600
Received: from [172.24.26.121] (lt9560gk3.dhcp.ti.com [172.24.26.121])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51P9gTA9106909;
	Tue, 25 Feb 2025 03:42:30 -0600
Message-ID: <85a366e8-5136-4b0f-914f-95d36658840e@ti.com>
Date: Tue, 25 Feb 2025 15:12:28 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] Fixes for perout configuration in IEP driver
To: Jakub Kicinski <kuba@kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>, <lokeshvutla@ti.com>,
        <vigneshr@ti.com>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250219062701.995955-1-m-malladi@ti.com>
 <415f755d-18a6-4c81-a1a7-b75d54a5886a@intel.com>
 <20250220172410.025b96d6@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20250220172410.025b96d6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/21/2025 6:54 AM, Jakub Kicinski wrote:
> On Wed, 19 Feb 2025 15:37:16 -0800 Jacob Keller wrote:
>> On 2/18/2025 10:26 PM, Meghana Malladi wrote:
>>> IEP driver supports both pps and perout signal generation using testptp
>>> application. Currently the driver is missing to incorporate the perout
>>> signal configuration. This series introduces fixes in the driver to
>>> configure perout signal based on the arguments passed by the perout
>>> request.
>>>    
>>
>> This could be interpreted as a feature implementation rather than a fix.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Agreed, ideally we should get a patch for net which rejects
> all currently (as in - in Linus's tree) unsupported settings.
> That would be a fix.
> 
> Then once that's merged add support for the new settings in net-next.
> 
> Hope that makes sense?

I do agree that this can be interpreted as a feature implementation (as 
the bug here is: missing perout driver implementation for which the 
driver claims it supports). I will post the updated patch series as 
suggested by Jakub.

Thanks,
Meghana Malladi.


