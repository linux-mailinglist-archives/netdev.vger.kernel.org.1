Return-Path: <netdev+bounces-190153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0858AB554C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327671B465AB
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45128DEFB;
	Tue, 13 May 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="b9dadrd3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6528CF5F
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747140842; cv=none; b=IITB4RL2Dnn3SIG9myoy2qHbY1LY1dt37keleSOt+lIa1luMyXq6XaeFXP7C2wUXFwHT+g/f/3ZlB3vA0TGWA1C8aDu1gV0NB6vHKLKWnvCOst0rQnjonjhpSoFAGYsxuII4CCzz+s8Sif4xXHGCPbyJKylNqXGa1YRaFDCBbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747140842; c=relaxed/simple;
	bh=61QsAw2XyTAMFFUPxXjAKuoMWgUzcbZBAetnPwxPvQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHuZJOp7vWJz3pd/aohue1v+8PbRXpzoi5qXQnutjfTjYx7Jqv4Z1VUErnODA4jidiXBSbdBNY3M15AdJ5X3/OWflx/RrILxC4cZ/YJXNfaeRNjIOL8u2zzDmJdPmMqta9VL94qGztlM7Q1rj6AREQLuY8YOhwuP2WjxCvjF77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=b9dadrd3; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4774193fdffso98201131cf.1
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1747140838; x=1747745638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cda+1VCsMzH6i03hToOmFegl/BDqthHHpn1YesTrXKw=;
        b=b9dadrd3ydZZTFLj3fmQrcfFV3kk7TUaSCnhxWMwyveS3bdDvYTGD6HVIfrgksHWtS
         TzvnNMU7myNMoQvoMN1qqvinwXjP8hOcr8x4hcj+3SsRueh7ezdyn6Rz/lnTSTNrhYsp
         bHaIn/OMWAgGLKFcXmypSAfnEswrIaK56OECM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747140838; x=1747745638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cda+1VCsMzH6i03hToOmFegl/BDqthHHpn1YesTrXKw=;
        b=Ttci3pqA32jy0Z2g7nVc5gbrCFHSmQq9HdH304PKZs8JwsdMI2AqmAqw4NrrutSsFQ
         sRxzHuWp9Lz5I88X7kK+Oi1IvOvx1evyiX0fw+/+jE4RKF0vucIQL9qRjQTDmTGC4AdR
         BkWuGDHyR+iYIWZfwA+AidHedEyerICMZ7+CxteqNGtFSQlZTWWziOjB2/6f1mwkEDgp
         JNdmqK7E8xUezYXQzyuhSN1PKO0aL9eSxg+4DOeHN20gtcJ/NzZD3XggU9l8vWBl46EZ
         NgcxsroE1wGlUkY5DPCjkBZEXVMI9kRhxMB6HoxjWUgKLBY9ZzL7/yIHpOaj8j8gyp3G
         gvJw==
X-Forwarded-Encrypted: i=1; AJvYcCWX8fLIxNFuTEYNvSpqAeCIlgm3fabX57dCXeDCK2DTP7/CA1N8SYuJPHzUnaz9idw07/X5We8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJzMswKETiuTYgHe/EZPkHz8w0Iglpq21t8mWlN+fbvSGP8Lp
	ZKT6FoS9CTf2JQQkMSpVGyL8HKlGHdd/RoPW9yDMYJ6rQJyWUdvDqCZVL4soSg==
X-Gm-Gg: ASbGncuzBgY9du4XH1UGEUtusc8WuXJxIulYQn/WG8WyUagjgLaLnTB8qtfIije/rNA
	p2WgcJJCgXH3uP/CLIya1VPVB26rT3/LMTQlRSeyYy3tbdIstcsdwEgI581K1xcWMO80yvnrgSU
	gRQE2oAT/cgK9m32PHgrH4ufcsu3DK8U3Jp3NUY7ZSdtGJH2J7bj4+HwcDecByIJMLYu2LP7uid
	c8RKYU4GyrjZyasrftRdno6pt+PLKJIywGZ75xkUd41Z5T/DnX1SbUdYxqIygnxxQ7qJwNJ3+jw
	Pcj2rEXLB1plKMC2ZaBQTwBFyXSanjo1WOW5HI/nThrcnoEXz45klLKQFerK1kgDS7tEfajYWbb
	MmibdyPkiHw==
X-Google-Smtp-Source: AGHT+IGm6HMrODZVoZv4JlFipQU0EQD19XT+C5zYjggkgoKVsT7cs6zEg6SKqMl5nBWyitUfKskuIQ==
X-Received: by 2002:a05:622a:4a06:b0:494:6160:301e with SMTP id d75a77b69052e-4946160313dmr223153101cf.38.1747140837560;
        Tue, 13 May 2025 05:53:57 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-4945259fa2bsm64173671cf.76.2025.05.13.05.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 05:53:56 -0700 (PDT)
Message-ID: <c09105f0-17db-4179-be2e-cd96b7f282b7@ieee.org>
Date: Tue, 13 May 2025 07:53:54 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: Make the SMEM item ID constant
To: Konrad Dybcio <konradybcio@kernel.org>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Luca Weiss <luca@lucaweiss.eu>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250512-topic-ipa_smem-v1-1-302679514a0d@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250512-topic-ipa_smem-v1-1-302679514a0d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/25 1:07 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> It can't vary, stop storing the same magic number everywhere.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Good idea.

Reviewed-by: Alex Elder <elder@kernel.org>

> ---
>   drivers/net/ipa/data/ipa_data-v3.1.c   |  1 -
>   drivers/net/ipa/data/ipa_data-v3.5.1.c |  1 -
>   drivers/net/ipa/data/ipa_data-v4.11.c  |  1 -
>   drivers/net/ipa/data/ipa_data-v4.2.c   |  1 -
>   drivers/net/ipa/data/ipa_data-v4.5.c   |  1 -
>   drivers/net/ipa/data/ipa_data-v4.7.c   |  1 -
>   drivers/net/ipa/data/ipa_data-v4.9.c   |  1 -
>   drivers/net/ipa/data/ipa_data-v5.0.c   |  1 -
>   drivers/net/ipa/data/ipa_data-v5.5.c   |  1 -
>   drivers/net/ipa/ipa_data.h             |  2 --
>   drivers/net/ipa/ipa_mem.c              | 21 +++++++++++----------
>   11 files changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ipa/data/ipa_data-v3.1.c b/drivers/net/ipa/data/ipa_data-v3.1.c
> index e902d731776da784cdf312a301daefe54db1ef7f..65dba47291552dc8ef15fbb07e04d0510cb88e44 100644
> --- a/drivers/net/ipa/data/ipa_data-v3.1.c
> +++ b/drivers/net/ipa/data/ipa_data-v3.1.c
> @@ -493,7 +493,6 @@ static const struct ipa_mem_data ipa_mem_data = {
>   	.local		= ipa_mem_local_data,
>   	.imem_addr	= 0x146bd000,
>   	.imem_size	= 0x00002000,
> -	.smem_id	= 497,
>   	.smem_size	= 0x00002000,
>   };
>   
> diff --git a/drivers/net/ipa/data/ipa_data-v3.5.1.c b/drivers/net/ipa/data/ipa_data-v3.5.1.c
> index f632aab56f4c346e5cfc406034fce1b4b5cc67b3..315e617a8eebecd3a00d1eeed4b978db2f2ba251 100644
> --- a/drivers/net/ipa/data/ipa_data-v3.5.1.c
> +++ b/drivers/net/ipa/data/ipa_data-v3.5.1.c
> @@ -374,7 +374,6 @@ static const struct ipa_mem_data ipa_mem_data = {
>   	.local		= ipa_mem_local_data,
>   	.imem_addr	= 0x146bd000,
>   	.imem_size	= 0x00002000,
> -	.smem_id	= 497,
>   	.smem_size	= 0x00002000,
>   };
>   
> diff --git a/drivers/net/ipa/data/ipa_data-v4.11.c b/drivers/net/ipa/data/ipa_data-v4.11.c
> index c1428483ca34d91ad13e8875ff93ab639ee03ff8..f5d66779c2fb19464caa82bea28bf0a259394dc9 100644
> --- a/drivers/net/ipa/data/ipa_data-v4.11.c
> +++ b/drivers/net/ipa/data/ipa_data-v4.11.c
> @@ -367,7 +367,6 @@ static const struct ipa_mem_data ipa_mem_data = {
>   	.local		= ipa_mem_local_data,
>   	.imem_addr	= 0x146a8000,
>   	.imem_size	= 0x00002000,
> -	.smem_id	= 497,
>   	.smem_size	= 0x00009000,
>   };
>   
> diff --git a/drivers/net/ipa/data/ipa_data-v4.2.c b/drivers/net/ipa/data/ipa_data-v4.2.c
> index 2c7e8cb429b9c2048498fe8d86df55d490a1235d..f5ed5d745aeb19c770fc9f1955e29d26c26794e0 100644
> --- a/drivers/net/ipa/data/ipa_data-v4.2.c
> +++ b/drivers/net/ipa/data/ipa_data-v4.2.c
> @@ -340,7 +340,6 @@ static const struct ipa_mem_data ipa_mem_data = {
>   	.local		= ipa_mem_local_data,
>   	.imem_addr	= 0x146a8000,
>   	.imem_size	= 0x00002000,
> -	.smem_id	= 497,
>   	.smem_size	= 0x00002000,
>   };
>   
> diff --git a/drivers/net/ipa/data/ipa_data-v4.5.c b/drivers/net/ipa/data/ipa_data-v4.5.c
> index 57dc78c526b06c96439155f9c4133c575bdeb6ba..730d8c43a45c37250f3641ac2a4d578c6ad6414c 100644
> --- a/drivers/net/ipa/data/ipa_data-v4.5.c
> +++ b/drivers/net/ipa/data/ipa_data-v4.5.c
> @@ -418,7 +418,6 @@ static const struct ipa_mem_data ipa_mem_data = {
>   	.local		= ipa_mem_local_data,
>   	.imem_addr	= 0x14688000,
>   	.imem_size	= 0x00003000,
> -	.smem_id	= 497,
>   	.smem_size	= 0x00009000,
>   };
>   
> diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
> index 41f212209993f10fee338e28027739a7402d5089..5e1d9049c62bd7a451669b1f3941e10661e078eb 100644
> --- a/drivers/net/ipa/data/ipa_data-v4.7.c
> +++ b/drivers/net/ipa/data/ipa_data-v4.7.c
> @@ -360,7 +360,6 @@ static const struct ipa_mem_data ipa_mem_data = {
>   	.local		= ipa_mem_local_data,
>   	.imem_addr	= 0x146a8000,
>   	.imem_size	= 0x00002000,
> -	.smem_id	= 497,
>   	.smem_size	= 0x00009000,
>   };
>   
> diff --git a/drivers/net/ipa/data/ipa_data-v4.9.c b/drivers/net/ipa/data/ipa_data-v4.9.c
> index 4eb9c909d5b3fa813b800e9d16ca7d0d73651f2e..da472a2a2e2914ccb026654ccbaf8ffaf5a6d4f4 100644
> --- a/drivers/net/ipa/data/ipa_data-v4.9.c
> +++ b/drivers/net/ipa/data/ipa_data-v4.9.c
> @@ -416,7 +416,6 @@ static const struct ipa_mem_data ipa_mem_data = {
>   	.local		= ipa_mem_local_data,
>   	.imem_addr	= 0x146bd000,
>   	.imem_size	= 0x00002000,
> -	.smem_id	= 497,
>   	.smem_size	= 0x00009000,
>   };
>   
> diff --git a/drivers/net/ipa/data/ipa_data-v5.0.c b/drivers/net/ipa/data/ipa_data-v5.0.c
> index 050580c99b65cf178bcd5e90ef832d2288a1a803..bc5722e4b053114621c099273782cdc694098934 100644
> --- a/drivers/net/ipa/data/ipa_data-v5.0.c
> +++ b/drivers/net/ipa/data/ipa_data-v5.0.c
> @@ -442,7 +442,6 @@ static const struct ipa_mem_data ipa_mem_data = {
>   	.local		= ipa_mem_local_data,
>   	.imem_addr	= 0x14688000,
>   	.imem_size	= 0x00003000,
> -	.smem_id	= 497,
>   	.smem_size	= 0x00009000,
>   };
>   
> diff --git a/drivers/net/ipa/data/ipa_data-v5.5.c b/drivers/net/ipa/data/ipa_data-v5.5.c
> index 0e6663e225333c1ffa67fa324bf430172789fd0c..741ae21d9d78520466f4994b68109e0c07409c1d 100644
> --- a/drivers/net/ipa/data/ipa_data-v5.5.c
> +++ b/drivers/net/ipa/data/ipa_data-v5.5.c
> @@ -448,7 +448,6 @@ static const struct ipa_mem_data ipa_mem_data = {
>   	.local		= ipa_mem_local_data,
>   	.imem_addr	= 0x14688000,
>   	.imem_size	= 0x00002000,
> -	.smem_id	= 497,
>   	.smem_size	= 0x0000b000,
>   };
>   
> diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
> index d88cbbbf18b749e22bb09b472dcfa59d44a9dca4..2fd03f0799b207833f9f2b421ce043534720d718 100644
> --- a/drivers/net/ipa/ipa_data.h
> +++ b/drivers/net/ipa/ipa_data.h
> @@ -180,7 +180,6 @@ struct ipa_resource_data {
>    * @local:		array of IPA-local memory region descriptors
>    * @imem_addr:		physical address of IPA region within IMEM
>    * @imem_size:		size in bytes of IPA IMEM region
> - * @smem_id:		item identifier for IPA region within SMEM memory
>    * @smem_size:		size in bytes of the IPA SMEM region
>    */
>   struct ipa_mem_data {
> @@ -188,7 +187,6 @@ struct ipa_mem_data {
>   	const struct ipa_mem *local;
>   	u32 imem_addr;
>   	u32 imem_size;
> -	u32 smem_id;
>   	u32 smem_size;
>   };
>   
> diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
> index dee985eb08cba29d5d7d6418ed6c187ce3d2fb5d..835a3c9c1fd47167da3396424a1653ebcae81d40 100644
> --- a/drivers/net/ipa/ipa_mem.c
> +++ b/drivers/net/ipa/ipa_mem.c
> @@ -26,6 +26,8 @@
>   /* SMEM host id representing the modem. */
>   #define QCOM_SMEM_HOST_MODEM	1
>   
> +#define SMEM_IPA_FILTER_TABLE	497
> +
>   const struct ipa_mem *ipa_mem_find(struct ipa *ipa, enum ipa_mem_id mem_id)
>   {
>   	u32 i;
> @@ -509,7 +511,6 @@ static void ipa_imem_exit(struct ipa *ipa)
>   /**
>    * ipa_smem_init() - Initialize SMEM memory used by the IPA
>    * @ipa:	IPA pointer
> - * @item:	Item ID of SMEM memory
>    * @size:	Size (bytes) of SMEM memory region
>    *
>    * SMEM is a managed block of shared DRAM, from which numbered "items"
> @@ -523,7 +524,7 @@ static void ipa_imem_exit(struct ipa *ipa)
>    *
>    * Note: @size and the item address are is not guaranteed to be page-aligned.
>    */
> -static int ipa_smem_init(struct ipa *ipa, u32 item, size_t size)
> +static int ipa_smem_init(struct ipa *ipa, size_t size)
>   {
>   	struct device *dev = ipa->dev;
>   	struct iommu_domain *domain;
> @@ -545,25 +546,25 @@ static int ipa_smem_init(struct ipa *ipa, u32 item, size_t size)
>   	 * The item might have already been allocated, in which case we
>   	 * use it unless the size isn't what we expect.
>   	 */
> -	ret = qcom_smem_alloc(QCOM_SMEM_HOST_MODEM, item, size);
> +	ret = qcom_smem_alloc(QCOM_SMEM_HOST_MODEM, SMEM_IPA_FILTER_TABLE, size);
>   	if (ret && ret != -EEXIST) {
> -		dev_err(dev, "error %d allocating size %zu SMEM item %u\n",
> -			ret, size, item);
> +		dev_err(dev, "error %d allocating size %zu SMEM item\n",
> +			ret, size);
>   		return ret;
>   	}
>   
>   	/* Now get the address of the SMEM memory region */
> -	virt = qcom_smem_get(QCOM_SMEM_HOST_MODEM, item, &actual);
> +	virt = qcom_smem_get(QCOM_SMEM_HOST_MODEM, SMEM_IPA_FILTER_TABLE, &actual);
>   	if (IS_ERR(virt)) {
>   		ret = PTR_ERR(virt);
> -		dev_err(dev, "error %d getting SMEM item %u\n", ret, item);
> +		dev_err(dev, "error %d getting SMEM item\n", ret);
>   		return ret;
>   	}
>   
>   	/* In case the region was already allocated, verify the size */
>   	if (ret && actual != size) {
> -		dev_err(dev, "SMEM item %u has size %zu, expected %zu\n",
> -			item, actual, size);
> +		dev_err(dev, "SMEM item has size %zu, expected %zu\n",
> +			actual, size);
>   		return -EINVAL;
>   	}
>   
> @@ -659,7 +660,7 @@ int ipa_mem_init(struct ipa *ipa, struct platform_device *pdev,
>   	if (ret)
>   		goto err_unmap;
>   
> -	ret = ipa_smem_init(ipa, mem_data->smem_id, mem_data->smem_size);
> +	ret = ipa_smem_init(ipa, mem_data->smem_size);
>   	if (ret)
>   		goto err_imem_exit;
>   
> 
> ---
> base-commit: edef457004774e598fc4c1b7d1d4f0bcd9d0bb30
> change-id: 20250512-topic-ipa_smem-cee4c5bad903
> 
> Best regards,


