Return-Path: <netdev+bounces-42459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941D77CECA0
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 02:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73421C20933
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 00:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE6517E;
	Thu, 19 Oct 2023 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gYDHfis9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFE7361
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 00:12:43 +0000 (UTC)
Received: from out-195.mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1DB125
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 17:12:41 -0700 (PDT)
Message-ID: <f2d0aaad-70ca-4417-bf8e-0d7006be6ebc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697674360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiFGcXBir5895gbTnSvVkUAxBA2ZOAi3wV+AILiCiwU=;
	b=gYDHfis9ygwRm6l48oBXXssrXFtLKWBA7IorJAjoGE8Y7cjSK3C6oXw0KLLLCpy6zE4dCc
	ZDd5n0hHsdxcVwqeXXZddcG8WfkDBsqheECQ//wETBy+XTwaaYas4ig9BUhzqjjEnFnkgT
	OsgHmHHIzL+WgaterzAipWgib/DnH2Y=
Date: Thu, 19 Oct 2023 01:12:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] vsock: initialize the_virtio_vsock before using VQs
Content-Language: en-US
To: Alexandru Matei <alexandru.matei@uipath.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mihai Petrisor <mihai.petrisor@uipath.com>,
 Viorel Canja <viorel.canja@uipath.com>
References: <20231018183247.1827-1-alexandru.matei@uipath.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231018183247.1827-1-alexandru.matei@uipath.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/10/2023 19:32, Alexandru Matei wrote:
> Once VQs are filled with empty buffers and we kick the host, it can send
> connection requests. If 'the_virtio_vsock' is not initialized before,
> replies are silently dropped and do not reach the host.
> 
> Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
> Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
> ---
>   net/vmw_vsock/virtio_transport.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index e95df847176b..eae0867133f8 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -658,12 +658,13 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>   		vsock->seqpacket_allow = true;
>   
>   	vdev->priv = vsock;
> +	rcu_assign_pointer(the_virtio_vsock, vsock);
>   
>   	ret = virtio_vsock_vqs_init(vsock);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		rcu_assign_pointer(the_virtio_vsock, NULL);
>   		goto out;
> -
> -	rcu_assign_pointer(the_virtio_vsock, vsock);
> +	}
>   
>   	mutex_unlock(&the_virtio_vsock_mutex);
>   

Looks like virtio_vsock_restore() needs the same changes. But
virtio_vsock_vqs_init() can fail only in virtio_find_vqs(). Maybe it can 
be split into 2 functions to avoid second rcu_assign_pointer() in case
of error?


