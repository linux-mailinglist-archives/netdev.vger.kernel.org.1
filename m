Return-Path: <netdev+bounces-172409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C844A547D1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BA43AE8FD
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB87204879;
	Thu,  6 Mar 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/QMl7xt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B471C84B9
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257162; cv=none; b=tA0+VaXMRrPFFeVcXTR64TIXvq2tXP3QZJ/rod4VDeWqsTtoWoQBTGwCtWIPgGOcrt6CoZPukWfu/YkHymMDEkZ17BnIWOocONkIAZ9xW/co+ccRHOVAOFbsE1+iFzkTB1tNoKNbLEdNVDnsYQhM+ucqcNQGonwuGKr8vP3pV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257162; c=relaxed/simple;
	bh=IGVAuJkuiiv0B8e7SlGUhgx4yCx9vKQqqr7RUi5IhrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NX62/eusBfLCQtTv0EYQ8c9Oad+6gW8rLkhLvRbNdsevTHs8a0wtgtxTKjytaPkybnG+37x5hcAwX6kUd6Rf0SX4+duJkwFiIFJjqoNJ4Tx7LVibdUey6IeteLbDJM6NVuKXspQBPgUWciEZFo+qdiEJ1Qy3ZnjLGvy9zpXsvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/QMl7xt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741257159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMqW1t44N97ihf+A97Lk88vZ7a/tf/Mv4rMOKlQe5oc=;
	b=G/QMl7xtkYT5riY8ftoyDCywY32cv4DLo0wwMnMtibR9BDxrSg+joQAd+Y1/EJf6Ad0CHM
	olffo73IosagJ2MO6mXkBEKoBIWrtRZbLVZmNv83MfmecKviPWeCoIHcHWvCjBIqUkF9HG
	YmhCQRpbwjw+4wA/Z4HGY27ppE44ZF8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-4HNzw6YfOvKYuJ34IwN7eg-1; Thu, 06 Mar 2025 05:32:15 -0500
X-MC-Unique: 4HNzw6YfOvKYuJ34IwN7eg-1
X-Mimecast-MFC-AGG-ID: 4HNzw6YfOvKYuJ34IwN7eg_1741257135
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394c489babso2143995e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 02:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257135; x=1741861935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMqW1t44N97ihf+A97Lk88vZ7a/tf/Mv4rMOKlQe5oc=;
        b=i/FyeZhf7iErEf3BcIW9E9gcPoRvkrowONMQuq0MQS6b/7vxURpDFDIjPGbfpC89lF
         byBhfpW0mv6jH4CVAJNvC1rcnLnaj0dB6MhPo/O+DOZIKn/bONW4hO2jbfbdBgWJg7Nb
         F/0VuWmFll9M34zD0V0PEOrPAahNnsC9qyRnjPrqystVeAaqIoCUmplLze4CwHbI5Evi
         bj2sQIHrZk/+jHdHxFcCXztOBzpnrMXghDl2rpTcxMrCH9OjwTSS2etWV+E4tVT3E3xs
         X0+A9v8RZ31d56Qtiul92U6sd5Y8GTYGyDvF682x823SOWacW1xrX9IJKpS0apKbetgx
         uT1g==
X-Gm-Message-State: AOJu0YzQ6PSjDWS/kbuf0f6epjCXvOTYNOX1+xytC47BsI900odXZkVA
	nGdbsfiUQHA3EailPUW9SxYUTSBkek6LdrDkVvBJo3CJlqlJLSmKO4L+qGX1oyrRHaeFiFUoIvX
	+8A29xTme0GCHDQcFpJgLCTKkkDNxRvnY0OlSKqXc/xUCblNlFNoocg==
X-Gm-Gg: ASbGncvR6grXUMXo1s5r3puMg+ZS9tSEvenBsDNfDuscmGWMC1g6OhqfInF5+Ws0ZvX
	Z5ahqIBTj/UZGD3Ywswvl/5VRapFI0wRT71NY5FNKX5sSXG2CQr7pPGt0JBY83eIsQ/RTKLjFEy
	YO/9WzxO7IIItYvCId7HJNJMn6/MYNIvOypir1TI0d+niueNAAlWHx2ir+sj54aSbFdPiM/0I18
	ux5ow3itgijmEDmSwDnaFqlP2fPDCVL2dCrGPG7h7kmAScvCtd00LqmxMYrlQhLua1x9UmCI/wk
	A5/9gUNVXnXXTUkatSFPunwEbIRm3fr0HiZwsjDZLMBu6g==
X-Received: by 2002:a05:600c:4e8d:b0:439:930a:58aa with SMTP id 5b1f17b1804b1-43bd28a73f2mr56130465e9.0.1741257133395;
        Thu, 06 Mar 2025 02:32:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjneL1v6mm7CN1Ta5I26BcghZEUJFnb1sJCU6KoCgTgUbp+nI7Nhqiox0FcMr5Gc2xWIH6mA==
X-Received: by 2002:a05:600c:4e8d:b0:439:930a:58aa with SMTP id 5b1f17b1804b1-43bd28a73f2mr56128875e9.0.1741257130527;
        Thu, 06 Mar 2025 02:32:10 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba888sm1639761f8f.16.2025.03.06.02.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:32:10 -0800 (PST)
Message-ID: <8ec75d7c-0fcf-4f7f-9505-31ec3dae4bdd@redhat.com>
Date: Thu, 6 Mar 2025 11:32:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qlcnic: fix a memory leak in
 qlcnic_sriov_set_guest_vlan_mode()
To: Haoxiang Li <haoxiang_li2024@163.com>, shshaikh@marvell.com,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 rajesh.borundia@qlogic.com, sucheta.chakraborty@qlogic.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250305100950.4001113-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250305100950.4001113-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/25 11:09 AM, Haoxiang Li wrote:
> Add qlcnic_sriov_free_vlans() to free the memory allocated by
> qlcnic_sriov_alloc_vlans() if qlcnic_sriov_alloc_vlans() fails
> or "sriov->allowed_vlans" fails to be allocated.
> 
> Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Add qlcnic_sriov_free_vlans() if qlcnic_sriov_alloc_vlans() fails.
> - Modify the patch description.
> vf_info was allocated by kcalloc, no need to do more checks cause
> kfree(NULL) is safe. Thanks, Paolo! 
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
> index f9dd50152b1e..0dd9d7cb1de9 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
> @@ -446,16 +446,20 @@ static int qlcnic_sriov_set_guest_vlan_mode(struct qlcnic_adapter *adapter,
>  		 sriov->num_allowed_vlans);
>  
>  	ret = qlcnic_sriov_alloc_vlans(adapter);
> -	if (ret)
> +	if (ret) {
> +		qlcnic_sriov_free_vlans(adapter);

I'm sorry for the lack of clarity in my previous reply. I think it would
be better to do this cleanup inside qlcnic_sriov_alloc_vlans(), so that
on error it returns with no vlan allocated.

There is another caller of qlcnic_sriov_alloc_vlans() which AFAICS still
leak memory on error. Handling the deallocation in
qlcnic_sriov_alloc_vlans() will address even that caller.

Thanks,

Paolo


