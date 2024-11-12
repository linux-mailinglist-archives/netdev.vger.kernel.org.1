Return-Path: <netdev+bounces-144034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E59B9C529E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA4C1F21229
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5027220CCF6;
	Tue, 12 Nov 2024 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUvZ3EHY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D55918A6BF
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405840; cv=none; b=JBEOrVHAye48+GmD7NZWVyd4HVlZJL5TKjUo9D91BidDfbBuC+HZ3yPAXdQ+S1KYG+DeWG7JBqMQbyxkFv2GD23iuUFxicWa5WwnVs6NsZjG55smSklv431PjOjHfd0vjfxR7VBuLd0dZfnjhJHP08C7CxqgaLNGmZ/C9vv3mxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405840; c=relaxed/simple;
	bh=mij0PuBDBUQ5oNZm3ImD6hJSXEWYAYzy5KC1dpwd6DE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Hhg8XvCdCbdeCtX3KECKWW0Yf5a9XCer4spNAb7cIMGZSWNzDeP5xL+97AJFDK0Pxk9ODMYm+lxeSekiXtZzmVeQg5zTBALt9ibvTvGlz3sW7EP+ZhMoVW2/er+1mwOJLm5hgWTlclOQowqrJAd0oPl/XGADbRQjwIp+Os8Kekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUvZ3EHY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315abed18aso46348485e9.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 02:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731405837; x=1732010637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGWhHKwouAr6cxs2pOPTKtEYMNA8YfSUT0XaOqIT8aI=;
        b=EUvZ3EHY/a0k3dF5phyUS8i3qYgaGEeUNqcwqqGPzFt7ZcDrfK/MYKfU+3Qhxz0dHh
         LtIyenvpdcN7G8vAWZtdJlRmxenHKSLzHD3Li34A818HCsaOMYJ5AGAfS5Dzuyrby7rG
         TxMb9TnNfPSv0ncl8XfleNmP5+Jd0O30ROCywewaueHtm6naqsc3Qbt/eck9nrWDQDgm
         knAf02dNvEHwH7TL1ILkZSp/mLkqyyHFpsBMSn1GpuOkWhTY0k4Qy5Hb+xAUA+vWRLB1
         Jd4xMvJJQ/eB9Au3scZVs3kCvTW69FqQz/99GZtCAXnnA8R08ERnipm3754ANoHtlKZU
         gNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731405837; x=1732010637;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGWhHKwouAr6cxs2pOPTKtEYMNA8YfSUT0XaOqIT8aI=;
        b=BBouKeV6jovqL+AWFKgTZRnpiu+oJUMarFMbO2NsoDQJfXldSr434HUXRYYIcjBs+3
         WOv4IdXS31om9DPMQKqhdLlMIInDatRv9L/58/eXmGjH8smik35zo3Y8Otm25x/Hx5Q4
         GJRLmGTMUs4PGUCb6zHuLPO+3eg8xLZGM6gta31I57+KOOkOUPEekRU5OLaWh6Dt7brX
         naY0BUsIWo9P204lYswMl8Oh1w0AvNcYEu+MbHRtj8xXcqY+u/y9x3YivxwyE+Ij/ofF
         8ZdQtBhwawRWkY+dltX9c4e2/upu+90JGdnNFBDQJJBRpxvKol5HYiydD1MyzqL+n7zQ
         NaZw==
X-Forwarded-Encrypted: i=1; AJvYcCUUY/RKj8s3nZRxiZo1TD60/qaFgJeJ0zM0mHsUT3KXILJkZMxpWZQPIXSwa1mOw2ORWqKW4As=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJRJJ57edf019DAyzvXiMh3prTd3vdSs/Csg3PRgNMLCZnSmx
	hOdkbXDl5ackXzqun6AXIFcFl9pkozWQAqUn0yfVuTiMA5YuWoPq
X-Google-Smtp-Source: AGHT+IGx30Rpk/mRIxjhka9hPreyvqDzPtvvoKpV0LUhWkANfWgA/yxp028eirqoazGONakaM0lwHQ==
X-Received: by 2002:a05:600c:3c8f:b0:431:52f5:f48d with SMTP id 5b1f17b1804b1-432b751f42fmr133652995e9.31.1731405836628;
        Tue, 12 Nov 2024 02:03:56 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5d29sm208727355e9.39.2024.11.12.02.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 02:03:56 -0800 (PST)
Subject: Re: [PATCH ethtool-next v2] rxclass: Make output for RSS context
 action explicit
To: Daniel Xu <dxu@dxuuu.xyz>, jdamato@fastly.com, davem@davemloft.net,
 mkubecek@suse.cz
Cc: kuba@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 kernel-team@meta.com
References: <978e1192c07e970b8944c2a729ae42bf97667a53.1731107871.git.dxu@dxuuu.xyz>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <21bcb49a-4542-ddd4-db46-e0ba5f22aa35@gmail.com>
Date: Tue, 12 Nov 2024 10:03:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <978e1192c07e970b8944c2a729ae42bf97667a53.1731107871.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 11/11/2024 19:05, Daniel Xu wrote:
> Currently `ethtool -n` prints out misleading output if the action for an
> ntuple rule is to redirect to an RSS context. For example:
> 
>     # ethtool -X eth0 hfunc toeplitz context new start 24 equal 8
>     New RSS context is 1
> 
>     # ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
>     Added rule with ID 0
> 
>     # ethtool -n eth0 rule 0
>     Filter: 0
>             Rule Type: Raw IPv6
>             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>             Dest IP addr: <redacted> mask: ::
>             Traffic Class: 0x0 mask: 0xff
>             Protocol: 0 mask: 0xff
>             L4 bytes: 0x0 mask: 0xffffffff
>             RSS Context ID: 1
>             Action: Direct to queue 0
> 
> The above output suggests that the HW will direct to queue 0 where in
> reality queue 0 is just the base offset from which the redirection table
> lookup in the RSS context is added to.
> 
> Fix by making output more clear. Also suppress base offset queue for the
> common case of 0. Example of new output:
> 
>     # ./ethtool -n eth0 rule 0
>     Filter: 0
>             Rule Type: Raw IPv6
>             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>             Dest IP addr: <redacted> mask: ::
>             Traffic Class: 0x0 mask: 0xff
>             Protocol: 0 mask: 0xff
>             L4 bytes: 0x0 mask: 0xffffffff
>             Action: Direct to RSS context id 1
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

but someone who understands ethtool_get_flow_spec_ring_vf() should
 look at this as well to check whether that information's needed too.

> ---
> Changes from v1:
> * Reword to support queue base offset API
> * Fix compile error
> * Improve wording (also a transcription error)
> 
>  rxclass.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/rxclass.c b/rxclass.c
> index f17e3a5..ac9b529 100644
> --- a/rxclass.c
> +++ b/rxclass.c
> @@ -248,13 +248,17 @@ static void rxclass_print_nfc_rule(struct ethtool_rx_flow_spec *fsp,
>  
>  	rxclass_print_nfc_spec_ext(fsp);
>  
> -	if (fsp->flow_type & FLOW_RSS)
> -		fprintf(stdout, "\tRSS Context ID: %u\n", rss_context);
> -
>  	if (fsp->ring_cookie == RX_CLS_FLOW_DISC) {
>  		fprintf(stdout, "\tAction: Drop\n");
>  	} else if (fsp->ring_cookie == RX_CLS_FLOW_WAKE) {
>  		fprintf(stdout, "\tAction: Wake-on-LAN\n");
> +	} else if (fsp->flow_type & FLOW_RSS) {
> +		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
> +
> +		fprintf(stdout, "\tAction: Direct to RSS context id %u", rss_context);
> +		if (queue)
> +			fprintf(stdout, " (queue base offset: %llu)", queue);
> +		fprintf(stdout, "\n");
>  	} else {
>  		u64 vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
>  		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
> 


