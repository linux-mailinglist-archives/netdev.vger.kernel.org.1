Return-Path: <netdev+bounces-290145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADLkJfFKDmoM9gUAu9opvQ
	(envelope-from <netdev+bounces-290145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:59:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D8259D10D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3B3E30D6781
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC5C39A7E7;
	Wed, 20 May 2026 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ2ca/Wg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0A346E7D;
	Wed, 20 May 2026 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321552; cv=none; b=jJ25MuN1LgiRQ7nhbk1FhIg4muud5+PP9RoOIP0MAZmV9tLlHmzSX2OEk9HkPQcNrexngFfZPc684UnizIYszvttifF7ay66NSLiVfZTEDJU1kBTb+VzSvZQJEWt4XD8vJNQPchQbRKoNNdS3tk3a/IwfQGtSuuwhdhONBk3hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321552; c=relaxed/simple;
	bh=tZ4w/Cf7aX6DFaeTnL15SpHjEU7OjP0mVO6Y7AWLweU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvSEuyYqb78Z8qquxwYw+zyDJ5aHB0OoSXLvoSh8G2+UK3s6gArkbJdFWJjR+ejIiemTd2g4OXChthEeKCirPSRiLHJmtJELd+OPvkxfLfZxVobCUvDeb54FA+8mXwmmeyFjdjjUeAVeNN7l7BtufzCtmAdJ951JMXtQGXEIZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQ2ca/Wg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A83D1F000E9;
	Wed, 20 May 2026 23:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321551;
	bh=GgSk2xjle+o5w0hl20ShFxqteYe0X3Jm9DBMWwVDBPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EQ2ca/WgDtNTIxm25zbtHihu1q4/MDFKUVpv/hLnZ7Kx7hLLIVyutiSJ+oZs7Typp
	 dgIb5CPziVMJlzYr/uwWzuJ/IPWgMbTSSfJv77pKrPNJQF7By440LE4gpbJ0VE9QEj
	 Kk74mweKiI3B2TH0vIMytPIcu7tO8Z3Shmk93aHbOhYQVxJ4FvkSvk3nydxkSDqJwj
	 3dGvwAMxSTClo4H06Zw2Al1DycZsww6jg3m2VwiM+/z0CidL2uLNrhvTm7jlx1zG/b
	 43UHK65hBLc7z923Lb6JPOtu5DwHAD68tTiKv86KJQ/9Oi1szccvpkG8A2Qe0c9P3J
	 WWRoBckAVd1Xg==
Date: Wed, 20 May 2026 16:59:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: ag71xx: Unmap TX DMA buffers on
 completion
Message-ID: <20260520165909.0ac7bf4a@kernel.org>
In-Reply-To: <20260517214302.1450433-1-rosenp@gmail.com>
References: <20260517214302.1450433-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290145-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 34D8259D10D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 17 May 2026 14:43:02 -0700 Rosen Penev wrote:
> Store the DMA address used for each transmitted skb and unmap it when
> the skb is completed or cleaned from the TX ring.
> 
> This keeps the streaming DMA mapping lifetime paired with the skb
> lifetime on both normal completion and shutdown cleanup paths.

This must obviously not matter on the platforms where this driver is
used, otherwise we'd run out of memory in no time..
-- 
pw-bot: reject

