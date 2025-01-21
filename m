Return-Path: <netdev+bounces-159925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B89C8A17645
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 04:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E4C1889C61
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 03:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30514F102;
	Tue, 21 Jan 2025 03:35:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3126281;
	Tue, 21 Jan 2025 03:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737430552; cv=none; b=bmaS1tmWib1gCY8HdGZajTiX0wTr6HxSr14NI8G2x09bLAhfHskxE7feOqIN/LZPJNyEMhrh2tag4tUOdPcVls2QGQAbECmKQrnK7e689tmQaJvlsQ+4hjqvEfyAJn/Gew815dgLTM1FhC0D+Zb+iQXEhrrt0NIXbCuNXnwVH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737430552; c=relaxed/simple;
	bh=zxmPTjR/C6BQF4A/PgOOzO/rx8UyxlffSoxx9TVQdAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkkaPv9f7at7UCwyHz0IoxPT4t1LSIm1fx2mj58Pje8K5IL3dagVqZP/V8d0N2Fh20JCjMIG5DSnhIR07X6rvOBIVhS1tsJl9cRiPWcSZHXF8VUFnISCnTRa9iO0rYDOysHtTbpI2Hdr1DozgZEj0JrcDgeedI9xBOuec/0632Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 192.168.208.130(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.b8ISMbM_1737430542 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 21 Jan 2025 11:35:44 +0800
Message-ID: <5e11c651-ec84-4681-b631-ec771cc8736c@motor-comm.com>
Date: Mon, 20 Jan 2025 19:35:41 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: motorcomm: Fix yt8521 Speed issue
To: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110093358.2718748-1-zhangxiangqian@kylinos.cn>
Content-Language: en-US
From: "Frank.Sae" <Frank.Sae@motor-comm.com>
In-Reply-To: <20250110093358.2718748-1-zhangxiangqian@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/10/25 01:33, Xiangqian Zhang wrote:
> yt8521 is 1000Mb/s after connecting to the network cable, but it is
> still 1000Mb/s after unplugging the network cable.
>
> Signed-off-by: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
> ---
>   drivers/net/phy/motorcomm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 0e91f5d1a4fd..e1e33b1236e2 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -1487,6 +1487,7 @@ static int yt8521_read_status(struct phy_device *phydev)
>   		}
>   
>   		phydev->link = 0;
> +		phydev->speed = SPEED_UNKNOWN;
>   	}
>   
>   	return 0;


Dear xiangqian,

you could find the initialization of phydev->speed = SPEED_UNKNOWN;

in yt8521_read_status_paged().

Regards

Frank


