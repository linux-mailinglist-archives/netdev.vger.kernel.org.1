Return-Path: <netdev+bounces-231646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CB8BFBF72
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A36A7355A41
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 12:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F212347BB5;
	Wed, 22 Oct 2025 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="UNS2drj+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F16F344046
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137428; cv=none; b=inOWAkP+X6D/G8AwLM50dLfcuzreUzZgq5n9xm6IHU4b0UCBKr5AG0jlmS8COvXUCT/gvkR7+qF76w3zocN4ceo+1VGzk9upgQM5XdF3JxZy1WbGwIiozZ3KYrmqBFQfXPNI/c9VKRsEja2O1QFMMGFK6RKei+fB3UyGxoCgwBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137428; c=relaxed/simple;
	bh=ZXohKXzTXjxyhGmIta74tVz7YubZEcgHibf5y0hQrzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyISqr5/+uVgJVAjDinKoV3hql90Y5cNsa/m5ngKGZQA0UN6jynXZWvSFkKJAlQzIRTQiX9Dh7Tc4LhMZpzBcn5aL+cxpliMC/xhjLU9P44znNtLBJVD1TB8mSI4Sgj5sUwT8gB7m5fd3oXA9a2l/xXZazpRYBDomubJcQlh3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=UNS2drj+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so1313639766b.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761137421; x=1761742221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlBzXeLMRR7oz24/jCJCTbfxBakkjsQ0pgWftELTrS4=;
        b=UNS2drj+Nt/qR4ZfAnlpRfG8ploIjPfOdCa7LIwderQ2zx1Wb5UvuJL/FtbD4G18xi
         VB1IVyaQm7gbSNzJoZxVCL16kuGgGdIg0jBAetw1m9QEwuLTiegmY9JckKG4qHIv17tz
         9+lVxvn89f1CgCz+dygcoewS9TlJU0tn9ldDf7AzeMQqOQVDPb4iTJQ9Eg/yrurTQB36
         NBVQ3agKEOdjbh0ZEK+htdV2HuiycS86FIjiMdmFBH232pHsA8yhlh9Dv6Ke5hzTQ4KW
         PbXpM+UqnX/+l4soczXV+ySTUsDqqer0g/cxZzKK+P/+MJOQya9NeKWJfCfDCehQtlJ3
         cnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137421; x=1761742221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlBzXeLMRR7oz24/jCJCTbfxBakkjsQ0pgWftELTrS4=;
        b=OHhjdq4XuFZqGCStjougxQ1OHFMm+fK4v5tBa6KmzwN2PZGLj2INa0jcICRYgH5fcx
         E4EbLGZRWHQmJOEosNQRTEONiFITfDIRK54abVODKgPibUtox0+BDPoxIKr8UyPOq0qr
         YHHZMZQJx9dtdIY2ue1pwO4qPoVCS3ZnyLsx2bs51qZghntXMvjJACZz2NFWdpy2WiPd
         J1oR1aoqeC8gl8dj+CMq/xFs3xqfre9xr3im1BsfqGN1ieVNwCMQTvxG/WwixcneOhDL
         JLnFapH5y50tBtLdWjtzGsUSVYqWE/1GG3OAo9gQS6uxghCMr3XGisiFFdYY/imgOmUQ
         vayg==
X-Forwarded-Encrypted: i=1; AJvYcCUZDcuwg8IUxqjjxRr0vmO4y21IImuK7paqLj8pKuREnYLzcMtJIhe8YDM92+yUSTgTxhv1t8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyYFEGtB6rI1GxPN8dx6Ulh43LRwSmve4dHIRiuwaZRi0z4TrD
	7QkGKOuJ2nWOKVScPHBphH3iTBqiIrHI3RsXoNGnghP30yU+irGkGP5rg6U3QD3h2TQ=
X-Gm-Gg: ASbGncsMMJOmYoPeK9Qc8Fnd2CiOGh1yrBaE7XyMcX28AYFtapMjuWmJEV0VyF8/o22
	Ui3Cb4dMcgj65FRPcbzDobH7COSL95tHmONMS5NFBo9qJsJqfCIhIFGk6bT94qCfZxFIIhkzkN8
	qZK8x8XRcJtz8x0pcvVT+Nh97Ik+rWlAckT7csjoZWex2oQCM0TUDAT8A3wVPrumWTzAup6JAYe
	5+z97EzsGXgGXkGy31XCe0HvTcsT0OE+obcsM9iFeick9+R4+hbYzeV/CFThemYvIyUflDt7dEL
	aRQRq+IIP/2BbTq7DEW3QGgRcPiUA3LLVeJbUbt61651kt/rha5jESwtuxfE6cSl6R5yC9M/Sx2
	K8XGYt9ovqz8+OFXo+5ovzBDguGrBUotTr3fxqG9UzQuNarjwjwWHG3GpZxXhU3iqEIQPAxeJF/
	rCpx2P0og6LM1sgJr8AS4nFwE81nNk+BMfHiIc/5DeBTQ=
X-Google-Smtp-Source: AGHT+IGK2M2QMmjt0Ltj+ax30YpGqmkyiLmafC7IwyMavI6cGNjRmi8OmQnBBPx18MSOTcJS0+DWug==
X-Received: by 2002:a17:906:9fc1:b0:b41:3c27:e3ca with SMTP id a640c23a62f3a-b6474039b13mr2332953366b.7.1761137420912;
        Wed, 22 Oct 2025 05:50:20 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d3501ed5esm144343666b.70.2025.10.22.05.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:50:20 -0700 (PDT)
Message-ID: <f610a76a-c482-4e3d-b652-237261955553@blackwall.org>
Date: Wed, 22 Oct 2025 15:50:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/15] net: Proxy net_mp_{open,close}_rxq for
 mapped queues
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-6-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-6-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> When a process in a container wants to setup a memory provider, it will
> use the virtual netdev and a mapped rxq, and call net_mp_{open,close}_rxq
> to try and restart the queue. At this point, proxy the queue restart on
> the real rxq in the physical netdev.
> 
> For memory providers (io_uring zero-copy rx and devmem), it causes the
> real rxq in the physical netdev to be filled from a memory provider that
> has DMA mapped memory from a process within a container.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/net/page_pool/memory_provider.h |  4 +-
>  net/core/netdev_rx_queue.c              | 57 +++++++++++++++++--------
>  2 files changed, 41 insertions(+), 20 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


