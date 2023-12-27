Return-Path: <netdev+bounces-60368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A3181EDA8
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 10:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0371F214C9
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B73811CA0;
	Wed, 27 Dec 2023 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V+BSI4cz"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75022CCBF
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BR9Gb0D100019;
	Wed, 27 Dec 2023 03:16:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703668597;
	bh=NvLAYkCm+s6BJiOX+q/e2EFDzhgZcz5axVC8oBJtkwQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=V+BSI4czvNTf2mR40c/KwjvD6yRTKLdFe6T08oI2Jxxu6pDrqc8cJkJv+jnuNW2hM
	 ih2iq+Ff9yNgktNf1NehMHR9O1nxmCnZMpJ6dZLwPxrnD8YW3P6xgvpwdVfez9q0nK
	 2tpTDDrRjCPQmv1tsoBInJCJGYqsgf3YQFY7PLJE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BR9Gb3R096885
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Dec 2023 03:16:37 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Dec 2023 03:16:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Dec 2023 03:16:37 -0600
Received: from [172.24.227.247] (uda0500640.dhcp.ti.com [172.24.227.247])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BR9GX7r043590;
	Wed, 27 Dec 2023 03:16:34 -0600
Message-ID: <1f9c2f85-6922-c346-1b55-dd4666dc0977@ti.com>
Date: Wed, 27 Dec 2023 14:46:32 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next] net: ethtool: Fix symmetric-xor RSS RX flow hash
 check
Content-Language: en-US
To: Gerhard Engleder <gerhard@engleder-embedded.com>, <ahmed.zaki@intel.com>,
        <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jia.guo@intel.com>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <horms@kernel.org>,
        Ravi Gunasekaran
	<r-gunasekaran@ti.com>
References: <20231226205536.32003-1-gerhard@engleder-embedded.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20231226205536.32003-1-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 12/27/23 2:25 AM, Gerhard Engleder wrote:
> Commit 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
> adds a check to the ethtool set_rxnfc operation, which checks the RX
> flow hash if the flag RXH_XFRM_SYM_XOR is set. This flag is introduced
> with the same commit. It calls the ethtool get_rxfh operation to get the
> RX flow hash data. If get_rxfh is not supported, then EOPNOTSUPP is
> returned.
> 
> There are driver like tsnep, macb, asp2, genet, gianfar, mtk, ... which
> support the ethtool operation set_rxnfc but not get_rxfh. This results
> in EOPNOTSUPP returned by ethtool_set_rxnfc() without actually calling
> the ethtool operation set_rxnfc. Thus, set_rxnfc got broken for all
> these drivers.
> 
> Check RX flow hash in ethtool_set_rxnfc() only if driver supports RX
> flow hash.
> 
> Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> ---
>  net/ethtool/ioctl.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 86d47425038b..ec27897d1b24 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -973,32 +973,35 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>  						u32 cmd, void __user *useraddr)
>  {
>  	const struct ethtool_ops *ops = dev->ethtool_ops;
> -	struct ethtool_rxfh_param rxfh = {};
>  	struct ethtool_rxnfc info;
>  	size_t info_size = sizeof(info);
>  	int rc;
>  
> -	if (!ops->set_rxnfc || !ops->get_rxfh)
> +	if (!ops->set_rxnfc)
>  		return -EOPNOTSUPP;
>  
>  	rc = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
>  	if (rc)
>  		return rc;
>  
> -	rc = ops->get_rxfh(dev, &rxfh);
> -	if (rc)
> -		return rc;
> +	if (ops->get_rxfh) {
> +		struct ethtool_rxfh_param rxfh = {};
>  
> -	/* Sanity check: if symmetric-xor is set, then:
> -	 * 1 - no other fields besides IP src/dst and/or L4 src/dst
> -	 * 2 - If src is set, dst must also be set
> -	 */
> -	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
> -	    ((info.data & ~(RXH_IP_SRC | RXH_IP_DST |
> -			    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
> -	     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
> -	     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
> -		return -EINVAL;
> +		rc = ops->get_rxfh(dev, &rxfh);
> +		if (rc)
> +			return rc;
> +
> +		/* Sanity check: if symmetric-xor is set, then:
> +		 * 1 - no other fields besides IP src/dst and/or L4 src/dst
> +		 * 2 - If src is set, dst must also be set
> +		 */
> +		if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
> +		    ((info.data & ~(RXH_IP_SRC | RXH_IP_DST |
> +				    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
> +		     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
> +		     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
> +			return -EINVAL;
> +	}
>  
>  	rc = ops->set_rxnfc(dev, &info);
>  	if (rc)

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi

