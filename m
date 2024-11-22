Return-Path: <netdev+bounces-146874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ACB9D6633
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 00:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FFA16141C
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53304189B86;
	Fri, 22 Nov 2024 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fw5+t5nd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338C176ADB;
	Fri, 22 Nov 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732316699; cv=none; b=j5QxKFJg8VzfX+1WFG40hupXj8u7pBa4fYy2DBFAl7hPRlYPiL7s+dR+f6iH0tl2AQhHDf/LxTTiw729wcWi4cAi2hgsfCZtfy+vxdjaeuDeCOol5X01cPmncQNnYfh+mChfvMRK+T8mhXT8WMQ8BwJlI0Ui0XxgI1C8DNCpr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732316699; c=relaxed/simple;
	bh=4wIWfXpF5G8HG9/Pq+zqdSb7DFqwGwuXPQRVw4+p5FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXfB1BPStLiTEhAi0BO/WFzPm6kxcwNp3OEkPjqhV1boe3ArUHPF7UAPRoXgTDc1/CxpN/5kzbOiSW5lx+ax8uqj2WYFGpjeNcyBxelAyDxj94vFYR5DseN4jL6MGiwS+dWU3dE3RifyHSJ93/h5ulNHXnaIs8ug//LIFZmylSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fw5+t5nd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IEf/4Dtt1gordcffcgfDzPQ5Kwj0hKh+nasI0mtcRXU=; b=fw5+t5ndLTUbfV+GOCK33u7kKP
	0NIDL66Qye4jbiAL54256OFAhoWjOExVCRm58kK4jLY8By4WNhj6nNsamBy4UmE7RdKO1znD3qZLH
	z0Rl9T3KzFWdEPfNu5wpSx1F4vIX0/13CaW5W01HO6hD4izaNYr8C/iS95nicBIBcdkk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tEchk-00EAsH-3b; Sat, 23 Nov 2024 00:04:48 +0100
Date: Sat, 23 Nov 2024 00:04:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v2 14/21] motorcomm:yt6801: Implement the WOL
 function of ethtool_ops
Message-ID: <55cac132-578f-4f07-95b0-d4ddb06b6b7f@lunn.ch>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-15-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120105625.22508-15-Frank.Sae@motor-comm.com>

On Wed, Nov 20, 2024 at 06:56:18PM +0800, Frank Sae wrote:
> Implement the .get_wol and .set_wol callback function.
> 
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> ---
>  .../motorcomm/yt6801/yt6801_ethtool.c         | 169 +++++
>  .../net/ethernet/motorcomm/yt6801/yt6801_hw.c | 576 ++++++++++++++++++
>  .../ethernet/motorcomm/yt6801/yt6801_net.c    | 118 ++++
>  3 files changed, 863 insertions(+)
> 
> diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c
> index 7989ccbc3..af643a16a 100644
> --- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c
> +++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c
> @@ -565,6 +565,173 @@ static int fxgmac_set_ringparam(struct net_device *netdev,
>  	return ret;
>  }
>  
> +static void fxgmac_get_wol(struct net_device *netdev,
> +			   struct ethtool_wolinfo *wol)
> +{
> +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> +
> +	wol->supported = WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_MAGIC |
> +			 WAKE_ARP | WAKE_PHY;

You are not asking the PHY what it can do. Ideally you want the PHY to
do WoL so you can power off the MAC. You should only use MAC WoL when
asked to do something the PHY does not support.

> +	wol->wolopts = 0;
> +	if (!(pdata->hw_feat.rwk) || !device_can_wakeup(pdata->dev)) {
> +		yt_err(pdata, "%s, pci does not support wakeup.\n", __func__);
> +		return;
> +	}
> +
> +	wol->wolopts = pdata->wol;
> +}
> +
> +#pragma pack(1)
> +/* it's better to make this struct's size to 128byte. */
> +struct pattern_packet {
> +	u8 ether_daddr[ETH_ALEN];
> +	u8 ether_saddr[ETH_ALEN];
> +	u16 ether_type;
> +
> +	__be16 ar_hrd;		/* format of hardware address  */
> +	__be16 ar_pro;		/* format of protocol          */
> +	u8 ar_hln;		/* length of hardware address  */
> +	u8 ar_pln;		/* length of protocol address  */
> +	__be16 ar_op;		/* ARP opcode (command)        */
> +	u8 ar_sha[ETH_ALEN];	/* sender hardware address     */
> +	u8 ar_sip[4];		/* sender IP address           */
> +	u8 ar_tha[ETH_ALEN];	/* target hardware address     */
> +	u8 ar_tip[4];		/* target IP address           */
> +
> +	u8 reverse[86];
> +};
> +
> +#pragma pack()
> +
> +static int fxgmac_set_pattern_data(struct fxgmac_pdata *pdata)
> +{
> +	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
> +	u8 type_offset, tip_offset, op_offset;
> +	struct wol_bitmap_pattern pattern[4];
> +	struct pattern_packet packet;
> +	u32 ip_addr, i = 0;
> +
> +	memset(pattern, 0, sizeof(struct wol_bitmap_pattern) * 4);

This is somewhat error prone. It is better to use

       memset(pattern, 0, sizeof(pattern));

> +
> +	/* Config ucast */
> +	if (pdata->wol & WAKE_UCAST) {
> +		pattern[i].mask_info[0] = 0x3F;

What does 0x3F mean? Can you replace the magic number with a #define
which explains it?

> +		pattern[i].mask_size = sizeof(pattern[0].mask_info);
> +		memcpy(pattern[i].pattern_info, pdata->mac_addr, ETH_ALEN);
> +		pattern[i].pattern_offset = 0;
> +		i++;
> +	}
> +
> +	/* Config bcast */
> +	if (pdata->wol & WAKE_BCAST) {
> +		pattern[i].mask_info[0] = 0x3F;
> +		pattern[i].mask_size = sizeof(pattern[0].mask_info);
> +		memset(pattern[i].pattern_info, 0xFF, ETH_ALEN);
> +		pattern[i].pattern_offset = 0;
> +		i++;
> +	}
> +
> +	/* Config mcast */
> +	if (pdata->wol & WAKE_MCAST) {
> +		pattern[i].mask_info[0] = 0x7;
> +		pattern[i].mask_size = sizeof(pattern[0].mask_info);
> +		pattern[i].pattern_info[0] = 0x1;
> +		pattern[i].pattern_info[1] = 0x0;
> +		pattern[i].pattern_info[2] = 0x5E;

I don't think that is the correct definition of multicast.

https://elixir.bootlin.com/linux/v6.12/source/include/linux/etherdevice.h#L122

You are just interested in one bit to indicate it is an Ethernet
multicast frame.

> +	/* Config arp */
> +	if (pdata->wol & WAKE_ARP) {
> +		memset(pattern[i].mask_info, 0, sizeof(pattern[0].mask_info));
> +		type_offset = offsetof(struct pattern_packet, ar_pro);
> +		pattern[i].mask_info[type_offset / 8] |= 1 << type_offset % 8;
> +		type_offset++;
> +		pattern[i].mask_info[type_offset / 8] |= 1 << type_offset % 8;
> +		op_offset = offsetof(struct pattern_packet, ar_op);
> +		pattern[i].mask_info[op_offset / 8] |= 1 << op_offset % 8;
> +		op_offset++;
> +		pattern[i].mask_info[op_offset / 8] |= 1 << op_offset % 8;
> +		tip_offset = offsetof(struct pattern_packet, ar_tip);
> +		pattern[i].mask_info[tip_offset / 8] |= 1 << tip_offset % 8;
> +		tip_offset++;
> +		pattern[i].mask_info[tip_offset / 8] |= 1 << type_offset % 8;
> +		tip_offset++;
> +		pattern[i].mask_info[tip_offset / 8] |= 1 << type_offset % 8;
> +		tip_offset++;
> +		pattern[i].mask_info[tip_offset / 8] |= 1 << type_offset % 8;
> +
> +		packet.ar_pro = 0x0 << 8 | 0x08;
> +		/* ARP type is 0x0800, notice that ar_pro and ar_op is
> +		 * big endian
> +		 */
> +		packet.ar_op = 0x1 << 8;
> +		/* 1 is arp request,2 is arp replay, 3 is rarp request,
> +		 * 4 is rarp replay
> +		 */
> +		ip_addr = fxgmac_get_netdev_ip4addr(pdata);

What happens when there is no IPv4 address on the interface? You
probably want to return -EINVAL.

> +static int fxgmac_set_wol(struct net_device *netdev,
> +			  struct ethtool_wolinfo *wol)
> +{
> +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> +	int ret;
> +
> +	if (wol->wolopts & (WAKE_MAGICSECURE | WAKE_FILTER)) {
> +		yt_err(pdata, "%s, not supported wol options, 0x%x\n", __func__,
> +		       wol->wolopts);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!(pdata->hw_feat.rwk)) {
> +		yt_err(pdata, "%s, hw wol feature is n/a\n", __func__);
> +		return wol->wolopts ? -EOPNOTSUPP : 0;
> +	}

You should be reporting that in get_wol().

> +	pdata->wol = 0;
> +	if (wol->wolopts & WAKE_UCAST)
> +		pdata->wol |= WAKE_UCAST;
> +
> +	if (wol->wolopts & WAKE_MCAST)
> +		pdata->wol |= WAKE_MCAST;

It is not 100% clear, but i think set_wol should be additive. You can
use ethtool to keep adding more WoL options. The clear them you use
wol d.

	Andrew

