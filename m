Return-Path: <netdev+bounces-78300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F08874A5F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FB41C208A1
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659AF82D7E;
	Thu,  7 Mar 2024 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIC74F3O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284E823BF
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802507; cv=none; b=EA7wfDPQ1M6/3g1IbuJac0ZrO3GgJehdKdhATGL81s8zDMCwzM/npWnn/qcto74ndDOuMCDCSvkhbW4TDiCFJOELpP2giaGoH0cqA+smAQ+9AEC0J3xoA17ZrGnREzYqSREpI5ldoFZnv/yxlojQ6LQlGMYHaEvUU1q/rlLXd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802507; c=relaxed/simple;
	bh=9cQWBE1RocNRrwr5eedBCJ4yUc2x/d54fg8aCoVBdsA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SXyoPSBu/XZSfm1iIDHiG1wudDGbU0BvVxcUHPj2Xpd0/XT2fhHgR2MoJDpYZ+/gYF1c58oTTLgqtELfBw0Bo6jL+5SkYstBRszsFZGxMZKvOh0hrLVQghd55jH1X5mcfQEUJfCJUZLV/YzxruOBqCAQwa3xRRiYXrrhhv9IawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIC74F3O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709802503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=leep4yaFIogVbNLUAzoWdO8yurLYlyZPm5kOow0HBQA=;
	b=fIC74F3ONohyz9hV+ktb+sA8SYQzDRjDF6r4VYhQ4IW1NxmBNXNSdBvIMtdj+OEYUeiA9f
	bFjgIDt7jSIYtiW/Ij14aDD6FyJlt9+VQ3eBzsX0UYB2SvVLoG4s3zojxyjsYFHM6lDZ2u
	XcX/ggEtZ/DLj6f379xhdhUqGUFXW2E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-9g99O7rcPBquHnVywXd0SA-1; Thu, 07 Mar 2024 04:08:20 -0500
X-MC-Unique: 9g99O7rcPBquHnVywXd0SA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d323435c88so1139561fa.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 01:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802498; x=1710407298;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=leep4yaFIogVbNLUAzoWdO8yurLYlyZPm5kOow0HBQA=;
        b=lWnLkwoOl9IEkpvyH8YaWpIOZqb1IpUzWlIxTAx4MdX9mc0N4PTSyNBrPuWE0cnacn
         Ru5q0yupnHOnbe7MGBMUwhlfDcUqN9tsD3kA4M5kvAyPIt8M4tpv5sqmsXHH6Hm55GNk
         gY/9XpgYeA8a6DIy52LKkas7EsM9sCyyZibVhbyU58uZX2vBVeo5NWAjmav62CAp+gF/
         O5pOBJY6Y26e8Y+f6rpcrYLNJE5MIdTbYOPVpSoSr27sePFzRvsIOje5hF6Mfo65iFyi
         Jp8moyrJFFoJ0qlz9/YnVWb9Zu4LgUV1Df5Hxeg6QMtPT12Q73wsK6Z3vg+hPLkpiELm
         fv3g==
X-Forwarded-Encrypted: i=1; AJvYcCUgRpN2OKjm9kKGf4H+ivBvTzpmnEVFEkbWWRBfIg07GG81XKa+9amGNHtKravX0nwh8yrHME73skQB+85p7E6y4EslORU1
X-Gm-Message-State: AOJu0YwADFa3vj6UXfBc5Fmg84JsUxDbaTy6kY0z9SkesFuuHTnf/eN4
	FG2+4YEWi1ECrbzjY8eq60c9DN/Kd2MgA5aTUbH2avCsVfts4wT0kibYVNHp+5Dj5jD72ROvWc6
	Uhxc4RURibVdCtc9ixBi5KoOv1KyMwbjm983dmAz+qitKdAbvbbh9Kw==
X-Received: by 2002:a05:6512:1595:b0:513:2a5b:cae with SMTP id bp21-20020a056512159500b005132a5b0caemr1294465lfb.2.1709802498268;
        Thu, 07 Mar 2024 01:08:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGtdEQcRWCFdNLYHeaCifIwee5WpVWmsfHtKjU37eHTPyGH8O4ds9oRMotOw3D/6tlNhS4hg==
X-Received: by 2002:a05:6512:1595:b0:513:2a5b:cae with SMTP id bp21-20020a056512159500b005132a5b0caemr1294441lfb.2.1709802497797;
        Thu, 07 Mar 2024 01:08:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00412ff941abasm1962497wmq.21.2024.03.07.01.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:08:17 -0800 (PST)
Message-ID: <ae074ab772566932d491a43fa34e0625ef855f2d.camel@redhat.com>
Subject: Re: [PATCH v4 net-next 05/15] af_unix: Iterate all vertices by DFS.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kuni1840@gmail.com,  netdev@vger.kernel.org
Date: Thu, 07 Mar 2024 10:08:16 +0100
In-Reply-To: <20240306201413.13082-1-kuniyu@amazon.com>
References: <25a99a706459304e9661881d413a342558a23372.camel@redhat.com>
	 <20240306201413.13082-1-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-06 at 12:14 -0800, Kuniyuki Iwashima wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Tue, 05 Mar 2024 09:53:17 +0100
> > On Thu, 2024-02-29 at 18:22 -0800, Kuniyuki Iwashima wrote:
> > > The new GC will use a depth first search graph algorithm to find
> > > cyclic references.  The algorithm visits every vertex exactly once.
> > >=20
> > > Here, we implement its DFS part without recursion so that no one
> > > can abuse it.
> > >=20
> > > unix_walk_scc() marks every vertex unvisited by initialising index
> > > as UNIX_VERTEX_INDEX_UNVISITED, iterates inflight vertices in
> > > unix_unvisited_vertices, and call __unix_walk_scc() to start DFS
> > > from an arbitrary vertex.
> > >=20
> > > __unix_walk_scc() iterates all edges starting from the vertex and
> > > explores the neighbour vertices with DFS using edge_stack.
> > >=20
> > > After visiting all neighbours, __unix_walk_scc() moves the visited
> > > vertex to unix_visited_vertices so that unix_walk_scc() will not
> > > restart DFS from the visited vertex.
> > >=20
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  include/net/af_unix.h |  2 ++
> > >  net/unix/garbage.c    | 74 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 76 insertions(+)
> > >=20
> > > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > > index f31ad1166346..970a91da2239 100644
> > > --- a/include/net/af_unix.h
> > > +++ b/include/net/af_unix.h
> > > @@ -33,12 +33,14 @@ struct unix_vertex {
> > >  	struct list_head edges;
> > >  	struct list_head entry;
> > >  	unsigned long out_degree;
> > > +	unsigned long index;
> > >  };
> > > =20
> > >  struct unix_edge {
> > >  	struct unix_sock *predecessor;
> > >  	struct unix_sock *successor;
> > >  	struct list_head vertex_entry;
> > > +	struct list_head stack_entry;
> > >  };
> > > =20
> > >  struct sock *unix_peer_get(struct sock *sk);
> > > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > > index 84c8ea524a98..8b16ab9e240e 100644
> > > --- a/net/unix/garbage.c
> > > +++ b/net/unix/garbage.c
> > > @@ -103,6 +103,11 @@ struct unix_sock *unix_get_socket(struct file *f=
ilp)
> > > =20
> > >  static LIST_HEAD(unix_unvisited_vertices);
> > > =20
> > > +enum unix_vertex_index {
> > > +	UNIX_VERTEX_INDEX_UNVISITED,
> > > +	UNIX_VERTEX_INDEX_START,
> > > +};
> > > +
> > >  static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge =
*edge)
> > >  {
> > >  	struct unix_vertex *vertex =3D edge->predecessor->vertex;
> > > @@ -241,6 +246,73 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
> > >  	unix_free_vertices(fpl);
> > >  }
> > > =20
> > > +static LIST_HEAD(unix_visited_vertices);
> > > +
> > > +static void __unix_walk_scc(struct unix_vertex *vertex)
> > > +{
> > > +	unsigned long index =3D UNIX_VERTEX_INDEX_START;
> > > +	struct unix_edge *edge;
> > > +	LIST_HEAD(edge_stack);
> > > +
> > > +next_vertex:
> > > +	vertex->index =3D index;
> > > +	index++;
> > > +
> > > +	/* Explore neighbour vertices (receivers of the current vertex's fd=
). */
> > > +	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
> > > +		struct unix_vertex *next_vertex =3D edge->successor->vertex;
> > > +
> > > +		if (!next_vertex)
> > > +			continue;
> > > +
> > > +		if (next_vertex->index =3D=3D UNIX_VERTEX_INDEX_UNVISITED) {
> > > +			/* Iterative deepening depth first search
> > > +			 *
> > > +			 *   1. Push a forward edge to edge_stack and set
> > > +			 *      the successor to vertex for the next iteration.
> > > +			 */
> > > +			list_add(&edge->stack_entry, &edge_stack);
> > > +
> > > +			vertex =3D next_vertex;
> > > +			goto next_vertex;
> > > +
> > > +			/*   2. Pop the edge directed to the current vertex
> > > +			 *      and restore the ancestor for backtracking.
> > > +			 */
> > > +prev_vertex:
> > > +			edge =3D list_first_entry(&edge_stack, typeof(*edge), stack_entry=
);
> > > +			list_del_init(&edge->stack_entry);
> > > +
> > > +			vertex =3D edge->predecessor->vertex;
> > > +		}
> > > +	}
> > > +
> > > +	/* Don't restart DFS from this vertex in unix_walk_scc(). */
> > > +	list_move_tail(&vertex->entry, &unix_visited_vertices);
> > > +
> > > +	/* Need backtracking ? */
> > > +	if (!list_empty(&edge_stack))
> > > +		goto prev_vertex;
> > > +}
> > > +
> > > +static void unix_walk_scc(void)
> > > +{
> > > +	struct unix_vertex *vertex;
> > > +
> > > +	list_for_each_entry(vertex, &unix_unvisited_vertices, entry)
> > > +		vertex->index =3D UNIX_VERTEX_INDEX_UNVISITED;
> > > +
> > > +	/* Visit every vertex exactly once.
> > > +	 * __unix_walk_scc() moves visited vertices to unix_visited_vertice=
s.
> > > +	 */
> > > +	while (!list_empty(&unix_unvisited_vertices)) {
> > > +		vertex =3D list_first_entry(&unix_unvisited_vertices, typeof(*vert=
ex), entry);
> > > +		__unix_walk_scc(vertex);
> >=20
> > If I read correctly this is the single loop that could use the CPU for
> > a possibly long time. I'm wondering if adding a cond_resched_lock()
> > here (and possibly move the gc to a specific thread instead of a
> > workqueue) would make sense.
> >=20
> > It could avoid possibly very long starvation of the system wq and the
> > used CPU.
>=20
> TIL cond_resched_lock() :)
>=20
> The loop is executed only when we add/del/update edges whose successor
> is alredy inflight, and the loop takes O(|Vertex| + |Edges|).
>=20
> If the loop takes so long, there would be too many inflight skbs, but
> the current GC does not care such a situation.

Yes, the whole idea was about a possible additional improvement WRT the
current status.

> The suggestion still makes sense, and then we could use mutex instead of
> spinlock after kthread conversion.
>=20
> Given the series has already 15 patches, I can add cond_resched_lock()
> only in the next version and include the conversion in the follow-up
> patches or include both changes as followup or do the conversion as prep.
>=20
> What's the preferred option ?

Keep all the 'new stuff' in follow-up series would be the best option
IMHO.

Thanks!

Paolo


