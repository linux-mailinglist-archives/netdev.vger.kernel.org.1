Return-Path: <netdev+bounces-86407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AB389EA68
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1F7B21C9A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A3C29CFA;
	Wed, 10 Apr 2024 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZRtU12n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D621219E2
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729377; cv=none; b=LgeqtgDWngfX6O2tGLrKo6KAzHoFFepyFEyxsKLcAje6ODD1N+PpgrZ+rAt3NYlxttYiBIwgK8Xlf4yYXIIqLTqkE0yaowVutKX71TAe56zcT6w3AAT30qEG23IPD9LqLeTyk875I6OYt0NFlwS74p0dCx711ffhWcPZlf7vebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729377; c=relaxed/simple;
	bh=fN93S+O/a4r8919HDaOpaGLyUFbfFTR4Yqdw+94Pp/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/Ur/b7TD59RMcql5mXNvmBlmdJ0hM2p9MtThiowydEyUjWUK5kJBu3OhxuIPW7DxYMIETadwL8vcY4Z4T/cNaXYnTqwO39gvhSjovZvlARHJQ9NtlbfwcZ0OJ/HmacJnAXPT8LsWb1VdYRLAjEvJrGfe6Vn1+Y3Qg+CTo1nT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZRtU12n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712729375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b5vs9vSUGn8ADK8g0iw0wXboKE+rPl/OAO5DzwLqrA=;
	b=fZRtU12n45pOJ6eEU0t7R+icutVp5J4sDxQJjIl05v5agDvLFygkfMXyNblYgAt6s3zg5g
	E8DSpXUSCQehICZv3HQslUk/NUuSMOey1WOrc2Ez+JUU3aA53WKQG34P3yKO2Ajr7zhms4
	nnV1iJfaYAUeDu0hEJ8GiUgTZeSFJcQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-F7Y6Zu0EOL2fPkNHu2umDg-1; Wed, 10 Apr 2024 02:09:33 -0400
X-MC-Unique: F7Y6Zu0EOL2fPkNHu2umDg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a4b60f8806so3577836a91.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 23:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712729372; x=1713334172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6b5vs9vSUGn8ADK8g0iw0wXboKE+rPl/OAO5DzwLqrA=;
        b=eApqWmGlUXJ/zr9ZSLz9L4UPl3Jpdj58p7e67UVYuxsfJ4pOeVYNiVntMemd8dNB9S
         CgXEhkz3iRD28LJm4mon/CCls0j6HP3ukO5yaRdrbRWpQH686NhreEF38aTOLRcc1GzL
         Wb2PBUDOZ5fyENkws+L7TWoNCMtObrdxRsWJI7j4HAVvytxJRJwUXZW/cwwwPPYBxLSI
         hJ7PNXugJE0qU6Z96f4I8LEtgt6rUWs70IrA6Kwq2jnAL8z2cQiXNMtjiPVi+hwq1h8F
         8V5dcEeqjTkZ33KU+dJncgEimR+qv1+UIyDRbC968z8CB3wlRepgjC4z73TwLRBJwptF
         jG2g==
X-Gm-Message-State: AOJu0YznuH5kVer3225u5s6cDJ0i23F87ZVtFlWnPTA1ZsUKljvCVIW4
	nT+ly/4TMNA1Hm09oBhGnxoN5cXb0GTtdwmBxlOcCf0PtnakynmfvnPKoHl61ksU5XRy8ATmbSz
	8OxFrfYzOWCT/fhgZCzzNS/AxECtKMFZq16j9Vt7A44oTE6ySvL+jAlC4iYlLBcSy4NY2MwbCHP
	BCSD31FnUw0ur4SxrhRyp8HXW55ih5
X-Received: by 2002:a17:90a:f011:b0:2a5:decc:47e5 with SMTP id bt17-20020a17090af01100b002a5decc47e5mr325840pjb.38.1712729372255;
        Tue, 09 Apr 2024 23:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4OypenlPPbiCIKXCbwYuLlk6d1UE613DACQ8FfIH/rLE/xnrB/ReP5oeXLI6ZF1tM/VeXhwAWDVRBi1ckH5s=
X-Received: by 2002:a17:90a:f011:b0:2a5:decc:47e5 with SMTP id
 bt17-20020a17090af01100b002a5decc47e5mr325822pjb.38.1712729371974; Tue, 09
 Apr 2024 23:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com> <20240318110602.37166-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 14:09:20 +0800
Message-ID: <CACGkMEvd3cg_W64aMMvER03vNqkrxYM6VAMYTj7z3zAkfdaSVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 7/9] virtio_net: rename stat tx_timeout to timeout
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we have this:
>
>     tx_queue_0_tx_timeouts
>
> This is used to record the tx schedule timeout.
> But this has two "tx". I think the below is enough.
>
>     tx_queue_0_timeouts
>
> So I rename this field.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 12dc1d0d8d2b..a24cfde30d08 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -87,7 +87,7 @@ struct virtnet_sq_stats {
>         u64_stats_t xdp_tx;
>         u64_stats_t xdp_tx_drops;
>         u64_stats_t kicks;
> -       u64_stats_t tx_timeouts;
> +       u64_stats_t timeouts;
>  };
>
>  struct virtnet_rq_stats {
> @@ -111,7 +111,7 @@ static const struct virtnet_stat_desc virtnet_sq_stat=
s_desc[] =3D {
>         VIRTNET_SQ_STAT("xdp_tx",       xdp_tx),
>         VIRTNET_SQ_STAT("xdp_tx_drops", xdp_tx_drops),
>         VIRTNET_SQ_STAT("kicks",        kicks),
> -       VIRTNET_SQ_STAT("tx_timeouts",  tx_timeouts),

This is noticeable by userspace, not sure if it's too late.

Thanks


> +       VIRTNET_SQ_STAT("timeouts",     timeouts),
>  };
>
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] =3D {
> @@ -2780,7 +2780,7 @@ static void virtnet_stats(struct net_device *dev,
>                         start =3D u64_stats_fetch_begin(&sq->stats.syncp)=
;
>                         tpackets =3D u64_stats_read(&sq->stats.packets);
>                         tbytes   =3D u64_stats_read(&sq->stats.bytes);
> -                       terrors  =3D u64_stats_read(&sq->stats.tx_timeout=
s);
> +                       terrors  =3D u64_stats_read(&sq->stats.timeouts);
>                 } while (u64_stats_fetch_retry(&sq->stats.syncp, start));
>
>                 do {
> @@ -4568,7 +4568,7 @@ static void virtnet_tx_timeout(struct net_device *d=
ev, unsigned int txqueue)
>         struct netdev_queue *txq =3D netdev_get_tx_queue(dev, txqueue);
>
>         u64_stats_update_begin(&sq->stats.syncp);
> -       u64_stats_inc(&sq->stats.tx_timeouts);
> +       u64_stats_inc(&sq->stats.timeouts);
>         u64_stats_update_end(&sq->stats.syncp);
>
>         netdev_err(dev, "TX timeout on queue: %u, sq: %s, vq: 0x%x, name:=
 %s, %u usecs ago\n",
> --
> 2.32.0.3.g01195cf9f
>


