Return-Path: <netdev+bounces-75274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B561B868E9C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A0B1C211EF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B5F1386BF;
	Tue, 27 Feb 2024 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rvr2et12"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076152A8C1
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032787; cv=none; b=FKknL7DSRnDLVc+HxwUP1KIGDhLTUJF98GOlphCNopCvd8U3TnXXVv03hkjcxgVfDGIBsYM7st89UesWc+aXcFIJ9W/2nSHDjP0vxFUNfsOF0/uwgCSJEq1olCfTqSlkTYV7FsiVhc3OoFS7XMj/AEpFkQj54C9aqTQ7ku77JN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032787; c=relaxed/simple;
	bh=G5wqjJIz4ZUMdV0h2Juz5cXuYqvcjunQ/EnHjNUUVF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jj2NkPais/HZwI0+EDLcdKOspiFEDkcjNxqMNOZAkL/DWc+kyYYNwNzzWP76TFaLie8uGoVY2ajDpNMjaiyO0aPuL3Tn4b0rwrLSKjvQcedyHxvs4nHKY6VUQ6+wJHqzdtodjGmCriAHQQfdJQFZeZaMVK09Zew138VwpdXTxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rvr2et12; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709032784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kgnUIqNhPtGG62RSvcxQ6A8XC5zpWKZ/aWyMaBV5C3w=;
	b=Rvr2et12XawIVvcfDXW4+mIUoQvjke99cnifQiOJJZnp/G1VIe3FjVHH16xxhkFaAK60Rl
	/2CaimRwPDgznVi3ghvjXIPQ+XnysPyTaIPPHqHMl8foCogRTDNF8VcB+sqTeKZcKvm1NW
	9ZojfAIWqqBk8gf2lPHfXVL1jTAKRJ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-FrMZwG0nPsO1nqzoYfmclQ-1; Tue, 27 Feb 2024 06:19:43 -0500
X-MC-Unique: FrMZwG0nPsO1nqzoYfmclQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3377bf95b77so1055116f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 03:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709032782; x=1709637582;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgnUIqNhPtGG62RSvcxQ6A8XC5zpWKZ/aWyMaBV5C3w=;
        b=c5c6mUZJJQRtWVwXhzA5s9pB479EMeP/WAT3mrQyjVOJ5JPa50i5WcLMe2DdlQ93cG
         AUwBLcHJKMCvJGh5Y4gU4PQE/CAgfSMdsJzGQj5fpykCObm560Amd7qq4/IIL1quUBL5
         f7Fz+EmFgWR2Ss6whon1rFDEj0MFeSEgvmqJQNjwQ1zirM0IEU7AFoePkCv2SI/QX0uP
         k/rVrBmhsBwmZhBHDoHOkQ+7gIga7V5FjUEWYMcDz8N8aIgTrTvb263COWuEb9tc3OuV
         DC+HAINiLXwpRFTZMBBlj65Hl3cRaGv2IU4qiJBhV3jMY2jde1js3CsEh5n1liU4SIm1
         BzGg==
X-Forwarded-Encrypted: i=1; AJvYcCWEotBiS7CLsWhq6S8gMadQ+aXuyo7XPfwU2hHFwWTlyCtyjOcZoMvVvHFLH4Us8JmoFwlU3toU2o6G4V6y11GeH5KDboa+
X-Gm-Message-State: AOJu0Yz6LDPjNMUdFFfX4yzVvjDijs8Jxl5zJktpyGCl39tTPlAyzVNY
	er7DNZwh4/UjOl5ivrxt1YIXB7NZmqGCH93h4XlREqwOHSXEQnAHAn+OCPH7ERNyRdaOaFJYzch
	g3Cic5v9mSWIbvLj4U5x6q7ekuablXpC081KpvVhxwV6LuXGSXWAZcA==
X-Received: by 2002:a5d:5a1b:0:b0:33d:297c:911c with SMTP id bq27-20020a5d5a1b000000b0033d297c911cmr8101210wrb.0.1709032782484;
        Tue, 27 Feb 2024 03:19:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpzYug4z9yVDAFe+KKEhg5Ov9qW+zi3iTVBYNBc1gsjYzN9vovXjCQwQSh3cxdjoH6OlW0FA==
X-Received: by 2002:a5d:5a1b:0:b0:33d:297c:911c with SMTP id bq27-20020a5d5a1b000000b0033d297c911cmr8101194wrb.0.1709032782101;
        Tue, 27 Feb 2024 03:19:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-60.dyn.eolo.it. [146.241.245.60])
        by smtp.gmail.com with ESMTPSA id u14-20020a056000038e00b0033dca6f8b44sm8436081wrf.16.2024.02.27.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 03:19:41 -0800 (PST)
Message-ID: <5f13e49d7aa3fb7ce51a5bea51268882a90a32c1.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 11/14] af_unix: Assign a unique index to SCC.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Tue, 27 Feb 2024 12:19:40 +0100
In-Reply-To: <20240223214003.17369-12-kuniyu@amazon.com>
References: <20240223214003.17369-1-kuniyu@amazon.com>
	 <20240223214003.17369-12-kuniyu@amazon.com>
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

On Fri, 2024-02-23 at 13:40 -0800, Kuniyuki Iwashima wrote:
> The definition of the lowlink in Tarjan's algorithm is the
> smallest index of a vertex that is reachable with at most one
> back-edge in SCC.  This is not useful for a cross-edge.
>=20
> If we start traversing from A in the following graph, the final
> lowlink of D is 3.  The cross-edge here is one between D and C.
>=20
>   A -> B -> D   D =3D (4, 3)  (index, lowlink)
>   ^    |    |   C =3D (3, 1)
>   |    V    |   B =3D (2, 1)
>   `--- C <--'   A =3D (1, 1)
>=20
> This is because the lowlink of D is updated with the index of C.
>=20
> In the following patch, we detect a dead SCC by checking two
> conditions for each vertex.
>=20
>   1) vertex has no edge directed to another SCC (no bridge)
>   2) vertex's out_degree is the same as the refcount of its file
>=20
> If 1) is false, there is a receiver of all fds of the SCC and
> its ancestor SCC.
>=20
> To evaluate 1), we need to assign a unique index to each SCC and
> assign it to all vertices in the SCC.
>=20
> This patch changes the lowlink update logic for cross-edge so
> that in the example above, the lowlink of D is updated with the
> lowlink of C.
>=20
>   A -> B -> D   D =3D (4, 1)  (index, lowlink)
>   ^    |    |   C =3D (3, 1)
>   |    V    |   B =3D (2, 1)
>   `--- C <--'   A =3D (1, 1)
>=20
> Then, all vertices in the same SCC have the same lowlink, and we
> can quickly find the bridge connecting to different SCC if exists.
>=20
> However, it is no longer called lowlink, so we rename it to
> scc_index.  (It's sometimes called lowpoint.)
>=20
> Also, we add a global variable to hold the last index used in DFS
> so that we do not reset the initial index in each DFS.
>=20
> This patch can be squashed to the SCC detection patch but is
> split deliberately for anyone wondering why lowlink is not used
> as used in the original Tarjan's algorithm and many reference
> implementations.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/af_unix.h |  2 +-
>  net/unix/garbage.c    | 15 ++++++++-------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index ec040caaa4b5..696d997a5ac9 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -36,7 +36,7 @@ struct unix_vertex {
>  	struct list_head scc_entry;
>  	unsigned long out_degree;
>  	unsigned long index;
> -	unsigned long lowlink;
> +	unsigned long scc_index;
>  };
> =20
>  struct unix_edge {
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 1d9a0498dec5..0eb1610c96d7 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -308,18 +308,18 @@ static bool unix_scc_cyclic(struct list_head *scc)
> =20
>  static LIST_HEAD(unix_visited_vertices);
>  static unsigned long unix_vertex_grouped_index =3D UNIX_VERTEX_INDEX_MAR=
K2;
> +static unsigned long unix_vertex_last_index =3D UNIX_VERTEX_INDEX_START;
> =20
>  static void __unix_walk_scc(struct unix_vertex *vertex)
>  {
> -	unsigned long index =3D UNIX_VERTEX_INDEX_START;
>  	LIST_HEAD(vertex_stack);
>  	struct unix_edge *edge;
>  	LIST_HEAD(edge_stack);
> =20
>  next_vertex:
> -	vertex->index =3D index;
> -	vertex->lowlink =3D index;
> -	index++;
> +	vertex->index =3D unix_vertex_last_index;
> +	vertex->scc_index =3D unix_vertex_last_index;
> +	unix_vertex_last_index++;
> =20
>  	list_add(&vertex->scc_entry, &vertex_stack);
> =20
> @@ -342,13 +342,13 @@ static void __unix_walk_scc(struct unix_vertex *ver=
tex)
> =20
>  			vertex =3D edge->predecessor->vertex;
> =20
> -			vertex->lowlink =3D min(vertex->lowlink, next_vertex->lowlink);
> +			vertex->scc_index =3D min(vertex->scc_index, next_vertex->scc_index);
>  		} else if (next_vertex->index !=3D unix_vertex_grouped_index) {
> -			vertex->lowlink =3D min(vertex->lowlink, next_vertex->index);
> +			vertex->scc_index =3D min(vertex->scc_index, next_vertex->scc_index);

I guess the above will break when unix_vertex_last_index wraps around,
or am I low on coffee? (I guess there is not such a thing as enough
coffee to allow me reviewing this whole series at once ;)

Can we expect a wrap around in host with (surprisingly very) long
uptimes?=20

Thanks,

Paolo


