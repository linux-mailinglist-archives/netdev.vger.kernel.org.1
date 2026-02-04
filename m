Return-Path: <netdev+bounces-256788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BwuLjOJg2niowMAu9opvQ
	(envelope-from <netdev+bounces-256788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 19:00:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38618EB4C8
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 19:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEA62303C028
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0903B52E4;
	Wed,  4 Feb 2026 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es+cpqdy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C613A7F66
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227762; cv=none; b=ZicZdubmCKzAgRY+9zxjPX+Nd1lcc5CqK2RfypwFHdzAZmX8ppqHqNsXzz3z9ZrvUtMBHX325zGF1dKirfbg9ZdRBnr+9FiA8b04chNIGbgmKwhRNlZTZiGKNQLn/dPI6sQHjKaVFSVOH+1un8OU51ohTEN+7OAKWIcYks/mVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227762; c=relaxed/simple;
	bh=Wrs8v3Ibl/2UVhDWKQ0wbPiQLOnTpSRd8XznyUqhHLY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JVU1v5vvK+5rg83wV3rwM152arRbY5tquXhCv2dYXKY5wd4J/xfSkKMEU8ULqSZWhqpeAnOgjhLTUs9E1HSCb2FGhP83810EtRehK43xVHStWkyh3vyDa86TNTlbNdhS29njb0G/Lgrop0NkQ+rFJHsa1hazMdfgYgLwQQ/ey1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es+cpqdy; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79427f739b0so113287b3.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 09:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770227761; x=1770832561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/QoYdN54LYW2mp+h4jl0HE9exyW7dgtn+9C6PPxWXs=;
        b=es+cpqdysktzkrSnDADytBGI+3+ARnOsRWbhVqjOlWjJ/2+wRpIeoqSB/S8BJ7r3OA
         l+kDi3/aDefEg/2/Fw87jy7h5zneiGHf9islFP3+z0aA19445D0YIVFH5iF1mVkCnXvN
         X9aimvT7Bc7S6QrXaE99RuKeVjnf/wKBdMmwVy4gIHUzWlGnemPn6TwjgpuUh5wMKt1r
         aAi54lrFQfSI3ojqdG5P8nls2doLU+d0AEK+Nev+31VSM3tcGJm6dh+MoZiGxER18npL
         rqihDWuuHKt14/H5Ql7PDn7/8oNxNwe6CfaGNsgeQ4W88o/MFFszeoEejsCEBRryOt0J
         4Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227761; x=1770832561;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/QoYdN54LYW2mp+h4jl0HE9exyW7dgtn+9C6PPxWXs=;
        b=vI7vNvtCSZtZAmu+pL3GToiQ5YhIMLgmR/M92X9+PmoVf8pFjIk9WStRT/m7R38HIM
         rjDfgZxc4X2+nUocWHip5ey4j0hSd+BcUjqODeSdeaum47sGKEj0yTN/h65dKPfuwM6D
         dolNKrKWXbLWC53dJDnZEU+Re3Kz0/drPS4hhGZHCNwCja/dzUHLgxwylJSzr1ERovQ1
         1TzCiZd2ewVhtjRHyPYmsmFNcbj9sZtffFp3fjplP3XH1swScYoj0oGe9l0MtbzTNjsb
         zP/4TEGSTQMM919fHfbuNAdvkvjqSLYHKDG1411Zd//QnQypCppdGNHGI9cL2IRfpbfx
         29fA==
X-Forwarded-Encrypted: i=1; AJvYcCWdKrP9CmZF3zn60x5BnIZYqmrv+kODhlwwlbb+OoMmStiY+riJEO0GbXqIsglTd9uDg01P1jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSONfoetYBrsxdcfCvn/dRd1vH1iYMihDxYOfNe1O9fU0lK8JY
	BauIgOfRpTTngI4loKGOgqDfs5wCwmrVAeRJbRqIdY+xYYSSqycHMr3g
X-Gm-Gg: AZuq6aIb1b2GCOcCJ2YC4kKYqgseCcePHdugH2tR+y1BtvUgh6k7dMYXdg77VfqYSY8
	6b1WTmac2a9Zk3326pen6kGY1mjgu0EBYOy1xYn/upuftbKwySzlk+II5w+esWXmwP8nmigRUZ8
	9utwIxqsWDLcXQ0C0UmU7TBkmAadQwt16hFHpr/SRr/OzWao52rHNdNTNd76JqutMngrxEOBnbk
	FID+AiiUtvfi82BvvDiRKk/b+aJI0c02ahaEAOe4/knwLQwQMd1njEKFDf6Am7uKzNWAFUiH8Nw
	UH7j7TvPeBL776t8dMfxlSnu6doYqISuJPITEk5dg+XTtqBgyW3Oq4ZCIxBriejvwg7ib/FvQnZ
	mX+rX1FeiPLVSYsyxFvN1Y35c4rF0pI+br86vO1gVtzj7PBm00Gw68UTD4cF2aQGE8XS+i71EsW
	ySg04x7qITdxj8WXMZLyD8RCP4dlQQJgMYmT4XyZrxtwxgGYlF0UAkaWikkxE=
X-Received: by 2002:a05:690c:e3cb:b0:794:fb91:9221 with SMTP id 00721157ae682-794fe7d208cmr36871737b3.56.1770227761009;
        Wed, 04 Feb 2026 09:56:01 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794feeaefaesm26690287b3.20.2026.02.04.09.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:56:00 -0800 (PST)
Date: Wed, 04 Feb 2026 12:55:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.302a7f5489992@gmail.com>
In-Reply-To: <CACGkMEsqobRMhtz3LUuWu3O1njK9jU7oQ65OOyy9vHcZ_QLz4A@mail.gmail.com>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <willemdebruijn.kernel.37516e24f10fa@gmail.com>
 <CACGkMEsqobRMhtz3LUuWu3O1njK9jU7oQ65OOyy9vHcZ_QLz4A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256788-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,redhat.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,lists.linux.dev,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38618EB4C8
X-Rspamd-Action: no action

Jason Wang wrote:
> On Mon, Feb 2, 2026 at 5:06=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Steffen Trumtrar wrote:
> > > Add optional hardware rx timestamp offload for virtio-net.
> > >
> > > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > > virtio-net header is expanded with room for a timestamp.
> > >
> > > To get and set the hwtstamp the functions ndo_hwtstamp_set/get need=

> > > to be implemented. This allows filtering the packets and only time =
stamp
> > > the packets where the filter matches. This way, the timestamping ca=
n
> > > be en/disabled at runtime.
> > >
> > > Tested:
> > >   guest: ./timestamping eth0 \
> > >           SOF_TIMESTAMPING_RAW_HARDWARE \
> > >           SOF_TIMESTAMPING_RX_HARDWARE
> > >   host: nc -4 -u 192.168.1.1 319
> > >
> > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > >
> > > --
> > >   Changes to last version:
> > >   - rework series to use flow filters
> > >   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
> > >   - original work done by: Willem de Bruijn <willemb@google.com>
> > > ---
> > >  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++=
++++++++----
> > >  include/uapi/linux/virtio_net.h |   9 +++
> > >  2 files changed, 133 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 1bb3aeca66c6e..4e8d9b20c1b34 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -429,6 +429,9 @@ struct virtnet_info {
> > >       struct virtio_net_rss_config_trailer rss_trailer;
> > >       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> > >
> > > +     /* Device passes time stamps from the driver */
> > > +     bool has_tstamp;
> > > +
> > >       /* Has control virtqueue */
> > >       bool has_cvq;
> > >
> > > @@ -475,6 +478,8 @@ struct virtnet_info {
> > >
> > >       struct control_buf *ctrl;
> > >
> > > +     struct kernel_hwtstamp_config tstamp_config;
> > > +
> > >       /* Ethtool settings */
> > >       u8 duplex;
> > >       u32 speed;
> > > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> > >               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> > >               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> > >               struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > > +             struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
> >
> > Jason, Michael: creating a new struct for every field is not very
> > elegant. Is it time to find a more forward looking approach to
> > expanding with new fields? Like a TLV, or how netlink structs like
> > tcp_info are extended with support for legacy users that only use
> > a truncated struct?
> =

> I fully agree, we need somebody to work on this.

Great. I'll take a look when I have some time.

The current approach infers struct virtio_net_hdr_$VARIANT size from
negotiated features:

- virtio_net: virtio_has_feature
- vhost_net: virtio_features_test_bit
- tun: tun_vnet_parse_size

Tuntap however also explicitly negotiates length with TUNSETVNETHDRSZ.

If we create a struct virtio_net_hdr_ext that can be continuously
extended going forward, the host and guest will have to negotiate the
length they both understand, and agree to the min of the two.

We could use that to implicitly negotiate supported features. E.g.,
if len is sizeof(virtio_net_hdr_v1_hash_tunnel) then these features
are supported:

VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
VIRTIO_NET_F_HASH_REPORT
etc.

But that would mean that all features up to the length have to be
supported, no gaps. I think that is probably not preferable? So then
they still need to negotiate features, as well as length. Does virtio
have a mechanism to negotiate not boolean feature enable/disable but
integers such as struct length?

Else the change will probably be simpler: keep existing negotiation,
only change the code to once define a struct and keep adding fields.
Rather than defining new structs with each feature and updating many
function arguments and variables to switch to the new struct type.

Again, for that see as example struct tcp_info, which is UAPI, but has
been extended many times.=

