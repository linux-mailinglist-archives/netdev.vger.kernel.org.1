Return-Path: <netdev+bounces-178386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B521AA76CFA
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F261888A9D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F18218EB1;
	Mon, 31 Mar 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTsnbYxO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55521772B;
	Mon, 31 Mar 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743446035; cv=none; b=h4MuNzL25LLzIESQYbqocLovqgab5bgQI4FxByjsaHplMRWBpsT6TPqZLSpVNBOOLvpNVoGjpYlk6jZN8ZONRvEHj2glGNkeVOgY6kdQnDRz4MnQagOgMiCn0GBiF+fyM51z7/KxTPU2qVjJV5Gj1KeIeZxsNAA/Vz5eV1JwZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743446035; c=relaxed/simple;
	bh=3q/nzymF4jq3PSl6KLLQ7uin9nbdcvQJbu/3CzSXnGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKR6WUzo01/OwUFxM2k/VmnfoXtjWL6qUz617KDaCDHTdQND4xGqRv1MkA7eBz4H5yXd2Z1ux0zViZ7ubnAg3Qe7WlCxUi5f/SpaRu4dpSevjNZOF66mDKdxsAMC8X70X0n4ZNBpUfDeN9YC715oVrBVgrqNwJnZT7zmwhgdN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTsnbYxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C4EC4CEE3;
	Mon, 31 Mar 2025 18:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743446034;
	bh=3q/nzymF4jq3PSl6KLLQ7uin9nbdcvQJbu/3CzSXnGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTsnbYxOztlWA2/pLXosQv1X+Z0vWfGIelL/fVSEfY3S5PKbUk3agsxVLz3otUQZu
	 +2o41IGue32Ta/PyjNMFSu9ujoreYXcSGJIONowpMHt3k8OSu0gCQ1fwAp65U0PXpW
	 40il2So2M3Rs/wYFy19HWp02U6i0aKfVV5ZlENH6bKyIlJxiUxACpw/oSXkfhe9iIj
	 nHPnj6YgQ7uSKWEA7lJBpOz/P/m0IcH0YaYAd0W1SDZ5RYfCwnizIMnpEt6nMVZg52
	 datZxcWN/vGgphnWv3tlgypftvGNib6gQ70LvYvQ8EIiACQe18zLsUtRE00Dnb3cwC
	 yRk4QyfUfb76w==
Date: Mon, 31 Mar 2025 19:33:50 +0100
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 05/23] cxl: add function for type2 cxl regs setup
Message-ID: <20250331183350.GF185681@horms.kernel.org>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-6-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331144555.1947819-6-alejandro.lucero-palau@amd.com>

On Mon, Mar 31, 2025 at 03:45:37PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Export the capabilities found for checking them against the
> expected ones by the driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/pci.c | 52 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  5 ++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 05399292209a..e48320e16a4f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1095,6 +1095,58 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>  
> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
> +				     struct cxl_dev_state *cxlds,
> +				     unsigned long *caps)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
> +	/*
> +	 * This call can return -ENODEV if regs not found. This is not an error
> +	 * for Type2 since these regs are not mandatory. If they do exist then
> +	 * mapping them should not fail. If they should exist, it is with driver
> +	 * calling cxl_pci_check_caps where the problem should be found.
> +	 */
> +	if (rc == -ENODEV)
> +		return 0;
> +
> +	if (rc)
> +		return rc;
> +
> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +}
> +
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds,
> +			      unsigned long *caps)

nit: the indentation of the line above is not quite aligned
     to the inside of the opening parentheses on the previous line.
     There is one space too many.

...

