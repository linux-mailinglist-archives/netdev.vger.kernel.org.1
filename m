Return-Path: <netdev+bounces-265885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DI8MuaNr2kragIAu9opvQ
	(envelope-from <netdev+bounces-265885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:20:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1880244B34
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D1B8302BA4B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5AC1FF1C7;
	Tue, 10 Mar 2026 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bBiG9SLz"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538CA186284
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112804; cv=none; b=b01QM7N6+3yJAGd7TdVB8Wrfjvy0dhH/gLRRe+lTvtxXGHMbsGd1mGQUfM1h6pO6vxG8VeQqtBuFg8z9bae6Azo2F1fGDMg9uZjgIe1XwWe9H2ASD3O5idqlLf5dv8qvyFFGXBXm1g8Jbmjguws9E9V9hZxv/8tuYgYcf1IplfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112804; c=relaxed/simple;
	bh=+x7Gbh/MowER54PCDUhUo/uZ9Zk2GPuZsumBm4hYMro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIUF48gVPeFb0N5pbvTqkiDlMuZgXmVFAalwkjWPtlPJVTAOk87anHsqJwJROIDz10/3ZcTAoBVzMvobVRKQe71YSjTOh3JoSY1qT2JxfE1C87fTmthiCZff6nNhNDU7zQGAmK9qPUBECgWN8tyXe7gYPD6SNLQgwZyjyyGSDD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bBiG9SLz; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Mar 2026 11:19:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773112800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPzwk8mYXvU3xAfs2Sh8DnOi8USzPO+Hy0PEkYl4BAA=;
	b=bBiG9SLz8A5KzXH/1MwfTS0hyjpT9uyGrjXz7CwNdGkaDlVd/dPp7qPh+5z0I8CHeBInZo
	gCC5DOKnBrafZSGRAR9m88ztuCAIRzTskQS13RcnO2LOzNwo4YDV4GQSjy95Dsls57ccig
	1bRh5U4199CsSVXP/dU97z8XzhROOWA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp: use WRITE_ONCE() for tsoffset in tcp_v6_connect()
Message-ID: <sdyelt66tgfd55anansdmp3argjouxtpqlzumlwgcxher4i5ym@5z552zecejtz>
References: <20260310012604.145661-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310012604.145661-1-atwellwea@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E1880244B34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-265885-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 07:26:04PM +0800, Wesley Atwell wrote:

You should use [PATCH net] instead of [PATCH] to indicate which tree 
this patch is intended for.

> Commit dd23c9f1e8d5 ("tcp: annotate data-races around tp->tsoffset")
> updated do_tcp_getsockopt() to read tp->tsoffset with READ_ONCE()
> for TCP_TIMESTAMP because another CPU may change it concurrently.
> 
> tcp_v6_connect() still stores tp->tsoffset with a plain write. That
> store runs under lock_sock() via inet_stream_connect(), but the socket
> lock does not serialize a concurrent getsockopt(TCP_TIMESTAMP) from
> another task sharing the socket.
> 
> Use WRITE_ONCE() for the tcp_v6_connect() store so the connect-time
> writer matches the lockless TCP_TIMESTAMP reader. This also makes the
> IPv6 path consistent with tcp_v4_connect().
> 
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
>  net/ipv6/tcp_ipv6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index bb09d5ccf599..ba7cd7d3d4da 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -325,7 +325,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  						 inet->inet_dport);
>  		if (!tp->write_seq)
>  			WRITE_ONCE(tp->write_seq, st.seq);
> -		tp->tsoffset = st.ts_off;
> +		WRITE_ONCE(tp->tsoffset, st.ts_off);
>  	}
>  
>  	if (tcp_fastopen_defer_connect(sk, &err))

