Return-Path: <netdev+bounces-122780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DC0962888
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4001F221AC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A8C178CF2;
	Wed, 28 Aug 2024 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5qxVLJi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE216BE1B;
	Wed, 28 Aug 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851388; cv=none; b=HptUpXFdFSlR5/CLhsdzRwUfSSQjDFZa7Gjg68QFEsU7y0wEn8wChDIU8Av1oat+3cAQExCIFnuhzA3+a+YsZKksMg9Peym3ws4tXbN7lYeCNzY2bYRchdNgyDGY1ymXsZE8w1DEZKGBR/wzFerhD7/aYxXKAq2PJ962THXhx4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851388; c=relaxed/simple;
	bh=FKck4MO4GJU9DG7wBxwyLMSPqGcNic5OM6j0jhT8VW4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=n3nnYqFBhGw72ZAf681fJfvRP0ePvccw/IL4D6CmxEvIVOATgAZnz9cpdVKAHfUR+oaftGuH4unFSpehaPNO0q8U4b4IGOZWge+Me/QmX7eVAUX6Jdo0e8w2pNsvffeFHVunvPnA7JIDM/MJAySBJYIPzOXcicXBU7MPYilImmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5qxVLJi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-371893dd249so3606181f8f.2;
        Wed, 28 Aug 2024 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724851385; x=1725456185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIpRiiJDG1BUAb8zv1hEdTk/voFT0ml5TdCRhuBWi80=;
        b=g5qxVLJiGFsbLRYITauYDCHw2S/8JLWtkmGu/AcxDXXp10z5VtOahpXIA3Zr0K2ZDX
         ntXV60zGRIK6sjkKFA692SlBP1c4BIlcj8repMiAfFxPIh8uKMXl0WmjaXadjD+xCmWB
         iSe3b7yV+kUiIava1hHOpfkZZ8v3e8uXfK7O0ZDYDu57BXehtcxDHAoVpQjeTQDHwH9O
         jaEJeBWZq2uY/lfJ1dqCtws8cpsMw4Ey9JQ/gJs4x3n61ikTBFq0XPDRCT/RZwrY34R9
         4a0uLP1an6CLntNnRD3buNkwNOdsBeLmJij7WIK2u4QjOEOOTK093KrMUlSBFsQoWvr2
         kSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851385; x=1725456185;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIpRiiJDG1BUAb8zv1hEdTk/voFT0ml5TdCRhuBWi80=;
        b=S7+w0K6iBnoiSLF+IfTeBnAad4yQeidJ1W7Hnwm3FGOw4RwoShi5MgCUnyBVCtES4S
         afQxNTHodBjRL4ILmuf3GDk1iU1ZrZUqJr0eaeWzSP5SufOn/dvkirJHF1nXXEWcw8Hr
         /BSR8sGzyoRRKIYEetrSqbT7BRLutAtERKD/t0G9yo5pRc67ZmBMwphosiY33Vv6C/F0
         AoQlOQn3IuZaCrJXZ79B/su/v1wumn5byitzw9k+HBdVbdWbHU7zuJg3q5FUzx7Lg80X
         26fXoEAImXKcFL7MLSD4lzpM90dCLru7Z9YTIihfdXPOUnTHlERr5CNmmVNaNKBINxMs
         zD8A==
X-Forwarded-Encrypted: i=1; AJvYcCXemvtviLhbKyMPdn0mSazMcX+Pg8monl8vehnQkXLJj3fdFieHmWlwsd9UB2MX6aNkEoVeM5KZOQ448YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxyGcZhWbXTsb1imVPLLOMQSRVgAPIT14YnJXpr7TY9HWJZf2
	igczUGgPd48dYIm4jHc++KLxBbA/sY+Dk+0IivbZeqpE+lu8gCar
X-Google-Smtp-Source: AGHT+IEOjNMF2pqMTezk3k31Wq01AGUxPif8brK9ZSVKrBkiftG3PmpTOKfqJRexACIuMekofKko0Q==
X-Received: by 2002:a5d:6247:0:b0:367:4dce:1ff5 with SMTP id ffacd0b85a97d-37311863704mr9980077f8f.32.1724851384525;
        Wed, 28 Aug 2024 06:23:04 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb4829ccsm2261202a12.95.2024.08.28.06.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 06:23:04 -0700 (PDT)
Subject: Re: [PATCH v1] sfc: Convert to use ERR_CAST()
To: Shen Lichuan <shenlichuan@vivo.com>, habetsm.xilinx@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240828100044.53870-1-shenlichuan@vivo.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <6e57f3c0-84bb-ce5d-bbca-b1a823729262@gmail.com>
Date: Wed, 28 Aug 2024 14:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240828100044.53870-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 28/08/2024 11:00, Shen Lichuan wrote:
> As opposed to open-code, using the ERR_CAST macro clearly indicates that 
> this is a pointer to an error value and a type conversion was performed.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  drivers/net/ethernet/sfc/tc_counters.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
> index c44088424323..76d32641202b 100644
> --- a/drivers/net/ethernet/sfc/tc_counters.c
> +++ b/drivers/net/ethernet/sfc/tc_counters.c
> @@ -249,7 +249,7 @@ struct efx_tc_counter_index *efx_tc_flower_get_counter_index(
>  					       &ctr->linkage,
>  					       efx_tc_counter_id_ht_params);
>  			kfree(ctr);
> -			return (void *)cnt; /* it's an ERR_PTR */
> +			return ERR_CAST(cnt); /* it's an ERR_PTR */

May as well remove the now superfluous comment.
Other than that this lgtm.

