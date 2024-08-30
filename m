Return-Path: <netdev+bounces-123729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 779F59664E0
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAA4288BEB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59518EFE6;
	Fri, 30 Aug 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDES2D6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE64A1D
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030165; cv=none; b=Jo2QiI/dfLlreE2b2OWRzRv6dcHtH4lKC2VlSWdM/lHakFjzZyXtX9KmUWfAgw27xjaaP9GH+2W202jWGxp9+TL84JD0FDG3GLdRx1eUmsIPOkJ5eljNFD7Fg6+mUXR9JrLbrVAxx0M0qnSWL4r7RdwGEEbVjg/zwWBJ1GQ3cvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030165; c=relaxed/simple;
	bh=DVqN2nxauPBaFgrq4Y/pwV+6SwrfHVL5SasKAO1CPM8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OF+U4miW4inFLkxcJiKEbWZYDVL64uHuIvhAXn9ZgTdtPZGTryZpZ8GWZCZyJ1D//R5NB4S8bmaiAccJA+3X1am05dgk7Z2Dh3SJPq7hFr/iOxT1vVeoqE2yMR1RKmJkMxNzb8K0LntgQvi1Ed2JCtho+HmYgK5pIDj03FKDt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDES2D6W; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a7fef9a5fdso187956785a.1
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725030163; x=1725634963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nT2N53ytO2hIGEDfkFsQ98FizBShMD0NLaCOJ0MPQcA=;
        b=ZDES2D6WdvookVq8BzHmYLsDJNZWjrMbaeA7DmeErIbJRDMmc2p/0XUeXQqAdXLRye
         ZWKwi4rMIZQfq9ocAjQdDuXzQU3anyE2YWLYrNCmS6Zm+NE+AIW8/CALHDpG5Ovk5U8V
         Ix8sCKl6LiRSwC+Qzj+B6ZQH10ZYUYJnOGXfAZ+uTk60AFnwcypW5cOltQ1wnAkkegoE
         4XHsxhzbtu42pv1KVEwTEmgI4m0Vgt4H8o3XJnAdD6R+wlEmPKNEuhdllWh8KQmU+jth
         CRsS8rxnZmAsE/CUw1LuqZXtOMC6qMMnJuGv/fCncxJ+oF7ajPqp2gXuEcgHec4odLae
         sNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725030163; x=1725634963;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT2N53ytO2hIGEDfkFsQ98FizBShMD0NLaCOJ0MPQcA=;
        b=kVj4fIeBU33xyVx8gkbi6pppN2/F9driWl6ByedbxNqoPeQj+A0nRLAWtrOdJJVC8p
         Za+1svc9FHoEp7z1oV8pDeGrUuPnxz2/luQLyjjwpxa9ysrsNlaGEpdKODQluDelBlLM
         KFdpBqSgtpUKmo5pu2WAlrUir2rGSC5+BWXwimfUzuH3o2mM+zuSfoxjLDgnSJjQ3Qkt
         B+Y9FadSHA/ERYYY+gCwkWToQQgJ+yWkZsVouL3Ftp2Y0x/fqR2UkhjCoQ12+EvEV1Iw
         gjPzc2MJuQJhKy8MsSixshcgp5ew+t7TrPhFl2YLji0YGrNQg9z60qpx2rkJwCJH08M2
         kGyw==
X-Forwarded-Encrypted: i=1; AJvYcCWjrSVvKm+YBzbcVPYX87VW7XLEVUBx4QMpCWsHGKlGjmuNGsmvutWohRVE9V1g3LGZzRil1X0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmc8bjwPdt1hMpvGOyh5XH4DgDIPtFdvS1aHpqOKlUmaQdO9Nk
	VywXRfG6vmny8b5s/NCa1s7MQWT7H1TKQ7akQfazViXBuk8+EqUe
X-Google-Smtp-Source: AGHT+IF3Hq2DPx3O5r6+QZ7WJk6hGXmfj2uS7S/wPwOM/SxxoEP+ZiIYCTFGx1DhdXvEzI445gmLKw==
X-Received: by 2002:a05:620a:448d:b0:7a7:f8ae:a511 with SMTP id af79cd13be357-7a804b8a84dmr958659985a.4.1725030162449;
        Fri, 30 Aug 2024 08:02:42 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d88943sm148228385a.133.2024.08.30.08.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:02:41 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:02:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, 
 netdev@vger.kernel.org
Message-ID: <66d1df11a42fc_3c08a2294a5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240829204922.1674865-1-vadfed@meta.com>
References: <20240829204922.1674865-1-vadfed@meta.com>
Subject: Re: [PATCH net-next 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> timestamps and packets sent via socket. Unfortunately, there is no way
> to reliably predict socket timestamp ID value in case of error returned
> by sendmsg. For UDP sockets it's impossible because of lockless
> nature of UDP transmit, several threads may send packets in parallel. In
> case of RAW sockets MSG_MORE option makes things complicated. More
> details are in the conversation [1].
> This patch adds new control message type to give user-space
> software an opportunity to control the mapping between packets and
> values by providing ID with each sendmsg. This works fine for UDP
> sockets only, and explicit check is added to control message parser.
> 
> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  include/net/inet_sock.h           |  4 +++-
>  include/net/sock.h                |  1 +
>  include/uapi/asm-generic/socket.h |  2 ++
>  include/uapi/linux/net_tstamp.h   |  1 +
>  net/core/sock.c                   | 12 ++++++++++++
>  net/ipv4/ip_output.c              | 13 +++++++++++--
>  net/ipv6/ip6_output.c             | 13 +++++++++++--
>  7 files changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 394c3b66065e..2161d50cf0fd 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -174,6 +174,7 @@ struct inet_cork {
>  	__s16			tos;
>  	char			priority;
>  	__u16			gso_size;
> +	u32			ts_opt_id;
>  	u64			transmit_time;
>  	u32			mark;
>  };
> @@ -241,7 +242,8 @@ struct inet_sock {
>  	struct inet_cork_full	cork;
>  };
>  
> -#define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */
> +#define IPCORK_OPT		1	/* ip-options has been held in ipcork.opt */
> +#define IPCORK_TS_OPT_ID	2	/* timestmap opt id has been provided in cmsg */
>  
>  enum {
>  	INET_FLAGS_PKTINFO	= 0,
> diff --git a/include/net/sock.h b/include/net/sock.h
> index f51d61fab059..73e21dad5660 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1794,6 +1794,7 @@ struct sockcm_cookie {
>  	u64 transmit_time;
>  	u32 mark;
>  	u32 tsflags;
> +	u32 ts_opt_id;
>  };
>  
>  static inline void sockcm_init(struct sockcm_cookie *sockc,
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 8ce8a39a1e5f..db3df3e74b01 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>  
> +#define SCM_TS_OPT_ID		78
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
> index a2c66b3d7f0f..081b40a55a2e 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -32,6 +32,7 @@ enum {
>  	SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
>  	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
>  	SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
> +	SOF_TIMESTAMPING_OPT_ID_CMSG = (1 << 17),
>  
>  	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_TCP,
>  	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |

Update SOF_TIMESTAMPING_LAST

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 468b1239606c..560b075765fa 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2859,6 +2859,18 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  			return -EINVAL;
>  		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
>  		break;
> +	case SCM_TS_OPT_ID:
> +		/* allow this option for UDP sockets only */
> +		if (!sk_is_udp(sk))
> +			return -EINVAL;
> +		tsflags = READ_ONCE(sk->sk_tsflags);
> +		if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
> +			return -EINVAL;
> +		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
> +			return -EINVAL;
> +		sockc->ts_opt_id = *(u32 *)CMSG_DATA(cmsg);
> +		sockc->tsflags |= SOF_TIMESTAMPING_OPT_ID_CMSG;
> +		break;
>  	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index b90d0f78ac80..65b5d9f53102 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1050,8 +1050,14 @@ static int __ip_append_data(struct sock *sk,
>  
>  	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
>  		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
> -	if (hold_tskey)
> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +	if (hold_tskey) {
> +		if (cork->flags & IPCORK_TS_OPT_ID) {
> +			hold_tskey = false;
> +			tskey = cork->ts_opt_id;
> +		} else {
> +			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +		}
> +	}
>  
>  	/* So, what's going on in the loop below?
>  	 *
> @@ -1324,8 +1330,11 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
>  	cork->mark = ipc->sockc.mark;
>  	cork->priority = ipc->priority;
>  	cork->transmit_time = ipc->sockc.transmit_time;
> +	cork->ts_opt_id = ipc->sockc.ts_opt_id;
>  	cork->tx_flags = 0;
>  	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
> +	if (ipc->sockc.tsflags & SOF_TIMESTAMPING_OPT_ID_CMSG)
> +		cork->flags |= IPCORK_TS_OPT_ID;
>  
>  	return 0;
>  }
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index f26841f1490f..91eafef85c85 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1401,7 +1401,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
>  	cork->base.gso_size = ipc6->gso_size;
>  	cork->base.tx_flags = 0;
>  	cork->base.mark = ipc6->sockc.mark;
> +	cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
>  	sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
> +	if (ipc6->sockc.tsflags & SOF_TIMESTAMPING_OPT_ID_CMSG)
> +		cork->base.flags |= IPCORK_TS_OPT_ID;
>  
>  	cork->base.length = 0;
>  	cork->base.transmit_time = ipc6->sockc.transmit_time;
> @@ -1545,8 +1548,14 @@ static int __ip6_append_data(struct sock *sk,
>  
>  	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
>  		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
> -	if (hold_tskey)
> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +	if (hold_tskey) {
> +		if (cork->flags & IPCORK_TS_OPT_ID) {
> +			hold_tskey = false;
> +			tskey = cork->ts_opt_id;
> +		} else {
> +			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +		}
> +	}

Setting, then clearing hold_tskey is a bit weird. How about

if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
        if (cork->flags & IPCORK_TS_OPT_ID) {
                 tskey = cork->ts_opt_id;
        } else {
                 tskey = atomic_inc_return(&sk->sk_tskey) - 1;
                 hold_tskey = true;
        }
}

