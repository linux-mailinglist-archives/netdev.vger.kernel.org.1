Return-Path: <netdev+bounces-148511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479B99E1EFF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4AF164181
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0E1F6666;
	Tue,  3 Dec 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcfW8chQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708BC1F4708;
	Tue,  3 Dec 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235852; cv=none; b=CEjB78W1QgmhSpri3Q/bCnVXop0YHcoN/VlOrG007VdMUkbBkJfzoVl+N6STSJhh0ogqHK5XHn9z7+886kWFkgwvpiFmv780XCsCzlBP4yTR5gxdZnlIdVeBDTUlPX0sDN2cMNS2JXFY2xnB+SVVhe7xaJ0t50OMa0IM9cuSaoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235852; c=relaxed/simple;
	bh=W+C2cJcC0sRu1VoOvZkzmodYOgYz8IyTO1gOzgq100Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm64qd0kt9aoHk+6rt5uVKNCwGTkZl5hhG3dO8VfU5Eo/JTkAV83PlGIfxXgHd2KYo8S852Xjub6O3htjwPwOj7d3dlYGlBzMJCHzKBTkxMmfyAVyn7E4qo3WPixVJq55NhOAIZHMflvBzc5IvKpAYanpKjvzxt4LiWO/Rfbg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcfW8chQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a2033562so45869895e9.1;
        Tue, 03 Dec 2024 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733235849; x=1733840649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u87SOJxHKcLpI+9DS4jttvbTCzPElqhihswI2Z2OBA4=;
        b=CcfW8chQJ9kQ+ss8sPDnunlzXOlwZ4iTXoX81JOas3p3rx98hBkIzao+w+xGPywbZ2
         WuiPBXv/Oil6rWyyKD2WsINxPEuvzOEmJC6+gwmkf10POXk3MJi47fwEHa51n40aoNBU
         me+RfxMlMmKCvjf/an9ZpiaMxXRyMQiPwegsR9mIgKN7vd0fxMtdmo2vk/vlSnWDPbqn
         OezqCH1E6UR0U/NNgRms9QjBHb2YOgzz1K6PX0Pe/9rLCqM15Roe6whHetDt7aswIkJx
         zSXFtSABDVv9nKlBBaduIrjV7vPWOyR6lBA0LvePehqof3+JzBawe92bxKGNxctYlyvq
         3x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235849; x=1733840649;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u87SOJxHKcLpI+9DS4jttvbTCzPElqhihswI2Z2OBA4=;
        b=HQoCiOKUq8GUTEJ4yj5g28dQzGQ1DXB7lB4X3djd75UEGYbB1gc6SCuLrDhYSX89Gt
         lQ0QqANV5pipg8wB9V2Jf5iUOBd+1yJu1tMuitEBhJeD8XOehBvFUB+OE1bgpb++jYOi
         6EJO3GAijvvhzAIjpY40vBXx6zjF30GgjaXq6JadIWc0apSC7ABJAqU4qPAllJ3HD6nY
         L2XIWl2NfdDXQIcQBm2Wh6H8JwdU6kmH1khjVQzGpeXiXztneUwNFiUSwC1T/3dM8RLe
         Q4Wf61vz1ULUSDAMnmLx7fg17EVI8EhjjuFlICrO5bw6doML/V7CC8ywUNjXcXiNWVNu
         F27Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEunPUEym/lJT+ouSBGBRKYP3v3KLuoY4YwsbTyEPQ8IpC1WpEcoZGDAqhj/mFY8Xr0t8M8sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxk33nqKwflV+swBmVDjooBzYS09GwaB0xyHfK4oQVIY77dn9N
	8bk+3B+/qWOaRzIMnHbDdS9r7m7iB5dwjSVo08surgRzEjmdFJK80PXqXDje
X-Gm-Gg: ASbGncuwN8nwz84Kalo3McE+ogwTj/bIOw5YheI0D4Akhl6eFTiY3qyTo3OaL90bt9j
	oBNOlJDdznQL/MpkGbGD/ZZQ0dQC0505kHyDjlSMlrXwHRRsEcSvsQkj3Xq0PYm5J3M+Wa9CW38
	4sfhZlWOZEtQPtSN8EgCiVpv8yag6NgF/y+3FZ732WHuKZ3cvvrC0v67TLfEAuLiXAQ4dhtTYB4
	+qGDXV+/XCWAip29Gq6O7CA4JdCCucte6ARZSn3CmaKBc+koGs=
X-Google-Smtp-Source: AGHT+IGXAp+3/lEI5HA+N6wXoyJLMP2Fv1GBmS+eL21zTchAvpwlj8RtHwHAgai2Z8pj9RVaCQbiGw==
X-Received: by 2002:a05:600c:1ca2:b0:434:9e1d:7626 with SMTP id 5b1f17b1804b1-434d0a03d92mr22940915e9.25.1733235848472;
        Tue, 03 Dec 2024 06:24:08 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm226466405e9.29.2024.12.03.06.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:24:08 -0800 (PST)
Date: Tue, 3 Dec 2024 14:24:06 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 07/28] sfc: use cxl api for regs setup and checking
Message-ID: <20241203142406.GB778635@gmail.com>
Mail-Followup-To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-8-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-8-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:01PM +0000, alejandro.lucero-palau@amd.com wrote:
> 
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping.
> 
> Validate capabilities found based on those registers against expected
> capabilities.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
>  include/cxl/cxl.h                  |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 9cfb519e569f..44e1061feba1 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -21,6 +21,8 @@
>  int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct pci_dev *pci_dev;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> @@ -65,6 +67,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err2;
>  	}
>  
> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL accel setup regs failed");
> +		goto err2;
> +	}
> +
> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
> +
> +	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
> +		pci_err(pci_dev,
> +			"CXL device capabilities found(%08lx) not as expected(%08lx)",
> +			*found, *expected);
> +		goto err2;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 05f06bfd2c29..18fb01adcf19 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -5,6 +5,7 @@
>  #define __CXL_H
>  
>  #include <linux/ioport.h>
> +#include <linux/pci.h>
>  
>  enum cxl_resource {
>  	CXL_RES_DPA,
> @@ -40,4 +41,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  			unsigned long *expected_caps,
>  			unsigned long *current_caps);
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  #endif
> -- 
> 2.17.1
> 
> 

