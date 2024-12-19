Return-Path: <netdev+bounces-153396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825729F7D53
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11694188B5CE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805CA86343;
	Thu, 19 Dec 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhYIathI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55678F2A
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619715; cv=none; b=N3FN/hgSrzzDKl5iA6O4ByHLmI0CBB96Z8EAyTo0U+ykYLEuNyO0nSmtyy+IJOhjygwCxAQ5VLfwys6SXvY3mTI9V02F2JeY43hxDpzHgtUjgr7h10dz9yuyOgVDUHOwsnckUtmYBhMEUQ7caiX2hr2vbh4V36OgyigHj0HmuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619715; c=relaxed/simple;
	bh=sWynjvh9dabSYwRUA+Jjv/DQhoRvo7p8rsykS+/gwvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIcfwp+oIVQan9B1PP0LMKfQrx66JFh0Wrq1Jm64Qt1+jnbKOkkiijM7MJQNOSteDJb6rCqSFoVj7uBmItVCR1Kj96kXLVZMi7kOnwc3+ROP+ZuFKRazgiFqHdAoIsw/LNx5r+0ez/9jV1rvaul4GxgKxXo1NJ5ysweclXKYq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhYIathI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734619712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWynjvh9dabSYwRUA+Jjv/DQhoRvo7p8rsykS+/gwvY=;
	b=NhYIathIyocgGho1PD7aKyFmz9IAkN0+sz06siKw2WET9E4V8sVtZ5YdsNEHZ7lW69r8p0
	VmXtrbmqCo4Neeu6/DQfYYYjdLAfcO9M5vtbDQLoAgPVCPUDsuogE6RLsQ67f1ldxgwzYc
	jgK0TLq+GQTw9JLZ945C1ivgujwNFPk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-KP4lKimFNkiZ4Ptw-JTRtw-1; Thu, 19 Dec 2024 09:48:30 -0500
X-MC-Unique: KP4lKimFNkiZ4Ptw-JTRtw-1
X-Mimecast-MFC-AGG-ID: KP4lKimFNkiZ4Ptw-JTRtw
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6efed40a56aso9416977b3.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 06:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619709; x=1735224509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWynjvh9dabSYwRUA+Jjv/DQhoRvo7p8rsykS+/gwvY=;
        b=lKUGeK3OhdQyo5MI3PUYqXQ7Tuc4vzjWXxaUHOGEjLAr92Y5sZsQzXYGsB7q0XXhhD
         AtA0BLoDRrESaL5+mJQi99YO1pqG7IvnKOBf8yegCF8BovQoRqliNzIi9uNPOBGmFPdw
         PB2qzo1xgkz9fMSRd4C6uaKwHYKUhL9hOsr/ZXNNI2mDldUAC5we8fJILGShHH243cDg
         +HMc7Xtgdsfl5DURUiF8dW8UwqjK4hazea5430LgnHXOVtf744yyCQqHdLs/LAV53TUL
         gehJLqGP+W4k5l6SImJp5u/3P3IFU4QyZIzBq9H+1XzpQv+0Uy63byPip4IOYN6dP8rN
         fUtA==
X-Forwarded-Encrypted: i=1; AJvYcCWXDlG1SzT7y8VuEWtyMaokdjmjR1ZifesRsBeInL4f1wLQ+M8+EXLZw08lyVufjOXRWRsoBp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84/krqoHBVWyFFPoxR5g9A9B1NKXB8CzKbK9XL4EhUAGEeApt
	uaF00v08NPyjPJAFItCMFiWoOM4UB3UHCa7NlY/dgZK5ZJn9I0wXERmEQBANLnLV3uPFepcMYbk
	RwFs8vxB6nPsN4TpxUxW5DfXT5DoRmwmQ4MdtBJzM82aAfugZ8hkixV6aQg2ZgbAp82CCq2/y5M
	+4xHz7/8fPir3MVmm1dJ7wUcOcCRvB
X-Gm-Gg: ASbGncuT597SMSE7TUOwBDiVVspKj6wavETy4ka4cn2gE1BfLvadEoTQmkV6ETcMqRI
	ThNniGoqxr60RMJ9m2Nu7RWiViXefKKz1YNpj
X-Received: by 2002:a05:690c:d93:b0:6ef:146a:aac0 with SMTP id 00721157ae682-6f3e1b33cc6mr28410157b3.4.1734619709695;
        Thu, 19 Dec 2024 06:48:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgYDQOhtfDr+AO1Qgyag7331PuEiAbwWl2ozIO3vR/nCLHHckhLKLG/7TJoTfW7k7xl48SvjELlcyMVoR1Ttk=
X-Received: by 2002:a05:690c:d93:b0:6ef:146a:aac0 with SMTP id
 00721157ae682-6f3e1b33cc6mr28409887b3.4.1734619709336; Thu, 19 Dec 2024
 06:48:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX> <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX> <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
 <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
 <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX> <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>
 <Z2N44ka8+l83XqcG@v4bel-B760M-AORUS-ELITE-AX> <fezrztdzj5bz54ys6qialz4w3bjqqxmhx74t2tnklbif6ns5dn@mtcjqnqbx6n4>
 <722e8d32-fe5c-4522-be2b-5967fdbb6b30@rbox.co>
In-Reply-To: <722e8d32-fe5c-4522-be2b-5967fdbb6b30@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 19 Dec 2024 15:48:18 +0100
Message-ID: <CAGxU2F5VMGg--iv8Nxvmo_tGhHf_4d_hO5WuibXLUcwVVNgQEg@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
To: Michal Luczaj <mhal@rbox.co>
Cc: Hyunwoo Kim <v4bel@theori.io>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	qwerty@theori.io
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Dec 2024 at 15:36, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 12/19/24 09:19, Stefano Garzarella wrote:
> > ...
> > I think the best thing though is to better understand how to handle
> > deassign, rather than checking everywhere that it's not null, also
> > because in some cases (like the one in virtio-vsock), it's also
> > important that the transport is the same.
>
> My vote would be to apply your virtio_transport_recv_pkt() patch *and* make
> it impossible-by-design to switch ->transport from non-NULL to NULL in
> vsock_assign_transport().

I don't know if that's enough, in this case the problem is that some
response packets are intended for a socket, where the transport has
changed. So whether it's null or assigned but different, it's still a
problem we have to handle.

So making it impossible for the transport to be null, but allowing it
to be different (we can't prevent it from changing), doesn't solve the
problem for us, it only shifts it.

>
> If I'm not mistaken, that would require rewriting vsock_assign_transport()
> so that a new transport is assigned only once fully initialized, otherwise
> keep the old one (still unhurt and functional) and return error. Because
> failing connect() should not change anything under the hood, right?
>

Nope, connect should be able to change the transport.

Because a user can do an initial connect() that requires a specific
transport, this one fails maybe because there's no peer with that cid.
Then the user can redo the connect() to a different cid that requires
a different transport.

Stefano


