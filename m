Return-Path: <netdev+bounces-195155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4ADACE793
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 02:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E8C1895FD8
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 00:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0474C18C06;
	Thu,  5 Jun 2025 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOC/av84"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C6D2FB
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749084392; cv=none; b=nKyw/VDlz3xUBEiBMJOa0K90D8CDNLQYqzRnWuPBSJoAB35CmO0LOkPUUzI+VJLqb17yd7pFZQPWEez5SAUWl3USlrdpAe8sNjkcASAY+pkVJryKyFG4RlRMrnJPWz7WYGvGgJk/Dg+Vz9A1PfperiL87pUqoE9w4DlotvWL+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749084392; c=relaxed/simple;
	bh=gQ2K28JFSJwrXcviJxZJUo1aNRaVu0m2YAcpDoDihjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJaoDMDguhj13dKBJuRZP11TDMwAldwmjsyKqlZGMRt+Lq6KOfuRcGCPMHIZHeRaeGHvidQta4dCI8rd35ewqLjOVgkBh5ISP3rtXNR/Ifxr3zk4cdwt2zQhbiFidwBwWWWib3xqbybuJssLLBM6daAshmTbzwXHxy2+fHci/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOC/av84; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749084390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rvoJRZ+941RRB3yT2eqwz3H2iab1etLIqCrT/3n0JQ=;
	b=VOC/av844JdAZzNwNKyB08D/6JGHXAo2r3ehJARx9H1ZFKOHd/jv1bbnUF1PtdelgkRo34
	m6YnoKod7uWIUGgTSKobLDaU6GGtzO7AIaBjdpC8/oensZRy4IvUMrk8YQAG577FcJFymC
	Nc2dDCOt1zb5/ok1CQQvgbOx6yw5yyQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-6A_p7krbNZCNznCKfBIBDw-1; Wed, 04 Jun 2025 20:46:28 -0400
X-MC-Unique: 6A_p7krbNZCNznCKfBIBDw-1
X-Mimecast-MFC-AGG-ID: 6A_p7krbNZCNznCKfBIBDw_1749084388
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-747a9ef52a4so585937b3a.2
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 17:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749084387; x=1749689187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rvoJRZ+941RRB3yT2eqwz3H2iab1etLIqCrT/3n0JQ=;
        b=mKGwh14bd13aWtrFcCadWCU+V284Zkon68ZnwBu1YbixfSeuhblxnU0P+Fm3UeJg0v
         nulXq9nT0Vnk/5Iyz2YxDUwetPl5GrYF9W2Pbd++xCTP8RHoCJdXhQQxURFxZNcWu/PV
         npWynBkhxThBgNZnE9YgCbN6N5g/oO+l3mGcfjw/YsIjwwRoEkHUIiNpKYwRRgMSjoqI
         JjBarHSra8CKo4C+dh/il+nYCmS2l0qO34H1k/Z2vQV+38E7IrPehN0FUvemv9o3LSAw
         efqljj/nJn+tkWY+PNqEIPRv9SoeIshxe+ACzE+luetIzRe7AuRr/uBrpKw0NQ3fYDXB
         vEzQ==
X-Gm-Message-State: AOJu0YzWu3pj1XsQGcvLMnzt+GB5Uj8NMdT8+q9E1nHo0haZewv0ox1/
	yI7KYC5ZIos2sB+nfNo4FeDCAICkMOC62CM4M0UJfUpAVbdcAfaO7R7SSw9H8hCHw7KbOP1Hqop
	Jf5MZP2Alh+RbfExPglliPtz7+4KlUrOtboRTPJRy+YQ2yuKjB4Eti8I/MDunhdYjdLVO6S+/xx
	5qsiaOgPm48DuycYFXMauWWj+nFXVSHK2N
X-Gm-Gg: ASbGncsoIHL2MRB+gXHCFOYMqevkoOyUX6Fn5Qea5GTd1+UPPhofgVM9Hn4PkDdGy1S
	yCMRbnydbAvdwxR/DMf6mW0BUnjCzocoKvoHUzvfpt5ubMEKob8p87a1Ej6Wvj7IfKZC/
X-Received: by 2002:a05:6a00:1a8b:b0:736:53f2:87bc with SMTP id d2e1a72fcca58-7480b41c057mr6620865b3a.13.1749084387532;
        Wed, 04 Jun 2025 17:46:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWm/kjbk8cd6j93CgnJ1yt93I+3ZM/WhLMOUv1rkUy4RSWdCL17+h6rPArAx08BKWo82wHYZSyXb0/Dn2zN4A=
X-Received: by 2002:a05:6a00:1a8b:b0:736:53f2:87bc with SMTP id
 d2e1a72fcca58-7480b41c057mr6620834b3a.13.1749084387116; Wed, 04 Jun 2025
 17:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <CACGkMEuHDLJiw=VdX38xqkaS-FJPTAU6+XUNwfGkNZGfp+6tKg@mail.gmail.com> <0bc8547d-aa8f-4d96-9191-fd52d1bec74e@gmail.com>
In-Reply-To: <0bc8547d-aa8f-4d96-9191-fd52d1bec74e@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Jun 2025 08:46:16 +0800
X-Gm-Features: AX0GCFvjyMd1H9dniamKbUvfa3PlpuL7i79qr8xhrVJzz6-ckoHw99myc9wjf_U
Message-ID: <CACGkMEvnn52XaidBdD9yGy8Yfpw3vu+QLcd8JoBSNS5ZEtmMqw@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 10:17=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 6/4/25 07:37, Jason Wang wrote:
> > On Tue, Jun 3, 2025 at 11:07=E2=80=AFPM Bui Quang Minh <minhquangbui99@=
gmail.com> wrote:
> >> In virtio-net, we have not yet supported multi-buffer XDP packet in
> >> zerocopy mode when there is a binding XDP program. However, in that
> >> case, when receiving multi-buffer XDP packet, we skip the XDP program
> >> and return XDP_PASS. As a result, the packet is passed to normal netwo=
rk
> >> stack which is an incorrect behavior. This commit instead returns
> >> XDP_DROP in that case.
> >>
> >> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >> ---
> >>   drivers/net/virtio_net.c | 11 ++++++++---
> >>   1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index e53ba600605a..4c35324d6e5b 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merg=
e(struct net_device *dev, struct
> >>          ret =3D XDP_PASS;
> > It would be simpler to just assign XDP_DROP here?
> >
> > Or if you wish to stick to the way, we can simply remove this assignmen=
t.
>
> This XDP_PASS is returned for the case when there is no XDP program
> binding (!prog).

You're right.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> >
> >>          rcu_read_lock();
> >>          prog =3D rcu_dereference(rq->xdp_prog);
> >> -       /* TODO: support multi buffer. */
> >> -       if (prog && num_buf =3D=3D 1)
> >> -               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, =
stats);
> >> +       if (prog) {
> >> +               /* TODO: support multi buffer. */
> >> +               if (num_buf =3D=3D 1)
> >> +                       ret =3D virtnet_xdp_handler(prog, xdp, dev, xd=
p_xmit,
> >> +                                                 stats);
> >> +               else
> >> +                       ret =3D XDP_DROP;
> >> +       }
> >>          rcu_read_unlock();
> >>
> >>          switch (ret) {
> >> --
> >> 2.43.0
> >>
> > Thanks
> >
>
>
> Thanks,
> Quang Minh.
>
>


