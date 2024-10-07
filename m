Return-Path: <netdev+bounces-132580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B89923D4
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 07:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3CA1C2216E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 05:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D480139D1E;
	Mon,  7 Oct 2024 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B+DiS9C5"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B0139CFA;
	Mon,  7 Oct 2024 05:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728278076; cv=none; b=kwOHlOE3UYTjVNVAwsT/YE6W63pkweitWnzgL/N+CLDnmC+tuVjUFj8WC8m/PvoIzP+Kshq9ddpffrIkzmy/kX1WtqJh7KKpo/Fg1Ku4ZCbXa5pPeAjixm5the2wVl6NXjtsRezY/GngOM+TkCSxtXc9iHmdnEznZO7ehzSsA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728278076; c=relaxed/simple;
	bh=glujGhuouhR6tZcWKwQlZ4dPKFfUr7KE4A40baq8cCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SR1eohWqH8VPlqrBCuPpYVpmke/UHhlTGejD5aHmUP4pNg/PWjkHgDMymBiD3lUX33KocicQ+IF1EyoIvQFliiGX5XePe0NbGWabiktbBuaqv01l0fOAfYnGKDeoy0Ou3ISG7qbAiVHQt4aE07cxBUk8VEDqbuoWWSlyZbTUihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B+DiS9C5; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4975E1sT054601;
	Mon, 7 Oct 2024 00:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728278042;
	bh=+IJn3Mr1Y+S2ZowOgJdniuPe/b1G/Bqe1cFQM5wp+E0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=B+DiS9C5MS/aY+G1zKmmwXF8IYJSa0hlp2wa9UPjZiTgbXH+WqXhTEqgQlKQh+IkB
	 QzAKEzL30jm6fJXzRHNAqgsWhGF0/d+eIOIk3ypefgVXd/vl/uIKvyu1g50LG+yc0t
	 dwcidJ/VTyhRADjG8wOnNkITiiZcdaww8Qoxp4Rs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4975E1TJ076325
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Oct 2024 00:14:01 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 00:14:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 00:14:01 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4975DuNp047138;
	Mon, 7 Oct 2024 00:13:57 -0500
Message-ID: <a5fbbde6-8f77-47b9-a7dc-566d8e082e15@ti.com>
Date: Mon, 7 Oct 2024 10:43:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix race condition for VLAN
 table access
To: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
CC: MD Danish Anwar <danishanwar@ti.com>, <robh@kernel.org>,
        <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
        <diogo.ivo@siemens.com>, <andrew@lunn.ch>, <pabeni@redhat.com>,
        <edumazet@google.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
References: <20241003105940.533921-1-danishanwar@ti.com>
 <20241003174142.384e51ad@kernel.org>
 <4f1f0d20-6411-49c8-9891-f7843a504e9c@ti.com>
 <20241004104610.GD1310185@kernel.org> <20241004130755.3ec07538@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20241004130755.3ec07538@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 10/5/2024 1:37 AM, Jakub Kicinski wrote:
> On Fri, 4 Oct 2024 11:46:10 +0100 Simon Horman wrote:
>>> 1. Move the documentation to kdoc - This is will result in checkpatch
>>> 2. Keep the documentation in kdoc as well as inline - This will result
>>> in no warnings but duplicate documentation which I don't think is good.
>>>
>>> I was not sure which one takes more precedence check patch or kdoc, thus
>>> put it inline thinking fixing checkpatch might have more weightage.
>>>
>>> Let me know what should be done here.  
>>
>> FWIIW, my preference would be for option 2.
> 
> Of the two options I'd pick 1, perhaps due to my deeply seated
> "disappointment" in the quality of checkpatch warnings :)
> Complaining about missing comment when there's a kdoc is a false
> positive in my book. But option 2 works, too.
> 
> I haven't tested it but there's also the option 3 - providing 
> the kdoc inline, something like:
> 
> +	/** @vtbl_lock: Lock for vtbl in shared memory */
> +	spinlock_t vtbl_lock;
> 

Hi Jakub, I tested this and option 3 works. I don't see either kdoc or
checkpatch warning. I will go ahead and re spin the patch with option 3.

> Again, no strong preference on which option you choose.
> kdoc warnings may get emitted during builds so we should avoid them.

-- 
Thanks and Regards,
Md Danish Anwar

