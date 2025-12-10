Return-Path: <netdev+bounces-244190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD46CB201D
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 06:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF29230180AD
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15177311967;
	Wed, 10 Dec 2025 05:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBTCHYzF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rTzpxKBA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B357301012
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 05:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345539; cv=none; b=HBYRRKTybmKP/RKma/d69Nq08ymv8NBp42DzM+jVxuIn1lMIOHJoLZkN+tDKPpxD4Wz+1AfAZKmiOMKrenRjYRPppu+uQ2hzo2iqkicw4we2LOG0x9p1RJJpXfW/nBoI1mSk+hiek25YsIU5Jcj63Ffmj25BTj+9l6NJIthcf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345539; c=relaxed/simple;
	bh=w6iiCVQLpFikPUe4uciKj0mkXr2KE4ORLhI9r5rmOzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eG9lye0dh1jDN1KhcUbEQtVwtEgalgJKtBHFz87Rew2LX+5iT+qNvQF9GAKzDUuHM5XbX7em7c7vbPNWNBxUtdw5vY4KVmSHYpjbudmnZxQ4sKGff6F6yW2jGsLDN8V+92co0fe0HWkwsl24ieAw1WEq8zOM6wCrzzFvQcQBf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBTCHYzF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rTzpxKBA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765345536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5u9zjHxp5nOkcmQAgH5/2pjjFKz+7xciix+1rrgeQw=;
	b=VBTCHYzFnM2yUzbTSBrQ7ZqLsiUvq4qpBkQv/0/JkTbnrUAYUee4MHlfrbm9NG0T26jzDR
	g0NbwwLIGayfHuwLf3JB9KX8SusCqbPmLHNZ0LfMpIPN2QyAdRMOCRA5zzwyzJXhIRykz4
	8sbp+LRY5Tiu2c//DhSHCpUP8a0eO6U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-P-R3NwlAMg6L2jNs-BfbQA-1; Wed, 10 Dec 2025 00:45:33 -0500
X-MC-Unique: P-R3NwlAMg6L2jNs-BfbQA-1
X-Mimecast-MFC-AGG-ID: P-R3NwlAMg6L2jNs-BfbQA_1765345533
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-342701608e2so7348247a91.1
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 21:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765345532; x=1765950332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5u9zjHxp5nOkcmQAgH5/2pjjFKz+7xciix+1rrgeQw=;
        b=rTzpxKBAniyLXsosgIop7oewH4TA9w5+T0RyAfr61LR0qR+RPzKQ8JxYb7HcUKf1IJ
         9N+RGQWD8BXTJ4Z2vrZ/Eu29BBy2BrkzGPUyEVmuTAGzKWo2ZfKWqM4kT/VMrRbMSQ2B
         rFkHJqXqSmNQj3M2pj8Y1La+0Uw2eUtNUXsdqvhMVx+SLjsP+/sUAO0mMmJDea3DVDIq
         LWPQQM63rhZlB6mrFSO/gmj0rwE+USDfU2qHZHI/62vKGFX4/qvSzDpvByKx3LPOIlMB
         NpE+NWV7U/U6Bbsi0MW+rBEe+Szk9XQ5QAHcnCND6JzWiW+UP/phQsAHQKqwdt7IwFk2
         9lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765345532; x=1765950332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5u9zjHxp5nOkcmQAgH5/2pjjFKz+7xciix+1rrgeQw=;
        b=lKIKYjEq6foMx56DyBZDL7s4QbzJA1MbJeft+/yE260aj03jGcryH1XjLNQkguZaeP
         UfxcsJkq1NxBshsz1iULvjBnZZt4xGxez6Ek6KvJWHZTY4VxDsd0RikDJAZ8QfoC00zw
         aEdglGI75in9EeNGb1Yg3lSVxo/SDpfHnqqj4Y4xVXlyVsOQ4KQW768G/a5/wZcos75G
         npL3MwPlSyaYQoACNaSpu2vIMCqb2FLrLlIzv4Wr83e/o4slBC+kVii/6thQDu8zqz5g
         vqJ3nd6B6KN6ijmvKTqrTqWd6vwk2ehPwupiQVceQ1VCYCAD6guLUC8t5OP6b2BDXjrv
         2rcA==
X-Gm-Message-State: AOJu0YyTFlAnoJ3apdPkuonAYNXquS27z9TFu/G2Hcsj720eGxjoz2ZQ
	cU5vT/QSr2aoMmCjoplB90hZYwfETa2V1607hLqCFJdTHv80nyDDM5yfK3YaCI+wRUrJgUs9HA1
	0Oc90V9OWsUU6ILXeaHofgPIzTa4nZgzfTXBdLreMQJuzxXzBCS6JeYlpwrxpwxhTuWJEeX+AsF
	duuyVDdhAirVJW9iDNYFBcUuXe5WV3B80u
X-Gm-Gg: AY/fxX5Wrk5Nxd2fWo8K56ZpILBHL2g4ZHJfGclZ6toNqPogpcgxEyZkOd+izATjqPX
	iOMPNNFmxsMQqw7DvZBeYk7+XMx0//RVGVuVt5cQDHo8JY1/rpiVnWN0fi8zCbGAO3un8JkVcjY
	cvWdP6ttDOPb4tAfhfzQa5HFYIXyjFzO0DgW0+f2xnNzPHkXrvMH/P1R+odWTXEP8yguo=
X-Received: by 2002:a17:90b:3847:b0:340:a5b2:c305 with SMTP id 98e67ed59e1d1-34a72808f67mr1088294a91.2.1765345532542;
        Tue, 09 Dec 2025 21:45:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh6+dEVRAMV2C5vYHDGZU4Qf85RNHec+uPwoESl74tc15tqIpJSGl+Ri/dVxp9XR0wrBpc75hUH8L0OPBAOfQ=
X-Received: by 2002:a17:90b:3847:b0:340:a5b2:c305 with SMTP id
 98e67ed59e1d1-34a72808f67mr1088273a91.2.1765345532051; Tue, 09 Dec 2025
 21:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
 <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com> <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com>
In-Reply-To: <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Dec 2025 13:45:19 +0800
X-Gm-Features: AQt7F2rVVyUHdSbcdKdzi21zc9e3z98C7ZeLVe5qQ4lJ-Awfq6TRhCbVeKZ8w04
Message-ID: <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 11:23=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 12/9/25 11:30, Jason Wang wrote:
> > On Mon, Dec 8, 2025 at 11:35=E2=80=AFPM Bui Quang Minh <minhquangbui99@=
gmail.com> wrote:
> >> Calling napi_disable() on an already disabled napi can cause the
> >> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> >> when pausing rx"), to avoid the deadlock, when pausing the RX in
> >> virtnet_rx_pause[_all](), we disable and cancel the delayed refill wor=
k.
> >> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> >> work too early before enabling all the receive queue napis.
> >>
> >> The deadlock can be reproduced by running
> >> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> >> device and inserting a cond_resched() inside the for loop in
> >> virtnet_rx_resume_all() to increase the success rate. Because the work=
er
> >> processing the delayed refilled work runs on the same CPU as
> >> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> >> In real scenario, the contention on netdev_lock can cause the
> >> reschedule.
> >>
> >> This fixes the deadlock by ensuring all receive queue's napis are
> >> enabled before we enable the delayed refill work in
> >> virtnet_rx_resume_all() and virtnet_open().
> >>
> >> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing =
rx")
> >> Reported-by: Paolo Abeni <pabeni@redhat.com>
> >> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/resu=
lts/400961/3-xdp-py/stderr
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >> ---
> >>   drivers/net/virtio_net.c | 59 +++++++++++++++++++-------------------=
--
> >>   1 file changed, 28 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 8e04adb57f52..f2b1ea65767d 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *=
vi, struct receive_queue *rq,
> >>          return err !=3D -ENOMEM;
> >>   }
> >>
> >> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> >> +{
> >> +       bool schedule_refill =3D false;
> >> +       int i;
> >> +
> >> +       enable_delayed_refill(vi);
> > This seems to be still racy?
> >
> > For example, in virtnet_open() we had:
> >
> > static int virtnet_open(struct net_device *dev)
> > {
> >          struct virtnet_info *vi =3D netdev_priv(dev);
> >          int i, err;
> >
> >          for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >                  err =3D virtnet_enable_queue_pair(vi, i);
> >                  if (err < 0)
> >                          goto err_enable_qp;
> >          }
> >
> >          virtnet_rx_refill_all(vi);
> >
> > So NAPI and refill work is enabled in this case, so the refill work
> > could be scheduled and run at the same time?
>
> Yes, that's what we expect. We must ensure that refill work is scheduled
> only when all NAPIs are enabled. The deadlock happens when refill work
> is scheduled but there are still disabled RX NAPIs.

Just to make sure we are on the same page, I meant, after refill work
is enabled, rq0 is NAPI is enabled, in this case the refill work could
be triggered by the rq0's NAPI so we may end up in the refill work
that it tries to disable rq1's NAPI while holding the netdev lock.

Thanks

>
> Thanks,
> Quang Minh.
>


