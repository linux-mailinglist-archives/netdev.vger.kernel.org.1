Return-Path: <netdev+bounces-148713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9904C9E2F55
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0982819A7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAB8207A3E;
	Tue,  3 Dec 2024 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feZY56eq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C4913AD1C;
	Tue,  3 Dec 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733266554; cv=none; b=eeWXaHwD1He5k7ufDmV9flxVu+a5saWzAhzrOIWoM0L5U3QnNQmNOT7le3adSiEYoa9JjBPjN7NraoSl2AWrZ5hfLWehNeVyRK+sHR0VvzRwsGJnZd9ZUvVsPLJd31EhKWlKqX5ROWnEbjXjeknNJeNV97ScSEDjryJyOkCEMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733266554; c=relaxed/simple;
	bh=UtJ8GUEdiO1IioQArRIlzoBgNQKZhjfkymQq8faQpcY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUsIg40pEjhAeHAUDquA/NoMmTNZN2uuiKsYyaGbo9HcUKlAVcXM0CqaKgvjdocJ+U99MLGpY0RaJryodxbUZb6f19J6kgZDY3vkcnGIWwy9YIvM7Hc40ZyL7/ZSz4I76KBN6xKveK1anq1n/ayV/FtNt5JN2pkR11MO2voqDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feZY56eq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-724e14b90cfso6124522b3a.2;
        Tue, 03 Dec 2024 14:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733266552; x=1733871352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xo4AlQVCclASkVxOb5FJsyufPpNOzRkzyxv+8/vrslY=;
        b=feZY56eqRrSmmN2ewO65O6AVUN/lPNoUpqaOJPnsrSzWJkymaX3/qnasTL99liJ1uO
         +1HL0j88actGNoqIaMCPqRB4iq5UJhUG1Mc1tQHjr23/x1xywd0luqIlSYk3d3Mx0Znr
         6BYojOLB01WkvSim35YymiUO5nToxSguFFSmLmYSZpch6IKWZx45yDuSPk6ZknqnEFKz
         7zBG5lToExE7A93YYTYrGFG3w2M+0TuHH40RARVXXOYsYkbuwZYXesgeViKpOPCfghnH
         RJt7dNcxtadw2GaULmAxMFyDF3t1GywUdSzrZ0T6DnhvYSyQZ515H67rDNwIArBvW9hZ
         ZP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733266552; x=1733871352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo4AlQVCclASkVxOb5FJsyufPpNOzRkzyxv+8/vrslY=;
        b=tApWMP2BkTafZ2WIF4M4j4S/qKomKluFP1Y99tgL0pwKzx+1G8Vlwjf6+OkBXyZmsk
         YfxGhVyorSLqydX3FP7XQ9Zv/h5W3c1RNBDU3xjNxaoNRmf2etYCtgBYc3TU43OJ7hF5
         yqApefNgkHg8gyUgA5dkFJA1kpq+0ZJ94iWpowi+KCUin/lyHv9MSpVivssQzldLVgCV
         uqKTVKNis8ibRJgUdtwIWhfZ0LoDjxuA2PjhQlugwiVnSrTEoZPguyAHP8yx5goH+Pyn
         4a8yz7Vl/hsVHfpl33c+V9DcPiMvu5OKUOh9Lg7HO98w/8ewdHdoJ+b01m02g2M8oKEo
         yySw==
X-Forwarded-Encrypted: i=1; AJvYcCVjl6L/UvjyeNQmBUdregUFZyFTjgQP0wlGe7GaTZc/gKAy5amwDc+4DgnIDAXaRcAXz5LaKps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6uoA+EJQYZlISo1GVn0bb5qkHd28M8WTfL8ODXJfSerD9ceT1
	2uOWFwUehM0s9amiKu/G4vNVOSpyh6xioJ5Q4lckHj4fH5rNXJ/M
X-Gm-Gg: ASbGncvfK0mZ9Fk2zrnC5kOI19dvYOye0Gitke/gDMfW5vxXKJKke+K21K3Sn85z7T9
	cj4A6bKiH1SoJgPqP1W4zPkP83lam/rLA+cvSbjtStas7ALaMkyPjgDVVKVVZYk4Uu2ls25Yas7
	8GIPjnZpOM21vrqTXhvQPn9WVldwqVt7mKAFcPIH3Gqnl3z+QN+gL8jAx83Y/lhRsGpoZQV7ZZO
	qUbevVJVQbLbiMKOFSIjZIl2zznFBC5+q78dK8I7obdLLYTnVfDIQ==
X-Google-Smtp-Source: AGHT+IHf8Y6mlT0E/9tS74VLfp3S49niBvr1PpAdwP0HkpIvXn0cbpq3xiSJWO0jaLIXhimrAt3cFg==
X-Received: by 2002:a05:6a00:39a8:b0:725:3fb5:5595 with SMTP id d2e1a72fcca58-7257fa3a10dmr6612589b3a.5.1733266552252;
        Tue, 03 Dec 2024 14:55:52 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176fc93sm11404797b3a.63.2024.12.03.14.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:55:51 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 3 Dec 2024 22:55:49 +0000
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 04/28] cxl/pci: add check for validating capabilities
Message-ID: <Z0-MddhGPjtO91h_@smc-140338-bm01>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-5-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-5-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:11:58PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> During CXL device initialization supported capabilities by the device
> are discovered. Type3 and Type2 devices have different mandatory
> capabilities and a Type2 expects a specific set including optional
> capabilities.
> 
> Add a function for checking expected capabilities against those found
> during initialization and allow those mandatory/expected capabilities to
> be a subset of the capabilities found.
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
> @@ -1055,3 +1056,18 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  
>  	return 0;
>  }
> +
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
> +			unsigned long *current_caps)

It seems "current_caps" will always be cxlds->capabilities in this
series, and used only for the error message. Do we expect a case where
these two can be different? If not, I think we can get rid of it and
just use cxlds->capabilities directly in the function and in the error
message below.

Fan
> +{
> +
> +	if (current_caps)
> +		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
> +
> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected caps 0x%08lx\n",
> +		*cxlds->capabilities, *expected_caps);
> +
> +	/* Checking a minimum of mandatory/expected capabilities */
> +	return bitmap_subset(expected_caps, cxlds->capabilities, CXL_MAX_CAPS);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index fe835f6df866..70378bb80b33 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -444,15 +444,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
>  		cxl_probe_device_regs(host, base, dev_map, caps);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found: %s%s%s\n",
> -				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " : "");
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
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_register_map map;
> @@ -964,6 +966,28 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
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
> +	/*
> +	 * Checking mandatory caps are there as, at least, a subset of those
> +	 * found.
> +	 */
> +	if (!cxl_pci_check_caps(cxlds, expected, found)) {
> +		dev_err(&pdev->dev,
> +			"Expected mandatory capabilities not found: (%08lx - %08lx)\n",
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
> @@ -37,4 +37,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>  void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>  int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  		     enum cxl_resource);
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
> +			unsigned long *expected_caps,
> +			unsigned long *current_caps);
>  #endif
> -- 
> 2.17.1
> 

-- 
Fan Ni (From gmail)

