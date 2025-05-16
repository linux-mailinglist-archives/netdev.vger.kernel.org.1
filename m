Return-Path: <netdev+bounces-191053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD012AB9EA1
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A038E7A770A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6766914884C;
	Fri, 16 May 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Uu08swzm"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09464182D2;
	Fri, 16 May 2025 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405895; cv=none; b=PCqutF4DNMcR1kyzLuuQKwDOGyYZQ1g/V9H4wfwOH7GNHDpwBPv3i0rs3bu7Lc6aPhKxzrBxtfvRZs86U1Sj7KL/8zNE+fV9OIq5Aljlh3krCU2MS4w8BST9rnt8IISsnUwPb/vpvfDls1DA1DhPxIWKI+972skv2BhLCWDlf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405895; c=relaxed/simple;
	bh=M7o1V0Yz2b8z6+5dv8rT1AaCCrJCBA8c8DP1AB+RZSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Oidqy9NByoXZtxr+1J7Q1TwpbTQPVjkTycrsobCJvWn7TF9R+/wZgKpIzDGz5LCN9Eh2ca50QGYATO64RqlQVXjoiqB25faNsdDVjO2HryKQXDfJSkb0cNbdm8NpldbzHtHAGEEz32JdwpU9JZJN4DuLpsASVkvzPCbPZ+9gPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Uu08swzm; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54GEUvXx331109;
	Fri, 16 May 2025 09:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747405857;
	bh=Se7SjLpGUe2hll4l9FYqJAqFl200CdYNr0JbGi6Mdfo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Uu08swzmfS19/F+OugzJFEeiinG4K2YQuYzn2rPbTK4NsM3qTu+BQUdpjXERBeBaG
	 r7nni9qw+7W92Cq9IoOUj2780qtHVaiSXgqnC+7zv+qkRiJ+DJLNdQ8H3W4OjgAR27
	 0umN77qj1puGL12tQp4dss0kxRMKCmIjsqHHom1k=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54GEUvAf2265453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 16 May 2025 09:30:57 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 May 2025 09:30:57 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Fri, 16 May
 2025 09:30:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 May 2025 09:30:57 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54GEUugK055994;
	Fri, 16 May 2025 09:30:56 -0500
Message-ID: <d09482d0-5169-4a2a-b00b-e492928abe5b@ti.com>
Date: Fri, 16 May 2025 09:30:56 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Peter Rosin
	<peda@axentia.se>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>
CC: kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Samuel Holland <samuel@sholland.org>, "Arnd
 Bergmann" <arnd@arndb.de>
References: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
 <174738338644.6332.8007717408731919554.b4-ty@linaro.org>
 <bfe991fa-f54c-4d58-b2e0-34c4e4eb48f4@linaro.org>
 <3172aba1-77f8-46a7-a967-14fae37f66ea@linaro.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <3172aba1-77f8-46a7-a967-14fae37f66ea@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 5/16/25 3:58 AM, Krzysztof Kozlowski wrote:
> On 16/05/2025 10:26, Krzysztof Kozlowski wrote:
>> On 16/05/2025 10:16, Krzysztof Kozlowski wrote:
>>>
>>> On Thu, 15 May 2025 16:05:56 +0200, Krzysztof Kozlowski wrote:
>>>> MMIO mux uses now regmap_init_mmio(), so one way or another
>>>> CONFIG_REGMAP_MMIO should be enabled, because there are no stubs for
>>>> !REGMAP_MMIO case:
>>>>
>>>>    ERROR: modpost: "__regmap_init_mmio_clk" [drivers/mux/mux-mmio.ko] undefined!
>>>>
>>>> REGMAP_MMIO should be, because it is a non-visible symbol, but this
>>>> causes a circular dependency:
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/1] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
>>>        https://git.kernel.org/krzk/linux/c/39bff565b40d26cc51f6e85b3b224c86a563367e
>>>
>> And dropped. More recursive dependencies are detected, so my fix here is
>> incomplete.
>>
>> error: recursive dependency detected!
>> 	symbol REGMAP default is visible depending on REGMAP_MMIO
>> 	symbol REGMAP_MMIO is selected by MUX_MMIO
>> 	symbol MUX_MMIO depends on MULTIPLEXER
>> 	symbol MULTIPLEXER is selected by MDIO_BUS_MUX_MULTIPLEXER
>> 	symbol MDIO_BUS_MUX_MULTIPLEXER depends on MDIO_BUS
>> 	symbol MDIO_BUS is selected by REGMAP
>>
>> https://krzk.eu/#/builders/43/builds/4855
>>
>> That's a mess, I need work on this a bit more.
> 
> 
> My branch fails with above error because I do not have Heiner's commit
> a3e1c0ad8357 ("net: phy: factor out provider part from mdio_bus.c").
> Will it reach current RC (rc7) at some point? I could merge the tag to
> my next branch to solve it.
> 
> 

I took a shot at breaking this recursive dependency at the REGMAP config[0].
That should allow REGMAP_MMIO to be selected by MUX_MMIO without touching
stuff here in netdev.

Kconfig is a huge mess at this point, the golden rule of "select should be
used with care" is completely ignored, there are now more uses of select
in Linux Kconfig than the normal "depends on"! Might be time to add that
SAT solver..

Andrew

[0] https://www.spinics.net/lists/kernel/msg5687922.html

