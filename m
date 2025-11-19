Return-Path: <netdev+bounces-239777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0887C6C54F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B8EEE2954E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4483F261B9A;
	Wed, 19 Nov 2025 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0EyRKK0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xn3wJseE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D38C1DC1AB
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763518064; cv=none; b=LO7vLirte5scCwnSHmdXVw0GvFUbYswDQFQi1PnU+PQ7T2YmCzCYeQPF2B5cmUbSq8uz22FRywGghbgddJi1KkqxQQ5cZK/uJpTRzMoPgV3/aj0a/43W4UATelkzE1Y3nzMyKOBhikwgRwtZAzI6v3Tdnxi5ytbk5wnJ49PZcVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763518064; c=relaxed/simple;
	bh=qCPvjbPyrqEz/TADGcfkQrklmfu8vszx3E4BBHEcAEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMBTisK0+TmnV3e3uNSoqErT4GwxHX1IM0O6E5BzYguR+qNGNSkx+wiXVi5pQIYV0o8rE40r0UzTGvhKtxhfhxMy4/3uMbTVfmqpizHioMZti7mw2rEoMjLoCxgEq6w1SLjO1vrP4SJmE3DsBKwQVXtrcXSu/SFE0AuC7mOj7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0EyRKK0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xn3wJseE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763518061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4eFjpzST/7FqskG5nkglbLK48aXe7h6Rso97yeE/nI=;
	b=B0EyRKK0iXASirw4CdRgx5VoePzmJ+wlO/RyZkiJeaAzgnMa0eviCnVL5A8X1nFKHNV/OA
	PK5d0ER+av2q1GpWFxNolicn9OFzLDN5NEh0UnfxH3H/UP9fjWX5uokOjVRZHxKk2Dg6j0
	TopgMR7W3ds/tdJe1lTyeCV6aSD1Qv0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-2gdsA-pPNliJPYvV4EKBIQ-1; Tue, 18 Nov 2025 21:07:39 -0500
X-MC-Unique: 2gdsA-pPNliJPYvV4EKBIQ-1
X-Mimecast-MFC-AGG-ID: 2gdsA-pPNliJPYvV4EKBIQ_1763518058
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29806c42760so222640885ad.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763518058; x=1764122858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4eFjpzST/7FqskG5nkglbLK48aXe7h6Rso97yeE/nI=;
        b=Xn3wJseEf9R5flb9sZByjsu4IH8AUl32IpdaN8BXCNdkpkskD9Ja0nysuNptX60oiF
         j62cDkFhf3fjR6Tsu/CUkD5060XVaXtm5p5o/FYQaaxGlweKUIU4aq/bZOB3IGYCbBzE
         C1hyL0Z/iQtKwjngpBNHX/EYxjJsmo7JpWX8DKz70ZE0DIz+pd7NAlYkBnpiIJqGghET
         ajkKfL4whwGKaMrq2fttxBCllwk5rw2kPxaDWYhiGvGo7gGHcKReSaA3HYNptja6ccQH
         zhGdQB0Qm3OrjIs1fWQsAN9wtWtVB2WNZzDyCqKGofsXMxVaH6GjZUix6HL9CiYWswHv
         bHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763518058; x=1764122858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4eFjpzST/7FqskG5nkglbLK48aXe7h6Rso97yeE/nI=;
        b=bw8lyl2YygDi5keybBl+qygA/SX/inqSWSCYJ8mSbzIcMtHR7Jvtx/g7RMfugngcMn
         Ic8CEBin2WGBMO6DO0IDQ6PVICSSRcx6pFNR15Db2tQxwh/P6DNCeYsdmDCbwLg5eOhr
         boFgxVXU796OecFu6UFyqMrJ7aFsGY6LKqAp2WZg+bVLvLOgm5uTz9FUkbqXfe9IuHf8
         VWGXKAHeU2JR+c+8528QEr4RL0sjsE3o3iP39AfocE7ASXTOr1tX3ZYXsgO5vjZ6KNpV
         iSQRr0CPtHjrCpx521VlWw5L2p0ntAkC3NGA/PyZ7N7vJQSgVVeU+o5udgA1RXC7fBAR
         932Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqEbsJFb556whcI+rt1zeh52tho/TJV0i9ZCmL/RlS/O3atZzQrG7s7zkgXz0oXdgn7oZPSQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjRG06VXFjsMKdDP/d2ROmPALA4VNxgfY40CD8JW5IVMSlRFj
	RPTQV8SxFYEGUuH8XushfutY72lhWtYlGA/PpPnkleylXkEiM51CBUr4lhtvTr7JOOGENNJUgmL
	pAUH5j8bNK4p3OP7B16UtqU4t0VGF/3iqlIUxRUALXCKkm/TYtkz/qqUKAryhinSt5KAAXja8UF
	EJAGkru8IDAzev3Rz9CD/MY5PcJzC+4Mhi
X-Gm-Gg: ASbGnctq4NH18u5s+dJCfRaGJDh9fjjR6UfV2WI4H8hxXwgaT/VMZYuDJvXVKNIcIno
	4GgiQjp+TOqjhfkJTPYAQfe1MIvbc6Cl3XWZvEZxzCoodzF9hc1XdU106DpFxZ2PEdv16uFn0jf
	kys5xEeYFB2+2Z2KoJ07S184qqTJ1shZ+xTmCPYTKHenYBMZWAjrnq1S8+3WFVQnE=
X-Received: by 2002:a17:902:d506:b0:294:f30f:ea4b with SMTP id d9443c01a7336-2986a6b876dmr182238615ad.8.1763518058040;
        Tue, 18 Nov 2025 18:07:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeNmmVfrrspl6rGIc3D9CV7NqJozv/OQZ7x2GYHJcSke+eR1q39k1K+UiJUfQ97cov5THZVM1u3R8wVQVhXxE=
X-Received: by 2002:a17:902:d506:b0:294:f30f:ea4b with SMTP id
 d9443c01a7336-2986a6b876dmr182238245ad.8.1763518057445; Tue, 18 Nov 2025
 18:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113015420.3496-1-jasowang@redhat.com> <20251113030230-mutt-send-email-mst@kernel.org>
 <CACGkMEtnihOt=g+zs0gVQ=wnx8_YF_F=QSuLQ4RGWBVuOeFi7w@mail.gmail.com>
 <20251114012141-mutt-send-email-mst@kernel.org> <CACGkMEuqPtrCotXRcP2kzdaJ50L3oY7U-LVAKNuXOFJP_h1_PQ@mail.gmail.com>
 <20251117034446-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251117034446-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 10:07:25 +0800
X-Gm-Features: AWmQ_blKbntcqNTR-p4W8w_fljr4MW0-vt2uxGDqpZFsxDx5iKHoNZJAujuIHy4
Message-ID: <CACGkMEtoKYrv5A9GAq_KcrpvN03SkoYPRkxnb20NhBVcOHp3jg@mail.gmail.com>
Subject: Re: [PATCH net] vhost: rewind next_avail_head while discarding descriptors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:49=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 17, 2025 at 12:26:51PM +0800, Jason Wang wrote:
> > On Fri, Nov 14, 2025 at 2:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 09:53:12AM +0800, Jason Wang wrote:
> > > > On Thu, Nov 13, 2025 at 4:13=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Nov 13, 2025 at 09:54:20AM +0800, Jason Wang wrote:
> > > > > > When discarding descriptors with IN_ORDER, we should rewind
> > > > > > next_avail_head otherwise it would run out of sync with
> > > > > > last_avail_idx. This would cause driver to report
> > > > > > "id X is not a head".
> > > > > >
> > > > > > Fixing this by returning the number of descriptors that is used=
 for
> > > > > > each buffer via vhost_get_vq_desc_n() so caller can use the val=
ue
> > > > > > while discarding descriptors.
> > > > > >
> > > > > > Fixes: 67a873df0c41 ("vhost: basic in order support")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >
> > > > > Wow that change really caused a lot of fallout.
> > > > >
> > > > > Thanks for the patch! Yet something to improve:
> > > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/vhost/net.c   | 53 ++++++++++++++++++++++++++---------=
--------
> > > > > >  drivers/vhost/vhost.c | 43 ++++++++++++++++++++++++-----------
> > > > > >  drivers/vhost/vhost.h |  9 +++++++-
> > > > > >  3 files changed, 70 insertions(+), 35 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > > > > index 35ded4330431..8f7f50acb6d6 100644
> > > > > > --- a/drivers/vhost/net.c
> > > > > > +++ b/drivers/vhost/net.c
> > > > > > @@ -592,14 +592,15 @@ static void vhost_net_busy_poll(struct vh=
ost_net *net,
> > > > > >  static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
> > > > > >                                   struct vhost_net_virtqueue *t=
nvq,
> > > > > >                                   unsigned int *out_num, unsign=
ed int *in_num,
> > > > > > -                                 struct msghdr *msghdr, bool *=
busyloop_intr)
> > > > > > +                                 struct msghdr *msghdr, bool *=
busyloop_intr,
> > > > > > +                                 unsigned int *ndesc)
> > > > > >  {
> > > > > >       struct vhost_net_virtqueue *rnvq =3D &net->vqs[VHOST_NET_=
VQ_RX];
> > > > > >       struct vhost_virtqueue *rvq =3D &rnvq->vq;
> > > > > >       struct vhost_virtqueue *tvq =3D &tnvq->vq;
> > > > > >
> > > > > > -     int r =3D vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq=
->iov),
> > > > > > -                               out_num, in_num, NULL, NULL);
> > > > > > +     int r =3D vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SIZE(t=
vq->iov),
> > > > > > +                                 out_num, in_num, NULL, NULL, =
ndesc);
> > > > > >
> > > > > >       if (r =3D=3D tvq->num && tvq->busyloop_timeout) {
> > > > > >               /* Flush batched packets first */
> > > > > > @@ -610,8 +611,8 @@ static int vhost_net_tx_get_vq_desc(struct =
vhost_net *net,
> > > > > >
> > > > > >               vhost_net_busy_poll(net, rvq, tvq, busyloop_intr,=
 false);
> > > > > >
> > > > > > -             r =3D vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE=
(tvq->iov),
> > > > > > -                                   out_num, in_num, NULL, NULL=
);
> > > > > > +             r =3D vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SI=
ZE(tvq->iov),
> > > > > > +                                     out_num, in_num, NULL, NU=
LL, ndesc);
> > > > > >       }
> > > > > >
> > > > > >       return r;
> > > > > > @@ -642,12 +643,14 @@ static int get_tx_bufs(struct vhost_net *=
net,
> > > > > >                      struct vhost_net_virtqueue *nvq,
> > > > > >                      struct msghdr *msg,
> > > > > >                      unsigned int *out, unsigned int *in,
> > > > > > -                    size_t *len, bool *busyloop_intr)
> > > > > > +                    size_t *len, bool *busyloop_intr,
> > > > > > +                    unsigned int *ndesc)
> > > > > >  {
> > > > > >       struct vhost_virtqueue *vq =3D &nvq->vq;
> > > > > >       int ret;
> > > > > >
> > > > > > -     ret =3D vhost_net_tx_get_vq_desc(net, nvq, out, in, msg, =
busyloop_intr);
> > > > > > +     ret =3D vhost_net_tx_get_vq_desc(net, nvq, out, in, msg,
> > > > > > +                                    busyloop_intr, ndesc);
> > > > > >
> > > > > >       if (ret < 0 || ret =3D=3D vq->num)
> > > > > >               return ret;
> > > > > > @@ -766,6 +769,7 @@ static void handle_tx_copy(struct vhost_net=
 *net, struct socket *sock)
> > > > > >       int sent_pkts =3D 0;
> > > > > >       bool sock_can_batch =3D (sock->sk->sk_sndbuf =3D=3D INT_M=
AX);
> > > > > >       bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER=
);
> > > > > > +     unsigned int ndesc =3D 0;
> > > > > >
> > > > > >       do {
> > > > > >               bool busyloop_intr =3D false;
> > > > > > @@ -774,7 +778,7 @@ static void handle_tx_copy(struct vhost_net=
 *net, struct socket *sock)
> > > > > >                       vhost_tx_batch(net, nvq, sock, &msg);
> > > > > >
> > > > > >               head =3D get_tx_bufs(net, nvq, &msg, &out, &in, &=
len,
> > > > > > -                                &busyloop_intr);
> > > > > > +                                &busyloop_intr, &ndesc);
> > > > > >               /* On error, stop handling until the next kick. *=
/
> > > > > >               if (unlikely(head < 0))
> > > > > >                       break;
> > > > > > @@ -806,7 +810,7 @@ static void handle_tx_copy(struct vhost_net=
 *net, struct socket *sock)
> > > > > >                               goto done;
> > > > > >                       } else if (unlikely(err !=3D -ENOSPC)) {
> > > > > >                               vhost_tx_batch(net, nvq, sock, &m=
sg);
> > > > > > -                             vhost_discard_vq_desc(vq, 1);
> > > > > > +                             vhost_discard_vq_desc(vq, 1, ndes=
c);
> > > > > >                               vhost_net_enable_vq(net, vq);
> > > > > >                               break;
> > > > > >                       }
> > > > > > @@ -829,7 +833,7 @@ static void handle_tx_copy(struct vhost_net=
 *net, struct socket *sock)
> > > > > >               err =3D sock->ops->sendmsg(sock, &msg, len);
> > > > > >               if (unlikely(err < 0)) {
> > > > > >                       if (err =3D=3D -EAGAIN || err =3D=3D -ENO=
MEM || err =3D=3D -ENOBUFS) {
> > > > > > -                             vhost_discard_vq_desc(vq, 1);
> > > > > > +                             vhost_discard_vq_desc(vq, 1, ndes=
c);
> > > > > >                               vhost_net_enable_vq(net, vq);
> > > > > >                               break;
> > > > > >                       }
> > > > > > @@ -868,6 +872,7 @@ static void handle_tx_zerocopy(struct vhost=
_net *net, struct socket *sock)
> > > > > >       int err;
> > > > > >       struct vhost_net_ubuf_ref *ubufs;
> > > > > >       struct ubuf_info_msgzc *ubuf;
> > > > > > +     unsigned int ndesc =3D 0;
> > > > > >       bool zcopy_used;
> > > > > >       int sent_pkts =3D 0;
> > > > > >
> > > > > > @@ -879,7 +884,7 @@ static void handle_tx_zerocopy(struct vhost=
_net *net, struct socket *sock)
> > > > > >
> > > > > >               busyloop_intr =3D false;
> > > > > >               head =3D get_tx_bufs(net, nvq, &msg, &out, &in, &=
len,
> > > > > > -                                &busyloop_intr);
> > > > > > +                                &busyloop_intr, &ndesc);
> > > > > >               /* On error, stop handling until the next kick. *=
/
> > > > > >               if (unlikely(head < 0))
> > > > > >                       break;
> > > > > > @@ -941,7 +946,7 @@ static void handle_tx_zerocopy(struct vhost=
_net *net, struct socket *sock)
> > > > > >                                       vq->heads[ubuf->desc].len=
 =3D VHOST_DMA_DONE_LEN;
> > > > > >                       }
> > > > > >                       if (retry) {
> > > > > > -                             vhost_discard_vq_desc(vq, 1);
> > > > > > +                             vhost_discard_vq_desc(vq, 1, ndes=
c);
> > > > > >                               vhost_net_enable_vq(net, vq);
> > > > > >                               break;
> > > > > >                       }
> > > > > > @@ -1045,11 +1050,12 @@ static int get_rx_bufs(struct vhost_net=
_virtqueue *nvq,
> > > > > >                      unsigned *iovcount,
> > > > > >                      struct vhost_log *log,
> > > > > >                      unsigned *log_num,
> > > > > > -                    unsigned int quota)
> > > > > > +                    unsigned int quota,
> > > > > > +                    unsigned int *ndesc)
> > > > > >  {
> > > > > >       struct vhost_virtqueue *vq =3D &nvq->vq;
> > > > > >       bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER=
);
> > > > > > -     unsigned int out, in;
> > > > > > +     unsigned int out, in, desc_num, n =3D 0;
> > > > > >       int seg =3D 0;
> > > > > >       int headcount =3D 0;
> > > > > >       unsigned d;
> > > > > > @@ -1064,9 +1070,9 @@ static int get_rx_bufs(struct vhost_net_v=
irtqueue *nvq,
> > > > > >                       r =3D -ENOBUFS;
> > > > > >                       goto err;
> > > > > >               }
> > > > > > -             r =3D vhost_get_vq_desc(vq, vq->iov + seg,
> > > > > > -                                   ARRAY_SIZE(vq->iov) - seg, =
&out,
> > > > > > -                                   &in, log, log_num);
> > > > > > +             r =3D vhost_get_vq_desc_n(vq, vq->iov + seg,
> > > > > > +                                     ARRAY_SIZE(vq->iov) - seg=
, &out,
> > > > > > +                                     &in, log, log_num, &desc_=
num);
> > > > > >               if (unlikely(r < 0))
> > > > > >                       goto err;
> > > > > >
> > > > > > @@ -1093,6 +1099,7 @@ static int get_rx_bufs(struct vhost_net_v=
irtqueue *nvq,
> > > > > >               ++headcount;
> > > > > >               datalen -=3D len;
> > > > > >               seg +=3D in;
> > > > > > +             n +=3D desc_num;
> > > > > >       }
> > > > > >
> > > > > >       *iovcount =3D seg;
> > > > > > @@ -1113,9 +1120,11 @@ static int get_rx_bufs(struct vhost_net_=
virtqueue *nvq,
> > > > > >               nheads[0] =3D headcount;
> > > > > >       }
> > > > > >
> > > > > > +     *ndesc =3D n;
> > > > > > +
> > > > > >       return headcount;
> > > > > >  err:
> > > > > > -     vhost_discard_vq_desc(vq, headcount);
> > > > > > +     vhost_discard_vq_desc(vq, headcount, n);
> > > > >
> > > > > So here ndesc and n are the same, but below in vhost_discard_vq_d=
esc
> > > > > they are different. Fun.
> > > >
> > > > Not necessarily the same, a buffer could contain more than 1 descri=
ptor.
> > >
> > >
> > > *ndesc =3D n kinda guarantees it's the same, no?
> >
> > I misread your comment, in the error path the ndesc is left unused.
>
>
>
>
> > Would this be a problem?
> > >
> > > > >
> > > > > >       return r;
> > > > > >  }
> > > > > >
> > > > > > @@ -1151,6 +1160,7 @@ static void handle_rx(struct vhost_net *n=
et)
> > > > > >       struct iov_iter fixup;
> > > > > >       __virtio16 num_buffers;
> > > > > >       int recv_pkts =3D 0;
> > > > > > +     unsigned int ndesc;
> > > > > >
> > > > > >       mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> > > > > >       sock =3D vhost_vq_get_backend(vq);
> > > > > > @@ -1182,7 +1192,8 @@ static void handle_rx(struct vhost_net *n=
et)
> > > > > >               headcount =3D get_rx_bufs(nvq, vq->heads + count,
> > > > > >                                       vq->nheads + count,
> > > > > >                                       vhost_len, &in, vq_log, &=
log,
> > > > > > -                                     likely(mergeable) ? UIO_M=
AXIOV : 1);
> > > > > > +                                     likely(mergeable) ? UIO_M=
AXIOV : 1,
> > > > > > +                                     &ndesc);
> > > > > >               /* On error, stop handling until the next kick. *=
/
> > > > > >               if (unlikely(headcount < 0))
> > > > > >                       goto out;
> > > > > > @@ -1228,7 +1239,7 @@ static void handle_rx(struct vhost_net *n=
et)
> > > > > >               if (unlikely(err !=3D sock_len)) {
> > > > > >                       pr_debug("Discarded rx packet: "
> > > > > >                                " len %d, expected %zd\n", err, =
sock_len);
> > > > > > -                     vhost_discard_vq_desc(vq, headcount);
> > > > > > +                     vhost_discard_vq_desc(vq, headcount, ndes=
c);
> > > > > >                       continue;
> > > > > >               }
> > > > > >               /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NE=
T_HDR */
> > > > > > @@ -1252,7 +1263,7 @@ static void handle_rx(struct vhost_net *n=
et)
> > > > > >                   copy_to_iter(&num_buffers, sizeof num_buffers=
,
> > > > > >                                &fixup) !=3D sizeof num_buffers)=
 {
> > > > > >                       vq_err(vq, "Failed num_buffers write");
> > > > > > -                     vhost_discard_vq_desc(vq, headcount);
> > > > > > +                     vhost_discard_vq_desc(vq, headcount, ndes=
c);
> > > > > >                       goto out;
> > > > > >               }
> > > > > >               nvq->done_idx +=3D headcount;
> > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > index 8570fdf2e14a..b56568807588 100644
> > > > > > --- a/drivers/vhost/vhost.c
> > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > @@ -2792,18 +2792,11 @@ static int get_indirect(struct vhost_vi=
rtqueue *vq,
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > -/* This looks in the virtqueue and for the first available buf=
fer, and converts
> > > > > > - * it to an iovec for convenient access.  Since descriptors co=
nsist of some
> > > > > > - * number of output then some number of input descriptors, it'=
s actually two
> > > > > > - * iovecs, but we pack them into one and note how many of each=
 there were.
> > > > > > - *
> > > > > > - * This function returns the descriptor number found, or vq->n=
um (which is
> > > > > > - * never a valid descriptor number) if none was found.  A nega=
tive code is
> > > > > > - * returned on error. */
> > > > >
> > > > > A new module API with no docs at all is not good.
> > > > > Please add documentation to this one. vhost_get_vq_desc
> > > > > is a subset and could refer to it.
> > > >
> > > > Fixed.
> > > >
> > > > >
> > > > > > -int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> > > > > > -                   struct iovec iov[], unsigned int iov_size,
> > > > > > -                   unsigned int *out_num, unsigned int *in_num=
,
> > > > > > -                   struct vhost_log *log, unsigned int *log_nu=
m)
> > > > > > +int vhost_get_vq_desc_n(struct vhost_virtqueue *vq,
> > > > > > +                     struct iovec iov[], unsigned int iov_size=
,
> > > > > > +                     unsigned int *out_num, unsigned int *in_n=
um,
> > > > > > +                     struct vhost_log *log, unsigned int *log_=
num,
> > > > > > +                     unsigned int *ndesc)
> > > > >
> > > > > >  {
> > > > > >       bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER=
);
> > > > > >       struct vring_desc desc;
> > > > > > @@ -2921,16 +2914,40 @@ int vhost_get_vq_desc(struct vhost_virt=
queue *vq,
> > > > > >       vq->last_avail_idx++;
> > > > > >       vq->next_avail_head +=3D c;
> > > > > >
> > > > > > +     if (ndesc)
> > > > > > +             *ndesc =3D c;
> > > > > > +
> > > > > >       /* Assume notifications from guest are disabled at this p=
oint,
> > > > > >        * if they aren't we would need to update avail_event ind=
ex. */
> > > > > >       BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
> > > > > >       return head;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL_GPL(vhost_get_vq_desc_n);
> > > > > > +
> > > > > > +/* This looks in the virtqueue and for the first available buf=
fer, and converts
> > > > > > + * it to an iovec for convenient access.  Since descriptors co=
nsist of some
> > > > > > + * number of output then some number of input descriptors, it'=
s actually two
> > > > > > + * iovecs, but we pack them into one and note how many of each=
 there were.
> > > > > > + *
> > > > > > + * This function returns the descriptor number found, or vq->n=
um (which is
> > > > > > + * never a valid descriptor number) if none was found.  A nega=
tive code is
> > > > > > + * returned on error.
> > > > > > + */
> > > > > > +int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> > > > > > +                   struct iovec iov[], unsigned int iov_size,
> > > > > > +                   unsigned int *out_num, unsigned int *in_num=
,
> > > > > > +                   struct vhost_log *log, unsigned int *log_nu=
m)
> > > > > > +{
> > > > > > +     return vhost_get_vq_desc_n(vq, iov, iov_size, out_num, in=
_num,
> > > > > > +                                log, log_num, NULL);
> > > > > > +}
> > > > > >  EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
> > > > > >
> > > > > >  /* Reverse the effect of vhost_get_vq_desc. Useful for error h=
andling. */
> > > > > > -void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
> > > > > > +void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n,
> > > > > > +                        unsigned int ndesc)
> > > > >
> > > > > ndesc is number of descriptors? And n is what, in that case?
> > > >
> > > > The semantic of n is not changed which is the number of buffers, nd=
esc
> > > > is the number of descriptors.
> > >
> > > History is not that relevant. To make the core readable pls
> > > change the names to readable ones.
> > >
> > > Specifically n is really nbufs, maybe?
> >
> > Right.
> >
> > Thanks
>
> All I am asking for is that in the API the parameter is named in a way
> that makes it clear what it is counting.
>
> vhost_get_vq_desc_n is the function you want to document, making it
> clear what is returned in ndesc and how it's different from the return
> value.

Will do.

Thanks

>
>
>
> --
> MST
>


