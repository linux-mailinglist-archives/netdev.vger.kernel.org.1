Return-Path: <netdev+bounces-75869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8871386B671
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 18:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C8C28B74B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B8B73509;
	Wed, 28 Feb 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cb9fIfTA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715715DBC5
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142711; cv=none; b=J7Do2Ca8giXVTXoaxUfyDBpeHejZVXI3RdmEsC+XpNFRe+VhX6rZwUJnujIXq0ye0p6gijoqoSXyLkaagFLXl9zm1KECcyr1orkclVwBpOj8yS67KzEcxzB85OHmYGxe082q/c4VMJlZl95ZGtf+ec9ou2J6y7iGBXQWP0HKNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142711; c=relaxed/simple;
	bh=yBUOcYQBHwBnUIBsxF2xCzpJI8sN2HkqsN9GU4NqxTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jqe6a/AtG3eCQJYKGrQAY7Rd9x5bTfUS8i2bmyzE3M6uLsZJ1rW6eDJuFbIQje7+FotNPkoN82MZeeHTVpp4+/ypXAkydFCiM4LAPvWMwSpFmrx+XXzK9w66ri/ZKp1nxGHxj0at5zdv2g97HaWCnifCIHr17/wpR0dijmT3HnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cb9fIfTA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709142705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JCwHc0PNiaAHN/EWIMoPFjUe5+j9z9JerCblQ07qOAY=;
	b=cb9fIfTAkw4tz4RXYuv9Aw8GY0/lOtE8Gonu93Z9hKsD0mhT7SXpu8fizlv62XNs5cGjai
	XJ+XBrpPq0eaV+bpJ3Rw+V9BKJ9v5wjXvqP1lYZ6eiSZFz7xLpNnQvyA/0lUyu7zu6mf+l
	L2iF48+I63tzWvC1XfQRl2GZx0suvTA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-IH2wgwqKPfeh1n9JTbOMCQ-1; Wed, 28 Feb 2024 12:51:44 -0500
X-MC-Unique: IH2wgwqKPfeh1n9JTbOMCQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-410adb15560so6805e9.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 09:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142703; x=1709747503;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCwHc0PNiaAHN/EWIMoPFjUe5+j9z9JerCblQ07qOAY=;
        b=GAIkpThECrV/S/evhULUdRpnEpuev4oDjop/WMoTU/qGcuFysci17+DOTQbEUmLzo8
         2dIHhsS4XOPjU/2jX6YhNtXpYC9+4tAeJpRcGzpHMgTLeW1HT+x5Dvo9tVQFK7L6ReYK
         P6tOWRocbQnAA8+/Cvfgv1Tc95prV6S/209lSNRhTVbngoBtaNVunVpbNS3ev+KdmYK3
         ehjM1GVhQsJpFHkwaL0+kS4vLbDIVXhPk+plL85XFf52Hx9PKG0z4+71yJfFCRfkZcZN
         4pA9VzdJUJQIrpvXBXwIhMbN9VuZtPnE1Fg3zrMc2KzlPmwwcKd7m+z0LJonvnBqCpqs
         FRkw==
X-Forwarded-Encrypted: i=1; AJvYcCXBrJclcVEVKh8dJc8Cau042NBVCoCFBu1iOoCq47AwdvIGJax87zC54gi3CC0KRo9b+lINDGRtgNcmd172mQ4OPbWH3yQw
X-Gm-Message-State: AOJu0Yw/R8WdVZAbp9sX/ZpryEtz9IDR4aNcrCQKqXAJBxRk04xO0ken
	QlDqWetYIGuAgyDuIn6N3gwDb0bU1Bjsy6blJzc7fZVL0QWlOnykiR0BltcoNiVnvBMsMWhS0fx
	RZ2DvmhjeZFr8aDC5fFxiiC2aV+PkABxQ7FZAXT1G7yBHqfq+ZHQ+Yw==
X-Received: by 2002:a05:6000:a18:b0:33d:a6f2:86f5 with SMTP id co24-20020a0560000a1800b0033da6f286f5mr9453259wrb.4.1709142703392;
        Wed, 28 Feb 2024 09:51:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOQV/tVBrvoVH1ZkuvA6Ja1R0yqdqv4Os6oSTU3N/SeE+cdq5vndmjyOJheNEKgssuiVZuOw==
X-Received: by 2002:a05:6000:a18:b0:33d:a6f2:86f5 with SMTP id co24-20020a0560000a1800b0033da6f286f5mr9453243wrb.4.1709142702897;
        Wed, 28 Feb 2024 09:51:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-156.dyn.eolo.it. [146.241.246.156])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4523000000b0033cfa00e497sm15143436wra.64.2024.02.28.09.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:51:42 -0800 (PST)
Message-ID: <961535955d1988b7f8ad06f0cb93a200f4b97fb6.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 11/14] af_unix: Assign a unique index to SCC.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kuni1840@gmail.com,  netdev@vger.kernel.org
Date: Wed, 28 Feb 2024 18:51:41 +0100
In-Reply-To: <20240228162539.98084-1-kuniyu@amazon.com>
References: <3adcdaf1bd20b37640a92593d643964bf49297c2.camel@redhat.com>
	 <20240228162539.98084-1-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 08:25 -0800, Kuniyuki Iwashima wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Wed, 28 Feb 2024 08:49:46 +0100
> > On Tue, 2024-02-27 at 19:05 -0800, Kuniyuki Iwashima wrote:
> > > From: Paolo Abeni <pabeni@redhat.com>
> > > Date: Tue, 27 Feb 2024 12:19:40 +0100
> > > > On Fri, 2024-02-23 at 13:40 -0800, Kuniyuki Iwashima wrote:
> > > > > The definition of the lowlink in Tarjan's algorithm is the
> > > > > smallest index of a vertex that is reachable with at most one
> > > > > back-edge in SCC.  This is not useful for a cross-edge.
> > > > >=20
> > > > > If we start traversing from A in the following graph, the final
> > > > > lowlink of D is 3.  The cross-edge here is one between D and C.
> > > > >=20
> > > > >   A -> B -> D   D =3D (4, 3)  (index, lowlink)
> > > > >   ^    |    |   C =3D (3, 1)
> > > > >   |    V    |   B =3D (2, 1)
> > > > >   `--- C <--'   A =3D (1, 1)
> > > > >=20
> > > > > This is because the lowlink of D is updated with the index of C.
> > > > >=20
> > > > > In the following patch, we detect a dead SCC by checking two
> > > > > conditions for each vertex.
> > > > >=20
> > > > >   1) vertex has no edge directed to another SCC (no bridge)
> > > > >   2) vertex's out_degree is the same as the refcount of its file
> > > > >=20
> > > > > If 1) is false, there is a receiver of all fds of the SCC and
> > > > > its ancestor SCC.
> > > > >=20
> > > > > To evaluate 1), we need to assign a unique index to each SCC and
> > > > > assign it to all vertices in the SCC.
> > > > >=20
> > > > > This patch changes the lowlink update logic for cross-edge so
> > > > > that in the example above, the lowlink of D is updated with the
> > > > > lowlink of C.
> > > > >=20
> > > > >   A -> B -> D   D =3D (4, 1)  (index, lowlink)
> > > > >   ^    |    |   C =3D (3, 1)
> > > > >   |    V    |   B =3D (2, 1)
> > > > >   `--- C <--'   A =3D (1, 1)
> > > > >=20
> > > > > Then, all vertices in the same SCC have the same lowlink, and we
> > > > > can quickly find the bridge connecting to different SCC if exists=
.
> > > > >=20
> > > > > However, it is no longer called lowlink, so we rename it to
> > > > > scc_index.  (It's sometimes called lowpoint.)
> > > > >=20
> > > > > Also, we add a global variable to hold the last index used in DFS
> > > > > so that we do not reset the initial index in each DFS.
> > > > >=20
> > > > > This patch can be squashed to the SCC detection patch but is
> > > > > split deliberately for anyone wondering why lowlink is not used
> > > > > as used in the original Tarjan's algorithm and many reference
> > > > > implementations.
> > > > >=20
> > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > > ---
> > > > >  include/net/af_unix.h |  2 +-
> > > > >  net/unix/garbage.c    | 15 ++++++++-------
> > > > >  2 files changed, 9 insertions(+), 8 deletions(-)
> > > > >=20
> > > > > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > > > > index ec040caaa4b5..696d997a5ac9 100644
> > > > > --- a/include/net/af_unix.h
> > > > > +++ b/include/net/af_unix.h
> > > > > @@ -36,7 +36,7 @@ struct unix_vertex {
> > > > >  	struct list_head scc_entry;
> > > > >  	unsigned long out_degree;
> > > > >  	unsigned long index;
> > > > > -	unsigned long lowlink;
> > > > > +	unsigned long scc_index;
> > > > >  };
> > > > > =20
> > > > >  struct unix_edge {
> > > > > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > > > > index 1d9a0498dec5..0eb1610c96d7 100644
> > > > > --- a/net/unix/garbage.c
> > > > > +++ b/net/unix/garbage.c
> > > > > @@ -308,18 +308,18 @@ static bool unix_scc_cyclic(struct list_hea=
d *scc)
> > > > > =20
> > > > >  static LIST_HEAD(unix_visited_vertices);
> > > > >  static unsigned long unix_vertex_grouped_index =3D UNIX_VERTEX_I=
NDEX_MARK2;
> > > > > +static unsigned long unix_vertex_last_index =3D UNIX_VERTEX_INDE=
X_START;
> > > > > =20
> > > > >  static void __unix_walk_scc(struct unix_vertex *vertex)
> > > > >  {
> > > > > -	unsigned long index =3D UNIX_VERTEX_INDEX_START;
> > > > >  	LIST_HEAD(vertex_stack);
> > > > >  	struct unix_edge *edge;
> > > > >  	LIST_HEAD(edge_stack);
> > > > > =20
> > > > >  next_vertex:
> > > > > -	vertex->index =3D index;
> > > > > -	vertex->lowlink =3D index;
> > > > > -	index++;
> > > > > +	vertex->index =3D unix_vertex_last_index;
> > > > > +	vertex->scc_index =3D unix_vertex_last_index;
> > > > > +	unix_vertex_last_index++;
> > > > > =20
> > > > >  	list_add(&vertex->scc_entry, &vertex_stack);
> > > > > =20
> > > > > @@ -342,13 +342,13 @@ static void __unix_walk_scc(struct unix_ver=
tex *vertex)
> > > > > =20
> > > > >  			vertex =3D edge->predecessor->vertex;
> > > > > =20
> > > > > -			vertex->lowlink =3D min(vertex->lowlink, next_vertex->lowlink=
);
> > > > > +			vertex->scc_index =3D min(vertex->scc_index, next_vertex->scc=
_index);
> > > > >  		} else if (next_vertex->index !=3D unix_vertex_grouped_index) =
{
> > > > > -			vertex->lowlink =3D min(vertex->lowlink, next_vertex->index);
> > > > > +			vertex->scc_index =3D min(vertex->scc_index, next_vertex->scc=
_index);
> > > >=20
> > > > I guess the above will break when unix_vertex_last_index wraps arou=
nd,
> > > > or am I low on coffee? (I guess there is not such a thing as enough
> > > > coffee to allow me reviewing this whole series at once ;)
> > > >=20
> > > > Can we expect a wrap around in host with (surprisingly very) long
> > > > uptimes?=20
> > >=20
> > > Then, the number of inflight AF_UNIX sockets is at least 2^64 - 1.
> >=20
> > Isn't "unix_vertex_last_index" value preserved across consecutive cg
> > run? I though we could reach wrap around after a lot of gc runs...
>=20
> It's preserved across consecutive DFS in a single gc run, but
> unix_walk_scc() always reset it.  So, if it's wrapped, there
> would be too many sockets.

Ah, I missed that point. No wrap-around problem then!

> I used unix_vertex_last_index elsewhere in the initial draft,
> but now local variable could be better here.

You could bundle the index, hitlist, etc. in a single struct (gs_state
or whatever) and pass around a single argument, if that helps.

Cheers,

Paolo


