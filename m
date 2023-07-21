Return-Path: <netdev+bounces-19705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2D075BC9F
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 05:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DC91C215CD
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 03:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B8E39F;
	Fri, 21 Jul 2023 03:02:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B77F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 03:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB334C433C8;
	Fri, 21 Jul 2023 03:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689908538;
	bh=iKUuOMZQqYBSqB9J+CgVXxUr5qGvS6AiXjXlER6cU8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I/nfmOZEBdGC8dqweIX3zxGJbrQfeAcrU9OzsJEwnfb6i/ItjzEPP40QeqaztfXe7
	 NY0qJ4lVXlEfYF0JOyJOPtkAOZbweLE+hQa5zcUqOnXTlZKTlvkbm8NdPeyQ0m4p+W
	 Mq6kzBo74F0agoT6coPvoqCgQpGyU3z5rfu/IrwjkOPPHSvfbOkd6pRzc6P8mo68Ve
	 lvUrPjUB/ygEuGDgJEIADl04/keCYvBG8eStkhl2JVr0FpbYcji8BTGLowxfvsVTYJ
	 AV+tEjKLpVOPyymf5tTGd44qMOv7tF4PS8j1FswEYJ2qKd8L1S2z8Z4TzGX4TvMEto
	 /NzWN0/0ivSzw==
Date: Thu, 20 Jul 2023 20:02:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
Message-ID: <20230720200216.4bf1bf4b@kernel.org>
In-Reply-To: <20230719113836.68859-7-hare@suse.de>
References: <20230719113836.68859-1-hare@suse.de>
	<20230719113836.68859-7-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jul 2023 13:38:36 +0200 Hannes Reinecke wrote:
> Implement ->read_sock() function for use with nvme-tcp.

> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
> +		     sk_read_actor_t read_actor)
> +{
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
> +	struct strp_msg *rxm = NULL;
> +	struct tls_msg *tlm;
> +	struct sk_buff *skb;
> +	struct sk_psock *psock;
> +	ssize_t copied = 0;
> +	bool bpf_strp_enabled;

bubble up the longer lines, like this:

+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
+	struct strp_msg *rxm = NULL;
+	struct sk_psock *psock;
+	bool bpf_strp_enabled;
+	struct tls_msg *tlm;
+	struct sk_buff *skb;
+	ssize_t copied = 0;
+	int err, used;

> +	int err, used;
> +
> +	psock = sk_psock_get(sk);
> +	err = tls_rx_reader_acquire(sk, ctx, true);
> +	if (err < 0)
> +		goto psock_put;
> +	bpf_strp_enabled = sk_psock_strp_enabled(psock);

You're not servicing the BPF out of band queue, just error out if
the BPF psock is enabled. It's barely used and endlessly buggy anyway.

> +	/* If crypto failed the connection is broken */
> +	err = ctx->async_wait.err;
> +	if (err)
> +		goto read_sock_end;
> +
> +	do {
> +		if (!skb_queue_empty(&ctx->rx_list)) {
> +			skb = __skb_dequeue(&ctx->rx_list);
> +			rxm = strp_msg(skb);
> +		} else {
> +			struct tls_decrypt_arg darg;
> +
> +			err = tls_rx_rec_wait(sk, psock, true, true);
> +			if (err <= 0)
> +				goto read_sock_end;
> +
> +			memset(&darg.inargs, 0, sizeof(darg.inargs));
> +			darg.zc = !bpf_strp_enabled && ctx->zc_capable;

And what are you zero-copying into my friend? zc == zero copy.
Leave the zc be 0, like splice does, otherwise passing msg=NULL
to tls_rx_one_record() may explode. Testing with TLS 1.2 should
show that.

> +			rxm = strp_msg(tls_strp_msg(ctx));
> +			tlm = tls_msg(tls_strp_msg(ctx));
> +
> +			/* read_sock does not support reading control messages */
> +			if (tlm->control != TLS_RECORD_TYPE_DATA) {
> +				err = -EINVAL;
> +				goto read_sock_requeue;
> +			}
> +
> +			if (!bpf_strp_enabled)
> +				darg.async = ctx->async_capable;
> +			else
> +				darg.async = false;

Also don't bother with async. TLS 1.3 can't do async, anyway,
and I don't think you wait for the completion :S

> +			err = tls_rx_one_record(sk, NULL, &darg);
> +			if (err < 0) {
> +				tls_err_abort(sk, -EBADMSG);
> +				goto read_sock_end;
> +			}
> +
> +			sk_flush_backlog(sk);

Hm, could be a bit often but okay.

> +			skb = darg.skb;
> +			rxm = strp_msg(skb);
> +
> +			tls_rx_rec_done(ctx);
> +		}
> +
> +		used = read_actor(desc, skb, rxm->offset, rxm->full_len);
> +		if (used <= 0) {
> +			if (!copied)
> +				err = used;
> +			goto read_sock_end;

You have to requeue on error.

> +		}
> +		copied += used;
> +		if (used < rxm->full_len) {
> +			rxm->offset += used;
> +			rxm->full_len -= used;
> +			if (!desc->count)
> +				goto read_sock_requeue;

And here. Like splice_read does. Otherwise you leak the skb.

> +		} else {
> +			consume_skb(skb);
> +			if (!desc->count)
> +				skb = NULL;
> +		}
> +	} while (skb);
> +
> +read_sock_end:
> +	tls_rx_reader_release(sk, ctx);
> +psock_put:
> +	if (psock)
> +		sk_psock_put(sk, psock);
> +	return copied ? : err;
> +
> +read_sock_requeue:
> +	__skb_queue_head(&ctx->rx_list, skb);
> +	goto read_sock_end;
> +}
> +
>  bool tls_sw_sock_is_readable(struct sock *sk)
>  {
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);


