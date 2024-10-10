Return-Path: <netdev+bounces-134158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FC399835E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99331C21C09
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFB11BE239;
	Thu, 10 Oct 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwjVlgNr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1604B1A0B0D
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555546; cv=none; b=JnVPKrXGWZigMCr1fbRBXNLDffkdce7isKHUVWkC+xxTRgiyws2xgHosPV8IupxqUeeSU0dD/aegvhPUkb3A59OFAA74QM7oPZ6RwuwIX0ViAfztBWD6NS3/NNOKyfeXsHWe5Tq/ABqoXJjRqdD3X9kJhLkXC2VS2ZmXFndpW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555546; c=relaxed/simple;
	bh=You3KciRBccqTPyQfD4ephnvb2Dnj9UR8ls2ZmPUhMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVHzmmjg0Sk/MkXJKgFkPc8yCS0cGZ75iCdWwcrBVPKrjem2hhSNWtrAgMUysUs+hzji9jW0t60jo/lx8CCTGCYRJEKVWpGZnNztimb5Gm0CtFBRyII4WE4S+Cz81iNHphJjfA2K15zGQB1lRyqvq0feG8a4A8ejolzxeUjzWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwjVlgNr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728555544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mUL67vRK9vnSx2DO2qXf7zuyyE8wI/OX3Z3NmwagL0=;
	b=hwjVlgNrExhWpuD2HIZYlk85iCRLeMaWMhZD52ZlxIq+UFWIW8LQecYXqh5Mfj8o/3X9B/
	MLxLDB2hWfPofu9tUTpltvDoOrCM5yBBJbLjm4x8DclYcex9Sa8kdI2E07PWZ7N2eYXoEU
	AwIn7DIW5q/qhBuq/HyBaCuogm0+SAs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-7RYtBWXiNAyZ7H792xs5Hw-1; Thu, 10 Oct 2024 06:19:02 -0400
X-MC-Unique: 7RYtBWXiNAyZ7H792xs5Hw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43112243946so6415275e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728555542; x=1729160342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mUL67vRK9vnSx2DO2qXf7zuyyE8wI/OX3Z3NmwagL0=;
        b=Q43weVGxbx+UFt6ccI0LIEDbTNkFi5O3JqT/SBIYMFacKEgUwFGB6WDqT+8EtYlY99
         niop8xH+Ettdq+s9O7zd1q6vSagb50oB/UI2pFN+cqG2tvcNmq73izPp09JRNGVJO+MM
         jqgrPBknxCbgxC8KRNrYqsGGYQSmwYRXJF81XC0F2WI9PS4SU54AMC4NL2dN637rZexx
         HGXQnny0QhLNGDJRb8zPY+1IeHypSHXugZZmQwxrAs9vPVePPiuZm0uWFWkkLobw0VEo
         EfzVUVwTT4k/hVdpuaOHiR4QDu/kGpuoZHt1i9DBnd6QpiNBTwrQUlBC+qEDpBq6e+Te
         64nw==
X-Gm-Message-State: AOJu0YzA+xiLItRstBdITGLQ6aqQR54ZH5b1l8c7fKv6xfpdIr7xAcdV
	62pao8Rl31VGIh+mtz2EL+la3lneFQ+ddrDVLfNIiCO1XA/EfPzh9RLZfp7MXk+Zqlfw8w6L2Q5
	bpBaYynK02XN73re937EwwDlnuQRgAuy4SH76+l4TzOPRUQebn1nvSw==
X-Received: by 2002:a05:600c:45d1:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-430ccf3178bmr55212945e9.15.1728555541717;
        Thu, 10 Oct 2024 03:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGReol42k+b1smHe2ddlOvt20p66e2NQO4J33yLgpx2ne+CFj7o5KZ9l60dT2Hd4yXZXn4Fog==
X-Received: by 2002:a05:600c:45d1:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-430ccf3178bmr55212655e9.15.1728555541285;
        Thu, 10 Oct 2024 03:19:01 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183061a4sm11851455e9.23.2024.10.10.03.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 03:19:00 -0700 (PDT)
Message-ID: <d4413c7d-7c7a-413c-a75d-de876ccf6e09@redhat.com>
Date: Thu, 10 Oct 2024 12:18:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/5] eth: fbnic: add software TX timestamping
 support
To: Vadim Fedorenko <vadfed@meta.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexanderduyck@fb.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241008181436.4120604-1-vadfed@meta.com>
 <20241008181436.4120604-2-vadfed@meta.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241008181436.4120604-2-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/8/24 20:14, Vadim Fedorenko wrote:
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 5d980e178941..ffc773014e0f 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -6,6 +6,16 @@
>   #include "fbnic_netdev.h"
>   #include "fbnic_tlv.h"
>   
> +static int
> +fbnic_get_ts_info(struct net_device *netdev,
> +		  struct kernel_ethtool_ts_info *tsinfo)
> +{
> +	tsinfo->so_timestamping =
> +		SOF_TIMESTAMPING_TX_SOFTWARE;

Only if you need to repost for some other reasons: the above could use a 
single line.

/P


