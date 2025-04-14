Return-Path: <netdev+bounces-182381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 207AFA88994
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EFD1895CEE
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B5827A110;
	Mon, 14 Apr 2025 17:18:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2823E25B;
	Mon, 14 Apr 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651121; cv=none; b=FzcjilyGHIQVgp9beMNRNVclpw1vAPZNQzB22/Z6OhFNPdI3FQJede/O0pGAgG1EdssZje6ZP4xwWFTvFT0r36pRt9XU7kODEmYMgMZGLLhDrbUWQxjilGgf3MWnoERNunFDqPG3rMF0W8bswoFxVPf0h5vVtN4NZXpWK9HlOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651121; c=relaxed/simple;
	bh=Bi6MjyvNxAdltopf0J1FHXTPq7j6JHlwNPAo3aXWj/s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Spy8qAxXgLTAjKjAGeKsJjeqLflSfCd5ltmzPytApqpTtgcecf5nCj3GAH+O7V1gGbSq51W1ZdVs1xMYZQPdY/dU1QOkb90PjvE8ruz28T65pU4iy6mp8dKjbWZ8m69v2UB1WL/xrx/P3DKYkRGGPjIkxXZKToiXZTtJgdlaEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zbv6R2LtMz6M4wd;
	Tue, 15 Apr 2025 01:14:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 93F731402F4;
	Tue, 15 Apr 2025 01:18:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Apr
 2025 19:18:35 +0200
Date: Mon, 14 Apr 2025 18:18:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v13 04/22] cxl: move register/capability check to driver
Message-ID: <20250414181833.00003eca@huawei.com>
In-Reply-To: <20250414151336.3852990-5-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
	<20250414151336.3852990-5-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Apr 2025 16:13:18 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 has some mandatory capabilities which are optional for Type2.
> 
> In order to support same register/capability discovery code for both
> types, avoid any assumption about what capabilities should be there, and
> export the capabilities found for the caller doing the capabilities
> check based on the expected ones.
> 
> Add a function for facilitating the report of capabiities missing the
> expected ones.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Hi Alejandro.

A request if we end up with a v14 - please add notes on what changed
in each patch. It's really handy for reviewers to tell which patches
they need to take another look at.   More info that we get from
absence of our own tags!

One minor thing inline. 

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0996e228b26a..7d94e81b2e3b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -836,6 +836,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>  	struct cxl_dpa_info range_info = { 0 };
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
Trivial but can do
	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
to avoid need for the zeroing below.

> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_register_map map;
> @@ -871,7 +873,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxlds->rcd = is_cxl_restricted(pdev);
>  
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	bitmap_zero(expected, CXL_MAX_CAPS);
> +	bitmap_zero(found, CXL_MAX_CAPS);
> +
> +	/*
> +	 * These are the mandatory capabilities for a Type3 device.
> +	 * Only checking capabilities used by current Linux drivers.
> +	 */
> +	set_bit(CXL_DEV_CAP_HDM, expected);
> +	set_bit(CXL_DEV_CAP_DEV_STATUS, expected);
> +	set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, expected);
> +	set_bit(CXL_DEV_CAP_MEMDEV, expected);
> +





















