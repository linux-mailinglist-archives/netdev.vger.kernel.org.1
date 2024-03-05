Return-Path: <netdev+bounces-77397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDFE8718A6
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439F31C20ADD
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF064EB22;
	Tue,  5 Mar 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRkE8pJK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC34CB58
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628805; cv=none; b=tu0ORKFLbMkR3ZEDNCX+LRi7l23nNQDGYqkQXJPuO6rJ6Rxm5WhYDB6/IEPMTBY9EVVs4Pno6pf1idzQh6It7iH7EySgnfrgzS+zxW0rL1ayb/6tubRHtSDspcwO0Rgqgk41lVxiJydGI1QcSd0CFwTr9b2A7wMvE9RmpMcp4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628805; c=relaxed/simple;
	bh=1M4qFUW1DtKLZIzAUEO/bt3ouHH402b4L2QV8eA4kS4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TuXWEKE/JlfOg1kDLuLA1AZGCk8jSY9oRheJcAa1wmR0cJ3d6QvdnwBWm0rkoYxUjVVYibrxxl5tvMTUJmyahd1nbC88qBZWowLwm0Y9EcsxvZrY1CdpRbWO59phG+vpHacjTn+brvgxw1iU6Lza0aa7QR+lYu8wm6PBNNdSuzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRkE8pJK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709628802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+qSo/si2QVginjb1EtxixlkjW2UK21h2Qh7Be7XFBHU=;
	b=MRkE8pJKzR9wyU5IABqmBohXTND8DoY43jrbAYQm2QkTJsWuUqOXsGj9A78OVvOGt8n4UD
	cz89t9XtZtD/Ey/jsztpeSHj84Bje0ur8UE7mR3fxb197fqu0b3qcWFLt+Qrgcyrh9LhZO
	TD8AD/F0oVisx1Iety2mJfGj+mCF0qM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-4LJ4UXZjNN-0WlJ1gDmVfQ-1; Tue, 05 Mar 2024 03:53:21 -0500
X-MC-Unique: 4LJ4UXZjNN-0WlJ1gDmVfQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d86aedbffso326873f8f.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 00:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628800; x=1710233600;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qSo/si2QVginjb1EtxixlkjW2UK21h2Qh7Be7XFBHU=;
        b=ihIndSRlPr6NL3j/LmGH56X7zkJH1dRJDSv7QP0IQkC2qty4KiZYQUR4L/3qtqJ0Zr
         g0Y2Qu6pNwPQhlN4L47ZrepFb+vTIW/xaX6TrJNtQbs6A47JPd02VlnJduEcyZ3Nz49/
         gE4vpQtfa95egObm812kb27gfaYpDguDfqy1cCR/u2ey0D+fZsGBf1HGit2KAhr4hthr
         1K2OrXWZJtXx0KeDAOK/LlZxP1i6Xk5MmK9jziUZ1ns0YQcaVFCtabmQ8hP4/R2K2hHp
         EyOfQ6n9LPq/jgxQY3K779+jJhVEyl5ip9Qy6VqYG3yq1IVdMcIaovrbKUHZLIVluEYx
         v0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsRqA03eNFqBPRyo/4WIx4r2ZijrTAe4kXVV/aydD6bBFRFUlrs7dhTh9nrKMiPIlAFfTTqzeYOJMazFbHRHCUltksc3OC
X-Gm-Message-State: AOJu0YzWOzug2KpOvP6AM34sz3fY5yhSK+CfPz/U+M0/qXojAlCLMcsS
	UiIcyoPZkWUr9O7lG7xVdFTJalxh9FC/uEjIMqSvGG5nGYDM1u75az6Rpi5mx6pa/0JADtD0/om
	aqQY/9ntUtHaSjE/FUpxozovM4d27IbanK1zMKj0T9TGhERP0extaUg==
X-Received: by 2002:a5d:50c7:0:b0:33e:1ee0:628c with SMTP id f7-20020a5d50c7000000b0033e1ee0628cmr7945015wrt.3.1709628800189;
        Tue, 05 Mar 2024 00:53:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRQ9CPZkcUKhg70z5t1qAFBatuvAfHHo844DzunZktY4D4/57+TUDQk1xHqu3olG7qjWRibA==
X-Received: by 2002:a5d:50c7:0:b0:33e:1ee0:628c with SMTP id f7-20020a5d50c7000000b0033e1ee0628cmr7945001wrt.3.1709628799765;
        Tue, 05 Mar 2024 00:53:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id by12-20020a056000098c00b0033e25c39ac3sm9692991wrb.80.2024.03.05.00.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:53:18 -0800 (PST)
Message-ID: <25a99a706459304e9661881d413a342558a23372.camel@redhat.com>
Subject: Re: [PATCH v4 net-next 05/15] af_unix: Iterate all vertices by DFS.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Tue, 05 Mar 2024 09:53:17 +0100
In-Reply-To: <20240301022243.73908-6-kuniyu@amazon.com>
References: <20240301022243.73908-1-kuniyu@amazon.com>
	 <20240301022243.73908-6-kuniyu@amazon.com>
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

On Thu, 2024-02-29 at 18:22 -0800, Kuniyuki Iwashima wrote:
> The new GC will use a depth first search graph algorithm to find
> cyclic references.  The algorithm visits every vertex exactly once.
>=20
> Here, we implement its DFS part without recursion so that no one
> can abuse it.
>=20
> unix_walk_scc() marks every vertex unvisited by initialising index
> as UNIX_VERTEX_INDEX_UNVISITED, iterates inflight vertices in
> unix_unvisited_vertices, and call __unix_walk_scc() to start DFS
> from an arbitrary vertex.
>=20
> __unix_walk_scc() iterates all edges starting from the vertex and
> explores the neighbour vertices with DFS using edge_stack.
>=20
> After visiting all neighbours, __unix_walk_scc() moves the visited
> vertex to unix_visited_vertices so that unix_walk_scc() will not
> restart DFS from the visited vertex.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/af_unix.h |  2 ++
>  net/unix/garbage.c    | 74 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>=20
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index f31ad1166346..970a91da2239 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -33,12 +33,14 @@ struct unix_vertex {
>  	struct list_head edges;
>  	struct list_head entry;
>  	unsigned long out_degree;
> +	unsigned long index;
>  };
> =20
>  struct unix_edge {
>  	struct unix_sock *predecessor;
>  	struct unix_sock *successor;
>  	struct list_head vertex_entry;
> +	struct list_head stack_entry;
>  };
> =20
>  struct sock *unix_peer_get(struct sock *sk);
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 84c8ea524a98..8b16ab9e240e 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -103,6 +103,11 @@ struct unix_sock *unix_get_socket(struct file *filp)
> =20
>  static LIST_HEAD(unix_unvisited_vertices);
> =20
> +enum unix_vertex_index {
> +	UNIX_VERTEX_INDEX_UNVISITED,
> +	UNIX_VERTEX_INDEX_START,
> +};
> +
>  static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edg=
e)
>  {
>  	struct unix_vertex *vertex =3D edge->predecessor->vertex;
> @@ -241,6 +246,73 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
>  	unix_free_vertices(fpl);
>  }
> =20
> +static LIST_HEAD(unix_visited_vertices);
> +
> +static void __unix_walk_scc(struct unix_vertex *vertex)
> +{
> +	unsigned long index =3D UNIX_VERTEX_INDEX_START;
> +	struct unix_edge *edge;
> +	LIST_HEAD(edge_stack);
> +
> +next_vertex:
> +	vertex->index =3D index;
> +	index++;
> +
> +	/* Explore neighbour vertices (receivers of the current vertex's fd). *=
/
> +	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
> +		struct unix_vertex *next_vertex =3D edge->successor->vertex;
> +
> +		if (!next_vertex)
> +			continue;
> +
> +		if (next_vertex->index =3D=3D UNIX_VERTEX_INDEX_UNVISITED) {
> +			/* Iterative deepening depth first search
> +			 *
> +			 *   1. Push a forward edge to edge_stack and set
> +			 *      the successor to vertex for the next iteration.
> +			 */
> +			list_add(&edge->stack_entry, &edge_stack);
> +
> +			vertex =3D next_vertex;
> +			goto next_vertex;
> +
> +			/*   2. Pop the edge directed to the current vertex
> +			 *      and restore the ancestor for backtracking.
> +			 */
> +prev_vertex:
> +			edge =3D list_first_entry(&edge_stack, typeof(*edge), stack_entry);
> +			list_del_init(&edge->stack_entry);
> +
> +			vertex =3D edge->predecessor->vertex;
> +		}
> +	}
> +
> +	/* Don't restart DFS from this vertex in unix_walk_scc(). */
> +	list_move_tail(&vertex->entry, &unix_visited_vertices);
> +
> +	/* Need backtracking ? */
> +	if (!list_empty(&edge_stack))
> +		goto prev_vertex;
> +}
> +
> +static void unix_walk_scc(void)
> +{
> +	struct unix_vertex *vertex;
> +
> +	list_for_each_entry(vertex, &unix_unvisited_vertices, entry)
> +		vertex->index =3D UNIX_VERTEX_INDEX_UNVISITED;
> +
> +	/* Visit every vertex exactly once.
> +	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
> +	 */
> +	while (!list_empty(&unix_unvisited_vertices)) {
> +		vertex =3D list_first_entry(&unix_unvisited_vertices, typeof(*vertex),=
 entry);
> +		__unix_walk_scc(vertex);

If I read correctly this is the single loop that could use the CPU for
a possibly long time. I'm wondering if adding a cond_resched_lock()
here (and possibly move the gc to a specific thread instead of a
workqueue) would make sense.

It could avoid possibly very long starvation of the system wq and the
used CPU.

Cheers,

Paolo


