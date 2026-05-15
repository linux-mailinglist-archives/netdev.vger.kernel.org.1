Return-Path: <netdev+bounces-288441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOX2IqN+B2qQ5gIAu9opvQ
	(envelope-from <netdev+bounces-288441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:14:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E368C557559
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0CF0301D328
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB333909B7;
	Fri, 15 May 2026 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbHpVugY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04712BE639;
	Fri, 15 May 2026 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876059; cv=none; b=IZINDWIQ1osRijTribQ+FJsH6pWCXZ4sAy4Bcaz/UTNC7om7DZJEtxT7pGVxm7TYMCccgIBjlqFThxDy0cGdski858zKVB05sQG7KYJukxUzHmTFZHlkY65GhFGXYw9LCntOaSCJOrpcxH79FXyYZrqqeTgPWUO1aqYDXkExNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876059; c=relaxed/simple;
	bh=ulJYPETGiLGFPMwIPDuffMKtTKgscUihrnQ20VnSf3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBjy+LW4m4VjlgZWi+Nc26m4ANXaGfUJVmYyx8c26ZKIeSydaBFCFjCHpgJES71+wSPdbWCRw4qEE7E+stb3XVWyfjFVyYpHrCWpLKZJe+L5kos6Dm+dDOzrowz2T5/Zr0CSPU9v9XReB6y4Ol615tTb/gfngYrjjUIbho1G7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbHpVugY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758B5C2BCB0;
	Fri, 15 May 2026 20:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778876058;
	bh=ulJYPETGiLGFPMwIPDuffMKtTKgscUihrnQ20VnSf3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbHpVugYTdJr3pf45pLdYehV4qtwpK4UAogLIeYx/NXlWj5ZYZC80Ng3A/u6XOOZf
	 tnqmPM8stpaCnnbw1y0qZZWvjLgrwE8zMyzqHIou4Kr5VPEF58jRjGzLVsjuNjUukx
	 wv/zRcOl8Ksh+lO0Mo2TjipmoPS1dTapXGGOkdIdxrSymyoAOmvkMwe1cfvG0kzwub
	 3usOOC8ecYfZwPu4d4IkCmV4wT0/uRYNsODFdAGc4245h6EqqgXmHxEyVHvNV1U5G1
	 C1Y4mVRmqYYunh2ecPnrHA/IWYu8ZrmzPakHiuIPgYLDLo19qk8u2xB7scGQ87/QW0
	 UqlVrmMwbUEzw==
Date: Fri, 15 May 2026 20:14:16 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/5] net/rxrpc: Use local FCrypt-PCBC
 implementation
Message-ID: <20260515201416.GA3484095@google.com>
References: <20260508182318.GA4145640@google.com>
 <20260428024400.123337-3-ebiggers@kernel.org>
 <20260428024400.123337-1-ebiggers@kernel.org>
 <286248.1778263325@warthog.procyon.org.uk>
 <287476.1778266603@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <287476.1778266603@warthog.procyon.org.uk>
X-Rspamd-Queue-Id: E368C557559
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288441-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 07:56:43PM +0100, David Howells wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > Also I'm waiting to see if the following patch gets merged:
> > https://lore.kernel.org/netdev/20260502211340.446927-1-n7l8m4@u.northwestern.edu/
> 
> This is the favoured solution:
> 
> 	https://lore.kernel.org/netdev/af2kdW2F1gJ9U-Gg@v4bel/
> 
> The problem with the one you mentioned is that it does a mandatory copy, even
> when it doesn't need to, for rxgk.  I can benchmark that to see what the
> performance impact it has.

Seems that the latest is now
https://lore.kernel.org/netdev/20260514155304.2249591-4-dhowells@redhat.com/
which is back to just using a linear buffer unconditionally.  I'll
resend this series after that goes in.

- Eric

