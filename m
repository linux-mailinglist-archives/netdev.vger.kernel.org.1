Return-Path: <netdev+bounces-197503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C076AD8D83
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0AE3BA029
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B0E1922FD;
	Fri, 13 Jun 2025 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHy0z1OW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA21C3C18
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822285; cv=none; b=qLlSsucWNfCCk0yX0amHg+AqMEQPn9Y0XCu54XKUBTrq7Ns/uUXJEppuIM2wy5Jzwtpomu4RVnwTSoqBEzCFYYMMU/Aibd2JuWLB1/fl4aX09lnFOO6mXxhde5WKdH4Pg/K1yk46RebfsQkyHySanpniOBK7hlvJCYJmZg6/ka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822285; c=relaxed/simple;
	bh=xs8tc8DARrkvnlKYhwS5g6JwfwaoL0omsEX3mEYryYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrtV/8sW0zs/EK39Qn2yb+jQYKbQibV9lH9gcQls8Iqm1JvDpril4nCQfs7yvY9zoEYMRcRnJik48K2y+8mY3QPnqpMDq1eRagfQlX3gvUkxl+OUQieAUGvB8I1rq5C2HmsqHSb3FSZR/6/uvLo1D0MmNHQ3DIesiM0yw+9FjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHy0z1OW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a53ee6fcd5so1393383f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749822282; x=1750427082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ha63WmYrBhrwv1Upra6Vi8R5v2qxwHgIImmnm0aSZ3E=;
        b=ZHy0z1OW4mBdZPkFmWkvtZxg5Q2oTEXPzYwaJSbI+HLelANsUjZS9fOWmFIGJzMgeI
         DeUeOBBftd0X9aM7D+VwbcULxj9lkznHDNmCYLUQqUBhO1qTwnDxxC4cSOI5trYuDCuJ
         evlqIGYQ5/8P+C3KlbNcPbk5q8Pq1r9Dw+MWkFuTnFFkmX5AN0zBlxrCmC+MuewFksOo
         4jk4ALskCa7oF/arGXPgZJLibGNYiX32b+9OSKl/Hn8GOyvIa/9pMgvXFaxGmnePmQuD
         bu5m4bfoSvQXjdNog9DZ706yMUJhD6yy5pdbxPktOVDYbZrDqu0M+h3/yINiZOCdmp4L
         37QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749822282; x=1750427082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha63WmYrBhrwv1Upra6Vi8R5v2qxwHgIImmnm0aSZ3E=;
        b=FBlnReQFbC//r8Ixy+ZzSSg1VdZ/l7NdRC46PJmFnAT14PCKsVBxbK0gcG2xNv8Tbu
         Fw1WqSjHCUnXPK+bgvwMHdmQlJi9DbVDYcqYcvm7Hwz3muoDVaWzKK/SeJV+D8SkdRga
         ilphIf45opZ+7AhQMifHBuFNorq3xI0Ar5XbsR6x/o14CfZH7sMOn5w1EfkyflMM1dwF
         q7XPmgDIX7cNjuFhTzWF7CHyCtD9+6V0X8wXkbWMHQRM6bvOTV5inrOKmTz+XeU0317G
         O+sRDwasBIqyxiJHOmFVaRi4ACBViYS6KcCnkl5R+yPdRhdjsfaYezwIznDc/w3D0mxw
         YV1g==
X-Gm-Message-State: AOJu0YyGvgT8im0P1fYD1pGrwlMLxRwOOEMWflk3z9iYvE19wUzdf5mj
	O/bLmlDdjpz69X7+oktHxtd/qGI9KLdIwJsxKjzXRVSpH6AiFhwwZ/mD
X-Gm-Gg: ASbGnctENh0suN+JEMytKV2kytq3ib/dn2Is0Eh7J3e1SC6PvS3gbyK5eshB8jvBgAc
	KVCBakJb2NK4Qcud0srD27V1p+5C6aPn+wf4uRb1ymcyAMNHiMylyfHrKKWIj3Jpd8IiuT2vXaG
	n6N0mMwrK00880yjlyB799l6NeGIpsxZZ5Ly8CxT4/XeSYLTjKqzPRaQtkHh/YLhjt6dbI8NJeR
	k6iFwLhVTtSe0dHqIRzKK2cRxqmacer2d4gsl1KFK9eyURpe5lFGrLh/wovUfY4z6grSaD0qiI4
	mX+WRIe0UbWlTpEc9GEkgcmNoNxK3Cf3oOu85bXl8NzPgkrXw+QrBnuCYS0egFWbHzJXzDb82Ub
	qNDKx+0cRPRvOKY4vza/PcYK89e5EearM5Ib98dCnz3gnJ4YmG32WwphhZOzE
X-Google-Smtp-Source: AGHT+IFWhrTkw4ZNzuScntWEkfW/AQnL1MBwaRY12aG4R0UJO8cBwa+vTq5mH1DrVorrMEmlDlLiDQ==
X-Received: by 2002:a05:6000:4027:b0:3a3:64fb:304d with SMTP id ffacd0b85a97d-3a56864c20bmr2825197f8f.12.1749822282088;
        Fri, 13 Jun 2025 06:44:42 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5689e5f3dsm2466959f8f.0.2025.06.13.06.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 06:44:41 -0700 (PDT)
Message-ID: <6425933b-3b17-4509-86be-be4a75f12e17@gmail.com>
Date: Fri, 13 Jun 2025 14:44:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/6] eth: sfc: falcon: migrate to new RXFH
 callbacks
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bharat@chelsio.com,
 benve@cisco.com, satishkh@cisco.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 bryan.whitehead@microchip.com, rosenp@gmail.com, imx@lists.linux.dev
References: <20250613005409.3544529-1-kuba@kernel.org>
 <20250613005409.3544529-7-kuba@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250613005409.3544529-7-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/2025 01:54, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> This driver's RXFH config is read only / fixed so the conversion
> is purely factoring out the handling into a helper.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/sfc/falcon/ethtool.c | 51 +++++++++++++----------
>  1 file changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
> index 04766448a545..6685e71ab13f 100644
> --- a/drivers/net/ethernet/sfc/falcon/ethtool.c
> +++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
> @@ -943,6 +943,33 @@ static int ef4_ethtool_get_class_rule(struct ef4_nic *efx,
>  	return rc;
>  }
>  
> +static int
> +ef4_ethtool_get_rxfh_fields(struct net_device *net_dev,
> +			    struct ethtool_rxfh_fields *info)
> +{
> +	struct ef4_nic *efx = netdev_priv(net_dev);
> +	unsigned int min_revision = 0;
> +
> +	info->data = 0;
> +	switch (info->flow_type) {
> +	case TCP_V4_FLOW:
> +		info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
> +		fallthrough;
> +	case UDP_V4_FLOW:
> +	case SCTP_V4_FLOW:
> +	case AH_ESP_V4_FLOW:
> +	case IPV4_FLOW:
> +		info->data |= RXH_IP_SRC | RXH_IP_DST;
> +		min_revision = EF4_REV_FALCON_B0;
> +		break;
> +	default:
> +		break;
> +	}
> +	if (ef4_nic_rev(efx) < min_revision)
> +		info->data = 0;
> +	return 0;

So granted that you're only moving code, but looking at this it doesn't
 actually make sense, since every path that sets info->data to nonzero
 also sets min_revision, so why not just do the ef4_nic_rev() check at
 the start?  Answer, from git log spelunking, is that when this code was
 shared with Siena, EFX_REV_SIENA_A0 supported IPv6 here.

Have a
Reviewed-By: Edward Cree <ecree.xilinx@gmail.com>
... but this patch could be followed-up with a simplification to put
	if (ef4_nic_rev(efx) < EF4_REV_FALCON_B0)
		return 0;
 before the switch and get rid of min_revision.
Falcon is long since end-of-life, so I don't have any NICs and can't run
 any tests, which maybe means the smart thing to do is just to leave well
 alone and not touch this code beyond your factoring.

*twitches with barely-suppressed urge to fix it anyway*
-ed

PS: I spent about two hours reading device documentation from 2008
 because I thought it said Falcon did 4-tuple hashing on UDP too.  For
 the record: the 'Falcon hash' was broken (in some unspecified way), so
 falcon_init_rx_cfg() selects the Toeplitz hash which does indeed only
 consume port numbers on these devices if protocol is TCP.  And I will
 never get that time back :/

