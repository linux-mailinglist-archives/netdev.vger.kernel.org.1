Return-Path: <netdev+bounces-90328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E28ADC18
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3890280D10
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E8F18659;
	Tue, 23 Apr 2024 03:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYDPqqvv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669718049
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841928; cv=none; b=Skv4IY2I9WiKWhgqqA2Zj95bxKh9h9T1SKvkgxFs/y5+NiM5TuaJIhz5fAB+v3zNq+CEf9+WycjzEwFVzbQn8+lzwr37hvC43hDelkaET21wvl/6ZxoVQYS83mARrEYsPeTW2JExw75/0VD88EIgAOe5kIyjLnoZ+7ce2JorO1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841928; c=relaxed/simple;
	bh=T/ufC5uEstpX7JOyLrRfGUXFoGcTxcoqu+hG9uSdM3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTP5uha/vv6wLik5BJVnzI+MZfjVbbWhdlbO1pj1k/eqtGOY2YDwM3SzIN83YgMy84xDRfvcCUnATTczOUrJOU9peUL4EBlsKQAaEtETqDlDJTuIWAgmu90Ua1HeIIK90ktLdabI4h1d3csDf3aN9/hmVX0yqQogDdgzlGVdqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYDPqqvv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713841926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6Hud8ZwYGV/pvpEAsvmgKYrOtwj2IKB6XpISxJlVG0=;
	b=fYDPqqvvm0V2xsVRbCdjW5xgOaQw+FPqnOTPatW1MTerV57fPzLQ1FqOGG5jF3JkA7WqVO
	jPiVQrgm3UlyT5XtRn71teLnZ1H3/SIl9Hzh4jAE1cwrXLZOCPJfzoKZDqR4tUh6KzsB64
	L0bIVrEexcZ1DZjHGwvhVk52WnTHsns=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-4UlKFTDfN62chLNPLgDv1g-1; Mon, 22 Apr 2024 23:12:04 -0400
X-MC-Unique: 4UlKFTDfN62chLNPLgDv1g-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d5a080baf1so5265561a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 20:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713841923; x=1714446723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6Hud8ZwYGV/pvpEAsvmgKYrOtwj2IKB6XpISxJlVG0=;
        b=P7sEucEixT+CkHSVbFi2GU3FEuBGe6aq8XWFmqFFJIQ+ZudjRTHLGRTDYpfUvKvQ6x
         6G0h+JJR5P7wVg8qL08XgRTFwT/M3UB6fYHm9XlT6KywtzpqjcHs0sbWH8IfAwW3aQ1u
         mwj41vKZ7YCwpsUqcPxfk+phMQRKdjhxmLmdHWm8nFfyfY2j2wns2Yb06UAwDJwgq459
         cKH37o7IvOEdo4wvx/di8agXHl/4gp8ad31SPE1X52rUHMCvz6U8Ck4ZHuAPoFXgIfIJ
         qJQfaDkFhijUxSvl+ZxehGjtL52D9Qrxqcm/iUjqC4+4AygNjHBGf5bJRoD654c9TS4K
         yQVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlhCMmo+a/ZVXHEbocCA1wZXh3Yq5p35vX6eUsIabAbr+MeFkoHh2sX0FjvXPNjX0o7DYZ2dYY3yEt/60a4vsV9nVC1bss
X-Gm-Message-State: AOJu0YxhS+SRcxLo6ZSx+JihllzxuD+idVwiSxySPACLdPm48NG5+/8J
	tRqdklvpLs7/MP4kDaHpR3PIRt7wY88TEpsO3NkkR+RUeGDdqkL5RN+L7W+scFXGnZ4g8LOPrrW
	Ol0Vt78kCUmQwv9xrAYYLRyMGUAzOUb/szr714pKBIEp48zKylJKHtwmiscVbM+myZ8k/xE+mHk
	K5Pirv4uRsLsS/g7EAs8+zltYxBIBh
X-Received: by 2002:a05:6a20:3256:b0:1a7:5721:7011 with SMTP id hm22-20020a056a20325600b001a757217011mr11311677pzc.41.1713841923309;
        Mon, 22 Apr 2024 20:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL/9rAZIQKEhE2sGik3GY4VP6E6ML0Uuq+/eQz4r9cyQjK8L0BsWvQoRqid/ZT5JNaJAJMTO7IM8KdyetjUHA=
X-Received: by 2002:a05:6a20:3256:b0:1a7:5721:7011 with SMTP id
 hm22-20020a056a20325600b001a757217011mr11311674pzc.41.1713841923041; Mon, 22
 Apr 2024 20:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com> <20240422072408.126821-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240422072408.126821-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Apr 2024 11:11:51 +0800
Message-ID: <CACGkMEubWOFq8Bj1Kk02Om8DnbhFyNtAD_Lk8mXL4c2GSZgabA@mail.gmail.com>
Subject: Re: [PATCH vhost v2 7/7] virtio_net: remove the misleading comment
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> We call the build_skb() actually without copying data.
> The comment is misleading. So remove it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 848e93ccf2ef..ae15254a673b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -690,7 +690,6 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>
>         shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
> -       /* copy small packet so we can reuse these pages */
>         if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >=3D shinfo_=
size) {
>                 skb =3D virtnet_build_skb(buf, truesize, p - buf, len);
>                 if (unlikely(!skb))
> --
> 2.32.0.3.g01195cf9f
>


