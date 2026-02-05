Return-Path: <netdev+bounces-256939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD6PAhMGhGn+wwMAu9opvQ
	(envelope-from <netdev+bounces-256939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:53:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECA6EE262
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45EE2301ABB7
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F55F2D5C76;
	Thu,  5 Feb 2026 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee49XqDD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wqwjlvc9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480F292B44
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259961; cv=pass; b=BBnzqXLQBz6om6vA4agLO1vU6JouhakcynQIxgfA+8EjJZKFxF58emo7H2Zq60IKGvCTZqFYOpYLs2QAtRbX0nUkgvLXQzTMUBVgfLy7Lt1buoxc+GTmAXSqFL45mfMZzok5Dnn/pqHU0pmhyScP/ZeWHwBQ7fDMNKxS9GpLj2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259961; c=relaxed/simple;
	bh=SFxsix8N3tZ9wZkZUiCVZ5WxVG4k+p3CMehdG3exSl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfVrZ9xFj7Whn1jxgb5EM23qWnR2h/N9DmLueMF+53ky0aduGqP7bxew/WZyYMUy6xq+zSHXLxSjFWmPZl6cPe58ZXIK9jqPyyIFzKhU1UpjskCcqfmiTX4aMaaqfO4hrNzP2OYAukt6vsvu+qOT3wPqdGNuFK9+KMi/DonpDk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ee49XqDD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wqwjlvc9; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770259960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpIKSJSO3ObJk6nWSzgXQPDBc3nfYRy7QFNzxUTyPWk=;
	b=ee49XqDDh3ypgKF365sshzhzQy2SfpVbhWJljKtieyTSsI6fhXVYtSF/4nZXmVl3luipz1
	BrdtNGg+DwSAGBNBLxikwuJ/MUa5vjVJOW0F48e5NFHkVIbaAlrUdiY2ctrfzf3EiyN80c
	6JZm1RlKciU455oApAXRpNuKKoQxB0w=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-Kqk9p74pNEi9HlRRq9nJtQ-1; Wed, 04 Feb 2026 21:52:38 -0500
X-MC-Unique: Kqk9p74pNEi9HlRRq9nJtQ-1
X-Mimecast-MFC-AGG-ID: Kqk9p74pNEi9HlRRq9nJtQ_1770259958
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso1150043a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 18:52:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770259957; cv=none;
        d=google.com; s=arc-20240605;
        b=TnJ0gZc+Df3G3fr8cRwgxZDsDDp/iNhDpjWr5nJYDuIjrmhOBbSXNSsrv8fDmYG+7f
         dF+xVLDcfcH35cR4sGaGal4jge07VVjWmCnRutn3Dwzgklm2DelWISM+L2cq2JjLsL3Q
         zXc1s/nz/AXK67KfE2K27LIHimUM1BQDJHnDePeqtM5VhcO20+D3s/lROCy4OlQcE367
         ffiDyCFSbcmKy3ipPo2T7S3gT1DrTwKT5QrsGaTGKX9r4ypWHWLfnODGzfI6Iuuh/qaC
         JgFDJTqpSQzy9AwA8RdgAbk7065e6qjCPO44YB306+OeHRWDZ0cM4C8IDZ99UZwM5RQJ
         IlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QpIKSJSO3ObJk6nWSzgXQPDBc3nfYRy7QFNzxUTyPWk=;
        fh=tKF2Vy6BOzn7t3hS8cSUMv+Au9VqaHNrQFXk1x2PUbA=;
        b=IXVHRglUgZYl60MSLch4SXOXGn0u3HsUxyNcgloQ+vbcHfSMcaalFC68yvt0FEfaIa
         wn/z9qRjC/bIaE3zi2+JHzmqGN615hwCZ4JN01sFOvExgh7Apk7sxVH/rN0JLSSZZoNn
         tovy3y3pHbKsRe6DmY2giAid3qUcfehf7QsCUnZlWucZqrwwsnv9YWy9DN6pasYTxO8e
         W99e0e6Xb3JlOURMi5STZ7uBsPeIWYRs+GTUtbNFc7/PxnzcsBVwXzsHihSyuyxeeXtN
         hT4+ja46al49zeoGq3GF6I9EIFUXgu6sJWLVu8U+8FhE+JL0C51PM2Ifqkdgd0LkUko8
         u3WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770259957; x=1770864757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpIKSJSO3ObJk6nWSzgXQPDBc3nfYRy7QFNzxUTyPWk=;
        b=Wqwjlvc9RRHfEUP7CD6ho/En3YszB7AhsXue8noaYIRGdH38DI5MvSM4Y+iBJ8eBPp
         eC4Y+1F4ALOUdBDXhDCpZBzmatUhTHqLfexkWYjZ2Gh1D3JAPLkqgZcmFmY2fBYi80Bh
         6oTpLJ9BhsHA2lGupWuR0XAEUnoVoYe3P3rCLi5bttP581QZwK/Tvpu1aRDP2U0HlV2s
         th4Cmq2M6LB5aeNcbM82A3TcOeGrblXs9ECv8OTW9jH6DGSU8DQPK+J6j1TWSFwIAzfC
         E1p4+97RBEkoZm3ia8tH1qJ8NJPy88UIurzWUfLgnpwkiyKWphrV/z3aneTGCprHvfLu
         LQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259957; x=1770864757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QpIKSJSO3ObJk6nWSzgXQPDBc3nfYRy7QFNzxUTyPWk=;
        b=xRpCqPL/e3QU1ew5INiLr/ZRTpqmTrvEss8wBNQ4crkrPNHf9M04xackmRjqSqs/EK
         2cKP5MTTbt+te4BaCe5nlQKni/yfbr6E+HG3pT3Ig+EzOyKZymZGJTeOYUWN2sQ3DXKc
         xLFEwDViX+bn2kuc9IDyepLiCH2w2om9chRcjWppVjWMKU5pY+abxWsPrWfUiBGHZT7q
         MiLG21OWIrCPwvc/t5SptaIOcjVYv/uf5CQgRsLr8Zknm0eH9mLVEVjIwlwzspihVDVt
         NqqQtJNvQKeQ6dIJVepxY9RjWiyf1FgmSxdfrTgAR5B0YV9aXfCA9sp9w32LcN1ieNLO
         0Owg==
X-Forwarded-Encrypted: i=1; AJvYcCWUazuQ8k2ZeR6lJWdW4BNTXRzBDKVbBn77GCl24Wh7XEOtNoQ1TkXU5C/mq8OcPjrBj7BzXZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGjDDrjkA8CbuMRbHVEh1bpKDT0tPtUP5HUeEcUaKeP0nTC2M
	Ft39ZMmGtsxGC4Z2SlZ5H4byzaQapP3dcQvHVvV+ihLGll1SOnZzxNU6XjyycWXgymyBLKCl89M
	Zc0Msf/4DWaeDSuIT95eO9mar96rCQ/y5bwkMb5k7ixLutgccFTqlRzmQ8ybgx2/ptHPsE7J3lI
	XgqEjHqTP/mdJH0bikhQAKB4qJ2y3m/Yyu
X-Gm-Gg: AZuq6aJyj+6F3ZbD/UvCuVsHqfiE8QEq/DxO0NhKvAIZ5gVTRq11vDtc8sYiK5bWCWV
	2mQdJRc/WHr7Gf4z7stXy+bkZXk3KIFXCg9pavtam56ttiUFQUnKPidNQHnxRpBat6QqSnAo4ZV
	9Mpk5p+zIwv3t1q+aRGhOoeJS9PY/10HGgrPmP4WmyEQiJDlj+06vFZE/WrmlIcGt1MQ==
X-Received: by 2002:a05:6a21:6490:b0:38d:f226:49d2 with SMTP id adf61e73a8af0-39372119dc9mr5264232637.35.1770259957578;
        Wed, 04 Feb 2026 18:52:37 -0800 (PST)
X-Received: by 2002:a05:6a21:6490:b0:38d:f226:49d2 with SMTP id
 adf61e73a8af0-39372119dc9mr5264210637.35.1770259957165; Wed, 04 Feb 2026
 18:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <willemdebruijn.kernel.37516e24f10fa@gmail.com> <CACGkMEsqobRMhtz3LUuWu3O1njK9jU7oQ65OOyy9vHcZ_QLz4A@mail.gmail.com>
 <willemdebruijn.kernel.302a7f5489992@gmail.com> <20260204134257-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260204134257-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Feb 2026 10:52:22 +0800
X-Gm-Features: AZwV_QheVEsP5Y4RAFgv_O1W-jMjSmC4wlbqTv1DMlT9lfcD-74-qPxxWpVnIe0
Message-ID: <CACGkMEsP5bv2j5Fx7f3jL=F8oyzA2h_BQZyBZyhwy7DzQzB-SA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Steffen Trumtrar <s.trumtrar@pengutronix.de>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256939-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,linux.alibaba.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: 8ECA6EE262
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 2:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Feb 04, 2026 at 12:55:59PM -0500, Willem de Bruijn wrote:
> > Jason Wang wrote:
> > > On Mon, Feb 2, 2026 at 5:06=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Steffen Trumtrar wrote:
> > > > > Add optional hardware rx timestamp offload for virtio-net.
> > > > >
> > > > > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > > > > virtio-net header is expanded with room for a timestamp.
> > > > >
> > > > > To get and set the hwtstamp the functions ndo_hwtstamp_set/get ne=
ed
> > > > > to be implemented. This allows filtering the packets and only tim=
e stamp
> > > > > the packets where the filter matches. This way, the timestamping =
can
> > > > > be en/disabled at runtime.
> > > > >
> > > > > Tested:
> > > > >   guest: ./timestamping eth0 \
> > > > >           SOF_TIMESTAMPING_RAW_HARDWARE \
> > > > >           SOF_TIMESTAMPING_RX_HARDWARE
> > > > >   host: nc -4 -u 192.168.1.1 319
> > > > >
> > > > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > > >
> > > > > --
> > > > >   Changes to last version:
> > > > >   - rework series to use flow filters
> > > > >   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
> > > > >   - original work done by: Willem de Bruijn <willemb@google.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++=
++++++++++----
> > > > >  include/uapi/linux/virtio_net.h |   9 +++
> > > > >  2 files changed, 133 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 1bb3aeca66c6e..4e8d9b20c1b34 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -429,6 +429,9 @@ struct virtnet_info {
> > > > >       struct virtio_net_rss_config_trailer rss_trailer;
> > > > >       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> > > > >
> > > > > +     /* Device passes time stamps from the driver */
> > > > > +     bool has_tstamp;
> > > > > +
> > > > >       /* Has control virtqueue */
> > > > >       bool has_cvq;
> > > > >
> > > > > @@ -475,6 +478,8 @@ struct virtnet_info {
> > > > >
> > > > >       struct control_buf *ctrl;
> > > > >
> > > > > +     struct kernel_hwtstamp_config tstamp_config;
> > > > > +
> > > > >       /* Ethtool settings */
> > > > >       u8 duplex;
> > > > >       u32 speed;
> > > > > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> > > > >               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> > > > >               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> > > > >               struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > > > > +             struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
> > > >
> > > > Jason, Michael: creating a new struct for every field is not very
> > > > elegant. Is it time to find a more forward looking approach to
> > > > expanding with new fields? Like a TLV, or how netlink structs like
> > > > tcp_info are extended with support for legacy users that only use
> > > > a truncated struct?
> > >
> > > I fully agree, we need somebody to work on this.
> >
> > Great. I'll take a look when I have some time.
> >
> > The current approach infers struct virtio_net_hdr_$VARIANT size from
> > negotiated features:
> >
> > - virtio_net: virtio_has_feature
> > - vhost_net: virtio_features_test_bit
> > - tun: tun_vnet_parse_size
> >
> > Tuntap however also explicitly negotiates length with TUNSETVNETHDRSZ.
> >
> > If we create a struct virtio_net_hdr_ext that can be continuously
> > extended going forward, the host and guest will have to negotiate the
> > length they both understand, and agree to the min of the two.
> >
> > We could use that to implicitly negotiate supported features. E.g.,
> > if len is sizeof(virtio_net_hdr_v1_hash_tunnel) then these features
> > are supported:
> >
> > VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
> > VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
> > VIRTIO_NET_F_HASH_REPORT
> > etc.
> >
> > But that would mean that all features up to the length have to be
> > supported, no gaps. I think that is probably not preferable? So then
> > they still need to negotiate features, as well as length. Does virtio
> > have a mechanism to negotiate not boolean feature enable/disable but
> > integers such as struct length?

I think not.

> >
> > Else the change will probably be simpler: keep existing negotiation,
> > only change the code to once define a struct and keep adding fields.
> > Rather than defining new structs with each feature and updating many
> > function arguments and variables to switch to the new struct type.
>
> Right I am not sure why we keep doing this. Let's add a VLA at
> the end of the struct and declare fields can be added at will.
>
>
> > Again, for that see as example struct tcp_info, which is UAPI, but has
> > been extended many times.
>
>

Yes.

Thanks

> --
> MST
>


