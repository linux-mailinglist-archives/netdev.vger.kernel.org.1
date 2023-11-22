Return-Path: <netdev+bounces-50179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E1B7F4C90
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F42B20C1F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF2C4F204;
	Wed, 22 Nov 2023 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OLD50Wqk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF5DD44
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i/gP1b1DMD6LlS0hEdJQz2QaqX/WUHHFpY+huteHtCc=; b=OLD50Wqk9C6AiioN/CoHLaFYTo
	i2dYouGX5FMqpSqrOEU8yGky1J5fHJmZkuayIKASpTiwmbNm4oSKAWXlh2UmOtzY/AW6+02XmChvg
	c1zVhFL7pZumxD4M69nn5vfqDKnVcp7U3yHoV9lmfB5mlth4owrGxLW2QizX0sEAUKqo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5qCd-000tGb-Om; Wed, 22 Nov 2023 17:35:51 +0100
Date: Wed, 22 Nov 2023 17:35:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 4/5] net: wangxun: add ethtool_ops for channel
 number
Message-ID: <c909a46f-ce06-4596-b3fc-e56552b00de8@lunn.ch>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com>
 <20231122102226.986265-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122102226.986265-5-jiawenwu@trustnetic.com>

> +int wx_set_channels(struct net_device *dev,
> +		    struct ethtool_channels *ch)
> +{
> +	unsigned int count = ch->combined_count;
> +	struct wx *wx = netdev_priv(dev);
> +
> +	/* verify they are not requesting separate vectors */
> +	if (!count || ch->rx_count || ch->tx_count)
> +		return -EINVAL;

I think EOPNOTSUPP here. Its a but fuzzy when you use EINVAL and when
to use EINVAL. If its a feature you don't support at all, use
EOPNOTSUPP. If its a feature you do support, but the value is out of
range for what the hardware can do, then EINVAL.

So here, the configuration is asking for something you cannot support,
split RX and TX configuration. So EOPNOTSUPP.

> +
> +	/* verify other_count has not changed */
> +	if (ch->other_count != 1)
> +		return -EINVAL;
> +
> +	/* verify the number of channels does not exceed hardware limits */
> +	if (count > wx_max_channels(wx))
> +		return -EINVAL;

Here it is out of range, so EINVAL is correct.

Please think about this for the whole patchset, and the driver in
general.

> +
> +	wx->ring_feature[RING_F_RSS].limit = count;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(wx_set_channels);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
> index 3a80f8e63719..5b5af3689c04 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
> @@ -25,4 +25,8 @@ int wx_set_coalesce(struct net_device *netdev,
>  		    struct ethtool_coalesce *ec,
>  		    struct kernel_ethtool_coalesce *kernel_coal,
>  		    struct netlink_ext_ack *extack);
> +void wx_get_channels(struct net_device *dev,
> +		     struct ethtool_channels *ch);
> +int wx_set_channels(struct net_device *dev,
> +		    struct ethtool_channels *ch);
>  #endif /* _WX_ETHTOOL_H_ */
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 40897419a970..bad56bba26fc 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -1597,6 +1597,71 @@ static void wx_restore_vlan(struct wx *wx)
>  		wx_vlan_rx_add_vid(wx->netdev, htons(ETH_P_8021Q), vid);
>  }
>  
> +static void wx_store_reta(struct wx *wx)
> +{
> +	u8 *indir_tbl = wx->rss_indir_tbl;
> +	u32 reta = 0;
> +	u32 i;
> +
> +	/* Fill out the redirection table as follows:
> +	 *  - 8 bit wide entries containing 4 bit RSS index
> +	 */
> +	for (i = 0; i < 128; i++) {
> +		reta |= indir_tbl[i] << (i & 0x3) * 8;
> +		if ((i & 3) == 3) {
> +			wr32(wx, WX_RDB_RSSTBL(i >> 2), reta);
> +			reta = 0;
> +		}
> +	}
> +}
> +
> +static void wx_setup_reta(struct wx *wx)
> +{
> +	u16 rss_i = wx->ring_feature[RING_F_RSS].indices;
> +	u32 i, j;
> +
> +	/* Fill out hash function seeds */
> +	for (i = 0; i < 10; i++)
> +		wr32(wx, WX_RDB_RSSRK(i), wx->rss_key[i]);
> +
> +	/* Fill out redirection table */
> +	memset(wx->rss_indir_tbl, 0, sizeof(wx->rss_indir_tbl));
> +
> +	for (i = 0, j = 0; i < 128; i++, j++) {
> +		if (j == rss_i)
> +			j = 0;
> +
> +		wx->rss_indir_tbl[i] = j;
> +	}
> +
> +	wx_store_reta(wx);
> +}

There are a lot of magic numbers here, 10, 128 etc. It would be good
to add #define to document what they are.

> +/**
> + * wx_init_rss_key - Initialize wx RSS key
> + * @wx: device handle
> + *
> + * Allocates and initializes the RSS key if it is not allocated.
> + **/
> +static inline int wx_init_rss_key(struct wx *wx)

No inline functions in .c files. Let the compiler decide.

> +{
> +	u32 *rss_key;
> +
> +	if (!wx->rss_key) {
> +		rss_key = kzalloc(WX_RSS_KEY_SIZE, GFP_KERNEL);
> +		if (unlikely(!rss_key))
> +			return -ENOMEM;
> +
> +		netdev_rss_key_fill(rss_key, WX_RSS_KEY_SIZE);
> +		wx->rss_key = rss_key;
> +	}
> +
> +	return 0;
> +}
> +
>  int wx_sw_init(struct wx *wx)
>  {
>  	struct pci_dev *pdev = wx->pdev;
> @@ -1861,6 +1950,11 @@ int wx_sw_init(struct wx *wx)
>  		return -ENOMEM;
>  	}
>  
> +	if (wx_init_rss_key(wx)) {
> +		wx_err(wx, "rss key allocation failed\n");
> +		return -ENOMEM;

Return the error code wx_init_rss_key() returns.

       Andrew

