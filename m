Return-Path: <netdev+bounces-228337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EB6BC81DE
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 10:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60943AB6B0
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 08:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABA728D83F;
	Thu,  9 Oct 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKnOn2ez"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFC38D
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999634; cv=none; b=LAex2co30LkRcqeMWhwt9SKPftyWQfe99ztpOm5bcfCZ3U/8kMqusxzhtweAf8bg9d7LBUoIdFM3UqcsxafNm1Tue5AZ18383l0qtNpKXoPKmy4TpOTZbJl2GQPes4CwHfELIt0QfTxLSI1CdUZJ7linxzDilx/FDLQQ7MUemLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999634; c=relaxed/simple;
	bh=i0+auL9WZo6acyK3t9ckGl7eYBZ0eEV4fO/V99agg+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2THF7azP4paMWmzmhhkQBISYlp077y0kzRg1SW1Qcj99qMltcIQXSU3n5H50We6rUg/PrVR2WoZOhhJHYVkbKqrE58gayixtbblflus3giMoaR9lt7dv/VODPGuIhUr+tppLMKo5YhUCibcqS/fY1OzMzbqBHxwXPGevx2/AsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKnOn2ez; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759999632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYPSmMLiVE1vRxaqysXPxWnvNjdPRDnGzEaVSJvhD+4=;
	b=ZKnOn2ezv96K4dYWifOB6Qo5c8paXEK5UJHD+JoQdOr+RWyeoiIcuAlktWBfP59AP7Q3M7
	eNSgMbYMDkv86v53f6P9RuWFl5P7qZEzjDLZ6maTe9YEPATQZVqpHjOdTLe7iYe294CO5E
	1J1M7WzZ31vvw3+Vu1zGqgCvG2HnwNY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-gpYitfOEMYmQBkYaONlY3Q-1; Thu, 09 Oct 2025 04:47:10 -0400
X-MC-Unique: gpYitfOEMYmQBkYaONlY3Q-1
X-Mimecast-MFC-AGG-ID: gpYitfOEMYmQBkYaONlY3Q_1759999629
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e3d9bf9e1so3909795e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 01:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999629; x=1760604429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYPSmMLiVE1vRxaqysXPxWnvNjdPRDnGzEaVSJvhD+4=;
        b=g6mjESAcLQIn9AfTPnQ37toCuRv0CjfOWi1YuE1yXoBC+qdzkDS/29PY9m2RhwY07U
         Z28CerV5zBnwZKqEHzRSC35ORrRbE1jXC/AGsuS2A75Li9e3KAneSaKIHmhpW04HwsN4
         wAp8MVgfNuH8caG4EFWGVbdN1pZyBSwuDOtVXaxZrOjF07cWThc45cZEibUO0nRJZfBm
         lj/dDvoSn4lJgC4c+XE3WGv+qVbyYtQF7lZy6tGN5/AIzSVl8ujmRjQELrZPW13GlcXG
         8kfbVWLTfGcnExP+jH6DCxxowtscXXdK9FtjJn+yjXFW+gZE//OpDtY1cDFFqr/xE/iu
         UM4A==
X-Forwarded-Encrypted: i=1; AJvYcCWkFNpmu1u9HulQtuUwXlQYzSxTEOWcFQrFcaTtPSifX3F3TY9bqa+6N/G7K0WMT7WJWhQ8hMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ305bbZHAX0Ma13UZ/kXVxyVTVtBgEuPCIgL0aA69LL+PDIIm
	gwhq8xe66f2iEWFyzPdUp/pTSklCYq8qUSC4RB+gUvuxIDRqWDOMc9vTaAnNVXGnPmnsvulJWH6
	7EiSLfvLaGPALh7/K9mTRaYy7wqJirEs5aUPtjF1XQJsNbgjU26dDynWFvg==
X-Gm-Gg: ASbGncv/u/kOK7dDJ9jAfK4Vdd2jna3VHthqIcEDQD5wuTozNjXpUNXrNNUAkbO+KYR
	MrBzZsEoksPVWAmcKMY0jn4iKROxLnnd3kLj2w7DA2yIIl+JUXVyurIC8LR1UZ0hirSSydd50fP
	JWscZRln3TeGvCXKRNLN4MtMNJ11OCtLZVz1dYt7dOiKMXHWwKIiuyNn2pbZRQk/u+pqkvthlwn
	PzRi3xgWFsOLV2GoFBZmJFDn2lkHIQwtdY3YgsGnBbp6/KFVrnROBhsAjYZY2aMQe/zX+xwM3Wk
	JAkEtsyHJWRLpKvuug7AA61VWr7chg//PXg9Ill0yRyfvDdriPDV6nNEP/FXqPvc3Aq2N7O4OiA
	1miOZ7FipAU0kKYcPbA==
X-Received: by 2002:a05:600c:4745:b0:46d:45e:3514 with SMTP id 5b1f17b1804b1-46fa9af3045mr47067815e9.17.1759999629040;
        Thu, 09 Oct 2025 01:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhyHsRVdtzI7WBZXfSp8UYaDtELObmhEsuzOkOpCP2sIgluT2oVR/QZMswp1CBbHoakmRFPw==
X-Received: by 2002:a05:600c:4745:b0:46d:45e:3514 with SMTP id 5b1f17b1804b1-46fa9af3045mr47067645e9.17.1759999628643;
        Thu, 09 Oct 2025 01:47:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf16acc5sm41338355e9.10.2025.10.09.01.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 01:47:08 -0700 (PDT)
Message-ID: <a756f384-33c2-4c21-a23a-9223823f296b@redhat.com>
Date: Thu, 9 Oct 2025 10:47:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: cxgb4/ch_ipsec: fix potential use-after-free
 in ch_ipsec_xfrm_add_state() callback
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Ayush Sawal <ayush.sawal@chelsio.com>,
 Harsh Jain <harsh@chelsio.com>, Atul Gupta <atul.gupta@chelsio.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Ganesh Goudar <ganeshgr@chelsio.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251006134726.1232320-1-Pavel.Zhigulin@kaspersky.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251006134726.1232320-1-Pavel.Zhigulin@kaspersky.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 3:47 PM, Pavel Zhigulin wrote:
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
> index ecd9a0bd5e18..29dbc3b6e9e2 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
> @@ -301,7 +301,8 @@ static int ch_ipsec_xfrm_add_state(struct net_device *dev,
>  		sa_entry->esn = 1;
>  	ch_ipsec_setkey(x, sa_entry);
>  	x->xso.offload_handle = (unsigned long)sa_entry;
> -	try_module_get(THIS_MODULE);
> +	if (unlikely(!try_module_get(THIS_MODULE)))
> +		res = -ENODEV;

Here ch_ipsec_xfrm_add_state() had just successfully added a new entry,
but still return failures, which looks inconsistent and possibly cause
more serious negative side effect. I think you should move the module
check before the sa_entry creation.

Thanks,

Paolo


