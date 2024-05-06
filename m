Return-Path: <netdev+bounces-93554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0D08BC4EC
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24CE1F21125
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 00:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4156116;
	Mon,  6 May 2024 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="13OQW5I5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975442904
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 00:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956134; cv=none; b=hIGgc72YQYOwl+YkK2nED37ICmX+RCywwwLKU7xq4UvL++Jfpp9aWEYRp2VlBBzbceNn+p3YApsFK1XFvfbJ7IL/SX+cSN3M1gHdDMzrGdL6Bf7U1S+nCm1aEj8llqugY7F6ggxtcqVuZqJbfbtoAsu+0nwPzGVqHc83AEPknKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956134; c=relaxed/simple;
	bh=IGr0hTwkEN9idneoSwmei7n35yNoPlFoXAhz9kGkTUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsylfMuONGDUqkyFYgtLlp9+Zba3m82Z8EMuSvmnrT1L4p5VqOc30WoC/+dyy31Qdjjfy1//MLAPoPPnLud0cfyeg9SDV1MbiBdtadmWqW7nswAC3uQS6VYsjWw84YGocqlVAVm6bdUYzEbPdeCUS9Z1COSml8fdIZkSk4mvVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=13OQW5I5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f447976de7so866953b3a.1
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 17:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714956133; x=1715560933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjjSF/SVJpJQ6ltMa4a2TpkGb0zelasblXCxP0mNVrw=;
        b=13OQW5I5Gof0Qu7HNuqg7aysDXBrFPpVAY6pFZJA/tKbHFB0Z+7HnxCjs+HakAg/hM
         dJWIp1hG4lwTlz5kAbyD7oHJnNfwvt5HwJ8zj7m8yCiS6KaSpicTZSr1LeSjP40j+eWN
         b20aBZuE33hbMHH5jQLA2wu3Oo/Psn/+Rr5lNd3pnD2DNIPQOz4YrGBtuIMiYYbC2F5P
         FwcNSYVXd3BR3Kb4dHLCuKyd6l/0NNtZqLFdpsCJo2t3jjIQRwRu+3LT5upKPnlcxOQl
         XWZk1DsNyYzd8Gj3L8UymjqziMqk71NCZ5VNWDh7Z9TxvPoIGLNLXwOHfpVAVaPVOZ+w
         4GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956133; x=1715560933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjjSF/SVJpJQ6ltMa4a2TpkGb0zelasblXCxP0mNVrw=;
        b=fbisfW+mQTYnCQcyAhrvIcgSn33o4IfrNxRKpZa2YECo4Ot+kk4hDqKpysIV4O/WVf
         2Cw3f9UhsY9CIGo6xGdf+HX5jNhZtfiEXeUoTiTfSXagZ1lG+Oo3Kjdyinj1l1r/80Pc
         LKvzKjsK4UyUTzYcBkYO/mG1TowQeI0kCuJnqnNmxUnEky/I6S2ms65oOIqVVAakvIHj
         dcjSEVgeSwkzg/wdXjPTTftXhQjGFFrh9sge3jnksFYwFurnA1VENXLz/quPXBcKpEN1
         qCnPjzC0Fr9mtNZtpthlaJVobRnjYNvmlThQI02FWIVEDXNWke6jRQqwCsIqHWEZMvS2
         S+jg==
X-Gm-Message-State: AOJu0YzjXlXmrL39vWMjxAHJIs45xVxtOsCvRkLzexGH0JVmZdEFTNzW
	SCxG72HvMqLPjlALA0af1uPng8QOMlfKGjyC/8jBQRxqo8a2JiJsRFpgStmPNzE=
X-Google-Smtp-Source: AGHT+IHYh3rC2dgNj+BKsbIzYBGI17hzFkIykLE6YSmR7+z2X/lprWqjzqmjWFbMu8fmcHLOiQxR9w==
X-Received: by 2002:a05:6a00:3d46:b0:6ed:2f53:8059 with SMTP id lp6-20020a056a003d4600b006ed2f538059mr9820525pfb.34.1714956132742;
        Sun, 05 May 2024 17:42:12 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id fx13-20020a056a00820d00b006e66a76d877sm6555893pfb.153.2024.05.05.17.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 17:42:12 -0700 (PDT)
Message-ID: <bc56b9e8-73ea-448c-b006-c9b5b73940ca@davidwei.uk>
Date: Sun, 5 May 2024 17:42:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 7/9] bnxt: add helpers for allocating rx
 ring mem
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Mina Almasry <almasrymina@google.com>, Shailend Chand <shailend@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240502045410.3524155-1-dw@davidwei.uk>
 <20240502045410.3524155-8-dw@davidwei.uk>
 <20240504123432.GI3167983@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240504123432.GI3167983@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-04 05:34, Simon Horman wrote:
> On Wed, May 01, 2024 at 09:54:08PM -0700, David Wei wrote:
>> Add several helper functions for allocating rx ring memory. These are
>> mostly taken from existing functions, but with unnecessary bits stripped
>> out such that only allocations are done.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 87 +++++++++++++++++++++++
>>  1 file changed, 87 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index b0a8d14b7319..21c1a7cb70ab 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -14845,6 +14845,93 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
>>  	.get_base_stats		= bnxt_get_base_stats,
>>  };
>>  
>> +static int __bnxt_alloc_rx_desc_ring(struct pci_dev *pdev, struct bnxt_ring_mem_info *rmem)
>> +{
>> +	int i, rc;
>> +
>> +	for (i = 0; i < rmem->nr_pages; i++) {
>> +		rmem->pg_arr[i] = dma_alloc_coherent(&pdev->dev,
>> +						     rmem->page_size,
>> +						     &rmem->dma_arr[i],
>> +						     GFP_KERNEL);
>> +		if (!rmem->pg_arr[i]) {
>> +			rc = -ENOMEM;
>> +			goto err_free;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +err_free:
>> +	while (i--) {
>> +		dma_free_coherent(&pdev->dev, rmem->page_size,
>> +				  rmem->pg_arr[i], rmem->dma_arr[i]);
>> +		rmem->pg_arr[i] = NULL;
>> +	}
>> +	return rc;
>> +}
>> +
>> +static int bnxt_alloc_rx_ring_struct(struct bnxt *bp, struct bnxt_ring_struct *ring)
> 
> Hi David,
> 
> W=1 builds fail because this and other functions introduced by
> this patch are unused. I agree that it is nice to split up changes
> into discrete patches. But in this case the change isn't really discrete.
> So perhaps it is best to add helper functions in the same patch
> where they are first used.

Okay, I'll squash it with the patch that uses these functions. Thanks.

