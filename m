Return-Path: <netdev+bounces-233858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA9C19516
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECAA3AA38A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992EE315D4E;
	Wed, 29 Oct 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GiBLcPoK"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3530F7F5
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728845; cv=none; b=B32fGWv6+OW9JM4ADCDrE5bHkidYdG74bw/BC8GTXngzoijnzWNVMI8obugmmt1jjYv9v9n3FCQVfA5GbVf2p+REnMzOmm6ySHPu9SZBn7WRMzJ8EaneFZTBUdlb4+hy57vYyE3VhMBquDhYPxpV8ji9RptSNo0d8HG54ncfJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728845; c=relaxed/simple;
	bh=a/0eHzdglTkiqzhJrEZqxDDhD1UW7gDlS/tNpuOlCeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wtc02dnQCB8zRSJmcb/fy8vDwEy1xUjvkj+YSopKmrJ1WvGPu4dMKfxSsyyANk6X+0TkVXX5XCgoO+QsCYS3S2VK0daPrbTTQNyONHQ25isJ+IvkgnSGsd7rgJjjmTHepL3qiX9CKBug+AGazd+SJjxlON6Ye9DB/7s4gOb3e/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GiBLcPoK; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <58de2a18-94da-4018-95f6-2fa4242e231d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761728831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSM+L1NFIiX7SYEcbrIOFFcrQwPjbZGXAyCL3OtPVkc=;
	b=GiBLcPoKt6ODncrbCkCW6LXXwUQ2jnA+MF1dYONPD2UQmXBSyk1BMO0oiJX66udecbROkD
	Ecq2tUTd/wbmK+WH3CVW5dQAcpoYXFTOQMVzNcNVxAW7Wk+RJf8ah/jM9/gUPXe7x3ujCY
	lGZ+o54IZQ5POGdhK8FgUGNo9xUFht4=
Date: Wed, 29 Oct 2025 17:07:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/3] net: stmmac: Add generic suspend/resume
 helper for PCI-based controllers
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Qunqin Zhao <zhaoqunqin@loongson.cn>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Furong Xu <0x1207@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251028154332.59118-1-ziyao@disroot.org>
 <20251028154332.59118-2-ziyao@disroot.org>
 <aQDoZaET4D64KfQA@shell.armlinux.org.uk>
 <91de05f5-3475-45eb-bbf7-162365186297@linux.dev>
 <aQHXlbDRAu76m5by@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <aQHXlbDRAu76m5by@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/29 下午5:00, Russell King (Oracle) 写道:
> On Wed, Oct 29, 2025 at 10:27:18AM +0800, Yanteng Si wrote:
>> 在 2025/10/28 下午11:59, Russell King (Oracle) 写道:
>>> On Tue, Oct 28, 2025 at 03:43:30PM +0000, Yao Zi wrote:
>>>> Most glue driver for PCI-based DWMAC controllers utilize similar
>>>> platform suspend/resume routines. Add a generic implementation to reduce
>>>> duplicated code.
>>>>
>>>> Signed-off-by: Yao Zi<ziyao@disroot.org>
>>>> ---
>>>>    drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
>>>>    .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++++++
>>> I would prefer not to make stmmac_main.c even larger by including bus
>>> specific helpers there. We already have stmmac_pltfm.c for those which
>>> use struct platform_device. The logical name would be stmmac_pci.c, but
>>> that's already taken by a driver.
>>>
>>> One way around that would be to rename stmmac_pci.c to dwmac-pci.c
>>> (glue drivers tend to be named dwmac-foo.c) and then re-use
>>> stmmac_pci.c for PCI-related stuff in the same way that stmmac_pltfm.c
>>> is used.
>>>
>>> Another idea would be stmmac_libpci.c.
>> I also don't want stmmac_main.c to grow larger, and I prefer
>> stmmac_libpci.c instead. Another approach - maybe we can
>> keep these helper functions in stmmac_pci.c and just declare
>> them as extern where needed?
> stmmac_pci.c is itself a glue driver, supporting PCI IDs:
>
> 	0x0700, 0x1108	- synthetic ID
> 	0x104a, 0xcc09	- ST Micro MAC
> 	0x16c3, 0x7102	- Synopsys GMAC5
>
> I don't think we should try to turn a glue driver into a library,
> even though it would be the easier option (we could reuse
> CONFIG_STMMAC_PCI.)

I agree with your opinion; let's build a new library.


Thanks,

Yanteng


