Return-Path: <netdev+bounces-277027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCHZL9i712l0SAgAu9opvQ
	(envelope-from <netdev+bounces-277027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:46:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DABEC3CC2C8
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE4543011539
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36512DF6E6;
	Thu,  9 Apr 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3MpEIG1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1613D9DD8
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745969; cv=none; b=THKnXeoTartuZi6G5blqomIb5mHUyKK8rrmP18VAIzXWfqCCdtBsiP9pJ01YYPoP2BSQWMmN1R5IlYrdNauUc9VfZJoUVaHCeFFB5s27FkqJq/385rQQjR5hRLNXh3aXCBWZcxPuMq3mOFlvkh2lZdloeqy5VO984DY29AjZnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745969; c=relaxed/simple;
	bh=Ck9x0AEIsBXVeWrdArtBGkWtubMxpneGNl7gdFnxyB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiAZ5jUMZX4aXEhaQXJCTcHPoYzQ3Wf1Zse5ls0WTv96ms4yeNhfB2VEJFt2u398dgt8ZMLQMMz6ntAurDriPIKHwiKrzP3zY1b3oc2Dpqng087JfjtxeL4BFJHR7NiuEuXP85+epnV5NwKWORCHaWU4rqXHVLufDTsyg3oprcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3MpEIG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B4BC4CEF7;
	Thu,  9 Apr 2026 14:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775745968;
	bh=Ck9x0AEIsBXVeWrdArtBGkWtubMxpneGNl7gdFnxyB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3MpEIG1tXzE1SVuxAvUTks3Cwt+rftajY4fGo9Cyk6dc2kE8q8x2Ss8f6Xz1XVMb
	 WFB9ytzfTdJ3DL4HlFSL0/YG0YCjFNydOBg8h4ox1SbEB38blS6hBOUpImuzHhPOJV
	 MWCFa1+nGveaOU188AyBHtAIAr7AG8186R2C3DweBVVhxiT98/2KTfnVaoipl6T2nI
	 R6XVBh8Hg6vYUvYEgFYhkvjPAMEE/jjAZXP8y/ODptbd+RzlRDjdtIPDCcpuLX3pY5
	 yYBvvZcFb+fUe05j10ZdmCv50yMIQtsevk3N07aYC1a3b0OzM8byo0wufRXt98jWcK
	 02ooqvFhGLI7A==
Date: Thu, 9 Apr 2026 15:46:03 +0100
From: Simon Horman <horms@kernel.org>
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: jchapman@katalix.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] l2tp: take a session reference in pppol2tp_ioctl()
Message-ID: <20260409144603.GN469338@kernel.org>
References: <20260404133245.2391409-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404133245.2391409-1-sunyiqixm@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277027-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DABEC3CC2C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 09:32:45PM +0800, Yiqi Sun wrote:
> pppol2tp_ioctl() reads sock->sk->sk_user_data and dereferences the
> returned l2tp_session without taking a reference on it.
> 
> Since the ppp socket/session lifetime rework, session teardown runs
> asynchronously and can clear sk_user_data and drop the last session
> reference in parallel with ioctl(). This leaves ioctl() with a stale
> session pointer and can trigger a use-after-free.
> 
> Fix this by using pppol2tp_sock_to_session() in pppol2tp_ioctl() and
> dropping the session reference before returning. This matches the
> existing getsockopt/setsockopt paths.
> 
> Fixes: c5cbaef992d64 ("l2tp: refactor ppp socket/session relationship")
> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> ---
>  net/l2tp/l2tp_ppp.c | 88 +++++++++++++++++++++++++++------------------
>  1 file changed, 54 insertions(+), 34 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index ae4543d5597b..e6d7d3537180 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -1042,66 +1042,79 @@ static int pppol2tp_tunnel_copy_stats(struct pppol2tp_ioc_stats *stats,
>  static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
>  			  unsigned long arg)
>  {
> +	struct sock *sk = sock->sk;
>  	struct pppol2tp_ioc_stats stats;
>  	struct l2tp_session *session;
> +	int err;
> +
> +	err = -ENOTCONN;
> +	if (!sk->sk_user_data)
> +		goto end;

I think it would be cleaner to simply:

		return -ENOTCONN;

> +
> +	err = -EBADF;
> +	session = pppol2tp_sock_to_session(sk);
> +	if (!session)
> +		goto end;

And, similarly here.

...

> @@ -1111,15 +1124,22 @@ static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
>  		stats.tunnel_id = session->tunnel->tunnel_id;
>  		stats.using_ipsec = l2tp_tunnel_uses_xfrm(session->tunnel);
>  
> -		if (copy_to_user((void __user *)arg, &stats, sizeof(stats)))
> -			return -EFAULT;
> +		if (copy_to_user((void __user *)arg, &stats, sizeof(stats))) {
> +			err = -EFAULT;
> +			goto end_put_sess;
> +		}
> +		err = 0;
>  		break;
>  
>  	default:
> -		return -ENOIOCTLCMD;
> +		err = -ENOIOCTLCMD;

I would suggest a goto here.

> +		break;
>  	}
>  

And setting err = 0 here, rather than in multiple places above.

> -	return 0;
> +end_put_sess:

I think "out_put_session" would be a slightly better name for this label.

> +	l2tp_session_put(session);
> +end:
> +	return err;
>  }
>  
>  /*****************************************************************************
> -- 
> 2.34.1
> 

