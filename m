Return-Path: <netdev+bounces-148514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112299E1F19
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADA42812B3
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E387C1DE2DE;
	Tue,  3 Dec 2024 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjMWlruF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37E17BB16;
	Tue,  3 Dec 2024 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236036; cv=none; b=qqaoMp4+e5Mja22755mVtR4tmAzjCxCcs0++1ZMtVzRXwTbGrghZCbjrdwhBejU04dgyZyBIF5kRCthkoWCsPxTp0m7hoOHP85H7/3kTlYSsVgk6LIzzaUkxaSr+KT04GXqqqNAHlehsV5R+vTfKwX8pNxwCB44odmQ20e5++dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236036; c=relaxed/simple;
	bh=V8M00ZrHRkxhMoW+Hre3GkXo8196KSxpcBoK0Sfx1QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mndUStLdfrDfAw5Kj0bnxk5TB4ouN0BGnEVOSf700QkCjzGzGhjiRpf/KIVfLc6IqNLd/XAGaF0wsCqzM770x6LbQQ+gnyt8ot39sfmgT4+9F9ydgAgN1+tPpTsBflOv5uo0bl3lXQi6Y1nnhoUWlZcLsqF+sYUoacszUB9a2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjMWlruF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a2033562so45901435e9.1;
        Tue, 03 Dec 2024 06:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236033; x=1733840833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqcuArezHXb39bFp1GyHDfvERYj9Nr4BHaf61ZOUrZA=;
        b=WjMWlruFmklz2PwUWTq9M2WKCYh1fQIMA+TzoylutXakYVJeG8EU8wmDQtc1QaG4Jo
         OxOjUsFqWmHtiwLZV5TTw9TmA3k8srmmBAL8aCEAEfh9XjmHb3T8iqp41bXHkDj8LsnZ
         5/qni3Uq6fXo0FGeJGG3k+pnjmmMYGzwDsaHnOPQSUdCB116P+rBcWSSmG26YUW9EOC/
         emqulMC9QLXLFCUnzKyqUYJQA8hyFYirxKcho3mxUEBazNK0ULlD1z9sS8Cb+PCZE/5K
         cvFdXC3a+4DMX7HJeGfPwZ9EwJTqrPWcGdLG3/K3eRtO1d570RG7ahP55cNVw6mxHG0F
         3IXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236033; x=1733840833;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqcuArezHXb39bFp1GyHDfvERYj9Nr4BHaf61ZOUrZA=;
        b=vAOhE93urXQv44vkd+UNzyheuW++kAMJmcMZWUHViKMBrjCuJqGf8lFRCdaWj3Z0ec
         1Mj4zuNItB7evqpJIUY4ad+Pdqiuc8xFC5YRE0ihxO6BspganpOvgtt3gRNkqsEN84x3
         ld9yfwD8xkQ/QMy0KVtivQlK5YCH9TPJhOcWV/2NPACY4wxYzWthYo4Q1kI4de2eNnqZ
         onrOtfqjfxfqM3lBqZ0yqKNU8395Ksa3iOaKJFjqIDxznW6Evp/yLb7yfIwWsMGPixKX
         BVCjC9Amv8XgLVBdYS/xGcVDGeYHPZNCjA7o81k3xXa6y9XGTI/PoHWEe0+43y29HKow
         WMoA==
X-Forwarded-Encrypted: i=1; AJvYcCVvIZfEkPsmwRkBFHke9GstNbNm9IINJ9lx0zztvMe8tAlsgaw8szWUPiSYbq9n8jkaPveeTZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKlA7z/LiYWIdmFU4CS+DmFwdaSRlVm7drsPTf1qhnLHFXeE5
	h0iL30I+ADzQHqVcDBq8n+RKqDdpialVgp7XLSMJmkm4+6TQGYgC
X-Gm-Gg: ASbGncvMgxXqDE8N+DTH/8X/v4xOFUau8YkJz+j1OR/MNBN+ifW2C/v6zQL2dnelR/h
	0EdLDtQiE0405JEMY1PBczXR7PI0nU2pGExo9lWyR680T91D6A5alNpavBNhutN5nCI+INiVXGW
	NNRGadoDFK0gWwUfg9heI5ssIe7WvGB87KXSNQfkqF22rkJ1FnZc6CvqpGO/043bQrUT19Yy1Mq
	zkY6kZpRmBtG/KPzXWi5uwaCySNFDg4wvy16pHCjsmG5NWj9UI=
X-Google-Smtp-Source: AGHT+IF6g9tgzzuVmlMM0Nv6DGvTD/uu26ZsKOPvnB+wLn1vMee5Ee9swHRvvvW8QphIiPmvU+6Whg==
X-Received: by 2002:a5d:6c62:0:b0:385:f677:85af with SMTP id ffacd0b85a97d-385fd53ee5fmr2333335f8f.47.1733236033343;
        Tue, 03 Dec 2024 06:27:13 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f327f2sm192697845e9.29.2024.12.03.06.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:27:12 -0800 (PST)
Date: Tue, 3 Dec 2024 14:27:11 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 14/28] sfc: create type2 cxl memdev
Message-ID: <20241203142711.GE778635@gmail.com>
Mail-Followup-To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-15-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-15-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:08PM +0000, alejandro.lucero-palau@amd.com wrote:
> 
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl API for creating a cxl memory device using the type2
> cxl_dev_state struct.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index aa65f227c80d..d03fa9f9c421 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -95,10 +95,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	 */
>  	cxl_set_media_ready(cxl->cxlds);
>  
> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed");
> +		rc = PTR_ERR(cxl->cxlmd);
> +		goto err3;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  
> +err3:
> +	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
>  err2:
>  	kfree(cxl->cxlds);
>  err1:
> -- 
> 2.17.1
> 
> 

