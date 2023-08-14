Return-Path: <netdev+bounces-27448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE977C067
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65A92811FF
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9A6CA66;
	Mon, 14 Aug 2023 19:11:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD77C2CE
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3087DC433C9;
	Mon, 14 Aug 2023 19:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692040270;
	bh=SKT9AcALWyy63u4qVauRO5pzUnSm/sXbOePBOf6TjoY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LCgb6Cnf+prC8blAbTgElCbyFUWLVZTEvIGHG7A2phGLMApQ0OzRpjQ40kCn1BeHC
	 28NtqSbakhlxyLDpiCZkK35dvaTi4Wk5VpxzuGESMSM4fo6VeExkaeuf0HRNKf8uhr
	 EfQrSeDFMGydlPbSvjHqbOH240zwdR7JP9Y1H9a25D4tt73Ws+82OAWWeCd5Z0mW3O
	 1rdC41y3wWgzP90WLWHs9S2cdplXshzYfNVA6wVcV2jJiTyzIQOpPJ7YEQdGvuzWSo
	 Ukzy2lqIk+BNk7H9TjI/11IEFPyFe0CF6/pISNrQPLV2Grw+G3XJJqMhznpKi97cbH
	 TMotDBrCBDLeg==
Message-ID: <f3bca29ab509069b8fe947672eb19bc1926a97ab.camel@kernel.org>
Subject: Re: [PATCH v2] sunrpc: set the bv_offset of first bvec in
 svc_tcp_sendmsg
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: David Howells <dhowells@redhat.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Neil
 Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-nfs@vger.kernel.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 14 Aug 2023 15:11:07 -0400
In-Reply-To: <ZNp5nzfLGij7O5/k@tissot.1015granger.net>
References: <20230814-sendpage-v2-1-f56d1a25926c@kernel.org>
	 <ZNp5nzfLGij7O5/k@tissot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-08-14 at 14:59 -0400, Chuck Lever wrote:
> On Mon, Aug 14, 2023 at 01:36:54PM -0400, Jeff Layton wrote:
> > svc_tcp_sendmsg used to factor in the xdr->page_base when sending pages=
,
> > but 5df5dd03a8f7 dropped that part of the handling. Fix it by setting
> > the bv_offset of the first bvec.
> >=20
> > Fixes: 5df5dd03a8f7 ("sunrpc: Use sendmsg(MSG_SPLICE_PAGES) rather then=
 sendpage")
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> LGTM. However, nfsd-fixes does not have 5df5dd03a8f7 because the
> previous nfsd-next was merged into v6.5 before David's
> MSG_SPLICE_PAGES work was merged.
>=20
> Unless someone has a better suggestion, I'll rebase nfsd-fixes to
> v6.5-r6 and apply this fix to send to Linus.
>=20

ACK. That's probably safer than trying to pull in the big rework at the
last minute.


>=20
> > ---
> > Changes in v2:
> > - limit the change to just svc_tcp_sendmsg
> > ---
> >  net/sunrpc/svcsock.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > index e43f26382411..2eb8df44f894 100644
> > --- a/net/sunrpc/svcsock.c
> > +++ b/net/sunrpc/svcsock.c
> > @@ -1244,6 +1244,9 @@ static int svc_tcp_sendmsg(struct socket *sock, s=
truct xdr_buf *xdr,
> >  	if (ret !=3D head->iov_len)
> >  		goto out;
> > =20
> > +	if (xdr_buf_pagecount(xdr))
> > +		xdr->bvec[0].bv_offset =3D offset_in_page(xdr->page_base);
> > +
> >  	msg.msg_flags =3D MSG_SPLICE_PAGES;
> >  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,
> >  		      xdr_buf_pagecount(xdr), xdr->page_len);
> >=20
> > ---
> > base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
> > change-id: 20230814-sendpage-b04874eed249
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

