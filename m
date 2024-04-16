Return-Path: <netdev+bounces-88260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC068A681B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1275F1F21BE8
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90ED1272BA;
	Tue, 16 Apr 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="l8agxUzF"
X-Original-To: netdev@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64A84D26
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262643; cv=none; b=h3+RwxZb9yuc3XJ59tsTsqX5SlBSUsSOX7i6M/1zH1notgYCEJUAELYWrB76lmO52H9eIzBtJ/f43w4PxaXFuAc7pft4Q8+1wYDnzIyyJMrNnuAF5vYantD+ChxWlvS2iCHSpUn9LQQuDNP2mSiQ/FTZoj/GelCexXVnvFFHT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262643; c=relaxed/simple;
	bh=W7GVUp0G/7+jdOV+VHK8P1nhO7co9D+XupPn7jMRhio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1ALALYeSv0tWTtgBRnxe5cs7iFAA8ne9BoaONH/29IWFdVht1tetNJJe35xKGcNv7muJqXd26XoCGaltGXUc33NkC8lvakw8K6poJV76cAqXzEQAqFs0r7Shy09YnfIwUL4fFk2bAShDGULZ8f15fWHhiMTy9kKkQgcSw1eGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=l8agxUzF; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 43GAGYmT1412059;
	Tue, 16 Apr 2024 12:16:34 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 43GAGYmT1412059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1713262594;
	bh=bOV6LcuIsmg87c6Hk1kz6NBvEbPHizqpogaLhLHMw0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8agxUzFDt386j00a5v/7Aqqty0+z7dDHSh+w2zo0tYLLkkNZZ0AnnsVulXlyno84
	 ff25mSq1+9xL97Kfcy7nfLLASJ8XrwUw/rvmVvNl7NnJBi19datocnte2FD4nEQm8x
	 xUn+VkeStiBzwP27KIz8KpyRk+WyXha0YiCwXSPA=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 43GAGWfL1412048;
	Tue, 16 Apr 2024 12:16:32 +0200
Date: Tue, 16 Apr 2024 12:16:31 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
        netdev@vger.kernel.org, mengyuanlou@net-swift.com,
        duanqiangwen@net-swift.com
Subject: Re: [PATCH net 1/5] net: wangxun: fix the incorrect display of queue
 number in statistics
Message-ID: <20240416101631.GA1411807@electric-eye.fr.zoreil.com>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com>
 <20240416062952.14196-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416062952.14196-2-jiawenwu@trustnetic.com>
X-Organisation: Land of Sunshine Inc.

Jiawen Wu <jiawenwu@trustnetic.com> :
> When using ethtool -S to print hardware statistics, the number of
> Rx/Tx queues printed is greater than the number of queues actually
> used.
> 
> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index cc3bec42ed8e..3847c909ba1a 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -59,9 +59,17 @@ static const struct wx_stats wx_gstrings_stats[] = {
>  
>  int wx_get_sset_count(struct net_device *netdev, int sset)
>  {
> +	struct wx *wx = netdev_priv(netdev);
> +
>  	switch (sset) {
>  	case ETH_SS_STATS:
> -		return WX_STATS_LEN;
> +		if (wx->num_tx_queues <= WX_NUM_RX_QUEUES) {
> +			return WX_STATS_LEN -
> +			       (WX_NUM_RX_QUEUES - wx->num_tx_queues) *
> +			       (sizeof(struct wx_queue_stats) / sizeof(u64)) * 2;
> +		} else {
> +			return WX_STATS_LEN;
> +		}

The same code appears in wx_get_drvinfo.

1) It may be factored out.
2) The size of stats depends on num_{rx, tx}_queues. Unless there is some
   reason to keep WX_STATS_LEN, you may remove it, avoid the conditional code
   and always perform the required arithmetic.

By the way, I understand that driver allocates num_tx_queues and num_rx_queues
symmetrically as outlined in the comment at the start of wx_ethtool.c.
However, it's a bit unexpected to see this dependency elsewhere.

-- 
Ueimor

