Return-Path: <netdev+bounces-213260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975D7B24439
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1EE724C61
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BCE2ED174;
	Wed, 13 Aug 2025 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eNx4LCbG"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009FB2ECEBD;
	Wed, 13 Aug 2025 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073276; cv=none; b=SSKtiT6ULzZmw5tpC/bFRGBZ2Eac6jFiUr0C/ASXfkHo6s/drFlWz0Wv2DLyeC93TDaapYpPNlYkMBNUTb4P+5NcRfhdOPO9hA1tuCi0wdSwpbAMevEBOrFbqSO+V/nmII3NOn6oXxOsRlFeRp1f3DAcuz0N2j1RaEhrB9gZDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073276; c=relaxed/simple;
	bh=4nJfdxzcG4OcM3o0GGc0fk6bUgEPLo11b5P1eW5MSA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YYsAQwffPTegs97IfU1t5PSeE2RQvIqE7yJRpqZRRWs8Msnr6pFuylxJtgLYvLWlYDRvcVyQ8pU6Ai9gHKmfZ/j+vqnH0meFPgbwid/j2C+CRMD1TFwsEPBIeRdGjN+BXTtvorIh2cxsNdYMUbSpRt9XWrRP/DLoQKQBDZUa8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eNx4LCbG; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57D8KGP42108025;
	Wed, 13 Aug 2025 03:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755073216;
	bh=tFefP1/yJlaAiGAZVj+v17ptcjE2g02yG+MMbCWecvo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=eNx4LCbGOW99HXoL9WyQlZDzPGnspHO7byjmLgCVttJyvbz9GrmJf5qDtDNk/D3gr
	 ZRfroad0I+A2LSFijVskPrkXlzf1/v05OGCighnsKm+7gfU6vbGwjHjCzzIXEXHvh3
	 Mq5wynYxft68hDfZfx+Tde/NkBNDlnqRnOh3xX7Q=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57D8KGXd4113029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 03:20:16 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 03:20:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 03:20:15 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57D8K8io2021639;
	Wed, 13 Aug 2025 03:20:09 -0500
Message-ID: <ab6e5c8c-6f91-4017-b68b-7fdf93980a17@ti.com>
Date: Wed, 13 Aug 2025 13:50:08 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
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
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-5-dong100@mucse.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250812093937.882045-5-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 12/08/25 3:09 pm, Dong Yibo wrote:
> +/**
> + * mucse_fw_get_capability - Get hw abilities from fw
> + * @hw: pointer to the HW structure
> + * @abil: pointer to the hw_abilities structure
> + *
> + * mucse_fw_get_capability tries to get hw abilities from
> + * hw.
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int mucse_fw_get_capability(struct mucse_hw *hw,
> +				   struct hw_abilities *abil)
> +{
> +	struct mbx_fw_cmd_reply reply;
> +	struct mbx_fw_cmd_req req;
> +	int err;
> +
> +	memset(&req, 0, sizeof(req));
> +	memset(&reply, 0, sizeof(reply));
> +	build_phy_abalities_req(&req, &req);

Typo in function name. You probably meant "build_phy_abilities_req".

> +	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
> +	if (!err)
> +		memcpy(abil, &reply.hw_abilities, sizeof(*abil));
> +	return err;
> +}
> +
> +/**
> + * mucse_mbx_get_capability - Get hw abilities from fw
> + * @hw: pointer to the HW structure
> + *
> + * mucse_mbx_get_capability tries to some capabities from
> + * hw. Many retrys will do if it is failed.
> + *

Typo in comment: "tries to some capabities" should be "tries to get
capabilities"

> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_mbx_get_capability(struct mucse_hw *hw)
> +{
> +	struct hw_abilities ability;
> +	int try_cnt = 3;
> +	int err;
> +
> +	memset(&ability, 0, sizeof(ability));
> +	while (try_cnt--) {
> +		err = mucse_fw_get_capability(hw, &ability);
> +		if (err)
> +			continue;
> +		hw->pfvfnum = le16_to_cpu(ability.pfnum);
> +		hw->fw_version = le32_to_cpu(ability.fw_version);
> +		hw->axi_mhz = le32_to_cpu(ability.axi_mhz);
> +		hw->bd_uid = le32_to_cpu(ability.bd_uid);
> +		return 0;
> +	}
> +	return err;
> +}


Missing initialization of err variable before the last return, which
could lead to undefined behavior if all attempts fail.

> +
> +/**
> + * mbx_cookie_zalloc - Alloc a cookie structure
> + * @priv_len: private length for this cookie
> + *


-- 
Thanks and Regards,
Danish


