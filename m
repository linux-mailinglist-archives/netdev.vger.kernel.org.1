Return-Path: <netdev+bounces-223872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8976B80209
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DB217AE4C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D952BD020;
	Wed, 17 Sep 2025 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Am1FkHJj"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F2931BCB3;
	Wed, 17 Sep 2025 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092599; cv=none; b=pAfliurB39frHZjSQT52UBz25MtKYKZeeum1e+T3S0ctdNGtRVh82I51kaiS9xf/5pTte9ksPlENZfUGaaXzrTfxJgcBnmULgC/1ba1ejt1+q0UASMVcxtd5/rqMiUX91lGaOlBCmK68gnFvjUiExLykDY+FITLwBitckgVd8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092599; c=relaxed/simple;
	bh=ZwEwVx4+vvI7bG6s3rfzODzayFsu6fzYI6qnm/Ixn+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IwoM301TPQAwMQzvqv2MOi8mxC35a+tv5h0Se7MxbxFv0izsfFQDtnDEv7aeLggMGrkXX+CHEx7oHHfj7Sbuo6kVffl6GR7i13F6YtAZCll6sIrP8SRk0zeio0JdNFosLMJNJa51xGx2SNpbIvh86GJaWTR5Qb9W0c+zfKG3gZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Am1FkHJj; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58H72913193866;
	Wed, 17 Sep 2025 02:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758092529;
	bh=+B67X3paSDwAeNO3XirQWnWFfRrEQzVBPUdDesQrxRU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Am1FkHJjMno2PMnL5jr83k8VR2PgpScvQf2mmhY8Cqm1wz3U7Rseyk38/yG4djKvS
	 b+vPl1SEfxWQpwSOgCWWRgAKVU1RSwvqepidQSQYpOkD36qD7cOYLjIWj65GnZsh5g
	 mzgzE/hUmN0WsXy85TWIwlVSA0crbP9p2NxjxueU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58H729o41338827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 17 Sep 2025 02:02:09 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 02:02:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 02:02:09 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58H720uP2892552;
	Wed, 17 Sep 2025 02:02:01 -0500
Message-ID: <e035611d-9fef-4665-b6b0-5048a9d4fa5f@ti.com>
Date: Wed, 17 Sep 2025 12:31:59 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 1/5] net: rnpgbe: Add build support for
 rnpgbe
To: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <lee@trager.us>, <gongfan1@huawei.com>, <lorenzo@kernel.org>,
        <geert+renesas@glider.be>, <Parthiban.Veerasooran@microchip.com>,
        <lukas.bulwahn@redhat.com>, <alexanderduyck@fb.com>,
        <richardcochran@gmail.com>, <kees@kernel.org>, <gustavoars@kernel.org>,
        <rdunlap@infradead.org>, <vadim.fedorenko@linux.dev>, <joerg@jo-so.de>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        Andrew
 Lunn <andrew@lunn.ch>
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-2-dong100@mucse.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250916112952.26032-2-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 16/09/25 4:59 pm, Dong Yibo wrote:
> Add build options and doc for mucse.
> Initialize pci device access for MUCSE devices.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish


