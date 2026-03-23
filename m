Return-Path: <netdev+bounces-270464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPlmFUcYwWn5QQQAu9opvQ
	(envelope-from <netdev+bounces-270464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:39:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D62F052C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 710C2300C3B0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D037E2E6;
	Mon, 23 Mar 2026 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="KH5kXMzR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KwA12vbP"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECE385507
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261942; cv=none; b=qNXC5ZwVaUqQTJRS6wXhMi4WI+v8QKiyd9Sph2VJTZ93ocfm5aZS7pZ+U0pDciNjNPjIGwr+KgI5OpNEsmsUIiaTxKKwqC/RHSrGCQ1E+4g+c1+HyNP5b80z20XQ3TUlFSOkUOoIZJnP+8MHR1a3FnWVO+IUY8RMFWeH+q0ZtAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261942; c=relaxed/simple;
	bh=Jbm3gL9m+5ehEdpaNRD6Q+tk2vD2OrCJCif7iJG7zlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7Xyk+nz617VImQjPUE3ljWyj8/V1YWP6D+kaytFYExxFQ5DsQtfm+PJdTCq2uRAFbPI4WOwd1GMrPyK8qKM5oUpf9U3JtohDJdVkCuUQgRgP7bQJWirjQCPBiZB7/+lYiSQRYaFioY3CorRNqjFZ743qgUmLgxCMP+5QotABzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=KH5kXMzR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KwA12vbP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C4286EC0128;
	Mon, 23 Mar 2026 06:32:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 23 Mar 2026 06:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774261939; x=
	1774348339; bh=hJduocjrXMFZdNZhvfojWfHM8U/AGpgvy3BJBMoTKxE=; b=K
	H5kXMzRJLCRfKUx7xm9MpURHHqr3pewIUOO+/z4FBwNYkU1njyUbv6vGG8B+OkIA
	A00SYtxt61lmb+9eD8GdqoCaufUyD3IUiqwXHLID53sIl2RiME+kgZPb4S7GWJcc
	ngHv5Yzxap9NMfbXO3FUHe/CkVxcW8Lv0EQ+DWVhSEuLsuxnYRVwyIPniGJLnPLb
	i+6dW+awYUxIpMV+qCCtVyUftVYHDJzDEGo7VHG1iIifbJeWBTUU4H5AaxNcQzRI
	qg/PzwqcF3RTwqQOQBNiaIfjQNHLrW7KAJkwz741+RbwL7JI1A1/9r8TqkkACZ/3
	BHqYpXPjckz/y2TDEa8bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774261939; x=1774348339; bh=hJduocjrXMFZdNZhvfojWfHM8U/AGpgvy3B
	JBMoTKxE=; b=KwA12vbPnobgmBTINviBQc0sZ6Gs8d2Vqf3Hg4t9diV0UP1Q0X6
	pSQA1Feaoxuit7rw0hgA2SVwgJcEFTX1nOcq+BfkrCEHXeVJQamMyulNQt5Aw7WQ
	V5rGtVwdX8YD5IndRMGcmab9vpeUGl4GLvAfX6oDaIEhZCHU2hPtqXj/gxFpD6Zk
	JMYQulgN8LzhddTc5xeir02Ksx0IhMNRBGgDWkTG3/Y6cQhtW2EuZbEe07gJTaBt
	IAD+jOcvfD1xsnw9O/mVwTcvTsQNwU6c6MpVVMLBUVFd0HFjdLCjVlJt1wU7doUP
	cMVlWOPLujoVRpGFR7V7PEkUyPMCf5yqi9g==
X-ME-Sender: <xms:sxbBad6-KzjXQzGArpRJEKYiXEoTkQEQELVgyABF521khGEsxh7Cag>
    <xme:sxbBaU7WrCUy7dskj7vNRBD83XcUKN2lP9iRY3NdzGprLfOMNzjp-bbu6Ydb07aig
    rld6SdW6y1C28h0MuFh9f65vHYSGLmaJlTfTXbqG8BBv37VIuYUZ9Vo>
X-ME-Received: <xmr:sxbBabHhR6-mGeECY53f50Qq0sy_QETVEBB0OJPeMygSynNC8PkcilIKcauv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgr
    nhgtihhsseifuggtrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
X-ME-Proxy: <xmx:sxbBaUUcRKQHp3AJ3mhyYLWlwAL23TY2CylV68gH0YZS7dgAXVz2kw>
    <xmx:sxbBafVXxYqtytoDDvxVGCKasEoA28FHZV-wJR6mhqQOs4qG6dw68w>
    <xmx:sxbBaaJxnCEYpKW3yB-n0uoSWyXvgPDAmS_EpEJlGr-4_CN3ttI9mw>
    <xmx:sxbBafDCKaJTTLHjwnUfwVNDWGcGsV4F6oPq6PT3AlxwG1R41vs_LQ>
    <xmx:sxbBaZqjAON9OzSwlUmxNHZiJUj-BfmPDRU54vNs6hrbyN4tnSo4Y6hN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 06:32:19 -0400 (EDT)
Date: Mon, 23 Mar 2026 11:32:17 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH PATCH net-next v4 5/8] tls: Suppress spurious
 saved_data_ready on all receive paths
Message-ID: <acEWsQOtWq3B62yi@krikkit>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-5-ab1086ec600f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317-tls-read-sock-v4-5-ab1086ec600f@oracle.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270464-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,wdc.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 4E9D62F052C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-17, 11:04:18 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Each record release via tls_strp_msg_done() triggers
> tls_strp_check_rcv(), which calls tls_rx_msg_ready() and
> fires saved_data_ready(). During a multi-record receive,
> the first N-1 wakeups are pure overhead: the caller is
> already running and will pick up subsequent records on
> the next loop iteration. The same waste occurs on the
> recvmsg and splice_read paths.

nit: splice_read is less of a problem since it doesn't loop over
records?


[...]
> +void tls_strp_check_rcv_quiet(struct tls_strparser *strp)
> +{
> +	if (unlikely(strp->stopped) || strp->msg_ready)
> +		return;
> +
> +	if (tls_strp_read_sock(strp) == -ENOMEM)
> +		queue_work(tls_strp_wq, &strp->work);
> +}

c/p of tls_strp_check_rcv isn't nice. Add a 'bool wake_up' argument
instead? [but see the comment about recvmsg]


>  void tls_strp_check_rcv(struct tls_strparser *strp)
>  {
>  	if (unlikely(strp->stopped) || strp->msg_ready)
> @@ -551,6 +566,8 @@ void tls_strp_check_rcv(struct tls_strparser *strp)
>  
>  	if (tls_strp_read_sock(strp) == -ENOMEM)
>  		queue_work(tls_strp_wq, &strp->work);
> +	else if (strp->msg_ready)
> +		tls_rx_msg_ready(strp);

Since that's now the only caller of tls_rx_msg_ready, and all that
does is call saved_data_ready, inline it here?

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 07f4a3d1a6f854acc7762608cc7741b3de95c195..381a723b6cacc669e333752af34f051f296d6f52 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1384,7 +1384,10 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>  			return ret;
>  
>  		if (!skb_queue_empty(&sk->sk_receive_queue)) {
> -			tls_strp_check_rcv(&ctx->strp);
> +			/* tls_strp_check_rcv() is called at each receive
> +			 * path's exit before the socket lock is released.
> +			 */

I'm not convinced this comment will make sense to someone reading the
code outside of reviewing this series.

> +			tls_strp_check_rcv_quiet(&ctx->strp);
>  			if (tls_strp_msg_ready(ctx))
>  				break;
>  		}
> @@ -1867,9 +1870,9 @@ static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
>  	return 1;
>  }
>  
> -static void tls_rx_rec_done(struct tls_sw_context_rx *ctx)
> +static void tls_rx_rec_release(struct tls_sw_context_rx *ctx)
>  {
> -	tls_strp_msg_done(&ctx->strp);
> +	tls_strp_msg_release(&ctx->strp);
>  }
>  
>  /* This function traverses the rx_list in tls receive context to copies the
> @@ -2150,7 +2153,7 @@ int tls_sw_recvmsg(struct sock *sk,
>  		err = tls_record_content_type(msg, tls_msg(darg.skb), &control);
>  		if (err <= 0) {
>  			DEBUG_NET_WARN_ON_ONCE(darg.zc);
> -			tls_rx_rec_done(ctx);
> +			tls_rx_rec_release(ctx);
>  put_on_rx_list_err:
>  			__skb_queue_tail(&ctx->rx_list, darg.skb);
>  			goto recv_end;
> @@ -2164,7 +2167,8 @@ int tls_sw_recvmsg(struct sock *sk,
>  		/* TLS 1.3 may have updated the length by more than overhead */
>  		rxm = strp_msg(darg.skb);
>  		chunk = rxm->full_len;
> -		tls_rx_rec_done(ctx);
> +		tls_rx_rec_release(ctx);
> +		tls_strp_check_rcv_quiet(&ctx->strp);

This one worries me: if tls_strp_check_rcv_quiet() sets msg_ready=1
without calling saved_data_ready. If we break out of the loop after
this, the final tls_strp_check_rcv() just before returning from
tls_sw_recvmsg() will do:

void tls_strp_check_rcv(struct tls_strparser *strp, bool wake_up)
{
	if (unlikely(strp->stopped) || strp->msg_ready)
		return;
[...]

and not call saved_data_ready?

-- 
Sabrina

