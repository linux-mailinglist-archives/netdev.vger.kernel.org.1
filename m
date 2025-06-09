Return-Path: <netdev+bounces-195773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5C3AD2304
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87053A60E1
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AEF211A00;
	Mon,  9 Jun 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Zi32pe91"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4D3398B;
	Mon,  9 Jun 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484565; cv=none; b=Pzdm5KWZgFukI/rrnDaLxV1vaL3BW60bBWmUVhtseB6QLH82RsqA6EL/rkm5dYZHNcl5HxjF8mclNktyNHhc+u7mEI9aabxHCuo9p3bBWyOevnEAgFmXdR6uBR1eFcOdj9iEmQjoLmZdqdhj6cqHM4ienG1Kl3AV9nmLIl68NZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484565; c=relaxed/simple;
	bh=v/HOs5wYPXahQ/BppAotUsbvMIqbvajKilLGW22iZyA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8AIXZyK3/y9DNNh6yB9kCo3N5T2hfsfboQL+EqPkqyg7mm82ZjLUHxFm+XGps19oeF4kArdiEyGmKLGDbE4SaRfcMc/mOjkMdkgelk005NewmrEqfRuBOpmhHqgqA8NNFvrOoNRKUWLw3pBA9rMEY9HLlYYISO2QPgR66U2x+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Zi32pe91; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55998ewc029069;
	Mon, 9 Jun 2025 08:55:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=c7wxP6T9T+fWiIwiyEdpN+6mV
	3/fDKk1w5mqHrm9StU=; b=Zi32pe91oTdDj9pWov31QZFZFi74GIDH1O5oveE3M
	X3RWZqP6wqjDvod05hzTTTtdrSPIRUqj/pouyXkn3pxBMaLKQFkGchkCz1qXbATi
	HNLIZXXa4dda/G95aVX0kua6jPgWjoIbkdXTWm4yPFJHuVioVD8i594xlilcgE07
	KbxDEzer8xft5hrMdl0hGA9dyeR5GjIrRhwMXwStB7XyzGmsLzbWZ53yNOmP+740
	J9NRa6EShWUeESzHjmr5NvEQAQD7jonHY3bPGHTmvqnntp3Vcic0dBE9EDYjeaoz
	O8V8Gz6BlTSJN1BRvTFuXQ4wt1sZICQ9/2OHYGDqSdV0A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 475vq80qhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 08:55:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 08:55:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 08:55:54 -0700
Received: from 64799e4f873a (unknown [10.28.168.138])
	by maili.marvell.com (Postfix) with SMTP id 2A91F3F704D;
	Mon,  9 Jun 2025 08:55:50 -0700 (PDT)
Date: Mon, 9 Jun 2025 15:55:49 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Lucas Sanchez Sagrado <lucsansag@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-usb@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: usb: r8152: Add device ID for TP-Link UE200
Message-ID: <aEcEBUBIbLUM3dHn@64799e4f873a>
References: <20250609145536.26648-1-lucsansag@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250609145536.26648-1-lucsansag@gmail.com>
X-Proofpoint-ORIG-GUID: YnLukZZsPclCQ0iSRB4HiC2_56FMn0V9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDExOCBTYWx0ZWRfX3wMz8Kq5K4J7 o4eCWRf5NSxIimD1gXU/0WBMV/seau+8Uj9UfmL2QLRcatUw+YgmSE5sk/hPEcAOhqyDO8sczVv eEzuj2nJgH60DyVoWHH+vVT7dN375hEbf6KD2lXdOpbbqz6kgFJ4aRIX1c7drQjLUZsAvDrsoqt
 TxDu+8c9/EAlw5YCYFyYZNq+GFLgoxhCfxhARjqI2hmWLrNuFctIgVKFYpdpKs6kfR8dLmlgsj3 hbYytFppx2EeQxQNyt6/reBWv/soj9/qgjnEiQAAE5pjlIumXuXIhkStQDpgbX7fiFMWUs2uY6S M3bI9ofU6gzm/ISL92yaYkdDsP8FOEDV7gm4GbtyVBvJpsUGKTdeXCXilUIvWVzIVerpjZTK3vU
 79fgpmt6CEdQxDFExZ3eebvgbU3XfJoW4CnhIAwOcoRpTNZITOGVyiYqwwZW8zthnYWWOF9T
X-Authority-Analysis: v=2.4 cv=Rp3FLDmK c=1 sm=1 tr=0 ts=6847040b cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8 a=H9Uv-0vqiJoLvD0a3_0A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: YnLukZZsPclCQ0iSRB4HiC2_56FMn0V9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01

On 2025-06-09 at 14:55:36, Lucas Sanchez Sagrado (lucsansag@gmail.com) wrote:
> The TP-Link UE200 is a RTL8152B based USB 2.0 Fast Ethernet adapter. This 
> patch adds its device ID. It has been tested on Ubuntu 22.04.5.
> 
> Signed-off-by: Lucas Sanchez Sagrado <lucsansag@gmail.com>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

> ---
>  drivers/net/usb/r8152.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index d6589b24c68d..44cba7acfe7d 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -10054,6 +10054,7 @@ static const struct usb_device_id rtl8152_table[] = {
>  	{ USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
>  	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
>  	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
> +	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0602) },
>  	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
>  	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
>  	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
> 
> base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
> -- 
> 2.34.1
> 

