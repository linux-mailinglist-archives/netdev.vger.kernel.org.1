Return-Path: <netdev+bounces-280248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IrAB+fe52kBCAIAu9opvQ
	(envelope-from <netdev+bounces-280248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:32:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 247DE43F7E6
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BFA53003BEA
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B2E3988EB;
	Tue, 21 Apr 2026 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADccd10A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CE32860B;
	Tue, 21 Apr 2026 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803553; cv=none; b=h2o07/ronY8M6PzG68nCW8L60e7mxm7cBxE1SaCYDKp337+1zbFODTa44cwjC/Q3sIktFkXh6YqcFElgBuJDpAh/4/ZTqialeaTsYCYeQa2pOdcdesTQLXcdk4Ro4OxHaMxetYlz3KKYRj/pw2EH4mTKXmBP0GEsBkGcamnKcsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803553; c=relaxed/simple;
	bh=53QDOGGOwf6FATEssZuXFprNrd1l0dw43fXxNlgjXYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+bu5PZr4azUXR14h+ZKjmNUbsOCwbgg3UJJzvkJ7TwdUEUQE3S0zZ6n2uhL9t+JBjIWlDdQ/g07BtmYPlE4urVbPKFgxcgy5bMfwvlwQW0hLjvWHEtKRypZx/LRt+rYKH6XytbpfMqdqFiwkppJDvTzAc6AJU/kwK0DEpr+wrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADccd10A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C9CC2BCB0;
	Tue, 21 Apr 2026 20:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776803552;
	bh=53QDOGGOwf6FATEssZuXFprNrd1l0dw43fXxNlgjXYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADccd10A5ycsSnGcPo+Gmz69vdABaG0lxDBVNVXJtEpZzdxlH4/rPEhvWTOAJiXjh
	 UxlK27mlOFMzgSQfZOi1oSai8Fvb5tMbEMdTJYq+PNQh3ZrqKUyjPJQ3IE1pFtUYna
	 PH168oigjkyVyu0K9l+dOVuQLfMMuOg/zLOREAIDluzrPfPaXuN+J3SCvOuOM8vS+k
	 B+3cJ1F1fwNgdHynlK7lusUrtqFiYk5VG+lG4biaTu9K4b2tI711T1MU2MrBYoZi8r
	 RZprmIUBtc2PXvwAUNRNDgNEnei6oU8wsAEGovo7Lvk3cKyggb35qlKhfnaJOTwKU2
	 SXguh0WwfXZ0A==
Date: Tue, 21 Apr 2026 21:32:28 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>, stable@kernel.org
Subject: Re: [PATCH net 1/4] rxrpc: Fix memory leaks in
 rxkad_verify_response()
Message-ID: <20260421203228.GI651125@horms.kernel.org>
References: <20260420145900.1223732-1-dhowells@redhat.com>
 <20260420145900.1223732-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260420145900.1223732-2-dhowells@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280248-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 247DE43F7E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 03:58:54PM +0100, David Howells wrote:
> Fix rxkad_verify_response() to free ticket by using a __free() construct
> rather than explicitly freeing it.
> 
> Also fix rxkad_verify_response() to free the server key by using a __free()
> construct.
> 
> Fixes: 57af281e5389 ("rxrpc: Tidy up abort generation infrastructure")
> Fixes: ec832bd06d6f ("rxrpc: Don't retain the server key in the connection")
> Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>

...

> index eb7f2769d2b1..0acdc46f42c2 100644
> --- a/net/rxrpc/rxkad.c
> +++ b/net/rxrpc/rxkad.c

...

> @@ -1160,16 +1159,15 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
>  	}
>  
>  	ret = -ENOMEM;
> -	response = kzalloc_obj(struct rxkad_response, GFP_NOFS);
> +	struct rxkad_response *response __free(kfree) =
> +		kzalloc_obj(struct rxkad_response, GFP_NOFS);
>  	if (!response)
>  		goto temporary_error;
>  

Hi David,

This goto, combined with the use of __free in the declaration
of ticket below results in a compile error for x86_64 allmodconfig
with clang 21.1.8.

  net/rxrpc/rxkad.c:1165:3: error: cannot jump from this goto statement to its label
   1165 |                 goto temporary_error;
        |                 ^
  net/rxrpc/rxkad.c:1192:8: note: jump bypasses initialization of variable with __attribute__((cleanup))
   1192 |         void *ticket __free(kfree) = kmalloc(ticket_len, GFP_NOFS);
        |               ^

Moreover, the use of this construct is discouraged in Networking code:

  1.7.3. Using device-managed and cleanup.h constructs¶

  Netdev remains skeptical about promises of all “auto-cleanup” APIs,
  including even devm_ helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.

  Use of guard() is discouraged within any function longer than 20 lines,
  scoped_guard() is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.

  Low level cleanup constructs (such as __free()) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  __free() within networking core and drivers is discouraged. Similar
  guidance applies to declaring variables mid-function.

  https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

And to round things out, Sashiko also points out problems with
the use of __free() in this patch.

...

>  
>  	/* extract the kerberos ticket and decrypt and decode it */
>  	ret = -ENOMEM;
> -	ticket = kmalloc(ticket_len, GFP_NOFS);
> +	void *ticket __free(kfree) = kmalloc(ticket_len, GFP_NOFS);
>  	if (!ticket)
> -		goto temporary_error_free_resp;
> +		goto temporary_error;

...

>  temporary_error:
>  	/* Ignore the response packet if we got a temporary error such as
>  	 * ENOMEM.  We just want to send the challenge again.  Note that we
>  	 * also come out this way if the ticket decryption fails.
>  	 */
> -	key_put(server_key);
>  	return ret;
>  }
>  
> 

-- 
pw-bot: changes-requested

