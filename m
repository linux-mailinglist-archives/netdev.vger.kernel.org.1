Return-Path: <netdev+bounces-86405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D689EA61
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09451F239A4
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4FF282F9;
	Wed, 10 Apr 2024 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anU1H4yL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA0262A8
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729370; cv=none; b=eL8WBz7x5EjA5d79xPeWMnAyyFoZxIm0ixBUxRlqgI1hbBIKtHtARDqVf5o56EMfYuOqHAGGkI5rXMe978uvM9iJk/Vo78ilO2VhI+VPZQ6VfZLuh/Ov8ZJt5Ke9U6PtfzeQZzGpZMxKGXyISL0LSie+crzvKEFFnRFNH1KYuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729370; c=relaxed/simple;
	bh=dIQqCW4vXQ8LoM7WsnlboTXmHceZ6q4uVBsb5+MjBeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6d0hUbXrokVpsDN7841qC0g0fyEtDtfJoeSEDEbhtNdU187UFvCWgkIg7zjlCoVQ9vk6RtP8oN/7Q1wCMhpBKUD4nQrobFbd/2FPnaYzHd7iuhHtvn2Rb384w4CyC5wf1yPqPczjlj/tRiY6B6s6UHG98lm+i2m7wcXi1eMrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anU1H4yL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712729368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpUDa2UySzZ6xNtAKKwlmJjaVp8SzowsTqBfpIs3GWw=;
	b=anU1H4yLnA+RWOlDfxm5MCEqo8O++6rVg05/Ylfkz+HLlDpFWQdpZVsu/ELlt+D11fpTcD
	pYttX2H0QCqAf/55VVXUEaBahRGMN5e7AW7rh4Pqh//V4ngn43Ttk3i2rlyjQ/y8k1CLJP
	POjh3IKuji0T/gpHAT76Jp79iEVhjqs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-KlwhXEYEMra_jyHrBwaBjw-1; Wed, 10 Apr 2024 02:09:25 -0400
X-MC-Unique: KlwhXEYEMra_jyHrBwaBjw-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5a796dc1461so6536056eaf.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 23:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712729365; x=1713334165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpUDa2UySzZ6xNtAKKwlmJjaVp8SzowsTqBfpIs3GWw=;
        b=TFUgM0SgXa3nt2EniDm9HHTwZkOSw4y91Pj6b8aSM2p0RmUsYlWaDzdrFMm4WhpC9q
         h431X3nr01f1fSbK1l7Q0J3ZyVjzZKVPR4lEM/XDCyKvM9N5DXMzdZ5bkf/Ond+Tss6T
         +rs0cCRdjJT3gaMBDoFIsmhtv+CVajSKxJW+PYJofTnzNKZcH/Krt3YBvES6TaH+TU2D
         K0OIU4444RItcr5mPRBeiRary6ugYJOqqqVVoHNXTL04hQPblXTCBL8YExUbb7/z3tCz
         k8C97yLD42SMKZNMq+vcZlFfz8Klqkb3kwQxsR/VSYq8ES0QS+Ua2Dqe9O5EPFn5Dy/q
         Xhmw==
X-Gm-Message-State: AOJu0YyWMGiEkZQIzXdC2uKj2Bniy+Ax5RJElmWaNw1lUCrc1eu216Uz
	tFIPglhoWR7JZke/45bRPTdKyuHjp65e8+BYgRelaQjKbd8WW/x2aC3sW1wdioTJDF+Stugu0qt
	4OU88k0nhPW4sRs4mV/KmnnYVbey3wQ3cAbxteiERZbr8+623jZq9y8snWz/glrLMUQ+SEIwc7d
	v3GNyneKYPXkMvwLG0PE9wyBRt5L9+
X-Received: by 2002:a05:6358:4b45:b0:183:9ea4:74ab with SMTP id ks5-20020a0563584b4500b001839ea474abmr2134344rwc.31.1712729365211;
        Tue, 09 Apr 2024 23:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd6cDUF6ppyja4kOtkluO3wddXwNXimvcjissix6p7JvRj9JHcaaOGJT1Jjj9iErmie7vMc+YqpALeBXrbmY0=
X-Received: by 2002:a05:6358:4b45:b0:183:9ea4:74ab with SMTP id
 ks5-20020a0563584b4500b001839ea474abmr2134319rwc.31.1712729364897; Tue, 09
 Apr 2024 23:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com> <20240318110602.37166-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 14:09:11 +0800
Message-ID: <CACGkMEt_RYQMLpZOYe6MhhxeH8xpzKUJE-UCthBCr+7JgD6V1g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/9] virtio_net: virtnet_send_command supports command-specific-result
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f3899898230=
39724f95bbbd243291ab0064f82
>
> The virtnet cvq supports to get result from the device.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 47 +++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..af512d85cd5b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2512,10 +2512,11 @@ static int virtnet_tx_resize(struct virtnet_info =
*vi,
>   * never fail unless improperly formatted.
>   */
>  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 c=
md,
> -                                struct scatterlist *out)
> +                                struct scatterlist *out,
> +                                struct scatterlist *in)
>  {
> -       struct scatterlist *sgs[4], hdr, stat;
> -       unsigned out_num =3D 0, tmp;
> +       struct scatterlist *sgs[5], hdr, stat;
> +       u32 out_num =3D 0, tmp, in_num =3D 0;
>         int ret;
>
>         /* Caller should know better */
> @@ -2533,10 +2534,13 @@ static bool virtnet_send_command(struct virtnet_i=
nfo *vi, u8 class, u8 cmd,
>
>         /* Add return status. */
>         sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
> -       sgs[out_num] =3D &stat;
> +       sgs[out_num + in_num++] =3D &stat;
>
> -       BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
> -       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMI=
C);
> +       if (in)
> +               sgs[out_num + in_num++] =3D in;
> +
> +       BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
> +       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_=
ATOMIC);
>         if (ret < 0) {
>                 dev_warn(&vi->vdev->dev,
>                          "Failed to add sgs for command vq: %d\n.", ret);
> @@ -2578,7 +2582,8 @@ static int virtnet_set_mac_address(struct net_devic=
e *dev, void *p)
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
>                 sg_init_one(&sg, addr->sa_data, dev->addr_len);
>                 if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> -                                         VIRTIO_NET_CTRL_MAC_ADDR_SET, &=
sg)) {
> +                                         VIRTIO_NET_CTRL_MAC_ADDR_SET,
> +                                         &sg, NULL)) {
>                         dev_warn(&vdev->dev,
>                                  "Failed to set mac address by vq command=
.\n");
>                         ret =3D -EINVAL;
> @@ -2647,7 +2652,7 @@ static void virtnet_ack_link_announce(struct virtne=
t_info *vi)
>  {
>         rtnl_lock();
>         if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_ANNOUNCE,
> -                                 VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL))
> +                                 VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL, NUL=
L))

Nit: It might be better to introduce a virtnet_send_command_reply()
and let virtnet_send_command() call it as in=3DNULL to simplify the
changes.

Others look good.

Thanks


