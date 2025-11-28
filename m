Return-Path: <netdev+bounces-242473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4764C909BF
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE3AF347F46
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17532459D9;
	Fri, 28 Nov 2025 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuPEg6pr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B02qwrLb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3819221F11
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296438; cv=none; b=uoIsvJ0eBcwZOMS6+rDN+hYy23lvh+wyZ3hLEu6xLFrK9HDTF1nO19h1kzZnAK6UjI61p2gj1DHFRzp3AI7oteAk6UI2Q5ASa9ll6IA02xHpRku5CO+YqeHNkGgQAcY2229s7odKoCZ+b9ork1jMGPrsmeCb7WMfBTP4aoyXgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296438; c=relaxed/simple;
	bh=juuT2szlDhnZah03azTXrfo8JNzsr8IYomevmrOodCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mE16ENRFayLnL3BvaiJ0Fr/T/WC0s1GFGHOuW76zZdCI0jwLOQlV/+kWVxw5iEovsuBhiAbdtldDoAn52XJEXw+rd80BYpibqgec3QTyyIQFwgFP0PYCr1b1FJmmQRjtYjMeKypKLoQsfjTQuf+DS+fX8p1LJbhBVWJKWi85Jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FuPEg6pr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B02qwrLb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764296435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYccDo2j+1D3EXgLNM4B1dXCh8l3NXcIw8nBRY7Khlg=;
	b=FuPEg6prKofXB3JC7TtVrIYMN21a95NZkMktrokAmpUhRHqYnzExZ+P+uP3G5ibH6d1dLQ
	NdgletxFWZzEcX+7D92pm8UXTc9u6tlftK2RDaLS8yDQJrZWD0964/M2zYkqilTB1znqbN
	fWcFM8f8sH/zaWrJF8Kt94D6tgOXpTY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-KrtERb2kMcaLwOVB8ZzZFg-1; Thu, 27 Nov 2025 21:20:34 -0500
X-MC-Unique: KrtERb2kMcaLwOVB8ZzZFg-1
X-Mimecast-MFC-AGG-ID: KrtERb2kMcaLwOVB8ZzZFg_1764296433
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340d3b1baafso1759818a91.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 18:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764296433; x=1764901233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYccDo2j+1D3EXgLNM4B1dXCh8l3NXcIw8nBRY7Khlg=;
        b=B02qwrLb5nhgd4pMuoFjAfOlr+HCondXLOpVNI4lQ2Vh/7U3F/7jfxzETDRiIOGpsZ
         tigohUpVBlQILpKhfZsj15HDFRZld6kzMkKB8wL5+a9kmDtafBw1o49tz7eCm/OEI+qC
         a89rRfpEzXXrbhaIxzYHYfmQtgaRcLJZMB7FxPkBe6moM9LCwIKOkw3ctmjxUmFaLD1f
         BBtDGCRFSmQ8BXgmhnTzWzW3sUGW2H6Upcc6mXVGIFEo7F5RvIyuHF1PjaT6W86Bxok6
         ragXWyqT6WrO83SLjG/Dldk5BO8raVsjYNMj4lSV4OaArbVynEDeOhaej11xqCwrKpox
         gxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764296433; x=1764901233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYccDo2j+1D3EXgLNM4B1dXCh8l3NXcIw8nBRY7Khlg=;
        b=qYFLFQ0eXmERVMliMjjDQwJ9eLbOtzlKBMbYxGHMcYAncAOUhFmWryPsJeIg7Ey7+X
         42LOefslm2QmCtto3DH3fCgA81J7dffhDL++YdURL0q80/HUkXa1IezMWLVNxbbWtwO3
         aBlee2oqmqftRaBbUiiIQWLnFFPol7OwJjpXWFfCg3lliB94LNNO6vaYu3jHdNwJO//M
         JqsulgYwMb+8rFn6pY4Z+0lKvCYgE1E0cUUkxy8n3Uy5ZwFy2FqJFovYSrvxoyKjAvgQ
         nJDtAyHPv1PsnImstpMYkT9m0O0f4DeGIEm8gVCKezYdc0wHU8cGW0FWBJrdYquFxPT1
         JtJw==
X-Forwarded-Encrypted: i=1; AJvYcCU+PvM9yzt7De+YnoQ2MH0GcRE4fhRlWt3RAntmeCQ1S+xpjNYR4WWDk8dVBHGVCzihWrG1zJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvdUg6jBjtM2dPVmGH3vvEkAl0kWZXRLnacnALojzaQS+EgvA2
	DkmgiZuIVkn/FY9VxJD+0Epe2EC0/zoHf6Q/1mC9cI+4kjQI9E/sfG8bN2MedU7OUgtnfHkBLht
	Ms9UDlAZVPcckZwurWHY+vAUtFvxFu+Edb6kPSlICL1jisa++aUeXIwhGAtECdZG7xXZycoYhiy
	haTSc4iHANQt/F0aVzk3TtyJx9KjXvMYC2
X-Gm-Gg: ASbGnctRLiW3RMYPUreAnDlTTDpUMcMprxKOQsFFjaADeDRQ+juMosuhdN/lQK3rBWn
	G/xdiJHrFWRpt50rXj42pnB1RSzrlK4Xk0/dqO1p9awzD19uvyVFZ/Sdq7JJxjfcH3LJybhFPzk
	/CuvEoNJqi1CjL9tKUv+SXbzlHg9Zkyv69UHZFgNjYDgpYb3kh5UmYbo7BhrRkiksQ
X-Received: by 2002:a17:90b:544b:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-34733e4cd33mr24799059a91.5.1764296433350;
        Thu, 27 Nov 2025 18:20:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv94V6EgbFiEIs81QepFX0mRMFn3g2NyGux1CLfN5JgtlXv14IqI7OOH8tWGprrDA/aklgfN72ym5w+o80QPw=
X-Received: by 2002:a17:90b:544b:b0:338:3d07:5174 with SMTP id
 98e67ed59e1d1-34733e4cd33mr24799030a91.5.1764296432936; Thu, 27 Nov 2025
 18:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
In-Reply-To: <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Nov 2025 10:20:21 +0800
X-Gm-Features: AWmQ_bkpiNIqEJYMSebVvAaf2aLCflDbTnLMVmn819Q7sJ2u-A2teXvBbKmJ7ag
Message-ID: <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 1:47=E2=80=AFAM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> I think the the requeue in refill_work is not the problem here. In
> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
> use "even if the work re-queues itself". AFAICS, cancel_work_sync()
> will disable work -> flush work -> enable again. So if the work requeue
> itself in flush work, the requeue will fail because the work is already
> disabled.

Right.

>
> I think what triggers the deadlock here is a bug in
> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
> __virtnet_rx_resume() which calls napi_enable() and may schedule
> refill. It schedules the refill work right after napi_enable the first
> receive queue. The correct way must be napi_enable all receive queues
> before scheduling refill work.

So what you meant is that the napi_disable() is called for a queue
whose NAPI has been disabled?

cpu0] enable_delayed_refill()
cpu0] napi_enable(queue0)
cpu0] schedule_delayed_work(&vi->refill)
cpu1] napi_disable(queue0)
cpu1] napi_enable(queue0)
cpu1] napi_disable(queue1)

In this case cpu1 waits forever while holding the netdev lock. This
looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
NAPI enablement with netdev_lock()")?

>
> The fix is like this (there are quite duplicated code, I will clean up
> and send patches later if it is correct)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e04adb57f52..892aa0805d1b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3482,20 +3482,25 @@ static void __virtnet_rx_resume(struct virtnet_in=
fo *vi,
>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
>   {
>       int i;
> +    bool schedule_refill =3D false;
> +
> +    for (i =3D 0; i < vi->max_queue_pairs; i++)
> +        __virtnet_rx_resume(vi, &vi->rq[i], false);
>
>       enable_delayed_refill(vi);
> -    for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -        if (i < vi->curr_queue_pairs)
> -            __virtnet_rx_resume(vi, &vi->rq[i], true);
> -        else
> -            __virtnet_rx_resume(vi, &vi->rq[i], false);
> -    }
> +
> +    for (i =3D 0; i < vi->curr_queue_pairs; i++)
> +        if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> +            schedule_refill =3D true;
> +
> +    if (schedule_refill)
> +        schedule_delayed_work(&vi->refill, 0);
>   }
>
>   static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_q=
ueue *rq)
>   {
> -    enable_delayed_refill(vi);
>       __virtnet_rx_resume(vi, rq, true);
> +    enable_delayed_refill(vi);

This seems to be odd. I think at least we need to move this before:

> +    if (schedule_refill)
> +        schedule_delayed_work(&vi->refill, 0);

?

>   }
>
>   static int virtnet_rx_resize(struct virtnet_info *vi,
>
> I also move the enable_delayed_refill() after we __virtnet_rx_resume()
> to ensure no refill is scheduled before napi_enable().
>
> What do you think?

This has been implemented in your patch or I may miss something.

Thanks

>
> Thanks,
> Quang Minh
>


