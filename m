Return-Path: <netdev+bounces-148530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB639E2378
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD96B80C6D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5961F6691;
	Tue,  3 Dec 2024 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mta84p4f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F81F667E;
	Tue,  3 Dec 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236674; cv=none; b=BO14pLp2K0g9VKrTNfmbe9+A5htcmkNBDjMLSIc/9zASIcEcOpZY7aMd8LmDLrH0VwYy2nS/63O5+v3zQBbT6V135xTM2ji5NOvlwldGg5kGOKkCv5fV8YoMcCWTrVKLDtxo3ALediO69idQhvyxi1r6pwNiB+q7oIkJloXxfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236674; c=relaxed/simple;
	bh=DqiY3UAanf00dIqw+RQo8ty085QscpuR2AWemSYwG5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goLYGXT4rNZQp7p7WmGNndnuRr0xKUcPo9v5W3PqHOWNoqxKgZtuOZpgUIxMF+57wMcJBVz6BCho5TwUBmOWY41xxqstNfJJxaFFYAEoSr46/bif8NXID3zCsCYc6evVmhnubYh5E22IcaFrjGTQHwD+XCSB/iOTrOGqY7DG0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mta84p4f; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso3746817f8f.1;
        Tue, 03 Dec 2024 06:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236671; x=1733841471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6VRfPhQBrvJKtWRzpXQC0tO9V9z0NTMxlObez9peLk=;
        b=Mta84p4fb6YW8S5lyRDwaHdwfAQ5TAWTFLHa/GO/6nS0UxnBSxgcOVtc5rgmxJKRS/
         wNzVUyw/vWmbMyxQjZEUVUIDMtalI1StqYqL+NfHAo6WI3W0Vj+/2AZ+tXWXh8phILMs
         xjaBOaSdjkko01bipCSw7oIqZxyYbdTa3SqKcXjW3doM3Kmk4YeoL0qLdWx7mI4DKS3v
         R+Qiip68AaD1+uo5Lwvva9VmGZ+XS7Nrfy58SfuRDI1z0n4Hzize9jZN9S1XWlINkTi/
         cHzzTnd93vUJCOtSwblQXPLL1HSw+mqkVcVQXg3sIV+dPSi5vu74d1tMOhGoYNYO+JlZ
         pcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236671; x=1733841471;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6VRfPhQBrvJKtWRzpXQC0tO9V9z0NTMxlObez9peLk=;
        b=FtpbAv1C5hduJWldJ76KGSR+rShIV5M7aBWYJg30vFSNQyRkIVif5QQbXm58CP/YqS
         g8On4GfBI53H0L60ft3xiurOhRoTAw1Rt63ntFP71C0qfKWY8T2gtdV0vLoPye9eYll2
         /8XfqaJW+SvrrUdi6mVlG2bPeTWA+wXfvc2SYNjB0B3rGoPfVNqEXUCeJZjUoJ3J7cQ5
         knT9f+Vpv3HkUpKOBqnsUxWGC2hiOHzuR2EXt541q5A7pPwQNXggtL/gn/I6RH/13g6D
         F7Z5fVPeQr/zxtTa9MHvjft8OzEaP+E1H+aXQL+kmhh/2Fh37ZNaIhwTHDbWY/mAfWM/
         kddQ==
X-Forwarded-Encrypted: i=1; AJvYcCViTjwS9czL1Mb9oWbMKSVkXnU1P3SaxCiQvmwJ/vWpFv7z4ew3OGzuUGLfxYsPS8RmZXKwZR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cCbI6P3C2RTQmfvPzWmonyK1EdUMwCz9xu4eUMku3ugTV4/o
	+G00uwS/1zP6jRlV+NuFfdOKbm+9+oY+SLX25IpS5KJgVKkmMBmveIjkij2V
X-Gm-Gg: ASbGncuZWEelnWe9XzOOvMh8azkNrUCgYkc+HZyYykkLTymyLNChkfe89kE2nlAjGgA
	fdDJy9Q8zuYiVQlQ2qAr5ryIwVzbRE9gRJzZOLmgtTpkJU5YHWYNhzgpdVkGEJtJvdC6E/xLL89
	QOJbyjRpCK6G8gpLVH3NZtFjyLxnc5N5TsGK/QXUXbpBEDOfXc+F+WcXIW68tBmRag8Nn9yWR3H
	3UbUZlr6B3sXZeOqpQBo6Az0yDUHqnp6jjISiZ53ygUmsOfY1Q=
X-Google-Smtp-Source: AGHT+IHccbbI9yOqiqQRLIlcqcZQgiCcqeKu9khutfVmht5tn9xnmDxEGKNKj6iLJuToaLvCAgyf9w==
X-Received: by 2002:a5d:5983:0:b0:382:38e6:1eb3 with SMTP id ffacd0b85a97d-385fd3ee6acmr2110079f8f.30.1733236670839;
        Tue, 03 Dec 2024 06:37:50 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0d4778dsm12098730f8f.45.2024.12.03.06.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:37:50 -0800 (PST)
Date: Tue, 3 Dec 2024 14:37:49 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 23/28] sfc: create cxl region
Message-ID: <20241203143749.GH778635@gmail.com>
Mail-Followup-To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-24-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-24-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:17PM +0000, alejandro.lucero-palau@amd.com wrote:
> 
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for creating a region using the endpoint decoder related to
> a DPA range.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
One comment below.

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 6ca23874d0c7..3e44c31daf36 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -128,10 +128,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err3;
>  	}
>  
> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
> +	if (!cxl->efx_region) {
> +		pci_err(pci_dev, "CXL accel create region failed");

This error would be more meaningful if it printed out the region address and size.

> +		rc = PTR_ERR(cxl->efx_region);
> +		goto err_region;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  
> +err_region:
> +	cxl_dpa_free(cxl->cxled);
>  err3:
>  	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
>  err2:
> @@ -144,6 +153,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_accel_region_detach(probe_data->cxl->cxled);
>  		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>  		kfree(probe_data->cxl->cxlds);
> -- 
> 2.17.1
> 
> 

