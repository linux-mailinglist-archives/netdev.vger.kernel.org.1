Return-Path: <netdev+bounces-235751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEB5C34CD8
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 10:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3135561221
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73F6313284;
	Wed,  5 Nov 2025 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea1G+Cwb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891E23128C3;
	Wed,  5 Nov 2025 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334219; cv=none; b=u4m1AX+q95fqfGdoIJuFg+4OQw7C1kYNjb2imqMJQy2ys3k1yE7ObS0rPw8VZv7hBIfh88+qYfSdmj0+dZioSCgCxOI4PzHXXhqWW8DCrjPaf8Owgs+8ZVawpTo8bBVLbHekB5WaOZlBMSPMP2IMXWfSmlD5p+VAY/6jGF4BCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334219; c=relaxed/simple;
	bh=q/m3wCulTXhTB8/LDywh9yjrxdqTuaGoDm5TZmWIuIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlXvFpY4/TMYaxFIa93Uyp0GWwbRKoFgyxufcVIJCzE17mUueDeS09q7S73iM2yOL/t6OwGBwG4kfH8Lz7A7hTkFd+l/rxOUpzmiwBeR6k2P4vN6d52x36nrYUrgHPbagDJPfCZAlb2Kjaww8vPfEgv4745FrthwR449yfPm/qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea1G+Cwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588A1C116B1;
	Wed,  5 Nov 2025 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334219;
	bh=q/m3wCulTXhTB8/LDywh9yjrxdqTuaGoDm5TZmWIuIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ea1G+CwbIiLDs+nYhhAmF9Ead5AYmRI6qHA/G3hzcjEkcOLeoktFY+u3ZedO1PBwy
	 PQS+D4pe+MCyykbewq+yl0+vsTG4/zIed4dgCI/1+EFVx/MwqPB7kwkv+klrnhoUmT
	 ZS1kK0556t01AgRszoK0KFwBHcBSccpc2FFJSPO1HFKdtiamU58NbyVyARnIHM99ac
	 7rB/KcnlNjLhskl3W469prlkIvaAVM8UdnwTVJCPH5PI+QQx+p6Gi7NZ+NkjJ2twxB
	 7Y0p9G3iPab5eNWy0gFLu012cVham/THP2w70RfqdAprmr4ywP3Ug15J43jJC22N2e
	 oHFibyT7ISaJA==
Date: Wed, 5 Nov 2025 09:16:53 +0000
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Markus.Elfring@web.de,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v04 5/5] hinic3: Add netdev register interfaces
Message-ID: <aQsWBXonR4lwK6uo@horms.kernel.org>
References: <cover.1761711549.git.zhuyikai1@h-partners.com>
 <6c69354773fd22691da74614daa391b6451b8ebe.1761711549.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c69354773fd22691da74614daa391b6451b8ebe.1761711549.git.zhuyikai1@h-partners.com>

On Wed, Oct 29, 2025 at 02:16:29PM +0800, Fan Gong wrote:

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c

...

> @@ -250,7 +319,29 @@ static void netdev_feature_init(struct net_device *netdev)
>  	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_TSO))
>  		tso_fts |= NETIF_F_TSO | NETIF_F_TSO6;
>  
> -	netdev->features |= dft_fts | cso_fts | tso_fts;
> +	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_RX_VLAN_STRIP |
> +				HINIC3_NIC_F_TX_VLAN_INSERT))
> +		vlan_fts |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
> +
> +	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_RX_VLAN_FILTER))
> +		vlan_fts |= NETIF_F_HW_VLAN_CTAG_FILTER;
> +
> +	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_VXLAN_OFFLOAD))
> +		tso_fts |= NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL_CSUM;
> +
> +	/* LRO is disabled by default, only set hw features */
> +	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_LRO))
> +		hw_features |= NETIF_F_LRO;
> +
> +	netdev->features |= dft_fts | cso_fts | tso_fts | vlan_fts;
> +	netdev->vlan_features |= dft_fts | cso_fts | tso_fts;
> +		hw_features |= netdev->hw_features | netdev->features;

nit: The line above seems to be indented too much.

> +	netdev->hw_features = hw_features;
> +	netdev->priv_flags |= IFF_UNICAST_FLT;
> +
> +	netdev->hw_enc_features |= dft_fts;
> +	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_VXLAN_OFFLOAD))
> +		netdev->hw_enc_features |= cso_fts | tso_fts | NETIF_F_TSO_ECN;
>  }
>  
>  static int hinic3_set_default_hw_feature(struct net_device *netdev)

...

