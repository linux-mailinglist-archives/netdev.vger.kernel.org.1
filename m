Return-Path: <netdev+bounces-68226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D378462DA
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 22:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D8F1C23142
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 21:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C64174F;
	Thu,  1 Feb 2024 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8tmqHIC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D043EA89
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824066; cv=none; b=msbnSyVLJlrzPUF+t4pj+k/hJC6ErVUiRgEVER/p9AfA1d6jyr8EEhNBE8VPNW0FcHbXKDh4Vj7Y8oOCYAz7PO8rt85x94v73TuWAPubI+3CDUzg9Fs1ei8q11rPUccHRvwQG24mkrs2dsVjv/zzsJ1unEYaadJxiJ90unz30tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824066; c=relaxed/simple;
	bh=6GU8hHP9jGTgDMpfzVPAVkfsiOjGsOZZFoe0Xxt2Myc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmmZnGU9Bmt95nNSs8pTLlz4wPXK2KX4ReOZXPpCecYeCk81FknRoKfcafYaaF4PHT4sGD9T00jXtyUBS/0G9o2BpquGUrJ5YWQuebKzL0fd6KiLYkGJ6jxGX2eAac+TCtNl2wmusaiDOxuPUlzhqGPh8FY9zXVIMhGRCTBydKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8tmqHIC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706824062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nd6pZFAe36Ph7pnbqd5xnWNHxoCQ+A2+nfOfl6OaIEI=;
	b=S8tmqHICEtw6Sn8FyaIcwm34PpN7yYm8blrjGtX7/ZkG8bzsHqca2pXqJS1XT9naISB/7Z
	c1ULv2DWtXuU5Ega47q0PEFogFcuLvvmz/rj4MMPpKIAg5f3x6K/Sy2/B6m11HkHwtJQaI
	JcRAMqj1zVPzlH1cc1vwyf0+SIdnyRo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-E3MMc370P1qdtJ6j6Wjxzw-1; Thu, 01 Feb 2024 16:47:39 -0500
X-MC-Unique: E3MMc370P1qdtJ6j6Wjxzw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5113583c567so29156e87.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 13:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824058; x=1707428858;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nd6pZFAe36Ph7pnbqd5xnWNHxoCQ+A2+nfOfl6OaIEI=;
        b=BgCFe+jf1/nLlsfXeJKgE5Q9+B+O9DNrT1WE0XPRM6c+7YqxX/plc/Kl9O+0MsjsxK
         D2gza4JRNRHfGVcrQC5YRvWANdeTk97Pexma8eA/UzZm0UTTa/EVXkDHsGuDoKrT/Unb
         alBVE8fBx3DdxyZ9oxIDAcm1IRkfsOt0bqaSpPINLMlpq0nKgYLKL8pUWYoX1r/r9Ro0
         2mfWm/Mv95dPzJNmnzHaodp8nXjq3yOKO0txFNJlesCFCyt8a73bVI/rOf8S+O82IuLs
         z36TRGi20BxA63gXXhR+2go8ifNjDlDuOU0zPSOdxMnXha9TORDqpzDJ5WqjzzM8HJXU
         VipQ==
X-Gm-Message-State: AOJu0YzMp6t6JSlseEVWn9LtnEUJGAqE5dZjEv871UZoHa/vbBHFVzvF
	Lw0Q6zhv7Ioz9vRq5K36ZHchadMlZHvtrp3WgfaEsAUA91v65ve9iP0hflMRNKQtOR/SDOdg+Yt
	fjfDMwRsOCeFA/ociptGBU5Mzn+uueTmv1dr9ZE3zLoftpCrc7sNDlA==
X-Received: by 2002:a19:9119:0:b0:511:8ae:a3ce with SMTP id t25-20020a199119000000b0051108aea3cemr116855lfd.64.1706824057813;
        Thu, 01 Feb 2024 13:47:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERJumn4jmPk94XsbThRiH1oxprtpORD7De9/dN3geKxTHsNjDzRADdHkn5t7WjQ4g0GDsdUA==
X-Received: by 2002:a19:9119:0:b0:511:8ae:a3ce with SMTP id t25-20020a199119000000b0051108aea3cemr116842lfd.64.1706824057340;
        Thu, 01 Feb 2024 13:47:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXcvt6FzFuEt6+5/FgCEnaeIsP+2gRzanG2HXw5U5uuFjH/j+AC6IjrJiPlmYkoGgRIPugIzQ7pu2L2q31k0eO8y6aFrzplOW+qIcHDvtvWGoOq4rHl7h4PiaA0kEuXo7WLWwBb8kpU1wzm7W7EfsJfycjCterjwdWyyPFc1tKH0jm3oVWchX55IepzQhP4AIVzZbckIPj3P+fIgLhskYdTkRcVEg==
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id ps6-20020a170906bf4600b00a28fa7838a1sm192163ejb.172.2024.02.01.13.47.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2024 13:47:36 -0800 (PST)
Date: Thu, 1 Feb 2024 22:47:00 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, lvivier@redhat.com, dgibson@redhat.com, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [RFC net-next] tcp: add support for SO_PEEK_OFF
Message-ID: <20240201224700.5b32b913@elisabeth>
In-Reply-To: <20240201213201.1228681-1-jmaloy@redhat.com>
References: <20240201213201.1228681-1-jmaloy@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 16:32:01 -0500
jmaloy@redhat.com wrote:

> From: Jon Maloy <jmaloy@redhat.com>
> 
> When reading received messages from a socket with MSG_PEEK, we may want
> to read the contents with an offset, like we can do with pread/preadv()
> when reading files. Currently, it is not possible to do that.
> 
> In this commit, we add support for the SO_PEEK_OFF socket option for TCP,
> in a similar way it is done for Unix Domain sockets.
> 
> In the iperf3 log examples shown below, we can observe a throughput
> improvement of 15-20 % in the direction host->namespace when using the
> protocol splicer 'pasta' (https://passt.top).
> This is a consistent result.
> 
> pasta(1) and passt(1) implement user-mode networking for network
> namespaces (containers) and virtual machines by means of a translation
> layer between Layer-2 network interface and native Layer-4 sockets
> (TCP, UDP, ICMP/ICMPv6 echo).
> 
> Received, pending TCP data to the container/guest is kept in kernel
> buffers until acknowledged, so the tool routinely needs to fetch new
> data from socket, skipping data that was already sent.
> 
> At the moment this is implemented using a dummy buffer passed to
> recvmsg(). With this change, we don't need a dummy buffer and the
> related buffer copy (copy_to_user()) anymore.
> 
> passt and pasta are supported in KubeVirt and libvirt/qemu.
> 
> jmaloy@freyr:~/passt$ perf record -g ./pasta --config-net -f
> SO_PEEK_OFF not supported by kernel.
> 
> jmaloy@freyr:~/passt# iperf3 -s
> -----------------------------------------------------------
> Server listening on 5201 (test #1)
> -----------------------------------------------------------
> Accepted connection from 192.168.122.1, port 44822
> [  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 44832
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
> 
> jmaloy@freyr:~/passt$ perf record -g ./pasta --config-net -f
> SO_PEEK_OFF supported by kernel.
> 
> jmaloy@freyr:~/passt# iperf3 -s
> -----------------------------------------------------------
> Server listening on 5201 (test #1)
> -----------------------------------------------------------
> Accepted connection from 192.168.122.1, port 52084
> [  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 52098
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
> [  5]   0.00-10.04  sec  12.9 GBytes  11.0 Gbits/sec                  receiver
> -----------------------------------------------------------
> Server listening on 5201 (test #2)
> -----------------------------------------------------------
> ^Ciperf3: interrupt - the server has terminated
> logout
> [ perf record: Woken up 20 times to write data ]
> [ perf record: Captured and wrote 5.040 MB perf.data (33411 samples) ]
> jmaloy@freyr:~/passt$
> 
> The perf record confirms this result. Below, we can observe that the
> CPU spends significantly less time in the function ____sys_recvmsg()
> when we have offset support.
> 
> Without offset support:
> ----------------------
> jmaloy@freyr:~/passt$ perf report -q --symbol-filter=do_syscall_64 -p ____sys_recvmsg -x --stdio -i  perf.data | head -1
>     46.32%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sys_recvmsg
> 
> With offset support:
> ----------------------
> jmaloy@freyr:~/passt$ perf report -q --symbol-filter=do_syscall_64 -p ____sys_recvmsg -x --stdio -i  perf.data | head -1
>    28.12%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sys_recvmsg
> 
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

I guess this was Suggested-by: Paolo Abeni <pabeni@redhat.com> ? :)

> ---
>  include/net/tcp.h  |  1 +
>  net/ipv4/af_inet.c |  1 +
>  net/ipv4/tcp.c     | 25 +++++++++++++++++++------
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 87f0e6c2e1f2..7eca7f2ac102 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -357,6 +357,7 @@ void tcp_twsk_purge(struct list_head *net_exit_list, int family);
>  ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
>  			struct pipe_inode_info *pipe, size_t len,
>  			unsigned int flags);
> +int tcp_set_peek_offset(struct sock *sk, int val);
>  struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
>  				     bool force_schedule);
>  
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index fb81de10d332..7a8b3a91257f 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1068,6 +1068,7 @@ const struct proto_ops inet_stream_ops = {
>  #endif
>  	.splice_eof	   = inet_splice_eof,
>  	.splice_read	   = tcp_splice_read,
> +	.set_peek_off      = tcp_set_peek_offset,
>  	.read_sock	   = tcp_read_sock,
>  	.read_skb	   = tcp_read_skb,
>  	.sendmsg_locked    = tcp_sendmsg_locked,
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index fce5668a6a3d..33ade88633de 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -863,6 +863,14 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
>  }
>  EXPORT_SYMBOL(tcp_splice_read);
>  
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

Stray change.

>  static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
>  			      int flags, struct scm_timestamping_internal *tss,
>  			      int *cmsg_flags)
> @@ -2317,6 +2324,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
>  	long timeo;
>  	struct sk_buff *skb, *last;
>  	u32 urg_hole = 0;
> +	u32 peek_offset = 0;
>  
>  	err = -ENOTCONN;
>  	if (sk->sk_state == TCP_LISTEN)
> @@ -2349,7 +2357,8 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
>  
>  	seq = &tp->copied_seq;
>  	if (flags & MSG_PEEK) {
> -		peek_seq = tp->copied_seq;
> +		peek_offset = max(sk_peek_offset(sk, flags), 0);
> +		peek_seq = tp->copied_seq + peek_offset;
>  		seq = &peek_seq;
>  	}
>  

And with this, explicit support in tcp_peek_sndq() is not actually
needed, but this comment in that function:

        /* XXX -- need to support SO_PEEK_OFF */

should be removed now I guess.

> @@ -2452,11 +2461,11 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
>  		}
>  
>  		if ((flags & MSG_PEEK) &&
> -		    (peek_seq - copied - urg_hole != tp->copied_seq)) {
> +		    (peek_seq - peek_offset - copied - urg_hole != tp->copied_seq)) {
>  			net_dbg_ratelimited("TCP(%s:%d): Application bug, race in MSG_PEEK\n",
>  					    current->comm,
>  					    task_pid_nr(current));
> -			peek_seq = tp->copied_seq;
> +			peek_seq = tp->copied_seq + peek_offset;
>  		}
>  		continue;
>  
> @@ -2497,7 +2506,10 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
>  		WRITE_ONCE(*seq, *seq + used);
>  		copied += used;
>  		len -= used;
> -
> +		if (flags & MSG_PEEK)
> +			sk_peek_offset_fwd(sk, used);
> +		else
> +			sk_peek_offset_bwd(sk, used);
>  		tcp_rcv_space_adjust(sk);
>  
>  skip_copy:
> @@ -2774,6 +2786,7 @@ void __tcp_close(struct sock *sk, long timeout)
>  		data_was_unread += len;
>  		__kfree_skb(skb);
>  	}
> +	sk_set_peek_off(sk, -1);
>  
>  	/* If socket has been already reset (e.g. in tcp_reset()) - kill it. */
>  	if (sk->sk_state == TCP_CLOSE)
> @@ -4492,7 +4505,7 @@ void tcp_done(struct sock *sk)
>  		reqsk_fastopen_remove(sk, req, false);
>  
>  	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
> -
> +	sk_set_peek_off(sk, -1);
>  	if (!sock_flag(sk, SOCK_DEAD))
>  		sk->sk_state_change(sk);
>  	else

-- 
Stefano


