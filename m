Return-Path: <netdev+bounces-71277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC40852E5A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DFF1F25625
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A7D249F5;
	Tue, 13 Feb 2024 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+yfpXxz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66828DCF
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821363; cv=none; b=bfrjKoZuPBFb6/EdxJ5YSGABKBLi2s2VOAdI2Ft05p5X5aEzGGU1FwChOKfAhWBfWDECo7LEmjXgkCo38vupXzxXPDsUT92NmiPNtHLymEsI5ws4JebhWMvtNiTYJsG8zLQbKAD2BUgjE51jl4UV3v7YubUyxyiF/hE1ADRkMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821363; c=relaxed/simple;
	bh=viBiqnGMvWBSllJgcAwM2UN6NCusAHk3gFlPeklQePM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hTSvqVG/pgYkkuaEJ/CRFvn4NVidgQOxPWjVl5hkTpI1fP2/7l8tSIZIf3hgGo+gOYOztQJv41sEDyPHZIKbZPLlHh/CCzsHBvM0i6XhBq3gAjsVj+2PdzFjztPsdc0Z+8yU5l8A2Da3C/eWUTCYDSLJZpyqA4S8UhaFO2IyDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+yfpXxz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707821360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PHTArUk6XpMKcL8ZD8BS06xlBF/cz/SP1cRis2fuhZo=;
	b=S+yfpXxzNKbFV2Uht0vbBfb/zOmDjKGVY3L4jD3VecLyj/xyuaKUMbCyCbdrvkFxMfNXox
	Wa2Iqsz9yZHm6VXnrILkAtHW0GATxUgt/jzFM7u+DMrXPaVJ8j41bhipkkNuVCGYvNFu6Z
	QJeYuhrKwEVKeT5tbvHQN4fyJdQjtGc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-NBq6v-b0Na-zkjUT8VbSLA-1; Tue, 13 Feb 2024 05:49:19 -0500
X-MC-Unique: NBq6v-b0Na-zkjUT8VbSLA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7830635331bso180233885a.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 02:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707821358; x=1708426158;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHTArUk6XpMKcL8ZD8BS06xlBF/cz/SP1cRis2fuhZo=;
        b=wSDEOLmpPgYfFiv4VMZ8wwE8DfOLtv3/HwKRmJ6Ge1fgIZfrIrzZXerX+mJ+mvK8pn
         IaELJWuoypUC+agS1QtK7Pdy+/xDXDFCGz3FMLnnPdg3FvWENIEOhY41jxEKTC9G98Ur
         1vVsXHeAujL9qKaalsxBx/288VFfwfQHl/8VAzcxWXJjPR4vq1HbpLWp5smErp+0B11F
         EAZBBdYXpDqSHtxEIJM1dwzo9uM9Nco7iBV9WsKgnYs7VnPALLN+vT6N4zp4nZ8YT8s2
         /fuZaZov1QV2Wljn5ew/qAGg3BmSsKu1HrsoiR5lecHoJXo/tbzEF00yIPEkMplmjZmC
         epxg==
X-Forwarded-Encrypted: i=1; AJvYcCUyY6YYLArmRurXa56Zo67ZcSWAxg0ZppQ8VSWmCpOKkiax/4Mx3+g+t7eYNJjL8wgcNXu3GyolcaITKwnZMo2z1QtHRfbP
X-Gm-Message-State: AOJu0Yz1J1WLQzpzb7om2LNRWvfWExSn8nChYrvbaxUcrd0lIC/RT7uu
	mpsVA+LAs953OKu1QBwFhsoQKgZ9e7+UBwFHleLLp84nZQVi1NtaTkmsdnZX9Brcg1gKZlC43ec
	bMCxrH3HsENyAfQ5kI6kzEjZHugmEVdwyi5oS5uhG/I7HRExMqMksgA==
X-Received: by 2002:ac8:7d01:0:b0:42d:a98a:649d with SMTP id g1-20020ac87d01000000b0042da98a649dmr2487256qtb.5.1707821358433;
        Tue, 13 Feb 2024 02:49:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA9YsBg7REjGAYCMPwYyty9ifQBawWLMMDbdEzyBYVmFlbPtD2SgMB/lX43MQSQZMFEcVKuQ==
X-Received: by 2002:ac8:7d01:0:b0:42d:a98a:649d with SMTP id g1-20020ac87d01000000b0042da98a649dmr2487243qtb.5.1707821358060;
        Tue, 13 Feb 2024 02:49:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1Omeq4O26M5KUfr+EVN3sw9XRMhIO6KZVrfHeoiIRqs8LD3o+DrwMi6P6eu6+0ID7RuLaJWb0Pz4hIUTJuJymXOVVNQK2wsfI1cNG3iCfcWEood9D21HYpg3W7y4jr3fOU/5QDARpSKPSDR1FYukETudNRUhODhRai2AMlgNKl0xn6vlsLJAz+Ic1QyLjs7p3UjT272BG5+OhlHRwu2POxB/iaMYwqLWhB0x2mmmr0xzkvuwAH4TsYlayiXkNQg==
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id y15-20020ac8524f000000b0042c11de41fasm1014356qtn.67.2024.02.13.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 02:49:17 -0800 (PST)
Message-ID: <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com,
 lvivier@redhat.com,  dgibson@redhat.com, jmaloy@redhat.com,
 netdev@vger.kernel.org, davem@davemloft.net
Date: Tue, 13 Feb 2024 11:49:14 +0100
In-Reply-To: <20240209221233.3150253-1-jmaloy@redhat.com>
References: <20240209221233.3150253-1-jmaloy@redhat.com>
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

Oops,=20

I just noticed Eric is missing from the recipients list, adding him
now.

On Fri, 2024-02-09 at 17:12 -0500, jmaloy@redhat.com wrote:
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
> [  5]   0.00-10.04  sec  12.9 GBytes  11.0 Gbits/sec  receiver
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
> jmaloy@freyr:~/passt$ perf report -q --symbol-filter=3Ddo_syscall_64 \
>                        -p ____sys_recvmsg -x --stdio -i  perf.data | head=
 -1
> 46.32%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sy=
s_recvmsg
>=20
> With offset support:
> ----------------------
> jmaloy@freyr:~/passt$ perf report -q --symbol-filter=3Ddo_syscall_64 \
>                        -p ____sys_recvmsg -x --stdio -i  perf.data | head=
 -1
> 28.12%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sy=
s_recvmsg
>=20
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
>=20
> ---
> v3: - Applied changes suggested by Stefano Brivio and Paolo Abeni
> ---
>  net/ipv4/af_inet.c |  1 +
>  net/ipv4/tcp.c     | 16 ++++++++++------
>  2 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 4e635dd3d3c8..5f0e5d10c416 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1071,6 +1071,7 @@ const struct proto_ops inet_stream_ops =3D {
>  #endif
>  	.splice_eof	   =3D inet_splice_eof,
>  	.splice_read	   =3D tcp_splice_read,
> +	.set_peek_off      =3D sk_set_peek_off,
>  	.read_sock	   =3D tcp_read_sock,
>  	.read_skb	   =3D tcp_read_skb,
>  	.sendmsg_locked    =3D tcp_sendmsg_locked,
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 7e2481b9eae1..1c8cab14a32c 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1415,8 +1415,6 @@ static int tcp_peek_sndq(struct sock *sk, struct ms=
ghdr *msg, int len)
>  	struct sk_buff *skb;
>  	int copied =3D 0, err =3D 0;
> =20
> -	/* XXX -- need to support SO_PEEK_OFF */
> -
>  	skb_rbtree_walk(skb, &sk->tcp_rtx_queue) {
>  		err =3D skb_copy_datagram_msg(skb, 0, msg, skb->len);
>  		if (err)
> @@ -2327,6 +2325,7 @@ static int tcp_recvmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t len,
>  	int target;		/* Read at least this many bytes */
>  	long timeo;
>  	struct sk_buff *skb, *last;
> +	u32 peek_offset =3D 0;
>  	u32 urg_hole =3D 0;
> =20
>  	err =3D -ENOTCONN;
> @@ -2360,7 +2359,8 @@ static int tcp_recvmsg_locked(struct sock *sk, stru=
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
> @@ -2463,11 +2463,11 @@ static int tcp_recvmsg_locked(struct sock *sk, st=
ruct msghdr *msg, size_t len,
>  		}
> =20
>  		if ((flags & MSG_PEEK) &&
> -		    (peek_seq - copied - urg_hole !=3D tp->copied_seq)) {
> +		    (peek_seq - peek_offset - copied - urg_hole !=3D tp->copied_seq)) =
{
>  			net_dbg_ratelimited("TCP(%s:%d): Application bug, race in MSG_PEEK\n"=
,
>  					    current->comm,
>  					    task_pid_nr(current));
> -			peek_seq =3D tp->copied_seq;
> +			peek_seq =3D tp->copied_seq + peek_offset;
>  		}
>  		continue;
> =20
> @@ -2508,7 +2508,10 @@ static int tcp_recvmsg_locked(struct sock *sk, str=
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
> @@ -3007,6 +3010,7 @@ int tcp_disconnect(struct sock *sk, int flags)
>  	__skb_queue_purge(&sk->sk_receive_queue);
>  	WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
>  	WRITE_ONCE(tp->urg_data, 0);
> +	sk_set_peek_off(sk, -1);
>  	tcp_write_queue_purge(sk);
>  	tcp_fastopen_active_disable_ofo_check(sk);
>  	skb_rbtree_purge(&tp->out_of_order_queue);


