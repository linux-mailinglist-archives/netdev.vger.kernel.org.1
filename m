Return-Path: <netdev+bounces-291434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDDnH2SnFGrJPAcAu9opvQ
	(envelope-from <netdev+bounces-291434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:47:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 075CC5CE19B
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78B483017037
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A97380FDC;
	Mon, 25 May 2026 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpNRzXcd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3F380FC3
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738464; cv=none; b=XYXft5w4yin3yQJjVRC/TLM5ek8SOQ9n3XxClaLISN6opOBFFmIz6vDmSHgI62WHigO2eWEfRGnO164rh9w3MGkpLM6gjLzS1x1M+D3nzdii9JBcdBkXw+P5GGoeBD6/NrbEDAqUYQQjTCYhB9zbobjA9JQ/mbUtSTX3x6hHkl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738464; c=relaxed/simple;
	bh=SfgDUGiTc0GebUzJVRklLwdpbnvBHF9lKfZkwcDFjgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNDb2aMo31fcEoJ9inF4jpHHdJmKy0OBziXuHKMybxopFWOrYI/yf74fKrCToqp5fJs0i9hinidnA6q2bwVhU0bMzrqzHZjUOXH+TFSGkyidcxb+NPfnOO2WzV24ZFNJ7WQBeOyD+FZJVseBSLZVTZVdcviqek/6Rp8rLfve2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpNRzXcd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7715A1F000E9;
	Mon, 25 May 2026 19:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779738461;
	bh=v7wdcmNSjGVdCYOovJ0w8o2PtIKtBQIuBvnAy6xomfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hpNRzXcdJb6i3Ilv5MJ6MUCpnpNRHPS/HnMVtLKXsPfO6/9jm84B3Dm7tM6hZK6t+
	 NPBLYbCI637LlcsOeRlZTct/e/pTy5LhINH57rwBsZvz5I21432HVYMDSeC5jvCuWf
	 81Dt9q0MuervfgirtxnNCAh0nWGoxKK4khtbZn+bAt4WQ4zH8G0IYVuCs7UJcYv77Q
	 NJUWzZimP3MU5FKX4B8r5mcnFh2eouhnU4weWGNz0E7DK7ovigDHz20Mt28S7SkvUb
	 im7sbAPL236lWUp35pN1U/2HSHtp+SehQMJU2JDG8QBc78dOautAjArYmPWZN53N1r
	 ABIyzfMQ9UMsw==
Date: Mon, 25 May 2026 12:47:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCHv2 net-next] net: ucc_geth: Batch RX packets before stack
 handoff
Message-ID: <20260525124740.5e71e96c@kernel.org>
In-Reply-To: <20260521060729.2293222-1-rosenp@gmail.com>
References: <20260521060729.2293222-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291434-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 075CC5CE19B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 23:07:29 -0700 Rosen Penev wrote:
> It would be nice to use napi_gro_receive, but the tradeoff is lower
> routing performance. There is no support for hardware checksum offload,
> which really hurts routing performance.

Not sure this was clear from the previous discussion but AFAIK
GRO will fall back to the list processing if disabled with ethtool -K
So the argument of GRO-enabled being slower for forwarding is moot.
-- 
pw-bot: cr

