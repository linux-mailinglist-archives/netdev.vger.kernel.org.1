Return-Path: <netdev+bounces-230989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE2BF3138
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 21:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF7E18C0AFC
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED57082D;
	Mon, 20 Oct 2025 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pyPwF5xQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81772D47F1
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986823; cv=none; b=RhmUPKYMxvUG4Vxj6t4gjWObPIt02jvH5Me4m0K48tBCv2uN+61MgVhEoCkaPQwywBEyxdLuFdHr2A1l9BfCrvNQTa1x65MxOws/lbbZeT/jXT/oDQony2RhACsisvZqd1IxU6qo9QGUcLSQ5z8EdiWbH8eI0Vhja6t0CGXwpDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986823; c=relaxed/simple;
	bh=nxey75cxcFQL5QPssvYFUL1mnIGgCIh2iEByP7qNNbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EX1qRLgWBkS+lO2uga/ZyUnxYbvXmwnAZSbE0VEdOcyUoWExME8VETAWKx+DQEoK6X1aF3SpIKSoBXXq8KewL1zkDXwjP7Z9d8Ogwp/xPKO8tOL5yzW8ZmK2N6b345P3CQjvE2gsgScDJk8R6i/asigEpImNhyNQY0dRCKv01x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pyPwF5xQ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c4b64428-4ec0-4575-94d1-32e30b1fe5e8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760986811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB31FHdEq1usalJwEmIg6M9c0oANx01yNT1XnL0gbtw=;
	b=pyPwF5xQchqvBYUjSqfXDa4e3j4UoCDCuTxscn9SQa149yBIhBnMZbz1xbHFk9saOIuX/t
	cJzMD4LkzfqYqq1AjOLQIfIRva3EQGeAc+96GLGYpongFRCUnZOguvRhN5KJ3hwHrxtEIx
	8MCIMitS5uMzEsPSIco3992XIAm6ByA=
Date: Mon, 20 Oct 2025 20:00:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 6/7] tsnep: convert to ndo_hwtstatmp API
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
 <20251016152515.3510991-7-vadim.fedorenko@linux.dev>
 <375eed92-0f76-4df1-9837-2c29208417fa@engleder-embedded.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <375eed92-0f76-4df1-9837-2c29208417fa@engleder-embedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 20/10/2025 18:51, Gerhard Engleder wrote:
> On 16.10.25 17:25, Vadim Fedorenko wrote:
>> Convert to .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
>> After conversions the rest of tsnep_netdev_ioctl() becomes pure
>> phy_do_ioctl_running(), so remove tsnep_netdev_ioctl() and replace
>> it with phy_do_ioctl_running() in .ndo_eth_ioctl.
>>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   drivers/net/ethernet/engleder/tsnep.h      |  8 +-
>>   drivers/net/ethernet/engleder/tsnep_main.c | 14 +---
>>   drivers/net/ethernet/engleder/tsnep_ptp.c  | 88 +++++++++++-----------
>>   3 files changed, 51 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/engleder/tsnep.h b/drivers/net/ 
>> ethernet/engleder/tsnep.h
>> index f188fba021a6..03e19aea9ea4 100644
>> --- a/drivers/net/ethernet/engleder/tsnep.h
>> +++ b/drivers/net/ethernet/engleder/tsnep.h
>> @@ -176,7 +176,7 @@ struct tsnep_adapter {
>>       struct tsnep_gcl gcl[2];
>>       int next_gcl;
>> -    struct hwtstamp_config hwtstamp_config;
>> +    struct kernel_hwtstamp_config hwtstamp_config;
>>       struct ptp_clock *ptp_clock;
>>       struct ptp_clock_info ptp_clock_info;
>>       /* ptp clock lock */
>> @@ -203,7 +203,11 @@ extern const struct ethtool_ops tsnep_ethtool_ops;
>>   int tsnep_ptp_init(struct tsnep_adapter *adapter);
>>   void tsnep_ptp_cleanup(struct tsnep_adapter *adapter);
>> -int tsnep_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int 
>> cmd);
>> +int tsnep_ptp_hwtstamp_get(struct net_device *netdev,
>> +               struct kernel_hwtstamp_config *config);
>> +int tsnep_ptp_hwtstamp_set(struct net_device *netdev,
>> +               struct kernel_hwtstamp_config *config,
>> +               struct netlink_ext_ack *extack);
>>   int tsnep_tc_init(struct tsnep_adapter *adapter);
>>   void tsnep_tc_cleanup(struct tsnep_adapter *adapter);
>> diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ 
>> ethernet/engleder/tsnep_main.c
>> index eba73246f986..b118407c30e8 100644
>> --- a/drivers/net/ethernet/engleder/tsnep_main.c
>> +++ b/drivers/net/ethernet/engleder/tsnep_main.c
>> @@ -2168,16 +2168,6 @@ static netdev_tx_t 
>> tsnep_netdev_xmit_frame(struct sk_buff *skb,
>>       return tsnep_xmit_frame_ring(skb, &adapter->tx[queue_mapping]);
>>   }
>> -static int tsnep_netdev_ioctl(struct net_device *netdev, struct ifreq 
>> *ifr,
>> -                  int cmd)
>> -{
>> -    if (!netif_running(netdev))
>> -        return -EINVAL;
>> -    if (cmd == SIOCSHWTSTAMP || cmd == SIOCGHWTSTAMP)
>> -        return tsnep_ptp_ioctl(netdev, ifr, cmd);
>> -    return phy_mii_ioctl(netdev->phydev, ifr, cmd);
>> -}
>> -
>>   static void tsnep_netdev_set_multicast(struct net_device *netdev)
>>   {
>>       struct tsnep_adapter *adapter = netdev_priv(netdev);
>> @@ -2384,7 +2374,7 @@ static const struct net_device_ops 
>> tsnep_netdev_ops = {
>>       .ndo_open = tsnep_netdev_open,
>>       .ndo_stop = tsnep_netdev_close,
>>       .ndo_start_xmit = tsnep_netdev_xmit_frame,
>> -    .ndo_eth_ioctl = tsnep_netdev_ioctl,
>> +    .ndo_eth_ioctl = phy_do_ioctl_running,
>>       .ndo_set_rx_mode = tsnep_netdev_set_multicast,
>>       .ndo_get_stats64 = tsnep_netdev_get_stats64,
>>       .ndo_set_mac_address = tsnep_netdev_set_mac_address,
>> @@ -2394,6 +2384,8 @@ static const struct net_device_ops 
>> tsnep_netdev_ops = {
>>       .ndo_bpf = tsnep_netdev_bpf,
>>       .ndo_xdp_xmit = tsnep_netdev_xdp_xmit,
>>       .ndo_xsk_wakeup = tsnep_netdev_xsk_wakeup,
>> +    .ndo_hwtstamp_get = tsnep_ptp_hwtstamp_get,
>> +    .ndo_hwtstamp_set = tsnep_ptp_hwtstamp_set,
>>   };
>>   static int tsnep_mac_init(struct tsnep_adapter *adapter)
>> diff --git a/drivers/net/ethernet/engleder/tsnep_ptp.c b/drivers/net/ 
>> ethernet/engleder/tsnep_ptp.c
>> index 54fbf0126815..ae1308eb813d 100644
>> --- a/drivers/net/ethernet/engleder/tsnep_ptp.c
>> +++ b/drivers/net/ethernet/engleder/tsnep_ptp.c
>> @@ -19,57 +19,53 @@ void tsnep_get_system_time(struct tsnep_adapter 
>> *adapter, u64 *time)
>>       *time = (((u64)high) << 32) | ((u64)low);
>>   }
>> -int tsnep_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int 
>> cmd)
>> +int tsnep_ptp_hwtstamp_get(struct net_device *netdev,
>> +               struct kernel_hwtstamp_config *config)
>>   {
>>       struct tsnep_adapter *adapter = netdev_priv(netdev);
>> -    struct hwtstamp_config config;
>> -
>> -    if (!ifr)
>> -        return -EINVAL;
>> -
>> -    if (cmd == SIOCSHWTSTAMP) {
>> -        if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
>> -            return -EFAULT;
>> -
>> -        switch (config.tx_type) {
>> -        case HWTSTAMP_TX_OFF:
>> -        case HWTSTAMP_TX_ON:
>> -            break;
>> -        default:
>> -            return -ERANGE;
>> -        }
>> -
>> -        switch (config.rx_filter) {
>> -        case HWTSTAMP_FILTER_NONE:
>> -            break;
>> -        case HWTSTAMP_FILTER_ALL:
>> -        case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>> -        case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>> -        case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>> -        case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>> -        case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>> -        case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>> -        case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
>> -        case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
>> -        case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
>> -        case HWTSTAMP_FILTER_PTP_V2_EVENT:
>> -        case HWTSTAMP_FILTER_PTP_V2_SYNC:
>> -        case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>> -        case HWTSTAMP_FILTER_NTP_ALL:
>> -            config.rx_filter = HWTSTAMP_FILTER_ALL;
>> -            break;
>> -        default:
>> -            return -ERANGE;
>> -        }
>> -
>> -        memcpy(&adapter->hwtstamp_config, &config,
>> -               sizeof(adapter->hwtstamp_config));
>> +
>> +    *config = adapter->hwtstamp_config;
>> +    return 0;
>> +}
>> +
>> +int tsnep_ptp_hwtstamp_set(struct net_device *netdev,
>> +               struct kernel_hwtstamp_config *config,
>> +               struct netlink_ext_ack *extack)
>> +{
>> +    struct tsnep_adapter *adapter = netdev_priv(netdev);
>> +
>> +    switch (config->tx_type) {
>> +    case HWTSTAMP_TX_OFF:
>> +    case HWTSTAMP_TX_ON:
>> +        break;
>> +    default:
>> +        return -ERANGE;
>>       }
>> -    if (copy_to_user(ifr->ifr_data, &adapter->hwtstamp_config,
>> -             sizeof(adapter->hwtstamp_config)))
>> -        return -EFAULT;
>> +    switch (config->rx_filter) {
>> +    case HWTSTAMP_FILTER_NONE:
>> +        break;
>> +    case HWTSTAMP_FILTER_ALL:
>> +    case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>> +    case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>> +    case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>> +    case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>> +    case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>> +    case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>> +    case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
>> +    case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
>> +    case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
>> +    case HWTSTAMP_FILTER_PTP_V2_EVENT:
>> +    case HWTSTAMP_FILTER_PTP_V2_SYNC:
>> +    case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>> +    case HWTSTAMP_FILTER_NTP_ALL:
>> +        config->rx_filter = HWTSTAMP_FILTER_ALL;
>> +        break;
>> +    default:
>> +        return -ERANGE;
>> +    }
>> +    adapter->hwtstamp_config = *config;
>>       return 0;
>>   }
> 
> As you were first, I skip my patch.

Thanks Gerhard! >
> Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>


