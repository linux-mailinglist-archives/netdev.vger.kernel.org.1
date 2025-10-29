Return-Path: <netdev+bounces-233769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3744BC180A7
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8CE1A220D1
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1FB2C236B;
	Wed, 29 Oct 2025 02:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h+xYBjTn"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E761F0994
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704850; cv=none; b=Lq/vTWgwvzZAea+suNm8mf9k2Ft0YXAHQ+o70e5VtxK7+UItOJETWMvOIjyDgK48DX5w0uOUnUIf/XqKxfHdgzuc4UcAyju83igB/NsEWzG4JCwZypBGSKU85EepAvH9kQrmcj6x3tEexZYpDHjCNh/J+cGZV4XBMaZnlXY8DVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704850; c=relaxed/simple;
	bh=ZAa8YrfBZCJJvU2+LBOiK9HqGPmJmDvCTByCdVc/+HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWywLi7aQ9/fa5UVWJoP0i2k2P0/J3cB4HCMsmr/iQuiy6onc4g3I5teyzeq3gMhNRQbEiitOTpJ23VhKwyw/drxbrvJK708P0yOLvHkP8CatwLcjt3wklo4qxhQWuaBAl3L2Yw5+8jAzeqQVSyA5Fq7lO2WhHj6HZ5YuaxCKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h+xYBjTn; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <91de05f5-3475-45eb-bbf7-162365186297@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761704846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpJ/2UeKPOQj3QH3COAUSbB7u7mUiVa8jSdlFJvPeMY=;
	b=h+xYBjTnwvtV8tO5ZhjdcS7E0G6taAoRUCOOgWBTWHbElXWR3LpAeUx5YkqzPzBMa90Pbi
	Ya7p27k5tTBBM1w7JB/Xmi72kuhvRm/TUhsOHq7Si8JL74OLnArhYLYHtmvCBjORNeYfVT
	mpMW4w3z6E3xICCX7KpnzwvHz/9T23A=
Date: Wed, 29 Oct 2025 10:27:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/3] net: stmmac: Add generic suspend/resume
 helper for PCI-based controllers
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <aQDoZaET4D64KfQA@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/28 下午11:59, Russell King (Oracle) 写道:
> On Tue, Oct 28, 2025 at 03:43:30PM +0000, Yao Zi wrote:
>> Most glue driver for PCI-based DWMAC controllers utilize similar
>> platform suspend/resume routines. Add a generic implementation to reduce
>> duplicated code.
>>
>> Signed-off-by: Yao Zi <ziyao@disroot.org>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
>>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++++++
> I would prefer not to make stmmac_main.c even larger by including bus
> specific helpers there. We already have stmmac_pltfm.c for those which
> use struct platform_device. The logical name would be stmmac_pci.c, but
> that's already taken by a driver.
>
> One way around that would be to rename stmmac_pci.c to dwmac-pci.c
> (glue drivers tend to be named dwmac-foo.c) and then re-use
> stmmac_pci.c for PCI-related stuff in the same way that stmmac_pltfm.c
> is used.
>
> Another idea would be stmmac_libpci.c.

I also don't want stmmac_main.c to grow larger, and I prefer

stmmac_libpci.c instead. Another approach - maybe we can

keep these helper functions in stmmac_pci.c and just declare

them as extern where needed?


Thanks,

Yanteng

>

