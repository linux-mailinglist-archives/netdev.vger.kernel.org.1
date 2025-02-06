Return-Path: <netdev+bounces-163362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05553A29FF5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043411884E6B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8E4212FBC;
	Thu,  6 Feb 2025 05:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dYGMxAj4"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1514214214;
	Thu,  6 Feb 2025 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738818830; cv=none; b=ph7Qj7d5UvdVm4xYY9J0HW5SPU7YHgxJbTVGb5F0IwL2+bmhcL+vNhAqfS63W2lzLcOWWZ/JMfGM5lTjpmU7sxmmDF4p8HImvwEJ+GbuEldF4gnOVSWHf+TUHnDaypyIrQ8qEYpaGP18MZF9lojApI5LQdfGBo3xtDLif4H6dTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738818830; c=relaxed/simple;
	bh=SMknFv3E/KYryEOBK8jDr418l7AEOXLkPPwuOK+Zkr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lPKnJBu/kcOp1vlAhAeiNiOgeB41Q2X7nv05zHBQnb9j9HkXVTqxZ0yBzV76XzhvNuth7oemR7dxd6Uj7P/9GtL6QkA95o10d/9RYxTHufzgZrVfTFLr1Yje1hs9uxrJ9CZlKGCv+auO28xKcqBjec/NSebi/fKRBysEhQfTaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dYGMxAj4; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5165DPEk2668748
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 23:13:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738818805;
	bh=PxNeor84lPrfwH3EeQJD/Mm6TsABEnRiymSE+ZgCbtE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dYGMxAj4KeKtCAyobFN51ossH7Lzv680Z4sSpBuyi87HdTd9kB7sF/XVeFywrC1nY
	 v4RZf+EXHxpCll/nzvcXK0WGZO/2K20ho7W9Ol5oU7k3rTzlGuIWsBRRQgqWc7+cE1
	 AP3L9J+oJENSzj44NN+idd0iPGdpYSuoaRA2xmws=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5165DPKA060384
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Feb 2025 23:13:25 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 23:13:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 23:13:24 -0600
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5165DJLG106878;
	Wed, 5 Feb 2025 23:13:20 -0600
Message-ID: <bbbcba04-3e31-4282-a383-fb4daa7c6de3@ti.com>
Date: Thu, 6 Feb 2025 10:43:19 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Add support for Timesync Interrupt Router
To: Chintan Vankar <c-vankar@ti.com>, Jason Reeder <jreeder@ti.com>,
        <nm@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Thomas Gleixner
	<tglx@linutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <m-malladi@ti.com>
References: <20250205160119.136639-1-c-vankar@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250205160119.136639-1-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 05/02/25 21:31, Chintan Vankar wrote:
> Chintan Vankar (2):
>   irqchip: ti-tsir: Add support for Timesync Interrupt Router
>   net: ethernet: ti: am65-cpts: Add support to configure GenF signal for
>     CPTS
> 
>  drivers/irqchip/Kconfig             |   9 +++
>  drivers/irqchip/Makefile            |   1 +
>  drivers/irqchip/ti-timesync-intr.c  | 109 ++++++++++++++++++++++++++++
>  drivers/net/ethernet/ti/am65-cpts.c |  21 ++++++
>  4 files changed, 140 insertions(+)
>  create mode 100644 drivers/irqchip/ti-timesync-intr.c

Where are the device-tree binding updates that need to go with
individual driver changes?

-- 
Regards
Vignesh
https://ti.com/opensource


