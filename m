Return-Path: <netdev+bounces-293678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKwAN1tiHWojZwkAu9opvQ
	(envelope-from <netdev+bounces-293678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:43:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 279D561DC49
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ED5A3061005
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE3F356770;
	Mon,  1 Jun 2026 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PRtERTEV"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1135200A;
	Mon,  1 Jun 2026 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309949; cv=none; b=iE+u1AoKRohv42EdigfHsCGoRzjAj6+eW/SXQ5OlJkCHvR2fqQ7rTVXCWZwhhSdEEblKDx/vpLo4y689DsLY5GZmd59hMwoBp6XUyYrxg9L5xEY/udKDLzTEZnRGOA+6KJeSJwGJ5h+lK5pn0pGvfQrPqXuh4ssX+O+FaqfJj50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309949; c=relaxed/simple;
	bh=VQwiCzcOdw0Adro3cxvtHVL9YH9j1GP9QvHvryBdXcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDSYLx8EvGhO5biHwxOrtg/BP0DrKjiV40BZ2vgA8YWmMkQ6sghXR3Sl+GA9Ys3j0o7mmGHYmNqYnHoi/M7aj6LSY5qPPu5axjA7nQhl4rQZzJg9bqw1Dj7UH91R/gA4mifCLNpmOUFwSPlzJogb1iVARQ15lkINT1nXDcC1GMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PRtERTEV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mjd23Kgn+OQuLOU7nkSV1Rk7XW63KckLhd0WPzPzy7g=; b=PRtERTEVx6om/n+OxL1c1teWYi
	lUktKPM2tsNpyx0SUW7N3jZ7iKtR/iZ00K1BO4NjrjRTFk9q2/ihm0QjPgFBFlOL4B21vc3uCMA1o
	rgAjjTfDt8d9XgvxLaj1vZI4I7ljBxByuir2YX53sA31xq8RFNqAobkc5YcUHs9VjdW9Z97ydrp+U
	TtNtsS7o7mORgMr0zx/RaUbMAsQ1oFthrXV+XWzP0uoLU36uY1XW1Ic7H3ELBRN+iQ4qjptYXDN7v
	RRx7jSaPK0jVXT1uJB29B3SksapUIjXd+b+nnDqjCvGkDUWiDQkk8p3auku7SRkXibH5cUMCnC0a1
	mrmBADvw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wTzwD-00275R-13;
	Mon, 01 Jun 2026 10:32:05 +0000
Date: Mon, 1 Jun 2026 03:31:59 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neil Horman <nhorman@tuxdriver.com>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net 0/3] netconsole: Fix reported problems
Message-ID: <ah1fWCmoaRkrwf5T@gmail.com>
References: <20260529-netcons_fix_before_move-v1-0-cb2d1426dd75@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-netcons_fix_before_move-v1-0-cb2d1426dd75@debian.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-293678-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,tuxdriver.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 279D561DC49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 03:45:10AM -0400, Breno Leitao wrote:
> These are some of the issues that LLM reported to netconsole, and they
> are being addressed here before big refactors.
> 
> I was doing some big refactors, and got some "pre-existent-issues"
> during LLM review of the refactor, that make them hard to guarantee that
> refactor is not introducing any bug, so, let's clean these pre-existent
> bugs first, and then submit the refactor.
> 
> The issues fixed in this patchset were reported during the review of
> https://lore.kernel.org/all/20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org/
> 
> Not all of them got fixed, but, those that were easy to reason about.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Somehow this patch haven't applied to 'net' tree and the tests haven't
run.

https://patchwork.kernel.org/project/netdevbpf/patch/20260529-netcons_fix_before_move-v1-1-cb2d1426dd75@debian.org/

I will respin it.

--
pw-bot: cr

