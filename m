Return-Path: <netdev+bounces-213693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9710DB26512
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F51517F064
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D932FCBF1;
	Thu, 14 Aug 2025 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FWLeO9XL"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB02FC892;
	Thu, 14 Aug 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173467; cv=none; b=Jg2+dS5WDJrekAXYhraFvWHLhbCaHJSy9oK9o3v+6v/ddxOatMFNJTVyNZU/9xjtLJa/F/YcMpoNRx1g0NGZPbg3VicdxptmEnGvjpaoKJ8hzKxo0M4tBiJFSLuzhjHOzBTVq9N/HK+yj7obFUoLSAIhyYoyTbRai56V/YcMV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173467; c=relaxed/simple;
	bh=X8Ebv39DsgYW5S3vCtvPIj2jStoX614nqqQF4Oft9TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=idnJmnJ5d2UjDj/1gvz8STUQ3zpxymW1/ea3TwmF65bSJi3LY/4iauWMue5ffzJCkmJ29CQlXim1AcOLgMXJbVrSlxp9lXaXEZqCWP1/Ff1QbT+0+xbpC6tQQwZ+OAGUTQeg4cZ7zJCeGOViqJ7hvMDYxAtPmCc+xluaYBxKNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FWLeO9XL; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57ECAM3t1927833;
	Thu, 14 Aug 2025 07:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755173422;
	bh=P55J7AG+dVG9wSnCiAJHatO757Yyz2jOVx50FgR/qyA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=FWLeO9XLv76gKZ8Sqysx3J24Rq32v/j5fEXrMvLxCjGxOpak/ZySOpwE2F8wUle2i
	 sT7NMO+TI4vN2ZV4V0hxDuCOvYORT2IhqghhQuQqxXlPJIwYXnH/xCO0EV4v13LNMZ
	 SJyBDDSvlx5BgddFmZvWFfR5o9gXc8Jt+TU4l9tg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57ECAMh11135417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 07:10:22 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 07:10:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 07:10:21 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57ECAFeI3887319;
	Thu, 14 Aug 2025 07:10:16 -0500
Message-ID: <c69d6a87-3d9f-49dc-836e-f33508c62c1a@ti.com>
Date: Thu, 14 Aug 2025 17:40:14 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] net: rnpgbe: Add basic mbx_fw support
To: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <lee@trager.us>, <gongfan1@huawei.com>, <lorenzo@kernel.org>,
        <geert+renesas@glider.be>, <Parthiban.Veerasooran@microchip.com>,
        <lukas.bulwahn@redhat.com>, <alexanderduyck@fb.com>,
        <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-5-dong100@mucse.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250814073855.1060601-5-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 14/08/25 1:08 pm, Dong Yibo wrote:
> Initialize basic mbx_fw ops, such as get_capability, reset phy
> and so on.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   4 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 264 ++++++++++++++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 201 +++++++++++++
>  4 files changed, 471 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
> 

> +
> +/**
> + * mbx_cookie_zalloc - Alloc a cookie structure
> + * @priv_len: private length for this cookie
> + *
> + * @return: cookie structure on success
> + **/
> +static struct mbx_req_cookie *mbx_cookie_zalloc(int priv_len)
> +{
> +	struct mbx_req_cookie *cookie;
> +
> +	cookie = kzalloc(struct_size(cookie, priv, priv_len), GFP_KERNEL);
> +	if (cookie) {
> +		cookie->timeout_jiffes = 30 * HZ;

Typo: should be "timeout_jiffies" instead of "timeout_jiffes"

> +		cookie->magic = COOKIE_MAGIC;
> +		cookie->priv_len = priv_len;
> +	}
> +	return cookie;
> +}
> +
> +/**


-- 
Thanks and Regards,
Danish


