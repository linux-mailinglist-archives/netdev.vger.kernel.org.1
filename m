Return-Path: <netdev+bounces-75271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB7F868E46
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7E71F229EF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8C1386B2;
	Tue, 27 Feb 2024 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTuWciz7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E3136651
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031767; cv=none; b=KA7gdhTXcP2fESdhGZfmoLFvYrvDlV+rI/EWLTb77Ah1G8i5Wa5wUR7LvYZuFtlleOqMSBRQSnWy9c4W+hP4m08WP/65CMWti97xlCIvI2Y/tB9o2mvUhsIVz3W6Sj4qBrFbHXiWGz3KsxTxza5Pv2Ge+3oCnaBrvQrDFPFhDqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031767; c=relaxed/simple;
	bh=UuIahbWdRh7rrx+ODempGludCgZMo1mAtC58pkiJ+Yg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FI64hLpWFrd5m0FdL17yubf7qN9CdfqsUz2hg4Bu+0k4f/UUKhVZCwIWLItbIzIezau3WQPyMMESezEHZIW7Q7LnEUWzsgLuUbIREC6toguWrweyXC2VeDXv+qU49uQIhNAGkZET22kzoNoYe4Y19hevO3arLtXvU+otOtIBJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTuWciz7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709031764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JdyPge5h+2PqOHbTqXBm5iegKDQtnWyg6pxOpsM1t5k=;
	b=TTuWciz7DOE4vLaSN6iSX0tfJ8gieTgV0CY55kdGrDbCWM+yvH3588lemSZQfC9l/rSd5V
	CwNHKJHQ0vC6/pof4IB6wkJ7M9iAr1aLv44gbYILogm/Ow/WhFyBd8BHqtqIPjkQx3i1Jl
	2NlmLsACx+CRyLzJiH2iD2vrLvN8I/o=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-qySsK3ydNX2qM7TEjtSIjw-1; Tue, 27 Feb 2024 06:02:31 -0500
X-MC-Unique: qySsK3ydNX2qM7TEjtSIjw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d28956c7beso2777281fa.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 03:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709031750; x=1709636550;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdyPge5h+2PqOHbTqXBm5iegKDQtnWyg6pxOpsM1t5k=;
        b=CJKl1ckgk7rX1qjRZ3xQkcCoWIGeiP7O3mbDnBKjInVUS5y7t8wSs7wkb93K1Wa2NZ
         m8Bw9mCxxlCKzVLm18kopV2mk9kKl7lN1X3B68+KHvqfRX5x+7d4CCj+2Z56sJGS4i/a
         BBujiSLXBXz12D1Lxmy/fWttrv14k4G1XRoygWk3lmFPZQIvZBYAV6PfZ/QX7lh7uxwA
         7k3H0i7ugInpUj3RMSlz0P0tcFWGOTlHyjGMwJYvpdAosU7JtUVlx27H0w2HK0d49Cqu
         Shf+YOsO4uMPsngRqycHK+go2Z2MV8iosBwRarWG9f4yMTeYzRVOGlJBDch4DyVjlxNY
         DC9w==
X-Forwarded-Encrypted: i=1; AJvYcCVCQd5w592iSyGutxGCIgjvpyDt4Z5geEEIqoHRmRc162iPOSDMl+l5EDzrkhSdExR3kZ4ArwYN9bWJVDavvXtw+r6SMBKp
X-Gm-Message-State: AOJu0Yyt36xHB6ks+PCeswasQnE9gIMcqPRJ4FHFng9TXEbr/gXHvu2s
	aydQAHO8y2mN6pu6HqQTQWOXb0H3MdKlXMVoqWp4T9ql28l2AQMFIm5SzHUC2W/vj30vuuxQe0k
	DxcDXH+f3reSwVHqDgQbPWYa7Yu5AfDPxU2+btelsnBtLtXfpjlokKw==
X-Received: by 2002:a2e:b0c6:0:b0:2d2:51ec:6fff with SMTP id g6-20020a2eb0c6000000b002d251ec6fffmr5354943ljl.2.1709031750179;
        Tue, 27 Feb 2024 03:02:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8HXCHwnqNYzHvA2YvZ5wHA/rgn9N6MfHrliU/NzHqNUWEFyn3/07BNJ18JKfft91cPsHDhA==
X-Received: by 2002:a2e:b0c6:0:b0:2d2:51ec:6fff with SMTP id g6-20020a2eb0c6000000b002d251ec6fffmr5354923ljl.2.1709031749746;
        Tue, 27 Feb 2024 03:02:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-60.dyn.eolo.it. [146.241.245.60])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b00412a5a24745sm5417653wmq.27.2024.02.27.03.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 03:02:29 -0800 (PST)
Message-ID: <8880a6a22b774b25db9c4a2bc95487521170de20.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 05/14] af_unix: Detect Strongly Connected
 Components.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Tue, 27 Feb 2024 12:02:27 +0100
In-Reply-To: <20240223214003.17369-6-kuniyu@amazon.com>
References: <20240223214003.17369-1-kuniyu@amazon.com>
	 <20240223214003.17369-6-kuniyu@amazon.com>
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

On Fri, 2024-02-23 at 13:39 -0800, Kuniyuki Iwashima wrote:
> In the new GC, we use a simple graph algorithm, Tarjan's Strongly
> Connected Components (SCC) algorithm, to find cyclic references.
>=20
> The algorithm visits every vertex exactly once using depth-first
> search (DFS).  We implement it without recursion so that no one
> can abuse it.
>=20
> There could be multiple graphs, so we iterate unix_unvisited_vertices
> in unix_walk_scc() and do DFS in __unix_walk_scc(), where we move
> visited vertices to another list, unix_visited_vertices, not to
> restart DFS twice on a visited vertex later in unix_walk_scc().
>=20
> DFS starts by pushing an input vertex to a stack and assigning it
> a unique number.  Two fields, index and lowlink, are initialised
> with the number, but lowlink could be updated later during DFS.
>=20
> If a vertex has an edge to an unvisited inflight vertex, we visit
> it and do the same processing.  So, we will have vertices in the
> stack in the order they appear and number them consecutively in
> the same order.
>=20
> If a vertex has a back-edge to a visited vertex in the stack,
> we update the predecessor's lowlink with the successor's index.
>=20
> After iterating edges from the vertex, we check if its index
> equals its lowlink.
>=20
> If the lowlink is different from the index, it shows there was a
> back-edge.  Then, we propagate the lowlink to its predecessor and
> go back to the predecessor to resume checking from the next edge
> of the back-edge.
>=20
> If the lowlink is the same as the index, we pop vertices before
> and including the vertex from the stack.  Then, the set of vertices
> is SCC, possibly forming a cycle.  At the same time, we move the
> vertices to unix_visited_vertices.
>=20
> When we finish the algorithm, all vertices in each SCC will be
> linked via unix_vertex.scc_entry.
>=20
> Let's take an example.  We have a graph including five inflight
> vertices (F is not inflight):
>=20
>   A -> B -> C -> D -> E (-> F)
>        ^         |
>        `---------'
>=20
> Suppose that we start DFS from C.  We will visit C, D, and B first
> and initialise their index and lowlink.  Then, the stack looks like
> this:
>=20
>   > B =3D (3, 3)  (index, lowlink)
>     D =3D (2, 2)
>     C =3D (1, 1)
>=20
> When checking B's edge to C, we update B's lowlink with C's index
> and propagate it to D.
>=20
>     B =3D (3, 1)  (index, lowlink)
>   > D =3D (2, 1)
>     C =3D (1, 1)
>=20
> Next, we visit E, which has no edge to an inflight vertex.
>=20
>   > E =3D (4, 4)  (index, lowlink)
>     B =3D (3, 1)
>     D =3D (2, 1)
>     C =3D (1, 1)
>=20
> When we leave from E, its index and lowlink are the same, so we
> pop E from the stack as single-vertex SCC.  Next, we leave from
> D but do nothing because its lowlink is different from its index.
>=20
>     B =3D (3, 1)  (index, lowlink)
>     D =3D (2, 1)
>   > C =3D (1, 1)
>=20
> Then, we leave from C, whose index and lowlink are the same, so
> we pop B, D and C as SCC.
>=20
> Last, we do DFS for the rest of vertices, A, which is also a
> single-vertex SCC.
>=20
> Finally, each unix_vertex.scc_entry is linked as follows:
>=20
>   A -.  B -> C -> D  E -.
>   ^  |  ^         |  ^  |
>   `--'  `---------'  `--'
>=20
> We use SCC later to decide whether we can garbage-collect the
> sockets.
>=20
> Note that we still cannot detect SCC properly if an edge points
> to an embryo socket.  The following two patches will sort it out.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/af_unix.h |  5 +++
>  net/unix/garbage.c    | 82 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>=20
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index f31ad1166346..67736767b616 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -32,13 +32,18 @@ void wait_for_unix_gc(struct scm_fp_list *fpl);
>  struct unix_vertex {
>  	struct list_head edges;
>  	struct list_head entry;
> +	struct list_head scc_entry;
>  	unsigned long out_degree;
> +	unsigned long index;
> +	unsigned long lowlink;
> +	bool on_stack;
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
> index e8fe08796d02..7e90663513f9 100644
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
> @@ -245,6 +250,81 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
>  	unix_free_vertices(fpl);
>  }
> =20
> +static LIST_HEAD(unix_visited_vertices);
> +
> +static void __unix_walk_scc(struct unix_vertex *vertex)
> +{
> +	unsigned long index =3D UNIX_VERTEX_INDEX_START;
> +	LIST_HEAD(vertex_stack);
> +	struct unix_edge *edge;
> +	LIST_HEAD(edge_stack);
> +
> +next_vertex:
> +	vertex->index =3D index;
> +	vertex->lowlink =3D index;
> +	index++;
> +
> +	vertex->on_stack =3D true;
> +	list_add(&vertex->scc_entry, &vertex_stack);
> +
> +	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
> +		struct unix_vertex *next_vertex =3D edge->successor->vertex;
> +
> +		if (!next_vertex)
> +			continue;
> +
> +		if (next_vertex->index =3D=3D UNIX_VERTEX_INDEX_UNVISITED) {
> +			list_add(&edge->stack_entry, &edge_stack);
> +
> +			vertex =3D next_vertex;
> +			goto next_vertex;
> +prev_vertex:
> +			next_vertex =3D vertex;
> +
> +			edge =3D list_first_entry(&edge_stack, typeof(*edge), stack_entry);
> +			list_del_init(&edge->stack_entry);
> +
> +			vertex =3D edge->predecessor->vertex;
> +
> +			vertex->lowlink =3D min(vertex->lowlink, next_vertex->lowlink);
> +		} else if (edge->successor->vertex->on_stack) {

It looks like you can replace ^^^^^^^^^^^^^^^^^^^^ with 'next_vertex'
and that would be more readable.

IMHO more importantly: this code is fairly untrivial, I think that a
significant amount of comments would help the review and the long term
maintenance - even if everything is crystal clear and obvious to you,
restating the obvious in a comment would help me ;)

Thanks,

Paolo


