Return-Path: <netdev+bounces-125270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A096C8FF
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 22:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA371F27094
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 20:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B013B59E;
	Wed,  4 Sep 2024 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkakjoqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29058D530
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483272; cv=none; b=JCuX4PuPpkO7bVrBxgtwH4F7OvWE6RGEnqSZW5jJxonO0wAjjOdIM80h9IpG2H8YgVV1WCNWWUwD0BedO7Y0iBz28lF7rbnUy+wZh9cfScTx9aUKS9P1U4jtlD7gokaKVHR3V8O2VxgN6+WyU4/xlPve8spPBJsECU3KIQXHP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483272; c=relaxed/simple;
	bh=fkLcbFL/U6TK+I67e8tTVj8WSxzNV7OcjZ8dGchd91g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lArZinhtefp6FCmbQ5QtHLs97WaP7ggJ6sS2A2kuoZQVOhJp0WEKlLoFCBOVhiQ3UYo/udatVtgHzdQ8aUVewgkDuVSjgx2TavstOHcOk6z9J7b65trv9Ufc6qJ/CWaEPOEW7xiH6XrQkdqyHINm6xjkG+9dIn73VGDiseExNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkakjoqE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a8130906faso4317085a.0
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725483270; x=1726088070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Da80QxNN94KUf0ebQObZ6fGVkcmfBb05AWAh9B5qh0=;
        b=QkakjoqEvpJIdAZCpzjZ1qp2LHcgRGA6K8BQl4yiVoPzPX0CAzrgDMQDlhCVwjK1iR
         OSkjLES7flN0iVSkRWBH/FO+wVy8sUAT1jajNPcZmTs96XA0oY8he0iW9+iXo8kdwMOI
         40Yn88yOVi+IIz4ykfEjs82hYKeZPA8xyHVttZaTn7tr5ez8WtDOQxz1XuQpVE+fqbXs
         9+TJD6gvtyvTFNj8DmtbMQCjZLDXksEwFQNC8JmkdXPfUXEzzzXDGAL6kuSxKGXO/hUw
         X/QinTMXqpbNuVmBFNrBNzfFTFmwJT90axdYRABni6J3yzzKzTflpm1ytacBPeCzvvCQ
         p49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725483270; x=1726088070;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6Da80QxNN94KUf0ebQObZ6fGVkcmfBb05AWAh9B5qh0=;
        b=HkUgBLZUueZlQ+3H3vPiIdv1b9av9fzThpo9odW2bbeajFbrXNsh0NAz7aHVHUwXuP
         V3pBQVBKpgk2FcLycjqouANSLV/1sHG1/zh+M46tUPO6s9XKgJTqbJRadaZXCl49lnqf
         MeII+CgHLUPX9XLB2P35wN1zPNmfrNJR/casAmO/fjj6+Em4ZuxGl/B4bqrKNBOVsy0a
         A8jbJg3Q/pbxR6UTSV3CjYBtJGy84JX0EeLH6eqoRICd8Q+eqSozYg9kOGGNXLgDjp2j
         1LNTt9Y17SMlrH2EYU9Lr5Xt0kzndONQYFBKPgVwPO44l6D6KvqrNCziQUZzBbST6Ncz
         op4A==
X-Forwarded-Encrypted: i=1; AJvYcCX8dNf7aYCSMvLfM+5D3P0osxaLG7FUnOGqjRmtQW8s3yRbrXOhdoKlV5E69C7ilDrmV9Y+FKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV7AVuv44uE+503hLb89GX+l/NVy6dFUkvYY+hMAxLmnzJboML
	thhN1Xr4CzHAFFGN0nwFuoDr4/Zc0J42d5RvEbveglUwY0Ege+7veQsF0Q==
X-Google-Smtp-Source: AGHT+IEMiAbCFyEbsbAAH2K2uK8akvFgDGrT8VVCshdAbA5x3fK016kfixSkF4X8PjC/wHsL7NVadA==
X-Received: by 2002:a05:620a:4141:b0:7a6:7793:b6d9 with SMTP id af79cd13be357-7a8a3f74840mr2008484585a.36.1725483269946;
        Wed, 04 Sep 2024 13:54:29 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f00ffa6sm17154085a.118.2024.09.04.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:54:28 -0700 (PDT)
Date: Wed, 04 Sep 2024 16:54:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, 
 netdev@vger.kernel.org
Message-ID: <66d8c903bba20_163d9329498@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240904113153.2196238-2-vadfed@meta.com>
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-2-vadfed@meta.com>
Subject: Re: [PATCH net-next v3 1/4] net_tstamp: add SCM_TS_OPT_ID to provide
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
> values by providing ID with each sendmsg for UDP sockets.
> The documentation is also added in this patch.
> 
> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  Documentation/networking/timestamping.rst | 13 +++++++++++++
>  arch/alpha/include/uapi/asm/socket.h      |  2 ++
>  arch/mips/include/uapi/asm/socket.h       |  2 ++
>  arch/parisc/include/uapi/asm/socket.h     |  2 ++
>  arch/sparc/include/uapi/asm/socket.h      |  2 ++
>  include/net/inet_sock.h                   |  4 +++-
>  include/net/sock.h                        |  2 ++
>  include/uapi/asm-generic/socket.h         |  2 ++
>  include/uapi/linux/net_tstamp.h           |  7 +++++++
>  net/core/sock.c                           |  9 +++++++++
>  net/ipv4/ip_output.c                      | 18 +++++++++++++-----
>  net/ipv6/ip6_output.c                     | 18 +++++++++++++-----
>  12 files changed, 70 insertions(+), 11 deletions(-)
> 
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
> index a2c66b3d7f0f..1c38536350e7 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -38,6 +38,13 @@ enum {
>  				 SOF_TIMESTAMPING_LAST
>  };
>  
> +/*
> + * The highest bit of sk_tsflags is reserved for kernel-internal
> + * SOCKCM_FLAG_TS_OPT_ID. This check is to control that SOF_TIMESTAMPING*
> + * values do not reach this reserved area
> + */
> +static_assert(SOF_TIMESTAMPING_LAST != (1 << 31));

Let's not leak any if this implementation detail to include/uapi.

A BUILD_BUG_ON wherever SOCKCM_FLAG_TS_OPT_ID is used, such as in case
SCM_TS_OPT_ID, should work.

> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index eea443b7f65e..bd2f6a699470 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -973,7 +973,7 @@ static int __ip_append_data(struct sock *sk,
>  	unsigned int maxfraglen, fragheaderlen, maxnonfragsize;
>  	int csummode = CHECKSUM_NONE;
>  	struct rtable *rt = dst_rtable(cork->dst);
> -	bool paged, hold_tskey, extra_uref = false;
> +	bool paged, hold_tskey = false, extra_uref = false;
>  	unsigned int wmem_alloc_delta = 0;
>  	u32 tskey = 0;
>  
> @@ -1049,10 +1049,15 @@ static int __ip_append_data(struct sock *sk,
>  
>  	cork->length += length;
>  
> -	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
> -		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
> -	if (hold_tskey)
> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
> +	    READ_ONCE(sk->sk_tsflags) & SOCKCM_FLAG_TS_OPT_ID) {

s/SOCKCM_FLAG_TS_OPT_ID/SOF_TIMESTAMPING_OPT_ID/

> +		if (cork->flags & IPCORK_TS_OPT_ID) {
> +			tskey = cork->ts_opt_id;
> +		} else {
> +			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +			hold_tskey = true;
> +		}
> +	}
>  
>  	/* So, what's going on in the loop below?
>  	 *
> @@ -1325,8 +1330,11 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
>  	cork->mark = ipc->sockc.mark;
>  	cork->priority = ipc->priority;
>  	cork->transmit_time = ipc->sockc.transmit_time;
> +	cork->ts_opt_id = ipc->sockc.ts_opt_id;
>  	cork->tx_flags = 0;
>  	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
> +	if (ipc->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID)
> +		cork->flags |= IPCORK_TS_OPT_ID;

We can move initialization of ts_opt_id into the branch.

Or conversely avoid the branch with some convoluted shift operations
to have the rval be either 1 << 1 or 0 << 1. But let's do the simpler
thing.



