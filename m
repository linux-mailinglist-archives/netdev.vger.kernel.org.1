Return-Path: <netdev+bounces-186794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A090AA117F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2EB17C1CD
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A1724336D;
	Tue, 29 Apr 2025 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLCPHVff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01B3D561
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944008; cv=none; b=LQfNxZxuYSoG56s8tGb73emSetvUwFOXOQHG7Ml1izBHKGvvCZl31iFHiQPu/rp0CMTXtBXZCLYt5P05oz2fuM2MLK8eOKmg9QMnUfocif6+kYyfL5uHnZbntkY2EiO2i/yE19Wj4GmzKQq/cC1EPB/D09Bp/xLaz+Vy9KICG64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944008; c=relaxed/simple;
	bh=3H0JTSYEGxPhjlYRtn/Nv0Vv9nZxrJjvYoSjVLqecN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pY+wuvFKCR1CM2anJRD/LI+Xz682Omc8H3bu6Iag8VTy1xBhIKeiSVpf+9DBGx8Ijlm99M2VlDn8O5Inna8J72SZYAuzfsVsfEFFvqLB4HQ+nNolew6b+DfBPErQExKS7azlPZIrBmIUdetZbzHG3CmfSVRpmd3ipoa0AKq+qhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLCPHVff; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-879d2e419b9so5535997a12.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745944006; x=1746548806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGCEkSX+59MDfrCtQdhXXvbqwMXoqiT57UYCG87NkWo=;
        b=jLCPHVffJrmUpOAbuYP2UFYeG2OxaeZss8yiBMRk+hfg5ZbQUdRaPA9vbZYwiDSm+r
         xewg3Xwe5k92NGofW646c6eBFZVnhdVO7H2Nwo1Pr14uIjQlEbheTTT4bT6ZMj/y8MZ0
         /QCNCO7h3kn/mqjE3KahgEzPkv4JcyXMoHPz+IIcPUDtVv9VxdsJljge8k+D7JSq50ix
         BDmAIxjduzJvTy1CwPInuC78qPK3prkRzsTULto8/d9Odp4cwQO9aolSCrsJPvL3t/le
         KuewSVgAAKoCq4ef11CTSlK2CdPGpoMzPGLHeO6SSjnw2RthGIIFf82WZilH8UcKZEx1
         A9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745944006; x=1746548806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGCEkSX+59MDfrCtQdhXXvbqwMXoqiT57UYCG87NkWo=;
        b=XfL8vP3VvT0XvxQr1HK5g0k2bZyMQU7C+1lprDfZNaTjz3qMtQQoMDKqLJCbK07woB
         +u9Ka0ou/6r3wpl2XSwSn55rtXlHYkpvPOc43fCa5iSNcy62DUANjGRA1jIYNdG17v4p
         e3mG0RR2O4D+q9A1M/vU7PKHAsL+WBUIMox2dS7io29N38qaA+Vw4ph5zgRn3Xhnx8oM
         +LgWbewHycxAlAJWXw3UUwAY+dydiDBwtPlC1BO7sIpH5vbACa/lWH8E94391LKSAYJq
         +P2GLiH4VOustkb3bNlFx7JnmsoNBAx5j8DZ2yYUIB5j/YMIY9ORgq2CK3ab/ZMG1Obj
         9StQ==
X-Gm-Message-State: AOJu0YxKdd15WFmyAmhW2l6VjyUsuaHl9FtjLkoEc7mBFgqDYqyS51vX
	WtqIyk7sidcBnAqCPiuiLVyhnAI5rojSLHo3B5uQ/y3rRFdeD01E
X-Gm-Gg: ASbGncsx+0FC42JhLNRP0gPx5eSb1Ymg2JuT2kjZwqONMQjvaAEZNz4yJ2wHwWJoPKx
	AB6DWwyqa9w8XW0mXFPgSoljHf5xau8oBAU4Q9bwiFrFVIr0L8xF44VUjIvXY8/pgFdqDwJOyia
	n0B4b+nHJ85hOlo+dveS5K8E8FXDJOTFK6P+skPmi6+XyOz5d/VJFvh0WGeFYYodv0eH93ZtYV8
	oileZi+kOc+zsOFZ6kyECf8b2wOLXvU+zPLNCp7j4D+RgIf9qLiINCCjYBfbxgvqHrYNxJPcH+M
	Op7yrDyHCYzeO6ney++xqBlDpp+LIPygIdnguPkZIRyIOuChpkW4pWsPBRuNRQGcoldtyh5klal
	iBveZQT4i3YJPepzvRRk=
X-Google-Smtp-Source: AGHT+IFYtxVTfVoUCdjEWv7KpPL5vInCXNQ/fvHP67A7c8ZKhmTj/5x4uwxkwIzoTVsCd3Lvt0ThGg==
X-Received: by 2002:a17:90b:586b:b0:2fe:8902:9ecd with SMTP id 98e67ed59e1d1-30a23dc1f81mr4052117a91.1.1745944005793;
        Tue, 29 Apr 2025 09:26:45 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:8dc5:2d78:200a:494d? ([2001:ee0:4f0e:fb30:8dc5:2d78:200a:494d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f782d4d6sm9637291a91.38.2025.04.29.09.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 09:26:45 -0700 (PDT)
Message-ID: <ed15f7f3-b74d-4884-bdce-afa8f35b841a@gmail.com>
Date: Tue, 29 Apr 2025 23:26:37 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: don't re-enable refill work too early
 when NAPI is disabled
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 romieu@fr.zoreil.com, kuniyu@amazon.com, virtualization@lists.linux.dev
References: <20250429143104.2576553-1-kuba@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250429143104.2576553-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 21:31, Jakub Kicinski wrote:
> Commit 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> fixed a deadlock between reconfig paths and refill work trying to disable
> the same NAPI instance. The refill work can't run in parallel with reconfig
> because trying to double-disable a NAPI instance causes a stall under the
> instance lock, which the reconfig path needs to re-enable the NAPI and
> therefore unblock the stalled thread.
>
> There are two cases where we re-enable refill too early. One is in the
> virtnet_set_queues() handler. We call it when installing XDP:
>
>     virtnet_rx_pause_all(vi);
>     ...
>     virtnet_napi_tx_disable(..);
>     ...
>     virtnet_set_queues(..);
>     ...
>     virtnet_rx_resume_all(..);
>
> We want the work to be disabled until we call virtnet_rx_resume_all(),
> but virtnet_set_queues() kicks it before NAPIs were re-enabled.
>
> The other case is a more trivial case of mis-ordering in
> __virtnet_rx_resume() found by code inspection.
>
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: xuanzhuo@linux.alibaba.com
> CC: eperezma@redhat.com
> CC: minhquangbui99@gmail.com
> CC: romieu@fr.zoreil.com
> CC: kuniyu@amazon.com
> CC: virtualization@lists.linux.dev
> ---
>   drivers/net/virtio_net.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 848fab51dfa1..4c904e176495 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3383,12 +3383,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>   				bool refill)
>   {
>   	bool running = netif_running(vi->dev);
> +	bool schedule_refill = false;
>   
>   	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_delayed_work(&vi->refill, 0);
> -
> +		schedule_refill = true;
>   	if (running)
>   		virtnet_napi_enable(rq);
> +
> +	if (schedule_refill)
> +		schedule_delayed_work(&vi->refill, 0);
>   }
>   
>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3728,7 +3731,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>   succ:
>   	vi->curr_queue_pairs = queue_pairs;
>   	/* virtnet_open() will refill when device is going to up. */
> -	if (dev->flags & IFF_UP)
> +	if (dev->flags & IFF_UP && vi->refill_enabled)
>   		schedule_delayed_work(&vi->refill, 0);
>   
>   	return 0;

Reviewed-by: Bui Quang Minh <minhquangbui99@gmail.com>

Thanks,
Quang Minh.

