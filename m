Return-Path: <netdev+bounces-143625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0969C3626
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B811F21123
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 01:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600D44D8DA;
	Mon, 11 Nov 2024 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AY8ICHz/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92854224D4
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288883; cv=none; b=UhyL1I2Ze0CaQPx6zo17q5hAF9p0Ih4AztQnWvFVMGvXpm534koCqQm6A9hWuAawKP/ZZIsGNPY6ETUX65PxLXtMu/60tFmOJRIweoGsuXkAO+FoiBaaHK9d05JfxONqyaiagLh8B3VGM7KoyG5N7kTwtSgywwDm4U39//ISS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288883; c=relaxed/simple;
	bh=SwnYr0wQUUCUjeABHi0X22mCkb+XL7pmujqjUXf5TNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6993KmycYWeN38zvhRKIYTrVSN+UpSelGFWljVbxPDHU5aMLhFYwQPuFwdhFc8WumW39/uEx1u2mZz1VkXnux9RLDChufmO65jQLD6I+i/NkMCnAS94jR+28aNNW6LHiMuts0Ra4rKJWb6LRtVFkdpAd8pYJ0R4QgcnJzFi3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AY8ICHz/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5RPDPPvEC+nbrsIFTdBWydQ3ctDGSgyhAGrK+AzGtQ=;
	b=AY8ICHz/pdIGEds1gLob7+a98PDpyvm76bsT7WlBOHSIdY7ogiiI/MCPdX1niKvFeoEvM0
	MhQ0vMQklaRSbMXFK0j2klRzJTQ2qw2s8IWBXz7e2EaHDzSk9rIdh4SINtSGMq82oOaUBA
	YPkQHnT/gCcQ8STow4DAqsSye5LmaFU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-nvVx1NREPTu3M-hBiThQYA-1; Sun, 10 Nov 2024 20:34:39 -0500
X-MC-Unique: nvVx1NREPTu3M-hBiThQYA-1
X-Mimecast-MFC-AGG-ID: nvVx1NREPTu3M-hBiThQYA
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2ca4fb175so4001376a91.3
        for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 17:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288878; x=1731893678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5RPDPPvEC+nbrsIFTdBWydQ3ctDGSgyhAGrK+AzGtQ=;
        b=r6hNoMbT1WVC9DnHD2qYnSyeOM+SmygxHdtn/AdW/IyTEYQ8GKPxf3B62Ov8QXqsFk
         9zdZ1f8CsjwsvbfNlFqWH421iCwv8St32XYdyjEmCAethX0yvVj9LQuu2UEkN1/TQdi/
         V67bmIuoqgY1kOnoXCbV8shjC0DXsIejupfX6N03gcXzrPuDINeng+V5CTzsUeQtg3td
         t6VxbrwvYh29CHKTaH/nL9TaNVb9UAMTcO9CS0YzISnugTkz1JcH7Ur3Yn+gqNSvEIyB
         ppsPXocAMM5fClEJzg47LtnjuxlRN5M4pGtM7jIDesIeu2j9VtkLUZOONP0sjneLJbUH
         mZ0w==
X-Gm-Message-State: AOJu0YxXpIiaBQLf7rfb0cgelbh6jdPJ0NGjlsKf/DBxBZWRcfv6h2ra
	5M+qjgdzSd6XZ9fo0fO1/TdReGJIsCddq4xLRBRQj1LV+wdAuadt5YqcPrkEbB89nW1gqjmU9Px
	mBUEZ9r85bPJtZSYlS5ucIq17Na+b7/Yu9yAfAiOvv+yQ2qrS71nfAAkdMaV+JxqzkPmDYmn8eo
	2ExtweSB4hM4WaZA6czsWgVMtjLAEk
X-Received: by 2002:a17:90b:2e50:b0:2e0:74c9:ecf1 with SMTP id 98e67ed59e1d1-2e9b1680c50mr17180804a91.10.1731288878173;
        Sun, 10 Nov 2024 17:34:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKXVjG4ufYVtO/aRps9dNj08hlXOSoubtnDRnq04HNDaqa6AaAntNV6i56o/HhaPf03g09YFvoYfSVhfn/uuM=
X-Received: by 2002:a17:90b:2e50:b0:2e0:74c9:ecf1 with SMTP id
 98e67ed59e1d1-2e9b1680c50mr17180759a91.10.1731288877541; Sun, 10 Nov 2024
 17:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com> <20241107085504.63131-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241107085504.63131-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:34:26 +0800
Message-ID: <CACGkMEvwAte20vZjw-apRO_8+f+dy-Z070yoZjtzPD9SY=VPUg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/13] virtio_ring: introduce add api for premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 4:55=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Two APIs are introduced to submit premapped per-buffers.
>
> int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
>                                  struct scatterlist *sg, unsigned int num=
,
>                                  void *data,
>                                  void *ctx,
>                                  gfp_t gfp);
>
> int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
>                                   struct scatterlist *sg, unsigned int nu=
m,
>                                   void *data,
>                                   gfp_t gfp);
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


