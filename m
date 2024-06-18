Return-Path: <netdev+bounces-104319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B499B90C22D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D21B2292B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2DD19CCF8;
	Tue, 18 Jun 2024 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I23exiRU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841801E515
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679704; cv=none; b=fWy9xKcM+LW9vukN/71VkFGEuOpGH90DD/OhJ+mbCVBUxGqGEcPy2g9e+55gSqOhGvTbtVtzsWWPvEQ6i3eghy/YhHYblX3s1sWITlgV1TnY+R23IuADPvQVqtAhMnAnU22Q9p12Rq3BbYmMQ+F+JZEi3y8ui/qnfXEgnj0mHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679704; c=relaxed/simple;
	bh=nu4pca2mi6dQrvgDKgyW+yuVYeHR3Cy1A2xzxgA6xT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgeMUVv+1W/+EeFZOgAKHNJkfYeuBTJwXDJHBM8POLBTQ7CkuHB91iSqJBeJ/d7IpBEFs+680KMrc1jHbs8hTerxZ23yoNMHQTo1Ws37Bicu29KtikqLUt32qo9TTRYwfXTUvKmdNwXNGJ+Nnl0xCoZ0JqSomQwkBbiNHaQ1R38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I23exiRU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718679701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGO8xJv2KXgMjNv3VApDR/tvDfjbFvWmFZHb4b/swhY=;
	b=I23exiRUElPAcgpS+joY2T9GNiHD/UdrTyP5yrjqroNY83kAh6I1eXIYx8yOQa7YTcb4Do
	pPOJ4G0OxYHENtGf3gibEPnAnfYKehzKrMKFAAV+k+t3EGVnOe1Nhx59tfKlS1Lkk/aqAh
	/cHvlWCdHacLccVBh+XC3q6+JpvcvrU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-FAFSF-MxNeOqTPkwtWQq_g-1; Mon, 17 Jun 2024 23:01:40 -0400
X-MC-Unique: FAFSF-MxNeOqTPkwtWQq_g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c7316658ccso186342a91.3
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 20:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718679699; x=1719284499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGO8xJv2KXgMjNv3VApDR/tvDfjbFvWmFZHb4b/swhY=;
        b=KVBxYYx91IWbhA6dwmMRtfsDdWn1gV8m0K1Vpk7F3unmFH65wVG3LyiIbb7Km6iLee
         /hjY9AURgT0ByHF+6FoE99X0ldRB74lrgy6Q9BBXFsDSdsz8RahsKcbq4ZWIFg+20UBx
         sbc5unf9m88/a1XM9YFXN1TFSZQX4q/K6ySVpkF4dXYduMFPkhEJrfFoxAh61rFo/9NL
         kW5JdDK8xBGQM83KOoaGIapT4vlr+UkdSBrhP35/w3uZWHFyIP7NlBtXoMOYFqf1akfd
         On4PmA4Qj+KvJmlqgr96TqGJaSjxgDQLJX8mDeQS2tSiR2Vc03Qq+Bb8Xs76eDLHI6Iy
         wE0g==
X-Gm-Message-State: AOJu0YyLff2l2Oh9Rh5DX/QmFrHi7LlhWaESfl5usk3RBNq+/Nime0gV
	8ckq5UY5n6Le74OcmxiawsL1TJEYhrhPkQFBshhPZJpHLtidMAVJsEpvFBs7h4gzM/Two6zw8MK
	yBU/UYUna3Uel7rlkfExdceHV/ZblaLUxrgYsNilLij1L+JBxOX9E+tmuevrchZvsyp2At5ErOl
	URgc7qduzYnf9cGpF5lKUUgmr4fsGH
X-Received: by 2002:a17:90b:4f4b:b0:2c1:aa8e:d70 with SMTP id 98e67ed59e1d1-2c4da9c8de9mr11714900a91.0.1718679698947;
        Mon, 17 Jun 2024 20:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZBrfswUVDW/XgtKdE78Hbo2pv4VMfsIIEd1NV+lkFxY0mc3r22zWjQXrs9N3V9yGvI6LQ5+NPtf2aGgXqQlY=
X-Received: by 2002:a17:90b:4f4b:b0:2c1:aa8e:d70 with SMTP id
 98e67ed59e1d1-2c4da9c8de9mr11714876a91.0.1718679698612; Mon, 17 Jun 2024
 20:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617131524.63662-1-hengqi@linux.alibaba.com> <20240617131524.63662-2-hengqi@linux.alibaba.com>
In-Reply-To: <20240617131524.63662-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 11:01:27 +0800
Message-ID: <CACGkMEvDUcVmaT1dBoWnFx0CO5kH+HYp9je5bJ1dFR1+EEdyWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Thomas Huth <thuth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 9:15=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> In virtio spec 0.95, VIRTIO_NET_F_GUEST_CSUM was designed to handle
> partially checksummed packets, and the validation of fully checksummed
> packets by the device is independent of VIRTIO_NET_F_GUEST_CSUM
> negotiation. However, the specification erroneously stated:
>
>   "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device MUST set flag=
s
>    to zero and SHOULD supply a fully checksummed packet to the driver."
>
> This statement is inaccurate because even without VIRTIO_NET_F_GUEST_CSUM
> negotiation, the device can still set the VIRTIO_NET_HDR_F_DATA_VALID fla=
g.
> Essentially, the device can facilitate the validation of these packets'
> checksums - a process known as RX checksum offloading - removing the need
> for the driver to do so.
>
> This scenario is currently not implemented in the driver and requires
> correction. The necessary specification correction[1] has been made and
> approved in the virtio TC vote.
> [1] https://lists.oasis-open.org/archives/virtio-comment/202401/msg00011.=
html
>
> Fixes: 4f49129be6fa ("virtio-net: Set RXCSUM feature if GUEST_CSUM is ava=
ilable")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

(Should we manually do checksum if RXCUSM is disabled?)

Thanks


