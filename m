Return-Path: <netdev+bounces-81913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0BD88BA82
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 07:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237C7B21E1C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 06:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5061862F;
	Tue, 26 Mar 2024 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUs3uehJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411E4314A
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434939; cv=none; b=rUiQp2q1mrITPsfVVWfMfGiUlQ26lCQGauGPfVOdv695WHUNCLFeEbmcznYnAvyXA9Cy1J7edmSalqEPFl7G74Nl74tV0OaFnLVnGG0VQqyfzxkkO1eWndqMeISznBGMcnO+FxkNu++GBBqtB+FsJRqqDY+kTC5IKbU5s+Zd2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434939; c=relaxed/simple;
	bh=4+78nYQYB5Ci4NBkQebLOQgyOWv4FelTbQqjgSKmNzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZJZGfJlEjdd8vkOoGxQkkoUf9h/BlZTUkPH7tsJMHgedpwBpesTtblDqfFT53tZ4Kmh5ySr/3v4XCpTfn0k6CdugC8PGleIwQW7a9ezIKuMoF5BBzeeJKAgopMWeAvEHya8tEGytSCwvsV5jNIxtVenq96PyPiHr7tGAKcBfHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUs3uehJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711434935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV+n/AeH1+Y7vCOvFadr8DCW2Eq+lIrkj6t17qDJyoM=;
	b=DUs3uehJbb9o+Z86OpHKah8wmqNdE+H3IQCWWG7GzJbDAMiM2JhwTaJwB0hEn8UeEmatjD
	eOfgViJ9EtkrX4UQk2AWSnqu/79DG50/zvV8WwQUcgPUxDMtWB2fE39EtthM7SOox58xku
	wWIEjid37wPqJezjyF8/jsaEBfrrBn8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-Tng7dbiCPbupQkPxm3WxZQ-1; Tue, 26 Mar 2024 02:35:33 -0400
X-MC-Unique: Tng7dbiCPbupQkPxm3WxZQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e09dff52bdso23222315ad.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 23:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711434933; x=1712039733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV+n/AeH1+Y7vCOvFadr8DCW2Eq+lIrkj6t17qDJyoM=;
        b=NmpSa6Tq+jumQlYxpB+wI5mERw0rzs0nOzvIWNESQogLEea7vIwaxhhnXJUxRkznJB
         gFBpZPc+nofI8ZfOAEG9RgP/vrP/WfzDPNQhY9toTndfRh6bWEdyAvlgSuc7OyTenbT4
         7i/dgkQ3GaUKDyEXAGpiSvphQkw4TvF7Md787f5aYIt8UNOa1DyDm7RxVKtPiJH4cITK
         pTC6UA83XUpvaXWHJz1oqeLCrZFzOkwNW0BhgS8opVqjuyK4du0h9xZW9z9CHghpgWxp
         r8RYqudxPq+QSNr2EXqBF88E4ouMa5MwmLfGRpw0vYWZC7Coesse5fIjO567K1XA6pfQ
         4hPw==
X-Forwarded-Encrypted: i=1; AJvYcCXogplfRJdW5ZyzzIaoVn85bpNsdrdNqmovMuS6cZ+PpkNPqRkM0CkvabQeSTKGa3YPh6i8wqv/CSbJynDHSJq/g2ZnD1dv
X-Gm-Message-State: AOJu0YwaNp5PyXMwo+Elt8YEKVigTvQTWjGyE021FW4QdxBfM6cWLX9b
	oKxJe2HHHZuBSsWQWERutd4G8hKY+vW2A+7IM43HO73BcSpFLbWaE6q6aTcBHfVEY4HpTR89SXN
	mURh0Rgf4CjRStzQGpJBwECDQsI53Idtz+c9vzvDw7PPQ7eKyOZLZw3Zw5OTss9PBuwDlPr3EjI
	2E0OrOx+sCC4fmEAmMfFr31aT4twGL
X-Received: by 2002:a17:902:fc45:b0:1e0:93a:e681 with SMTP id me5-20020a170902fc4500b001e0093ae681mr10547517plb.58.1711434932766;
        Mon, 25 Mar 2024 23:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG38L73eoMVI0gE3VFcyJZbiAF71PJ9iqlnhy7YMgjlqkfIehY0e1Gl+LcuuDusrn1SHlJkZivN0EXqYXxdNPQ=
X-Received: by 2002:a17:902:fc45:b0:1e0:93a:e681 with SMTP id
 me5-20020a170902fc4500b001e0093ae681mr10547503plb.58.1711434932411; Mon, 25
 Mar 2024 23:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 14:35:21 +0800
Message-ID: <CACGkMEtEWCjb8+Zcfizij2+0ef-wb8YJD2bfyAvP_72hKZrGvA@mail.gmail.com>
Subject: Re: [PATCH vhost v5 00/10] virtio: drivers maintain dma info for
 premapped vq
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> As discussed:
>
> http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYq=
RZxYg@mail.gmail.com
>
> If the virtio is premapped mode, the driver should manage the dma info by=
 self.
> So the virtio core should not store the dma info. We can release the memo=
ry used
> to store the dma info.
>
> For virtio-net xmit queue, if the virtio-net maintains the dma info,
> the virtio-net must allocate too much memory(19 * queue_size for per-queu=
e), so
> we do not plan to make the virtio-net to maintain the dma info by default=
. The
> virtio-net xmit queue only maintain the dma info when premapped mode is e=
nable
> (such as AF_XDP is enable).
>
> So this patch set try to do:
>
> 1. make the virtio core to do not store the dma info when driver can do t=
hat
>     - But if the desc_extra has not dma info, we face a new question,
>       it is hard to get the dma info of the desc with indirect flag.
>       For split mode, that is easy from desc, but for the packed mode,
>       it is hard to get the dma info from the desc. And hardening
>       the dma unmap is safe, we should store the dma info of indirect
>       descs when the virtio core does not store the bufer dma info.
>
>       The follow patches to this:
>          * virtio_ring: packed: structure the indirect desc table
>          * virtio_ring: split: structure the indirect desc table
>
>     - On the other side, in the umap handle, we mix the indirect descs wi=
th
>       other descs. That make things too complex. I found if we we disting=
uish
>       the descs with VRING_DESC_F_INDIRECT before unmap, thing will be cl=
earer.
>
>       The follow patches do this.
>          * virtio_ring: packed: remove double check of the unmap ops
>          * virtio_ring: split: structure the indirect desc table
>
> 2. make the virtio core to enable premapped mode by find_vqs() params
>     - Because the find_vqs() will try to allocate memory for the dma info=
.
>       If we set the premapped mode after find_vqs() and release the
>       dma info, that is odd.
>
>
> Please review.
>
> Thanks

This doesn't apply cleany on vhost.git linux-next branch.

Which tree is this based on?

Thanks


