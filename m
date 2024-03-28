Return-Path: <netdev+bounces-82851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B192D88FF13
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 13:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C721F2447B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0E7E767;
	Thu, 28 Mar 2024 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NSyWSFj6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537F5F87C
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629265; cv=none; b=SSn2UlhYY+jv0CXKFx1H+qxzLqTktGxwh8udUFzu/94c/uR99QywdtRmTGV64GIWkv06g3SkqDtKnT31xZUIhXwr8FXX3Et3ioFu1Tpl8+xX11DOgbepFfjnfolPbaPvpu39tkmsd8PsWAMMX83kMBEytjPfBBZcyRaF11Xl3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629265; c=relaxed/simple;
	bh=zX2GWYXPtC7qjhq9kFDCMg3asCTHBNFGRevEEyfJ4pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hcxs8Lx9D+qO7JMtb8LkBxva100kEIiDBIEJIeZZryvy7XRYMN+PndetThFP5gMdCmx1fr+x69pMVEI3xLfcMlB5g9uNYPV1A/3aDOwbidgUs8EMi7VC/vLdbMQEEuc4jdAI7wiCb5UXRes0IQVstr+D8OGeHl14xvuSOlgGW/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NSyWSFj6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41493e0fbf2so6229545e9.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711629262; x=1712234062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWn4vKf6jmo6u/KAkidvDYA7hMTdnPHRFemGgPWSlIk=;
        b=NSyWSFj68eR8wToM0XskqZHMJ29ZmkRU/fJ+NFfAUHhG0HmaKu0bBTvq4QkfzMGjmH
         jUAEtrsdZFPxsSvlIAdvu4Dw2VNqcrSAaVGTmQf7otdSslwPlTAOxxHk4+wM/q7R5jYd
         KSY+/dmahb4erl5kG39qfc7NCHptH8BslDFoGHXL7NCC9zHoBtIB11axS9h9RaBGx97k
         X5oms86dove+9KITXsvdyYjeGMDys13gA0NLPZC1fuxEtRywv1WlTYQ9f1OtasQZgD7w
         X4XnDgNPOs93OKplHCkWKCufTJoFx/W5yj33Q4qbIkk5yI24Ti8upUn+0ni+haAdNNHu
         PtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629262; x=1712234062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWn4vKf6jmo6u/KAkidvDYA7hMTdnPHRFemGgPWSlIk=;
        b=eaXd9lrbEysnlYIkqMYLgKlznK6t4HTct8Cr/omLSQJTFJD8WWI3TYob1rLr3qHodn
         6peG8Xqi/FHIEgWJNCrFG7wbCcSNQpRICwL3zjLAmpKHk/pLW9WN+W6o5FHfYl243F7W
         g+sCzVwR35QdskwUqkRlDwSufunoYG+Hs3E+ukTG8MoDZ835InXYadiB33gfXrEMfmF7
         VCSxvnCySs0sULvsAWUIL4BTKC8ShRZREwcPrZ5W52L5sAK5xjHHXI1XdwYK4xiqEIb+
         PjtprUPP0lic5HGWaG1LzrMNjA8zlsMyK2LrhBcttFN+FvZMeZbh8jObB8IbK6egOwCr
         zXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJulBGehTjI03BSOfbaOOioZ/Ec8UnrPgnjyyWJ/MB09Sd/8I2/Xq+jhXQNkGEdQoKTX8xuaHXUqc90f8HvV5hjUlihyBf
X-Gm-Message-State: AOJu0YyS6+MuwVkuE19jbqUr7ect5bARhTz3P+O51bAJdt2uq6JF1/6S
	TDAt9VoJuHn7z+o74gKmaTy7nP29ILr/8BkbzZMObTtoHDv7TbCq/UDXHijg8l4=
X-Google-Smtp-Source: AGHT+IFLB/cUHJWkbnWrK10eduOa8rRtXuIj5s2I8YXRQ+IvMFyMnMJuaj5WaCt6J4TWoyPiuBZHlA==
X-Received: by 2002:a05:600c:45ca:b0:414:8948:621c with SMTP id s10-20020a05600c45ca00b004148948621cmr2473201wmo.8.1711629262250;
        Thu, 28 Mar 2024 05:34:22 -0700 (PDT)
Received: from [10.1.5.112] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b004154399fbd9sm2287689wmb.45.2024.03.28.05.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 05:34:22 -0700 (PDT)
Message-ID: <34f9a771-08dd-4db6-9790-cc5f70f707c7@baylibre.com>
Date: Thu, 28 Mar 2024 13:34:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/3] net: ethernet: ti: am65-cpsw: Add minimal
 XDP support
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v5-0-bc1739170bc6@baylibre.com>
 <20240223-am65-cpsw-xdp-basic-v5-3-bc1739170bc6@baylibre.com>
 <20240328114245.GA1560669@maili.marvell.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240328114245.GA1560669@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 12:42, Ratheesh Kannoth wrote:
> On 2024-03-28 at 14:56:42, Julien Panis (jpanis@baylibre.com) wrote:
>> This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
>> Ethernet driver. The following features are implemented:
>> - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
>> - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
>> - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
>>
>> The page pool memory model is used to get better performance.
>> Below are benchmark results obtained for the receiver with iperf3 default
>> parameters:
>> - Without page pool: 495 Mbits/sec
>> - With page pool: 505 Mbits/sec (actually 510 Mbits/sec, with a 5 Mbits/sec
>> loss due to extra processing in the hot path to handle XDP).
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> ---

[...]

>> +static struct sk_buff *am65_cpsw_alloc_skb(struct am65_cpsw_rx_chn *rx_chn,
>> +					   struct net_device *ndev,
>> +					   unsigned int len,
>> +					   int desc_idx)
>> +{
>> +	struct sk_buff *skb;
>> +	struct page *page;
>> +
>> +	page = page_pool_dev_alloc_pages(rx_chn->page_pool);
>> +	if (unlikely(!page))
>> +		return NULL;
>> +
>> +	len += AM65_CPSW_HEADROOM;
>> +
>> +	skb = build_skb(page_address(page), len);
>> +	if (unlikely(!skb)) {
>> +		page_pool_put_full_page(rx_chn->page_pool, page, ndev);
> Is it compiling ? third argument should be a bool.

Thank you for the time you spent on this patch.

Yes, it is compiling.
This was intentional but it may be unclear indeed.
I'll make the bool using more explicit in next version.


