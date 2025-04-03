Return-Path: <netdev+bounces-178983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BDDA79CDB
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 09:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1BD188D9EA
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400DD2405ED;
	Thu,  3 Apr 2025 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZye6mhy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5623FC4C
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665054; cv=none; b=QL4+uId08W/kTw8R0fYK+Crzw4tmwDC2lEVyfST1rTzGZVvSavRhLiNiI0dGbKoSJKMHA0JmHal0jTP6rK+6QIRBFxMMq5iJBkzRy+xzUbEN1mLbiAnAgGcxKZtNi0ZmDpzmpmfMIwuNWFT7UuwMy5a3iOj+XmMYK2BMa9qmcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665054; c=relaxed/simple;
	bh=BmGXNVrTqxXAkUExqcGcIkfGVthayzRf/XdQRf0ErJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKYdqfCmUnwLKKSCKzB3zVlpNgm14XWZANU5aYluyPDOLm+88F2L7CUihaJAVjHdYF8QzOaVxmxU5mSR3ahVzExgtODx0zmIftW7bM9CTwg2Qp2JDch7VxWKKCCl4kkgufF/Eyvi7jap+ra9cu8+sxFBYKIf6pZm2RuoOXaObDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZye6mhy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743665051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4GpbdVAioAsBhxItBe3Gp1I1aqveVV1B4xHRWy2NlY=;
	b=fZye6mhylmx+dpbsv2k4N6OZMzqaOgsvd/qgqR3DLbEhi59sHTr3QISe97Kbsb37eQ8zkz
	LOCrYZC5lSV2SNy/d5dycRKQ6pMfY3l5n4acDkgOSsJDRl5qsmBRUyR3wLZ9wsafMeyTU5
	q6vcxp/WPWcnxpEcj91COc/s4cm6nYI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-I0lCar_WNtCAszSk2Y_W4g-1; Thu, 03 Apr 2025 03:24:10 -0400
X-MC-Unique: I0lCar_WNtCAszSk2Y_W4g-1
X-Mimecast-MFC-AGG-ID: I0lCar_WNtCAszSk2Y_W4g_1743665049
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so2998415e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 00:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743665049; x=1744269849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4GpbdVAioAsBhxItBe3Gp1I1aqveVV1B4xHRWy2NlY=;
        b=DFmQ3oQHo8H79t5h29FYBNtKt0Ax1IXwfXRFu0Y6fNC1lZMjElahHxEbkOkl6luJws
         5lpEYziNNmC9PKEILhZH7l0p+8vRnm483pg2SzR3jwVCO2EgljD5POsd3acorDRivXVA
         ZG+ipgr9M4h4OZTjSVUYRnRlwIcBUy865neM9Wu4hsYM2+zzQl/oYni9e0yIZ4zRc1OC
         MQYgIXZe3aFtiHlefjP2pxZ+7lrhZTOxsI91QkXw1FC3s2hv4f/Yw9CCNfBmsmOjPoFs
         gk8tW5JEbRfyNwJvubMbZNX2WPdkFmY4ggHBVA9QHiOz6kWKElyyzeafFJrAl7vhFCab
         YhOA==
X-Forwarded-Encrypted: i=1; AJvYcCVcnqYQZkTIKArwzEdZ+abH9vnw8+GBcFWb+wFcQfig276uq/bblU6gntmizzUO9M9AXSRpAzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+OV/zjDBMIjtgTobk0HxDfpqN47koxMj0p237PH5h4skQaa/G
	A23Y0F6sgv0WqzsWi5er5vF0xaBQ9a74umq/aGuvw6E/QMA69fdwcXBHnIqKqMB973c40Srh0uv
	0qkrXipkZZ7uy3/46MwAGBMGR2t5JqeaJOJ24st3IoLQ2dzrpVc2gsg==
X-Gm-Gg: ASbGncsexFWmCjmDA8OpprNplkrLH2rcpUb8hoA/LXuB5KvqAqh7axsILHlluT9bepE
	02WUIARDaUQ7pPeaNCS3XEJ2KTmexewfgrnOAik8DlMZkHpaDCPLq0xFWsC5Gyi1xojNpQPJkO0
	cISEc9Z2uscoSi+e4XlvJvJ5PLm0CCGxqJHtTZwew7brpxOJGbG/BflMlgxKGffconcGF6JJ6H7
	0z5sgA/1dhzCmrVws1bTgsxHlCSiyX93MBtOt9wVY68zNmKFWXDVB+uvWMZFS2bmxqYM8I1yMaW
	0/vDQY7q0FaAYV2PKMl1QfMp0Bzkv5TBLT1gFC58w/W/aw==
X-Received: by 2002:a5d:6d8a:0:b0:39c:dcc:f589 with SMTP id ffacd0b85a97d-39c120dd036mr17302216f8f.20.1743665049145;
        Thu, 03 Apr 2025 00:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLjiN+esCynIJ2+bi2OUprGrFibkCQORORxWzFxwa+nAcvodEQofseNEFH/q+D6t/l5rRnhg==
X-Received: by 2002:a5d:6d8a:0:b0:39c:dcc:f589 with SMTP id ffacd0b85a97d-39c120dd036mr17302194f8f.20.1743665048726;
        Thu, 03 Apr 2025 00:24:08 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d68esm975281f8f.67.2025.04.03.00.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 00:24:08 -0700 (PDT)
Message-ID: <4b3bea7c-110d-48eb-bcf6-58f4b2cd1999@redhat.com>
Date: Thu, 3 Apr 2025 09:24:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when setting up xdp
To: Bui Quang Minh <minhquangbui99@gmail.com>, virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250402054210.67623-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250402054210.67623-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 7:42 AM, Bui Quang Minh wrote:
> When setting up XDP for a running interface, we call napi_disable() on
> the receive queue's napi. In delayed refill_work, it also calls
> napi_disable() on the receive queue's napi. This can leads to deadlock
> when napi_disable() is called on an already disabled napi. This commit
> fixes this by disabling future and cancelling all inflight delayed
> refill works before calling napi_disabled() in virtnet_xdp_set.
> 
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..33406d59efe2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5956,6 +5956,15 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	if (!prog && !old_prog)
>  		return 0;
>  
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	if (netif_running(dev)) {
> +		disable_delayed_refill(vi);
> +		cancel_delayed_work_sync(&vi->refill);

AFAICS at this point refill_work() could still be running, why don't you
need to call flush_delayed_work()?

@Jason: somewhat related, why virtnet_close() does not use
flush_delayed_work(), too?

Thanks,

Paolo


