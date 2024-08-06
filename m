Return-Path: <netdev+bounces-116126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3274949307
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02227B256CC
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2617AE0D;
	Tue,  6 Aug 2024 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiVaPlN5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA917ADF2
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954295; cv=none; b=pbkVqshp78dnb2qgtj7/Flu1v58dkghN2axXiLlLrXjT1jDkVHfNmg88l8kTSS7m6HtHUknMPcT+G0p7lvPQeCYp1VOagDVmkac8QMZr4aFFcxoJRXcurLU0gkSu8fd/MjuoQlVsL4pnuFNzQYdR65LALHGXsu+Llb9WUr7fLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954295; c=relaxed/simple;
	bh=/NqAG7/b27BPMkRaReA9ge8tM6v7+Nc4S8oBmIAnTLw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=a+uRUXBH0wsbqKu+vhUQiGPN2yI0M3q7AgnEVTFTOoloZqjE7SQgus+/iCuFZZBf90b5w1sZKqsxJOAxUMNYGobtEdHLqZMGwbekheh+b/aHiFXVCfi8X2F3fack7ZEa7r2v8MpQAZNICtCOU4jFMD9iwhPKc23QZS3xJPjElhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiVaPlN5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428163f7635so5492475e9.2
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954292; x=1723559092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUlHNxzLDKqpktPXfQvKNC6NIPx4e9AlQs9rsdGWOVg=;
        b=XiVaPlN5y0AgWQ6N7jP93sqideia3bfnyfDyhiNZv8Wb32ueHZwIfhpB4b3xWSvnFv
         lWhxitiG+AgWMjOT8n4iVGKPyuo0LhhOUSoC7HMeZYmiy2rKyC0+/pUq4AB9MNIIqhz1
         GBDExFvUwpmp6FdO2AlNJNiQbSmOYEzA3sXwSZ0eOUn3eukdFGMWE3Nl4SBiYcyqAXzr
         AFX1cEyjQEYJDQbyKLYdhx7BvhEP5TtBvdfrojVOy1aSVfbj5K3mQZ2KqhdxlQChk0m3
         bW9Ljl/x0nMFNSfeWlEAg0379pn7LaRBEtP6aYQ5QudzvgiPR06tU5xqk5QI+DBzZRlU
         qavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954292; x=1723559092;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUlHNxzLDKqpktPXfQvKNC6NIPx4e9AlQs9rsdGWOVg=;
        b=g6dRL6qJqn2PKl2tU3q7BRpR844kByagYp5oQPeSuwIDF3SznRnDN2Vadw2ysd5sy2
         OVSxsUW8TeG008qJWJyplAPreftg47n5Bjsk3Ttwkm0BTStnujYuUVFAPVaAway3NdLi
         NdcJbiDPwmPxMQyj08XW0pntlwYJDZ/rhpCeWPWW+7KALXk1WFTRgPUxSSbaG50kN+ez
         STp8dkjFSlfErOOxhrMMjXfAbsZnvh4/3VmLQ0B3de12jVPpFoiu+IOQG8n+yFQDR4EL
         KIn2QDJ2/N4z8SjLtxrKC5E3Me7o1pw+YYLqoGLKBs0+kSMS29xoYOU6742+vYgp6rBo
         Byow==
X-Gm-Message-State: AOJu0Yy/j2cMwDwujXHJiDkdL+8mgIoG1RHWXpJSOV7WY2spPPtO1oAb
	+Zjz8fM1uP85d74V7igxffHZR3e+5o2q9r+uUH2PtbIKvlrHl1sGlIRBHQ==
X-Google-Smtp-Source: AGHT+IH1w/k7DpxFgizLPF3TC5/3iYa0EBLE9GCcNnmAMcNC+7SNybZ9yaCnUWxCllG9nPdkt9x9UA==
X-Received: by 2002:a05:600c:4f90:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-428e6b831a1mr99233405e9.31.1722954292044;
        Tue, 06 Aug 2024 07:24:52 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baba5f2sm244751565e9.26.2024.08.06.07.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 07:24:51 -0700 (PDT)
Subject: Re: [PATCH net-next v2 09/12] ethtool: rss: support dumping RSS
 contexts
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
 gal.pressman@linux.dev, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-10-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <ff8dea3e-ff4e-af27-4b96-3fcf1092cc52@gmail.com>
Date: Tue, 6 Aug 2024 15:24:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240803042624.970352-10-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/08/2024 05:26, Jakub Kicinski wrote:
> Now that we track RSS contexts in the core we can easily dump
> them. This is a major introspection improvement, as previously
> the only way to find all contexts would be to try all ids
> (of which there may be 2^32 - 1).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
...
> +	if (!ctx->ctx_idx) {
> +		ret = rss_dump_one_ctx(skb, cb, dev, 0);
> +		if (ret)
> +			return ret;
> +		ctx->ctx_idx++;
> +	}

Maybe comment this block with something like "context 0 is
 not stored in the XArray" to make clear why this is split
 out from a loop that looks like it should be able to handle
 it.

> +
> +	for (; xa_find(&dev->ethtool->rss_ctx, &ctx->ctx_idx,
> +		       ULONG_MAX, XA_PRESENT); ctx->ctx_idx++) {
> +		ret = rss_dump_one_ctx(skb, cb, dev, ctx->ctx_idx);
> +		if (ret)
> +			return ret;
> +	}
> +	ctx->ctx_idx = 0;

Feels like there has to be a way to do this with
 xa_for_each_start()?  Something like (untested):

	struct ethtool_rxfh_context *rss_ctx;

	xa_for_each_start(&dev->ethtool->rss_ctx, ctx->ctx_idx,
			  rss_ctx, ctx->ctx_idx) {
		ret = rss_dump_one_ctx(skb, cb, dev, ctx->ctx_idx);
		if (ret)
			return ret;
	}
	ctx->ctx_idx = 0;

