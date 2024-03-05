Return-Path: <netdev+bounces-77396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB81D871884
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E9A1C212F7
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF02450246;
	Tue,  5 Mar 2024 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAZmGo/0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB30524C9
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628433; cv=none; b=TR20ZLgkRypaCa9cbCK9uG2SLJWJc4F8oCfxPVI792XmchSahCDodGS8WqnTeSdUyXiZTi8jnocZsEjwABQKxfe70QFR+uAS6hAjtxKWK3gMecZKyu6DLQiF/TvtCFpJYbGQN9FlODeRkT1K4TBMgJ6xINjMtVahqk4vY8oLthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628433; c=relaxed/simple;
	bh=Rd13VgYq4yvk30Jxv/2UhSYr2Hn+bzLDx0fsNxyMBys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qg+aqbym0u7GQZarTl5/gnEK0q7nFEjTgAfz2q4tIXJzpdKBgiWaXBPBDA1RUEtK93oUP/L+/+rq1elvAOiUfZgq/NhNqyFQnqeE6kglPltSEiA6TY7GgvdL+vJuOvw8vNol+NM61v6x4858LmSePJA5UyCD+099pZfEAgO24E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAZmGo/0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709628430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C+s6eTekLqXp29PokzbOBziXZM7CR+L/CD4ukqEvGUc=;
	b=cAZmGo/0Z21lHXRoQ9xx8vWJ2wip4INV2Ui1ttfH5TJCXgyvWdOJPb/w0jw1wYRFe15xmq
	7Y0Ue2UdpBb9TYXn/ohBEo4Jq0MmcThEshBS1vzK/a7NIjgBw8AUnFP83xsfyRiSx4Ugqn
	nhq8HF6acU4kJNYc6ntPbRdUNrquwbY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-scs1b6JZOHm3S3mD93bEaA-1; Tue, 05 Mar 2024 03:47:09 -0500
X-MC-Unique: scs1b6JZOHm3S3mD93bEaA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412e83f6349so1004135e9.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 00:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628426; x=1710233226;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+s6eTekLqXp29PokzbOBziXZM7CR+L/CD4ukqEvGUc=;
        b=WM2TQnPSBVWlMXGJF734Ew/ya2DKg6YtaIhjmxnxth/kZarJGYIJDXOTig6KhjOyZz
         l6o7O6aI/85qys9QbFikN1ah5nziV1W++5+tHQlOLnTXSoiDuVYmfryo8jIeTD201UJt
         Pxn9If3cllF9lFLX0QqCnxlC6fPChkPGvgEimBaA7w9s5KZDiCy5XlnaHgwkGP0bJUrt
         G7bIgeogLtPYIQ9FT8dFiNc26YVGMd8uUAgfRm6vUjfqCL/4gKVKsGpKGFE5/Ylb2WiZ
         fJPcYEml1MXoyxXCVoJvqV67w7jNn6on95AL/XsWp4xWDja9axBXGS18LFkx2zXHkEJq
         8SBw==
X-Forwarded-Encrypted: i=1; AJvYcCUj1KeJXTcWWXF2vHz34AkuvGc/scJqzCqYvbEHtzJBq6wItnkH5Cc7NFHiC+PdjMj3JLRIru17mSUtl/LZg4GODqVwd5Q2
X-Gm-Message-State: AOJu0YwEmmKhR/AnQWLycQ95lqhc7/WZMQ9SPnZxY8Zk6eEKQ7IMCTHW
	UBEyLVGbmsGP9nHPuT1b3p/4nbelhrBDw8IyIj8UPPpKa/NElki52Jukbuxaa2KZGpOXI7b8QGD
	tvvan5HPV51roG6Um7Tr1rb22T1LFbHL2hCCz6vEIfwiSkjUnG+2xCNLNbJx4/g==
X-Received: by 2002:a05:600c:3b99:b0:412:eb6e:2171 with SMTP id n25-20020a05600c3b9900b00412eb6e2171mr1031026wms.1.1709628426293;
        Tue, 05 Mar 2024 00:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYe+u/5iA0UupaOG0q1WuZrIjK2VdcCPZ+/7AEGBoanmTy7QKyaT/ttkh6WpzHlrGa7O8U6w==
X-Received: by 2002:a05:600c:3b99:b0:412:eb6e:2171 with SMTP id n25-20020a05600c3b9900b00412eb6e2171mr1031014wms.1.1709628425789;
        Tue, 05 Mar 2024 00:47:05 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id fl25-20020a05600c0b9900b00412ee8bca00sm706984wmb.0.2024.03.05.00.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:47:05 -0800 (PST)
Message-ID: <344810ddca4b0baa9d6844c5100ff091dcda50aa.camel@redhat.com>
Subject: Re: [PATCH v4 net-next 02/15] af_unix: Allocate struct unix_edge
 for each inflight AF_UNIX fd.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Tue, 05 Mar 2024 09:47:04 +0100
In-Reply-To: <20240301022243.73908-3-kuniyu@amazon.com>
References: <20240301022243.73908-1-kuniyu@amazon.com>
	 <20240301022243.73908-3-kuniyu@amazon.com>
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
> As with the previous patch, we preallocate to skb's scm_fp_list an
> array of struct unix_edge in the number of inflight AF_UNIX fds.
>=20
> There we just preallocate memory and do not use immediately because
> sendmsg() could fail after this point.  The actual use will be in
> the next patch.
>=20
> When we queue skb with inflight edges, we will set the inflight
> socket's unix_sock as unix_edge->predecessor and the receiver's
> unix_sock as successor, and then we will link the edge to the
> inflight socket's unix_vertex.edges.
>=20
> Note that we set NULL to cloned scm_fp_list.edges in scm_fp_dup()
> so that MSG_PEEK does not change the shape of the directed graph.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/af_unix.h | 6 ++++++
>  include/net/scm.h     | 5 +++++
>  net/core/scm.c        | 2 ++
>  net/unix/garbage.c    | 6 ++++++
>  4 files changed, 19 insertions(+)
>=20
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index c270877a5256..55c4abc26a71 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -33,6 +33,12 @@ struct unix_vertex {
>  	unsigned long out_degree;
>  };
> =20
> +struct unix_edge {
> +	struct unix_sock *predecessor;
> +	struct unix_sock *successor;
> +	struct list_head vertex_entry;
> +};
> +
>  struct sock *unix_peer_get(struct sock *sk);
> =20
>  #define UNIX_HASH_MOD	(256 - 1)
> diff --git a/include/net/scm.h b/include/net/scm.h
> index e34321b6e204..5f5154e5096d 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -23,12 +23,17 @@ struct scm_creds {
>  	kgid_t	gid;
>  };
> =20
> +#ifdef CONFIG_UNIX
> +struct unix_edge;
> +#endif
> +
>  struct scm_fp_list {
>  	short			count;
>  	short			count_unix;
>  	short			max;
>  #ifdef CONFIG_UNIX
>  	struct list_head	vertices;
> +	struct unix_edge	*edges;
>  #endif
>  	struct user_struct	*user;
>  	struct file		*fp[SCM_MAX_FD];
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 87dfec1c3378..1bcc8a2d65e3 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -90,6 +90,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm=
_fp_list **fplp)
>  		fpl->max =3D SCM_MAX_FD;
>  		fpl->user =3D NULL;
>  #if IS_ENABLED(CONFIG_UNIX)
> +		fpl->edges =3D NULL;
>  		INIT_LIST_HEAD(&fpl->vertices);
>  #endif
>  	}
> @@ -383,6 +384,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fp=
l)
>  		new_fpl->max =3D new_fpl->count;
>  		new_fpl->user =3D get_uid(fpl->user);
>  #if IS_ENABLED(CONFIG_UNIX)
> +		new_fpl->edges =3D NULL;
>  		INIT_LIST_HEAD(&new_fpl->vertices);
>  #endif
>  	}
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 75bdf66b81df..f31917683288 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -127,6 +127,11 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
>  		list_add(&vertex->entry, &fpl->vertices);
>  	}
> =20
> +	fpl->edges =3D kvmalloc_array(fpl->count_unix, sizeof(*fpl->edges),
> +				    GFP_KERNEL_ACCOUNT);

If I read correctly, the total amount of additionally memory used will
be proportional to vertices num + edges num. Can you please provide a
the real figures for some reasonable unix fd numbers (say a small
table), to verify this memory usage is reasonable?

Thanks,

Paolo


