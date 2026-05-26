Return-Path: <netdev+bounces-291865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL75FvLeFWqCdgcAu9opvQ
	(envelope-from <netdev+bounces-291865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:57:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDB85DB071
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797DF3132211
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F4B41C2FC;
	Tue, 26 May 2026 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0me14/J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489141B35C;
	Tue, 26 May 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816837; cv=none; b=bSoMuvgUBwanjxVLjKJURo11D3wHGSi2VZ7nTGD4BeXBocJU7CyW/PdDVOBEwSksbVyAdwV/Sm1BnzvKFAmBlAT21yYnuKvkXR4aqHqepTZaNW6v+XpSuu4Hvfi5g4iRjcwnNnu2abZ7Rs6480tTpUKNaE8TlIC6wB1MD3hjq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816837; c=relaxed/simple;
	bh=GsILhnnbVdoVwhECB8dRPg9InXwIw88e24tD7opTjpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K37kcuO/SINETxmAUlq8FV4+rofHyB/7bPpQ/zHc9crooqoomp8PaYDVQ+pqjjk7ycJbdMb86ZZvrxKZRVHOgnrDOrGvus95FkYw4ZpmbhLGYePtmxyidgTmxpsxje9z6m9E8LhtobeTe6Sk4mKuKvT/EFu0ta1lnRtuTqWZTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0me14/J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F080C1F000E9;
	Tue, 26 May 2026 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779816836;
	bh=gjpURTv2c2v2N9HFm7TiQlpaPA7lIpsocmrTHwzlbC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D0me14/JXHDqcpJ5hAQo4YDQ9P52gJBHzw8bO+6KZ4YoJ6FP2H1vzhnvT4bXKpxba
	 hMEITNQlUiJAQ/KWnaay0rduiIE7hrsHNjcgtHtyHmaIwbxryQq/++sD37bsrqGvy+
	 qWQTFAnGM+nx864ARTLkHXpfTskJ5QQhkVeHK6xFRD1NLkpFRBlDscHXqmGn0RBXal
	 AN144hIuXT3zFjXVcWQ4Y1pE/HkUE4v5XAkadJoAOyoEIL4RAhOoIw2xowA2P2H4KY
	 AY23x0qszNBQvPEFjc4tEwg8Milo/z1ajdMbfUgOS6fC0fJ0G04q03KMUjSQPrGuBP
	 pu3z3BeOvjh6g==
Date: Tue, 26 May 2026 18:33:51 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Heidelberg <david+nfc@ixit.cz>,
	Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH net v2 0/2] nfc: llcp: two fixes for nfc_llcp_getsockopt()
Message-ID: <20260526173351.GB2256768@horms.kernel.org>
References: <20260521-fix_llc-v2-0-ab44cc09179c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-fix_llc-v2-0-ab44cc09179c@debian.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-291865-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,horms.kernel.org:mid]
X-Rspamd-Queue-Id: ABDB85DB071
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 07:32:08AM -0700, Breno Leitao wrote:
> While converting the NFC LLCP socket layer to the new getsockopt_iter()
> API, I noticed that nfc_llcp_getsockopt() unconditionally stores four
> bytes through a (u32 __user *) cast regardless of the caller-supplied
> optlen, overflowing the user buffer when optlen < 4. Patch 1 adds an
> explicit length check (with a signed-int guard so a negative optlen
> cannot slip past it) and is what I originally sent as v1.
> 
> While reviewing v1, Simon/sashiko[1] pointed out that llcp_sock->local
> is read outside lock_sock(sk) and can be freed by a concurrent
> llcp_sock_bind() error path before getsockopt() dereferences it. Patch
> 2 moves the load and the NULL check inside the lock. Both fixes target
> the same original commit, so they are now sent together as a two-patch
> series.
> 
> Note: These fixes were compile-tested.
> 
> [1] https://lore.kernel.org/all/20260513-fix_llc-v1-1-33c76f931ff6@debian.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Guard the length check against negative optlen (Simon Horman / sashiko).
> - Add patch 2: move llcp_sock->local read inside lock_sock(sk) to close
>   a UAF race with llcp_sock_bind() (Simon Horman / sashiko).
> - Link to v1: https://patch.msgid.link/20260513-fix_llc-v1-1-33c76f931ff6@debian.org

Thanks for the update.

There is an AI-generated review of this patch on sashiko.dev.
It looks like it flags pre-existing issue that doesn't directly
impact the intent of this patch-set. So I don't believe it should delay
progress of this patch-set.

Reviewed-by: Simon Horman <horms@kernel.org>


