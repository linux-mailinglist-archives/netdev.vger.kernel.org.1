Return-Path: <netdev+bounces-88262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E088A6821
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1E61C20C5D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69E86244;
	Tue, 16 Apr 2024 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="EXsvXe8g"
X-Original-To: netdev@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C528625F
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262678; cv=none; b=q8KWLrV0uiQGDA6xfCEkl9ENQ807sUM0zv/JLcdhal1Nz1VtTRmLk6KBAAnJJvIJ/w03ElyA/8IlxbU29sH+PJoAe/9pjtL4LLzwseHi1uhtMtxleYqm24hC7Vh67wic7Mq9SVDAX3gGV8SjmFfnWr6/5kMWatauUzTNIYCCE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262678; c=relaxed/simple;
	bh=wu1KSA2K4rdd1FtRls5EIsNqX6kxbwc3xPND5lURLvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN+2dDifjIcVgBqKuVz2oHpccnwEKqx01uT16+/pE/CrulO0IE5K9YQeKXC2lDxxpl2QWt+O8m3n90pTDhwS7Js2F2Am2Q0UYHzG+PocezsvLBfdjpAWivHhEZs290FSbIosKgIzYwfPj87QiwvQJTmZZWENipNEgB/16krzk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=EXsvXe8g; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 43GAHbcB1412114;
	Tue, 16 Apr 2024 12:17:37 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 43GAHbcB1412114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1713262657;
	bh=0wWscTeJnAiLv0ojrU4Pb3w6bnT8+YSHf2M1mHIGvZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXsvXe8gykLToX4FXUiONUOU/KN4966Ug2SDcIwRShmXrEHUckQvd3fdqRwRbEN+J
	 qXvcqrJ75pBNXVhGcXBZrGH3T/5cK/qlWJv88Kcam0nnf9Dj4vAOaUP4ywjuRmIyg4
	 yZ/gKdR0oqHCpUrBJIOIbFTIkqwj4EBwM0cUGa70=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 43GAHba41412113;
	Tue, 16 Apr 2024 12:17:37 +0200
Date: Tue, 16 Apr 2024 12:17:37 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
        netdev@vger.kernel.org, mengyuanlou@net-swift.com,
        duanqiangwen@net-swift.com
Subject: Re: [PATCH net 2/5] net: wangxun: fix error statistics when the
 device is reset
Message-ID: <20240416101737.GB1411807@electric-eye.fr.zoreil.com>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com>
 <20240416062952.14196-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416062952.14196-3-jiawenwu@trustnetic.com>
X-Organisation: Land of Sunshine Inc.

Jiawen Wu <jiawenwu@trustnetic.com> :
> Add flag for reset state to avoid reading statistics when hardware
> is reset.
> 
> Fixes: 883b5984a5d2 ("net: wangxun: add ethtool_ops for ring parameters")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  3 +++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  6 +++++
>  .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 24 +++++++++++++++----
>  .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 24 +++++++++++++++----
>  4 files changed, 47 insertions(+), 10 deletions(-)
> 
[...]
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> index 786a652ae64f..0e85c5a6633e 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> @@ -52,7 +52,8 @@ static int ngbe_set_ringparam(struct net_device *netdev,
>  	struct wx *wx = netdev_priv(netdev);
>  	u32 new_rx_count, new_tx_count;
>  	struct wx_ring *temp_ring;
> -	int i;
> +	u8 timeout = 50;
> +	int i, err = 0;
>  
>  	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
>  	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
> @@ -64,6 +65,15 @@ static int ngbe_set_ringparam(struct net_device *netdev,
>  	    new_rx_count == wx->rx_ring_count)
>  		return 0;
>  
> +	while (test_and_set_bit(WX_STATE_RESETTING, wx->state)) {
> +		timeout--;
> +		if (!timeout) {
> +			err = -EBUSY;
> +			goto clear_reset;
> +		}
> +		usleep_range(1000, 2000);
> +	}
> +

This code appears twice. It may be factored out.

[...]
> @@ -89,7 +101,9 @@ static int ngbe_set_ringparam(struct net_device *netdev,
>  	wx_configure(wx);
>  	ngbe_up(wx);
>  
> -	return 0;
> +clear_reset:
> +	clear_bit(WX_STATE_RESETTING, wx->state);
> +	return err;
>  }

This function always clears the bit but it does not necessarily owns it.

-- 
Ueimor

