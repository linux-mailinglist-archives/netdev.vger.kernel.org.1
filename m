Return-Path: <netdev+bounces-99969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BEA8D740A
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 09:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF4628199F
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DA4179AD;
	Sun,  2 Jun 2024 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QkNbQRTP"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F52639;
	Sun,  2 Jun 2024 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717311726; cv=none; b=VPH+1SXW2OFlH6aNuvIx42Bb0N7bTh+PgAKugHhaw7Wle01LBPh7K1Q0dGgXtLo9VDmWwNrfSNVwH0107MCvN7+YJRQLUou5f7ieeH/5eZSphcKmOClghW/RKciNPb6MlvCJ2XiEI5Xca40JHdzqi3gVgBiSfaw43DCjXcofYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717311726; c=relaxed/simple;
	bh=rwBS9iZRg7crwH13dt5ijAnAHthmADY3XvpiDiRMn8M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBxe7waMUtoZUNQ2xI6QRflM4iUCT8QEXFUZCCQ6fRK7Y4E+RPGlzQ+fKoZECZxyrCOupSByBPkQcuRKTzicW2wYmk83evT8OeYL9xrjDAlZvqzL4dyLWYtO7UnzLemhDEhSNKbRdnT1U17g8HR6RgQPdlOHNlIm6uE1DmfDGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QkNbQRTP; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45271PFH069057;
	Sun, 2 Jun 2024 02:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717311685;
	bh=5r6d2PrPEEBsRenND0H/QwNv0hmJvFyqBuIX5o3zYbs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=QkNbQRTP3+KSCJyh0zcB1xZ98etDB1KPY4zo9VTOqEfdi+nCdFq6ao2ZBclkYPj57
	 biB7dy4WQkgaXtRQ/3oYQeX6qGlGXLG89CvLZ9muUF8ifYeLroNYV1qcKmLDTHsJr7
	 jsOoWFAXLFZ3W2lr1WYLU7gEGP4wGGbSol/YVjs0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45271PQh073449
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Jun 2024 02:01:25 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Jun 2024 02:01:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Jun 2024 02:01:24 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45271Owd121334;
	Sun, 2 Jun 2024 02:01:24 -0500
Date: Sun, 2 Jun 2024 12:31:23 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Yojana Mallik <y-mallik@ti.com>
CC: <schnelle@linux.ibm.com>, <wsa+renesas@sang-engineering.com>,
        <diogo.ivo@siemens.com>, <rdunlap@infradead.org>, <horms@kernel.org>,
        <vigneshr@ti.com>, <rogerq@ti.com>, <danishanwar@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH net-next v2 1/3] net: ethernet: ti: RPMsg based shared
 memory ethernet driver
Message-ID: <f13bf55e-9cc6-42dc-a32d-41bbbd8358e7@ti.com>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-2-y-mallik@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240531064006.1223417-2-y-mallik@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Fri, May 31, 2024 at 12:10:04PM +0530, Yojana Mallik wrote:
> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> TI's K3 SoCs comprises heterogeneous processors (Cortex A, Cortex R).
> When the ethernet controller is completely managed by a core (Cortex R)
> running a flavor of RTOS, in a non virtualized environment, network traffic
> tunnelling between heterogeneous processors can be realized by means of
> RPMsg based shared memory ethernet driver. With the shared memory used
> for the data plane and the RPMsg end point channel used for control plane.
> 
> inter-core-virt-eth driver is modelled as a RPMsg based shared
> memory ethernet driver for such an use case.
> 
> As a first step, register the inter-core-virt-eth as a RPMsg driver.
> And introduce basic control messages for querying and responding.
> 

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

My "Signed-off-by" tag was present in the RFC patch at:
https://lore.kernel.org/r/20240130110944.26771-2-r-gunasekaran@ti.com/

Any reason for dropping it? Also, I was in the Cc list of the RFC series.
Please ensure that you don't drop emails which were present in earlier
versions of the series (unless the email is no longer valid), and also
ensure that you Cc all individuals who have commented on the series when
you post a new version of the series.

> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Yojana Mallik <y-mallik@ti.com>
> ---
>  drivers/net/ethernet/ti/Kconfig               |  9 +++
>  drivers/net/ethernet/ti/Makefile              |  1 +
>  drivers/net/ethernet/ti/icve_rpmsg_common.h   | 47 +++++++++++
>  drivers/net/ethernet/ti/inter_core_virt_eth.c | 81 +++++++++++++++++++

[...]

Regards,
Siddharth.

