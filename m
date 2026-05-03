Return-Path: <netdev+bounces-283507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 58H+CJ6i9mnuXAIAu9opvQ
	(envelope-from <netdev+bounces-283507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 03:19:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFF84B3FAF
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 03:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9F083007F4E
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 01:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0C219C553;
	Sun,  3 May 2026 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgLUD3yf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689B86334;
	Sun,  3 May 2026 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777771163; cv=none; b=pjAqcvdU7T7K5R0p+8wn5lm3NTTMostk4N8xoCFuFNFmv7NYDotQtGMYUEZE3B8/aHnSM5+OYNj5gYZ66LWcNAkW8aTfPm8LAnnstx6PiS2cjWYpRz0Q+X6haQl1qiHOeyfM62tr9lEqfcmUb4Ww9ndezPhUgDHgRB+lEDjjUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777771163; c=relaxed/simple;
	bh=U+ym1hAnWzu9Xmw2/SpzLT+fWmey47bbrQPcbHnNuyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shXCVKCBlaYCfHSYepWKBXJrtKUfJ3hAPBUkeYCe/4jBUZe0NLtY3lJBw+XsaYOb5CX+50UNGW8pXmetZ75ncSaMEIVlZ8FK/dq+r6X9BdTIkJPM3eskQ3YBHBeKAtOPB+O+fRqGPPVKrhQJxr8HRaYHkU9YQhyeyA0NAqTnxOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgLUD3yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51C4C19425;
	Sun,  3 May 2026 01:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777771163;
	bh=U+ym1hAnWzu9Xmw2/SpzLT+fWmey47bbrQPcbHnNuyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IgLUD3yfs3ZOOPBs9p5IQ34Z/0yMIjbwiXJR/QNo64xxmq+pYipbHZnA6InzoFZ65
	 nd0ZEXoWkKFK9uwIss3zX2L9AF/y70Kg1NP8mH8e2f1jlwEwkHw523TbJrXwDbG1qg
	 OgUP0rvx7+BIWfeNQERWsOcZXe5roFzswXxj2xaigUJXmYmKWc+zXNfPq4BuBUqHey
	 KvKUTgQ6xG2T+vEzxzaJ5dB4ywTssqQd2No3GfGESdPuh5RfJ8oXvyFpLGyFlRxN4Y
	 zht54rSCMSr7DAodckgRj+5W+p5/kFnsVSPnshCLGccarLHL7TG2eBuo7ip8Esc77o
	 rwXl7yNVMmKZw==
Date: Sat, 2 May 2026 18:19:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, Chuck Lever
 <chuck.lever@oracle.com>
Subject: Re: [PATCH net-next v9 4/5] tls: Suppress spurious saved_data_ready
 on all receive paths
Message-ID: <20260502181921.6d74ac78@kernel.org>
In-Reply-To: <20260429-tls-read-sock-v9-4-39e71aa7810f@oracle.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
	<20260429-tls-read-sock-v9-4-39e71aa7810f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6DFF84B3FAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-283507-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Wed, 29 Apr 2026 17:48:11 -0400 Chuck Lever wrote:
> -void tls_strp_check_rcv(struct tls_strparser *strp)
> +/**
> + * tls_strp_check_rcv - parse queued data and optionally notify
> + * @strp: TLS stream parser instance
> + * @wake: if true, fire consumer notification when a record is newly
> + *        parsed by this call
> + *
> + * Returns immediately when a record is already ready; the wake fires
> + * only on transitions from no-record to record-ready. Callers that
> + * need to notify a waiter about a record parsed by another path
> + * should invoke tls_rx_msg_ready() directly.
> + */

nit/reminder: no kdoc

> +void tls_strp_check_rcv(struct tls_strparser *strp, bool wake)

I wonder if it'd make sense to s/wake/announce/ for consistency?

>  {
>  	if (unlikely(strp->stopped) || strp->msg_ready)
>  		return;
>  
>  	if (tls_strp_read_sock(strp) == -ENOMEM)
>  		queue_work(tls_strp_wq, &strp->work);
> +	else if (wake && strp->msg_ready)
> +		tls_rx_msg_ready(strp);
>  }

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index c58d3b0b0a8a..cbb068266bab 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1383,7 +1383,11 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>  			return ret;
>  
>  		if (!skb_queue_empty(&sk->sk_receive_queue)) {
> -			tls_strp_check_rcv(&ctx->strp);
> +			/* Defer notification to the exit point;
> +			 * this thread will consume the record
> +			 * directly.

this line could be un-wrapped AFAICT

> +			 */
> +			tls_strp_check_rcv(&ctx->strp, false);
>  			if (tls_strp_msg_ready(ctx))
>  				break;
>  		}
> @@ -1869,9 +1873,17 @@ static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
>  	return 1;
>  }
>  
> -static void tls_rx_rec_done(struct tls_sw_context_rx *ctx)
> +/* Parse any data left in the lower socket and hand off a single
> + * notification to the next reader. tls_rx_msg_ready() is a no-op
> + * when the current record has already been announced, so paths
> + * that drained ctx->rx_list without touching the strparser do
> + * not re-fire saved_data_ready() for a record BH or the worker
> + * already announced.
> + */
> +static void tls_rx_handoff(struct tls_sw_context_rx *ctx)
>  {
> -	tls_strp_msg_done(&ctx->strp);
> +	tls_strp_check_rcv(&ctx->strp, false);
> +	tls_rx_msg_ready(&ctx->strp);
>  }
>  
>  /* This function traverses the rx_list in tls receive context to copies the
> @@ -2152,7 +2164,7 @@ int tls_sw_recvmsg(struct sock *sk,
>  		err = tls_record_content_type(msg, tls_msg(darg.skb), &control);
>  		if (err <= 0) {
>  			DEBUG_NET_WARN_ON_ONCE(darg.zc);
> -			tls_rx_rec_done(ctx);
> +			tls_strp_msg_release(&ctx->strp);
>  put_on_rx_list_err:
>  			__skb_queue_tail(&ctx->rx_list, darg.skb);
>  			goto recv_end;
> @@ -2166,7 +2178,8 @@ int tls_sw_recvmsg(struct sock *sk,
>  		/* TLS 1.3 may have updated the length by more than overhead */
>  		rxm = strp_msg(darg.skb);
>  		chunk = rxm->full_len;
> -		tls_rx_rec_done(ctx);
> +		tls_strp_msg_release(&ctx->strp);
> +		tls_strp_check_rcv(&ctx->strp, false);
>  
>  		if (!darg.zc) {
>  			bool partially_consumed = chunk > len;
> @@ -2260,6 +2273,7 @@ int tls_sw_recvmsg(struct sock *sk,
>  	copied += decrypted;
>  
>  end:
> +	tls_rx_handoff(ctx);
>  	tls_rx_reader_unlock(sk, ctx);
>  	if (psock)
>  		sk_psock_put(sk, psock);
> @@ -2300,7 +2314,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>  		if (err < 0)
>  			goto splice_read_end;
>  
> -		tls_rx_rec_done(ctx);
> +		tls_strp_msg_release(&ctx->strp);
>  		skb = darg.skb;
>  	}
>  
> @@ -2327,6 +2341,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>  	consume_skb(skb);
>  
>  splice_read_end:
> +	tls_rx_handoff(ctx);

I don't get why the tls_rx_handoff() thing exists, TBH
Maybe it made sense in the context of the code which is no longer part
of the series. But without it it looks pretty odd. Fells like you should
simply be suppressing notifications when tls_strp_check_rcv() is called
by tls_rx_rec_done() and then tls_rx_reader_release() should make sure
it flushes the ->data_ready if it's exiting on a read && !announced
condition. In rcvmsg() path you're now calling tls_strp_check_rcv()
twice.

>  	tls_rx_reader_unlock(sk, ctx);
>  	return copied ? : err;
>  
> @@ -2392,7 +2407,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			tlm = tls_msg(skb);
>  			decrypted += rxm->full_len;
>  
> -			tls_rx_rec_done(ctx);
> +			tls_strp_msg_release(&ctx->strp);
>  		}
>  
>  		/* read_sock does not support reading control messages */
> @@ -2420,6 +2435,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	}
>  
>  read_sock_end:
> +	tls_rx_handoff(ctx);
>  	tls_rx_reader_release(sk, ctx);
>  	return copied ? : err;
>  
> @@ -2504,10 +2520,18 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
>  	return ret;
>  }
>  
> +/* Fire saved_data_ready() at most once per parsed record.
> + * msg_announced is cleared by tls_strp_msg_release() when the
> + * current record is consumed, arming the next announcement.
> + */
>  void tls_rx_msg_ready(struct tls_strparser *strp)

Given the change to the semantics maybe this should be named
tls_rx_msg_maybe_announce() or _flush_announce() now ?

>  {
>  	struct tls_sw_context_rx *ctx;
>  
> +	if (!READ_ONCE(strp->msg_ready) || strp->msg_announced)
> +		return;
> +	strp->msg_announced = 1;
> +
>  	ctx = container_of(strp, struct tls_sw_context_rx, strp);
>  	ctx->saved_data_ready(strp->sk);
>  }
> 


