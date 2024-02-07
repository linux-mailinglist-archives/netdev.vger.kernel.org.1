Return-Path: <netdev+bounces-69698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20FE84C440
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 06:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79884287B9D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 05:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DCA12E6A;
	Wed,  7 Feb 2024 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="c3sL7p35"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFD1CD22
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 04:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281989; cv=none; b=RXGAt3gKBWEIxgWd+SAsjD8QALGtS48w2xbmKQZJFMzrpP85+VJRiSX2Fembv8iDhJK6rA0h33BeWzPwFaiPNz2UONQTS0SUdmhiIYSEyiqwPt4DlnYmrOE7Ipho33Ctb1wN5O7ZroIAY6qs1o+AqvPfvnF65qOcu6UON4yE8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281989; c=relaxed/simple;
	bh=EVfsAPvWaw07EZ7en96OWWuERQKkYofKi4LupJlrdlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exbTlbuoJ3BeceAJX3aY28mmayX7vq5aG1nJst+o4f1pDL45gGB6/y3/xKq5lS3n7Lds49cu8rLnmZ4L2lLglaerZxBDlqUqH29Dw3mNH5oNbu7+mM9lYjvS5PFh+XmwZHAMjCL3CAhFItLS8lFXzzSDm+30bTuf5sftYjaMNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=c3sL7p35; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202312; t=1707281984;
	bh=JhGXRvBOqRUhEZZqF33CNwPgaXFii52hS4dt8SSOVxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3sL7p357Dv3/nrFUeviz9i2DG4DXcrjfz3Q7mDnb6qLifWNQgEgRYNbfIokxmk12
	 Tqpw2CRdceKZfNY+tDrx8F6Pxz4YSBASLSZhc0Yk556rsePlHD/1vSDxLhAhEFtGCJ
	 16YYxk3jffa5hxIdXgQzABsRq7w3Q/sCHWWIBpNwfpULAGgqcG55aeU1VgFbmEJGZB
	 bS8VG4y90PloRvgYWlATO9mUtAJPDhXl6XlBEwkw0LrRjKuKZm0h/zQYeEALo3rCqQ
	 W61XL/WP3WykPxcQHdsZVI8dDUDcV7c2RfLV6vvEpgriQz0tCc+2Rm8Fynk+P3BVvD
	 VnU2d/qRXf59Q==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4TV7Fr6XSHz4wqM; Wed,  7 Feb 2024 15:59:44 +1100 (AEDT)
Date: Wed, 7 Feb 2024 15:39:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com,
	dgibson@redhat.com
Subject: Re: [RFC net-next] tcp: add support for SO_PEEK_OFF
Message-ID: <ZcMJnVuJwr13bZmB@zatzit>
References: <20240201213201.1228681-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0pEo8qzJEVM5/HPv"
Content-Disposition: inline
In-Reply-To: <20240201213201.1228681-1-jmaloy@redhat.com>


--0pEo8qzJEVM5/HPv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 04:32:01PM -0500, jmaloy@redhat.com wrote:
> From: Jon Maloy <jmaloy@redhat.com>
>=20
> When reading received messages from a socket with MSG_PEEK, we may want
> to read the contents with an offset, like we can do with pread/preadv()
> when reading files. Currently, it is not possible to do that.
>=20
> In this commit, we add support for the SO_PEEK_OFF socket option for TCP,
> in a similar way it is done for Unix Domain sockets.
>=20
> In the iperf3 log examples shown below, we can observe a throughput
> improvement of 15-20 % in the direction host->namespace when using the
> protocol splicer 'pasta' (https://passt.top).
> This is a consistent result.
>=20
> pasta(1) and passt(1) implement user-mode networking for network
> namespaces (containers) and virtual machines by means of a translation
> layer between Layer-2 network interface and native Layer-4 sockets
> (TCP, UDP, ICMP/ICMPv6 echo).
>=20
> Received, pending TCP data to the container/guest is kept in kernel
> buffers until acknowledged, so the tool routinely needs to fetch new
> data from socket, skipping data that was already sent.
>=20
> At the moment this is implemented using a dummy buffer passed to
> recvmsg(). With this change, we don't need a dummy buffer and the
> related buffer copy (copy_to_user()) anymore.
>=20
> passt and pasta are supported in KubeVirt and libvirt/qemu.
>=20
> jmaloy@freyr:~/passt$ perf record -g ./pasta --config-net -f
> SO_PEEK_OFF not supported by kernel.
>=20
> jmaloy@freyr:~/passt# iperf3 -s
> -----------------------------------------------------------
> Server listening on 5201 (test #1)
> -----------------------------------------------------------
> Accepted connection from 192.168.122.1, port 44822
> [  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 448=
32
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  1.02 GBytes  8.78 Gbits/sec
> [  5]   1.00-2.00   sec  1.06 GBytes  9.08 Gbits/sec
> [  5]   2.00-3.00   sec  1.07 GBytes  9.15 Gbits/sec
> [  5]   3.00-4.00   sec  1.10 GBytes  9.46 Gbits/sec
> [  5]   4.00-5.00   sec  1.03 GBytes  8.85 Gbits/sec
> [  5]   5.00-6.00   sec  1.10 GBytes  9.44 Gbits/sec
> [  5]   6.00-7.00   sec  1.11 GBytes  9.56 Gbits/sec
> [  5]   7.00-8.00   sec  1.07 GBytes  9.20 Gbits/sec
> [  5]   8.00-9.00   sec   667 MBytes  5.59 Gbits/sec
> [  5]   9.00-10.00  sec  1.03 GBytes  8.83 Gbits/sec
> [  5]  10.00-10.04  sec  30.1 MBytes  6.36 Gbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.04  sec  10.3 GBytes  8.78 Gbits/sec   receiver
> -----------------------------------------------------------
> Server listening on 5201 (test #2)
> -----------------------------------------------------------
> ^Ciperf3: interrupt - the server has terminated
> jmaloy@freyr:~/passt#
> logout
> [ perf record: Woken up 23 times to write data ]
> [ perf record: Captured and wrote 5.696 MB perf.data (35580 samples) ]
> jmaloy@freyr:~/passt$
>=20
> jmaloy@freyr:~/passt$ perf record -g ./pasta --config-net -f
> SO_PEEK_OFF supported by kernel.
>=20
> jmaloy@freyr:~/passt# iperf3 -s
> -----------------------------------------------------------
> Server listening on 5201 (test #1)
> -----------------------------------------------------------
> Accepted connection from 192.168.122.1, port 52084
> [  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 520=
98
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  1.32 GBytes  11.3 Gbits/sec
> [  5]   1.00-2.00   sec  1.19 GBytes  10.2 Gbits/sec
> [  5]   2.00-3.00   sec  1.26 GBytes  10.8 Gbits/sec
> [  5]   3.00-4.00   sec  1.36 GBytes  11.7 Gbits/sec
> [  5]   4.00-5.00   sec  1.33 GBytes  11.4 Gbits/sec
> [  5]   5.00-6.00   sec  1.21 GBytes  10.4 Gbits/sec
> [  5]   6.00-7.00   sec  1.31 GBytes  11.2 Gbits/sec
> [  5]   7.00-8.00   sec  1.25 GBytes  10.7 Gbits/sec
> [  5]   8.00-9.00   sec  1.33 GBytes  11.5 Gbits/sec
> [  5]   9.00-10.00  sec  1.24 GBytes  10.7 Gbits/sec
> [  5]  10.00-10.04  sec  56.0 MBytes  12.1 Gbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.04  sec  12.9 GBytes  11.0 Gbits/sec                  rec=
eiver
> -----------------------------------------------------------
> Server listening on 5201 (test #2)
> -----------------------------------------------------------
> ^Ciperf3: interrupt - the server has terminated
> logout
> [ perf record: Woken up 20 times to write data ]
> [ perf record: Captured and wrote 5.040 MB perf.data (33411 samples) ]
> jmaloy@freyr:~/passt$
>=20
> The perf record confirms this result. Below, we can observe that the
> CPU spends significantly less time in the function ____sys_recvmsg()
> when we have offset support.
>=20
> Without offset support:
> ----------------------
> jmaloy@freyr:~/passt$ perf report -q --symbol-filter=3Ddo_syscall_64 -p _=
___sys_recvmsg -x --stdio -i  perf.data | head -1
>     46.32%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  __=
__sys_recvmsg
>=20
> With offset support:
> ----------------------
> jmaloy@freyr:~/passt$ perf report -q --symbol-filter=3Ddo_syscall_64 -p _=
___sys_recvmsg -x --stdio -i  perf.data | head -1
>    28.12%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ___=
_sys_recvmsg
>=20
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Apart from one trivial nit noted below,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/net/tcp.h  |  1 +
>  net/ipv4/af_inet.c |  1 +
>  net/ipv4/tcp.c     | 25 +++++++++++++++++++------
>  3 files changed, 21 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 87f0e6c2e1f2..7eca7f2ac102 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -357,6 +357,7 @@ void tcp_twsk_purge(struct list_head *net_exit_list, =
int family);
>  ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
>  			struct pipe_inode_info *pipe, size_t len,
>  			unsigned int flags);
> +int tcp_set_peek_offset(struct sock *sk, int val);
>  struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
>  				     bool force_schedule);
> =20
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index fb81de10d332..7a8b3a91257f 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1068,6 +1068,7 @@ const struct proto_ops inet_stream_ops =3D {
>  #endif
>  	.splice_eof	   =3D inet_splice_eof,
>  	.splice_read	   =3D tcp_splice_read,
> +	.set_peek_off      =3D tcp_set_peek_offset,
>  	.read_sock	   =3D tcp_read_sock,
>  	.read_skb	   =3D tcp_read_skb,
>  	.sendmsg_locked    =3D tcp_sendmsg_locked,
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index fce5668a6a3d..33ade88633de 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -863,6 +863,14 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t =
*ppos,
>  }
>  EXPORT_SYMBOL(tcp_splice_read);
> =20
> +int tcp_set_peek_offset(struct sock *sk, int val)
> +{
> +	WRITE_ONCE(sk->sk_peek_off, val);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(tcp_set_peek_offset);
> +
>  struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
>  				     bool force_schedule)
>  {
> @@ -2302,7 +2310,6 @@ static int tcp_inq_hint(struct sock *sk)
>   *	tricks with *seq access order and skb->users are not required.
>   *	Probably, code can be easily improved even more.
>   */
> -

Extraneous whitespace change here.

>  static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_=
t len,
>  			      int flags, struct scm_timestamping_internal *tss,
>  			      int *cmsg_flags)
> @@ -2317,6 +2324,7 @@ static int tcp_recvmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t len,
>  	long timeo;
>  	struct sk_buff *skb, *last;
>  	u32 urg_hole =3D 0;
> +	u32 peek_offset =3D 0;
> =20
>  	err =3D -ENOTCONN;
>  	if (sk->sk_state =3D=3D TCP_LISTEN)
> @@ -2349,7 +2357,8 @@ static int tcp_recvmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t len,
> =20
>  	seq =3D &tp->copied_seq;
>  	if (flags & MSG_PEEK) {
> -		peek_seq =3D tp->copied_seq;
> +		peek_offset =3D max(sk_peek_offset(sk, flags), 0);
> +		peek_seq =3D tp->copied_seq + peek_offset;
>  		seq =3D &peek_seq;
>  	}
> =20
> @@ -2452,11 +2461,11 @@ static int tcp_recvmsg_locked(struct sock *sk, st=
ruct msghdr *msg, size_t len,
>  		}
> =20
>  		if ((flags & MSG_PEEK) &&
> -		    (peek_seq - copied - urg_hole !=3D tp->copied_seq)) {
> +		    (peek_seq - peek_offset - copied - urg_hole !=3D tp->copied_seq)) {
>  			net_dbg_ratelimited("TCP(%s:%d): Application bug, race in MSG_PEEK\n",
>  					    current->comm,
>  					    task_pid_nr(current));
> -			peek_seq =3D tp->copied_seq;
> +			peek_seq =3D tp->copied_seq + peek_offset;
>  		}
>  		continue;
> =20
> @@ -2497,7 +2506,10 @@ static int tcp_recvmsg_locked(struct sock *sk, str=
uct msghdr *msg, size_t len,
>  		WRITE_ONCE(*seq, *seq + used);
>  		copied +=3D used;
>  		len -=3D used;
> -
> +		if (flags & MSG_PEEK)
> +			sk_peek_offset_fwd(sk, used);
> +		else
> +			sk_peek_offset_bwd(sk, used);
>  		tcp_rcv_space_adjust(sk);
> =20
>  skip_copy:
> @@ -2774,6 +2786,7 @@ void __tcp_close(struct sock *sk, long timeout)
>  		data_was_unread +=3D len;
>  		__kfree_skb(skb);
>  	}
> +	sk_set_peek_off(sk, -1);
> =20
>  	/* If socket has been already reset (e.g. in tcp_reset()) - kill it. */
>  	if (sk->sk_state =3D=3D TCP_CLOSE)
> @@ -4492,7 +4505,7 @@ void tcp_done(struct sock *sk)
>  		reqsk_fastopen_remove(sk, req, false);
> =20
>  	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
> -
> +	sk_set_peek_off(sk, -1);
>  	if (!sock_flag(sk, SOCK_DEAD))
>  		sk->sk_state_change(sk);
>  	else

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0pEo8qzJEVM5/HPv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmXDCZwACgkQzQJF27ox
2Gd4yA/+OVXJu1N4N6gETLBi8e7R/8jgflQIL+fnEU1kbig7bF/YBpdo/ATVso8u
gxO76Q/Kkc8GOYONibZVYd+2/XkcZd3us3dmB4ZxZUo8viirkpY4iWC7tj8QsEfe
3IHvAzo3ZSn8PwBP+Rk5dZqXMmoj0DJXtXlfZ163c+yZcRaWiLf7DAuL1CKPRZNb
Cpv/1Ctq2U/XWq+8PAZHWgTFhH0V4L3ts1QANgya363CFaGT9x99de3sQl4Ahy4x
/hIqgIiDYQ2VGwcaZfpAQ/EMCnu6rdkzkmb9nUTaivCta2dZiq9VgELSlc3x8X7E
PRWa9Jp9vaEsQk66QmrSksESCl5V0/zR573fHAR/u/dRM0gATgXYwQwq8WzMK8cj
U28s7REcb5qubjLSi4clqUgLxzn6hAqX5QGH2Ryt8F7qzW9UX6Sh8w0+5kU+v88X
NuzHCFaSrEml4RTNjTCYTte8ElJb+yytF2BStrefjtgyYVeNGCGl5mdg1jvSoGbl
rVXeCEekxHhqqaA7+R1yLUWJcFhjn6Djce7Uq1nX6ow2m7YmDDhcKhpW+VP1kDg0
jjSGE3k25kjAGcME4oyOPlXIF4YnwxtiX0ne6MV49J0Z/sHHWK+KWRsfa7jqjG/X
vmzR8V6frVaet0L001jVoGpCa+LyddpGTikLd28ykmlHJgmyEtc=
=pv8c
-----END PGP SIGNATURE-----

--0pEo8qzJEVM5/HPv--

