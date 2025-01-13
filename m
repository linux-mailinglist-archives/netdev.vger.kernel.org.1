Return-Path: <netdev+bounces-157625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8B8A0B0AA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109A73A80BA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657CC232386;
	Mon, 13 Jan 2025 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ey3At2kG"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888E23237C;
	Mon, 13 Jan 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755686; cv=none; b=nFHXov72KYOuV7LnjdF0U5IcRX4+EHwP6dJvpaffl5EsEf3Vl+5M1vFhBaS27SeRy/z5CW3JqJjpmpY/V3iNsorSLMVKN86PK/dedCTiC7pTqiuJBUpVC1WT88ZGgD4wlF0f5kJkVE+zcliqnGEfU5eP5RArLm3AEOUwFvRXlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755686; c=relaxed/simple;
	bh=ihlPJedmJhM6B9OsggRkSmMnQ5wOaqu9osIIPdgoR4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=neA10hbPZe4mlW1pGN/zmYU7H3cKiAMLWbqDQioCv9VJw4piGtzpbPxk5nxWjE7FW33yk04iw/zF+twhKtf/spoMqoUzNtiys2wpUDaib971A6V8+l//ByxibovQl/TpnNbECLgvaTEo0jofk6ATRllo8dhZyy8qdHWq4OIZmYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ey3At2kG; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 50D87WMo069796;
	Mon, 13 Jan 2025 02:07:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1736755652;
	bh=y/1lruJzKBcWY1AjyuHdyOmumPccEBHX0hLR5fZdcWI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Ey3At2kG9ACA1f6riMOY9OycdRAOu//rsLNT8mnxhjJntG1f9L1OnMR6h/IfeovpN
	 8f5atMjHGVU3Puha5Cx6azjePTGnbw7oftK+O4nPhGKNiZzxlccWzuRaj8fP9/XT2Z
	 UIjS+9v+D+jQN9TBxP0WfihH4Fw32duYwSmhd9oI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50D87WBe079818
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jan 2025 02:07:32 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Jan 2025 02:07:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Jan 2025 02:07:32 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50D87QTQ117495;
	Mon, 13 Jan 2025 02:07:27 -0600
Message-ID: <0eaff868-f67f-4e8a-ade8-4bdf98d9d094@ti.com>
Date: Mon, 13 Jan 2025 13:37:26 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: ti: icssg-prueth: Use
 syscon_regmap_lookup_by_phandle_args
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
 <20250112-syscon-phandle-args-net-v1-2-3423889935f7@linaro.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250112-syscon-phandle-args-net-v1-2-3423889935f7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 12/01/25 7:02 pm, Krzysztof Kozlowski wrote:
> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
> syscon_regmap_lookup_by_phandle() combined with getting the syscon
> argument.  Except simpler code this annotates within one line that given
> phandle has arguments, so grepping for code would be easier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 

The patch only touches `drivers/net/ethernet/ti/am65-cpsw-nuss.c`
however the subject suggests the patch is related to "icssg-prueth".

I suppose the subject should be changed to "am65-cpsw-nuss" instead of
"icssg-prueth"

-- 
Thanks and Regards,
Danish

