Return-Path: <netdev+bounces-63680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C483B82ECFD
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 11:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFFC1C23100
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB9C18EA6;
	Tue, 16 Jan 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="As1tiOIT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E4175A0
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705402157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HVRuidt3frhL0oDSHlkD6AyaJus1pFwG/YFvmhQe7R0=;
	b=As1tiOIT/5B3Ctk6tzM5mu9CzAILEIrLzQUlnglTlsxKFqX00ZM/a9lIV0OLyZbenoWxB1
	rdaFPK1Jkzrd4zODwy2TM+pNVo6d2W00LSLz28gZDnSwGMQpbIbpRI9Kuv+uD+RF2qyx7f
	WKr73TRovpqojDMId3uJnoBDnrAUg8c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-l5iG2LKeNUKeqXzwwpeDeg-1; Tue, 16 Jan 2024 05:49:16 -0500
X-MC-Unique: l5iG2LKeNUKeqXzwwpeDeg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78356ddf3cfso60037185a.1
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 02:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705402156; x=1706006956;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVRuidt3frhL0oDSHlkD6AyaJus1pFwG/YFvmhQe7R0=;
        b=iGxLPHHvbjl1i7njkfThc5/j8M+qTpIKaNGn5AJUaryK1s0ICvBa/H8YpcX6Sz5x9+
         9iUTeo+FyCibJGHVcG+fXyFe3yWXUhw4z+Z3aTd5LKig5baqq96iSMAMzKaICxFqmRTP
         U/dQA/lXjFw3gQ0f3Fe4jDrzLoDYQRtCztdSuoZxjlKDcCnH8VtuxM8emHMrFwxBRS9B
         XwwDPQ+4Vjao96E6JgXcKLj/u8M0z3SyhdwqmK9PBWZ/cRhQWB9UN4QxXc6g7NR1qPow
         t4geAf8T0K9ldXxzBehjhcfRv/0GCOQvfjvsyAheGaP/M3+dr3zvnHBSTKf+WvPLUjGY
         v1OA==
X-Gm-Message-State: AOJu0YxsQLmBAhZQMFj2nn7zhqwBwu5ZN+wHpcawPkgdaOocIZePLf9N
	WcTLz7dWt7FMdh5DxetJaObee3fOkpB8kPQCYKV+8HQMB9rkvTcwuNKHxccckdlT7LJN9YNqrjc
	9Q4ueWyzrjc/E4feUCsTIKZbb
X-Received: by 2002:a05:620a:261a:b0:783:573b:7377 with SMTP id z26-20020a05620a261a00b00783573b7377mr8840266qko.6.1705402155809;
        Tue, 16 Jan 2024 02:49:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmrAOAdPxNnm3m73RN6td2J622n5uPfVl0gKc8Qcu8dMapjUgjEnZS1BZyx90z4ovd0MocfA==
X-Received: by 2002:a05:620a:261a:b0:783:573b:7377 with SMTP id z26-20020a05620a261a00b00783573b7377mr8840253qko.6.1705402155438;
        Tue, 16 Jan 2024 02:49:15 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-126.dyn.eolo.it. [146.241.241.126])
        by smtp.gmail.com with ESMTPSA id d6-20020a37c406000000b007832b17f3eesm3630138qki.41.2024.01.16.02.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 02:49:14 -0800 (PST)
Message-ID: <df3045c3ec7a4b3c417699ff4950d3d977a0a944.camel@redhat.com>
Subject: Re: [RFC net-next] tcp: add support for read with offset when using
 MSG_PEEK
From: Paolo Abeni <pabeni@redhat.com>
To: jmaloy@redhat.com, netdev@vger.kernel.org, davem@davemloft.net
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com,
 lvivier@redhat.com,  dgibson@redhat.com
Date: Tue, 16 Jan 2024 11:49:12 +0100
In-Reply-To: <20240111230057.305672-1-jmaloy@redhat.com>
References: <20240111230057.305672-1-jmaloy@redhat.com>
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

On Thu, 2024-01-11 at 18:00 -0500, jmaloy@redhat.com wrote:
> From: Jon Maloy <jmaloy@redhat.com>
>=20
> When reading received messages from a socket with MSG_PEEK, we may want
> to read the contents with an offset, like we can do with pread/preadv()
> when reading files. Currently, it is not possible to do that.
>=20
> In this commit, we allow the user to set iovec.iov_base in the first
> vector entry to NULL. This tells the socket to skip the first entry,
> hence letting the iov_len field of that entry indicate the offset value.
> This way, there is no need to add any new arguments or flags.
>=20
> In the iperf3 log examples shown below, we can observe a throughput
> improvement of ~15 % in the direction host->namespace when using the
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
> MSG_PEEK with offset not supported by kernel.
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
> MSG_PEEK with offset supported by kernel.
>=20
> jmaloy@freyr:~/passt# iperf3 -s
> -----------------------------------------------------------
> Server listening on 5201 (test #1)
> -----------------------------------------------------------
> Accepted connection from 192.168.122.1, port 40854
> [  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 408=
62
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  1.22 GBytes  10.5 Gbits/sec
> [  5]   1.00-2.00   sec  1.19 GBytes  10.2 Gbits/sec
> [  5]   2.00-3.00   sec  1.22 GBytes  10.5 Gbits/sec
> [  5]   3.00-4.00   sec  1.11 GBytes  9.56 Gbits/sec
> [  5]   4.00-5.00   sec  1.20 GBytes  10.3 Gbits/sec
> [  5]   5.00-6.00   sec  1.14 GBytes  9.80 Gbits/sec
> [  5]   6.00-7.00   sec  1.17 GBytes  10.0 Gbits/sec
> [  5]   7.00-8.00   sec  1.12 GBytes  9.61 Gbits/sec
> [  5]   8.00-9.00   sec  1.13 GBytes  9.74 Gbits/sec
> [  5]   9.00-10.00  sec  1.26 GBytes  10.8 Gbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.04  sec  11.8 GBytes  10.1 Gbits/sec   receiver
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
>    27.24%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ___=
_sys_recvmsg
>=20
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
> ---
>  net/ipv4/tcp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1baa484d2190..82e1da3f0f98 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2351,6 +2351,20 @@ static int tcp_recvmsg_locked(struct sock *sk, str=
uct msghdr *msg, size_t len,
>  	if (flags & MSG_PEEK) {
>  		peek_seq =3D tp->copied_seq;
>  		seq =3D &peek_seq;
> +		if (!msg->msg_iter.__iov[0].iov_base) {
> +			size_t peek_offset;
> +
> +			if (msg->msg_iter.nr_segs < 2) {
> +				err =3D -EINVAL;
> +				goto out;
> +			}
> +			peek_offset =3D msg->msg_iter.__iov[0].iov_len;
> +			msg->msg_iter.__iov =3D &msg->msg_iter.__iov[1];
> +			msg->msg_iter.nr_segs -=3D 1;
> +			msg->msg_iter.count -=3D peek_offset;
> +			len -=3D peek_offset;
> +			*seq +=3D peek_offset;
> +		}

IMHO this does not look like the correct interface to expose such
functionality. Doing the same with a different protocol should cause a
SIGSEG or the like, right?

What about using/implementing SO_PEEK_OFF support instead?=20

Cheers,

Paolo


