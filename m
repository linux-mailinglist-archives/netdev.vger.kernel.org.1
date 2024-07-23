Return-Path: <netdev+bounces-112556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AE939F2B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 12:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1201E283632
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D814F11C;
	Tue, 23 Jul 2024 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a89HfaVe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA914EC5E
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721732380; cv=none; b=VJxKDUxOWyXc8UKsyqnCyt/6XZRMp3f4/nyw5i3Av8BUAiPyPammXW9TnBWRFL2i3aZxe5FQsWxpTBZH0JDJlwCKlPDwVk29b0fVmfqE6mPuWajn9UNeYdc3fHoGUVk1MpFQYI0J15UHUJmZ9RiIkEA0zYMK3rvPstyal2jyd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721732380; c=relaxed/simple;
	bh=rsxd8jvdP8INdvllDiiuyS36A1hZWjMKSpBbyz4s9js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWkJ105Khhv40PEiu4/6+3XNC7vvoUZzdvLvDFSbTY9QoBaEYb2aj+8t5hPS82620utQHSHB+2zxqNmB9YmhwebdT942BbUEr2gUcbK2bS/90D3mKFNOV6VMpWaf3RehbLaA2SoZzByXxBDw2qSA1+8y6wp/cPvq0EgdBlS5WJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a89HfaVe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721732377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZR2IpwmC4cG8RiESVS+LRqoQwhjOlsPShdcAsa0P/0=;
	b=a89HfaVe6vn8+sW7XnPadsBW0in0e4A1z+fU5gK1ww2FcDrEKbgDoeaxkW2mBaTsRuvwEL
	5NYFRK06tDslmNEq6MhUsk0w4WOnIdI4iM8N0muVr/a7MxKWpr3Wiu8aSf4xAxUDh+9yBM
	r9Hx7iVz+VkGSOZCDVxlVrmkBSIaY28=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-rI7XtbVJNOqylDKiZRk2SQ-1; Tue, 23 Jul 2024 06:59:36 -0400
X-MC-Unique: rI7XtbVJNOqylDKiZRk2SQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36845f43a96so899919f8f.3
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 03:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721732375; x=1722337175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZR2IpwmC4cG8RiESVS+LRqoQwhjOlsPShdcAsa0P/0=;
        b=McRpaUvL2z+AC+T3zh24MjY27aaAx1LrbjSjJc9ydiF9wW/n9GBUZ7mYFu57qkPK2H
         u67uqXq9AhtdSMQukRBP+9Uf22e7QWUGQNHCedztzcHTlbGQ6kQJwvDtKx95WZXIZmZP
         NSKCxAqTNCjurJWDwQrP6wgcGkMcYb53cx/ypGIjSCGlf/CToY+s/IHjJhbaxLwrmc4l
         NnhrnSN21s8KGmO5QNdljTNCc6/gRRcwGIY0FqRKEnTA1Bm4comtWiL8ws0GsAVE3s8q
         A/Hga3a6XjLImvztCXF7LNr/rqI0hNjSqYnJMer1p5H85LzXX3BpeWTcbK8YVGLBO3AQ
         ZOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjy2kKpFM4dyYTZu2ATKET2HtVDMaPiHCvFHEo+ORo1GMGmLKpT60KbGDCz2UW/XsEmEzDxHy1m8KN8unw2FyBFpIh4VNj
X-Gm-Message-State: AOJu0Yy0fGIH8ufKDePt8BPMCFqiivZG654cqqSUpMz5JLD+GDBbhfY8
	eNYVz7ZY2GAAkRPeeA/eWryQYO0xvPnNPjC2D1rX4PGUVlZcCz/YYrZlIAfSQp4ybr76YIU8RnT
	cdOZBST8v1k/eOIu/wrtUaB6ZI4k26wJd/bAKZD0acWNisqcMLburcQ==
X-Received: by 2002:a05:600c:511e:b0:426:6358:7c5d with SMTP id 5b1f17b1804b1-427daa8889emr44634375e9.4.1721732375176;
        Tue, 23 Jul 2024 03:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLtHC+rf4IEXrxwJ2FDzxlyKqONBXPS2EN2rBJ3tBlgIylGrz1i3ae1FztSShIJ8lRDgrLhA==
X-Received: by 2002:a05:600c:511e:b0:426:6358:7c5d with SMTP id 5b1f17b1804b1-427daa8889emr44634185e9.4.1721732374778;
        Tue, 23 Jul 2024 03:59:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d68fa9b1sm170722895e9.8.2024.07.23.03.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 03:59:34 -0700 (PDT)
Message-ID: <7657b8ca-ce93-46a5-93bf-f5572ba7806b@redhat.com>
Date: Tue, 23 Jul 2024 12:59:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bnxt_en: update xdp_rxq_info in queue restart
 logic
To: Taehee Yoo <ap420073@gmail.com>, michael.chan@broadcom.com
Cc: somnath.kotur@broadcom.com, kuba@kernel.org, dw@davidwei.uk,
 netdev@vger.kernel.org, horms@kernel.org, edumazet@google.com,
 davem@davemloft.net
References: <20240721053554.1233549-1-ap420073@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240721053554.1233549-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/24 07:35, Taehee Yoo wrote:
> When the netdev_rx_queue_restart() restarts queues, the bnxt_en driver
> updates(creates and deletes) a page_pool.
> But it doesn't update xdp_rxq_info, so the xdp_rxq_info is still
> connected to an old page_pool.
> So, bnxt_rx_ring_info->page_pool indicates a new page_pool, but
> bnxt_rx_ring_info->xdp_rxq is still connected to an old page_pool.
> 
> An old page_pool is no longer used so it is supposed to be
> deleted by page_pool_destroy() but it isn't.
> Because the xdp_rxq_info is holding the reference count for it and the
> xdp_rxq_info is not updated, an old page_pool will not be deleted in
> the queue restart logic.
> 
> Before restarting 1 queue:
> ./tools/net/ynl/samples/page-pool
> enp10s0f1np1[6] page pools: 4 (zombies: 0)
> 	refs: 8192 bytes: 33554432 (refs: 0 bytes: 0)
> 	recycling: 0.0% (alloc: 128:8048 recycle: 0:0)
> 
> After restarting 1 queue:
> ./tools/net/ynl/samples/page-pool
> enp10s0f1np1[6] page pools: 5 (zombies: 0)
> 	refs: 10240 bytes: 41943040 (refs: 0 bytes: 0)
> 	recycling: 20.0% (alloc: 160:10080 recycle: 1920:128)
> 
> Before restarting queues, an interface has 4 page_pools.
> After restarting one queue, an interface has 5 page_pools, but it
> should be 4, not 5.
> The reason is that queue restarting logic creates a new page_pool and
> an old page_pool is not deleted due to the absence of an update of
> xdp_rxq_info logic.
> 
> Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

@Michael: looks good?

> @@ -15018,6 +15019,16 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
>   	if (rc)
>   		return rc;
>   
> +	rc = xdp_rxq_info_reg(&clone->xdp_rxq, bp->dev, idx, 0);
> +	if (rc < 0)
> +		goto err_page_pool_destroy;
> +
> +	rc = xdp_rxq_info_reg_mem_model(&clone->xdp_rxq,
> +					MEM_TYPE_PAGE_POOL,
> +					clone->page_pool);
> +	if (rc)
> +		goto err_rxq_info_unreg;
> +
>   	ring = &clone->rx_ring_struct;
>   	rc = bnxt_alloc_ring(bp, &ring->ring_mem);
>   	if (rc)

Side note for a possible 'net-next' follow-up: there is quite a bit of 
duplicated code shared by both bnxt_queue_mem_alloc() and 
bnxt_alloc_rx_rings(), that is likely worth a common helper.

Thanks,

Paolo


