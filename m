Return-Path: <netdev+bounces-79417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C1F879204
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F211C2234D
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A5D7867A;
	Tue, 12 Mar 2024 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C8t6XGs3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1D0AD53
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239345; cv=none; b=qbkMfNSeNNcqwgrHxaWbgfhsUcggvYkH3xk0iyXtGw53pqRrOZ26jegJWCZ18cqphYBuTZ3qeg/kVpT4wi6/JdzFzL/dw0PqEa8f+fGCKhVB2ZE7VavAZ7FtYukKgGeyezWeal3iE++gj+BsHpdl2Q4gU4gHE9d+K3fponAmPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239345; c=relaxed/simple;
	bh=JLDcBgW+3vtGMYoTcRPuT4brcDBaHRWE2L0AAL86eQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqq1wkXiAdEk/lbL7KU2L2iNflOk6Tc1elEPzrWXXxKNwWouM7iMVkNJ15qaPAxTmznP9WDotnjKfQGCacjRVHIbi7wI6kACIPQPGJtx1IK+TcCIPLtvefntaM+sJ5L/HQSpNix4rR4vS40nK2DLa9tWS30factkgJUVxIrG/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C8t6XGs3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4132f37e0acso8093685e9.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 03:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710239342; x=1710844142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5d4B/pAoZQB5tS1BWWn28qe/xI29Jo7qr/wZ2JnyTFg=;
        b=C8t6XGs3CoziosSQAiUwj0PiG6auvS5pl2sHBvguqIx7BvfhSiXEkr5iGwblD1+IHd
         sueCvPQFHklTGp7t+V6MbMQrv/XMaBhmXa0+lpZrr8Yri/yyrhgWN+B2lIuc5PxYoKnI
         QktorKAQXEAclLo4ITnG0tIvbwzsQeisSF02kPnKGbLphmWTtbhDQZh/EeWbfRzs7Wlv
         eJaS3pyXWeOIb++WEp9JS0MECQfIYSQggHZ50kgG9KtA5PTMQ9Xuiybam2jZ6QLyvH4n
         9us7luNsZ58t0s057CHyIM+dOHbR7kov5mjNT9j7zSasF8SvtUAEsa/FVw0mgOiKezKC
         Ut8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710239342; x=1710844142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5d4B/pAoZQB5tS1BWWn28qe/xI29Jo7qr/wZ2JnyTFg=;
        b=Jq1JFF0rzQgADjoHRP4saRYH5/AhS+UfmIGu+h1pz7prqexSXQCcaxb3+lCZ55I7JI
         3kUmk7GAjIsLXZPHBzgi14yzG4w7m+W5Vkum1p2tIBiWfzrqffIR+i/QSb1zj2j4bctf
         yKK1VGpXyfaMLKjN39x82Y6wkeFczWAemSeQt+nLLs9jW92RbfqQOKP3ORtbcX9FzJgJ
         6ga07w54EJk33ChlCcHQa0mt1kHb1W9F9hdutxQeM12K2cNCPdBjZL+UWFznkdU+CbEy
         VpPxoapIeh7byZnOA+o/pZzqbJzOG786LFMus9gDDkrrU9ithhGHeYELyykdYQ5gLkbt
         bb/g==
X-Forwarded-Encrypted: i=1; AJvYcCWURJfStt9pBADTUMH3Zu4waBH8N7DpBxzJ7iIww74jji++u7sH1bW3OkyFKS47H0mvKrGovOpS8X7IJ5OJJykVQZL/pPLp
X-Gm-Message-State: AOJu0Yxd5fMOhXIKXe6CgjQvJ/x/nPwHddlkTnsReexKsCco0eLwPKYr
	Q5O0dbqf92XfIkd3l2UYKi20+d0+wuKqh+FvBKmusiyH4koGp78gOuqDuHABTpE=
X-Google-Smtp-Source: AGHT+IEtUTnilAGbJcn+GRXMX4RNIS078U7C8s6e6rzHKdm5WSpVA53oIuu5hDIUApB8xtk4QdMhSg==
X-Received: by 2002:a05:600c:5101:b0:413:2966:4bfb with SMTP id o1-20020a05600c510100b0041329664bfbmr4277240wms.1.1710239341697;
        Tue, 12 Mar 2024 03:29:01 -0700 (PDT)
Received: from [10.3.5.130] (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b00412f428aedasm18656971wmp.46.2024.03.12.03.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 03:29:01 -0700 (PDT)
Message-ID: <88856abb-f5f8-4dbf-9b26-30915bfaee7a@baylibre.com>
Date: Tue, 12 Mar 2024 11:28:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net: ethernet: ti: am65-cpsw: Add minimal XDP
 support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com>
 <20240223-am65-cpsw-xdp-basic-v2-2-01c6caacabb6@baylibre.com>
 <356f4dd4-eb0e-49fa-a9eb-4dffbe5c7e7c@lunn.ch>
 <3a5f3950-e47f-409a-b881-0c8545778b91@baylibre.com>
 <be16d069-062e-489d-b8e9-19ef3ef90029@lunn.ch>
 <f0a9524a-08cd-4ec2-89f8-4dff9dd3e09e@baylibre.com>
 <ff4ba8c9-8a34-41c3-92ed-910e46e1ca99@lunn.ch>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <ff4ba8c9-8a34-41c3-92ed-910e46e1ca99@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/24 17:43, Andrew Lunn wrote:
>> 3) From 2), am65_cpsw_alloc_skb() function removed and replaced by
>> netdev_alloc_skb_ip_align(), as used by the driver before -> res = 506
>> Conclusion: Here is where the loss comes from.
>> IOW, My am65_cpsw_alloc_skb() function is not good.
>>
>> Initially, I mainly created this 'custom' am65_cpsw_alloc_skb() function
>> because I thought that none of XDP memory models could be used along
>> with netdev_alloc_skb_ip_align() function. Was I wrong ?
>> By creating this custom am65_cpsw_alloc_skb(), I also wanted to handle
>> the way headroom is reserved differently.
> What is special about your device? Why would
> netdev_alloc_skb_ip_align() not work?
>
> 	Andrew

Nothing special about my device, I just misunderstood.

Regarding page pool, I now have better performance.
Two things were missing:
- I did not call skb_mark_for_recycle(), so pages were freed instead of
being recycled !
- In page_pool_params, that's better when I specify the "napi" parameter.

Performance improvement is not that impressive, but it's better:
505 Mbits/sec (with page pool) instead of 495 Mbits/sec (without).
There is a ~ 5 Mbits/sec loss due to additional processing in the path, for XDP stuffs.
So, the difference in favor of page pool using is ~ 15 Mbits/sec.

I'll send a v4 soon.

Julien


