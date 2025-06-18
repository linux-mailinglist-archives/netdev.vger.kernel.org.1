Return-Path: <netdev+bounces-199002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BAAADEA1D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7847A9A59
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7C2E2650;
	Wed, 18 Jun 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTR2bzNa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE963285056
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246263; cv=none; b=XhbWN7rvZ7PH1JLZBxG0NgIl9HLw7aZfJWctBrDtbqoyYCDfM2QU/7bRiUjI8MPQ1S53SqM/JJANh+sEkqv8s2hEuT4aW8GsSbHjMB2YsJV61xCajNG5KMSVqmXzJOa/Xs85ubJV5Of+fAv7FlF15IftZdFB+i/GZpBQwx3Knsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246263; c=relaxed/simple;
	bh=op463HFwpozUXcnLDJpbh5e1wOXUqGzsj3gNSHkF6hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crnH1lk+iit85RI47cMhqawcXXDabg2LyltTJVNjlp+HYjS6rwla0U9vpeUXzvOLHTf/3Zf9vANoEMAQ+U2yNm/CUaf0ywmRV+2tdjNdKR8d9wMOBm8pE2OBse3Q3ozk0O0PjTI+rBiLJfiR5ZJPSqImD1K6z4WN5xunKkm9mVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTR2bzNa; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750246261; x=1781782261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=op463HFwpozUXcnLDJpbh5e1wOXUqGzsj3gNSHkF6hw=;
  b=RTR2bzNaToXA+7bxMXCZbe4OpCWHbxM5tpSzeAhSUQRgdEXoG5vbQjcS
   WCosnoRCviawKK+P0T8o+ytnopLIsGwuhnlFZrurldPgzqg6Hpn7NiT4A
   iuEY3zrx+x0yt2q7u23Gx38OS9iJmCna1cMMkjvkNrihjV0jMA7ZdGAXT
   XAqc+etbCZvxgxTgcqpV3livZOoXGlQLAT4Gf2JbzWIl4XJL4ETxrqByi
   6I3ORjUk+ZO72zy9qPVoQ2dqraeJmARJk1dXGxQi6bDSaVlJoSP3dcuAk
   495FBZukmGuDpNWqtxctcbTnw1nWwwoUf05ty7CkCGTjrLqOctFPaRpDa
   Q==;
X-CSE-ConnectionGUID: HTvgO1RhTTCDI4Etmt2SgQ==
X-CSE-MsgGUID: u2Rj+H2TRWGPXpOBw7Y7wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63810267"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="63810267"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 04:29:52 -0700
X-CSE-ConnectionGUID: nmvufV68S3WApAtUcf2txw==
X-CSE-MsgGUID: B15fEukxQOWnW28mwjDanQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="149314136"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 04:29:49 -0700
Date: Wed, 18 Jun 2025 13:28:59 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com, jiawenwu@net-swift.com
Subject: Re: [PATCH net-next 02/12] net: libwx: add base vf api for vf drivers
Message-ID: <aFKi++7iX3PuEd9V@mev-dev.igk.intel.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
 <20250611083559.14175-3-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611083559.14175-3-mengyuanlou@net-swift.com>

On Wed, Jun 11, 2025 at 04:35:49PM +0800, Mengyuan Lou wrote:
> Implement mbox_write_and_read_ack functions which are
> used to set basic functions like set_mac, get_link.etc
> for vf.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/Makefile  |   1 +
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c   |   2 +-
>  drivers/net/ethernet/wangxun/libwx/wx_hw.h   |   1 +
>  drivers/net/ethernet/wangxun/libwx/wx_type.h |   1 +
>  drivers/net/ethernet/wangxun/libwx/wx_vf.c   | 521 +++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_vf.h   |  61 +++
>  6 files changed, 586 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf.c
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf.h
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
> index 9b78b604a94e..ddf0bb921676 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -5,3 +5,4 @@
>  obj-$(CONFIG_LIBWX) += libwx.o
>  
>  libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o
> +libwx-objs += wx_vf.o
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 0f4be72116b8..82dd76f0326e 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -1107,7 +1107,7 @@ static int wx_write_uc_addr_list(struct net_device *netdev, int pool)
>   *  by the MO field of the MCSTCTRL. The MO field is set during initialization
>   *  to mc_filter_type.
>   **/
> -static u32 wx_mta_vector(struct wx *wx, u8 *mc_addr)
> +u32 wx_mta_vector(struct wx *wx, u8 *mc_addr)
>  {
>  	u32 vector = 0;
>  
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
> index 26a56cba60b9..718015611da6 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
> @@ -29,6 +29,7 @@ void wx_mac_set_default_filter(struct wx *wx, u8 *addr);
>  int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool);
>  int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool);
>  void wx_flush_sw_mac_table(struct wx *wx);
> +u32 wx_mta_vector(struct wx *wx, u8 *mc_addr);
>  int wx_set_mac(struct net_device *netdev, void *p);
>  void wx_disable_rx(struct wx *wx);
>  int wx_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index f2061c893358..d2d0764792d4 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1213,6 +1213,7 @@ struct wx {
>  
>  	void *priv;
>  	u8 __iomem *hw_addr;
> +	u8 __iomem *b4_addr; /* vf only */
>  	struct pci_dev *pdev;
>  	struct net_device *netdev;
>  	struct wx_bus_info bus;
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.c b/drivers/net/ethernet/wangxun/libwx/wx_vf.c
> new file mode 100644
> index 000000000000..a211329fd71a
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.c
> @@ -0,0 +1,521 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/pci.h>
> +
> +#include "wx_type.h"
> +#include "wx_hw.h"
> +#include "wx_mbx.h"
> +#include "wx_vf.h"
> +
> +static void wx_virt_clr_reg(struct wx *wx)
> +{
> +	u32 vfsrrctl;
> +	int i;
> +
> +	/* VRSRRCTL default values (BSIZEPACKET = 2048, BSIZEHEADER = 256) */
> +	vfsrrctl = WX_VXRXDCTL_HDRSZ(wx_hdr_sz(WX_RX_HDR_SIZE));
> +	vfsrrctl |= WX_VXRXDCTL_BUFSZ(wx_buf_sz(WX_RX_BUF_SIZE));
> +
> +	/* clear all rxd ctl */
> +	for (i = 0; i < 7; i++) {

Define for 7 will be usefull.

> +		wr32m(wx, WX_VXRXDCTL(i),
> +		      WX_VXRXDCTL_HDRSZ_MASK | WX_VXRXDCTL_BUFSZ_MASK,
> +		      vfsrrctl);
> +	}

Drop {, } as it is one line.

> +
> +	rd32(wx, WX_VXSTATUS);
> +}
> +
> +/**
> + *  wx_start_hw_vf - Prepare hardware for Tx/Rx
> + *  @wx: pointer to hardware structure
> + *
> + *  Starts the hardware by filling the bus info structure and media type, clears
> + *  all on chip counters, initializes receive address registers, multicast
> + *  table, VLAN filter table, calls routine to set up link and flow control
> + *  settings, and leaves transmit and receive units disabled and uninitialized
> + **/
> +void wx_start_hw_vf(struct wx *wx)
> +{
> +	/* Clear wx stopped flag */
> +	wx->adapter_stopped = false;

From the description it should do a lot more. Maybe move the description
to the patch where the function is filled.

> +}
> +EXPORT_SYMBOL(wx_start_hw_vf);
> +
> +/**
> + *  wx_init_hw_vf - virtual function hardware initialization
> + *  @wx: pointer to hardware structure
> + *
> + *  Initialize the hardware by resetting the hardware and then starting
> + *  the hardware

Now it is just setting the flag and reading MAC address.

> + **/
> +void wx_init_hw_vf(struct wx *wx)
> +{
> +	wx_start_hw_vf(wx);
> +	wx_get_mac_addr_vf(wx, wx->mac.addr);
> +}
> +EXPORT_SYMBOL(wx_init_hw_vf);
> +
> +static int wx_mbx_write_and_read_reply(struct wx *wx, u32 *req_buf,
> +				       u32 *resp_buf, u16 size)
> +{
> +	int ret;
> +
> +	ret = wx_write_posted_mbx(wx, req_buf, size);
> +	if (unlikely(ret))

Why unlikely? It isn't usuall to add in error handling outside hot path.

> +		return ret;
> +
> +	return wx_read_posted_mbx(wx, resp_buf, size);
> +}
> +
> +/**
> + *  wx_reset_hw_vf - Performs hardware reset
> + *  @wx: pointer to hardware structure
> + *
> + *  Resets the hardware by resetting the transmit and receive units, masks and
> + *  clears all interrupts.
> + *
> + *  Return: returns 0 on success, negative error code on failure
> + **/
> +int wx_reset_hw_vf(struct wx *wx)
> +{
> +	struct wx_mbx_info *mbx = &wx->mbx;
> +	u32 msgbuf[4] = {WX_VF_RESET};
> +	u8 *addr = (u8 *)(&msgbuf[1]);
> +	u32 b4_buf[16] = {0};
> +	u32 timeout = 200;
> +	int ret;
> +	u32 i;
> +
> +	/* Call wx stop to disable tx/rx and clear interrupts */
> +	wx_stop_adapter_vf(wx);
> +
> +	/* reset the api version */
> +	wx->vfinfo->vf_api = wx_mbox_api_null;
> +
> +	/* backup msix vectors */
> +	if (wx->b4_addr) {

Where this address is being set? I wonder if 0 is always invalid (as 0
sounds like valid address) and also if it shouldn't return error in case
wx->b4_addr is invalid.

> +		for (i = 0; i < 16; i++)
> +			b4_buf[i] = readl(wx->b4_addr + i * 4);
> +	}
> +
> +	wr32m(wx, WX_VXCTRL, WX_VXCTRL_RST, WX_VXCTRL_RST);
> +	rd32(wx, WX_VXSTATUS);
> +
> +	/* we cannot reset while the RSTI / RSTD bits are asserted */
> +	while (!wx_check_for_rst_vf(wx) && timeout) {
> +		timeout--;
> +		udelay(5);
> +	}
> +
> +	/* restore msix vectors */
> +	if (wx->b4_addr) {
> +		for (i = 0; i < 16; i++)
> +			writel(b4_buf[i], wx->b4_addr + i * 4);
> +	}
> +
> +	/* amlite: bme */
> +#define WX_VX_PF_BME	0x4B8

In my opinion it should go to the header where there are other
register definitions.

> +	if (wx->mac.type == wx_mac_aml || wx->mac.type == wx_mac_aml40)
> +		wr32(wx, WX_VX_PF_BME, BIT(0));

BIT(0) can be also described there.

> +
> +	if (!timeout)
> +		return -EBUSY;
> +
> +	/* Reset VF registers to initial values */
> +	wx_virt_clr_reg(wx);
> +
> +	/* mailbox timeout can now become active */
> +	mbx->timeout = 2000;
> +
> +	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
> +					  ARRAY_SIZE(msgbuf));
> +	if (ret)
> +		return ret;
> +
> +	if (msgbuf[0] != (WX_VF_RESET | WX_VT_MSGTYPE_ACK) &&
> +	    msgbuf[0] != (WX_VF_RESET | WX_VT_MSGTYPE_NACK))
> +		return -EINVAL;
> +
> +	if (msgbuf[0] == (WX_VF_RESET | WX_VT_MSGTYPE_ACK))
> +		ether_addr_copy(wx->mac.perm_addr, addr);
> +
> +	wx->mac.mc_filter_type = msgbuf[3];
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(wx_reset_hw_vf);
> +
> +/**
> + *  wx_stop_adapter_vf - Generic stop Tx/Rx units
> + *  @wx: pointer to hardware structure
> + *
> + *  Sets the adapter_stopped flag within wx struct. Clears interrupts,
> + *  disables transmit and receive units. The adapter_stopped flag is used by
> + *  the shared code and drivers to determine if the wx is in a stopped
> + *  state and should not touch the hardware.
> + *
> + *  Return: returns 0 on success, negative error code on failure
> + **/
> +int wx_stop_adapter_vf(struct wx *wx)
> +{
> +	u32 reg_val;
> +	u16 i;
> +
> +	wx->adapter_stopped = true;
> +
> +	/* Clear interrupt mask to stop from interrupts being generated */
> +	wr32(wx, WX_VXIMS, WX_VF_IRQ_CLEAR_MASK);
> +
> +	/* Clear any pending interrupts, flush previous writes */
> +	wr32(wx, WX_VXICR, U32_MAX);
> +
> +	/* Disable the transmit unit.  Each queue must be disabled. */
> +	for (i = 0; i < wx->mac.max_tx_queues; i++)
> +		wr32(wx, WX_VXTXDCTL(i), WX_VXTXDCTL_FLUSH);
> +
> +	/* Disable the receive unit by stopping each queue */
> +	for (i = 0; i < wx->mac.max_rx_queues; i++) {
> +		reg_val = rd32(wx, WX_VXRXDCTL(i));
> +		reg_val &= ~WX_VXRXDCTL_ENABLE;
> +		wr32(wx, WX_VXRXDCTL(i), reg_val);
> +	}
> +	/* Clear packet split and pool config */
> +	wr32(wx, WX_VXMRQC, 0);
> +
> +	/* flush all queues disables */
> +	rd32(wx, WX_VXSTATUS);
> +
> +	return 0;

Always returns 0, should be void.

> +}
> +EXPORT_SYMBOL(wx_stop_adapter_vf);
> +
> +/**
> + *  wx_set_rar_vf - set device MAC address
> + *  @wx: pointer to hardware structure
> + *  @index: Receive address register to write
> + *  @addr: Address to put into receive address register
> + *  @enable_addr: set flag that address is active
> + *
> + *  Return: returns 0 on success, negative error code on failure
> + **/
> +int wx_set_rar_vf(struct wx *wx, u32 index, u8 *addr, u32 enable_addr)
> +{
> +	u32 msgbuf[3] = {WX_VF_SET_MAC_ADDR};
> +	u8 *msg_addr = (u8 *)(&msgbuf[1]);
> +	int ret;
> +
> +	memcpy(msg_addr, addr, ETH_ALEN);
> +
> +	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
> +					  ARRAY_SIZE(msgbuf));
> +	if (ret)
> +		return ret;
> +	msgbuf[0] &= ~WX_VT_MSGTYPE_CTS;
> +
> +	/* if nacked the address was rejected, use "perm_addr" */
> +	if (msgbuf[0] == (WX_VF_SET_MAC_ADDR | WX_VT_MSGTYPE_NACK)) {
> +		wx_get_mac_addr_vf(wx, wx->mac.addr);
> +		return -EINVAL;
> +	}
> +
> +	return ret;

nit, ret is always 0 here, so return 0; should be more readable.

> +}
> +EXPORT_SYMBOL(wx_set_rar_vf);
> +
> +/**
> + *  wx_update_mc_addr_list_vf - Update Multicast addresses
> + *  @wx: pointer to the HW structure
> + *  @netdev: pointer to the net device structure
> + *
> + *  Updates the Multicast Table Array.
> + *
> + *  Return: returns 0 on success, negative error code on failure
> + **/
> +int wx_update_mc_addr_list_vf(struct wx *wx, struct net_device *netdev)
> +{
> +	u32 msgbuf[WX_VXMAILBOX_SIZE] = {0};

WX_VXMAILBOX_SIZE is 15, but 4B is opcode. There is 14 * 4B for payload
= 56B, so it is 28 16 bit words, not 30, am I correct? Please add it as
define instead of just the number.

> +	u16 *vector_l = (u16 *)&msgbuf[1];
> +	struct netdev_hw_addr *ha;
> +	u32 cnt, i;
> +
> +	/* Each entry in the list uses 1 16 bit word.  We have 30
> +	 * 16 bit words available in our HW msgbuf buffer (minus 1 for the
> +	 * msgbuf type).  That's 30 hash values if we pack 'em right. If
> +	 * there are more than 30 MC addresses to add then punt the
> +	 * extras for now and then add code to handle more than 30 later.
> +	 * It would be unusual for a server to request that many multi-cast
> +	 * addresses except for in large enterprise network environments.
> +	 */

I think you should handle more than 30 here, instead of writting a
comment about adding it later. It is just about sending anoither
command, yes?

}
> +
> +	cnt = netdev_mc_count(netdev);
> +	if (cnt > 30)
> +		cnt = 30;
> +	msgbuf[0] = WX_VF_SET_MULTICAST;
> +	msgbuf[0] |= cnt << WX_VT_MSGINFO_SHIFT;
> +
> +	i = 0;
> +	netdev_for_each_mc_addr(ha, netdev) {
> +		if (i == cnt)
> +			break;
> +		if (is_link_local_ether_addr(ha->addr))
> +			continue;
> +
> +		vector_l[i++] = wx_mta_vector(wx, ha->addr);

What about endianess, don't you need a __cpu_to_le16/be16 conversion? 

> +	}
> +
> +	return wx_write_posted_mbx(wx, msgbuf, WX_VXMAILBOX_SIZE);

Shouldn't the size be cut to the real number of address?

> +}
> +EXPORT_SYMBOL(wx_update_mc_addr_list_vf);
> +
> +/**
> + *  wx_update_xcast_mode_vf - Update Multicast mode
> + *  @wx: pointer to the HW structure
> + *  @xcast_mode: new multicast mode
> + *
> + *  Updates the Multicast Mode of VF.
> + *
> + *  Return: returns 0 on success, negative error code on failure
> + **/
> +int wx_update_xcast_mode_vf(struct wx *wx, int xcast_mode)
> +{
> +	u32 msgbuf[2] = {WX_VF_UPDATE_XCAST_MODE, xcast_mode};
> +	int ret = 0;
> +
> +	switch (wx->vfinfo->vf_api) {
> +	case wx_mbox_api_13:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

if (api != vx_mbox_api_13)
	return -EINVAL;

> +
> +	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
> +					  ARRAY_SIZE(msgbuf));
> +	if (ret)
> +		return ret;
> +
> +	msgbuf[0] &= ~WX_VT_MSGTYPE_CTS;
> +	if (msgbuf[0] == (WX_VF_UPDATE_XCAST_MODE | WX_VT_MSGTYPE_NACK))
> +		return -EINVAL;
> +
> +	return ret;

return 0;

> +}
> +EXPORT_SYMBOL(wx_update_xcast_mode_vf);
> +
> +/**
> + * wx_get_link_state_vf - Get VF link state from PF
> + * @wx: pointer to the HW structure
> + * @link_state: link state storage
> + *
> + * Return: return state of the operation error or success.
> + **/
> +int wx_get_link_state_vf(struct wx *wx, u16 *link_state)
> +{
> +	u32 msgbuf[2] = {WX_VF_GET_LINK_STATE};
> +	int ret = 0;
> +
> +	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
> +					  ARRAY_SIZE(msgbuf));
> +	if (ret)
> +		return ret;
> +
> +	if (msgbuf[0] & WX_VT_MSGTYPE_NACK)
> +		return -EINVAL;
> +
> +	*link_state = msgbuf[1];
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(wx_get_link_state_vf);
> +
> +/**
> + *  wx_set_vfta_vf - Set/Unset vlan filter table address
> + *  @wx: pointer to the HW structure
> + *  @vlan: 12 bit VLAN ID
> + *  @vind: unused by VF drivers
> + *  @vlan_on: if true then set bit, else clear bit
> + *  @vlvf_bypass: boolean flag indicating updating default pool is okay
> + *
> + *  Turn on/off specified VLAN in the VLAN filter table.
> + *
> + *  Return: returns 0 on success, negative error code on failure
> + **/
> +int wx_set_vfta_vf(struct wx *wx, u32 vlan, u32 vind, bool vlan_on,
> +		   bool vlvf_bypass)
> +{
> +	u32 msgbuf[2] = {WX_VF_SET_VLAN, vlan};
> +	bool vlan_offload = false;
> +	int ret = 0;
> +
> +	/* Setting the 8 bit field MSG INFO to TRUE indicates "add" */
> +	msgbuf[0] |= vlan_on << WX_VT_MSGINFO_SHIFT;
> +	/* if vf vlan offload is disabled, allow to create vlan under pf port vlan */
> +	msgbuf[0] |= BIT(vlan_offload);
> +
> +	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
> +					  ARRAY_SIZE(msgbuf));
> +	if (ret)
> +		return ret;
> +
> +	if (msgbuf[0] & WX_VT_MSGTYPE_ACK)
> +		return 0;
> +
> +	return msgbuf[0] & WX_VT_MSGTYPE_NACK;

This will be positive on fail. Reword the kdoc.
Is it even possible to not have ACK and not have NACK?
Maybe return -EIO; here is enough? Or even better return error if no ACK
and return 0; at the end.

> +}
> +EXPORT_SYMBOL(wx_set_vfta_vf);
> +
> +void wx_get_mac_addr_vf(struct wx *wx, u8 *mac_addr)
> +{
> +	ether_addr_copy(mac_addr, wx->mac.perm_addr);
> +}
> +EXPORT_SYMBOL(wx_get_mac_addr_vf);
> +
> +int wx_get_fw_version_vf(struct wx *wx)
> +{
> +	u32 msgbuf[2] = {WX_VF_GET_FW_VERSION};
> +	int ret;
> +
> +	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
> +					  ARRAY_SIZE(msgbuf));
> +	if (ret)
> +		return ret;
> +
> +	if (msgbuf[0] & WX_VT_MSGTYPE_NACK)
> +		return -EINVAL;
> +	snprintf(wx->eeprom_id, 32, "0x%08x", msgbuf[1]);
> +
> +	return ret;

It will be great to stick to one style of checking if it is possible.
Here is the best, if nack returns error, just return 0 at the end, as
ret is always 0 here.

> +}
> +EXPORT_SYMBOL(wx_get_fw_version_vf);
> +
> +int wx_set_uc_addr_vf(struct wx *wx, u32 index, u8 *addr)
> +{
> +	u32 msgbuf[3] = {WX_VF_SET_MACVLAN};
> +	u8 *msg_addr = (u8 *)(&msgbuf[1]);
> +	int ret;
> +
> +	/* If index is one then this is the start of a new list and needs
> +	 * indication to the PF so it can do it's own list management.
> +	 * If it is zero then that tells the PF to just clear all of
> +	 * this VF's macvlans and there is no new list.
> +	 */
> +	msgbuf[0] |= index << WX_VT_MSGINFO_SHIFT;
> +	if (addr)
> +		memcpy(msg_addr, addr, 6);
> +	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
> +					  ARRAY_SIZE(msgbuf));
> +	if (ret)
> +		return ret;
> +
> +	msgbuf[0] &= ~WX_VT_MSGTYPE_CTS;
> +
> +	if (msgbuf[0] == (WX_VF_SET_MACVLAN | WX_VT_MSGTYPE_NACK))
> +		return -EINVAL;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(wx_set_uc_addr_vf);
> +
> +/**
> + *  wx_rlpml_set_vf - Set the maximum receive packet length
> + *  @wx: pointer to the HW structure
> + *  @max_size: value to assign to max frame size
> + *
> + *  Return: returns 0 on success, negative error code on failure
> + **/
> +int wx_rlpml_set_vf(struct wx *wx, u16 max_size)
> +{
> +	u32 msgbuf[2] = {WX_VF_SET_LPE, max_size};
> +	int ret;
> +
> +	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
> +					  ARRAY_SIZE(msgbuf));
> +	if (ret)
> +		return ret;
> +	if ((msgbuf[0] & WX_VF_SET_LPE) &&
> +	    (msgbuf[0] & WX_VT_MSGTYPE_NACK))
> +		return -EINVAL;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(wx_rlpml_set_vf);
> +
> +/**
> + *  wx_negotiate_api_version - Negotiate supported API version
> + *  @wx: pointer to the HW structure
> + *  @api: integer containing requested API version
> + *
> + *  Return: returns 0 on success, negative error code on failure
> + **/
> +int wx_negotiate_api_version(struct wx *wx, int api)
> +{
> +	u32 msgbuf[2] = {WX_VF_API_NEGOTIATE, api};
> +	int ret;
> +
> +	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
> +					  ARRAY_SIZE(msgbuf));
> +	if (ret)
> +		return ret;
> +
> +	msgbuf[0] &= ~WX_VT_MSGTYPE_CTS;
> +
> +	/* Store value and return 0 on success */
> +	if (msgbuf[0] == (WX_VF_API_NEGOTIATE | WX_VT_MSGTYPE_NACK))
> +		return -EINVAL;
> +	wx->vfinfo->vf_api = api;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(wx_negotiate_api_version);
> +
> +int wx_get_queues_vf(struct wx *wx, u32 *num_tcs, u32 *default_tc)
> +{
> +	u32 msgbuf[5] = {WX_VF_GET_QUEUES};
> +	int ret = 0;

int ret; is enough.

> +
> +	/* do nothing if API doesn't support wx_get_queues */
> +	switch (wx->vfinfo->vf_api) {
> +	case wx_mbox_api_13:
> +		break;
> +	default:
> +		return 0;

if() instead

> +	}
> +
> +	/* Fetch queue configuration from the PF */
> +	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
> +					  ARRAY_SIZE(msgbuf));
> +	if (ret)
> +		return ret;
> +	msgbuf[0] &= ~WX_VT_MSGTYPE_CTS;
> +
> +	/* if we didn't get an ACK there must have been
> +	 * some sort of mailbox error so we should treat it
> +	 * as such
> +	 */
> +	if (msgbuf[0] != (WX_VF_GET_QUEUES | WX_VT_MSGTYPE_ACK))
> +		return -EINVAL;
> +	/* record and validate values from message */
> +	wx->mac.max_tx_queues = msgbuf[WX_VF_TX_QUEUES];
> +	if (wx->mac.max_tx_queues == 0 ||
> +	    wx->mac.max_tx_queues > WX_VF_MAX_TX_QUEUES)
> +		wx->mac.max_tx_queues = WX_VF_MAX_TX_QUEUES;
> +
> +	wx->mac.max_rx_queues = msgbuf[WX_VF_RX_QUEUES];
> +	if (wx->mac.max_rx_queues == 0 ||
> +	    wx->mac.max_rx_queues > WX_VF_MAX_RX_QUEUES)
> +		wx->mac.max_rx_queues = WX_VF_MAX_RX_QUEUES;
> +
> +	*num_tcs = msgbuf[WX_VF_TRANS_VLAN];
> +	/* in case of unknown state assume we cannot tag frames */
> +	if (*num_tcs > wx->mac.max_rx_queues)
> +		*num_tcs = 1;
> +	*default_tc = msgbuf[WX_VF_DEF_QUEUE];
> +	/* default to queue 0 on out-of-bounds queue number */
> +	if (*default_tc >= wx->mac.max_tx_queues)
> +		*default_tc = 0;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(wx_get_queues_vf);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
> new file mode 100644
> index 000000000000..eb40048f46eb
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
> +
> +#ifndef _WX_VF_H_
> +#define _WX_VF_H_
> +
> +#define WX_VXSTATUS              0x4
> +#define WX_VXCTRL                0x8
> +#define WX_VXCTRL_RST            BIT(0)
> +
> +#define WX_VXMRQC                0x78
> +#define WX_VXICR                 0x100
> +#define WX_VXIMS                 0x108
> +#define WX_VF_IRQ_CLEAR_MASK     7
> +#define WX_VF_MAX_TX_QUEUES      4
> +#define WX_VF_MAX_RX_QUEUES      4
> +#define WX_VXTXDCTL(r)           (0x3010 + (0x40 * (r)))
> +#define WX_VXRXDCTL(r)           (0x1010 + (0x40 * (r)))
> +#define WX_VXRXDCTL_ENABLE       BIT(0)
> +#define WX_VXTXDCTL_FLUSH        BIT(26)
> +
> +#define WX_VXRXDCTL_RSCMAX(f)    FIELD_PREP(GENMASK(24, 23), f)
> +#define WX_VXRXDCTL_BUFLEN(f)    FIELD_PREP(GENMASK(6, 1), f)
> +#define WX_VXRXDCTL_BUFSZ(f)     FIELD_PREP(GENMASK(11, 8), f)
> +#define WX_VXRXDCTL_HDRSZ(f)     FIELD_PREP(GENMASK(15, 12), f)
> +
> +#define WX_VXRXDCTL_RSCMAX_MASK  GENMASK(24, 23)
> +#define WX_VXRXDCTL_BUFLEN_MASK  GENMASK(6, 1)
> +#define WX_VXRXDCTL_BUFSZ_MASK   GENMASK(11, 8)
> +#define WX_VXRXDCTL_HDRSZ_MASK   GENMASK(15, 12)
> +
> +#define wx_conf_size(v, mwidth, uwidth) ({ \
> +	typeof(v) _v = (v); \
> +	(_v == 2 << (mwidth) ? 0 : _v >> (uwidth)); \
> +})
> +#define wx_buf_len(v)            wx_conf_size(v, 13, 7)
> +#define wx_hdr_sz(v)             wx_conf_size(v, 10, 6)
> +#define wx_buf_sz(v)             wx_conf_size(v, 14, 10)
> +#define wx_pkt_thresh(v)         wx_conf_size(v, 4, 0)
> +
> +#define WX_RX_HDR_SIZE           256
> +#define WX_RX_BUF_SIZE           2048
> +
> +void wx_start_hw_vf(struct wx *wx);
> +void wx_init_hw_vf(struct wx *wx);
> +int wx_reset_hw_vf(struct wx *wx);
> +void wx_get_mac_addr_vf(struct wx *wx, u8 *mac_addr);
> +int wx_stop_adapter_vf(struct wx *wx);
> +int wx_get_fw_version_vf(struct wx *wx);
> +int wx_set_rar_vf(struct wx *wx, u32 index, u8 *addr, u32 enable_addr);
> +int wx_update_mc_addr_list_vf(struct wx *wx, struct net_device *netdev);
> +int wx_set_uc_addr_vf(struct wx *wx, u32 index, u8 *addr);
> +int wx_rlpml_set_vf(struct wx *wx, u16 max_size);
> +int wx_negotiate_api_version(struct wx *wx, int api);
> +int wx_get_queues_vf(struct wx *wx, u32 *num_tcs, u32 *default_tc);
> +int wx_update_xcast_mode_vf(struct wx *wx, int xcast_mode);
> +int wx_get_link_state_vf(struct wx *wx, u16 *link_state);
> +int wx_set_vfta_vf(struct wx *wx, u32 vlan, u32 vind, bool vlan_on,
> +		   bool vlvf_bypass);
> +
> +#endif /* _WX_VF_H_ */

In general it will be great to define structures for each command that
is used in VF communication. Filling it should be also easier.

Thanks

> -- 
> 2.30.1

