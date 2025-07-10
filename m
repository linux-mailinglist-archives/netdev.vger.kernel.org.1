Return-Path: <netdev+bounces-205727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E804AFFE1D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1084F7AC89E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E07298CB5;
	Thu, 10 Jul 2025 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KduGIgqI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777C298CC4
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139760; cv=none; b=ObP0TRNn0wQRdedX/SiKhtqpzV0XL/ijeTQiygIxP8sTrfNS31GYDuXXK3aySyv0bq18ZOocwn8uyoTHbZI8DbeYdAkSi9pQp9DncmoCBAQ2fSVTIvyPWxwWb5NkpWDE6hc1rrC2PlY2QH6mnId6hhiZRVBcG+uOqiSfkKV3/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139760; c=relaxed/simple;
	bh=Mj99t2+T5CZ3bj3evKUWmV1TWs6ZU+OLZkjlOnmUkbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9RbdpF8HtQawXwcJbiIlkA5i/Xh62bR3u9kWbd+a/+d9iIqWA6ZM6QnoJX10dHmDUOeOth9O4TCWAijltY2bplvvTMFoPpM8EyCw+onHn8vE/lwpG436vXPrRWuBWVis4sQuMNk9p1YkLMZiLL/gAyc5Nluf915Uez4q+lvGzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KduGIgqI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752139758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4m236VTKUqnXMtDNLsgzoIjZNCKdFD8CALQosO/eFs=;
	b=KduGIgqIaIM0Yl0QCObFLmRdMcE0NiQ0dEofmLLr8re5bVza3h9/R/QhRtjsC0UNOQXWTI
	uRCc9Q+AdatTekJU1xSTE8R49lkhxmU41GZQnYUsd0Lr+G3cTUdQEXn6ou09AAD7Kd4p1t
	46+DRgZzfLFV+h62Tw7C0RGvzcONVoI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-IwPQpY42OkS3wuAgqfZY7Q-1; Thu, 10 Jul 2025 05:29:16 -0400
X-MC-Unique: IwPQpY42OkS3wuAgqfZY7Q-1
X-Mimecast-MFC-AGG-ID: IwPQpY42OkS3wuAgqfZY7Q_1752139755
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso4047295e9.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139755; x=1752744555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4m236VTKUqnXMtDNLsgzoIjZNCKdFD8CALQosO/eFs=;
        b=UCnTDLYfll0W+xSxrcV3vTWb1A/wRb7xaQ28PnGbupag3UAq/t5JA2yXq1OcLJT4OL
         OFoghXpZ/QqLo6NfoND9dfLxtd1twmnY+Jcr0VBT2JPXYYKjf4EqgRQPahn7CqCKq2LX
         9SFZyzUWiZkBwHTxsv+9JjmxB6l50OYfooN6sM/6HhSM0ljm6kdIk8f0xI3hkwTcDePm
         MlZ4mUmfQhXBMPHLCi5vrwIsAx7GaRVM/O06KNrjjbc18+WBrf4MtgUSpHZJV5zRFnmg
         dOoi+C7gmgZzXlkLMkMDX4OUog7KJ26MaX8dX+pPAXNAGEe0gVI4O1SEKNng7lplcNCv
         gEfg==
X-Gm-Message-State: AOJu0YymBCdoCePQebvVMwhN8TGqJzfKyCwUaRb0bo2VALooi3mbDsC+
	05I3BBid5kI3Hdj7EO4a4tNwOEe0q5pOh6yoUplR2L1jWMPDWMRy5CJFtWOCBtRiP6T854GgA4k
	8ZYCa2TVYwTkmQ7F7r4INZy6GUvHxZrr7xNqexpkMkudHPK7GGgaY6d571g==
X-Gm-Gg: ASbGnct4EbjZqNuacU9YUKkPb95iXfVpweRsKIO1DhlT5ztrWacPsdXD6sF1etjyr9M
	8/2tViXWv/CsY5+F4l6uW0Dz7SOwTq3wv7a+NwbHlcE3KgSs/eo802Qsu7hQmgeYvWQa6du19wR
	yZ5GpXN22LZWwxA5haV+xDAe8R90qI4zI7y7609lWz1u8uxXS0FZ04bdbnCaPLtH6U7LFaqMn/H
	9B8JzqMxnKai9VvR87a9ume9+hpj4wQUmzppkL8NtJFpp8VDKuSUDyrZ0+K+S350Sc0BjU3sWX2
	tNGBW9zblM/zr9LSEc9AhVfQN7GTrlwuExO3rJRJr3bgI1sgA+UD4LXHHse0Uj5OnOwiCA==
X-Received: by 2002:a05:600c:3b0f:b0:450:d4a6:79ad with SMTP id 5b1f17b1804b1-454dd2f1fffmr16819965e9.23.1752139755360;
        Thu, 10 Jul 2025 02:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeNP7uDlPMS6NgOJ1XCVdaAcNbvsnjWShUEJ83Ozrbbnu/dt4Dbj65YDVdrx36XLOJWleHxA==
X-Received: by 2002:a05:600c:3b0f:b0:450:d4a6:79ad with SMTP id 5b1f17b1804b1-454dd2f1fffmr16819595e9.23.1752139754868;
        Thu, 10 Jul 2025 02:29:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50dcc84sm55548135e9.24.2025.07.10.02.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 02:29:14 -0700 (PDT)
Message-ID: <fe811639-7775-4666-b678-58f8a47b65ed@redhat.com>
Date: Thu, 10 Jul 2025 11:29:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] af_key: Add check for the return value of
 pfkey_sadb2xfrm_user_sec_ctx()
To: Haoxiang Li <haoxiang_li2024@163.com>, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250707160503.2834390-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250707160503.2834390-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 6:05 PM, Haoxiang Li wrote:
> Add check for the return value of pfkey_sadb2xfrm_user_sec_ctx()
> in pfkey_compile_policy(), and set proper error flag.
> 
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Set error flag '*dir' properly.
> - Hi, Steffen! I know that inside pfkey_sadb2xfrm_user_sec_ctx(), null
> value check has been done. This patch does the null value check after
> pfkey_sadb2xfrm_user_sec_ctx() being called in pfkey_compile_policy().
> Also, set proper error flag if pfkey_sadb2xfrm_user_sec_ctx() returns
> null. This patch code is similar to [1]. Thanks, Steffen!
> 
> [1]https://github.com/torvalds/linux/blob/master/net/key/af_key.c#L2404
> ---
>  net/key/af_key.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index efc2a91f4c48..9cd14a31a427 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -3335,6 +3335,11 @@ static struct xfrm_policy *pfkey_compile_policy(struct sock *sk, int opt,
>  		if ((*dir = verify_sec_ctx_len(p)))
>  			goto out;
>  		uctx = pfkey_sadb2xfrm_user_sec_ctx(sec_ctx, GFP_ATOMIC);
> +		if (!uctx) {
> +			*dir = -ENOMEM;
> +			goto out;
> +		}
> +
>  		*dir = security_xfrm_policy_alloc(&xp->security, uctx, GFP_ATOMIC);

AFAICS security_xfrm_policy_alloc() handle safely 'uctx' arguments ...

>  		kfree(uctx);

... and kfree, too.

This patch looks not needed.

/P


