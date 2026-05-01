Return-Path: <netdev+bounces-283310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFmsG3g69Wl8JgIAu9opvQ
	(envelope-from <netdev+bounces-283310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:42:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 013AF4B058F
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B383B3016485
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 23:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64EF37AA82;
	Fri,  1 May 2026 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXNgw7kh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D866FC5;
	Fri,  1 May 2026 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678964; cv=none; b=PUpp1uszIslaBDlwXuokpupYHiSGQTd6g6Afum7JGhgG3wLQeDa7NrPx8853h2RoYUZxGMfBojSsmr3QNI+TTjDA43+BU3k5o/YFPaLetXrLstO2zxnx0KtdnDp18nZzwt/2yaHZ656uJjiY75IJFD8Nd/Xa1P8CQPuv1FF+S60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678964; c=relaxed/simple;
	bh=9TI3xVEzbpOmg4LQujc1BopxZJDR4J9AEgxk3y+lpEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0PH6h6r/Ds5G2PJBIhQkiHiEGJlG7uw+071X3LsWxYRSvEHBozUnWXN3NvSk5KhqVw0Pr/VihLXJVzahgIrML6XA/IsPo3SevBLIRqBPv3L3c1QCSwiJRnK6jUjaZM4yr4jxSrWuVKzbf6iMpLPbIMuMpKa1r4AkjnQBqU10iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXNgw7kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A5BC2BCB4;
	Fri,  1 May 2026 23:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678964;
	bh=9TI3xVEzbpOmg4LQujc1BopxZJDR4J9AEgxk3y+lpEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gXNgw7khonnyMF2pxLmSRpPineiFZHxil8vKpJV8UG1MVTRUqb4McxF38VsDJ0bYw
	 BqShc+3v4kl2jLrG8MYRJeYv0q/essqgQyA8stYkH3CitI9K1PyFQVCZJA3+4mYFvE
	 cXQaq/BqdfofOI9CVj6EEIUQxYuXDb9idwfDfgTHBmCz2yUuNwuXRIGKofRKbynEgO
	 31ZmzGXPefk+ox/uPP/cSB23k4wCflo/JIkia5d6af1s5n9hylyJoSrw+QR5NFHQwX
	 HCDIWdkD3twgw2/qHOg5wVbzYMY5waKuzMUu918tsWvGOHM7Wi1Yl0JW9iptuZAu4R
	 satS7Yckhd4oQ==
Date: Fri, 1 May 2026 16:42:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: HACKE-RC <rc@rexion.ai>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Alexander Aring <alex.aring@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: rpl: fix hdrlen overflow in
 ipv6_rpl_srh_decompress()
Message-ID: <20260501164242.419cc17e@kernel.org>
In-Reply-To: <20260501063242.2523620-1-rc@rexion.ai>
References: <20260501063242.2523620-1-rc@rexion.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 013AF4B058F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283310-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri,  1 May 2026 12:02:42 +0530 HACKE-RC wrote:
> From: HACKE-RC <rc@rexion.ai>

We need a real name, if you don't want to provide one please feel free
to send just the bug report and one of the maintainers will generate
the patch. Code is cheap these days.

