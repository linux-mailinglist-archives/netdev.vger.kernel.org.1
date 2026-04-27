Return-Path: <netdev+bounces-281483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJi4ELHF72m4FwEAu9opvQ
	(envelope-from <netdev+bounces-281483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:23:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 905CA479F91
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BB343001075
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC329A32D;
	Mon, 27 Apr 2026 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKAtNUM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC58207A32
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321353; cv=none; b=grqPlSFLzvZBKVz91YmD4YzXmSA3ha5P4YatjFK+bKo04sWKAjBtw3UUVWmspTxtzCeEJjRM62/FfPE0BkzqzUl0OxDRWLRHYYgZZZhG5vHhFIfOyrlrg9R0sQAa/03fLe/Cawy8NZnil5sD1idQAc7z7z5lLJQG/D795lWz4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321353; c=relaxed/simple;
	bh=kHXLUA61nlqyrP7LBjoKHDFEG9Pa+X067JwPtNyRei8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiapSDbxzr/33ThcicOC1KNeF/vP7ZvN4B9BcZdxLaY2IOgJXVojanIHhaIsWWXb3AtX+cmU077ZfDqzhm+TzV0GfModJvV25RfT8Qb8b4JlyjHxqIIrXBpv1cxF++JsfV9/FzTLlipi7Pg282w0Yre73MpNsjvXQrZoutfewrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKAtNUM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58664C19425;
	Mon, 27 Apr 2026 20:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777321352;
	bh=kHXLUA61nlqyrP7LBjoKHDFEG9Pa+X067JwPtNyRei8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aKAtNUM3Ew773d156KR4mLC90ay8I5UVb9H1N4wnz8B68GIjGlxM3yRNanvhDeeGt
	 sqNQznsY0HloZEw2/QXGTJgS53P4baOaEw6SfAqbfQ9Lgv12O5VSQcKBfqG5SOX+Py
	 0F00y+ljCbURR8EqpGYsQbGtF+kc1cC9C6jqdHlHW3nbKe6NLyL+vEEpEVUS1aNpi7
	 bhYCJ1Vbg2wPIckAnnSHWEF/T1jTYvgcQhHJpH54tEAT2mcAz/W70CjIfDbOuLnEH8
	 ayUr5SL8ptbwVWzReF4b7jsIBPE6cOhNkhA470IROCwWGFZHq7E3akKdobxyKpKkG8
	 fyVb+BhCUh/QQ==
Date: Mon, 27 Apr 2026 13:22:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org, Ralf
 Lici <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <20260427132231.2621be72@kernel.org>
In-Reply-To: <aeqcvgufY0F50rkU@krikkit>
References: <20260422123242.530882-1-antonio@openvpn.net>
	<20260422123242.530882-2-antonio@openvpn.net>
	<20260422192050.7c4ca760@kernel.org>
	<7481bc31-44f6-43ae-b3aa-07002644d9e6@openvpn.net>
	<9221605c-ad31-44f9-b3b7-db2237f75eb7@openvpn.net>
	<aepK3XXc8IFemb1Z@krikkit>
	<20260423103628.4ce6fc05@kernel.org>
	<aeqcvgufY0F50rkU@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 905CA479F91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[openvpn.net,vger.kernel.org,mandelbit.com,redhat.com,lunn.ch,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-281483-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri, 24 Apr 2026 00:27:10 +0200 Sabrina Dubroca wrote:
> 2026-04-23, 10:36:28 -0700, Jakub Kicinski wrote:
> > On Thu, 23 Apr 2026 18:37:49 +0200 Sabrina Dubroca wrote:  
> > > We could also wrap all of ovpn_peer_add (including the new reg_state
> > > check) in netdev_lock, since we can't move to NETREG_UNREGISTERING
> > > until netdev_lock is released (then I think we wouldn't need the
> > > READ_ONCE(reg_state)). But I don't know if that's an acceptable use of
> > > netdev_lock.  
> > 
> > Yup, fwiw it's a perfectly legitimate use case.  
> 
> Ok. There's still a worrying bit in nesting lock_sock under
> netdev_lock (ovpn_peer_add -> netdev_lock -> ovpn_peer_add_p2p ->
> unlock_ovpn -> ovpn_socket_release -> lock_sock).

No opinion on socket lock, TBH. It does indeed increase the potential
for hard to trace deadlocks. But I'd think the ordering is intuitive -
netdev lock "feels" heavier than socket lock.

