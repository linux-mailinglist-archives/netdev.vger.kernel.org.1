Return-Path: <netdev+bounces-287371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JGFC+vSA2ol/AEAu9opvQ
	(envelope-from <netdev+bounces-287371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:24:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D5F52BDA8
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01D98307288A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84CE37703B;
	Wed, 13 May 2026 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI5/w58U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719FE3672BB;
	Wed, 13 May 2026 01:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635483; cv=none; b=tH794gNCsggUXPkk1B/V2vyywW4yvDCFXdn8T0Y80L8lFyT3tiV7/b5tEhIhjzP9k/kPVLCATHoZSrze3NdpiIr3Bzm2zZ1VvlLsLKsNjgvdBGQE1LCp1Uh2jnQFYt2GITUXRyhk6Pn5io3Y/z8a8Ndg3n/eaIIYgRrcOWCw5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635483; c=relaxed/simple;
	bh=+3yqjEDXPw+arLfZzIDfpVm0xM+O5B1A5w8icx+stt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hs1Z3B1LaNu/azJCi4lf9EsDgHEqjbroX4ve4VegfnGFQx6Sa+rnh5SLlQQWNxB9Ih7UvdEHljYDxVkxTkAqdIrwE49pE0CWjEjUWH1pNJpynCKpv4O8lmf4p5yF7/a6KXMpFEs4XKOOkxt4lht3FIGN5vS49mFXqCTAHn7dJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI5/w58U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA712C2BCB0;
	Wed, 13 May 2026 01:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778635482;
	bh=+3yqjEDXPw+arLfZzIDfpVm0xM+O5B1A5w8icx+stt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rI5/w58Ucq1MiOJ6Wmed0khguvxV5L6MzUbCZaNowdBjxSTdwgGAeMzD1codYXjEo
	 bi9Pty8h9bpbfUORD9OX+ZLfQrdbLelfCavgn8E8CX/+Zl3I4lXn1UBrmlLfnQR2rY
	 f65j687qggwCPVLL3iKrccf62jH+/Cpa/Ibt5yEWzmIiY7lV4aTCjeDs9VY1JxPzvw
	 oVM5tPLiGh02NFJmwS4LvEYeIxrUv9h/1albdMCf726wWdWo1OX4l8NEAMts4exoGM
	 UHsGoe5zv3mZrLnuXYWiAuMlmSVs/Y4XB2rvlewcE28XBKu6Gx5JgHF1R0BqhPpXSM
	 jz0ntrTItzWyw==
Date: Tue, 12 May 2026 18:24:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Sabrina Dubroca" <sd@queasysnail.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Eric Dumazet" <edumazet@google.com>, "Simon
 Horman" <horms@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, "Chuck Lever"
 <chuck.lever@oracle.com>, "Sagi Grimberg" <sagi@grimberg.me>
Subject: Re: [PATCH net-next v10 3/7] tls: Re-present partially-consumed
 records in tls_sw_read_sock()
Message-ID: <20260512182440.70cf8b03@kernel.org>
In-Reply-To: <c3f9038f-e4ed-42c9-b4f8-7a9dce2933df@app.fastmail.com>
References: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
	<20260511-tls-read-sock-v10-3-279fc5015f0e@oracle.com>
	<agMiq7CULgkRzd_E@krikkit>
	<20260512171715.078b49cf@kernel.org>
	<c3f9038f-e4ed-42c9-b4f8-7a9dce2933df@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D4D5F52BDA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[queasysnail.net,gmail.com,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,grimberg.me];
	TAGGED_FROM(0.00)[bounces-287371-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 21:11:39 -0400 Chuck Lever wrote:
> > If so a more appropriate direction would be to say that in
> > the commit message and drop the Fixes tag. =20
>=20
> I=E2=80=99ll drop the Fixes: tag and route 2/7 and 3/7 through net-next.
>=20
> Note that 7/7 in this series also bears a Fixes: tag. Should
> that one go through net instead?

That one looks like net material. Wouldn't be better off passing
bool copied into tls_rx_rec_wait() and calling sock_error()
conditionally than retroactively consume the error in the caller?

