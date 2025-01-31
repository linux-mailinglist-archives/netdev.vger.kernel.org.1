Return-Path: <netdev+bounces-161785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50240A23F56
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 16:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA8F3A6954
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AAB1C5D74;
	Fri, 31 Jan 2025 15:03:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3213D66;
	Fri, 31 Jan 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738335799; cv=none; b=m4g2TT0tTpuylXPF9BR8sIbSvM7O3A0drSgHNfReq6DJmkTRQ3gt/vLKUicm8JauEHLz+m6W0Bc8fOydaMfP1nMkdU7cAOulbOoX9Sw9LDoGEBCEh6UNZxYXMtHqTjdtfp3O3QS3PB6pHgJWOvmgrSH4NnQsjnxKXFG6Tkc9h0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738335799; c=relaxed/simple;
	bh=y8udIcxdrbNjwq612CEizD0X1c7DqRt6OGB3wweQYr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNIyFJdYkQ1xNh6WWrjmpIiGf8RUna6bulLLc1m9usTtQC2rQ51kRiu5CAD1WBB0SUR1K+LzfvrXxT4MFZWBO2i8stOO2AF85qQ6wGm4vREnxvn90bzRCDq54CUsgwrQPUZOGWqnVcvu62ts+48dF6a/cRm/K1Wa05oaTNc1buI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E983497;
	Fri, 31 Jan 2025 07:03:42 -0800 (PST)
Received: from [10.1.32.52] (e122027.cambridge.arm.com [10.1.32.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 996973F694;
	Fri, 31 Jan 2025 07:03:13 -0800 (PST)
Message-ID: <d6265f8e-51bc-4556-9ecb-bfb73f86260d@arm.com>
Date: Fri, 31 Jan 2025 15:03:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability value
 when FIFO size isn't specified
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Yanteng Si <si.yanteng@linux.dev>,
 Furong Xu <0x1207@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <07af1102-0fa7-45ad-bcbc-aef0295ceb63@arm.com>
 <fc08926d-b9af-428f-8811-4bfe08acc5b7@lunn.ch>
 <f343c126-fed9-4209-a18d-61a4e604db2f@arm.com>
 <a4e31542-3534-4856-a90f-e47960ed0907@lunn.ch>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <a4e31542-3534-4856-a90f-e47960ed0907@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2025 14:47, Andrew Lunn wrote:
>>> I'm guessing, but in your setup, i assume the value is never written
>>> to a register, hence 0 is O.K. e.g. dwmac1000_dma_operation_mode_rx(),
>>> the fifosz value is used to determine if flow control can be used, but
>>> is otherwise ignored.
>>
>> I haven't traced the code, but that fits my assumptions too.
> 
> I could probably figure it out using code review, but do you know
> which set of DMA operations your hardware uses? A quick look at
> dwmac-rk.c i see:
> 
>         /* If the stmmac is not already selected as gmac4,
>          * then make sure we fallback to gmac.
>          */
>         if (!plat_dat->has_gmac4)
>                 plat_dat->has_gmac = true;

has_gmac4 is false on this board, so has_gmac will be set to true here.

The DT compatible is rockchip,rk3288-gmac

Steve

> Which suggests there are two variants of the RockChip MAC.
> 
> 	Andrew


