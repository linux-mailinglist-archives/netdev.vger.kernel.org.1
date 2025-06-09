Return-Path: <netdev+bounces-195633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBCAD18A5
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 08:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4E21693E8
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1202459F9;
	Mon,  9 Jun 2025 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="emmX+3yQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25424610D
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749451134; cv=none; b=IdpCLwlDDli4IFLgwNAfL8QI2VVeg0b5sO+ieh1bXmpdItPcHEK7pmFfJcgtI7HTHRPUnVht24Jk0rLmK0zS0W8VWnx8+MYJ0t5IqEGvAGfgsobDblrz5+0+h14l0zedRrbEmuAf+VCFl8gr0SRFHcEMGVvnfrDNThGckO5wIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749451134; c=relaxed/simple;
	bh=cAb2IEGtUUtGGHDIj2yjd6O7vwK9cSmyXW3SsJpOSiw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVNBe9OTQNNMDRFiWl/sxw8kaY00hs27m+9I31FWS+2Hxd+1sqPmvbmc+/tD7DigE3Spbi/nXcBGae14Zxnx9+w9qW3aCxKAyUgxvkGcHAsRaKCeMYzw0i7Zu64w67otidtCGkwrqWE7li5CV4M4yraFlK5QXNCpXJTV3DWXxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=emmX+3yQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55940qkO009739;
	Sun, 8 Jun 2025 23:38:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=oATtCwnFCB/2aKY/BP7CiP3AQ
	7LXI1oOBW68AWYVq1E=; b=emmX+3yQ5UXCkz9er+z0XemakxpGH13Sp4JhtmFPA
	53I3S5kZenqLbPQkz8g4PC8OPO5XyULdqXtOq6ictbDdj7qFLUKJSGBbty49qllE
	4j36EPSv0N9gyOk+Cl20FeI3xx25KC6sPdClM/1eIhBBCVnMFn4E/vuht0xoQvMx
	MVgF/hH++Ws3fuCEfqYQQH8myMDwK1jjZtJt6wCObPANvXy/VY4dYcNsyUWnj2fo
	CT+5NYfhW4c78jnvrVDTeiSPh8R+ZCEamUmv3wouvMd5p3VAy97xCNT/suqo7KmG
	n2+VmGvU1t9qb/kPylfE92N0xOESxbnWqG3g6R54F942A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 474mxkad3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Jun 2025 23:38:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 8 Jun 2025 23:38:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 8 Jun 2025 23:38:35 -0700
Received: from 82bae11342dd (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 393793F707D;
	Sun,  8 Jun 2025 23:38:32 -0700 (PDT)
Date: Mon, 9 Jun 2025 06:38:31 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Li Jun <lijun01@kylinos.cn>
CC: <davem@davemloft.net>, <edumazet@google.com>, <netdev@vger.kernel.org>,
        <michal.swiatkowski@linux.intel.com>, <horms@kernel.org>
Subject: Re: [PATCH net-next] net: ppp: remove error variable
Message-ID: <aEaBZ2jK1DjxaEAr@82bae11342dd>
References: <20250609005143.23946-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250609005143.23946-1-lijun01@kylinos.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA1MSBTYWx0ZWRfX1YngPCwkbLc3 aKlqjxZ/XZDchxaSFHrp9WpdeXA3zj4jWxrL3cNKjpBOjEXOIzgSNJ4q2QR47XBkNcfY2gkPG9M 80thmh8RwDlb5/wPPx3PnO/07EKYI07ApOWd8Rztyp3lwhlpq90wKacKYLkrxtj293fBWidN8+n
 1Wn5mCOsED77ER4X2X5jAU5cusvlg7i4RUKYGA0l4dnFg4B/TmY7JIOtyqYeh1uLnnT1f1W8zJw U5SNiW5hzOusdK5xrJaELDZai0puqGWa8RPNjtngz4qPjz/agmbDohdtxVKTB5Fjs17fRo6Hcmh LAryYB48ejtRBegsfCfTW4bKOmuHTTxAvEty3rMXOkqVk5nEHbRRHqVH32CliH/CutquZMLTogx
 pdodPUD3WLsX9Lo57q+9H5oU9ZTipv1nwpvcRRsYch/UHPPg1CM6nODEXhdNR+T8GeT8/Ueu
X-Proofpoint-GUID: k6AgCrvYIkpVAJ36VmYxmXwL8fxmOBiV
X-Authority-Analysis: v=2.4 cv=Lq6Symdc c=1 sm=1 tr=0 ts=6846816c cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=tvudAbC32e9tQbKPJnUA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=45YzpkTmBZ4hW-29o7YJ:22
X-Proofpoint-ORIG-GUID: k6AgCrvYIkpVAJ36VmYxmXwL8fxmOBiV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_02,2025-06-05_01,2025-03-28_01

On 2025-06-09 at 00:51:43, Li Jun (lijun01@kylinos.cn) wrote:
> the error variable did not function as a variable.
> so remove it.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

> ---
>  drivers/net/ppp/pptp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
> index 5feaa70b5f47..67239476781e 100644
> --- a/drivers/net/ppp/pptp.c
> +++ b/drivers/net/ppp/pptp.c
> @@ -501,7 +501,6 @@ static int pptp_release(struct socket *sock)
>  {
>  	struct sock *sk = sock->sk;
>  	struct pppox_sock *po;
> -	int error = 0;
>  
>  	if (!sk)
>  		return 0;
> @@ -526,7 +525,7 @@ static int pptp_release(struct socket *sock)
>  	release_sock(sk);
>  	sock_put(sk);
>  
> -	return error;
> +	return 0;
>  }
>  
>  static void pptp_sock_destruct(struct sock *sk)
> -- 
> 2.25.1
> 

