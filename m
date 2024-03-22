Return-Path: <netdev+bounces-81167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738828865F1
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 06:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD531F2146E
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 05:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298F68495;
	Fri, 22 Mar 2024 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtnXc9Gk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576298F6E
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084652; cv=none; b=Fsd0MfFzwGqmfwfWN72Bgvyd88wg9WCpUQJ4mX2m2vb12nuXHk9kLN/rnsbgYCPNWLNzjX+HSDSeq00EDkdjkw+SYR6Qo9rDHw/dsxbQJ5gtJXEkfyuAh0d/XQnbk8Da137dfbXbA5ygHkLtkW6myUKFWpjFkfK/vUe09EBxADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084652; c=relaxed/simple;
	bh=EWE/U2YdOLWytXJDbIZukYYxmLvwVy2p5yLqcqrgdd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSG7/qt0Byt1y4pB4PhyG7eDSFJV53HayhGNuorTErUv0GrvKLxMjIhbED+fT5wMohH31+hiLZOPA0DBPT/hefuf8aDW0xF0n2K6/CEkONV921WSujR9ZpQ6Xv0+s3rWezyMKfZTW0+j9xNxMdB7XdAp1lE1fpAb+wzXpfCoaQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtnXc9Gk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiB8g8AYZuTj7XKOAnl43a6gnRGZomUOLPEEyadQvtw=;
	b=YtnXc9GkCjbyo4L/VC6dlWk8zAyo3yRJJLTXuFeIMcxY7FxFUsPSYYV6Z4j5f1CuzHFlnP
	3OOse6f0jmPExEwe0hGa0PHSVtfIYkzm0EhGuOMpMDUpqziR5DXq3IwYR8SuEr8wXh1fJ7
	mUOjQJv6WG8axVIU46l76uWllq2CM3Q=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-xr45DFWOP1KMZkWWbv0PLA-1; Fri, 22 Mar 2024 01:17:27 -0400
X-MC-Unique: xr45DFWOP1KMZkWWbv0PLA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29df4ec4304so1307970a91.3
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 22:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711084645; x=1711689445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiB8g8AYZuTj7XKOAnl43a6gnRGZomUOLPEEyadQvtw=;
        b=Uk1l7xZisDOFKZyeeJaoEJ3y3JLLQ2HtofHcQ6u6LlVxvNxI5Sje2jVgeDP2oPKXv3
         USXNKAXboeYJjFNFTFZOl7F5L8ypyMLywUZeyeXHay2w6EXLGfRqLjq5kFaq8GxCmkVv
         PPvVhxyye2VYvs2FD0tP3nj8tuj3GI4Kx23kUfVzzKk8pa1vB/Nvc1h2prsdXa/3K2He
         9uLPL1sD+gB8ZYmQhEvZwNj0Fxnpqv4Kod2QV9Qh6J7Ctzz/irjpJAOJY60m10GX0Obt
         W4WdNVvnbpYhau0mGCvdKmEqZnCsa5OyLTTBuSxKvb7xe9F3zoNhfKsRS8VNz8Nl5jkf
         VVtw==
X-Gm-Message-State: AOJu0YxschH5Q9ADhJi1PNkBkofMSd1ZVainlS6wyhxbjKkdwCfzuLPx
	nPjFx3zXTtjsthFIDijPZh3rg7tEnObj2LQiYL10tr/YZQUFQAVCQwLiBpdSEjzkFjiwXVRjulK
	R7PDHBJgVdkUPIeL6mx6JnKKEXaJMRgHT0ohArAxxCoYbQeV7+0nSjHcflqGs7QZ70pRIt3ioIs
	wSgvTDv5UCC/OZmTKrRkRhgfMnrzmS
X-Received: by 2002:a17:90b:4cc2:b0:29f:e100:5e8d with SMTP id nd2-20020a17090b4cc200b0029fe1005e8dmr1233623pjb.30.1711084645655;
        Thu, 21 Mar 2024 22:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwL6cxEzgUlFXUmhD96O4FYrKpPpJNtEYJx+SiogAQgf6veEJ5BZwFAMdLl9ha2tgOY4F2KX9Mf22HeDjoKcM=
X-Received: by 2002:a17:90b:4cc2:b0:29f:e100:5e8d with SMTP id
 nd2-20020a17090b4cc200b0029fe1005e8dmr1233612pjb.30.1711084645417; Thu, 21
 Mar 2024 22:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com> <1711021557-58116-2-git-send-email-hengqi@linux.alibaba.com>
In-Reply-To: <1711021557-58116-2-git-send-email-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:17:14 +0800
Message-ID: <CACGkMEtyujkJ6Gvxr1xV94a_tMzTo48opA+42oBvN-eQ=92StA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: fix possible dim status unrecoverable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> When the dim worker is scheduled, if it fails to acquire the lock,
> dim may not be able to return to the working state later.
>
> For example, the following single queue scenario:
>   1. The dim worker of rxq0 is scheduled, and the dim status is
>      changed to DIM_APPLY_NEW_PROFILE;
>   2. The ethtool command is holding rtnl lock;
>   3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
>      to acquire the lock and exits;
>
> Then, even if net_dim is invoked again, it cannot work because the
> state is not restored to DIM_START_MEASURE.
>
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d111..0ebe322 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_struct=
 *work)
>         struct dim_cq_moder update_moder;
>         int i, qnum, err;
>
> -       if (!rtnl_trylock())
> +       if (!rtnl_trylock()) {
> +               schedule_work(&dim->work);
>                 return;
> +       }

Patch looks fine but I wonder if a delayed schedule is better.

Thanks

>
>         /* Each rxq's work is queued by "net_dim()->schedule_work()"
>          * in response to NAPI traffic changes. Note that dim->profile_ix
> --
> 1.8.3.1
>


