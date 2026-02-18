Return-Path: <netdev+bounces-259244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMsMGfeJlWnqSAIAu9opvQ
	(envelope-from <netdev+bounces-259244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:44:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B173154D11
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59237300EA97
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F231A326922;
	Wed, 18 Feb 2026 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpJw3aqc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96731B814
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407860; cv=none; b=XaOfYeJ2z/ZygOP845yJap/Q7N5UjlUoCfo2KlST1XfFsysSKRpQaIK92FOFtpJVYKSIiDnOuJ++5chnijkS6oVsxV2C7fp2+U48CG4rO5Fw5vYKoXYdF5gcSYbUlMoGKPJU9zTbr3mn55A7hxe+bDwXTggqpdN6MKLH6qysb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407860; c=relaxed/simple;
	bh=DvBwpAu06e6aj8xMNAmhq7qBsezlWGDqujytLeNzUcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHlowH+s9wgh4ZEtV708L24J1qzc5HIZd2LEWB3rHaegVbHTHcgmlaVfurLmpgl8louNFqIkQotNZcr+zsXy6UMrc8yFcpLkDZKz5AOB1MeU0jhUYkM/Msv8+yPjz0lvqA8PpJetNeLkV/0SB9md0Omdo3r0Fh9CFfpE5afwbuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpJw3aqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A73C19421;
	Wed, 18 Feb 2026 09:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771407860;
	bh=DvBwpAu06e6aj8xMNAmhq7qBsezlWGDqujytLeNzUcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpJw3aqcxAkE/64jTro2O9TAHqKR0qTIB+mH8brhyHWqFsTW4C98TeGsil2Mb06zL
	 lz89ACOlYciFPp4g7/rC1ANToDTUC7uvWHBdIO6QwX8qjnKjPd7akZKIHUzXW/wVax
	 vjiQ4aYA4yI0K6Dk8E565D65Eq/vSLyuZTu/18Sqed/gVCZDNdCtkifv5SNEYABQzn
	 CFC5PkNTjLDgQMoHWpVQYIDF2V0sl49ADo7BLMdnXaLfjzpfJ9xCUU85Nq9bhtikps
	 CIyjDZouuUNu2tAlPgYIMGwmr0WJtmqIuxU/lJpmC8ckmtaJ2tzfchPFWAGSuc1GLg
	 SUaJrqNDW+ncA==
Date: Wed, 18 Feb 2026 09:44:16 +0000
From: Simon Horman <horms@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net v2] espintcp: Fix race condition in espintcp_close()
Message-ID: <aZWJ8KeUttdEIi3v@horms.kernel.org>
References: <aZSie7rEdh9Nu0eM@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZSie7rEdh9Nu0eM@v4bel>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259244-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,get_maintainer.pl:url]
X-Rspamd-Queue-Id: 9B173154D11
X-Rspamd-Action: no action

+ Sabrina

On Wed, Feb 18, 2026 at 02:16:43AM +0900, Hyunwoo Kim wrote:
> This issue was discovered during a code audit.
> 
> After cancel_work_sync() is called from espintcp_close(), 
> espintcp_tx_work() can still be scheduled from paths such as 
> the Delayed ACK handler or ksoftirqd.
> As a result, the espintcp_tx_work() worker may dereference a 
> freed espintcp ctx or sk.
> 
> The following is a simple race scenario:
> 
>            cpu0                             cpu1
> 
>   espintcp_close()
>     cancel_work_sync(&ctx->work);
>                                      espintcp_write_space()
>                                        schedule_work(&ctx->work);
> 
> To prevent this race condition, cancel_work_sync() is 
> replaced with disable_work_sync().
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v2:
> - Shorten the patch subject
> - Target the net tree
> - Add the bug discovery background and the race scenario to the commit message
> - v1: https://lore.kernel.org/all/aZLmvv51f5Iu9G7b@v4bel/

Thanks for taking my review into account [1].
This version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

It seems that get_maintainer.pl highlights that Sabrina is also a
maintainer, so I have CCed here and left the full context of the
patch in place for her convenience.

[1] https://lore.kernel.org/netdev/aZSbSOVuRgkjeezg@v4bel/

> ---
>  net/xfrm/espintcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> index bf744ac9d5a7..8709df716e98 100644
> --- a/net/xfrm/espintcp.c
> +++ b/net/xfrm/espintcp.c
> @@ -536,7 +536,7 @@ static void espintcp_close(struct sock *sk, long timeout)
>  	sk->sk_prot = &tcp_prot;
>  	barrier();
>  
> -	cancel_work_sync(&ctx->work);
> +	disable_work_sync(&ctx->work);
>  	strp_done(&ctx->strp);
>  
>  	skb_queue_purge(&ctx->out_queue);
> -- 
> 2.43.0
> 

