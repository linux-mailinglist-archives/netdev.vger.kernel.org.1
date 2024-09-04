Return-Path: <netdev+bounces-125174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FBE96C2BC
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A636B2819BC
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9761DEFDA;
	Wed,  4 Sep 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO/SZRhc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A571DB55A;
	Wed,  4 Sep 2024 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464673; cv=none; b=leQDNMUMWDXVgNMGD9VBWU1LXZKxY28O4QKYw7eWf/9v2H88aCXItY4mh3AdXJue5XwBwoOxsLyH4++OOlR7pXoMuMaQ7xKe9yuSaU/ns0KB5jO6h8epaBAT9fVENQL8Hncd32lf7JGEbOH6CgeToxgkAsauY+Bvv/Fb3claZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464673; c=relaxed/simple;
	bh=OnxPN/+AbrFrxcLgrBGr7w5CtUTVTvAlqoV+BjHQDZg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Gx5qkFC8DZ9nvrMZZnPpucR+co+Dxy0ibt0XU6RGLbwlb0oqib0QIHS7dX2dlL8DSny2obuvpPCA4kuLddynwiSWvVqzeGuWHna8BMbXFapYqTt8MaWNo1imMQUu3yreGxd46dAKL7msxN5HuBG0ZS2pHJLsP6Je8l+YLaK9dSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO/SZRhc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c3400367so3054838f8f.2;
        Wed, 04 Sep 2024 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725464670; x=1726069470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0/m9gfxAidcZmmSBa07F5tUNXyuTt8w6eXaConl8Dg=;
        b=GO/SZRhcla9tWe25LJkM7IPBfXPmkbR2AyQu9WJKlEUMcMrBYOk86No+kYEWS8pSp7
         LuCsswxR/QZAWDcRt+M4EzR9+23iHi2qhQEH8zCVn+jtrs2JCczfkQUYOli1mFUjqACb
         FJZd3ErUio7Aj6ksvpkTELF/RMkJoA1Oo3gCRr0Kweuk4+Z0tJslHgxM5zJTlWRspnwj
         0pDZOHC4dtQCHbbQjHQnxiTmI91UEBv7RrZDK2/YbY8yQ9YGdR+6738LItHlrq7c+40U
         L3ZNLiz7eXuZHP248xkHgDWgCdTuxiYntc9EdG1VAFG1iS8jliTLiVxKP++KccsM2RG5
         AXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464670; x=1726069470;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0/m9gfxAidcZmmSBa07F5tUNXyuTt8w6eXaConl8Dg=;
        b=r0zj6Tqz/YuGcDfA4JEmRx86jms8fH59E9HmEIesALsoI+mXSr8ut8MmYh3m2mHt3q
         B7z1WZ1NX9Jo4+NxeXGTBCZzxa6AAsPwXGsSUQNOe0K0OuB62TzlngzowoCTIyXK1JvM
         k58IGd192v7pufwuS16rV1QQIynIMR/10C2CWeWrPCJ3cVHXGvSyb4xBuXt3WPqHe5ft
         eMXQcjcjU9X+64KAWAAnF9UO0OttuGmz3aH+YXU/3lf9A4ltKSUyBoRGVHAuEdWUl45w
         pQct0JvcBMXQCvU4vxfNK1X7eB5o3WsQSr5yraokCGB1kJjnfb3YfevUoxpu5BTu7sYK
         g8yg==
X-Forwarded-Encrypted: i=1; AJvYcCVswFEzH4aq+eXpS3uncHDafle7pCBXLHOEHZf/kyxpewRc/ZiBF8st2QTl/oUEt0HbAoKZtepFxSjcYdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38k4D8jhy+0BrWEldZrNZ9FzeM4v6cgYNqog3pFGsJcSGkf8m
	yHN15V0JnC1u1jiXJPsy9FHwzXsbQktubTs2NWU6jpiPGIrBnV2xIXGC4A==
X-Google-Smtp-Source: AGHT+IGpJCjpT1qfXUmSb9iCWFqq6pK5v6aS6Z1hND2gE1k864IMDMT3VSxYAyMgJhm4Ujs7aJcrHg==
X-Received: by 2002:adf:e6c8:0:b0:374:c3cd:73de with SMTP id ffacd0b85a97d-374c3cd74d5mr10796637f8f.35.1725464670068;
        Wed, 04 Sep 2024 08:44:30 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a45b0sm6743666b.143.2024.09.04.08.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 08:44:29 -0700 (PDT)
Subject: Re: [PATCH net-next] sfc: convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, habetsm.xilinx@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20240904084951.1353518-1-nichen@iscas.ac.cn>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <f1007430-0c62-310f-8de1-362096bf2b1e@gmail.com>
Date: Wed, 4 Sep 2024 16:44:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240904084951.1353518-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 04/09/2024 09:49, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
> index 6fd2fdbaa418..aaacdcfa54ae 100644
> --- a/drivers/net/ethernet/sfc/ptp.c
> +++ b/drivers/net/ethernet/sfc/ptp.c
> @@ -884,7 +884,7 @@ static void efx_ptp_read_timeset(MCDI_DECLARE_STRUCT_PTR(data),
>  	timeset->host_start = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTSTART);
>  	timeset->major = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_MAJOR);
>  	timeset->minor = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_MINOR);
> -	timeset->host_end = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTEND),
> +	timeset->host_end = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTEND);
>  	timeset->wait = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_WAITNS);
>  
>  	/* Ignore seconds */
> 


