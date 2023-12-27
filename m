Return-Path: <netdev+bounces-60388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867E381EF7D
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 15:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72111C211DB
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099E45033;
	Wed, 27 Dec 2023 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TGrTW0Q4"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60E2B9C2
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <723b710b-f9ff-431d-bde9-5d3deb657776@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703688074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bf+Bf7B2iOSdjR4shx40sjMGMpAOnJQ30rpuk0X6RA4=;
	b=TGrTW0Q4jJR6Ap6Sw+dzjz56KODMfIAagMVUWsOAVTUYwXqxjHnNSiN0MIeGyVwhEARDXW
	V76F0rvL+Yp7d44pkBSWlkXAW2Ve6IEwUzGQ2oZxAtAjNiTaeAYZI+e7lRkVuoBxwsbf4I
	Zg8Qzg/Sr3DVkqLfAXkEadwQfxzbI40=
Date: Wed, 27 Dec 2023 22:41:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAxLzFdIHZpcnRpb19uZXQ6IEZpeCAi4oCYJWQ=?=
 =?UTF-8?Q?=E2=80=99_directive_writing_between_1_and_11_bytes_into_a_region_?=
 =?UTF-8?Q?of_size_10=22_warnings?=
To: Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20231227142637.2479149-1-yanjun.zhu@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231227142637.2479149-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2023/12/27 22:26, Zhu Yanjun 写道:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> Fix the warnings when building virtio_net driver.
>
> "
> drivers/net/virtio_net.c: In function ‘init_vqs’:
> drivers/net/virtio_net.c:4551:48: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
>   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
>        |                                                ^~
> In function ‘virtnet_find_vqs’,
>      inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
> drivers/net/virtio_net.c:4551:41: note: directive argument in the range [-2147483643, 65534]
>   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
>        |                                         ^~~~~~~~~~
> drivers/net/virtio_net.c:4551:17: note: ‘sprintf’ output between 8 and 18 bytes into a destination of size 16
>   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/virtio_net.c: In function ‘init_vqs’:
> drivers/net/virtio_net.c:4552:49: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=]
>   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
>        |                                                 ^~
> In function ‘virtnet_find_vqs’,
>      inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
> drivers/net/virtio_net.c:4552:41: note: directive argument in the range [-2147483643, 65534]
>   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
>        |                                         ^~~~~~~~~~~
> drivers/net/virtio_net.c:4552:17: note: ‘sprintf’ output between 9 and 19 bytes into a destination of size 16
>   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
>
> "

Hi, all

V1->V2: Add commit logs. Format string is changed.

Best Regards,

Zhu Yanjun

> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>   drivers/net/virtio_net.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d16f592c2061..89a15cc81396 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4096,10 +4096,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>   {
>   	vq_callback_t **callbacks;
>   	struct virtqueue **vqs;
> -	int ret = -ENOMEM;
> -	int i, total_vqs;
>   	const char **names;
> +	int ret = -ENOMEM;
> +	int total_vqs;
>   	bool *ctx;
> +	u16 i;
>   
>   	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
>   	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by
> @@ -4136,8 +4137,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>   		callbacks[rxq2vq(i)] = skb_recv_done;
>   		callbacks[txq2vq(i)] = skb_xmit_done;
> -		sprintf(vi->rq[i].name, "input.%d", i);
> -		sprintf(vi->sq[i].name, "output.%d", i);
> +		sprintf(vi->rq[i].name, "input.%u", i);
> +		sprintf(vi->sq[i].name, "output.%u", i);
>   		names[rxq2vq(i)] = vi->rq[i].name;
>   		names[txq2vq(i)] = vi->sq[i].name;
>   		if (ctx)

