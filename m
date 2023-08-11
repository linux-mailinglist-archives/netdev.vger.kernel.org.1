Return-Path: <netdev+bounces-26965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D09779AD3
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DA31C20AB4
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B0134CCE;
	Fri, 11 Aug 2023 22:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFED2F4E
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 22:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB58AC433C8;
	Fri, 11 Aug 2023 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691794213;
	bh=k02u5dlw3yPXK+0T6pf00+UIRqTxEUsHTDDQW8+4BpM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EkXomq4EYP3brX2c1RiuwvfQyeNHIM6fA2Ddf6dQZ0zg4uvqyzm03zrFEA3bQrJU8
	 XwJ5qMahpl8ei8/YMDrSGRgWu7Rjoe43IvHGb75QG8Oa78TPGTLDqYqoqpoepd5TfB
	 0fIhUchFKQPw4fbbbC6l0jOgGdIOSuejq7HklleN7CsszJCyNx+hVSnqMeJ5RK601j
	 IZ3EWhWiyUbB19KDld1JfOQ+wWbfQwidzuNQnszJGIRW2mKLQS3DRUXuTqnS8G8KR5
	 iNjzl9c0zTf1oW9HK/T3sIGVrbJnEpVOezkrEdLKUsLY7RkVZYDIB7/iKyHrVIC6g4
	 Jm/8Ow02NWtEw==
Message-ID: <104f68073d00911668ed6ea38239ef5f1d15567d.camel@kernel.org>
Subject: Re: [PATCH net-next 3/6] sunrpc: Use sendmsg(MSG_SPLICE_PAGES)
 rather then sendpage
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, Trond
 Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
 <anna@kernel.org>,  linux-nfs@vger.kernel.org
Date: Fri, 11 Aug 2023 18:50:10 -0400
In-Reply-To: <20230609100221.2620633-4-dhowells@redhat.com>
References: <20230609100221.2620633-1-dhowells@redhat.com>
	 <20230609100221.2620633-4-dhowells@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-06-09 at 11:02 +0100, David Howells wrote:
> When transmitting data, call down into TCP using sendmsg with
> MSG_SPLICE_PAGES to indicate that content should be spliced rather than
> performing sendpage calls to transmit header, data pages and trailer.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> cc: Anna Schumaker <anna@kernel.org>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-nfs@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>  include/linux/sunrpc/svc.h | 11 +++++------
>  net/sunrpc/svcsock.c       | 38 ++++++++++++--------------------------
>  2 files changed, 17 insertions(+), 32 deletions(-)
>=20

I'm seeing a regression in pynfs runs with v6.5-rc5. 3 tests are failing
in a similar fashion. WRT1b is one of them

[vagrant@jlayton-kdo-nfsd nfs4.0]$  ./testserver.py --rundeps --maketree --=
uid=3D0 --gid=3D0 localhost:/export/pynfs/4.0/ WRT1b                       =
                             =20
**************************************************                         =
                                                                           =
                         =20
WRT1b    st_write.testSimpleWrite2                                : FAILURE=
                                                                           =
                         =20
           READ returned                                                   =
                                                                           =
                         =20
           b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00',=
                                                                           =
                         =20
           expected b'\x00\x00\x00\x00\x00write data'                      =
                                                                           =
                         =20
INIT     st_setclientid.testValid                                 : PASS   =
                                                                           =
                         =20
MKFILE   st_open.testOpen                                         : PASS   =
                                                                           =
                         =20
**************************************************                         =
                                                                           =
                         =20
Command line asked for 3 of 679 tests                                      =
                                                                           =
                         =20
Of those: 0 Skipped, 1 Failed, 0 Warned, 2 Passed                          =
                        =20


This test just writes "write data" starting at offset 30 and then reads
the data back. It looks like we're seeing zeroes in the read reply where
the data should be.

A bisect landed on this patch, which I'm assuming is the same as this
commit in mainline:

    5df5dd03a8f7 sunrpc: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage

...any thoughts as to what might be wrong?

> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 762d7231e574..f66ec8fdb331 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -161,16 +161,15 @@ static inline bool svc_put_not_last(struct svc_serv=
 *serv)
>  extern u32 svc_max_payload(const struct svc_rqst *rqstp);
> =20
>  /*
> - * RPC Requsts and replies are stored in one or more pages.
> + * RPC Requests and replies are stored in one or more pages.
>   * We maintain an array of pages for each server thread.
>   * Requests are copied into these pages as they arrive.  Remaining
>   * pages are available to write the reply into.
>   *
> - * Pages are sent using ->sendpage so each server thread needs to
> - * allocate more to replace those used in sending.  To help keep track
> - * of these pages we have a receive list where all pages initialy live,
> - * and a send list where pages are moved to when there are to be part
> - * of a reply.
> + * Pages are sent using ->sendmsg with MSG_SPLICE_PAGES so each server t=
hread
> + * needs to allocate more to replace those used in sending.  To help kee=
p track
> + * of these pages we have a receive list where all pages initialy live, =
and a
> + * send list where pages are moved to when there are to be part of a rep=
ly.
>   *
>   * We use xdr_buf for holding responses as it fits well with NFS
>   * read responses (that have a header, and some data pages, and possibly
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index f77cebe2c071..9d9f522e3ae1 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1203,13 +1203,14 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqst=
p)
>  static int svc_tcp_send_kvec(struct socket *sock, const struct kvec *vec=
,
>  			      int flags)
>  {
> -	return kernel_sendpage(sock, virt_to_page(vec->iov_base),
> -			       offset_in_page(vec->iov_base),
> -			       vec->iov_len, flags);
> +	struct msghdr msg =3D { .msg_flags =3D MSG_SPLICE_PAGES | flags, };
> +
> +	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, vec, 1, vec->iov_len);
> +	return sock_sendmsg(sock, &msg);
>  }
> =20
>  /*
> - * kernel_sendpage() is used exclusively to reduce the number of
> + * MSG_SPLICE_PAGES is used exclusively to reduce the number of
>   * copy operations in this path. Therefore the caller must ensure
>   * that the pages backing @xdr are unchanging.
>   *
> @@ -1249,28 +1250,13 @@ static int svc_tcp_sendmsg(struct socket *sock, s=
truct xdr_buf *xdr,
>  	if (ret !=3D head->iov_len)
>  		goto out;
> =20
> -	if (xdr->page_len) {
> -		unsigned int offset, len, remaining;
> -		struct bio_vec *bvec;
> -
> -		bvec =3D xdr->bvec + (xdr->page_base >> PAGE_SHIFT);
> -		offset =3D offset_in_page(xdr->page_base);
> -		remaining =3D xdr->page_len;
> -		while (remaining > 0) {
> -			len =3D min(remaining, bvec->bv_len - offset);
> -			ret =3D kernel_sendpage(sock, bvec->bv_page,
> -					      bvec->bv_offset + offset,
> -					      len, 0);
> -			if (ret < 0)
> -				return ret;
> -			*sentp +=3D ret;
> -			if (ret !=3D len)
> -				goto out;
> -			remaining -=3D len;
> -			offset =3D 0;
> -			bvec++;
> -		}
> -	}
> +	msg.msg_flags =3D MSG_SPLICE_PAGES;
> +	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,
> +		      xdr_buf_pagecount(xdr), xdr->page_len);
> +	ret =3D sock_sendmsg(sock, &msg);
> +	if (ret < 0)
> +		return ret;
> +	*sentp +=3D ret;
> =20
>  	if (tail->iov_len) {
>  		ret =3D svc_tcp_send_kvec(sock, tail, 0);
>=20

--=20
Jeff Layton <jlayton@kernel.org>

