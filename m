Return-Path: <netdev+bounces-175634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E54DA66F96
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41493AA6EE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893F1FFC45;
	Tue, 18 Mar 2025 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fh8My5D6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CA146D6A
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289773; cv=none; b=dsENACenfGkygLoTJhp/vFPxxGfX37taQ8ygH+e3G4Lu21cRLM0rRvhSp9XRcBuGtAtLVQTRIgjwHzx0i7X9pqmrVmMP0MTNJEr5o3YFEQY5SS2/IOc3IJfOdBY7iP/B21rTzqiFyqPEEktldrgGl7pEbUhhAjhuY/uDdC2Yjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289773; c=relaxed/simple;
	bh=7Gl9i8J4SEjmDM9/80KebifgIGltyYp4A/mt9kqlwYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KithbPClKGmGH3XWtKRhaR7bJ3pnkak9TL1hB20vG4bEH/CbXUJKESOJ8SPu8nycFOmhMcT6K1nAGC8jinhjpm4VEGdN+MNe0QfOvyIX8MpZjB4FB1lmkzEVWIj0FyJYcwDEFb+5De7o2wZHTpEhC1XlsppRdefttzk4hDXguW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fh8My5D6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742289770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNWv137gtxUwCNL8E8e40OFade2LcpayUoQOPI9K41A=;
	b=fh8My5D6Z0NZOqw8pD5bmP7BV+m5wYryazqYan4m7GR7rFTahqqbq4E+Jwf8LRV1eKGhPF
	6APojzT4KX4R0SdebWWRFvapKOjTdAX1J3F4FJd0ikUqGEIA7XAgzZ0tx40Ss92+IiEBZR
	D8iiL13qoo0Ov3HH+5ZUkzaz8rqhZuQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-WaBozszOOza1dl7bjCs1Xw-1; Tue, 18 Mar 2025 05:22:49 -0400
X-MC-Unique: WaBozszOOza1dl7bjCs1Xw-1
X-Mimecast-MFC-AGG-ID: WaBozszOOza1dl7bjCs1Xw_1742289767
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-549adfc38daso3329054e87.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 02:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742289766; x=1742894566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNWv137gtxUwCNL8E8e40OFade2LcpayUoQOPI9K41A=;
        b=QnDB8kCT7eCeCyZ0aI6NJbCk8UfZ/F/3/pE1J3qRmJtrM19gao2iI6zag1mw8GZle/
         NysPOMPBTJSrVL4pZRnnVvCM8LYaq+aXbOT3gSxd/KqXQSvm57P5SXwI9dsEa8aVKmEC
         EFGpBSZMfKW2zUAphEipTzROtz4iOBjGXshEqbvOnGXXLNrq//Af1f7OPQrN8C3w+dHb
         695ZLn/PvQp0efWcSQWxjTN/y1ZD2BkwZMUBldQd9v1RWM8lDHd+pp/zGQZdX1gyTgp3
         KEQXFWuxb5vdYfAGJqMegKY1NUoOUSobvZ8mBsmOnDGR1eVsjMdsh9Qo+cUlYnV1q/+I
         pr6g==
X-Gm-Message-State: AOJu0Yxn2judvUzE2FSFosraiZ1b7oyLgHxRzpcyCigErslWnPZajERx
	MmJQr5g6mHIVkOWfHLJ0sg2dy29WXCSHzH/zS4dF8tv4RgvRTd2hxnCMYrZFmtLul+C+sfPmE2C
	bSgO0SuMM3cn+d97WuPUL8jUZmBjzPtBxqCJqNbr4HYv6Onhd0F0HHNOvtyN/+g==
X-Gm-Gg: ASbGncswjKq2ZXrOaSxFUkITWKiPf3yw0X6JaJSaC5bC3e+VijqmrE3fesqaIWklEew
	qWd27VX8GwJi0iXv2KeRNTjQYuNX776L5kJcCnfRM1cE4GmwnHpdquCWAYIB8N+T06yY76gFU1t
	b204f+PawybmbbDjjeUYkm5FDNJXMsz7o6TqsxogvqyRliuYGHfBeqRc+er+zjP3PPjZMqymDOa
	0ElyP3pOPRmSa7bS9CoCnx6WepjpWqMhlPomp5dZzjsoZGjRcYXozoDW3cY096zENqX1aVFWN3S
	ZoqEazVdNwyJj/opvuUGlhN8i9gi9Hk28uR+9/RNsfgv9w==
X-Received: by 2002:a05:6512:31d2:b0:549:7145:5d2d with SMTP id 2adb3069b0e04-54a30680dc7mr2139361e87.16.1742289766038;
        Tue, 18 Mar 2025 02:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv/gpmam++lHaHNIEMleX8HzN0Ik5B2IB9fg6o1NDJpDqw6kNf3PEojKDs0nSom45dx8Et6Q==
X-Received: by 2002:a05:6512:31d2:b0:549:7145:5d2d with SMTP id 2adb3069b0e04-54a30680dc7mr2139353e87.16.1742289765596;
        Tue, 18 Mar 2025 02:22:45 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a8c46sm1580585e87.235.2025.03.18.02.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:22:45 -0700 (PDT)
Message-ID: <17915ef1-d118-4e93-a46e-b63968aaa49b@redhat.com>
Date: Tue, 18 Mar 2025 10:22:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/7] bnxt_en: Add devlink support for ENABLE_ROCE
 nvm parameter
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Jiri Pirko <jiri@resnulli.us>
References: <20250310183129.3154117-1-michael.chan@broadcom.com>
 <20250310183129.3154117-4-michael.chan@broadcom.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250310183129.3154117-4-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 7:31 PM, Michael Chan wrote:
> @@ -1128,6 +1130,32 @@ static int bnxt_dl_nvm_param_set(struct devlink *dl, u32 id,
>  	return bnxt_hwrm_nvm_req(bp, id, req, &ctx->val);
>  }
>  
> +static int bnxt_dl_roce_validate(struct devlink *dl, u32 id,
> +				 union devlink_param_value val,
> +				 struct netlink_ext_ack *extack)
> +{
> +	const struct bnxt_dl_nvm_param nvm_roce_cap = {0, NVM_OFF_RDMA_CAPABLE,
> +		BNXT_NVM_SHARED_CFG, 1, 1};
> +	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
> +	struct hwrm_nvm_get_variable_input *req;
> +	union devlink_param_value roce_cap;
> +	int rc;
> +
> +	rc = hwrm_req_init(bp, req, HWRM_NVM_GET_VARIABLE);
> +	if (rc)
> +		return rc;

Not blocking this series, but I'm wondering: any special reason to not
fill the extack here? Could possibly be a small follow-up.

Thanks,

Paolo


