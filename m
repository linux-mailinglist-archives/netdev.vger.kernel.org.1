Return-Path: <netdev+bounces-256794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DcQIZiTg2lrpgMAu9opvQ
	(envelope-from <netdev+bounces-256794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 19:44:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5816EBBD4
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 19:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3AE0300DD5F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 18:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03910427A04;
	Wed,  4 Feb 2026 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlNSe6Ar";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sgobWlQO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4E4279FC
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770230677; cv=none; b=NM1JfdgCzf0A+gZgJMM0shIn3L5VT6EVpj/pAuduzQhr7rNjMvV2fvhMqMaNdE1j1FrwAtG2PnV3b+HSgklOpn7xNNCQhUlV9n9g6irFkhxPFMm6EvHCOfS7JcKQj7OmU+5wLc0ZWMs/iQ+SCF9A9dpGx+xCKwb2USzMvYTQMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770230677; c=relaxed/simple;
	bh=VqLIZNl8jmLGnUXe1BvwJtGoUSDpXd9EP4yjwpGKzII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G03VqndXWymCRWL2HGlHeNkNoSxkHVc+fGKCkPz1+snSii/UZy2OFDrT8qf6YU7cdZ2MrgpLA3E2zsEN8A94e1V0DkfFGRhcvEW+8wCeqa8YkVaAgc4N0m60d0MU4SkBBabvCiu8gCy7RJZo8V8WmbcN6M5VtQY+UnsRcxgk1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlNSe6Ar; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sgobWlQO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770230676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Gcs4Ihi3YzOYzBM/idLTJIxE2q0BSxfyQSiUhfJOsk=;
	b=hlNSe6ArhF3ZosgYlgbBcsmiBieRQkgGJeGCau+uSj6LMNXqP2R2fb7KH8C/q/GvQhs5+4
	n6fHNIeiTdCbWAaArF5/SwmMgtYiZt8ub1Mr/kkUT2q+notCZYH5OJXthM8uKf3wZumqgC
	dITY576w/WyMJwz/GwM7b8qlXZFaQv4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-i7JRORX4Ojau_8xwkwTdPg-1; Wed, 04 Feb 2026 13:44:34 -0500
X-MC-Unique: i7JRORX4Ojau_8xwkwTdPg-1
X-Mimecast-MFC-AGG-ID: i7JRORX4Ojau_8xwkwTdPg_1770230674
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801d21c280so919545e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 10:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770230673; x=1770835473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Gcs4Ihi3YzOYzBM/idLTJIxE2q0BSxfyQSiUhfJOsk=;
        b=sgobWlQOdjtmqY64s2HFuXJzRAzg6KPj2Mcc/51womd1ORFP2xM0PL2MMN8ZiLuXWJ
         y9COmwlstt4Eji0jMTvqb0vNOAnJeScHs7Uek07X3P6oNAfyqhd4I58htypE2UNMoPe8
         aXWS0rbiA1k/o2pvAXeUWigIzj4/vMhJ1aJklIIyd9WweIcc8hIjKPtlcKgT9dQnweFA
         GqwHy17C7zrARDZxDoJ0XHPq+Jt6eO1WdxkV4BdiH2kr5o3n4aEgLKKPUnotil8RDDR3
         5lZdC1gmq4PGZvANJJbJFu8r/fj5ZYz0XHl3yBCZcBTVqZFIgfKfkL3D5WJRkfdC+AJx
         cqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770230673; x=1770835473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gcs4Ihi3YzOYzBM/idLTJIxE2q0BSxfyQSiUhfJOsk=;
        b=o2ENf/v1oLY6hjVAHZ7lv8km+pQ9W6NGfhvXzGu0DTd1nxSuYEUeBjYE26gbvpfSCL
         KGeQHEKffg9WYNIZTGt5uvNVQkHdfy3Ew2jHdD/R42v4pXm06veUdVo+X2FcRaMr1nTh
         q7ZVQDdj+IsKBt0zT5wyiFU2opSPpbHmWSGL17gk6FSyG+26f0IngWgQDqx2ylm1fEIM
         akqYshZAOSrFkYpYudZ/ndgm0RjseF8nY9zBPMu0G0L1kF+iYsuQ3MfNEKDEip5ytOOk
         kFZIJVCGicXBpmc8gOHzEauk+6+Rq81ghnYR3G4yzZKC2PZcWt0tuvsDJYnRFrjoi28w
         GAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX155L21UopHVdBTcTm0LHOskfIr+A6FELmies4iWCvkNyQRk5Ppg/pSLHBJM18PNzBuwahz5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhVR0s1nvLutj7Ao3W/DLk4XVPDrhg1X4YB/7RK0+OU5vyq88s
	vYK9nNLVUbFhv2jDxh5ixIXqkMXWh/2j4F97CxjAoKc5Kpt94b8qXWxeWSGEHlkaKwmv+drQ1Wg
	qD9J/lkeQOofetiuad0DsPD8HQWdQelll3VARXEO9tSimDcfWgFm2RUAtvQ==
X-Gm-Gg: AZuq6aK1lWzwBdG3cMcSUjIdW7/ow19ey91w28UQW3D27eneHfbKpHGTu3X0AQ6hFL2
	j//HHfBcgQmEbkJrJJpJQBYHHqhvP28GvPCSRpmylwwNC7yTmBgYeYhLhnEEwHO1LNIPRLffcCj
	W/W+xcbyhbQ5Tj6oIY+shwTS7S5Btabwi4U7l+X8CVPzY47HIoOIKjRvssDpv/MIzSbYneaHbFZ
	CkNKijvb0hIalri+kwJZHqnmU/R1SKb1Zk8FxbnR2KrI/y0yT5dutJOOrH6tb28a5WE+bsRUukf
	UhCfVGLLfz9tepe3GtmQG5Btlq9sDtUUPp/1TC/k8bvJyaeu0ebAQZ+ykNKNOBTRWqdM3WdxPO/
	FqyXTexuQJHEzcf03MK50SKTtv5awaUf5mw==
X-Received: by 2002:a05:600c:674a:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-4830e986088mr53052235e9.35.1770230673589;
        Wed, 04 Feb 2026 10:44:33 -0800 (PST)
X-Received: by 2002:a05:600c:674a:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-4830e986088mr53051925e9.35.1770230673144;
        Wed, 04 Feb 2026 10:44:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d33eddsm3164835e9.4.2026.02.04.10.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 10:44:32 -0800 (PST)
Date: Wed, 4 Feb 2026 13:44:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Message-ID: <20260204134257-mutt-send-email-mst@kernel.org>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <willemdebruijn.kernel.37516e24f10fa@gmail.com>
 <CACGkMEsqobRMhtz3LUuWu3O1njK9jU7oQ65OOyy9vHcZ_QLz4A@mail.gmail.com>
 <willemdebruijn.kernel.302a7f5489992@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <willemdebruijn.kernel.302a7f5489992@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256794-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,pengutronix.de,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5816EBBD4
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 12:55:59PM -0500, Willem de Bruijn wrote:
> Jason Wang wrote:
> > On Mon, Feb 2, 2026 at 5:06 AM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Steffen Trumtrar wrote:
> > > > Add optional hardware rx timestamp offload for virtio-net.
> > > >
> > > > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > > > virtio-net header is expanded with room for a timestamp.
> > > >
> > > > To get and set the hwtstamp the functions ndo_hwtstamp_set/get need
> > > > to be implemented. This allows filtering the packets and only time stamp
> > > > the packets where the filter matches. This way, the timestamping can
> > > > be en/disabled at runtime.
> > > >
> > > > Tested:
> > > >   guest: ./timestamping eth0 \
> > > >           SOF_TIMESTAMPING_RAW_HARDWARE \
> > > >           SOF_TIMESTAMPING_RX_HARDWARE
> > > >   host: nc -4 -u 192.168.1.1 319
> > > >
> > > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > >
> > > > --
> > > >   Changes to last version:
> > > >   - rework series to use flow filters
> > > >   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
> > > >   - original work done by: Willem de Bruijn <willemb@google.com>
> > > > ---
> > > >  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++++++++++----
> > > >  include/uapi/linux/virtio_net.h |   9 +++
> > > >  2 files changed, 133 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 1bb3aeca66c6e..4e8d9b20c1b34 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -429,6 +429,9 @@ struct virtnet_info {
> > > >       struct virtio_net_rss_config_trailer rss_trailer;
> > > >       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> > > >
> > > > +     /* Device passes time stamps from the driver */
> > > > +     bool has_tstamp;
> > > > +
> > > >       /* Has control virtqueue */
> > > >       bool has_cvq;
> > > >
> > > > @@ -475,6 +478,8 @@ struct virtnet_info {
> > > >
> > > >       struct control_buf *ctrl;
> > > >
> > > > +     struct kernel_hwtstamp_config tstamp_config;
> > > > +
> > > >       /* Ethtool settings */
> > > >       u8 duplex;
> > > >       u32 speed;
> > > > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> > > >               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> > > >               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> > > >               struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > > > +             struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
> > >
> > > Jason, Michael: creating a new struct for every field is not very
> > > elegant. Is it time to find a more forward looking approach to
> > > expanding with new fields? Like a TLV, or how netlink structs like
> > > tcp_info are extended with support for legacy users that only use
> > > a truncated struct?
> > 
> > I fully agree, we need somebody to work on this.
> 
> Great. I'll take a look when I have some time.
> 
> The current approach infers struct virtio_net_hdr_$VARIANT size from
> negotiated features:
> 
> - virtio_net: virtio_has_feature
> - vhost_net: virtio_features_test_bit
> - tun: tun_vnet_parse_size
> 
> Tuntap however also explicitly negotiates length with TUNSETVNETHDRSZ.
> 
> If we create a struct virtio_net_hdr_ext that can be continuously
> extended going forward, the host and guest will have to negotiate the
> length they both understand, and agree to the min of the two.
> 
> We could use that to implicitly negotiate supported features. E.g.,
> if len is sizeof(virtio_net_hdr_v1_hash_tunnel) then these features
> are supported:
> 
> VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
> VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
> VIRTIO_NET_F_HASH_REPORT
> etc.
> 
> But that would mean that all features up to the length have to be
> supported, no gaps. I think that is probably not preferable? So then
> they still need to negotiate features, as well as length. Does virtio
> have a mechanism to negotiate not boolean feature enable/disable but
> integers such as struct length?
> 
> Else the change will probably be simpler: keep existing negotiation,
> only change the code to once define a struct and keep adding fields.
> Rather than defining new structs with each feature and updating many
> function arguments and variables to switch to the new struct type.

Right I am not sure why we keep doing this. Let's add a VLA at
the end of the struct and declare fields can be added at will.


> Again, for that see as example struct tcp_info, which is UAPI, but has
> been extended many times.


-- 
MST


