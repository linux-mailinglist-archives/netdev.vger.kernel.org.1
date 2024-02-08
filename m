Return-Path: <netdev+bounces-70276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A20B84E383
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CA81F2848F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5916879DB3;
	Thu,  8 Feb 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zCSaQKOK"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845167A01
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404034; cv=none; b=sp8DWvGaho5u9CwV2RQ94laneEBVXtYaFoV9mtkTAPr9bW5hj2lXV4jpicuahdiZSi76U8RcCYsGBGf0BUWkmRro3c512MKpqmxH1f9EX8y5SivRm0Lgoz4CBaim8SDhzryjWEs8yXJxpea6ed7yaFiAsjZqg0cwmk41omQturs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404034; c=relaxed/simple;
	bh=q9YoLf32PHIiRxJzmYTRvH5+VrTUwqrjluzG5twaNEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gtunrcqMNF2/Vs4SeDJDa8p5vlQ+q1ruOVfmMNTy0oP2fjvBQLp91k7gqqW17nfP3mRjEhfQ2s5FlvSpISw6PxTxqT/cDpeLjxx+wsMIkFv9sv9SvWwWSzOE++bZ3hYTn3BeOQm7bfpvjW8EbUeiSxBSafZ1AUypcs4XKvTo1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zCSaQKOK; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418ErX9K103128;
	Thu, 8 Feb 2024 08:53:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707404013;
	bh=3uDKHQbj5Z7JrKhXzfc23R/UQa6a6kK/v2nH8r+kt3A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=zCSaQKOKbwV2Foe1meSMSAqNDfad3mIlw61EJZnprO8KxOBXLQSpK857Z95nlWt32
	 pEfId30I56FwVzr+qvcn4WzNDCLWLeNOVPnWJbC2tb5UQXhSc5YYW/PXhdXnULpq7E
	 DbwN5DXsVVJ7gr4ysn8kA2MRr4GzrIttld4SwzHQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418ErXGR045108
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 08:53:33 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 08:53:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 08:53:33 -0600
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418ErSn9088552;
	Thu, 8 Feb 2024 08:53:28 -0600
Message-ID: <b4ae0bdf-0763-4cc0-87c3-0b7fd87f6633@ti.com>
Date: Thu, 8 Feb 2024 20:23:27 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Remove duplicate cleanup calls
 in emac_ndo_stop()
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, <danishanwar@ti.com>,
        <rogerq@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <vigneshr@ti.com>, <jan.kiszka@siemens.com>,
        <dan.carpenter@linaro.org>, <robh@kernel.org>,
        <grygorii.strashko@ti.com>, <horms@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
References: <20240206152052.98217-1-diogo.ivo@siemens.com>
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20240206152052.98217-1-diogo.ivo@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 2/6/2024 8:50 PM, Diogo Ivo wrote:
> Remove the duplicate calls to prueth_emac_stop() and
> prueth_cleanup_tx_chns() in emac_ndo_stop().
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Md Danish Anwar

