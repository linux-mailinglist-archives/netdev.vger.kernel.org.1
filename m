Return-Path: <netdev+bounces-102072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264190153A
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 11:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAEB1F2262C
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADAF199B0;
	Sun,  9 Jun 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gt8JVmkV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830920323
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717923901; cv=none; b=LWRtAGgaVyiRNgIr6rP2zBQdw9qLkq/vSLsuKviI1uThxy4/GI2GGznpZXoaULkmjTdhPMC5kS2Um5fg7ZQ1uBiJLZo43NMgnFuhnh0e3Dg3BgUS65MPZQvEYErGbygxjPqHclmaWupIRSHpxel3tNhtVQ0vpzJoi1I6bqrVufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717923901; c=relaxed/simple;
	bh=Si71bFQFrRd4fbeR2nUXGk/jsEUgyn+WHHa500mVRsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyN+bk2e7URi+AsJYe8JDZ/ydswxhcAf3IDyVlOv1GRLR9AgRhlTnuY1U799AXioJXgfAQxp1zYYV4754TIul4aFONLBxvDx98GyzjtOltUhTOpcrw/uD3A6qV1eISHf50jOPECmtEmU2M8WPPjX/8Kedif7Pg7qpWToKc9yBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=gt8JVmkV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6ef793f4b8so175203666b.1
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717923899; x=1718528699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIh4lH8bQWGJqNihyQij8olrXP+SesotSW7Pq/JkSlw=;
        b=gt8JVmkVmzM7jA2jbnbS/BOMoqukT+T6ETdMRCDk60sDNkKAUTotS0F9LmBLW5iMTQ
         OB+XQ3yx+WM8xl1OCihzGJlX000NgQlpNaJ5puvb/oskLrEvV6zieLY1WAwWRa913pYO
         B+wCNb2aLUXSxn43EPmItmF1Px1emI+N/nJT10r49MSDKMPS07yvQAQ1tDG+3YAMKGv5
         jfWUcMt9M3zAkirQSOh3lJDANxSuM53+qHxfIWIECAKYntCEmw8qfKFOpLT5W9dtHfWF
         p7OalkfdrTCWMKGxYNg7gCffB5u7+ns50eqDjpxckQkqjJSBlpcJhv/otwyTEI3shgUz
         FzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717923899; x=1718528699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIh4lH8bQWGJqNihyQij8olrXP+SesotSW7Pq/JkSlw=;
        b=KyBySU7jvk2PeFRXzOCJo9gY/M3L6DPYePvfsrgi7YKcqeTRafyo5LbNkP+l611dzw
         qgIofl8V2gRR291ccmz0HnLyEsNuDwRkglVBUYnahxqrBeseq74Xu+t8g8EB1FCpdY3n
         6Htl2YtyHlmz3ytaDp4FWhUF6zLiSznHtCdXyz6LHvrGq9rK6SPROmoTImIx0UPHlt7q
         vDjRgJN/fbdbm8HCJ6DJzppw0Z0/t7YYFPR6GJVFYVxL13IDF6Gma2KWdHDN4maaUErs
         BkBz38Sxb7ouCf8DSOZ/2zgwdiLirlLVzi3l0hCILgdoirobtYaE3v3j8clfmyKj8fLQ
         v3kA==
X-Forwarded-Encrypted: i=1; AJvYcCVpXvVDizeOzuf5Hkczx0uyhEftMbUstm6AXZ2eAuKjACQ8ngEMcHHMG9aUTH5RXl9Gdfv4srMoYtbwjN3N2nS6AYHc/AHk
X-Gm-Message-State: AOJu0Yw9/dIY38xkM4fMk1TxYGDtj0svSRd+gxAweBPEyKr77svfllgi
	ZFe8tTazG3ZGLQr28urV6DS/+cnFJ8O/xjMnlrHW+S8ui7P+JUJuxN7c0jCO7G0=
X-Google-Smtp-Source: AGHT+IFeE9HHbL43cW+IG9vH8TRTU8lt4FODOIbm9LfnJAHutw8/LXc+pVSYkTkSkQJY+mFvTLJ6lQ==
X-Received: by 2002:a17:906:3285:b0:a68:2f99:a3da with SMTP id a640c23a62f3a-a6cd5612575mr431690766b.16.1717923898631;
        Sun, 09 Jun 2024 02:04:58 -0700 (PDT)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef9100096sm247145366b.97.2024.06.09.02.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 02:04:58 -0700 (PDT)
Message-ID: <b2d17c74-86fd-4436-9156-271045ab1a45@blackwall.org>
Date: Sun, 9 Jun 2024 12:04:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] net: bridge: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
To: Julia Lawall <Julia.Lawall@inria.fr>, Roopa Prabhu <roopa@nvidia.com>
Cc: kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Paul E . McKenney" <paulmck@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-8-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240609082726.32742-8-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/24 11:27, Julia Lawall wrote:
> Since SLOB was removed, it is not necessary to use call_rcu
> when the callback only performs kmem_cache_free. Use
> kfree_rcu() directly.
> 
> The changes were done using the following Coccinelle semantic patch.
> This semantic patch is designed to ignore cases where the callback
> function is used in another way.
> 
[snip]
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> ---
>  net/bridge/br_fdb.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

