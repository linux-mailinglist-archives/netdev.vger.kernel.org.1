Return-Path: <netdev+bounces-111880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F77933DEA
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51991F21227
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD15E17FAC3;
	Wed, 17 Jul 2024 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XG1BgUXI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542C2EAE5
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223994; cv=none; b=VaP/PfE9r97K7QWjRzhhR/WTwWd2V8rYwDTiAU1qzJ0PJfFM565yy6A4wK/T9mqxL++ccVoJVnebrdDTuz0uKCeV6KzdGe5tONwOunjYUg80vEkH0X6eQ4uFGbgAK+UpM4B7NVfUsv8NUPwEoZf4dDRFeQTs44KZKeXHo7sJmlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223994; c=relaxed/simple;
	bh=NZ5PN3Rcuvuj1UHDMfctCD9D2QZDO3VvyfUBSN948wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKofX8z6R7ceBpJt7/1TMcjmBYXAdVh/EzOmPpUh9LCEM0nwe4DQ9EAdbK1xyB4/nRiRSH398RgYbOMAXgOQOwk0DZObrAp1+c5BzoUfjomOvpGStEtqVFIoSgRZ8EbV64HJIjQ+yXnhKfyx9NehPpDO4hPrwSzVHMooKykg4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XG1BgUXI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721223992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toL7QRhZzCsu7TEDH5Zg2JYzO4LLitCK112mUZsr83w=;
	b=XG1BgUXIwXC07MsnLOYE2ObF8cippm/6jJjapFRuf37CEOuA6x9X7vWBxx1H/+VwWwbzeX
	0+qGQaXrtbvTMy+FQ3Hp3aJTz66gRBOrFKINhTvZAiOTWGfVL7CQo2DfMm/WpSYGyE2IM3
	J2deR1kHPDtM9AYUK+fN6bYw+bLgUoQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-LcQdpICeOLKaZgn5Ww5EcA-1; Wed, 17 Jul 2024 09:46:28 -0400
X-MC-Unique: LcQdpICeOLKaZgn5Ww5EcA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4279f241ae6so6139145e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 06:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721223987; x=1721828787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toL7QRhZzCsu7TEDH5Zg2JYzO4LLitCK112mUZsr83w=;
        b=E5Taeiwu3M+dOFivh6L12vJOW0LvDyh73MXAmVeviA23K6rbDSOVDZVhKRcYqapl9H
         JmraxF93SHef5B9+cxLdwDXDuuCjmjrt+kAskMgnmLSwIk8HkwQBBbU6rm3VPNsA4Zhw
         MrFWSZpk9uZfqdWPtGlfsxrpDeeN2ZJYKcW9QiARTj6tBL3uutAmsDa/oxWXGsRay4aQ
         alNoFI1++zkw0zACdPk1Bu/7CN2EQDRNc9qvL1UF247hYcnHXUVNwxaT43pjlvL9id6Y
         NKKHTotgBiTVBl5e1pjXp9kegNlAUwLWDU82fLz3zO4iWkJNKs6gXOLcJ5EagCrQfGbP
         FJ7Q==
X-Gm-Message-State: AOJu0YzlXqIOfNrsKEAl9RNO9XUBror15HPXfzMNXvPrVyPhuprWt/6T
	ab0K1VE7IWPJ62gIzgXP7yQ19adEs9MkvsfTJkUN52QLrXonkkh3ZCHRSNp+Hs4Mnh91BhrWMlB
	PjZ9Bss6+f6n37RAMDSAb/WTI7ASvrDJzBX2fMGuyjOpp9qIT03qMnQ==
X-Received: by 2002:a5d:64e8:0:b0:362:1322:affc with SMTP id ffacd0b85a97d-368316fbf8dmr823008f8f.5.1721223987565;
        Wed, 17 Jul 2024 06:46:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1rQSCD47U0LD6I2s7FyNT1ooPnOtpZbFX1F4P+WBJwjmwj6a6CBaMGJaBgAWvdCe8tMbMqw==
X-Received: by 2002:a5d:64e8:0:b0:362:1322:affc with SMTP id ffacd0b85a97d-368316fbf8dmr822998f8f.5.1721223987175;
        Wed, 17 Jul 2024 06:46:27 -0700 (PDT)
Received: from [192.168.1.24] ([145.224.81.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36831035ab8sm1654152f8f.101.2024.07.17.06.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 06:46:26 -0700 (PDT)
Message-ID: <43bc03f0-5e5a-4265-898b-8ca526d6cc75@redhat.com>
Date: Wed, 17 Jul 2024 15:44:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] eth: fbnic: don't build the driver when skb has more
 than 25 frags
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, alexanderduyck@fb.com,
 kernel-team@meta.com
References: <20240717133744.1239356-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240717133744.1239356-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/17/24 15:37, Jakub Kicinski wrote:
> Similarly to commit 0e03c643dc93 ("eth: fbnic: fix s390 build."),
> the driver won't build if skb_shared_info has more than 25 frags.
> 
> Fixes: 0cb4c0a13723 ("eth: fbnic: Implement Rx queue alloc/start/stop/free")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: alexanderduyck@fb.com
> CC: kernel-team@meta.com
> ---
>   drivers/net/ethernet/meta/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
> index a9f078212c78..b599c71a2d27 100644
> --- a/drivers/net/ethernet/meta/Kconfig
> +++ b/drivers/net/ethernet/meta/Kconfig
> @@ -21,6 +21,7 @@ config FBNIC
>   	tristate "Meta Platforms Host Network Interface"
>   	depends on X86_64 || COMPILE_TEST
>   	depends on S390=n
> +	depends on MAX_SKB_FRAGS < 26

I think that with aarch MAX_SKB_FRAGS should be max 21. Aarch cacheline 
size is 128, right? The frag independent part of skb_shared_info takes 
48 bytes, and sizeof(skb_frag_t) == 16:

(512 - 128 - 48)/16 = 21

Cheers,

Paolo


