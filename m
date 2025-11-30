Return-Path: <netdev+bounces-242833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B03C953E6
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 20:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF07C4E01FF
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A8F2C08D1;
	Sun, 30 Nov 2025 19:28:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF51B87C9;
	Sun, 30 Nov 2025 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764530919; cv=none; b=gdXF32D0EehYqWyOttD8d5vpnejmLe4Idq6VF4MV58gBbVUT7NLUdWJkc1ImraVDlYavdYyB+Dt3yqdYO9n0NLcgb0kRNSAEOchliSHR+R+CQL2yGl8/BLyRVzkLo9SErm+eyg96rTTD62Dz3Xv5YjHnwYDHSOt6ROLd3VxTmp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764530919; c=relaxed/simple;
	bh=/3NtXpBqqkX2KBuXqBLrK+wVLh+0QKXcA4PpwZOodL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ah1zMYtEk2BVmggwpoKjjvsfUbG9hTVlbtwl23dRE0/wesncZ8/3F5+5nVGX7kVrUyluRuArUAhtlLMvPj78BiHeVxvC1+v/NNEJl/E31xKiQNsHd3wE8S8TztoZ17vJh6sNfgcVt3vslz6lfOWQogH7hx3+i811ke5j9NGspz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.57.174] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E3DE261CC3FDB;
	Sun, 30 Nov 2025 20:27:25 +0100 (CET)
Message-ID: <e765a7ca-c3dc-49cc-a8a5-de6c0fa58f2f@molgen.mpg.de>
Date: Sun, 30 Nov 2025 20:27:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: fix ptp time increment
 while link is down
To: =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus.bloechl@ipetronik.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251130-i40e_ptp_link_down-v2-1-8d6dfc10a661@blochl.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251130-i40e_ptp_link_down-v2-1-8d6dfc10a661@blochl.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Markus,


Thank you for the patch.

Am 30.11.25 um 16:23 schrieb Markus Blöchl:
> When an X710 ethernet port with an active ptp daemon (like the ptp4l and
> phc2sys combo) suddenly loses its link and regains it after a while, the
> ptp daemon has a hard time to recover synchronization and sometimes
> entirely fails to do so.
> 
> The issue seems to be related to a wrongly configured increment while the
> link is down. This could not be observed with the Intel reference driver.
> We identified the fix to appear in Intels official ethernet-linux-i40e

Intel’s

> release version 2.17.4.
> 
> Include the relevant changes in the kernel version of this driver.
> 
> Fixes: beb0dff1251d ("i40e: enable PTP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Blöchl <markus@blochl.de>
> ---
> Tested with an X710 at 10G link speed and kernel version 6.12.42.

I’d really appreciate it, if you put the in the commit message above, 
and if you provided exact steps for reproducing this in the commit message.

> ---
> Changes in v2:
> - Fix kdoc and code formatting
> - Rebase onto net tree
> - Link to v1: https://lore.kernel.org/r/20251119-i40e_ptp_link_down-v1-1-b351fed254b3@blochl.de
> ---
>   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h |  9 +++
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c        | 69 +++++++++++++++++++++--
>   drivers/net/ethernet/intel/i40e/i40e_register.h   |  9 +++
>   drivers/net/ethernet/intel/i40e/i40e_type.h       |  8 +++
>   4 files changed, 90 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> index cc02a85ad42b..ec176e9569ad 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> @@ -1488,6 +1488,15 @@ enum i40e_aq_link_speed {
>   	I40E_LINK_SPEED_25GB	= BIT(I40E_LINK_SPEED_25GB_SHIFT),
>   };
>   
> +enum i40e_prt_mac_pcs_link_speed {
> +	I40E_PRT_MAC_PCS_LINK_SPEED_UNKNOWN = 0,
> +	I40E_PRT_MAC_PCS_LINK_SPEED_100MB,
> +	I40E_PRT_MAC_PCS_LINK_SPEED_1GB,
> +	I40E_PRT_MAC_PCS_LINK_SPEED_10GB,
> +	I40E_PRT_MAC_PCS_LINK_SPEED_40GB,
> +	I40E_PRT_MAC_PCS_LINK_SPEED_20GB
> +};
> +
>   struct i40e_aqc_module_desc {
>   	u8 oui[3];
>   	u8 reserved1;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 33535418178b..89abe2f22216 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -847,6 +847,66 @@ void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index)
>   	i40e_ptp_convert_to_hwtstamp(skb_hwtstamps(skb), ns);
>   }
>   
> +/**
> + * i40e_ptp_get_link_speed_hw - get the link speed
> + * @pf: Board private structure
> + *
> + * Calculate link speed depending on the link status.
> + *
> + * Return: current link speed.
> + **/
> +static enum i40e_aq_link_speed i40e_ptp_get_link_speed_hw(struct i40e_pf *pf)
> +{
> +	bool link_up = pf->hw.phy.link_info.link_info & I40E_AQ_LINK_UP;
> +	enum i40e_aq_link_speed link_speed = I40E_LINK_SPEED_UNKNOWN;
> +	struct i40e_hw *hw = &pf->hw;
> +
> +	if (link_up) {
> +		struct i40e_link_status *hw_link_info = &hw->phy.link_info;
> +
> +		i40e_aq_get_link_info(hw, true, NULL, NULL);
> +		link_speed = hw_link_info->link_speed;
> +	} else {
> +		enum i40e_prt_mac_link_speed prtmac_linksta;
> +		u64 prtmac_pcs_linksta;
> +
> +		prtmac_linksta = (rd32(hw, I40E_PRTMAC_LINKSTA(0)) &
> +				  I40E_PRTMAC_LINKSTA_MAC_LINK_SPEED_MASK) >>
> +				  I40E_PRTMAC_LINKSTA_MAC_LINK_SPEED_SHIFT;
> +		if (prtmac_linksta == I40E_PRT_MAC_LINK_SPEED_40GB) {
> +			link_speed = I40E_LINK_SPEED_40GB;
> +		} else {
> +			i40e_aq_debug_read_register(hw,
> +						    I40E_PRTMAC_PCS_LINK_STATUS1(0),
> +						    &prtmac_pcs_linksta,
> +						    NULL);
> +
> +			prtmac_pcs_linksta = (prtmac_pcs_linksta &
> +					      I40E_PRTMAC_PCS_LINK_STATUS1_LINK_SPEED_MASK) >>
> +					      I40E_PRTMAC_PCS_LINK_STATUS1_LINK_SPEED_SHIFT;
> +
> +			switch (prtmac_pcs_linksta) {
> +			case I40E_PRT_MAC_PCS_LINK_SPEED_100MB:
> +				link_speed = I40E_LINK_SPEED_100MB;
> +				break;
> +			case I40E_PRT_MAC_PCS_LINK_SPEED_1GB:
> +				link_speed = I40E_LINK_SPEED_1GB;
> +				break;
> +			case I40E_PRT_MAC_PCS_LINK_SPEED_10GB:
> +				link_speed = I40E_LINK_SPEED_10GB;
> +				break;
> +			case I40E_PRT_MAC_PCS_LINK_SPEED_20GB:
> +				link_speed = I40E_LINK_SPEED_20GB;
> +				break;
> +			default:
> +				link_speed = I40E_LINK_SPEED_UNKNOWN;
> +			}
> +		}
> +	}
> +
> +	return link_speed;
> +}
> +
>   /**
>    * i40e_ptp_set_increment - Utility function to update clock increment rate
>    * @pf: Board private structure
> @@ -857,16 +917,14 @@ void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index)
>    **/
>   void i40e_ptp_set_increment(struct i40e_pf *pf)
>   {
> -	struct i40e_link_status *hw_link_info;
> +	enum i40e_aq_link_speed link_speed;
>   	struct i40e_hw *hw = &pf->hw;
>   	u64 incval;
>   	u32 mult;
>   
> -	hw_link_info = &hw->phy.link_info;
> +	link_speed = i40e_ptp_get_link_speed_hw(pf);
>   
> -	i40e_aq_get_link_info(&pf->hw, true, NULL, NULL);
> -
> -	switch (hw_link_info->link_speed) {
> +	switch (link_speed) {

Excuse my ignorance, but could you or the Intel authors explain in the 
commit message, why `hw_link_info->link_speed` is incorrect?

>   	case I40E_LINK_SPEED_10GB:
>   		mult = I40E_PTP_10GB_INCVAL_MULT;
>   		break;
> @@ -909,6 +967,7 @@ void i40e_ptp_set_increment(struct i40e_pf *pf)
>   	/* Update the base adjustement value. */
>   	WRITE_ONCE(pf->ptp_adj_mult, mult);
>   	smp_mb(); /* Force the above update. */
> +	i40e_ptp_set_1pps_signal_hw(pf);

 From the commit message, I would have thought, only this line would be 
needed.

>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
> index 432afbb64201..c4051dbcc297 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_register.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
> @@ -530,6 +530,15 @@
>   #define I40E_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER_SHIFT 0
>   #define I40E_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER_MASK I40E_MASK(0xFFFF, \
>   	I40E_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER_SHIFT)
> +/* _i=0...3 */ /* Reset: GLOBR */
> +#define I40E_PRTMAC_PCS_LINK_STATUS1(_i) (0x0008C200 + ((_i) * 4))
> +#define I40E_PRTMAC_PCS_LINK_STATUS1_LINK_SPEED_SHIFT 24
> +#define I40E_PRTMAC_PCS_LINK_STATUS1_LINK_SPEED_MASK I40E_MASK(0x7, I40E_PRTMAC_PCS_LINK_STATUS1_LINK_SPEED_SHIFT)
> +#define I40E_PRTMAC_PCS_LINK_STATUS2 0x0008C220
> +/* _i=0...3 */ /* Reset: GLOBR */
> +#define I40E_PRTMAC_LINKSTA(_i) (0x001E2420 + ((_i) * 4))
> +#define I40E_PRTMAC_LINKSTA_MAC_LINK_SPEED_SHIFT 27
> +#define I40E_PRTMAC_LINKSTA_MAC_LINK_SPEED_MASK I40E_MASK(0x7, I40E_PRTMAC_LINKSTA_MAC_LINK_SPEED_SHIFT)
>   #define I40E_GLNVM_FLA 0x000B6108 /* Reset: POR */
>   #define I40E_GLNVM_FLA_LOCKED_SHIFT 6
>   #define I40E_GLNVM_FLA_LOCKED_MASK I40E_MASK(0x1, I40E_GLNVM_FLA_LOCKED_SHIFT)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index ed8bbdb586da..98c8c5709e5f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -115,6 +115,14 @@ enum i40e_queue_type {
>   	I40E_QUEUE_TYPE_UNKNOWN
>   };
>   
> +enum i40e_prt_mac_link_speed {
> +	I40E_PRT_MAC_LINK_SPEED_100MB = 0,
> +	I40E_PRT_MAC_LINK_SPEED_1GB,
> +	I40E_PRT_MAC_LINK_SPEED_10GB,
> +	I40E_PRT_MAC_LINK_SPEED_40GB,
> +	I40E_PRT_MAC_LINK_SPEED_20GB
> +};
> +
>   struct i40e_link_status {
>   	enum i40e_aq_phy_type phy_type;
>   	enum i40e_aq_link_speed link_speed;


Kind regards,

Pul

