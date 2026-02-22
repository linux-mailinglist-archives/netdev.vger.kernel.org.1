Return-Path: <netdev+bounces-259892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jBZAD5VAm2nrwwMAu9opvQ
	(envelope-from <netdev+bounces-259892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 18:44:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB616FF86
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 18:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E55A300C90A
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD50B3502A3;
	Sun, 22 Feb 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNr/0lM8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27C155757
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771782289; cv=none; b=JySM+eFFvFAYdnEk5lO1JaCYoKSEqQ6pZR+6TVN0IvJ5ByKYtyFvPwYffKRZyUy5k9S0uUviuNOr9eHyb8h0KRZkSQnvO8nLFjapaMwFR8RveOT1t7+nrHwzRzZY8Pw0nnZ0Kw5TK0ccRtuvpVTee1yhDvLOuO2J8Xd9rzto52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771782289; c=relaxed/simple;
	bh=Z7NFtpBn3dOQ07bI3kQg9qbiBAjkgql1jy4fBlXAFhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDA7jn3M9oId/GRsv3PxZxK8jbAEaBG8bAiJBFKCIXLb1qr6zH/PCLVRE0QHFzItgenELSksULDj7lh017TmnTAfUh2y/XGuQkLdzd1vQNP32s9aH9t23nJ/kt4KveGwmG0qxvTw+6NLQcGEjn70ui8tg4oe3AanV1G1kdqMCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNr/0lM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C59C116D0;
	Sun, 22 Feb 2026 17:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771782289;
	bh=Z7NFtpBn3dOQ07bI3kQg9qbiBAjkgql1jy4fBlXAFhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNr/0lM8zohz+UnH/Brx8GYhdalVumV22C626ssUb9NMELUugIR4e/2c620dBqHwE
	 IqpiketRTuLIZQ4G7CGRMEmU19HRVpCV3Mj9MMTtVbTyw9nfXNbgBdp1ME5enu9WEJ
	 0BQAwCR1QThBY6Jjygy8w87BK2AgjRr+8TCKq4V82jRLEnSY9iHgdcNgQM/o5ArVdB
	 BR4rtEY6IO7mrID5xEn4znTmbPw2PS1U4uxP5UqIRHjMG0K6zVYytiFVHtLNo+XIZQ
	 9c75o6ZmfbQs0Au6uOdrj2dDp0Px63QDK+j2zihtDe1R2tQ9Gnw97LdIVOX9RRes6V
	 MD94djh3IFliQ==
Date: Sun, 22 Feb 2026 17:44:45 +0000
From: Simon Horman <horms@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] tls: Fix race condition in tls_sw_cancel_work_tx()
Message-ID: <aZtAjSf-iw-85UU2@horms.kernel.org>
References: <aZgsFO6nfylfvLE7@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZgsFO6nfylfvLE7@v4bel>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259892-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 73AB616FF86
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 06:40:36PM +0900, Hyunwoo Kim wrote:
> This issue was discovered during a code audit.
> 
> After cancel_delayed_work_sync() is called from tls_sk_proto_close(), 
> tx_work_handler() can still be scheduled from paths such as the 
> Delayed ACK handler or ksoftirqd.
> As a result, the tx_work_handler() worker may dereference a freed 
> TLS object.
> 
> The following is a simple race scenario:
> 
>           cpu0                         cpu1
> 
> tls_sk_proto_close()
>   tls_sw_cancel_work_tx()
>                                  tls_write_space()
>                                    tls_sw_write_space()
>                                      if (!test_and_set_bit(BIT_TX_SCHEDULED, &tx_ctx->tx_bitmask))
>     set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
>     cancel_delayed_work_sync(&ctx->tx_work.work);
>                                      schedule_delayed_work(&tx_ctx->tx_work.work, 0);
> 
> To prevent this race condition, cancel_delayed_work_sync() is 
> replaced with disable_delayed_work_sync().
> 
> Fixes: f87e62d45e51 ("net/tls: remove close callback sock unlock/lock around TX work flush")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v2:
> - Shorten the patch subject
> - Target the net tree
> - Add the bug discovery background and the race scenario to the commit message
> - v1: https://lore.kernel.org/all/aZLotq3aZY0b-dI8@v4bel/

Reviewed-by: Simon Horman <horms@kernel.org>


