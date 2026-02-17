Return-Path: <netdev+bounces-259150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIrANrfilGmjIgIAu9opvQ
	(envelope-from <netdev+bounces-259150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:50:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E8C1510CC
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6579630266FA
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F482FD66B;
	Tue, 17 Feb 2026 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjJENHkI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33712FD1BF
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365009; cv=none; b=KlV/wnyL4dUsO7xK7mMCUA3mIaTsMLB3aOeRxGPsGPUOthkeIlVwGUy+ILHj958iQR3qbiQ42yrsOanxJ5765ldO5XHi373lciOvLLbBtVsWTiDIC0MjrwS/q1plQkNac3CIAoczLueQEA6lBgpMwF3ggLQzn7vu4zAasvOm47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365009; c=relaxed/simple;
	bh=pvDZPoLzl55yumLqYP4PLy4xQzkiAuiTqZbKLIP8ny0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPYgeLXVttVmhircX0kHUxELOfEGlbGnK42DiC2eUUWzUsxAvJAGRHTv6NFXfltVlwAbXr2AiN4V32rCfRnThEWw6o3/pBCe97OnAUsRsbXS6gkiYSF6Nq254R8liE8c5lRIkviPoi1n+WfcnvGK+WsZI76ZXk3lX0eHPJgNA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjJENHkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD2AC2BC9E;
	Tue, 17 Feb 2026 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771365009;
	bh=pvDZPoLzl55yumLqYP4PLy4xQzkiAuiTqZbKLIP8ny0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EjJENHkICMOQEUfGJtHfBsGzutK2mmgKF1Uby00PIc6IYiOgsEpFrlM2Bm+dklilC
	 fAMg8+0uYB35+0giIrIUHZVdvKHJKxpisMHRmw0XUYAh03+Mv6t18fmP2+/e2O3R8g
	 XHotOmu4yoRhxNAU/EDHRhJqIOBukDpDlr2l+aDar37XnolKeUOr4Xo4qFHL+mj7Qj
	 yx0W9SmU0TwRgdZNN+h0swTzTPzFqPMUWpVi5LnYzzqAIRb+OCdQvVMOpR5ilcOYLb
	 cDPz+tUvL8qRVytPBQcU843MSTiU+SPOT4/MmBQn/jsFJdbDfaixONvgGO5bUyt6zO
	 bXZ/G348j1fmg==
Date: Tue, 17 Feb 2026 13:50:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
Message-ID: <20260217135008.30561ad9@kernel.org>
In-Reply-To: <CANn89iLURfPA69TjXjdBJjbc+Ad8X8XO-fiDQp=Uc8J+0PU5JQ@mail.gmail.com>
References: <20260117164255.785751-1-kuba@kernel.org>
	<CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
	<20260117150346.72265ac3@kernel.org>
	<CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
	<20260119090435.44b1da2d@kernel.org>
	<20260129150459.29419003@kernel.org>
	<CANn89i+P86WVVUY-4WppUAH1TGix1Z3KhgX9vSHok5nXqQAiHQ@mail.gmail.com>
	<20260216094936.5bf9d789@kernel.org>
	<CANn89iL+kzhRqwBr5wAcEBMdC_wbLFanHJ6VxS1r5ppGKUhftA@mail.gmail.com>
	<20260216101108.6b2319b2@kernel.org>
	<CANn89iLURfPA69TjXjdBJjbc+Ad8X8XO-fiDQp=Uc8J+0PU5JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259150-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6E8C1510CC
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 19:16:46 +0100 Eric Dumazet wrote:
> UDP use of skb_attempt_defer_free() is  with RX skbs, and normally
> their zcopy status has been cleared ?

I meant coming in via napi_consume_skb() -> skb_attempt_defer_free().
There we are freeing Tx skbs, which for UDP these may legitimately 
have zc state. No?

