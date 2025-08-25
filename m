Return-Path: <netdev+bounces-216470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BAAB33F31
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C195216AB89
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D241A0712;
	Mon, 25 Aug 2025 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fX6zBgaT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m1973195.qiye.163.com (mail-m1973195.qiye.163.com [220.197.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC782A1D1;
	Mon, 25 Aug 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124424; cv=none; b=cy7Pkl1b+wV3IS6kJ3xaKLEQmFVTNP89+3rJZRR4jF4juIgDU1bK9Rzdo/Nv7v7R9xVoMnI0oB1aKEEPY7i/qqMz40UCGgAm/NPwYKBhAK6k7VQ6wMIi4xZ1rEPu1GeP1DvsQfcQy22Y9unUtYfqHcVI0QEf69T8ETTwjfBnjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124424; c=relaxed/simple;
	bh=lV7sceRjjC2f2qDWsPGndVZ6JWnmY4Sm0KIRNOfc3D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQttea3zSpkmq9iAd2pvpbe5B6jeyRZXnD5AMC8ppHPbFmzjawQ4iZrMnmKF+bYEPu0RERvorNiupdxR5u+fxYx6RyhmE+2InO9jD0cXmLXgT+3wHjosyQ0hE916ALlZEfs1TZw7OSDR3CKnrCJH1VD0kxByPUsWTg/XmndbzjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fX6zBgaT; arc=none smtp.client-ip=220.197.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2082e1fe5;
	Mon, 25 Aug 2025 17:57:46 +0800 (GMT+08:00)
Message-ID: <d0fe6d16-181f-4b38-9457-1099fb6419d0@rock-chips.com>
Date: Mon, 25 Aug 2025 17:57:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: ethernet: stmmac: dwmac-rk: Make the
 clk_phy could be used for external phy
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Chaoyi Chen <kernel@airkyi.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20250815023515.114-1-kernel@airkyi.com>
 <CGME20250825072312eucas1p2d4751199c0ea069c7938218be60e5e93@eucas1p2.samsung.com>
 <a30a8c97-6b96-45ba-bad7-8a40401babc2@samsung.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <a30a8c97-6b96-45ba-bad7-8a40401babc2@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98e0a9922903abkunm8d311f8d115b06e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk0ZSlYfTR1CGB8dSx9IS01WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fX6zBgaTEeGN0mpna6Hvlzu9hPBOaJ7ysGmaTVSCNEshJ9NI0YvqT5dN41kV5vWU0MQxI0TSU8F7UxzWsQA9frFPm3X79taqass4ZUIJaPhcySrUKlvo3GWS8gfLxFa1RstO8YkKTk7RqkHJ2hQjZJeTm8Bl3jwoy9sEqJzh9HQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=EVpH2Wm83g8Rb+u3uT+a83bsfBledd8G1BDKOR8Jgq0=;
	h=date:mime-version:subject:message-id:from;

Hi Marek,

On 8/25/2025 3:23 PM, Marek Szyprowski wrote:
> On 15.08.2025 04:35, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> For external phy, clk_phy should be optional, and some external phy
>> need the clock input from clk_phy. This patch adds support for setting
>> clk_phy for external phy.
>>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>
>> Changes in v3:
>> - Link to V2: https://lore.kernel.org/netdev/20250812012127.197-1-kernel@airkyi.com/
>> - Rebase to net-next/main
>>
>> Changes in v2:
>> - Link to V1: https://lore.kernel.org/netdev/20250806011405.115-1-kernel@airkyi.com/
>> - Remove get clock frequency from DT prop
>>
>>    drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 11 +++++++----
>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> index ac8288301994..5d921e62c2f5 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> @@ -1412,12 +1412,15 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
>>    		clk_set_rate(plat->stmmac_clk, 50000000);
>>    	}
>>    
>> -	if (plat->phy_node && bsp_priv->integrated_phy) {
>> +	if (plat->phy_node) {
>>    		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>>    		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
>> -		if (ret)
>> -			return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
>> -		clk_set_rate(bsp_priv->clk_phy, 50000000);
>> +		/* If it is not integrated_phy, clk_phy is optional */
>> +		if (bsp_priv->integrated_phy) {
>> +			if (ret)
>> +				return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
>> +			clk_set_rate(bsp_priv->clk_phy, 50000000);
>> +		}

I think  we should set bsp_priv->clk_phy to NULL here if we failed to get the clock.

Could you try this on your board? Thank you.

>>    	}
>>    
>>    	return 0;
> The above change lacks the following check ingmac_clk_enable(): if (!bsp_priv->integrated_phy) return 0;
>
> Otherwise it blows on machines with integrated PHY, like Hardkernel's Odroid-M1 (RK3568 based):
>
> rk_gmac-dwmac fe2a0000.ethernet: IRQ eth_lpi not found
> rk_gmac-dwmac fe2a0000.ethernet: IRQ sfty not found
> rk_gmac-dwmac fe2a0000.ethernet: clock input or output? (output).
> rk_gmac-dwmac fe2a0000.ethernet: TX delay(0x4f).
> rk_gmac-dwmac fe2a0000.ethernet: RX delay(0x2d).
> rk_gmac-dwmac fe2a0000.ethernet: integrated PHY? (no).
> Unable to handle kernel paging request at virtual address fffffffffffffffe
> Mem abort info:
>     ESR = 0x0000000096000006
>     EC = 0x25: DABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>     FSC = 0x06: level 2 translation fault
> Data abort info:
>     ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
>     CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000000249e000
> [fffffffffffffffe] pgd=0000000000000000, p4d=000000000376f403, pud=0000000003770403, pmd=0000000000000000
> Internal error: Oops: 0000000096000006 [#1]  SMP
> Modules linked in: snd_soc_rockchip_i2s_tdm snd_soc_rk817 snd_soc_core snd_compress snd_pcm_dmaengine rockchip_thermal snd_pcm dwmac_rk(+) hantro_vpu rockchip_saradc industrialio_triggered_buffer kfifo_buf stmmac_platform rockchip_rga v4l2_vp9 stmmac spi_rockchip_sfc(+) v4l2_h264 snd_timer pcs_xpcs rockchipdrm(+) videobuf2_dma_sg v4l2_jpeg rk805_pwrkey v4l2_mem2mem videobuf2_dma_contig dw_hdmi_qp rockchip_dfi rk817_charger videobuf2_memops analogix_dp videobuf2_v4l2 dw_mipi_dsi panfrost snd rtc_rk808 drm_dp_aux_bus videodev drm_shmem_helper soundcore dw_hdmi videobuf2_common drm_display_helper mc gpu_sched ahci_dwc ipv6
> CPU: 3 UID: 0 PID: 154 Comm: systemd-udevd Not tainted 6.17.0-rc1+ #10875 PREEMPT
> Hardware name: Hardkernel ODROID-M1 (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : clk_prepare+0x18/0x44
> lr : gmac_clk_enable+0xf8/0x188 [dwmac_rk]
> ..
> Call trace:
>    clk_prepare+0x18/0x44 (P)
>    gmac_clk_enable+0xf8/0x188 [dwmac_rk]
>    rk_gmac_powerup+0x4c/0x1f0 [dwmac_rk]
>    rk_gmac_probe+0x3b4/0x5c8 [dwmac_rk]
>    platform_probe+0x5c/0xac
>    really_probe+0xbc/0x298
>    __driver_probe_device+0x78/0x12c
>    driver_probe_device+0x40/0x164
>    __driver_attach+0x9c/0x1ac
>    bus_for_each_dev+0x74/0xd0
>    driver_attach+0x24/0x30
>    bus_add_driver+0xe4/0x208
>    driver_register+0x60/0x128
>    __platform_driver_register+0x24/0x30
>    rk_gmac_dwmac_driver_init+0x20/0x1000 [dwmac_rk]
>    do_one_initcall+0x64/0x308
>    do_init_module+0x58/0x23c
>    load_module+0x1b48/0x1dc4
>    init_module_from_file+0x84/0xc4
>    idempotent_init_module+0x188/0x280
>    __arm64_sys_finit_module+0x68/0xac
>    invoke_syscall+0x48/0x110
>    el0_svc_common.constprop.0+0xc8/0xe8
>    do_el0_svc+0x20/0x2c
>    el0_svc+0x4c/0x160
>    el0t_64_sync_handler+0xa0/0xe4
>    el0t_64_sync+0x198/0x19c
> Code: 910003fd f9000bf3 52800013 b40000e0 (f9400013)
> ---[ end trace 0000000000000000 ]---
>
> Best regards

