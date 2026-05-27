Return-Path: <netdev+bounces-292307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DnZEmb3FmrUywcAu9opvQ
	(envelope-from <netdev+bounces-292307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:53:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C17725E55D7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA9773003ECC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2189382F31;
	Wed, 27 May 2026 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2tVTVSB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A53A7F4D;
	Wed, 27 May 2026 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889581; cv=none; b=sjaWJ2gMIZ7X1UaJAq4ABQwJod1Be/GnU21NtCrEKo1BM66trzzs56roy5t04yIF0KDrgcTDnZenjO8VqY1ErrAkx8w9rPPukXBOUVK/zcLrfYpZsXcdf3814OEbsoda1nK9Bn0AJuKx7wqnNTtRQDyLYiHTcnpQZVk2U/b9cEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889581; c=relaxed/simple;
	bh=91GYMrmhhx6Kj9QDncfbNQAO2jkWpUC93EBZTHL8l+0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCz1HoiksA9nXQ6749PKeqRi9lY6MJszK8bH2B4lcx4zDgOiGKwMKwHQBXE12HtEBUdxk5vwIEEr0NE5J2eNtQPfhsEN+JYdLi809Pf9vu9fWXCV7osYVdSjaE3V0cwUgeJb/nWD9s43D+B08WuCni5UsVgAbS+6L5sV7X5mrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2tVTVSB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EC11F000E9;
	Wed, 27 May 2026 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779889578;
	bh=SYXydJ7USR0jL+36aDhHGyobRYuIw5GtTlDda6B6EJs=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=L2tVTVSBrsUGcFa2fXce34yA2he9M95kAfEQ1r50t7R6cyWxko2t/SMvemVvRy1dH
	 I718LoWzfhazxSP7S2OYJc7zPQfiWtpinx//Sn2dWTFqaHP0b9f1vztYAdGWmqjWZP
	 UNqTnVTwiBNpG+q3SpJ1Rmk6+Y2CJRB+/bPHqrhfbVVWgJDiRAz873E/GsbWGSOi9h
	 8XWG0GaOcGP+RE/UW3DoBXLcH34ZjN17T2UXkufuaRfLRlwYz5GnyIS6GqWQ8JQMGC
	 xBxbTDoum31ViYUmQquyB7xYdRPjLmaPdu+STwHgVYiHYs0UIik1XfDPt7qG4A6yGn
	 ztEErDScK0YOA==
Date: Wed, 27 May 2026 14:46:14 +0100
From: Lee Jones <lee@kernel.org>
To: James Chapman <jchapman@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] l2tp: pppol2tp: hold reference to session in
 pppol2tp_ioctl()
Message-ID: <20260527134614.GB19682@google.com>
References: <20260527133630.2120612-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527133630.2120612-1-lee@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292307-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C17725E55D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026, Lee Jones wrote:

> pppol2tp_ioctl() read sock->sk->sk_user_data directly without any
> locks or reference counting.  If a controllable sleep was induced during
> copy_from_user() (e.g. via a userfaultfd page fault sleep), a concurrent
> socket close could trigger pppol2tp_session_close() asynchronously.  This
> frees the l2tp_session structure via the l2tp_session_del_work workqueue.
> Upon resuming, the ioctl thread dereferences the stale session pointer,
> resulting in a Use-After-Free (UAF).
> 
> Fix this by securely fetching the session reference using the RCU-safe,
> refcounted helper pppol2tp_sock_to_session(sk) on entry.  This locks the
> session's refcount across the sleep.  We structured the function to exit
> via standard err breaks, guaranteeing that l2tp_session_put() is cleanly
> called on all return paths to drop the reference.
> 
> To preserve existing behavior we validate the session and its magic
> signature only for the specific L2TP commands that require it.  This
> ensures that generic/unknown ioctls called on an unconnected socket
> still return -ENOIOCTLCMD and correctly fall back to generic handlers
> (e.g. in sock_do_ioctl()).

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")

> Signed-off-by: Lee Jones <lee@kernel.org>
> 
> ---
> v1 => v2: Restrict session validation in pppol2tp_ioctl() to L2TP specific
>           commands to preserve generic socket ioctl fallback and perform
>           checks silently to mitigate WARN_ON() DoS risks.
> 
>  net/l2tp/l2tp_ppp.c | 82 +++++++++++++++++++++++++++------------------
>  1 file changed, 50 insertions(+), 32 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 99d6582f41de..e0b1915be1a6 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -1045,64 +1045,76 @@ static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
>  {
>  	struct pppol2tp_ioc_stats stats;
>  	struct l2tp_session *session;
> +	int err = 0;
> +
> +	session = pppol2tp_sock_to_session(sock->sk);
>  
> +	/* Validate session presence and magic integrity ONLY for commands
> +	 * that belong to L2TP and require a valid session.
> +	 */
>  	switch (cmd) {
>  	case PPPIOCGMRU:
>  	case PPPIOCGFLAGS:
> -		session = sock->sk->sk_user_data;
> +	case PPPIOCSMRU:
> +	case PPPIOCSFLAGS:
> +	case PPPIOCGL2TPSTATS:
>  		if (!session)
>  			return -ENOTCONN;
>  
> -		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
> +		if (session->magic != L2TP_SESSION_MAGIC) {
> +			l2tp_session_put(session);
>  			return -EBADF;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
>  
> +	switch (cmd) {
> +	case PPPIOCGMRU:
> +	case PPPIOCGFLAGS:
>  		/* Not defined for tunnels */
> -		if (!session->session_id && !session->peer_session_id)
> -			return -ENOSYS;
> +		if (!session->session_id && !session->peer_session_id) {
> +			err = -ENOSYS;
> +			break;
> +		}
>  
> -		if (put_user(0, (int __user *)arg))
> -			return -EFAULT;
> +		if (put_user(0, (int __user *)arg)) {
> +			err = -EFAULT;
> +			break;
> +		}
>  		break;
>  
>  	case PPPIOCSMRU:
>  	case PPPIOCSFLAGS:
> -		session = sock->sk->sk_user_data;
> -		if (!session)
> -			return -ENOTCONN;
> -
> -		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
> -			return -EBADF;
> -
>  		/* Not defined for tunnels */
> -		if (!session->session_id && !session->peer_session_id)
> -			return -ENOSYS;
> +		if (!session->session_id && !session->peer_session_id) {
> +			err = -ENOSYS;
> +			break;
> +		}
>  
> -		if (!access_ok((int __user *)arg, sizeof(int)))
> -			return -EFAULT;
> +		if (!access_ok((int __user *)arg, sizeof(int))) {
> +			err = -EFAULT;
> +			break;
> +		}
>  		break;
>  
>  	case PPPIOCGL2TPSTATS:
> -		session = sock->sk->sk_user_data;
> -		if (!session)
> -			return -ENOTCONN;
> -
> -		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
> -			return -EBADF;
> -
>  		/* Session 0 represents the parent tunnel */
>  		if (!session->session_id && !session->peer_session_id) {
>  			u32 session_id;
> -			int err;
>  
>  			if (copy_from_user(&stats, (void __user *)arg,
> -					   sizeof(stats)))
> -				return -EFAULT;
> +					   sizeof(stats))) {
> +				err = -EFAULT;
> +				break;
> +			}
>  
>  			session_id = stats.session_id;
>  			err = pppol2tp_tunnel_copy_stats(&stats,
>  							 session->tunnel);
>  			if (err < 0)
> -				return err;
> +				break;
>  
>  			stats.session_id = session_id;
>  		} else {
> @@ -1112,15 +1124,21 @@ static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
>  		stats.tunnel_id = session->tunnel->tunnel_id;
>  		stats.using_ipsec = l2tp_tunnel_uses_xfrm(session->tunnel);
>  
> -		if (copy_to_user((void __user *)arg, &stats, sizeof(stats)))
> -			return -EFAULT;
> +		if (copy_to_user((void __user *)arg, &stats, sizeof(stats))) {
> +			err = -EFAULT;
> +			break;
> +		}
>  		break;
>  
>  	default:
> -		return -ENOIOCTLCMD;
> +		err = -ENOIOCTLCMD;
> +		break;
>  	}
>  
> -	return 0;
> +	if (session)
> +		l2tp_session_put(session);
> +
> +	return err;
>  }
>  
>  /*****************************************************************************
> -- 
> 2.54.0.746.g67dd491aae-goog
> 

-- 
Lee Jones

