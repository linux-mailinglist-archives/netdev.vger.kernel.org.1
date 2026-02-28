Return-Path: <netdev+bounces-262032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD3rFLpGomkJ1gQAu9opvQ
	(envelope-from <netdev+bounces-262032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:36:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2421BFC18
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 202B53033BEC
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6E82E11C5;
	Sat, 28 Feb 2026 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLu74K6L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4281E9919;
	Sat, 28 Feb 2026 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242611; cv=none; b=CAg6bwdjubFrPrv+lVk4SZDJPqCG8AUa0IkjCozBCoCkAefBo7QNyUwXia9/Li6brpvLu1VI2/hOxI4RKXn4wfl7UKw0fhRoQpby1RSJH/8UfdD/3QvanFNZsjlCCU7s2Zl3CXn08pN94WgL9GkoazZ+b0eJsNah7SHJ0dE5IlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242611; c=relaxed/simple;
	bh=c4pBVGH7zq9UuVP5amo0SjJihT/ZFkBYCMVvrDdIajo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u62J/o8PgcbLQhvTYDbY+roHyvPCQOZIClxJm2uG4lzJ94bodGGVU4A05skDIyMs6Va54/foRmbI67vHtNXyb0bbV0FwgPmt81itMjSDIm3wYg5OmNh5Ow+4ErsiiMqD1PtbtbWh7fkKLqMGCzcTA7Y+NQtmDFB4WMvyHy5pGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLu74K6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1AFC116C6;
	Sat, 28 Feb 2026 01:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772242611;
	bh=c4pBVGH7zq9UuVP5amo0SjJihT/ZFkBYCMVvrDdIajo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rLu74K6LNFeqnCrjG12I69zGopOJ/Q1p9SDQr6mDIE5Y51IOOl2zxXNdRb/48rxiH
	 yiZ3XCNKHzHaFd1imxlxpJb+57hOCR8LP25Nf0H7nnisx5zwh4xLiwqILSfIAFwu8F
	 W2CsLAPQpXaqtG7ySQR1i6INegHqf7gxIuF9qzapRLH0IvxHmZlfIT80GYzRuusl3X
	 crM9/xMJt/uKUds8AaHPQuE7gM7A8G2uo27SXbnf5Di7czq94wavlWvGA+3flKJfD9
	 B0ibDXjhAZDXcLZnDeTIaFAnYrCwCHzipAGvP/+k+C4Vdfg0Xf681PLbOg372h34Rz
	 zd32d7SrXZY+A==
Date: Fri, 27 Feb 2026 17:36:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net v3] net: core: failover: fix NULL pointer
 dereference in failover_slave_register()
Message-ID: <20260227173649.7a9f202e@kernel.org>
In-Reply-To: <20260226085601.11343-1-zeeshanahmad022019@gmail.com>
References: <20260226085601.11343-1-zeeshanahmad022019@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262032-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D2421BFC18
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 13:56:01 +0500 Zeeshan Ahmad wrote:
> Smatch warns that 'fops' is dereferenced without a NULL check.
> While other callbacks in this function properly check 'fops', the
> rx_handler registration does not.
> 
> Consolidate the NULL check for 'fops' at the beginning of the function,
> before it is first used in slave_pre_register(). This ensures 'fops' is
> valid for the entire function scope and allows the removal of redundant
> NULL checks later in the function, as suggested by Dan Carpenter.
> 
> Fixes: 30c8bd5aa8b2 ("net: Introduce generic failover module")

Not really a fix, there's only one user - net_failover and it always
passes the ops and has all callbacks.

> diff --git a/net/core/failover.c b/net/core/failover.c
> index 2a140b3ea669..47e4a91dcaa6 100644
> --- a/net/core/failover.c
> +++ b/net/core/failover.c
> @@ -59,7 +59,10 @@ static int failover_slave_register(struct net_device *slave_dev)
>  	if (!failover_dev)
>  		goto done;
>  
> -	if (fops && fops->slave_pre_register &&
> +	if (WARN_ON_ONCE(!fops))
> +		goto done;

Better still please add this check in failover_register()
so that we don't allow any device to be registered without ops.
Then you can delete all the fops checks throughout this file,
not just in this one function.
-- 
pw-bot: cr

