Return-Path: <netdev+bounces-141801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B42ED9BC457
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 05:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FBD1C210D5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 04:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E11B0F02;
	Tue,  5 Nov 2024 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eL1N5Mup"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447B18E363
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780971; cv=none; b=pnguK+xF3Ts27j+/kJI2n6uAcHViy8gyqb7fpj6qOkMtDD7ce5686yXL9OpY1ltA7b5DDhc1rCIKaqHuM+SHAYjKI+jgrjwxnNd6azLj0kxJg9WTVPo6DyvRT16dktl8/Ch/1kmrsQ9rVMH74KsqgQD1tol+PV9b7NWzNwLukr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780971; c=relaxed/simple;
	bh=IAFfMzzyrbRop/8uBKQSzdTM6VeUXaTo5Y0XtX+mIeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndUEZ4lCqmnsx4G5Y68m7APXNdEEFshDLcZ9skajY/0vGbThSKqV2PkEDeOlbCX/ZzgvZ6OeN1qCM1em7sgjH0GKONTATwLzPPV7YDT5oAwj7JyeiZVejOJej1DEv/aj+L5fYIRusGrTtIez1Gr9MKrUTJ4BLe1Aec8vttrPZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eL1N5Mup; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730780969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAFfMzzyrbRop/8uBKQSzdTM6VeUXaTo5Y0XtX+mIeY=;
	b=eL1N5MupBUqLR2mUBaPjmOOXY60/u44uUVbmaZInG2FBjwMlZI5Gc+JFVRhyRMXnoiiOpM
	46sXEMZMJ3UT06FrjnDTbscosYrw4Je4k3l2N1Ns/k0LmPL2dpVl5WKKTBREkRgJRXWDZ1
	3iQtBqdlTu/yvflcmnTrJ6nibP0qtXE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-IjAmo1vkMWWgnKyYmuH6Ew-1; Mon, 04 Nov 2024 23:29:28 -0500
X-MC-Unique: IjAmo1vkMWWgnKyYmuH6Ew-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e2ed2230fcso5205359a91.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 20:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730780966; x=1731385766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAFfMzzyrbRop/8uBKQSzdTM6VeUXaTo5Y0XtX+mIeY=;
        b=vYf6vb8RaNemrzO9mP7vtFx+ujiNIGC4JakKkiDWxdEVoo8YvgOF4jiWHHiJnv3if7
         y6K4LEEl+Wbc4buDJGpx4/BWamml73P50R8tnmWlkInKW8ASS7b2AQ78wgD7iuGzqOy2
         7rhd9s+z0LeToNDKN7FCpWEr1Zq6mSBj4XJ22jI86clxDjtd1oV7gMH6zfT4rMEVpDq7
         SVkzvndMnEcKovmrO42pouByoSfRUNdFpDgy5eEC8kRzwvbHP4A/E2zKZVVeXHB3Hpp3
         yZKWe7JFttXLMk7ax39vbIz442dy+lsU83Zmkv7dOK9LtOV3zghFkie/asbA1gjSMHQW
         nHFQ==
X-Gm-Message-State: AOJu0Ywb+hAzLDw/PnZDdkNg+F4GpIMmAHfqtF2+qbe0Sm9+rbxmXhTi
	2RxYlLdRTcTV9YIWZAPAGPbxcUpgwj2qw+B4sX91lrV2t/YollHlMoz5rlFk8URpViILmHGo7nz
	GL4f5QqwlE1xrBgYdv/B17r2j0P3qGXFp5MF3PGAl5Z8XPFWWCkTXh3YGuH5aAGWyemPRh+7Yl2
	db/u5k7os5NPYz/T7fByNOh1pgWmJJCridy0aNdjtRRQ==
X-Received: by 2002:a17:90b:540d:b0:2e2:d15c:1a24 with SMTP id 98e67ed59e1d1-2e93c1a6cddmr26138140a91.23.1730780966376;
        Mon, 04 Nov 2024 20:29:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlfBcjEUwY0jgicXD/Etg/7eX+icEijhUmPf3OjO6dPGL41QsO7QKLssoh6xABfMz8aXhIphYCx3Xy3KfX3CY=
X-Received: by 2002:a17:90b:540d:b0:2e2:d15c:1a24 with SMTP id
 98e67ed59e1d1-2e93c1a6cddmr26138115a91.23.1730780965914; Mon, 04 Nov 2024
 20:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com> <20241030082453.97310-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241030082453.97310-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 12:29:14 +0800
Message-ID: <CACGkMEvh=tFAp2gXmtCgaTGn9ZTL2z6oiA47TNysqkro3etZgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 07/13] virtio_ring: remove API virtqueue_set_dma_premapped
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

On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, this API is useless. remove it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


