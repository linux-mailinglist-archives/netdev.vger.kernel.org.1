Return-Path: <netdev+bounces-138977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E409AF946
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 07:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1441C21DFD
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED47518E058;
	Fri, 25 Oct 2024 05:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mvH+6nSS"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75588176AAD;
	Fri, 25 Oct 2024 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835301; cv=none; b=l5Uc5hkQPAqWcKAS3z+RhnBbKstkAjmAsFMsXy5ZDP1RPGEz5LHwLfbyz1qQ5vJXd+lw7RpLSZ0CpZb/hk7VfvGsDaNhIvoWpM+OvMV6CTRT/a5I53y+Ho2UPOU5fPE0W18IFvfNhVdlf4hLjk+YMpFuuwMMe9Wzmifoqf0N/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835301; c=relaxed/simple;
	bh=tuP/s5gh59A2YrZ8VTjZRwycjimE3WdhxkwS7JTFjkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oUk2HuSpw3vsvnkLk54Uw59kxg8rSZFYihuPn03NN46kcjzuKj8AXL+NR/PQ467/S0TlzemA5vPJtsoBzftFilTC6aI7G5Iv6xJR9Z4ykJlrvaZ913wCCnkKIDhWMUf058qbxZFkIluslx6zx1yY/XqtZ4LWNs08IqxiFmqdzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mvH+6nSS; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49P5lovC086446;
	Fri, 25 Oct 2024 00:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729835270;
	bh=sC0AZObzS5wq+HeZuDHGnanURF/3iC1yxkVC6FEekQw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mvH+6nSStuBl/YUJotLEAfWJeMmrS22V2XN7PwIM84oxAIkoyjCPrtgwIUWLpEhV+
	 X3f8idDYM4OlBLzu/LugkKXoPVcOKuUgYbBQDylkDnXFoON6Cf61Kwm7xagQ3VJH7X
	 bZ9zYRiCrdBEhIMckVIEuN5o/IayUlNQ6kWWiTeQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49P5lowk020548
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Oct 2024 00:47:50 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Oct 2024 00:47:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Oct 2024 00:47:50 -0500
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49P5ljGw087759;
	Fri, 25 Oct 2024 00:47:46 -0500
Message-ID: <060c298c-5961-467a-80dd-947c85207eea@ti.com>
Date: Fri, 25 Oct 2024 11:17:44 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix 1 PPS sync
To: Andrew Lunn <andrew@lunn.ch>
CC: <vigneshr@ti.com>, <horms@kernel.org>, <jan.kiszka@siemens.com>,
        <diogo.ivo@siemens.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <vadim.fedorenko@linux.dev>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20241024113140.973928-1-m-malladi@ti.com>
 <1a0a632e-0b3c-4192-8d00-51d23c15c97e@lunn.ch>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <1a0a632e-0b3c-4192-8d00-51d23c15c97e@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 25/10/24 01:25, Andrew Lunn wrote:
>> +static inline u64 icssg_readq(const void __iomem *addr)
>> +{
>> +	return readl(addr) + ((u64)readl(addr + 4) << 32);
>> +}
>> +
>> +static inline void icssg_writeq(u64 val, void __iomem *addr)
>> +{
>> +	writel(lower_32_bits(val), addr);
>> +	writel(upper_32_bits(val), addr + 4);
>> +}
> 
> Could readq() and writeq() be used, rather than your own helpers?
> 
> 	Andrew
> 
The addresses we are trying to read here are not 64-bit aligned, hence 
using our own helpers to read the 64-bit value.

Regards,
Meghana

