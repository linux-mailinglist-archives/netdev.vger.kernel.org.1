Return-Path: <netdev+bounces-256107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKyYNflqgWmwGAMAu9opvQ
	(envelope-from <netdev+bounces-256107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:26:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC59D41BE
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFA3E3055E65
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 03:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD5313E2C;
	Tue,  3 Feb 2026 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn/nFrDK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsKrYu/Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100A2F1FE4
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770089071; cv=pass; b=shuDyaYvPNtK+/KsOg/g9U7/1Pgd6I5s1m/kLCbJXgkUVx/CZJ8GrJndWtfCIlBbsJESnoPhoeoWvbyW2ZGhiB0q/5jZ19/uydo1dsGR4JtHOF0yv7mddVnqaQtd1ScG/AIUmDn7+8c5ZfEd2XGiqhVXG4dGJLcp+XL6FeeY/wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770089071; c=relaxed/simple;
	bh=nTjC77z6SKIcEhOAzNzeuTxSi1KokoyynKOgNszG5yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDvnO6XSRtczxGrq6AuOZy4mrG611iAJmFMmIgpsPVVMZGdUklXnHHWVdoE7aCZxGoh4+9NRsmlO7NdY6scGOKzTq9aX82qCdxO/1hadvkRT8JDceGpt1ArjNehlX0dvB4IyC4eXRByfM0tSqbmjlyBFv/+2+q+J0IFNa9RTd0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nn/nFrDK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsKrYu/Y; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770089068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJzVEzc6/YoB4RVHbPB+0q1BuvrVMg3+v8T2N9Qqszg=;
	b=Nn/nFrDKfVLCX/fY/KS9JHAR5bPpIaBCN+oReyYhWfbZd1IMRfsRQPPDvOKIeYhXmCX+E1
	jOaCppGYzWNWujPb8C3Bopn+ypnuUpNzyDyRbaC8kyU/QUVbOEK62WvkAnRDA4qRjrvw3+
	3s09+m66IHCyCaT/jAAv+7ZIC1RQbyk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Sq2nP7iPPdCjT-Uc521xxw-1; Mon, 02 Feb 2026 22:24:26 -0500
X-MC-Unique: Sq2nP7iPPdCjT-Uc521xxw-1
X-Mimecast-MFC-AGG-ID: Sq2nP7iPPdCjT-Uc521xxw_1770089065
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354490889b6so6141329a91.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 19:24:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770089065; cv=none;
        d=google.com; s=arc-20240605;
        b=kMvEQOS8g5Mt9yqSpvG2qexhepqnE4rVwcBo7i7tC5x7SVO47FWO+GEgwKe6Blb1Cr
         zv21r4cm06REp8IrmGTprkmlgZRaNw20LiU9tfONPDuzYutKiwYEY2b5Q7zCC9l4kqVK
         IEeGVGM8UxXcd9RakCnnbXycznwP23NoCGAKD+bnqD91MxXrR/0XiIQALhX+xeoQy5fk
         R1I4jIcolgkTX65De9vRqqZkWYwua1x0fYKvWE2p2Hc+cq7jx3jo9QsjLRK0BR8VOFDy
         HJCCLbP4d8xZQBFu+i6mknJkKOx625wb9WGIoeTF6nACNyQzzY+pfbHcRvSofsz/6k3S
         6GLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uJzVEzc6/YoB4RVHbPB+0q1BuvrVMg3+v8T2N9Qqszg=;
        fh=JNqAgJbePyV7QW0fDNK5k+9gB4oil1tprEDVID9bG8Y=;
        b=BbREqyocARzzAeeZ0I2XuvC74hnk0c1SPJY9tv7J1tTZyR/IyT222MaH/U9OIdVp1B
         gs19P6c3Gbprj/MBPxfUoLnvdvI5T/CTI5gd+xVaa+9GaCFlhWhWgwfCRXH6OwEhXlHl
         YkIc6AYnmuPXDVsouBPYF5ihkZvFP3KwaIYBOQKZNAa7y1EFmkzGKeUIRg0YshiGCwu5
         U+kXdpV9an/lTY40JpdbxBXYCiPTtlAyAxTYPCPgGX9OtSStWWB/o4xhXN49iZzvY5O7
         2sVOeNvRbUR2o7g6iF4Zu8SoPRM3wnJ/x3cBGxtg1/T50Rf/78rAFxQThnNwlzLz/6sm
         7VoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770089065; x=1770693865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJzVEzc6/YoB4RVHbPB+0q1BuvrVMg3+v8T2N9Qqszg=;
        b=hsKrYu/YRvKVdwOrYHhoVQyQu+nniKITFE9lGZUaePuuABNt6Fvg9Y+ixj6Q5pHM3H
         XLd37Jjyrqxh9+iuNRft1QyY/xRO3hGNOBRk0sIj63qyAyJ/AANl0AQJj1OQRAMCgAAW
         4YtwX6eyuLSYEgqYc+fp1a5ibWizhZvx5+hZ+oPN1lYieCF65hfDDDAfEFcprIyzYoFQ
         rgaeTgwKF8P+jrx6/d8S5nGpAb87TyF4DyeuBg3EkafdtBivGs1qtqnXHPIxrrvN8DwM
         6mpdJ0GOxNVL0g18Njws3cCq+SRsaTIaLJlpwwGAZUORU5a7K62v886ixygQjYXQwtQT
         2vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770089065; x=1770693865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJzVEzc6/YoB4RVHbPB+0q1BuvrVMg3+v8T2N9Qqszg=;
        b=ZMVXm8ZjE1mW6ySRKPC/VZFAWucWIq3gXIBDi3T5rx0BJe2wUXmhVWwFHDscx1V5oy
         cHH/1Naxly2TeQIcBvZKOIsfpdfAKWDMqY2p+mjr73xviXO89u/vkJM522TN/JdQc1jy
         JqGOdD2jC5DB1kaJHZidF9fG6pvGVT4YUnxGsYYwyQAhf4aDYGq1E44PUNL9ClaSh/++
         yX6u7accDsS/koWmZscEsYdeaPDiuCKQJTOFPMQPHh5Q5pvdpzXDq6YWZeKkv9OafIoh
         hT91peRXHVsYNte0ihhQbfqMCCOIwswqK0Pe+7SdV7rjm8Aie1iPaQ9P5szFNVJohz+K
         4pYg==
X-Forwarded-Encrypted: i=1; AJvYcCXY04ElSrau7lAJGyIeov5qt6uDrGTikrRN0eQhbrDe+ldRey0C3YpjN/4HhEIa2lIAb3tBbOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy2NFcijQTmhLyspz43TRD7tiTaYkSwWod9bZJEpynfiGMT8dM
	+HE6yYmZvWg+Yd2F6+PoylgpwC46AgYIUq0JCdMVNU+B5enS8s1RK+Vj6iMnYgC+w4gUANQvz3B
	j/sIh7zztgjaTObHbccSWgG/5RCDUVX8YRwrjw9ExCv6KN/wOIre8Y65Csljh9GNaS23LYQzwkW
	DoN6fM32WVzA0JRKaYZ/oBB3Lqx1QTCXsc
X-Gm-Gg: AZuq6aL/vcTbC2kaJF9kZI92CJKhyF8MMQ6pjh62vMKfLNWmBGrPSwqn6cC6Kaw2bDj
	+vn7OUUGyHDroNZhfqOwLmKlHrVBN0AWsVDYov8OIqp53CsnXb3Y7ObGtzRE97ZOV52nnVQx+Ec
	hkBdsHYk9xNvtyU+XDZ7+v9TSNcxrAzOkKTSOy0mnd2o3CWyywYMRLaDuvXao2Q3LzyFU=
X-Received: by 2002:a17:90b:1e02:b0:340:ad5e:cb with SMTP id 98e67ed59e1d1-3543b2dc6cbmr11785538a91.8.1770089065407;
        Mon, 02 Feb 2026 19:24:25 -0800 (PST)
X-Received: by 2002:a17:90b:1e02:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-3543b2dc6cbmr11785518a91.8.1770089064982; Mon, 02 Feb 2026
 19:24:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de> <willemdebruijn.kernel.37516e24f10fa@gmail.com>
In-Reply-To: <willemdebruijn.kernel.37516e24f10fa@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Feb 2026 11:24:13 +0800
X-Gm-Features: AZwV_Qi7FlBzxKew1vHDwolkROsAaYvuxcledhe6oJ_RgZX3godh2kx2XLbJePY
Message-ID: <CACGkMEsqobRMhtz3LUuWu3O1njK9jU7oQ65OOyy9vHcZ_QLz4A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256107-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,redhat.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AC59D41BE
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 5:06=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Steffen Trumtrar wrote:
> > Add optional hardware rx timestamp offload for virtio-net.
> >
> > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > virtio-net header is expanded with room for a timestamp.
> >
> > To get and set the hwtstamp the functions ndo_hwtstamp_set/get need
> > to be implemented. This allows filtering the packets and only time stam=
p
> > the packets where the filter matches. This way, the timestamping can
> > be en/disabled at runtime.
> >
> > Tested:
> >   guest: ./timestamping eth0 \
> >           SOF_TIMESTAMPING_RAW_HARDWARE \
> >           SOF_TIMESTAMPING_RX_HARDWARE
> >   host: nc -4 -u 192.168.1.1 319
> >
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >
> > --
> >   Changes to last version:
> >   - rework series to use flow filters
> >   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
> >   - original work done by: Willem de Bruijn <willemb@google.com>
> > ---
> >  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++++++=
++++----
> >  include/uapi/linux/virtio_net.h |   9 +++
> >  2 files changed, 133 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1bb3aeca66c6e..4e8d9b20c1b34 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -429,6 +429,9 @@ struct virtnet_info {
> >       struct virtio_net_rss_config_trailer rss_trailer;
> >       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >
> > +     /* Device passes time stamps from the driver */
> > +     bool has_tstamp;
> > +
> >       /* Has control virtqueue */
> >       bool has_cvq;
> >
> > @@ -475,6 +478,8 @@ struct virtnet_info {
> >
> >       struct control_buf *ctrl;
> >
> > +     struct kernel_hwtstamp_config tstamp_config;
> > +
> >       /* Ethtool settings */
> >       u8 duplex;
> >       u32 speed;
> > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> >               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> >               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> >               struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > +             struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
>
> Jason, Michael: creating a new struct for every field is not very
> elegant. Is it time to find a more forward looking approach to
> expanding with new fields? Like a TLV, or how netlink structs like
> tcp_info are extended with support for legacy users that only use
> a truncated struct?

I fully agree, we need somebody to work on this.

Thanks


