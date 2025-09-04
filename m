Return-Path: <netdev+bounces-219886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56181B43976
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B555A0253
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A0F2FB96A;
	Thu,  4 Sep 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Xit9gLr6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m1973181.qiye.163.com (mail-m1973181.qiye.163.com [220.197.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B942FB626;
	Thu,  4 Sep 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983806; cv=none; b=bRBXO3E5JimrZziDX+Tl7XKAlTBXB5PIrRyw/ceGapi66dB9cXqLB71A+/asJLyWIrwC/7/20lzXoFZuzS1ujc46udHr3tA7Pc20T3/6Epu8cJMizhkvXShisAKGphyUHtcv23eSEQWwIibRfdR+QLRh/jTomB6tZzEm3gpYj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983806; c=relaxed/simple;
	bh=ow5b9POkaXEpqRK3dMVygB0UZ9/f6SRG+hIyHUyvm/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jbapasr9fBdvxCNYhTJwvTLxO50jRl67HKbA5bSSnaGhlkiSlALTRyug3KTJcZaJM2NRmbuguDOzATvJpL43OihYui96UhP+AspjS3IIVEpxmPU6z+CZ4KUpK0CZa1kJ6ZKXUbuyKmKgs1ZJaxbp60VQf2x9A5DEdXLCyHHml94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Xit9gLr6; arc=none smtp.client-ip=220.197.31.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 21b2ed1f3;
	Thu, 4 Sep 2025 19:03:11 +0800 (GMT+08:00)
Message-ID: <b5fbeb3f-9962-444d-85b3-3b8a11f69266@rock-chips.com>
Date: Thu, 4 Sep 2025 19:03:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't contain
 invalid address
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20250904031222.40953-3-ziyao@disroot.org>
 <aLlwv3v8ACha8b-3@shell.armlinux.org.uk>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <aLlwv3v8ACha8b-3@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a991465108003abkunm0f56a227434cd4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhDQlZLGR4dShpIS0pDQkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Xit9gLr6c2F67gZWiRJ3knK+6v3aqUFhgRcIQ2qpT3IVYWVLjxjDx+93FZxit8MYIQ2q4QDexxikifP7ohn/GuR6WZl8TXLXN7BsZSF1phcaUvWq4h0bSxKVFlB7oNT+jkw/9A/nyTQILFNQSy4ZP7NbYAiYNyjQ3WrTJxtEWzs=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ZFFCk3oD5mOkAzLuXB6XLVMdJMHaibq0TJviAsZVl/c=;
	h=date:mime-version:subject:message-id:from;


On 9/4/2025 6:58 PM, Russell King (Oracle) wrote:
> On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
>>   	if (plat->phy_node) {
>>   		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>>   		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
>> -		/* If it is not integrated_phy, clk_phy is optional */
>> +		/*
>> +		 * If it is not integrated_phy, clk_phy is optional. But we must
>> +		 * set bsp_priv->clk_phy to NULL if clk_phy isn't proivded, or
>> +		 * the error code could be wrongly taken as an invalid pointer.
>> +		 */
> I'm concerned by this. This code is getting the first clock from the DT
> description of the PHY. We don't know what type of PHY it is, or what
> the DT description of that PHY might suggest that the first clock would
> be.
>
> However, we're geting it and setting it to 50MHz. What if the clock is
> not what we think it is?

We only set integrated_phy to 50M, which are all known targets. For external PHYs, we do not perform frequency settings.



>
> I'm not sure we should be delving in to some other device's DT
> properties to then get resources that it _uses_ to then effectively
> take control those resources.
>
> I think we need way more detail on what's going on. Commit da114122b83
> merely stated:
>
>      For external phy, clk_phy should be optional, and some external phy
>      need the clock input from clk_phy. This patch adds support for setting
>      clk_phy for external phy.
>
> If the external PHY requires a clock supplied to it, shouldn't the PHY
> driver itself be getting that clock and setting it appropriately?
>

