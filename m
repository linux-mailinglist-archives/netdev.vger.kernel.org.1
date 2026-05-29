Return-Path: <netdev+bounces-293106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBLqCSmHGWqdxQgAu9opvQ
	(envelope-from <netdev+bounces-293106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:31:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4296024A7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA3553050479
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762483DBD64;
	Fri, 29 May 2026 12:26:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579923403F1;
	Fri, 29 May 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057607; cv=none; b=rJi8q7Z1+qXXs8t07CXZXrrF4wmema+T/+r+VO49w3E/NHdLdTwC1at7S1SmxXb61nwCcPMgxvf8za+3zlfzZQ921ytLrGvhPF9Iy/cc4KMBjn/FjPd/vxxlBYUgo37rdXJbrMFXHFSykBtwgszpwv+Pl3fwYeIWpDF+oZKHCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057607; c=relaxed/simple;
	bh=8BCaMPr6FFES6C0ZoXn3/7zbtnGXDNpjgbko4Q9keeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6NhrL4k4xD3QaHSxgWSqmrmgaODrU1floVN+1KEQBo/BBlOI5WJPsFkf8qmKhK9j1/BSOjht1FmuHvI08JbX4nl1754OqlZagZVkqzLPkmtvWbF00Hni/rqkPZOlWmWm1aC+a6k4i/NKoDuQhu6c9trBIbz+HoL1nx8WgzWja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E272C60595; Fri, 29 May 2026 14:26:42 +0200 (CEST)
Date: Fri, 29 May 2026 14:26:42 +0200
From: Florian Westphal <fw@strlen.de>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: policy: Fix use-after-free on inexact bin in
 xfrm_policy_bysel_ctx()
Message-ID: <ahmGAgwpJx0OFKe7@strlen.de>
References: <CAOrxSK7v1BK_KsrfreHHAbfthAMDCZOBpOrCtzAjff1Wx-gr6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOrxSK7v1BK_KsrfreHHAbfthAMDCZOBpOrCtzAjff1Wx-gr6w@mail.gmail.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293106-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Queue-Id: 7A4296024A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sanghyun Park <sanghyun.park.cnu@gmail.com> wrote:
> Fix by pruning the bin while still holding xfrm_policy_lock, before
> dropping it. Use __xfrm_policy_inexact_prune_bin() directly since the
> lock is already held. This is safe because the function uses
> kfree_rcu() for the actual free, which is non-blocking. The wrapper
> xfrm_policy_inexact_prune_bin() becomes unused and is removed.
> 
> Race:
> 
>   CPU0 (XFRM_MSG_DELPOLICY)         CPU1 (XFRM_MSG_NEWSPDINFO)
>   ============================       ==========================
>   xfrm_policy_bysel_ctx():
>     spin_lock_bh(xfrm_policy_lock)
>     bin = xfrm_policy_inexact_lookup()
>     __xfrm_policy_unlink(pol)
>     spin_unlock_bh(xfrm_policy_lock)
>     xfrm_policy_kill(ret)
>     // wide window, lock not held
>                                      xfrm_hash_rebuild():
>                                        spin_lock_bh(xfrm_policy_lock)
>                                        __xfrm_policy_inexact_flush():
>                                          kfree_rcu(bin)  // bin freed
>                                        spin_unlock_bh(xfrm_policy_lock)
>     xfrm_policy_inexact_prune_bin(bin)
>     // UAF: bin is freed

This changelog is fine, rest is too verbose.

> Fixes: 9cf545ebd5d8 ("xfrm: policy: implement selector-based inexact lookup")

There is no such commit, neither ID nor subject.
If you use AI assistance, please check for hallucinations.

Probably:
Fixes: 6be3b0db6db8 ("xfrm: policy: add inexact policy search tree infrastructure")

> + if (bin && ret && delete)
> + __xfrm_policy_inexact_prune_bin(bin, false);

Looks like this patch is whitespace-damaged.
Could you also say in changelog why you added the 3rd criterion?

> - if (bin && delete)

Became (bin && ret && delete).

