Return-Path: <netdev+bounces-167347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB91A39DED
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1FA3AB2DA
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B722E401;
	Tue, 18 Feb 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/t9SFRL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0F42C0B;
	Tue, 18 Feb 2025 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886140; cv=none; b=RO7KUZHdqunIgbikKy56VTCj7nnCfuiZjkfg4J0JxzzOvhw/lBvSrrzGkzl4P79UWI0eNhLgd8w58Lp2S98uSKnDXMeBJur8KkltXfr5uDqd7VIwhZ3Odivbylk3J26zqBMpD4ChHItxPaSLD8WJWmeq7ZS4+m1ckqZRtY17UFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886140; c=relaxed/simple;
	bh=k4T1GostSpWpNOeyQDf1D/GlZj2EggYI+1EHv7/NqQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrBM2xfqWo1UzCFb0xBNkMpaydpVlMK6tT6qvvYZ/Teb1H4t9NqqIwLwd7JerLebaQfa8sFut9zDYKaVoM1XHobMy95EFliKnP9t9ig3e3QW0R57ncvNi3CbsHFfsjqxFYj8fNfigQLh1iQAmJzcs5vOHZFk63iFfPflgL43nlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/t9SFRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1770CC4CEE6;
	Tue, 18 Feb 2025 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739886139;
	bh=k4T1GostSpWpNOeyQDf1D/GlZj2EggYI+1EHv7/NqQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/t9SFRLC8M7j3j/bYYdHQ09ywLzqBQVHYhNMruXaeuIUaf9YWt80mryRcoBLD9k5
	 5KC/bi3Er24tWOczD6Yx8l9ZEJS376fh4n9AvHEgN6ZZmhxOc9plNG25heg/zA+iJG
	 ptxdRPOSsI83LEEcr2WMXEsu1jqShsYn8iPK5zfNSmgM2tcEsH/dVpgQrHX8xNj9K7
	 6Sv6GxVwtWyyLgmQwEhIc7UYZ0d9+qZfOJIvnuO4rRjuvtAUVAYNmYu04AorXVRtZI
	 BwZoHU5Dyeake2iX5vlqQbv4JjscF1A7eyiSIKtjgCCttkN9eVhALgKq45Ox8Du3Az
	 RUc4+f7z+CNhg==
Date: Tue, 18 Feb 2025 13:42:14 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/7] net: hibmcge: Add rx checksum offload
 supported in this module
Message-ID: <20250218134214.GY1615191@kernel.org>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-4-shaojijie@huawei.com>
 <20250217154028.GM1615191@kernel.org>
 <14b562d6-7006-4fe0-be61-48fe1abebe49@huawei.com>
 <CAH-L+nM0axD3QWXixe6p7U4dyVx=qn9zh5crOXLTxTH9Gpd9dQ@mail.gmail.com>
 <9d55d0a8-7a85-4caf-8358-7e04621813cc@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d55d0a8-7a85-4caf-8358-7e04621813cc@huawei.com>

On Tue, Feb 18, 2025 at 04:27:28PM +0800, Jijie Shao wrote:
> 
> on 2025/2/18 10:46, Kalesh Anakkur Purayil wrote:
> > On Tue, Feb 18, 2025 at 7:47 AM Jijie Shao <shaojijie@huawei.com> wrote:
> > > 
> > > on 2025/2/17 23:40, Simon Horman wrote:
> > > > On Thu, Feb 13, 2025 at 11:55:25AM +0800, Jijie Shao wrote:
> > > > > This patch implements the rx checksum offload feature
> > > > > including NETIF_F_IP_CSUM NETIF_F_IPV6_CSUM and NETIF_F_RXCSUM
> > > > > 
> > > > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > > > ...
> > > > 
> > > > > diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> > > > > index 8c631a9bcb6b..aa1d128a863b 100644
> > > > > --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> > > > > +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> > > > > @@ -202,8 +202,11 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
> > > > >    }
> > > > > 
> > > > >    static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
> > > > > -                                struct hbg_rx_desc *desc)
> > > > > +                                struct hbg_rx_desc *desc,
> > > > > +                                struct sk_buff *skb)
> > > > >    {
> > > > > +    bool rx_checksum_offload = priv->netdev->features & NETIF_F_RXCSUM;
> > > > nit: I think this would be better expressed in a way that
> > > >        rx_checksum_offload is assigned a boolean value (completely untested).
> > > > 
> > > >        bool rx_checksum_offload = !!(priv->netdev->features & NETIF_F_RXCSUM);
> > > Okay, I'll modify it in v2.
> > Maybe you can remove " in this module" from the patch title as it is
> > implicit. This comment/suggestion applies to all patches in this
> > series.
> 
> Sorry this may not have any bad effect,
> so I don't plan to change it in V2.
> If anyone else thinks it should be modified,
> I will modify it.

I agree that a shorter subject would be better.

