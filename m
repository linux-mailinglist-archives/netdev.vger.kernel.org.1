Return-Path: <netdev+bounces-223874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C52B7F6B2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180161C03D61
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54322DC34B;
	Wed, 17 Sep 2025 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cI/dLW8Z"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAE248861;
	Wed, 17 Sep 2025 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092628; cv=none; b=qp8rwIgpEszUDF4DRy/BRnMn/n31OVl5GCmGjaICAvXnGLeRSz9MWgKGKCfz80svIfkVXwYcN1zD+Y0e7PB7jeDRDn16Iilb4cOe6U4RAfggH/WuLEG7Sx+auBWZlo3DMYyDhjVQUaJlMQlVL4aQnAMPiuuqIqz6/+kyGxXNh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092628; c=relaxed/simple;
	bh=JL7LPSxAeOpDQ7OsRyHoWqabFLrFreRArFllKrCFsUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NdDz/Sn3/QYTW//m2UD7j98rqtb5OWQJ/OV05/to4qvpU4hzmqbaViFfGizawQb8GN8kH2NW9mCIJJP9ZrRoEuOKUSPQ7jfc1K5Vzxg9+wItqevcE5GazUciq5q2HMeDYMGE45By/lLTH3pWzLJNkgX1sL2sdMN/SoCpIrywDRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cI/dLW8Z; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58H72bQD192561;
	Wed, 17 Sep 2025 02:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758092557;
	bh=rs/Ep9MtQ745vAQgrQRbhz8251X6Ange/bXa/At+1nI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cI/dLW8ZMuCjD2eJxLjo3+L1ZYFh9LjfpTGQdSvqWaDKp1RmnPbgtc8t5lb6ufyIe
	 2EIxoAMooy3IM814h7OWaA6MjYBRfAA6RC92OtbPaQVKlKEdKVC/er+MrzdPxASGTV
	 deeGTGztP7yfgKqzhs2uChKyvCD36MCYxM9RO3Nc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58H72a601338979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 17 Sep 2025 02:02:36 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 02:02:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 02:02:36 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58H72RAf2893082;
	Wed, 17 Sep 2025 02:02:28 -0500
Message-ID: <67928aed-edf7-41db-bda9-b5bcfacca743@ti.com>
Date: Wed, 17 Sep 2025 12:32:27 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 2/5] net: rnpgbe: Add n500/n210 chip support
 with BAR2 mapping
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
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-3-dong100@mucse.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250916112952.26032-3-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 16/09/25 4:59 pm, Dong Yibo wrote:
> Add hardware initialization foundation for MUCSE 1Gbe controller,
> including:
> 1. Map PCI BAR2 as hardware register base;
> 2. Bind PCI device to driver private data (struct mucse) and
>    initialize hardware context (struct mucse_hw);
> 3. Reserve board-specific init framework via rnpgbe_init_hw.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish


