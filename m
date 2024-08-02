Return-Path: <netdev+bounces-115193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD7994565E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEC21C22676
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6185F17BB4;
	Fri,  2 Aug 2024 02:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IE8rNjeT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1611C693
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567322; cv=none; b=efQ1xs31e0FK7Dm8sCcFnhjl15vMBwOUV4Z5bjFAgXbIyjpCY6FIZ63voZ8ox2Q7eq/5L+zhMjlT7o6NQu14BXotYsoWMIGdCuURk5HbPCfsTF8wQ7aqCjz6IW5MbRX3DS7MFPxSio08FPJEYm+vlCE3ztTZp6MEYMQt2QYBbks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567322; c=relaxed/simple;
	bh=K4xoLpkZ6BwH3cmnGonrRZ9W1NOI6AkuT9StzCmYZVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rB6CxL9XlMVrJ7tWMfnYfGHHG3gip/AHTy9d1AxJgjELN1kB01Oa71t8YdwliQNMFYa/DwjtFOrZgOFrJgk8YLjR8gI26Mb20XvkqMFITrIxkGKAO2k4Q4KolRSMl1Wz5VDYc7X2mHvUXacWLc2ijlzRZY6BR5oDuwpF7AL0WoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IE8rNjeT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722567319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBdueG4+2+xR+07KsJ4mUB3qhmEq0wrfejgSN+9Z9CQ=;
	b=IE8rNjeTMlved+GBSAoR/UbrV4Gnyp14zCJ16HMc+drQVp4eY/HTBHEO0Fro1pghs30Fjf
	zPXt5XnlbCKdrnU6Le0/1EMWzP9QFvkBOtCvWrIJWB5YZG/UUCYq6e9qLjnq/z9oKB6NFj
	qXIwKiPiJ1FGeWvKWTCtfL9TNabIQFc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-JlQ-WQbVOHOneBZWU20QVw-1; Thu, 01 Aug 2024 22:55:16 -0400
X-MC-Unique: JlQ-WQbVOHOneBZWU20QVw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cfe41af75eso2406540a91.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 19:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722567315; x=1723172115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBdueG4+2+xR+07KsJ4mUB3qhmEq0wrfejgSN+9Z9CQ=;
        b=tNPPNEV1KBoLBvmQajrP2bhir9q4pZ1FzjXpfcVcJwuvJSEiJbLDvw4rqlDK6TYH7w
         hQkxLkXu02a25X8dQU7+O8Ursj0r9yrght0oy+UtTqklhuDRd1QOX0g31hpQ/KZqUdwz
         xiTDeBC/CBx+cLOtC2AX+F3ZiQJuUfxYvnOBrJCesDze3gKW1VbP2B/CBekrPkPxUH4M
         CieYYvmEp5xYkY5A5MkJCaEGcqL8TMm60lB5fAqVE1AVFTVLzpI8Yo1hny7x14LzRBvA
         uHLCKSVTDfP7vs8lW5qZd9DIkeiP/PHnZ/uNcU3i3WSQd3c50jtTzKPURwmlSOZcUPNh
         El8A==
X-Gm-Message-State: AOJu0YxBpPQ2M/fcM5in7XwPasa5NFhtpXcnACRPsRme7mibwa8XTZuB
	U0Pp8+4w9uOtXf+vbC9jNYmE8cgmvnDrjEX4rB/dYWzk868xGx/KA3ydkuwl03jHmiBXAdPxbgO
	A+kPbLo5AM8dd3ile3qPtJL7rYNlrHAK0YBiVBrie6HlurYTMhUhXylpE4WzROiIvyboMUCKJvh
	3wXK7zQpRph7xrKGFs0xRkDvmFJGSC
X-Received: by 2002:a17:90b:33ca:b0:2ca:d1dc:47e2 with SMTP id 98e67ed59e1d1-2cff9559d93mr2787840a91.33.1722567315124;
        Thu, 01 Aug 2024 19:55:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRq+tQFKs9EteORmxL/nkd8DIBEa3fxroeU6VOvZY8mZ7YjkWhizQtBG+HeQFWezhpE3EcMFHeQEUCYHijGbw=
X-Received: by 2002:a17:90b:33ca:b0:2ca:d1dc:47e2 with SMTP id
 98e67ed59e1d1-2cff9559d93mr2787814a91.33.1722567314583; Thu, 01 Aug 2024
 19:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801132338.107025-1-hengqi@linux.alibaba.com> <20240801132338.107025-2-hengqi@linux.alibaba.com>
In-Reply-To: <20240801132338.107025-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Aug 2024 10:55:03 +0800
Message-ID: <CACGkMEtiLsg6NKNB3TmwchxB-MbBYBnnsEJh1Cq3gHh1K7djbQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] virtio-net: check feature before configuring
 the vq coalescing command
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 9:23=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> Virtio spec says:
>
>         The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
>         feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
>         and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>
> So we add the feature negotiation check to
> virtnet_send_{r,t}x_ctrl_coal_vq_cmd as a basis for the next bugfix patch=
.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


