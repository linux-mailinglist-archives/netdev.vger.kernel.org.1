Return-Path: <netdev+bounces-229145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A286BD88DA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368A31923E0D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F6D2EBDC8;
	Tue, 14 Oct 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YF/Pocbf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC52E7641
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435240; cv=none; b=oM0cU4n9cO0DFL+DTHJUrgjrLte7tOgq7jTnM6ehMfkCRsAy6qH1x/eUtbDfV8lmO+Sp/pqif+erN+VvV2RT8Ynt5E/F360+dgWKA2tKg4ZT90OOi+/SnnJm6UjJ36krAfebbrKSg1jFibCfdSCbAbiyGOermMUmOoangGk63hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435240; c=relaxed/simple;
	bh=so4LHqIHw3CFGt8OZscMcsX45wmcCRUdVqsTf7gb+EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rB5b+t5VV76bp1Ln7D7OCeQvlfWHWosPG6ze6q9NRCZtTgSImKBlI5OsZ8me7Mm1FPjcY+xpAMDdqNSn+U5bZHOsYkBEVFPKXNMHbx3nII+5dZ+iKu3Hs4PLfTk6odHplTdJh+p4HBii6QhF/jwxilJazMzJG7EBMZ9Y03ju2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YF/Pocbf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760435238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5N6OEeG5CmV81eCe6A/4zE10OVgeRQaahrUEjZTGJf8=;
	b=YF/PocbfHXofEjyMDgXzH6fORI969uEJxlhwb4gJOxBWRNzzpiZCZtdhkMFhSX4OipUuCB
	iBAkUsNL09UhaRPR12moSNVVG9iw7dFjIyN5VynlYQcAZx3dAuzPY/c3cfVnT0G35QKxgo
	eTk4LhtiG3GSvcxW4OpIRBb/u//Ei4U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-NlcdX5T1OdSFFcufPQ81cA-1; Tue, 14 Oct 2025 05:47:15 -0400
X-MC-Unique: NlcdX5T1OdSFFcufPQ81cA-1
X-Mimecast-MFC-AGG-ID: NlcdX5T1OdSFFcufPQ81cA_1760435234
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e4c8fa2b1so21625515e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435234; x=1761040034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5N6OEeG5CmV81eCe6A/4zE10OVgeRQaahrUEjZTGJf8=;
        b=An22kOwehA+/FVMmov5MeAkGoi5aprcy55A5Oyf5eZesEH2b6qa3+iQJl6qbTzkT3s
         D1Mjk2t0s7WWiQtDbhmoDwe/8FtIDqoL+y6s5nlwGRQMjm9xu0vNUwHWYlRIgN8A5m7V
         eNJDZGz2W9mRciw1aQKokr4He7dTLAqhyGSidlEgC+vNdkydjnvN7HDOa6arQGsnfqX3
         3V0QTdmyyv5p7wuyUiWlm50c90rH1lPIoSiMjNrYqJrfI4EV9GyPRPGHcYvdq7YSTYGp
         n5bv5/f/us6p1LWzPx5WCIb/xT2jy0F9c8WHQ4AshB2CYf7fRQ1d7f5bGFtbaD8IAZId
         OIdw==
X-Forwarded-Encrypted: i=1; AJvYcCX2TLMYCIOs51n4x/ef/c55OJug3tacS8iZqbThtKMiCaMpNJTQeVOGP0MJiEY6xEK2ZUa12rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZK+KiIzYjBn6tp2+nSmyc4DMBgH1dEo+jVWH/6w6sMgTrbFD
	ktqTxyUHv0iBf2gR5WWykdgMoyqcIOMIa31i8cfGJU4s+KToW5M9uvkvp2dPcCRFZR0N8iE4NuL
	AeOrO2IVXa1XxkF/69iDLt6wqlBGlINHks/mxT6z6Q9ki9r5WHlp37bntIQ==
X-Gm-Gg: ASbGncsfTNIAk76ZKXYd5jFF64timlOJ2CP1Aq6LNiOzcRZaarHb4l9ADyAFkZzkssw
	wiblMW8r0BaoAdWW7i56VOEXNoQJbbkJUfb0vffz1gC6jW6hcSMUOFBhiHO9jEecOe/znArM52V
	VBDuua9DSWs89dk136j3eRdEVBqXWKhlaVXrNgujCR0QHzmcSAosBFe9yjvQ3rTo7FKC5lleEqs
	eb7Vc1Vsftyx/LfZaa56ZaMgEaKj2WBJi4tU0f4NETIA/pjEJKur9kOZdA6dxlu6uKIoa+eDCyu
	BBfKljFndcYMNtWr2cDFY6Nt3GVOh/pT3XFXEYva/hPTOAXsTHyk7r6+VtPsMXgwQGtG8ezjY7L
	ZDdYz0evwL7AR
X-Received: by 2002:a05:600c:4690:b0:46e:3dc2:ebac with SMTP id 5b1f17b1804b1-46fa9afbb62mr156259755e9.27.1760435233752;
        Tue, 14 Oct 2025 02:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCHYgG+2qltz9vAWbpxtZa9W5FNzHR/pFUCq82szUc8pklfr6PSxnc4vOKKExKos7pXzHLrg==
X-Received: by 2002:a05:600c:4690:b0:46e:3dc2:ebac with SMTP id 5b1f17b1804b1-46fa9afbb62mr156259465e9.27.1760435233351;
        Tue, 14 Oct 2025 02:47:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb479c171sm230297745e9.0.2025.10.14.02.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:47:12 -0700 (PDT)
Message-ID: <2b9e0f15-6e4f-4510-91b6-8e4586e5f665@redhat.com>
Date: Tue, 14 Oct 2025 11:47:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Octeontx2-af: Fix missing error code in cgx_probe()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
References: <20251010204239.94237-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251010204239.94237-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/25 10:42 PM, Harshit Mogalapalli wrote:
> When CGX fails mapping to NIX, set the error code to -ENODEV, currently
> err is zero and that is treated as success path.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aLAdlCg2_Yv7Y-3h@stanley.mountain/
> Fixes: d280233fc866 ("Octeontx2-af: Fix NIX X2P calibration failures")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with smatch and only compile tested.
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index d374a4454836..ec0e11c77cbf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -1981,6 +1981,7 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	    !is_cgx_mapped_to_nix(pdev->subsystem_device, cgx->cgx_id)) {
>  		dev_notice(dev, "CGX %d not mapped to NIX, skipping probe\n",
>  			   cgx->cgx_id);
> +		err = -ENODEV;
>  		goto err_release_regions;
>  	}
>  

Side note, a few lines below there is this check:

	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
	if (err < 0 || err != nvec) {
		dev_err(dev, "Request for %d msix vectors failed, err %d\n",
			nvec, err);
		goto err_release_regions;
	}

AFAICS err can never be a positive value in that error path, but the

	if (err < 0 || err != nvec)

check is confusing and should possibly be changed to:

	if (err < 0)

/P


