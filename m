Return-Path: <netdev+bounces-77436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7961B871C4E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00C8EB22B64
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6664F55C1D;
	Tue,  5 Mar 2024 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1TKr1Kug"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F541DDF4
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635567; cv=none; b=oYzNXfI+DOEf6D5744AAcuZ9jWCJnJ7hvTafovOXBcy9j1X+VANjsVwGPyCI7+2MQAf5/wTN11v5z2VBvM9Tjcep43hOoZEhrkJgceVs2W+ZsP5u2jyUomCrlc1C/2f2Wg8J+DhpdHfNRmFgs1H9t0FxBAzGTLGa0FFflj4hYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635567; c=relaxed/simple;
	bh=XklbFoUwOSii+y74bxc36aiADpTAj4ZlGh81v8WRHIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTs9ITIABZthauu1BY5kE+xgQ92i0up9hk+iZcWEBRagTZqOJ8Ziq5w9KZPQvITcvjo5qExBomsbpBPSIN4m59hq6014Jj3E8ov15lcbmpVNHi5j7dbZqkXrF43PavtEJVmCrbNsE80eX0veCEViHKYIr7sVlUdN7JEjA6i+dzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1TKr1Kug; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412e4426e32so13445815e9.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 02:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709635563; x=1710240363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVA1JqDTMPvckuRaTHq5sqq6pnFxGrbQ8TF6seYnelo=;
        b=1TKr1KugBceesEMwMGGzcf/55Y5czeuKgOSW8hUF2A4z7TvXPZbUOYgeR1XgC1W/Xg
         fKqN5vLnGGhZQyCuRQJSNo5wDVwWgzN+wl/3+IgVxcE/a9NgkVomCTb26LqDu5keSi2p
         ADFNs7kMiKQom8xrncsefJ69WNlttJumkg5B3ok8fALTscJr7sHXGdRQIWawG8CKkn8v
         8NBwMQPflifIgKMGDtNLbRnndmhwfDKlJ5sP7q99z8un65B8i2ph7TBDP4NDHH1zoqVO
         hew7XKZ4Y74A56I0i3IaOqyfe6sQq/8lYaTAN1cPZ9s5xelmmU2PJgnuMZtXFOwWpdM3
         gOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635563; x=1710240363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVA1JqDTMPvckuRaTHq5sqq6pnFxGrbQ8TF6seYnelo=;
        b=TA/k2nq9SAB9MFfdH8hw6sv5RKZRS8h7rVwTWtXJk5XELjQ5YgbV/zXfiIP1kNT4iV
         iLdXel6QExZNmu1n+wRCZCkRtMIcT8hlMXZlm7u8LaM2NFBMD6qeyqsLDylanKodMXTt
         N1GLGxcdi6a/G5L07sIO0AzBlYtZGxLc4v+pyPotYZ8Co++1hjSJ+GCmW2k3IhWUI8Xf
         XbCeIGyGDdVi0htH3WfUEC/uIq0EtOuc71uHhgHvp4I+y/nzrh2AqdRJL8e8jVhqC0/A
         4cAwfo/X/qgY5h/Z0gHufxumaCB+ruenOuEzIzz2acys7I77K7b/RlgqBikpwRfXMia7
         WFlw==
X-Forwarded-Encrypted: i=1; AJvYcCX1VoE5FU9Pw576I+crBU4w/boqfUWVvacF3yye+Qxfjjn26SjBkYJ3DvKa4F8RioWlmKRAcv78dy/NYM4DsBUSDTZoVvi0
X-Gm-Message-State: AOJu0YyMdxu5swZkL4zMZMbU5XzxhPldwtawGky//9MzPv8Qt6BgOLJs
	vJZXLJmUiHShMqdUcmo2qbMXJH97EyrL5MyhPzjVJFCHFz24eUg2++cjX2jzHx0uGmPVNanS8+r
	3
X-Google-Smtp-Source: AGHT+IE/L4A6bnauZ4LpcW6naeeYuRNA8WEWJrlnt645s9ZaWVjgn/tE11DGJ0F5XhXa7k+kx2lEzw==
X-Received: by 2002:a05:6000:1249:b0:33d:2226:a28b with SMTP id j9-20020a056000124900b0033d2226a28bmr7827513wrx.37.1709635563236;
        Tue, 05 Mar 2024 02:46:03 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033e052be14fsm14577187wrw.98.2024.03.05.02.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 02:46:02 -0800 (PST)
Message-ID: <3a5f3950-e47f-409a-b881-0c8545778b91@baylibre.com>
Date: Tue, 5 Mar 2024 11:46:00 +0100
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
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <356f4dd4-eb0e-49fa-a9eb-4dffbe5c7e7c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 17:38, Andrew Lunn wrote:
> On Fri, Mar 01, 2024 at 04:02:53PM +0100, Julien Panis wrote:
>> This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
>> Ethernet driver. The following features are implemented:
>> - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
>> - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
>> - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
>>
>> The page pool memory model is used to get better performance.
> Do you have any benchmark numbers? It should help with none XDP
> traffic as well. So maybe iperf numbers before and after?
>
> 	Andrew

Argh...Houston, we have a problem. I checked my v3, which is ready for
submission, with iperf3:
1) Before = without page pool -> 500 MBits/sec
2) After = with page pool -> 442 MBits/sec
-> ~ 10% worse with page pool here.

Unless the difference is not due to page pool. Maybe there's something else
which is not good in my patch. I'm going to send the v3 which uses page pool,
hopefully someone will find out something suspicious. Meanwhile, I'll carry on
investigating: I'll check the results with my patch, by removing only the using of
page pool.

Julien




