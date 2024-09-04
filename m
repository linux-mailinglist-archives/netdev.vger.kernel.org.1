Return-Path: <netdev+bounces-125175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A996C2BE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F16280613
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681E1DFE11;
	Wed,  4 Sep 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrJZssG8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5471DEFE2;
	Wed,  4 Sep 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464675; cv=none; b=GcwVP7ACA06nKcAtgsrraGh4NwKLB3VJtMSVRTAU+BVeB93mJP0WyfucoyCjSS/1WSp7T/0rFdQtpvFU0/szqbFW/dCoxVS9QG+6IFGvzj6W5vh7XcwOxVQBwwKTQu7zlh9JdR0XqHRT9oZrJtdtWpiDswAdNX8UOcXYTBqours=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464675; c=relaxed/simple;
	bh=jOcvn77ohC8xGMN8aQb1AhIHzP4gmcO8doQ5MvJKx5A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=s3QV/DD5SzcDP5TO30fGQppHwMT6sphrJRTChxjv3H3o2X3gK1usm75t0U2zjeLGvCjk5X3FwphjVT0K6u4J1iHquhkFx6XN0uQZSjeU35mSKy8897h6pdYiWWOzO+Da2KZ5Yf2HBX9nK0jC6LfZ3BQpepTR+OJdZhWSpMNGMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrJZssG8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso3766188a12.3;
        Wed, 04 Sep 2024 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725464672; x=1726069472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0LUnO6o66/A4O/lYj8KkZXclnfgrRQhoEfs8tLO9/I=;
        b=QrJZssG8dkCKSGhY/XDu1Kj1HPWhHKs1QB5WXois65lxxvvijH5U9qE2+Q6onbaWvh
         jSFdwEaQl1EVhb5FEw6FrTgjI5/i17TAQVr8OnamqrHYwx/LIn1yCkdI+JfHnryQ4ZWd
         +iwMGL47Fz5PCiormElggYZFnkh4aEfk/vJVGBH228nJRdVkUIkerNMPHd+05+puLrNo
         DFcT1pjZMV3PhaUXfhXz/A6CyqXb+Q7IiJXgdewMi6mifMc9ZUCl+a+ip6YjQxmsbMOA
         /HUzvBhpPbpSg2v5SrMrHcYGUm0qXOwh6ODpsvayynmAi3FFPCpyMyHgYPjS2HGk3DU7
         /NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464672; x=1726069472;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0LUnO6o66/A4O/lYj8KkZXclnfgrRQhoEfs8tLO9/I=;
        b=hA2Pei/iXTqHolw182SXdYog5kgyUDwZAK0+Oh202SUf4pEDdukYScOEXVP1E4X1hx
         a+ojZz+EQ8PlxKm79BmRQyniVtryqBdplQiL12ZxwR8W5JWHzJF1rkebP9Awts3SvtQj
         9Z2bo/yeHKlzOAx2HrEI4fB87h8efUacDJ7NyhjNV6VtNHI6EpHnwhGvvC1lZmfuFq4e
         GWL75Dews6IO6i3oUntm4zGRzf8nKHG8nWAoNBrO3AAJgJpGc1eNNlRmgGdlSg/6Qg50
         UfMLp8S0O90/oik1HJUwHCQUjQgI2LrHpaQ8JpXfEVIITs5aVuEmTOY/cpliif05PGu0
         1AtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX63s3SeO+iwcrS5+7uMIUswADUGF2X1kkTbp/gHvZYIOMihnKGrwt1Z+jBQsig/i9tQ3x0iKc+Psncnuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHfEru4JdLvMuJCzYBVoXflpiBziYmEsOkGlE03ygazSqWxLYz
	oF/YAbaeQJhznxk6LMhILh2nR9Mdbs8kugnu6DTm5RqKk4796bZAL6L30g==
X-Google-Smtp-Source: AGHT+IHD5HhUzs5neFHNdUUz8WtPLr3mxGQnKjsgCqssF4gzsiHMBp8p0ruL4oR9SJ48Xjmxbp7uyA==
X-Received: by 2002:a05:6402:3906:b0:5c0:a8d0:8be6 with SMTP id 4fb4d7f45d1cf-5c25f244e40mr6021157a12.19.1725464671887;
        Wed, 04 Sep 2024 08:44:31 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc52ebfcsm66052a12.20.2024.09.04.08.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 08:44:31 -0700 (PDT)
Subject: Re: [PATCH net-next] sfc/siena: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, habetsm.xilinx@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, vladimir.oltean@nxp.com,
 shannon.nelson@amd.com, wintera@linux.ibm.com, kory.maincent@bootlin.com,
 alex.austin@amd.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20240904084034.1353404-1-nichen@iscas.ac.cn>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <bc5a84c3-c14f-aa0e-1b89-00eab1565aa8@gmail.com>
Date: Wed, 4 Sep 2024 16:44:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240904084034.1353404-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 04/09/2024 09:40, Chen Ni wrote:
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
>  drivers/net/ethernet/sfc/siena/ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/siena/ptp.c b/drivers/net/ethernet/sfc/siena/ptp.c
> index c473a4b6dd44..85005196b4c5 100644
> --- a/drivers/net/ethernet/sfc/siena/ptp.c
> +++ b/drivers/net/ethernet/sfc/siena/ptp.c
> @@ -897,7 +897,7 @@ static void efx_ptp_read_timeset(MCDI_DECLARE_STRUCT_PTR(data),
>  	timeset->host_start = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTSTART);
>  	timeset->major = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_MAJOR);
>  	timeset->minor = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_MINOR);
> -	timeset->host_end = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTEND),
> +	timeset->host_end = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTEND);
>  	timeset->wait = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_WAITNS);
>  
>  	/* Ignore seconds */
> 


