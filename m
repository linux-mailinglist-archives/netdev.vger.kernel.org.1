Return-Path: <netdev+bounces-157621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F4DA0B075
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D018E165FF0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3235F23236D;
	Mon, 13 Jan 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="THf2oCBc"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13D14A629;
	Mon, 13 Jan 2025 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755459; cv=none; b=SJb6y8ft45QyjKVLw9hPs77CA1anpUsD0vUglnComkA2FR7+Ah3RdCNOLg/FPl4ZyJFMde54zJJRrSRtwKMhcpeoKAipEoDpM33DmY+60RbYKdMy9OsTqaAlbX7HrbyKZwZb3z+Bfis3zwZs/N9TVgiFlM8p6QLxN8o5z3MFCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755459; c=relaxed/simple;
	bh=Rfrp9lOHU4M0RZg8njtneTcHVAWTXMYTfADOMni+x90=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rsu/kfxSct1HEjzWmwOcm+nFBqcyThm7jGh5i0eylBIhivJX83eMasCEKQMhO121pLrBDM6ks7RlF83oVl44lw+VwerxeWl3FscEh0GeqNUVw1yKHbLPzR+N8/YAjsVQPRXO6tRkpQEzIjLzaS1ljcnH7Ievd0Q6pMmMYoyswz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=THf2oCBc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 50D83ZXR026475;
	Mon, 13 Jan 2025 02:03:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1736755415;
	bh=qSW8VsRMXbq3sSb57eaX0dEK1UpZGs9dyfJAciyuhos=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=THf2oCBc+cWD9sEwWiOq1EUoUG8XfBSDFs/vyyq450/w+4ZLTXiJJacNZ+2oYF/t9
	 zGZhDIIlUj7wtZ+heIDz8YamomhQ18Wd6alisu5dxljAgRSA4lPfUIZhL+aTk9lZZ1
	 oa6MaYRMQsC49E+lsW4eYnOgAMqPSWHmMFWw9CJk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50D83Z2V045615;
	Mon, 13 Jan 2025 02:03:35 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Jan 2025 02:03:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Jan 2025 02:03:34 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50D83T2u113090;
	Mon, 13 Jan 2025 02:03:29 -0600
Message-ID: <e08733fc-3dca-43e8-bcb6-c7d86c9f0982@ti.com>
Date: Mon, 13 Jan 2025 13:33:28 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: ti: icssg-prueth: Do not print physical
 memory addresses
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Roger Quadros
	<rogerq@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha
 Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team
	<kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <imx@lists.linux.dev>
References: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
 <20250112-syscon-phandle-args-net-v1-1-3423889935f7@linaro.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250112-syscon-phandle-args-net-v1-1-3423889935f7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 12/01/25 7:02 pm, Krzysztof Kozlowski wrote:
> Debugging messages should not reveal anything about memory addresses.
> This also solves arm compile test warnings:
> 
>   drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:1034:49: error:
>     format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Werror,-Wformat]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

