Return-Path: <netdev+bounces-193335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DDAAC38C0
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07929170467
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 04:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC111A725A;
	Mon, 26 May 2025 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtFYPujy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DF1BCA07
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748234467; cv=none; b=DMvEIG8gNGhJ+U88PvUGhcIRWdVrgJgnX5cv6DuqkFAZhMe1H9uCJPxFP1pzWFX4VwwmbGwiM3KxX/B9rSS6CjZAAXPZPg9OX2Fs4rHDQJ2yk976Kp6wSx1urcEsRUFmq51/nSTCw3MZRlHPkE3NURKPtZiMN5AfS7apryK9Gls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748234467; c=relaxed/simple;
	bh=G5oHeKCA4GUjC8Ddzh/HQtxJlTKTYo2cMTESzd/FMAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMb64j6NTG/AuddxDL2x5gYHARuWSLh6aMEeL0t0AlH4ubpXwRmoZQplst9/MOcs33EUz9hcwwjeiDwyFL79vgYnIwb7geyP+jNGjW15ATp0WpXRFcmI8PnkhYz4Vp6qscdQ+ShepvdEVPTbeWMCKDsISskrumeqvCRBs1GeWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtFYPujy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748234464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ucwg/e5o3VRwWOTQ7CVJZymUSW9w77nfmYr0aVm0tkY=;
	b=AtFYPujyb5gtuSKiMCZXa9U1Yq12z42jb5W5rj2M/JiyetYzuxmKZF9vYer+RH65wgjHDk
	LSE7zETtKPNFONukTJISMXJwX8MZKVryOr9ln17JdWYKMT5CT/rc0QamY75iSYzw/p1n+1
	Wg5pg4DuEkYVNtrjeXeB+CDXsi3f6no=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-SA4InLEyOxqzNDuo_xmcUg-1; Mon, 26 May 2025 00:41:02 -0400
X-MC-Unique: SA4InLEyOxqzNDuo_xmcUg-1
X-Mimecast-MFC-AGG-ID: SA4InLEyOxqzNDuo_xmcUg_1748234462
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-742951722b3so1526883b3a.2
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 21:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748234462; x=1748839262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ucwg/e5o3VRwWOTQ7CVJZymUSW9w77nfmYr0aVm0tkY=;
        b=LXPL/41fMhtzp1Dg+FUSntX/Vj4IoqK/sVWa3vuFjDY19NKupntsqq8HEZ/avCZJAZ
         3t0M0ehw9FhvaihddCQgdWdqrQK01FD+mO1b/64wqQp/w2rlc3YdLFekf/9THUbGk6N7
         KS0nloWc9I+1S/BeGVdu1x4VYyQaNMaAwBtIViGu3ELUzFnDb3llQo7FKJgAJCfBlZok
         UtTzJ+HTFwW6cV4vh+C2W0cA3QbYoC7qK/j0z2F6b1Vy7kFmvR8fhGimQKW2wDJvwbCP
         WKfHH25qHTLWSIW3KNagd00+zoeAaRZAflpKqTr4EX6am7U2SY9PRKAhJVV7hwxCrpE9
         81Jg==
X-Gm-Message-State: AOJu0YxtyntSx8nSLAbmaz88MPjzfSsYQPuoGNtxqcS8LPPp3bKpJ3x3
	4qrgWlIOb16cMxI0pwQusWqkYMSLTb6oaNRAvDcMdLDa3LKbkb6AplqFovgVq8RXKfVj0iDkYTZ
	xODJb4UjaNPE6SWHgYTFJnz+REZ3FKQBqvpFipc3CtL8ZtiYzkfZHJMdwbvsx3LHeOcFwjM7lGq
	Optf/R6WuKi9e0glDe61iVWDBJWhSROhag
X-Gm-Gg: ASbGncs2emEO02uJe9o2sax/Ybl3MrDsPRkdTBIhB8e1rvfhJ2tjJkqCWlBt5Wf9FRv
	Akk3Emzxkvs9zyzYIRrkWB1K33ISQpJ8RrxMO/70duBeqd5H9ifXoMMYUoLGLv+ZeZfwSBw==
X-Received: by 2002:a05:6a00:4601:b0:740:a52f:a126 with SMTP id d2e1a72fcca58-745fde9f2bamr11820065b3a.9.1748234461771;
        Sun, 25 May 2025 21:41:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAK04zIQSIc1WBcTNJ28AKULM2W0amti2j695ihtddTt5xZz3xBerHbQGpvAoIxB8BBeZ5QTO7mUTZSidqrrA=
X-Received: by 2002:a05:6a00:4601:b0:740:a52f:a126 with SMTP id
 d2e1a72fcca58-745fde9f2bamr11820046b3a.9.1748234461410; Sun, 25 May 2025
 21:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <f95716aed2c65d079cdb10518431088f3e103899.1747822866.git.pabeni@redhat.com>
In-Reply-To: <f95716aed2c65d079cdb10518431088f3e103899.1747822866.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 May 2025 12:40:48 +0800
X-Gm-Features: AX0GCFsc7pbMV2Pm82eQdVZsmwv8Jm8o61uwkDNBcYWusVARPl8WTMMp-oMDzoA
Message-ID: <CACGkMEvFRdgStxGxUjkCyUqn055bvL80bkH-kncvv=E+sLVymw@mail.gmail.com>
Subject: Re: [PATCH net-next 8/8] vhost/net: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 6:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Vhost net need to know the exact virtio net hdr size to be able
> to copy such header correctly. Teach it about the newly defined
> UDP tunnel-related option and update the hdr size computation
> accordingly.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/vhost/net.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index b894685dded3e..985f9662a9003 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -78,7 +78,9 @@ enum {
>  };
>
>  #ifdef VIRTIO_HAS_EXTENDED_FEATURES
> -#define VHOST_NET_FEATURES_EX VHOST_NET_FEATURES
> +#define VHOST_NET_FEATURES_EX (VHOST_NET_FEATURES | \
> +                       (VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO)) |=
 \
> +                       (VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)))
>  #endif
>
>  enum {
> @@ -1621,12 +1623,16 @@ static long vhost_net_reset_owner(struct vhost_ne=
t *n)
>  static int vhost_net_set_features(struct vhost_net *n, virtio_features_t=
 features)
>  {
>         size_t vhost_hlen, sock_hlen, hdr_len;
> +       bool has_tunnel;
>         int i;
>
>         hdr_len =3D (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
>                                (1ULL << VIRTIO_F_VERSION_1))) ?
>                         sizeof(struct virtio_net_hdr_mrg_rxbuf) :
>                         sizeof(struct virtio_net_hdr);
> +       has_tunnel =3D !!(features & (VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_T=
UNNEL_GSO) |
> +                                   VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNN=
EL_GSO)));
> +       hdr_len +=3D has_tunnel ? sizeof(struct virtio_net_hdr_tunnel) : =
0;

Same as patch 7, this seems to ignore the hash report fields.

Thanks


>         if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
>                 /* vhost provides vnet_hdr */
>                 vhost_hlen =3D hdr_len;
> --
> 2.49.0
>


