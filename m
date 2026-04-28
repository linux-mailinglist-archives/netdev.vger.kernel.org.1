Return-Path: <netdev+bounces-281655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCVYFKtM8Gm2RQEAu9opvQ
	(envelope-from <netdev+bounces-281655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828147DD01
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87D6B302B807
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9B33F8C6;
	Tue, 28 Apr 2026 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqH+WD4B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A935898
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777355936; cv=none; b=Nc4NSxnt3xb9e1DkcwBiv/+LEVO5LP6aJAgKde+RSfynvDVliHitJI/oZBN1rINFhDNMgFr38sAo3DEmWMEelR3lZBMdihRF91dXIc9gq50pQJKXpKcJsJHRmchpLrlmrXxRgupzP571vEqErJtz3T8EeiJWIPGKvqjslrDQMo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777355936; c=relaxed/simple;
	bh=9moRYPO6IrrwntTn/jZs+00rG1fdJL6QrtpMYRA5m5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LvftZIYph70vGJBqo2z3ddu44LYJV1cWSMyk3N9JC7rBTLZrw+4U2RlY+vd1Z/l0OJ08imwX1uk6JknybeehkF5TDx+uQYepyWl10kObla+L0pDjf9Bu+MUQJVpdYnazQWMGbfM/E2x3QM3D4gdwp192Yt7vjqTA6BrK6TWKSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hqH+WD4B; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35e5791871fso13867100a91.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777355933; x=1777960733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzUoMAnwF2GHarT+YBQ47BC+wMAAJa5xhvU2fBn99PY=;
        b=hqH+WD4BXnXIPK1FHgWoCq57JvPkzXhIYw0kKd1OK4VvICC3LqrT77PdpzXbTOrhJb
         RRtpkWWCoeOHhWo1hw86N2CugAo4aHRxbwmTdMNh/f2h9I/6E1qzmxV0P9K9DYRnqLrS
         NGmSJm1sMit3z+E3gMnMyA/jWcRsEs/jq8PhuvPLJX53r+RyrVgEW+ISPIOaIhAJCHWp
         RzJOWTKZywXj/WuWopXHn9t1QZcNvA+4thdMPYy+bfFFPM+VsQrOMq/oQRdL+DjvOVFp
         Yv2QKGTNG+rZ7yaBIZXHNnhv6FpgRMNUtOHGE+8woAsTXGkl/p3XKYGIYP3hSlLbp4Hi
         2hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777355933; x=1777960733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzUoMAnwF2GHarT+YBQ47BC+wMAAJa5xhvU2fBn99PY=;
        b=B1fKqz2Z0hZBzqsOA2CzA4di4uzKO/DpSLwuCYRfTf0dnzFLrwR3aKUZZ0/HF7Bys1
         pYfbu2gfMJnyE8470xAJ7D0vRQYvCvCa+H+70X0St4xxVafr8px62dY99B//sCq4FtRO
         2Q/d+3UA2IK3vuhL35+sAr2I4IPDqIOiZg3dcjugVI6HHNZOcOocW0BVnfaWaIr5yn/t
         OQRLD4Zgs9531viu8z+7JMlJ0a4NqwYWnR/Ud6XGb5wwalZ8HgnvGnQDLIbVFL5VylFv
         lEF6RMPHeigxJC6rxobWqmyZMg1BXGvb3uOU0lFXk0pbRn/DzYc583snZqKoJvMyCKZy
         nLMg==
X-Forwarded-Encrypted: i=1; AFNElJ+qYy04jfwAN04QOiQkauGN1QmwTn3fdPqzSCpKpKK6TqMliJwyvrrYaUUY7vxynh2yPa7DG4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz61sb16cGiPnrUQL/oBM82ZMeSnaqnLeM5sIbPiBlvs7Zdf+z/
	jiDYxAs6YltV3xzYWo7XzFcNt5wWDogunhIOwV20ZpeqrWPYJKmhtrCY33eeTYult7J6L8qT0WZ
	kcNdHvg==
X-Received: from pfbay28.prod.google.com ([2002:a05:6a00:301c:b0:82f:a0ba:50d5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e210:b0:39b:bee4:2952
 with SMTP id adf61e73a8af0-3a39c2ccbe9mr2070487637.45.1777355932768; Mon, 27
 Apr 2026 22:58:52 -0700 (PDT)
Date: Tue, 28 Apr 2026 05:58:41 +0000
In-Reply-To: <CANMuvJn15HHBrq8EEbhSfCk-Sn33WEEovRa-yVWF5huTKfoOYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CANMuvJn15HHBrq8EEbhSfCk-Sn33WEEovRa-yVWF5huTKfoOYA@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428055851.2204248-1-kuniyu@google.com>
Subject: Re: [PATCH] net: datagram: Drain queue before reporting EOF or ENOTCONN
From: Kuniyuki Iwashima <kuniyu@google.com>
To: oss@malat.biz
Cc: davem@davemloft.net, ebiggers@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0828147DD01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281655-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,malat.biz:email]

From: Petr Malat <oss@malat.biz>
Date: Mon, 27 Apr 2026 22:23:33 -0700
> If a packet is queued and RCV_SHUTDOWN flag is set after the function
> __skb_wait_for_more_packets() checked the queue, the function returns
> EOF, which is then propagated by __unix_dgram_recvmsg() and the user
> reads EOF although there is a message or messages still pending.
> 
> The function should check if the queue is empty before returning EOF.
> As the same is true for disconnect and it's also reasonable for a pending
> signal, check in a common place before returning from the function.
> 
> Signed-off-by: Petr Malat <oss@malat.biz>
> ---
>  net/core/datagram.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index c285c6465923..5952950f7233 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -98,40 +98,44 @@ int __skb_wait_for_more_packets(struct sock *sk,
> struct sk_buff_head *queue,
>  	/* Socket errors? */
>  	error = sock_error(sk);
>  	if (error)
> -		goto out_err;
> +		goto out;
> 
>  	if (READ_ONCE(queue->prev) != skb)
>  		goto out;
> 
>  	/* Socket shut down? */
> -	if (sk->sk_shutdown & RCV_SHUTDOWN)
> -		goto out_noerr;
> +	if (sk->sk_shutdown & RCV_SHUTDOWN) {
> +		error = 1;
> +		goto check_queue;

We already have checked the same condition just above, and this
is a matter of timing.

Even after the duplicated check is evaluated to false, there is
a small chance that the concurrent sendmsg() enqueues a new skb.

Considering __skb_wait_for_more_packets() is called only when
the queue is empty, it's not worth another round when shutdown()ed.


> +	}
> 
>  	/* Sequenced packets can come disconnected.
>  	 * If so we report the problem
>  	 */
> -	error = -ENOTCONN;
>  	if (connection_based(sk) &&
> -	    !(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_LISTEN))
> -		goto out_err;
> +	    !(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_LISTEN)) {
> +		error = -ENOTCONN;

Also, the queue is always empty if SOCK_SEQPACKET sk is at TCP_CLOSE.


> +		goto check_queue;
> +	}
> 
>  	/* handle signals */
> -	if (signal_pending(current))
> -		goto interrupted;
> +	if (signal_pending(current)) {
> +		error = sock_intr_errno(*timeo_p);
> +		goto check_queue;

and we don't want to delay signal if it arrived first.


> +	}
> 
> -	error = 0;
>  	*timeo_p = schedule_timeout(*timeo_p);
>  out:
> +	*err = error < 0 ? error : 0;
>  	finish_wait(sk_sleep(sk), &wait);
>  	return error;
> -interrupted:
> -	error = sock_intr_errno(*timeo_p);
> -out_err:
> -	*err = error;
> -	goto out;
> -out_noerr:
> -	*err = 0;
> -	error = 1;
> +check_queue:
> +	/* A packet may have arrived between the initial queue check and any
> +	 * of the early-exit conditions above.  Return 0 to let the caller
> +	 * drain the queue before acting on the shutdown / disconnect / signal.
> +	 */
> +	if (READ_ONCE(queue->prev) != skb)
> +		error = 0;
>  	goto out;
>  }
>  EXPORT_SYMBOL(__skb_wait_for_more_packets);
> -- 
> 2.47.3
> 

