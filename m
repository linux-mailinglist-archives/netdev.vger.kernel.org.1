Return-Path: <netdev+bounces-217892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DE5B3A4EC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28F33AD59D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D226B24DD11;
	Thu, 28 Aug 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWfsXaE1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1E1990C7
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396208; cv=none; b=cIPGzG30zwfYiKtq+Qr1yAGXiMgOBH1G9QI+BEVj0ZTcXUmbms8uYCauKxdHFFGnf4IFP0uA8fIQEVc6lMNWJmWgY9LjJEPFUeO+Pr05ejdKDOg/iGIIgOl5m6hRNwIn53ZYTSciZKBuLxiZj0ZH96Kjz37naw3C234B6zUL8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396208; c=relaxed/simple;
	bh=5H+Ss4hWPtWoXFpX5lZRNVUrGQ4kxB3ezww1LNkCXII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs1xqgUzGcAvuT5OX9yk3ZUvQnJdh9t6hm7LcsHTshRe4w5rkChqz24M5hScxbzykX3myKkut/aje5cjuFnaX9rXO9OKkQd/5ttRhYpg1KaTByJ0w2zg64Npbe9DQf1zA0j4s/4DzWDwLzX8DDA1Vh6BprEZB41iFiTPL/ULz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWfsXaE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8028C4CEEB;
	Thu, 28 Aug 2025 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756396208;
	bh=5H+Ss4hWPtWoXFpX5lZRNVUrGQ4kxB3ezww1LNkCXII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UWfsXaE1D8CRtwqFOGElBYwjmwd2Lkw1pBAsz9FBRG59GsrNM8AW+jck+og2zUoG0
	 4wbdectGtS8r7+taHGwxIGKsgywEe2hO3Eki2u9X/7ZjOnBikBil6EIGqRg1fmPaTo
	 uTB8JZ0CqZdEYrnPb5+aH6hm9iwiUPRzJtQnUmEPq9gXjXg515pKMXjEYlVebiahrT
	 YJITqXM5IsKtZPXeVrYC1XgM/4z4IiKDFebeqkQszxkjTSebEKBAKlp5qsW26psFYh
	 O/SHmeGIRQHimCm8WKmlQU3R3wC44p/V2kuet9CBWAlNdP/HcdY6jiFc+EdspGPOJp
	 V0H5w+X/Hmutw==
Date: Thu, 28 Aug 2025 16:50:04 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next 1/2] net: libwx: support multiple RSS for every
 pool
Message-ID: <20250828155004.GA31759@horms.kernel.org>
References: <20250827064634.18436-1-jiawenwu@trustnetic.com>
 <20250827064634.18436-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827064634.18436-2-jiawenwu@trustnetic.com>

On Wed, Aug 27, 2025 at 02:46:33PM +0800, Jiawen Wu wrote:
> For those devices which support 64 pools, they also support PF and VF
> (i.e. different pools) to configure different RSS key. Enable multiple
> RSS, use up to 64 RSS keys and that is one key per pool.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c

...

> @@ -2046,6 +2074,50 @@ static void wx_setup_reta(struct wx *wx)
>  	wx_store_reta(wx);
>  }
>  
> +void wx_config_rss_field(struct wx *wx)
> +{
> +	u32 rss_field;
> +
> +	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
> +	    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
> +		rss_field = rd32(wx, WX_RDB_PL_CFG(wx->num_vfs));
> +		rss_field &= ~WX_RDB_PL_CFG_RSS_MASK;
> +		rss_field |= wx->rss_flags << WX_RSS_FIELD_SHIFT;

Hi Jiawen,

I expect you can use something like the following here,
and drop WX_RX_FIELD_SHIFT entirely.

		rss_field |= FIELD_PREP(WX_RDB_PL_CFG_RSS_MASK, wx->rss_flags);

> +		wr32(wx, WX_RDB_PL_CFG(wx->num_vfs), rss_field);
> +
> +		/* Enable global RSS and multiple RSS to make the RSS
> +		 * field of each pool take effect.
> +		 */
> +		wr32m(wx, WX_RDB_RA_CTL,
> +		      WX_RDB_RA_CTL_MULTI_RSS | WX_RDB_RA_CTL_RSS_EN,
> +		      WX_RDB_RA_CTL_MULTI_RSS | WX_RDB_RA_CTL_RSS_EN);
> +	} else {
> +		rss_field = rd32(wx, WX_RDB_RA_CTL);
> +		rss_field &= ~WX_RDB_RA_CTL_RSS_MASK;
> +		rss_field |= wx->rss_flags << WX_RSS_FIELD_SHIFT;
> +		wr32(wx, WX_RDB_RA_CTL, rss_field);
> +	}
> +}

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index ec63e7ec8b24..9fd0f3a5a48c 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -168,9 +168,12 @@
>  #define WX_RDB_PL_CFG_L2HDR          BIT(3)
>  #define WX_RDB_PL_CFG_TUN_TUNHDR     BIT(4)
>  #define WX_RDB_PL_CFG_TUN_OUTL2HDR   BIT(5)
> +#define WX_RDB_PL_CFG_RSS_EN         BIT(24)
> +#define WX_RDB_PL_CFG_RSS_MASK       GENMASK(23, 16)
>  #define WX_RDB_RSSTBL(_i)            (0x19400 + ((_i) * 4))
>  #define WX_RDB_RSSRK(_i)             (0x19480 + ((_i) * 4))
>  #define WX_RDB_RA_CTL                0x194F4
> +#define WX_RDB_RA_CTL_MULTI_RSS      BIT(0)
>  #define WX_RDB_RA_CTL_RSS_EN         BIT(2) /* RSS Enable */
>  #define WX_RDB_RA_CTL_RSS_IPV4_TCP   BIT(16)
>  #define WX_RDB_RA_CTL_RSS_IPV4       BIT(17)

...

> @@ -1192,6 +1199,16 @@ struct vf_macvlans {
>  	u8 vf_macvlan[ETH_ALEN];
>  };
>  
> +#define WX_RSS_FIELD_SHIFT         16
> +#define WX_RSS_FIELD_IPV4_TCP      BIT(0)
> +#define WX_RSS_FIELD_IPV4          BIT(1)
> +#define WX_RSS_FIELD_IPV4_SCTP     BIT(2)
> +#define WX_RSS_FIELD_IPV6_SCTP     BIT(3)
> +#define WX_RSS_FIELD_IPV6_TCP      BIT(4)
> +#define WX_RSS_FIELD_IPV6          BIT(5)
> +#define WX_RSS_FIELD_IPV4_UDP      BIT(6)
> +#define WX_RSS_FIELD_IPV6_UDP      BIT(7)
> +
>  enum wx_pf_flags {
>  	WX_FLAG_MULTI_64_FUNC,
>  	WX_FLAG_SWFW_RING,

...

