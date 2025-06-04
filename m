Return-Path: <netdev+bounces-195125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E0DACE285
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6691D17792E
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AF81F8BBD;
	Wed,  4 Jun 2025 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="iXdqDuZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04CE1EA7CE
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056122; cv=none; b=riTSiKvEXIyWmhsrGWULu4PHSepDJfvKm7aqa9qvLbUeeNhgg7h85sEFb+1YinW+Zjrk0YixnBQr/Vso26Z8OWc/aQmiP2ZlyI8GcTKS0Wq5tj2uJOQ6Au5qKQ/wIpQkGKTcl/gftuScAN2jaPTz834zMpCgX5f7vhH1QjS/H5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056122; c=relaxed/simple;
	bh=AM+A6P9w2wkT0X0Ss8sfC+rK4sLbZj/SNTI2K8QsSFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFxGFK1ndym6nGxrcAxQXftcluKLZN0JrgdkUbXFAURJzIUJ5nWnR1UX0zN4fQ9BjCXo2qIc9QKM9edWkGNSFg5rgpFxegTEeIafkkfgjeyCHSluX9/hwijA0ieolG+CVaO2G7fPtj15m9fHoq4bObar3jHjaPPIp04JYGGoBpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=iXdqDuZl; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3124f18c214so53901a91.2
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1749056119; x=1749660919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM+A6P9w2wkT0X0Ss8sfC+rK4sLbZj/SNTI2K8QsSFg=;
        b=iXdqDuZlBH4gDyQQxyUTHepKQrLj73ZDyIYN5fhnC0YHLzKnBYRsD+LyXnLyYHPjlO
         GPaiBxrQQ5epRK0oeJc4kP/t7aY7HhHVENHyLD03QmoSxF77odqBo2osHWJcmvtUhXAX
         hhBi4s3uRpKFvQcyfJtSGAHBEvVmPcyoxENhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056119; x=1749660919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM+A6P9w2wkT0X0Ss8sfC+rK4sLbZj/SNTI2K8QsSFg=;
        b=SssNyS53xK3hOuA/K6gqK7KxsDsYPlHSi8HM0gU0lI6fhFButKfVK8Ru7TmakzcozQ
         4OrZH0BQXFAq6Pzyzse2tllyxm0FoGksFd81bMdsvLtgHAzkgQNuzkYYApIcmrP6NOfe
         wjEgiiw/gDk7mbFMFD65wylt02/U7lQKc4pET6nsmYvTYqbATcLo5DGBXMsSUhuzv6JQ
         DU6PRKS02FihLUHn7GhYvSJ/WA5JUAdQiruXigV4gkF1dsa5527ZeTSXP+tvDGeeY+0/
         YpkxAjpytKXHiyZDe/T7AEiFtrVwITZSZvm5Vfxq6sF97eMmzP3MQCGau0mz8VGtla8O
         FgRg==
X-Gm-Message-State: AOJu0Yyn7QlvCK3jcKmaRnihAyEElzAoMyBBLX9rD9S7Jps3WrHufWpg
	u78QX1+fv3F2iZE3zX+lAwvQvHL3BLhkGZQkVgWIjwOgPiyqYNLT8i+LLWjj2hkJuWaY4W7gsvC
	1JvBiUFSY7E9rOGNZdh5ITTnpeJqP+3k/nWSZRJ5NSsl6xU7Z3ReJrOg=
X-Gm-Gg: ASbGnctHj6umswn/gvkS74kD7Vd1rdoF1LNoTheahTm/3LKMHTT8xaBTDcvPwvZNasq
	x3IVFW1z0IwwmXGgfIrvTfmwORgGsAURyT3LAQji6a/+9ftaeEePoeskd/1CGF7AP5amQ5nhqZP
	ub7+4B0+TYm2mHjIGKd9vq/tL8Knqr03VT
X-Google-Smtp-Source: AGHT+IHSFm7AlkobZVkgSc2uHdOWwSJZnf8VUDuCELETibH45kd+R/oYzSGq4wkai7atxPvVDpyDGYc+gyHX+9/SSX8=
X-Received: by 2002:a17:90b:3d02:b0:312:e9d:4002 with SMTP id
 98e67ed59e1d1-3130cdad8e7mr5604061a91.28.1749056118925; Wed, 04 Jun 2025
 09:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
In-Reply-To: <20250603150613.83802-1-minhquangbui99@gmail.com>
From: Zvi Effron <zeffron@riotgames.com>
Date: Wed, 4 Jun 2025 09:55:06 -0700
X-Gm-Features: AX0GCFuTjwtD_LQoMjFITQPds6k3nNGJ-eA3Q34d-mo_X9J99JpFJ2MIxKJ-Rd8
Message-ID: <CAC1LvL0xTSv9sBRYnD-ykDqQr+Reg7yB0uwAR158-+aAm1J1Ew@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 8:09=E2=80=AFAM Bui Quang Minh <minhquangbui99@gmail=
.com> wrote:
>
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior. This commit instead returns
> XDP_DROP in that case.

Does it make more sense to return XDP_ABORTED? This seems like an unexpecte=
d
exception case to me, but I'm not familiar enough with virtio-net's multibu=
ffer
support.

>
> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> drivers/net/virtio_net.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..4c35324d6e5b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(s=
truct net_device *dev, struct
> ret =3D XDP_PASS;
> rcu_read_lock();
> prog =3D rcu_dereference(rq->xdp_prog);
> - /* TODO: support multi buffer. */
> - if (prog && num_buf =3D=3D 1)
> - ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
> + if (prog) {
> + /* TODO: support multi buffer. */
> + if (num_buf =3D=3D 1)
> + ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
> + stats);
> + else
> + ret =3D XDP_DROP;
> + }
> rcu_read_unlock();
>
> switch (ret) {
> --
> 2.43.0
>
>

