Return-Path: <netdev+bounces-219889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3819B439AA
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E25D587F02
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6672FC002;
	Thu,  4 Sep 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dnmK9/UP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m1973188.qiye.163.com (mail-m1973188.qiye.163.com [220.197.31.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA42EC08B;
	Thu,  4 Sep 2025 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984424; cv=none; b=FtP2WBGTXt6ouVHMuUy5nUaJPfxj9ftwj0t/1rfblcfoA3Odpio9+kCnPjFYMbGUGmg7MY3gkC+1p07/gDlcdZ64xoRtb14rLZPSfC3YZPqBBQ9USQhVksGI3EN9gYiuzHDwQ3M9TPsJF9GPd14wIWW3nzXZtP+CWWm8ZO9gN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984424; c=relaxed/simple;
	bh=VR+slzUaA5P3b/xmVtL0y9/SvFdjzQ6rC/I6OeGj5H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bL0Q392HbzWj6Vyg5L8Is3ThzPJxS+wXsjLsUUqRhARZk8MjOB/YiUZ4NoTvt6TsQIz5fJR9Qjp+3b2tizEdnzMy/FIzkk3wytDTbkUqIKE2GuqXZGOXmO6AnCRn6ccqbIiu5X9Zero8i5Rk33mBgw3WW2pTQhrsWWW6yfgycJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dnmK9/UP; arc=none smtp.client-ip=220.197.31.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 21b2ecee9;
	Thu, 4 Sep 2025 18:58:13 +0800 (GMT+08:00)
Message-ID: <b0f9d781-6b8f-49dd-bfa1-456a26d01290@rock-chips.com>
Date: Thu, 4 Sep 2025 18:58:12 +0800
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
 Simon Horman <horms@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20250904031222.40953-3-ziyao@disroot.org>
 <20250904103443.GH372207@horms.kernel.org>
 <aLluvYQ-i-Z9vyp7@shell.armlinux.org.uk>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <aLluvYQ-i-Z9vyp7@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a991460843203abkunm7caaa1364336ff
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQktCT1ZOGEtOSEJLSE0dTEpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dnmK9/UPjJ1KtwkXs3RJue/a/vLG/YZOsysbscDZnwQNDQ5c4C0amKOXSiZUmTfNj8kHxAwVGhJt7sRb1ow7t8d3Ekv6iAXbCUl6eiSd+h5CO81xKVPLvWmod1zbw4ATKS+DhKoAd5OkjF+3GaDMCJC5hwrLGmZOR2S/m/p7nWI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=oO8OiE3oPK2BXfQ71EAQVoAAmLr86e+akm6hPKvxYiw=;
	h=date:mime-version:subject:message-id:from;


On 9/4/2025 6:49 PM, Russell King (Oracle) wrote:
> On Thu, Sep 04, 2025 at 11:34:43AM +0100, Simon Horman wrote:
>> Thanks, and sorry for my early confusion about applying this patch.
>>
>> I agree that the bug you point out is addressed by this patch.
>> Although I wonder if it is cleaner not to set bsp_priv->clk_phy
>> unless there is no error, rather than setting it then resetting
>> it if there is an error.
> +1 !
>
>> More importantly, I wonder if there is another bug: does clk_set_rate need
>> to be called in the case where there is no error and bsp_priv->integrated_phy
>> is false?
> I think there's another issue:
>
> static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
> {
> ...
>          if (plat->phy_node) {
>                  bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
> ...
>
> static void rk_gmac_remove(struct platform_device *pdev)
> {
> ...
>          if (priv->plat->phy_node && bsp_priv->integrated_phy)
>                  clk_put(bsp_priv->clk_phy);
>
> So if bsp_priv->integrated_phy is false, then we get the clock but
> don't put it.

Yes! Just remove "bsp_priv->integrated_phy"


