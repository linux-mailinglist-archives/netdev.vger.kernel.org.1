Return-Path: <netdev+bounces-221270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13430B4FF8C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD213AD533
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795934DCF5;
	Tue,  9 Sep 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a6wbZp2N"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221931F875A;
	Tue,  9 Sep 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428518; cv=none; b=Ia8koF1TkH8gcAMq4rdCMD6QeAv9i1PEbbXeEv5iKrAPKiw574KtxANlhIWZi3C73ygRDKWB+cAFoRop86hLqQT5tAy/lRFvGK7ILqiDHJiBfzOYnqZ513IDYIxclOOVDZsGRw6VJJZ3hLq2Ui8MsoRfklGpJXC83OA2u1b40JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428518; c=relaxed/simple;
	bh=WFStOtptM0jE2sDwmCPXHKxWXtoz7iA6sgMZwK87oTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FMezqQB46GsDQ8889OKyAmbBPw7XwFiJE1pfV+g7I3o86fR4uMh2pR3xvjXL6yNyIM3KqoHRW2pwstknlf7v5JYW/K/yJoRFiVKLMehIGWmLrSGCAecWeNUw+ezHotxkaGyL+2sfZfbhnlSfSZf23FTb8svihutsxf8dGAoL+O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a6wbZp2N; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589ETNUP4120811;
	Tue, 9 Sep 2025 09:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757428163;
	bh=27WTtLsUgq3e+ywKn6BW4xaHJyslih6xGaEzfLrWAPU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=a6wbZp2NLES7tPft/GXaNBb6gxfQ8W3uTBXyiGaWgUahfZfpUotpbysUkF3b0VuaQ
	 2w5l8bbksJaqrpwFvKMTLfEbGs6Y5GULcl33eza83UUlIp7b6uBdAS5d9eatT4UEOe
	 Ydj64r7B8Usc+rEsSEWOR2nMJWNFgNnqd1XR0Izk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589ETMW03841795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 09:29:22 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 09:29:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 09:29:21 -0500
Received: from [10.249.130.74] ([10.249.130.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589ETCcj2468426;
	Tue, 9 Sep 2025 09:29:13 -0500
Message-ID: <68fc2f5c-2cbd-41f6-a814-5134ba06b4b5@ti.com>
Date: Tue, 9 Sep 2025 19:59:11 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 4/5] net: rnpgbe: Add basic mbx_fw support
To: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <danishanwar@ti.com>, <lee@trager.us>, <gongfan1@huawei.com>,
        <lorenzo@kernel.org>, <geert+renesas@glider.be>,
        <Parthiban.Veerasooran@microchip.com>, <lukas.bulwahn@redhat.com>,
        <alexanderduyck@fb.com>, <richardcochran@gmail.com>, <kees@kernel.org>,
        <gustavoars@kernel.org>, <rdunlap@infradead.org>,
        <vadim.fedorenko@linux.dev>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-5-dong100@mucse.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20250909120906.1781444-5-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 9/9/2025 5:39 PM, Dong Yibo wrote:
> Add fundamental firmware (FW) communication operations via PF-FW mailbox,
> including:
> - FW sync (via HW info query with retries)
> - HW reset (post FW command to reset hardware)
> - MAC address retrieval (request FW for port-specific MAC)
> - Power management (powerup/powerdown notification to FW)
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---

> +/**
> + * mucse_mbx_sync_fw - Try to sync with fw
> + * @hw: pointer to the HW structure
> + *
> + * mucse_mbx_sync_fw tries to sync with fw. It is only called in
> + * probe. Nothing (register network) todo if failed.
> + * Try more times to do sync.
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +int mucse_mbx_sync_fw(struct mucse_hw *hw)
> +{
> +	int try_cnt = 3;
> +	int err;
> +
> +	do {
> +		err = mucse_mbx_get_info(hw);
> +		if (err == -ETIMEDOUT)
> +			continue;
> +		break;
> +	} while (try_cnt--);
> +
> +	return err;
> +}

There's a logical issue in the code. The loop structure attempts to
retry on ETIMEDOUT errors, but the unconditional break statement after
the if-check will always exit the loop after the first attempt,
regardless of the error. The do-while loop will never actually retry
because the break statement is placed outside of the if condition that
checks for timeout errors.

-- 
Thanks and Regards,
Md Danish Anwar


