Return-Path: <netdev+bounces-126980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA11973779
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EE41C24E30
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A44193096;
	Tue, 10 Sep 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jQ4Xm46q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363A18DF72;
	Tue, 10 Sep 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971663; cv=none; b=L0jG5dTCrdbE1ZK1xJG2gYff6p/xZ/0pd6DlbtQ27dzxjwjajvpqaPkX+iJFzuLOOsMPLfUUPg8PzOLB1OJ1p5RUuFaJSv2DJ6Gevd6om9kwERke3JDQBN90VS2GY6ZShGjT9tFgw6cuzUXIX1zGJWT/oLaonjTyCZpZCbGojmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971663; c=relaxed/simple;
	bh=D2of0rmBPhrdqN50P0yetrVdysC/ySiDXZoj6UmJiAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdyaNKxe112itg1AtTh/enKtiNzDJmEz3sQjr9k+NWs9yKIKRkLlWifHjwyXov1m2Y7Q51fYbtCM48fjwkiFcWGJLtOhhAO7Q74IER0AA9l85raBRxFmHBpjTzUYt1uC4NFq9DqspUYdDIqKj5eHMGvG75rEzSVxJxyS4CcnBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jQ4Xm46q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pIOWqjZFdYf+oBYK80d0t+9czHjmiEGQG/cnsNBDATE=; b=jQ4Xm46q/0XjX88PpXmKGhfR18
	vTwHUIOEFEpq5ATVxJLNbu+7JuPlPN698cUJcIQa+E0k2nYj6+j6+DNszmcACjYm2jl/XlKgKfeoC
	9/pRhkVo1GbTea3QdmkThP/YIhfV2PdqGoda5aLqJ1BOB+6/U6NhsYhVNlMtGCzuqtSs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1so04S-0076ev-2R; Tue, 10 Sep 2024 14:34:12 +0200
Date: Tue, 10 Sep 2024 14:34:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, jdamato@fastly.com,
	horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
Message-ID: <a863646c-adc0-4d16-aad3-158702dfef45@lunn.ch>
References: <20240910075942.1270054-1-shaojijie@huawei.com>
 <20240910075942.1270054-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910075942.1270054-6-shaojijie@huawei.com>

On Tue, Sep 10, 2024 at 03:59:36PM +0800, Jijie Shao wrote:
> Implement the .ndo_open() .ndo_stop() .ndo_set_mac_address()
> .ndo_change_mtu functions() and ndo.get_stats64()
> And .ndo_validate_addr calls the eth_validate_addr function directly
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
> v8 -> v9:
>   - Remove HBG_NIC_STATE_OPEN in ndo.open() and ndo.stop(),
>     suggested by Kalesh and Andrew.
>   - Use netif_running() instead of hbg_nic_is_open() in ndo.change_mtu(),
>     suggested by Kalesh and Andrew
>   v8: https://lore.kernel.org/all/20240909023141.3234567-1-shaojijie@huawei.com/
> v6 -> v7:
>   - Add implement ndo.get_stats64(), suggested by Paolo.
>   v6: https://lore.kernel.org/all/20240830121604.2250904-6-shaojijie@huawei.com/
> v5 -> v6:
>   - Delete netif_carrier_off() in .ndo_open() and .ndo_stop(),
>     suggested by Jakub and Andrew.
>  v5: https://lore.kernel.org/all/20240827131455.2919051-1-shaojijie@huawei.com/
> v3 -> v4:
>   - Delete INITED_STATE in priv, suggested by Andrew.
>   - Delete unnecessary defensive code in hbg_phy_start()
>     and hbg_phy_stop(), suggested by Andrew.
>   v3: https://lore.kernel.org/all/20240822093334.1687011-1-shaojijie@huawei.com/
> RFC v1 -> RFC v2:
>   - Delete validation for mtu in hbg_net_change_mtu(), suggested by Andrew.
>   - Delete validation for mac address in hbg_net_set_mac_address(),
>     suggested by Andrew.
>   - Add a patch to add is_valid_ether_addr check in dev_set_mac_address,
>     suggested by Andrew.
>   RFC v1: https://lore.kernel.org/all/20240731094245.1967834-1-shaojijie@huawei.com/
> ---
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 39 ++++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |  3 +
>  .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 97 +++++++++++++++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 11 ++-
>  4 files changed, 149 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
> index 8e971e9f62a0..97fee714155a 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
> @@ -15,6 +15,7 @@
>   * ctrl means packet description, data means skb packet data
>   */
>  #define HBG_ENDIAN_CTRL_LE_DATA_BE	0x0
> +#define HBG_PCU_FRAME_LEN_PLUS 4
>  
>  static bool hbg_hw_spec_is_valid(struct hbg_priv *priv)
>  {
> @@ -129,6 +130,44 @@ void hbg_hw_irq_enable(struct hbg_priv *priv, u32 mask, bool enable)
>  	hbg_reg_write(priv, HBG_REG_CF_INTRPT_MSK_ADDR, value);
>  }
>  
> +void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr)
> +{
> +	hbg_reg_write64(priv, HBG_REG_STATION_ADDR_LOW_2_ADDR, mac_addr);
> +}
> +
> @@ -88,6 +181,10 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ret)
>  		return ret;
>  
> +	netdev->max_mtu = priv->dev_specs.max_mtu;
> +	netdev->min_mtu = priv->dev_specs.min_mtu;
> +	hbg_change_mtu(priv, HBG_DEFAULT_MTU_SIZE);

It does not help that you added added HBG_DEFAULT_MTU_SIZE in a
previous patch, but as far as i see, it is just ETH_DATA_LEN.

Please use the standard defines, rather than adding your own. It makes
the code a lot easier to understand, it is not using some special
jumbo size by default, it is just the plain, boring, normal 1500
bytes.

    Andrew

---
pw-bot: cr

