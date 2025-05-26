Return-Path: <netdev+bounces-193292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 719BAAC377D
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 02:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF0C7A9A7C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 00:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652EE224F6;
	Mon, 26 May 2025 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDkpqPg0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89D367
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748220492; cv=none; b=Uk9IA09VdUxe7A5sfN4PgzL1vBEb4TY7x/gqlU4NYuJ9lNkzfGQy8s45om6qfRaPODPwzJta5D2IWu0OJpNc0cwyPOGVgksaHMIVuOP7s23uwceacyq/oBsoJSKQqjf5m/glhqn4ht+pYRYZRx++hz7IBQtCRSKb65peLJZpNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748220492; c=relaxed/simple;
	bh=xM/iR15NZuSeqhFzoNkNCjbhqGCrEEn+F3fWA3e/VnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SG/HExM0ggWRow/6nnFWEUvdTRMuXUQlzcKPA2sHffGOoatJ7vtiY5MKAcKAgLSOHEiTNUNel1fT/sJTOMPVhR5kSP/07hah9BTzN2LqChAUplbi0j5OSZniwqq3jHGTwORleaqPzOQ3q56pH5eWBTHWQfHJgGi7ttamNMuvJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDkpqPg0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748220488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKZQ9RDyPUHUt9K+kBTS/mKPQs4MxH93OOxZ42An7cU=;
	b=VDkpqPg0B2mjsgpIDyZchPIjM841y2EK0QaqVvdkkksvLpKTwN2vOP8YOwXMFJKPP6grcO
	imrMwABXYCuG4HCuQXF/OOGDoBWTtTdAadRUDhdOYVodE5viEva55noE6Y1aYrSGwYTc74
	9F77kZdEeTbl2LmUlLxdKVw8WfUgjqU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-zvO9sb96OuaDKoPAsk6Snw-1; Sun, 25 May 2025 20:48:07 -0400
X-MC-Unique: zvO9sb96OuaDKoPAsk6Snw-1
X-Mimecast-MFC-AGG-ID: zvO9sb96OuaDKoPAsk6Snw_1748220486
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b00e4358a34so857281a12.0
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 17:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748220486; x=1748825286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKZQ9RDyPUHUt9K+kBTS/mKPQs4MxH93OOxZ42An7cU=;
        b=ILvEN9IVBGHBC8OIOzv26xW5PteMZhXztiL6E93DSw5pgrtxAxQjKpYUFkvFahw9zO
         IFYyX76gp4/S8jQds5i1p/4r5CKn0IO086vawlHjDvhwayWAI3tS4yx9H54DzCvuPoPl
         IdKk8jJRAj5g5rqyImhFbSt4/d4T+4RsMzbfZ8jiVuqISmq3KHZYpX4jW1A9MReB3mv1
         m7rvU70QodEgxGszjCuX0EbpkqT+tFOBJn/9+uZEcnji3Cqe9i8WDmtHYR0TURTJU2vq
         AtqlVL5BBQfb6UOPkc1pCegvgCjGsmwDF1aR5ddKu2jTzgi4E2lvEilTZSmzXuRCNRTx
         MgsA==
X-Gm-Message-State: AOJu0YwZAZ6OVWqbGk3F99csWKUoVEGclXrobTnwYQG+X2CWNI5iKG4P
	XFagyQiB2YaDgedjnEqZW7AEPgzUXJ0Mhc0C3S2HeRosXME/RuiobkZRdgDF/6uIcpZuJd1TFri
	ZqxNcAL1X1FsROhwHMckfG63rZzke8SphJMD8kPwxr+erQxE3Dg+ufSK7Brlp6V4bT0/JM1OVjx
	ZS322vXRFhElKN4MmG7whhuQNG0ZaUis0/WR9UYpM7mZA=
X-Gm-Gg: ASbGncuTZL5XxigGW2kRirX/QE4BAXhFfZgJ/nBy5roOKnD3/6CLhOTRShaD/JKP+6a
	UefKxAmgOX6BplGSGVVgqHAhxxZVUL3l6EW747UKOe5P8q+nbs5CnUEg3V8ZOs2SHOsFYJA==
X-Received: by 2002:a05:6a21:3387:b0:1f3:1d13:96b3 with SMTP id adf61e73a8af0-2188c20e104mr9100485637.5.1748220485783;
        Sun, 25 May 2025 17:48:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSktKuyktUz0NByxvqH70/TtFI1h3C9TaL5TEXaxXcIhO9tMd2Tuc6a4bsS+X96YLTZXbX81oTtyzu+rDLN7I=
X-Received: by 2002:a05:6a21:3387:b0:1f3:1d13:96b3 with SMTP id
 adf61e73a8af0-2188c20e104mr9100457637.5.1748220485390; Sun, 25 May 2025
 17:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <b1d716304a883a4e93178957defee2c560f5b3d4.1747822866.git.pabeni@redhat.com>
In-Reply-To: <b1d716304a883a4e93178957defee2c560f5b3d4.1747822866.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 May 2025 08:47:53 +0800
X-Gm-Features: AX0GCFuJRD34ohulPEfKcwx-CcwrHInnhUkxaj1CTxrdFkC_I7IWEpZuZ10KT4o
Message-ID: <CACGkMEuzWGQB=kQeX-bA8jVn=5Sj_MP_Q2zbMS=tvKGYrNmWLw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/8] vhost-net: allow configuring extended features
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Use the extended feature type for 'acked_features' and implement
> two new ioctls operation to get and set the extended features.
>
> Note that the legacy ioctls implicitly truncate the negotiated
> features to the lower 64 bits range.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/vhost/net.c        | 26 +++++++++++++++++++++++++-
>  drivers/vhost/vhost.h      |  2 +-
>  include/uapi/linux/vhost.h |  8 ++++++++
>  3 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7cbfc7d718b3f..b894685dded3e 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -77,6 +77,10 @@ enum {
>                          (1ULL << VIRTIO_F_RING_RESET)
>  };
>
> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES
> +#define VHOST_NET_FEATURES_EX VHOST_NET_FEATURES
> +#endif
> +
>  enum {
>         VHOST_NET_BACKEND_FEATURES =3D (1ULL << VHOST_BACKEND_F_IOTLB_MSG=
_V2)
>  };
> @@ -1614,7 +1618,7 @@ static long vhost_net_reset_owner(struct vhost_net =
*n)
>         return err;
>  }
>
> -static int vhost_net_set_features(struct vhost_net *n, u64 features)
> +static int vhost_net_set_features(struct vhost_net *n, virtio_features_t=
 features)
>  {
>         size_t vhost_hlen, sock_hlen, hdr_len;
>         int i;
> @@ -1704,6 +1708,26 @@ static long vhost_net_ioctl(struct file *f, unsign=
ed int ioctl,
>                 if (features & ~VHOST_NET_FEATURES)
>                         return -EOPNOTSUPP;
>                 return vhost_net_set_features(n, features);
> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES

Vhost doesn't depend on virtio. But this invents a dependency, and I
don't understand why we need to do that.

Thanks


