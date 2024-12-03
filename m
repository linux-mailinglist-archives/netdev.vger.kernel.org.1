Return-Path: <netdev+bounces-148634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903B09E2B07
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CCD1627A6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B0C1FCCE0;
	Tue,  3 Dec 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMNFnIog"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78214A088;
	Tue,  3 Dec 2024 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251041; cv=none; b=qVduydOgp9sJOZH8PDybc/RTj+UXuxDVjREHAi0ww5U3ktszBQJqYLshO9KayFi1m7QrOrhv+QjZ7QVwr2/u6qTKFbP+7DrrvgMGtuHc8ZgSHTrvtWkog4VsK3BPBu2z43cC/HRX9lsMeZILuCAqsxLS0PQ9kIYQYYGgGVz5uUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251041; c=relaxed/simple;
	bh=i25aqtaqmBDs6wQPwn662LWbHIdCo3vx1QlGSFnf/3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaXzhqjtrh2UQRG+vwlA1WO4THVjYqoljGAPWsNtPC+BJZUNN8AJCwjmF3UJFQzydsjWpI1yUVec+p0Apm+wGnKPEj5GckEJQl2YDwEax1/JvONvIsUMX6+xZTiBDXBl0VYsQgCJTu2EQNGxbwGaMo5cZcbOVcPXZ+ZNroZQHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMNFnIog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C277C4CECF;
	Tue,  3 Dec 2024 18:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733251039;
	bh=i25aqtaqmBDs6wQPwn662LWbHIdCo3vx1QlGSFnf/3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TMNFnIogT5S6lKgWYvagJTTuJzUE0+w4bnflUOUgD49gDuhp00YiMV14CoCR62TEb
	 JU1FwqHO2hT2H5abzumjiJtGpTUOL+9yNSrfZpaOhQ+tC54xUt9KldPVjJFWD6Ccv/
	 sJo5rrsZsGq66gNellz0LFT9uyC4RDABrws6sja6ngAU+rUTTi/x7fZG58vS57VgLv
	 luFK/Yba9w/swm7XaEcFOCAyYJriqc0DFFfvEUlAdytH09qxtVAOIwrTF5C5HZ2XaU
	 lXPGfT+fBXst5hH3oXBn4gg8cyaic8NEjrL4e749SMAFbrBxh6sbtT9X5slYRUgdit
	 S6+5oTximJocg==
Date: Tue, 3 Dec 2024 20:37:13 +0200
From: Zhi Wang <zhiwang@kernel.org>
To: <alejandro.lucero-palau@amd.com>
Cc: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
 <edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>,
 Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 04/28] cxl/pci: add check for validating capabilities
Message-ID: <20241203203713.00006c8b.zhiwang@kernel.org>
In-Reply-To: <20241202171222.62595-5-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
	<20241202171222.62595-5-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 17:11:58 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> During CXL device initialization supported capabilities by the device
> are discovered. Type3 and Type2 devices have different mandatory
> capabilities and a Type2 expects a specific set including optional
> capabilities.
> 
> Add a function for checking expected capabilities against those found
> during initialization and allow those mandatory/expected capabilities
> to be a subset of the capabilities found.
> 
> Rely on this function for validating capabilities instead of when CXL
> regs are probed.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c  | 16 ++++++++++++++++
>  drivers/cxl/core/regs.c |  9 ---------
>  drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
>  include/cxl/cxl.h       |  3 +++
>  4 files changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 7114d632be04..a85b96eebfd3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -8,6 +8,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <cxl/cxl.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -1055,3 +1056,18 @@ int cxl_pci_get_bandwidth(struct pci_dev
> *pdev, struct access_coordinate *c) 
>  	return 0;
>  }
> +
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long
> *expected_caps,
> +			unsigned long *current_caps)
> +{
> +
> +	if (current_caps)
> +		bitmap_copy(current_caps, cxlds->capabilities,
> CXL_MAX_CAPS); +
> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected
> caps 0x%08lx\n",
> +		*cxlds->capabilities, *expected_caps);
> +
> +	/* Checking a minimum of mandatory/expected capabilities */
> +	return bitmap_subset(expected_caps, cxlds->capabilities,
> CXL_MAX_CAPS); +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index fe835f6df866..70378bb80b33 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -444,15 +444,6 @@ static int cxl_probe_regs(struct
> cxl_register_map *map, unsigned long *caps) case
> CXL_REGLOC_RBI_MEMDEV: dev_map = &map->device_map;
>  		cxl_probe_device_regs(host, base, dev_map, caps);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found:
> %s%s%s\n",
> -				!dev_map->status.valid ? "status " :
> "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " :
> "");
> -			return -ENXIO;
> -		}
> -
>  		dev_dbg(host, "Probing device registers...\n");
>  		break;
>  	default:
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f6071bde437b..822030843b2f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -903,6 +903,8 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *id) {
>  	struct pci_host_bridge *host_bridge =
> pci_find_host_bridge(pdev->bus);
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_register_map map;
> @@ -964,6 +966,28 @@ static int cxl_pci_probe(struct pci_dev *pdev,
> const struct pci_device_id *id) if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS
> capability.\n"); 
> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
> +
> +	/*
> +	 * These are the mandatory capabilities for a Type3 device.
> +	 * Only checking capabilities used by current Linux drivers.
> +	 */
> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
> +

I suppose this change is for type-3, looks the caps above is wrong.

It has a duplicated one and I think what you mean is CXL_DEV_CAP_MEMDEV?

Better we can find some folks who have a type-3 to test these series.

Z.

> +	/*
> +	 * Checking mandatory caps are there as, at least, a subset
> of those
> +	 * found.
> +	 */
> +	if (!cxl_pci_check_caps(cxlds, expected, found)) {
> +		dev_err(&pdev->dev,
> +			"Expected mandatory capabilities not found:
> (%08lx - %08lx)\n",
> +			*expected, *found);
> +		return -ENXIO;
> +	}
> +
>  	rc = cxl_pci_type3_init_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index f656fcd4945f..05f06bfd2c29 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -37,4 +37,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16
> dvsec); void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>  int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource
> res, enum cxl_resource);
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
> +			unsigned long *expected_caps,
> +			unsigned long *current_caps);
>  #endif


