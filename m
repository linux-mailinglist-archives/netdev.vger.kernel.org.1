Return-Path: <netdev+bounces-206805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02585B04714
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2E07A11CB
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8812126B0A7;
	Mon, 14 Jul 2025 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9F92bNP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D177E26A1C7
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516239; cv=none; b=uTl7K5jXtG9YoVQAH8cTvGrFSH04IP5Xq35KUvx5VMecn+XPsTUpKY4h+fjZ5hToO5j0w9yoT8UhGuy4CkZLTfwHsRi1nA3+sI3fVJP7s3rfi5d+u9tfAqJDPiTh8JTT2+lsH2ELNWymQcipem+/5POICV60Y2hJtwK16GCfvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516239; c=relaxed/simple;
	bh=xKnjXWOY2IrRzosXfQB3Bpso/mm2u4JxGSYgZGdZjIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwuf6cQ2Ab5fq16ndyW2cjRhjodhmfB1CtJAjXZzIG2lxBjMxK1jRJGsQK4ifeW/n1Idxwno+cdojUUAoAItTzHm6jB/G2ItNcRyH+S3NWFxCwrqFngYwi5nRiw2M/6j9JrY7vFUAe/JuC+3NiWKER2J6fXWVNV0EXNblRYUr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9F92bNP; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ebb468cbb4so4077289fac.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752516236; x=1753121036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUc//PEDPwGX6GKHFUnDylrVbmV9/GKD9WpLyzBk2E0=;
        b=Z9F92bNPvUvzoOh9o+Tc/v+cCBf2+qu2MWe2G+RnjWD3C5x+s5lLbCFMjjA6bZZHKa
         W84FRIVVuaQVJ2pqMnhdhw0dQ3pF4LOsc3XrVXolQ6aJ34SCadHwhMOMfQOJAULm48QY
         OUHlIO8OIR6r5SZqjPuKKb2awKYWSxP9R4yVFTA59l7TkKPMj0wCHwV7sgywmQT9hgpk
         ldT9xZUimI5KStO+hW3gwxTtS7p7ud+7upXQkYXbhVwVYA2zQ+YA8BBLAcBV5QdIjhHv
         5FpaNP+G7k6nzJWFPnAKSC1L1uSWICCdR6vRbM98oluqvyDIvrmxKU+aNO1LnzLMerx4
         DtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516236; x=1753121036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUc//PEDPwGX6GKHFUnDylrVbmV9/GKD9WpLyzBk2E0=;
        b=jdsQx3eF70S5yXr9Ww2p0G+z2PdmvnIFryp6aRkHH3XXG4dQU/RKVCi/Sx7kkwyU8h
         aGVWnUAiQK+dGJIgeWdjXWey9+HImzr/N1HMfKGEunFig6o7R81FvoyMnoRGGPgQKEwf
         Uobf4upWtxTdjbQKD7lHE3kiBw8cxwWr6W//Jg2XzRw2CWfCZCjD/hhcXd5CuC74uHNt
         r6Y8i60oRvsDiE8eTSkPkhQ9jQeN+fYBtT0mvm9x5/gvpa4XWXDEE9A0VF5ea6MQY14d
         qnRSmIREjQCCauao3E+ktpnTQYLd8WPgXX1C3S2T54dt31eSohyC1irP5EzrbLFKpTA0
         LTUw==
X-Forwarded-Encrypted: i=1; AJvYcCVFVM6Q3nMv+U9NaOTGhkcGtpAclRNY29nLgAtQp19HElf4Loc8EMPk7V1wncnaTz2Eto5Ocuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaK+inZahEHqt5GpIP+6ws/fq9wGh4qR6PNLb7Y6Kiy11tosgh
	95nAOzmBDooYUeMgtCDEVPThsh565cr/meaAqO1FcaQjkmc5x7ZjE8Bs8kmH2skaMUQ=
X-Gm-Gg: ASbGncuHhxqDAHKfVEOdsMOIomF2QoSBdWpEJhU2c6lwwvjcKahNKfKChdLWP6RksJO
	kib3A+yjhxcencQRHEcGLLf/VaRBv/JWbAZFGE7J9ZciJ8X6AoMuf2WETGSSw2sC/O5lcSJ2gUI
	h05+8wxTMgganpfPsW2rzsCZH13UhvVprhzwQiPiZNmB1ED0fwJjOECm2wzS6tL+ABDA9drAVYf
	oRuKGScdCJ+ypU74WnQQy7GmQBPWCPGL4fbNJxNwbA0mzXWQdsE1vobycdEK0m9zEPpD8ORQD34
	T9jSvDvykEVUDXVD2lEjWN8tTncaZeA8wMiUcSfv0dU+p18FGt7PvuPBmdwzlOQdQOnKQJ20/Sh
	yh2tyC4oMdKs/ya1fCJB1b3EyvSYj8g==
X-Google-Smtp-Source: AGHT+IHTpGx6mV7WMwP1pIKs1b9CdmfJ9vEn7hc8jx+5sU/Mj67Y+rDomjPaMvowTYcY4XUtpdxDwA==
X-Received: by 2002:a05:687c:2001:20b0:2ff:8822:2912 with SMTP id 586e51a60fabf-2ff88223f6cmr1071480fac.5.1752516235811;
        Mon, 14 Jul 2025 11:03:55 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff8dea112bsm84240fac.43.2025.07.14.11.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:03:55 -0700 (PDT)
Date: Mon, 14 Jul 2025 21:03:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kohei Enju <enjuk@amazon.com>, Thomas Gleixner <tglx@linutronix.de>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/rose: Remove unnecessary if check in
 rose_dev_first()
Message-ID: <96fbe379-cf8e-44e9-aeaf-a8beee2eda9c@suswa.mountain>
References: <20250704083309.321186-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704083309.321186-3-thorsten.blum@linux.dev>

On Fri, Jul 04, 2025 at 10:33:08AM +0200, Thorsten Blum wrote:
> dev_hold() already checks if its argument is NULL.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/rose/rose_route.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
> index b72bf8a08d48..35e21a2bec9c 100644
> --- a/net/rose/rose_route.c
> +++ b/net/rose/rose_route.c
> @@ -608,8 +608,7 @@ struct net_device *rose_dev_first(void)
>  			if (first == NULL || strncmp(dev->name, first->name, 3) < 0)
>  				first = dev;
>  	}
> -	if (first)
> -		dev_hold(first);
> +	dev_hold(first);

I'm not a fan of these sorts of "remove the NULL check" patches in
general.  Sure it removes a line of code, but does it really improve
readability?  I feel like someone reading this code might think a NULL
check was required.

I guess there is also an argument that this is a tiny speedup.  That
could be a valid argument especially if we had benchmarking data to back
it up.

Of course, if you're planning to take over this code and be the
maintainer of it, then you get to do whatever you feel is best.  So if
this change were part of a larger change where you were taking over then
that's fine.

regards,
dan carpenter


