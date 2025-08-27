Return-Path: <netdev+bounces-217252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D39DB380A8
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D950B189416D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649F734F475;
	Wed, 27 Aug 2025 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TOkbCw8v"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3241FA178;
	Wed, 27 Aug 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293337; cv=none; b=KhNDqg4+SvPRxpA741nPp2AmQ1ZRUJThlSM3v8w9nkZm2fu/SNT1lrKTXvMhzKehX34QhoC8kCJDOYsODCM4ncZOAOzFAn9lWLHI5M/XezmS1waCzLunSVK2v4JxqvfXdlDY+B21XichPMh49cZ8wQc6HVNuc2cIpX1CKScXXRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293337; c=relaxed/simple;
	bh=DELClcv/QFFbgr0N0aIqJpzPrZ9sa0zi5L0dUoIeEug=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hzkkjq3itxTMSxw6Fqj8Kh1cD//RzsB1gFaAW5woa/lJoEPusXBziXlrcOf/jQDawOJ6uALaqzgt2AAntgZ6Q0/EeqKZuzjKYeKUJwz9i/Wa9XUxKMy6+ZrZaCLRaLIG4c31ZjXG5vyJYVKXcvP73o1l7Tezx5ehgdW+X9iTd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TOkbCw8v; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R0Wwsi018064;
	Wed, 27 Aug 2025 04:12:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=eS4PJTq7t6gAJPQmnSbdZkL6W
	tmo5aHPtGS7PhCB2/g=; b=TOkbCw8v3Q5QFfD+A1EZnSJVz3bnUg2t6UEPAMh5G
	qc36UQz/W75ptu5+a0WPwNdPfiFEFEHXp7YYI1dE38sIg1Kb4yeKBpd1yxAh9+lG
	QbYBDNgUWeXG/mySNgMTPg/0xnPiPnwOmqlZ9kdzEm82uezjAQ/ckZvoxRc/AqQH
	HPpA2XOe3Y6kFQ/UfF+2ixo7+blW7tOm2oz81k3DRLSDwBCdMqqel0tYZQG2OBNd
	Acc+nbM1rj0SUYBpr8xTReyaWj+p3pBtzdiBAn3QuHaYakkmifwwgh78jQIg0JK2
	zZwj32aYMkBQteRkbrGEImDhOSoarLvHsxbeVGtMFJKwg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48spmm98st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 04:12:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 27 Aug 2025 04:12:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 27 Aug 2025 04:12:26 -0700
Received: from opensource (unknown [10.29.8.22])
	by maili.marvell.com (Postfix) with SMTP id 1DF463F706B;
	Wed, 27 Aug 2025 04:12:22 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:12:21 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
CC: Igor Russkikh <irusskikh@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        "open list:AQUANTIA ETHERNET DRIVER (atlantic)"
	<netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: aquantia: Remove redundant ternary operators
Message-ID: <aK7oFUHS0l9w3MdI@opensource>
References: <20250827095836.431248-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250827095836.431248-1-liaoyuanhong@vivo.com>
X-Proofpoint-ORIG-GUID: WZigA6f_8B3AKV0MlGZq1D8xO-3M0eWr
X-Proofpoint-GUID: WZigA6f_8B3AKV0MlGZq1D8xO-3M0eWr
X-Authority-Analysis: v=2.4 cv=RMyzH5i+ c=1 sm=1 tr=0 ts=68aee81a cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=M5GUcnROAAAA:8 a=XY7qareSp0-CB3CkL5gA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=6wIt35iRdmYE2F5fZHQ2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDIwNSBTYWx0ZWRfX7cNUJ5Hknlh7 t8u7lyArV9NJ9Mz7eNWU2fhRKSyjEvRtqx8EFEP8Qjnea8OzZYhKbF4rP3bQYyZ+OJNCVZ71Cu3 jQ+LJqo/AgnvEIKsLS1xvELONrzJI2Z5aDRsoR+ifBfk/I52gpLz0Cdu7MwUlYHsormdhqlaW/M
 zgmRPBxOkIJ4/mZKL+F4MPYM8kemWV8u5k9s5B8gEy1l7bBtZbNDyd54ep80TFlKZHP5Qv6XDGG H+rgjkGpBwBBOhoZbB5Q0OcpqWfMi5640TxPTTP1vGemctE1mbw71Rn3H0RXd664aD3oMzL3ieL 7NoefaA4SD/Zd7494f7d4sJtLcayw6lZl2mjdJcWbM6zSFZFFYsYMgNETaTiZBEosFtIWlwb8Tr gGCnearW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01

On 2025-08-27 at 09:58:33, Liao Yuanhong (liaoyuanhong@vivo.com) wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
> index 7e88d7234b14..f5e0f784ec56 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
> @@ -463,8 +463,7 @@ bool hw_atl_utils_ver_match(u32 ver_expected, u32 ver_actual)
>  	ver_match = (dw_major_mask & (ver_expected ^ ver_actual)) ? false : true;
>  	if (!ver_match)
>  		goto err_exit;
> -	ver_match = ((dw_minor_mask & ver_expected) > (dw_minor_mask & ver_actual)) ?
> -		false : true;
> +	ver_match = (dw_minor_mask & ver_expected) <= (dw_minor_mask & ver_actual);
>  
>  err_exit:
>  	return ver_match;
> -- 
> 2.34.1
> 

