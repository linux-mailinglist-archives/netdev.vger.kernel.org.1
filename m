Return-Path: <netdev+bounces-75279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8467868EC0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE54289DA7
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EC013958A;
	Tue, 27 Feb 2024 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsqId4qN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65784139583
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033164; cv=none; b=UK4TxvKgkIMXDef+LMt7QimHfzXTVUYSwgnW6qiY7z11CUCVODFfQnRiW8FA3PBsSHoRAv47pBb1Cgarj8QvGxcJl6OhestzZLmlsIEmWVsdsh7qSO+ECamoTO+jR3ZD8jSXka7nCZ13Y8e6TURd31vPl3bk/Hul6TV3uMlloWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033164; c=relaxed/simple;
	bh=H8V0fbyxSIi5P8l6sN7YJ5lH5WKC18R8v23qpdCoGRs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRnK5nDIec1q4MLnn5tHTIG+xw/WMQtaF+EsCPbHSg1Oj0zI8JxeaNncw2+P4eil/f51NKFWPwU3GSWbPZvvgCT8YgZIUqtenMuYJqpMkNYXhK5kirVKkKhE0s19/bi4Aoevw7dkwQih6IeADspaEc6BpIFeJU+zV970CIxAUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsqId4qN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709033160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vmr8M+7Lci/cjuXmpceWAO77EBGfQ3NFBviIfN+X3ik=;
	b=MsqId4qNxNCP/6gE6urVdUKS/ra4wRB4WjyxlZrgp8NEomP/Inj0zGDTkHpRJH4YzHQd6L
	aAKen/55jb8FNh/vU8KN/6u8t+YZflPTpsHe9h/6ON0HC2LOVMg/Fn+il+rU71KKtLPOng
	ESCQ77K+fpkeofnfmBaVPAW1s32utQE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-klq-QRJGMo2RwmvFC0VE-A-1; Tue, 27 Feb 2024 06:25:59 -0500
X-MC-Unique: klq-QRJGMo2RwmvFC0VE-A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so9508935e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 03:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709033158; x=1709637958;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vmr8M+7Lci/cjuXmpceWAO77EBGfQ3NFBviIfN+X3ik=;
        b=JvIbiQh6kWOHtbHbOW8vl1n9LISr7d3gcIOwH4BOwMUuGjZq7KfMpz7ek+xtMWrG8w
         hLXvyILeAUNIglcmkLaIyz4ep/zGMNhKhNrQLP7fterwnaiq4kbqtHxu3lPNz58EJ+KC
         MUqhI9+Z2d76AfaAuUstGoM6pP3R58qEgmFYBOkJf7uQqrB8K5xBqQLwwXDxn/nlSIdk
         lCZfpyw/c57GXLkmjY632BGm0S7iD3lUUGAa2IjWY+nJsa1DeHqX1VqsZi+ibzq2xR5Y
         ffaYI8iInZxqkRhafYKizIWIwTI5Oo2FbKKKBNmgo+LCY17DQmHrcx4Nmj+hEQsRebAv
         WbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNZCLWf614Vq+utqY6aXkwyJFkz1ORCB6Jo3lloiYR0EyRYqxD0m/XY5yGF9Kh/y+lPYCg+RFWHsgsooZBrAlA4q5yEd1m
X-Gm-Message-State: AOJu0YwyO240pqfvNxdV5qCLtKKskEh70j6a4tTKdoPwfdwHRfAh35j5
	hyPYaPIjKLKocC9Ovqv540ryW0cwlsWvqyRS5x050D1c8qWUBjCfQHELcKHUoY21O/tG6C6xJ05
	4R31AbSHZemmBxFz4e3p1J2jr7SVyvbWRWFb/gLH+sM5ecvb57JzYjQ==
X-Received: by 2002:a05:600c:198e:b0:412:a2b1:66fa with SMTP id t14-20020a05600c198e00b00412a2b166famr4538212wmq.0.1709033158383;
        Tue, 27 Feb 2024 03:25:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE00ak0eX+8GgEdEB840YJpv86+ewl0GNRcdlsYJY4jr+XQFiF8004V3gh9LQSkjJ2h8sQr2A==
X-Received: by 2002:a05:600c:198e:b0:412:a2b1:66fa with SMTP id t14-20020a05600c198e00b00412a2b166famr4538198wmq.0.1709033158041;
        Tue, 27 Feb 2024 03:25:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-60.dyn.eolo.it. [146.241.245.60])
        by smtp.gmail.com with ESMTPSA id t19-20020a7bc3d3000000b00410dd253008sm14743005wmj.42.2024.02.27.03.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 03:25:57 -0800 (PST)
Message-ID: <3f629d0a45734914fbb64fdca80b44ff614aedb2.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 12/14] af_unix: Detect dead SCC.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Tue, 27 Feb 2024 12:25:56 +0100
In-Reply-To: <20240223214003.17369-13-kuniyu@amazon.com>
References: <20240223214003.17369-1-kuniyu@amazon.com>
	 <20240223214003.17369-13-kuniyu@amazon.com>
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
> When iterating SCC, we call unix_vertex_dead() for each vertex
> to check if the vertex is close()d and has no bridge to another
> SCC.
>=20
> If both conditions are true for every vertex in SCC, we can
> execute garbage collection for all skb in the SCC.
>=20
> The actual garbage collection is done in the following patch,
> replacing the old implementation.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/unix/garbage.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 0eb1610c96d7..060e81be3614 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -288,6 +288,32 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
>  	unix_free_vertices(fpl);
>  }
> =20
> +static bool unix_vertex_dead(struct unix_vertex *vertex)
> +{
> +	struct unix_edge *edge;
> +	struct unix_sock *u;
> +	long total_ref;
> +
> +	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
> +		struct unix_vertex *next_vertex =3D unix_edge_successor(edge);
> +
> +		if (!next_vertex)
> +			return false;
> +
> +		if (next_vertex->scc_index !=3D vertex->scc_index)
> +			return false;
> +	}
> +
> +	edge =3D list_first_entry(&vertex->edges, typeof(*edge), vertex_entry);
> +	u =3D edge->predecessor;
> +	total_ref =3D file_count(u->sk.sk_socket->file);
> +
> +	if (total_ref !=3D vertex->out_degree)
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool unix_scc_cyclic(struct list_head *scc)
>  {
>  	struct unix_vertex *vertex;
> @@ -350,6 +376,7 @@ static void __unix_walk_scc(struct unix_vertex *verte=
x)
> =20
>  	if (vertex->index =3D=3D vertex->scc_index) {
>  		struct list_head scc;
> +		bool dead =3D true;

Very minor nit: the above variable 'sounds' alike referring to the
current vertex, while instead it tracks a global status, what about
'all_dead' or 'gc_all'?

Thanks,

Paolo


