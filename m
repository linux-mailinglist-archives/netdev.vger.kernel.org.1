Return-Path: <netdev+bounces-73274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD8085BB63
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74451F21B5B
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552D67C4B;
	Tue, 20 Feb 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XF09oky4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54667C4F
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430787; cv=none; b=h9rBsBAJV38Uq3NFjyrlViU1ROyhiea+ksag/Uj+aHJdSmAK8Ki5r6YCD6GFKtvn2Oko6H0TQr6AGINq2YkWROWMK+HH11JS0PKhtLib9AqH8eNOgnH+3Hq7aVYjfUVssOo8uqWfER5iKFEoXiowp1YRpruVuYSSPl++/h5UcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430787; c=relaxed/simple;
	bh=NFi+j3hA9WEesenlgGCRFiz11TTrlXk4sHYqy5xFwkY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z21C5lrzYuFq6Nty7Y6FBq4OBnkMjMt/fHkLKIzcgCHHfwMAq38BFHqltv3o0a/d0ZBq0oP/5IWJpWC+0CSKZAsZuj/YwC7pd4x9s3lbpg8jqM+gsupL5/msokPFFFfNpsWiv6Q2JbgUKt409w3LaSU5WFs2Ht/I3fW0Leidht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XF09oky4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708430784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lg1u0aMGipJlSQmuc4KE0d4NV/J0ImutHRAnFZXMs00=;
	b=XF09oky4ywD20TeLKLrP4bKNIdnnefIRIT5k85g0IpEBytw619r3+pTKC+XELauGjJ7d8r
	SenxNCEox9ab9fM/g8ykyCcXCJTZYbauSiU/GC/RTcpYtuMdQb2+rlDqmZpDwSNV6rfqRp
	xic9O1+EL2YDHLqRF0h7M3VZE8dVGdE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-xEEaiTwRNByXDKYmVF_z0g-1; Tue, 20 Feb 2024 07:06:22 -0500
X-MC-Unique: xEEaiTwRNByXDKYmVF_z0g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d3757a367so125505f8f.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 04:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430781; x=1709035581;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg1u0aMGipJlSQmuc4KE0d4NV/J0ImutHRAnFZXMs00=;
        b=YN9PxBHq9vMtdtlP0MyvT9eMXvOpuRVoGIOViqlCnZpgG2jni0GyLl3wZutYZYkNKo
         v3OAqtbuJjQnThtOVCJaWKn4OVebXv7lx9MtMQbgBbwKYcJxlsXAHXk56Hr4ISMrRhIu
         OKucBm90zs6+YzxH/pZmAz01n3iLFeFtkaSXK3HlTToSTncj94BYH9HyvNbGowkwfNsR
         +Bw0ldPBGVrvHkMPhsqLHXCorRgh5BcSoWiWWDoflEnLfdWqHd4rXa+gFDC2dTSxo/uD
         iRRT/ZjoFscWMS0aKEQpIQhIo9uhem0NcSy/Q4b59OsyjiVrw+kiYjIYW4fF57onhUqK
         eK7A==
X-Forwarded-Encrypted: i=1; AJvYcCU2URTEc0iWw5z9lV8EwcQQSIRCGoW/0jZ2lsi6x3p/HGLCpI/RKtZ5MUboIkA6AxjEvHjQRiglvwl0ASEICEJrwK+1hl8I
X-Gm-Message-State: AOJu0YynchH13KOfPrkE6I5CR454yNnMxjZKY3K7bMnOmhvmLbtCol13
	/q6nCG5lMtBUl/PCyikdlDZhfma9rvhYKpAV2EfZR6ORF3MegUmoe8wsj3NrYNI8RcyzQf3VYHx
	nskv6VSvyux+HBbMxeeIQ4izvQT07DTQ12USAI7nJ3yaQqzMvbmfv8A==
X-Received: by 2002:a05:6000:1f09:b0:33b:88a0:a1e9 with SMTP id bv9-20020a0560001f0900b0033b88a0a1e9mr7513937wrb.4.1708430781155;
        Tue, 20 Feb 2024 04:06:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwkkldF9nLAmzQ5qy8YbLC9JjxLkvvE163fZt2XGXn/e0lUYfb+iVacFr4DVRZLfIlkEzsKw==
X-Received: by 2002:a05:6000:1f09:b0:33b:88a0:a1e9 with SMTP id bv9-20020a0560001f0900b0033b88a0a1e9mr7513913wrb.4.1708430780715;
        Tue, 20 Feb 2024 04:06:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-79.dyn.eolo.it. [146.241.230.79])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d428e000000b0033ce5b3390esm13313351wrq.38.2024.02.20.04.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:06:20 -0800 (PST)
Message-ID: <82046b6cf70823e8c17e102c8233f1cb219bb9f5.camel@redhat.com>
Subject: Re: [PATCH v1 net-next 03/16] af_unix: Link struct unix_edge when
 queuing skb.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Tue, 20 Feb 2024 13:06:18 +0100
In-Reply-To: <20240203030058.60750-4-kuniyu@amazon.com>
References: <20240203030058.60750-1-kuniyu@amazon.com>
	 <20240203030058.60750-4-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-02 at 19:00 -0800, Kuniyuki Iwashima wrote:
> Just before queuing skb with inflight fds, we call scm_stat_add(),
> which is a good place to set up the preallocated struct unix_edge
> in UNIXCB(skb).fp->edges.
>=20
> Then, we call unix_add_edges() and construct the directed graph
> as follows:
>=20
>   1. Set the inflight socket's unix_vertex to unix_edge.predecessor
>   2. Set the receiver's unix_vertex to unix_edge.successor
>   3. Link unix_edge.entry to the inflight socket's unix_vertex.edges
>   4. Link inflight socket's unix_vertex.entry to unix_unvisited_vertices.
>=20
> Let's say we pass the fd of AF_UNIX socket A to B and the fd of B
> to C.  The graph looks like this:
>=20
>   +-------------------------+
>   | unix_unvisited_vertices | <------------------------.
>   +-------------------------+                          |
>   +                                                    |
>   |   +-------------+                +-------------+   |            +----=
---------+
>   |   | unix_sock A |                | unix_sock B |   |            | uni=
x_sock C |
>   |   +-------------+                +-------------+   |            +----=
---------+
>   |   | unix_vertex | <----.  .----> | unix_vertex | <-|--.  .----> | uni=
x_vertex |
>   |   | +-----------+      |  |      | +-----------+   |  |  |      | +--=
---------+
>   `-> | |   entry   | +------------> | |   entry   | +-'  |  |      | |  =
 entry   |
>       | |-----------|      |  |      | |-----------|      |  |      | |--=
---------|
>       | |   edges   | <-.  |  |      | |   edges   | <-.  |  |      | |  =
 edges   |
>       +-+-----------+   |  |  |      +-+-----------+   |  |  |      +-+--=
---------+
>                         |  |  |                        |  |  |
>   .---------------------'  |  |  .---------------------'  |  |
>   |                        |  |  |                        |  |
>   |   +-------------+      |  |  |   +-------------+      |  |
>   |   |  unix_edge  |      |  |  |   |  unix_edge  |      |  |
>   |   +-------------+      |  |  |   +-------------+      |  |
>   `-> |    entry    |      |  |  `-> |    entry    |      |  |
>       |-------------|      |  |      |-------------|      |  |
>       | predecessor | +----'  |      | predecessor | +----'  |
>       |-------------|         |      |-------------|         |
>       |  successor  | +-------'      |  successor  | +-------'
>       +-------------+                +-------------+
>=20
> Henceforth, we denote such a graph as A -> B (-> C).
>=20
> Now, we can express all inflight fd graphs that do not contain
> embryo sockets.  The following two patches will support the
> particular case.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/af_unix.h |  2 ++
>  include/net/scm.h     |  1 +
>  net/core/scm.c        |  2 ++
>  net/unix/af_unix.c    |  8 +++++--
>  net/unix/garbage.c    | 56 ++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 66 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index cab9dfb666f3..54d62467a70b 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -23,6 +23,8 @@ extern unsigned int unix_tot_inflight;
>  void unix_inflight(struct user_struct *user, struct file *fp);
>  void unix_notinflight(struct user_struct *user, struct file *fp);
>  void unix_init_vertex(struct unix_sock *u);
> +void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)=
;
> +void unix_del_edges(struct scm_fp_list *fpl);
>  int unix_alloc_edges(struct scm_fp_list *fpl);
>  void unix_free_edges(struct scm_fp_list *fpl);
>  void unix_gc(void);
> diff --git a/include/net/scm.h b/include/net/scm.h
> index a1142dee086c..7d807fe466a3 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -32,6 +32,7 @@ struct scm_fp_list {
>  	short			count_unix;
>  	short			max;
>  #ifdef CONFIG_UNIX
> +	bool			inflight;
>  	struct unix_edge	*edges;
>  #endif
>  	struct user_struct	*user;
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 8661524ed6e5..d141c00eb116 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -87,6 +87,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm=
_fp_list **fplp)
>  		*fplp =3D fpl;
>  		fpl->count =3D 0;
>  		fpl->count_unix =3D 0;
> +		fpl->inflight =3D false;
>  		fpl->edges =3D NULL;
>  		fpl->max =3D SCM_MAX_FD;
>  		fpl->user =3D NULL;
> @@ -378,6 +379,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fp=
l)
>  		for (i =3D 0; i < fpl->count; i++)
>  			get_file(fpl->fp[i]);
> =20
> +		new_fpl->inflight =3D false;
>  		new_fpl->edges =3D NULL;
>  		new_fpl->max =3D new_fpl->count;
>  		new_fpl->user =3D get_uid(fpl->user);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 0391f66546a6..ea7bac18a781 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1956,8 +1956,10 @@ static void scm_stat_add(struct sock *sk, struct s=
k_buff *skb)
>  	struct scm_fp_list *fp =3D UNIXCB(skb).fp;
>  	struct unix_sock *u =3D unix_sk(sk);
> =20
> -	if (unlikely(fp && fp->count))
> +	if (unlikely(fp && fp->count)) {
>  		atomic_add(fp->count, &u->scm_stat.nr_fds);
> +		unix_add_edges(fp, u);
> +	}
>  }
> =20
>  static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
> @@ -1965,8 +1967,10 @@ static void scm_stat_del(struct sock *sk, struct s=
k_buff *skb)
>  	struct scm_fp_list *fp =3D UNIXCB(skb).fp;
>  	struct unix_sock *u =3D unix_sk(sk);
> =20
> -	if (unlikely(fp && fp->count))
> +	if (unlikely(fp && fp->count)) {
>  		atomic_sub(fp->count, &u->scm_stat.nr_fds);
> +		unix_del_edges(fp);
> +	}
>  }
> =20
>  /*
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 6a3572e43b9f..572ac0994c69 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -110,6 +110,58 @@ void unix_init_vertex(struct unix_sock *u)
>  	INIT_LIST_HEAD(&vertex->entry);
>  }
> =20
> +DEFINE_SPINLOCK(unix_gc_lock);
> +static LIST_HEAD(unix_unvisited_vertices);
> +
> +void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
> +{
> +	int i =3D 0, j =3D 0;
> +
> +	spin_lock(&unix_gc_lock);
> +
> +	while (i < fpl->count_unix) {
> +		struct unix_sock *inflight =3D unix_get_socket(fpl->fp[j++]);
> +		struct unix_edge *edge;
> +
> +		if (!inflight)
> +			continue;
> +
> +		edge =3D fpl->edges + i++;
> +		edge->predecessor =3D &inflight->vertex;
> +		edge->successor =3D &receiver->vertex;
> +
> +		if (!edge->predecessor->out_degree++)
> +			list_add_tail(&edge->predecessor->entry, &unix_unvisited_vertices);
> +
> +		INIT_LIST_HEAD(&edge->entry);

Here  'edge->predecessor->entry' and 'edge->entry' refer to different
object types right ? edge vs vertices. Perhaps using different field
names could clarify the code a bit?=20

Also the edge->entry initialization just before the list_add_tail below
looks strange/suspect. Perhaps it would be better to the init at
allocation time?

Thanks!

Paolo


