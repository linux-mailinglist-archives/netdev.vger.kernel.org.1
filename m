Return-Path: <netdev+bounces-150418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFBF9EA2D9
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA9428241C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E85213E9F;
	Mon,  9 Dec 2024 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF8iZKfX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1F213E74;
	Mon,  9 Dec 2024 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787110; cv=none; b=I7EHsCZZwwRX9CpbHN8oMGFUEq6u3wuU6yiVrLXp1tWUuU1Y+d0l5NR2alnGwl/UXTM8H1rB+sL/CO3xN1OUbp6iszHEkXh+8yJDBitZfEPJidZwnxf9DNIoJopews/EupggyCI13d54u575A4qmfmlif+leUc9N1f1h8tYCrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787110; c=relaxed/simple;
	bh=HRolDNNh5VeZOal5KgaJ9BVFC0x7791FJx9OkRUx2+4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jht1ngsONJOr3pjPDZ34z2/bt7rJls78UfrvUOMK9c8GtnE+hpQ/ebzk1f25CMQ0z9HY0mltMdR/Mo3HsOUMoFOjh5wEKKMeUjMA3IkrUr/daI2JSjWDdkLrmucv/e/9dFH7xPO1JbYcrqMAn6atxbhk9NkA/4mAOLAT7IFgQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF8iZKfX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-435004228c0so7834175e9.0;
        Mon, 09 Dec 2024 15:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733787107; x=1734391907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVLiwDVnZDxng7E3/gp/oj68kLUn9l0CJrsxOcb2dBY=;
        b=bF8iZKfX9ikeOhYT4sVtxii9DWn7FP/m/ZBBVonLOK36+lGksW9flFhKYWayQCRIrG
         8rxqJ0J+IJHYMNRvq5ed7AQBFaoHdYuj2ZGlBSZ2N2UnetRVxof+k+OuHQOGZNGHy8+2
         hnbGBVOZpk0t/O9IVWumMM0bryIKihPrYgfeDUt6U7IOPlutrUSYXZjm9ObfRtpmqeKw
         VFsjUkL+m6BRsnYVwltiGoOupzhi+B+eXiQTtek8vSfNt5K/zjmkfmX76sgaR5giJZNa
         spkTdiP3rGoJl+Z15Edx6yCnwDNE1CWwnPimbyHkLeva5Fw0DhsVqsvEAIHywKNUbFtg
         LbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733787107; x=1734391907;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVLiwDVnZDxng7E3/gp/oj68kLUn9l0CJrsxOcb2dBY=;
        b=dXJrtNvYXif/gvj6PX5hzpSGHrqeM2BRB2O8WdXboBWmAj3+qKGian9zsUf6R7RHgR
         wGNa6WDVQqgnwhshbLkgr6KXkicPBPnss2crxZlsWEuG1CbERuCqFGeHaoatMnPBr76K
         jSjlkze58rWFl/lgSGT76doiJ9ikflErJmlM/WGxFuNDbkcgTC7ePCV3EHCvoon2YI0/
         Z/lb9CjPQLVf1tdrZdZMitoh1BZOXELUU80r1d435HIqKbTQvqMOBoxhdtRKeKKRR8AO
         lwsyt3JNex0SIgSQq3dNLiEidj7gPA5WQxmGDAx9I8rJ7Nw3ORQAOlW8YPorZ5fMibNw
         gOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU0XkhbN584q2HV8TGtmokYIvlbe9iUPOAWW60g0eCKycx/ywCHcsfCb+bKo1bUN9ghyk9jzSSxJk=@vger.kernel.org, AJvYcCXDmGomKRDnCwJWDOXYpe8Q/ebgT+hCox6oxt1XuuJFaSjjQiVZXatR843bdWtqySrX10dzDDuH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1f5slj982bKJETc5LqiDyZ8F0VkG4aqf22gneuJMTZttRwIaM
	Lwa98XzyIkfvBlQL+Nl94e2fbJ00fX4Lu6NoQSAei9Zr7da9Na/7
X-Gm-Gg: ASbGncsNP4PYiVMgcxM6bGQZlmuFZYDl67WQRb04rqwBqnQt9Rh5fn46SRUMYoVJQAU
	PFBWP+qZl2Vm//oSEisjmydSO6SxZ03oWU+44hB7TQY42BplNefXgSRksxee4N6ZVcaa/p4BuMg
	BYPUrq6siGU/de5oWqDgf6jnOupyKtBRZTJ+ThrejT8rTYpdekr1IpGXSAPRiuPxPzYns2aOQ4E
	EaeGuz1LOVUpmgnk38PFUHPvOsMAmwu24TfKUMcpmXv6Skfpe4cihS+558Cgtqi+7Iv5qGwnms/
	H0XzuvqJ2LaigAXqitRGIisDVT9A6588XJ/n6w9RFw==
X-Google-Smtp-Source: AGHT+IFzTlH+CAU74XXST/xc814mG6xMdkaj9e8cTpZJnmtljmbAe+ADD3sGW6SFXKjqyU90Nj78bQ==
X-Received: by 2002:a05:600c:474d:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-434fff9c611mr22258815e9.22.1733787106595;
        Mon, 09 Dec 2024 15:31:46 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0c9esm209622355e9.31.2024.12.09.15.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:31:46 -0800 (PST)
Subject: Re: [PATCH v7 14/28] sfc: create type2 cxl memdev
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-15-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <51a9b9a9-44b3-4185-d746-43b5a054bfcf@gmail.com>
Date: Mon, 9 Dec 2024 23:31:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209185429.54054-15-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl API for creating a cxl memory device using the type2
> cxl_dev_state struct.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

