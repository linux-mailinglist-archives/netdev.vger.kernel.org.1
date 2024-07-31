Return-Path: <netdev+bounces-114371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DAF9424C9
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 05:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7031C213C6
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3503F17BA9;
	Wed, 31 Jul 2024 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/V8oP3Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A617557
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395491; cv=none; b=OY2JhtwW8fRItmwJDqu/2ADvdPfCiRrerMM2Ky8T6I/uiYuAW6EJ/S5nd32PGe1v/tF1JyRk/t+RMFTrSa3uxes76brDRVqbHWZ4eo3m35DNw69hpYH/z3V8buA9Lkk5thyMSv/wR991fy8pzJ4mGz+jJUYHVZwNAG5WvoSpR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395491; c=relaxed/simple;
	bh=DwQLvRUThF01vAGn1WxpvhmQL57pItU0ZwjmUKgEutU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRTCdUTp+r72eosum2R+IG8YuPdyTgDt0J6aCe3NtOpHv/fat9SdZ9gWY7YGq66dp7hZooYGy+JiU8zfxlgHssdQ+rrBJ7NZKZQkrXJoaVuRpZvYbN8tuQWN/Wll8rvYuJCJ2WVuQIQ7tvWFwUJDOjODkOxTeNXQaJFPdk3UxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/V8oP3Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722395488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWwLp1Ih+u6gHfiUIAuOqbUDdnoH9hCbh7uBar0a72c=;
	b=B/V8oP3YyE324VbDZ63Ehe4M3Gh6sDWtUTJCFASh68JxBoX9wuRgQl196KCqFD55J3QVz8
	ou6h13Aatp8D8it3JPtD4DTyaD7R66SioYsQfSLytNnraufanvHPnBbXlkg3+jt3nWN+oW
	7Oxn6uUpHOo5lPhVOKi8llnwaM+zu/A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-2ln613IGMAif79kaWdQciw-1; Tue, 30 Jul 2024 23:11:26 -0400
X-MC-Unique: 2ln613IGMAif79kaWdQciw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb696be198so5174334a91.3
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722395486; x=1723000286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWwLp1Ih+u6gHfiUIAuOqbUDdnoH9hCbh7uBar0a72c=;
        b=XP/lN5d4qAGdJDZ69gkZ6Qj7gOZNpZH1j0YVyJjcn7rXyh1j7UoztCxPgAl2XJSZrs
         xtKQbjNyA/EPwnq6+qWEPYxIPXBqNhUHj8deRYg0/k/9bdWEn6pEoow4kMyNLB3elf4f
         quYLxwXJZmDraW4PagvP9V60F4BoFSfnZf9VoRYYtyTuwcQq6k4AxY/DsL6nb2doi8u2
         +NL0+tLJbgBR3Tb9f5gFceX9Qnld5nA87S6VHln/h8Kvm6h1ipwODpla0ZstbD2kGv8w
         YuTHbH+xnv7GNEkjRNOihjFe4UwXoSlzMuKV5NXiZbwyBvFRVTMcsbaJa2hupR2k+0Bv
         cuQw==
X-Gm-Message-State: AOJu0YwdHTuXj5FL/ixDuciB1kfucUgXZem3QaxGuMsOspu4GULd1fyf
	0ZgLjjjo6iTvg+ogE6BSRwDdiqrXUT13oZ51Ji9kL8ZqDroaGHlaLXt0xZ7HkAJ2haO+DyL/5u/
	EtXjpCqddg+q3xFIJPJ7u5gjLtsjBOegwD7yBC7hTN0pnHTkalGgW3MCwSMLPd1hYlALnIkW/2Y
	2nDUanbEuQ2qjPa5Gi1WI0dRGgMPDv
X-Received: by 2002:a17:90a:8d02:b0:2c5:3dbd:58bc with SMTP id 98e67ed59e1d1-2cf7e1ff521mr11519139a91.25.1722395485797;
        Tue, 30 Jul 2024 20:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExASsgvEQCSJuoJ8g3UUDEN5BjkkKwxLgLE2D9X91t6mmIgyrqyRPAqowIGVUDuDM9ayTpLd7IIbn/CwV/4LA=
X-Received: by 2002:a17:90a:8d02:b0:2c5:3dbd:58bc with SMTP id
 98e67ed59e1d1-2cf7e1ff521mr11519113a91.25.1722395485350; Tue, 30 Jul 2024
 20:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729124755.35719-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240729124755.35719-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:11:13 +0800
Message-ID: <CACGkMEt9PoT4XDw1TKBaQ_GYihOAdnyzBosVYNVL62MTrYD0rg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:48=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> From the virtio spec:
>
>         The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
>         feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
>         and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>
> The driver must not send vq notification coalescing commands if
> VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> applies to vq resize.
>
> Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq re=
size")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


