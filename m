Return-Path: <netdev+bounces-80798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755078811C3
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30365285D38
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E7D3BBC8;
	Wed, 20 Mar 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnE5SgoM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57FE3FE20
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938376; cv=none; b=qV34PqHq4MGxBij1jyO0T0LIBGwTFYiMOfzKKYL6Co2nPxOZBMOmbyPqzSkyi3nvugWj5mqi4zjGEL5dBHAC9ju2meSSXHt0y7MrAppAv+8b+RyeDGaeMaERGacQiO6XeYAy4FNlQQ3G4ghXKg5kLeArXdS/TidRgGNnnYWFVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938376; c=relaxed/simple;
	bh=Wunx9RkS5kAS7EP8GV7ofSvEH6Bug37mEESmRmm4X88=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SHYEw8kHRc2jkZnRmodkelCdgTN1J8cZF/QcphLAEOjQjOKXEVwhLxdTf/VRp5kE4KiaCR0B/3rLS+QbX3rohLc8vN5rEPBhsf0jGOYaYPcTt6XgS+TS053wiPkaed+5NlMeu9sWHo82Rb0PY4GoUGEO601+jZiDEmY/X8HftRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnE5SgoM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710938372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwD1DlHDJoiZ+BASl5M1X9taC4Av7K/8w3on45P9Dug=;
	b=VnE5SgoM1YaUMivRuddNt0uVoYHUojtOhTLRH172Wyaulp7+rDTohhN55FfVxsMsYbvx7d
	YQfdy7piNYYG+5hk9G8fGtud+BpcNXOUvWDl+99pIavYNUPOJ88O9v7nLqyNg71UMeQAph
	CrwSpfeepgrYzxmSYuA2UaFM4O2JAPE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-OwzYUCm4P8i5eq6lgk7V5g-1; Wed, 20 Mar 2024 08:39:30 -0400
X-MC-Unique: OwzYUCm4P8i5eq6lgk7V5g-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso4215946a12.3
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 05:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710938369; x=1711543169;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pwD1DlHDJoiZ+BASl5M1X9taC4Av7K/8w3on45P9Dug=;
        b=hEjIv20S5xfgCcsadKtcBnf3tL9b/l6CtwSRfzn3L9Ra9PJPnviLWchXscfWq2PtGv
         Oys7f9q+eD47TH+gdmVNMxmsITgrWb14KYez6YuvZXPXRoIolrFKSrD6WSBIIwxqaPuq
         kzQsGcVUtYL+xXMWbxgyJGvkeq8O/GvvG4PqaSCVbBBF3xmEViNZSn5AmoSr930snNF/
         RbC6g6jAXQQT8UfY7hWobA61TDkpL377uxecM/6XnEKHhpvhn3LXsINI+/gV+PyfFCaX
         F959TaT6DvQZ6GOXGtj1L6XOKas0T1FyP8Oro4qpVyVVSMuTLweiacv37yEvAKEqmYJ1
         +Ubw==
X-Gm-Message-State: AOJu0YxZNja7RowwyVvKlpH9M8IxArlqIwHt4x6/9JRoJWHlsVeMA4Hq
	p/hh/YKTKSh+iuqw38foPbvakQRkF9R5Pp2SeQfeZ9ZUEYbWEgVG3orxlTYEcvq9oq0QzqbXwPL
	OcFsTe/5ugHFsLIIs/ZZaQua2WGRIkfb5yT5SITbvbVV4tFkzpgn1dQ==
X-Received: by 2002:a05:6a20:b297:b0:1a3:6ed2:ee27 with SMTP id ei23-20020a056a20b29700b001a36ed2ee27mr5397295pzb.16.1710938369603;
        Wed, 20 Mar 2024 05:39:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlcuStyWu3TlWrrisDP8mtM6DjNM279tXgyIaSQ2Jz6K6uDf2Hr7dvEXshrk3XT1ZYHq+R8w==
X-Received: by 2002:a05:6a20:b297:b0:1a3:6ed2:ee27 with SMTP id ei23-20020a056a20b29700b001a36ed2ee27mr5397286pzb.16.1710938369255;
        Wed, 20 Mar 2024 05:39:29 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id g20-20020aa78754000000b006e672b48b49sm11548252pfo.157.2024.03.20.05.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 05:39:28 -0700 (PDT)
Date: Wed, 20 Mar 2024 21:39:24 +0900 (JST)
Message-Id: <20240320.213924.690460440850932744.syoshida@redhat.com>
To: chr@terma.com
Cc: netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] net: ll_temac: platform_get_resource replaced by wrong
 function
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <41c3ea1df1af4f03b2c66728af6812fb@terma.com>
References: <41c3ea1df1af4f03b2c66728af6812fb@terma.com>
X-Mailer: Mew version 6.9 on Emacs 29.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 19:45:26 +0000, Claus Hansen Ries wrote:
> From: Claus Hansen ries <chr@terma.com>
> 
> devm_platform_ioremap_resource_byname is called using 0 as name, which eventually 
> ends up in platform_get_resource_byname, where it causes a null pointer in strcmp.
> 
>                 if (type == resource_type(r) && !strcmp(r->name, name))
> 
> The correct function is devm_platform_ioremap_resource.
> 
> Fixes: bd69058 ("net: ll_temac: Use devm_platform_ioremap_resource_byname()")
> Signed-off-by: Claus H. Ries <chr@terma.com>
> Cc: stable@vger.kernel.org

This patch LGTM. Before the commit bd69058 ("net: ll_temac: Use
devm_platform_ioremap_resource_byname()"), temac_probe() calls
platform_get_resource() with the index 0 to get the resource. So we
have to use devm_platform_ioremap_resource() with the index 0 here.

> ---
>  drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
> index 9df39cf8b097..1072e2210aed 100644
> --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
> +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
> @@ -1443,7 +1443,7 @@ static int temac_probe(struct platform_device *pdev)
>         }
>           /* map device registers */
> -       lp->regs = devm_platform_ioremap_resource_byname(pdev, 0);
> +       lp->regs = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(lp->regs)) {
>                 dev_err(&pdev->dev, "could not map TEMAC registers\n");
>                 return -ENOMEM;

However, it seems that the patch is indented by spaces instead of tabs
(maybe your mail client replaced this?). I recommend running
checkpatch.pl before submitting patches.

Also, we should put appropriate prefix, i.e. "net" or "net-next", in
the subject. As for this patch, I think "[PATCH net]" is appropriate.

Thanks,
Shigeru

> base-commit: d95fcdf4961d27a3d17e5c7728367197adc89b8d
> --  2.39.3 (Apple Git-146)
> 
> 
> 


