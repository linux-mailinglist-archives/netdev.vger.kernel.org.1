Return-Path: <netdev+bounces-148765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94549E3168
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D6C161A73
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B959833987;
	Wed,  4 Dec 2024 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSJ0aitx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250BB27453;
	Wed,  4 Dec 2024 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279258; cv=none; b=mk+aVew0KmC5VRZ2cxX/HDaF+CO2eLiaKLiced1mVJVE7wfo0Z5PaJoxARS1I90CHeN7L2RqFShRgMHSexb3P6eNaFjgAqciUk66ECUbfBIMWEyDNFQGnB3tCdjXI6bo0SkEAIbftwQpVx2dlB+0Ws7GF3oiv3pfhBk7xoAoviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279258; c=relaxed/simple;
	bh=CvrPaCwLoa8GJeqtiBbSMsTx0QixjyJcnz0n84a5Z0c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRjx4UE1vComRJb9yNxliUrLuoa1GEnCvHbbCCSmThLlRpmonLDCHyl3Z6opTQ9vidD+1NRUJkd2lUjByXXBgcHteRFeiGr5yRxbCW51AaNjl5uVXoD1ynd0faDGzjo3tG69s6lxbZfbm182EDqPubgzsRTHDQtYghG7ZsL8Y7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSJ0aitx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7251abe0e69so5626251b3a.0;
        Tue, 03 Dec 2024 18:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733279256; x=1733884056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhd1EuBDKBFP4lqV1U8bPA9vjuYmQYBHaCzG4Z+LEK4=;
        b=ZSJ0aitx5NUzHjlDHyBehSIYBV3XGUvYuv8zMCeuHUrn34bfMZe5OkmMC1gma+pg0L
         9QvGIHARNiPSJWkLmHD9q20eHOJUjF9qeHzEsFJySFMREs3YtT6IbwNmxE9cg3t3f1kW
         gyI4ucLoSeG/tD6kEj87xc4E2hmNVWZ2Zg2HijdY4H2AcotI+QLkS9bE3sm+aqIytUh2
         wQYOCSJARjOuqa/ysy4p1wt69fVZBw4TRR7GESaSSKRP+QCP8vN0/4OWOurCFNJCYMv7
         1TFJiWKDvtAr3VPmTz8iUxeeLWFluvpRl9v95qGi0jWDKfeSPEndXv/cTYY2tGHE2nXJ
         jHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733279256; x=1733884056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xhd1EuBDKBFP4lqV1U8bPA9vjuYmQYBHaCzG4Z+LEK4=;
        b=EACBLGmx1NZ9F3KMjRwFEvdYLqNBtcAuj0rQdOC4odBpREA4GJaHyyGxq99SnN9MB0
         6d31DZ1yQKHPoBUgOOXRfxUmvpB5wi1FRG1dq/xQg3EiYKuD0UPLqETV2DajVOeZfAUf
         r98hHdG895ya0xFhoun2dHxWAqxAspslQGArIe8DgyDJjldKozS7bQ/PDzP85/7/YvWQ
         EAXguVW5bba6WIhVRSxl/HcalERz7jhxLLopkm25iZT1kPiJOiuqwA207RpNj5/jdGyD
         Z6D6crzqHqTpYHwEZUYT5gLbjkRACtsIuTt3T4dxX9AjQK7vFo0QWTe2BwoXs3gkqDMq
         4gpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZAQhTh+DvCRXPIDKAEislvJHnLHyb0p2WBKF4powQRQqhzjSjlPBsA8AK6WWcMahDJqm9i/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFfGvcCXkMGsf+V4yBHw0Jf+jF7nSRjrkHITtpcLQBCLFf2Yz
	XttgS0EmSIkxiy1tIBEnDPBFXmZifumqcDcFf8ldbB/VJ5Vx9Cuj
X-Gm-Gg: ASbGncuzU6iy2psy7zcV+CAzFCBURohKle9YXOvZUq55KDGsMASazwCxRvrWNPGzd0i
	+RW5hDzyGK/10j+jhPK/jDyDI26z9Anp41deQOay6LsTkd3YLBuHnCPTrxjMzJflx3c3abtkVIG
	9V3S3TmXreBbgUSswNBj9PKuoQg00SL6+UqTTDEWhQ1UiJsETxqCcDD2v7jLnBksr4y9CwuRL9N
	T7lKe8HZAjmk69YIBC9IO6Qex3QlHn9qD4omA==
X-Google-Smtp-Source: AGHT+IHkzmsdUDocrv7p+JQFkdwhkCUqTFBFQi154KIyszqH5Hmrw5Xo3zHsoBsNPPW/Cd/ENBxbJA==
X-Received: by 2002:a05:6a00:4613:b0:71e:6ef2:6c11 with SMTP id d2e1a72fcca58-7257fa5b54cmr6475203b3a.9.1733279256266;
        Tue, 03 Dec 2024 18:27:36 -0800 (PST)
Received: from fan ([2601:646:8f03:9fee:204:6b61:1fa:ccc8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541770786sm11189074b3a.79.2024.12.03.18.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 18:27:35 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 3 Dec 2024 18:27:33 -0800
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 06/28] cxl: add function for type2 cxl regs setup
Message-ID: <Z0--FdatNaFBtwrJ@fan>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-7-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-7-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:00PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/pci.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 378ef2dfb15f..95191dff4dc9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1096,6 +1096,53 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
>  
> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
> +				     struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
> +	/*
> +	 * This call returning a non-zero value is not considered an error since
> +	 * these regs are not mandatory for Type2. If they do exist then mapping
> +	 * them should not fail.
> +	 */
> +	if (rc)
> +		return 0;
> +
> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +}
> +
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> +{
> +	int rc;
> +
> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->reg_map, cxlds->capabilities);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
> +		return rc;
> +
> +	rc = cxl_map_component_regs(&cxlds->reg_map,
> +				    &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc)
> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
> +
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  {
>  	int speed, bw;
> -- 
> 2.17.1
> 

-- 
Fan Ni

