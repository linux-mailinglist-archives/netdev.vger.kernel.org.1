Return-Path: <netdev+bounces-201410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35362AE95A3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7690E4A28D6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 06:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D838204F73;
	Thu, 26 Jun 2025 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PtDgXxnw"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155054F81;
	Thu, 26 Jun 2025 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918070; cv=none; b=FVDbxsqHOku+lvUokjX8vdNuUw7xvLuWCuqBGe7eacErsFhqiYmu/l1m73eUqvIz5+Jqnsq3dJiyY5qJsSKqgwUUP8EbA5iML4RcblE16/qqDLQf9pAuNlrZjKv70UZE81EXrkLj3NSWELQhTKuBHxFFvVmjpFYaTMjxEJVXzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918070; c=relaxed/simple;
	bh=27prZUVVbLvFLQIxDtNtbGHO1peuqszUlInwqjBRqUQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB6JNpxd8HeO3eY/njwHvPjHVGxbjvtddF1/AF6fcfN2ymOIt5Dir2Qfx1xw3kpuqVXjgi73krybd6+cR/3fYDJkKBOFSCBc6uCNNlgVUJD4yP201aI7eG5qeeqBqi42hsr9P+rXdpPyzjaF8dXFeFUVuxAPFYDlQPQLVXfwLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PtDgXxnw; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55Q67Zpg2070975;
	Thu, 26 Jun 2025 01:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750918055;
	bh=hn9jqwG+6hjfJaATf5aBengLef83yCpKVDRfxQQTKb8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=PtDgXxnwQizdiB4y6j4K+D1334jkzIfu2ztyDdgCVpRZ3zMwuKsmEubM3H11gJgHc
	 XeDWALpgW9FDyVm7G0Nw5wBw6PuoNOq00ysamh4V7Oq/5km1tNZkeEXtzNO31A+u7W
	 QL6GgHm0910rDKO5lgIsVUAc5g0zwyuJALLHIcm0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55Q67Zom1708532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 26 Jun 2025 01:07:35 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 01:07:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 01:07:34 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55Q67YX1757429;
	Thu, 26 Jun 2025 01:07:34 -0500
Date: Thu, 26 Jun 2025 11:37:33 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <rogerq@kernel.org>,
        <horms@kernel.org>, <mwalle@kernel.org>, <jacob.e.keller@intel.com>,
        <jpanis@baylibre.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw-nuss: Fix skb size
 by accounting for skb_shared_info
Message-ID: <0efafd15-d31f-45f7-9052-5666921100fc@ti.com>
References: <20250626051226.2418638-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250626051226.2418638-1-c-vankar@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Jun 26, 2025 at 10:42:26AM +0530, Chintan Vankar wrote:
> While transitioning from netdev_alloc_ip_align() to build_skb(), memory
> for the "skb_shared_info" member of an "skb" was not allocated. Fix this
> by including sizeof(skb_shared_info) in the packet length during
> allocation.
> 
> Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> This patch is based on the commit '9caca6ac0e26' of origin/main branch of
> Linux-net repository.
> 
> Link to v1:
> https://lore.kernel.org/r/598f9e77-8212-426b-97ab-427cb8bd4910@ti.com/
> 
> Changes from v1 to v2:
> - Updated commit message and code change as suggested by Siddharth
>   Vadapalli.

Thank you for addressing the feedback on the v1 patch.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

