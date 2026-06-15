Return-Path: <netdev+bounces-299557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V14YAB8+MGpbQQUAu9opvQ
	(envelope-from <netdev+bounces-299557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:02:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFEA68907E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:02:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=eWSIDLcQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299557-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299557-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9297C305044C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028712EA171;
	Mon, 15 Jun 2026 18:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB78635D;
	Mon, 15 Jun 2026 18:00:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546456; cv=none; b=L3+8+hkY7cBB8I2CiUAWc2dwAhrHVvJJ2N8E5zFs/vA1tY51PTf3sSqBZ6Qsp5wWvJBXUZH4SYXcPv1BmAyQsAI3u/Uh42bOfTUVWr0N7j51qHBBFKOnbj9zB+6iB+9dh/YVjgS89tNidThZT6EdrHIPucPUSov9o86IUNljMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546456; c=relaxed/simple;
	bh=Cc3W1e/04LcFkOihgk+qEg39U0Kve56hZkAQtIPZICs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHD2a98jZLhQKLeheR0fAdiv8gqh7teLa7GLpKpl9LMVsr1UKuSQUvVkpahj9LxjN8/W2Ucvg+304o0orn/tAzRw6I1AOHIsNu/IWTJpPHJ/2prUt4q1vxt0enJwdH9Kg4eCHQzsnI1JkM/Z9dmBweR5JDxQABHLWdvn2fPh+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=eWSIDLcQ; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id CC191E838CF;
	Mon, 15 Jun 2026 20:00:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1781546452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cc3W1e/04LcFkOihgk+qEg39U0Kve56hZkAQtIPZICs=;
	b=eWSIDLcQBf7WOD9ybJEKo+SiFys7HuDqV33JtvXIWPnkHk5T9m+3zAShEFhEa2ROt52Ky2
	W9o1Y9qqR6PkXTxSR9jUR58JJ1i95P4fIrINBgNNGhof/9WoUyikw0u+eXgBUKN0j539Oz
	hbSxNiPAzsb9knjYX35CtgsboDdezp24rrcLSd6TRkWtsQRVbUq3VmpRVbI0X2r06sLCRY
	3x0ZavmgLTjuJ63vvqvtLj9/SGbc0hHqkgoFIkrmBEsCEhZ12kQSpvJ+iqF1Y6ag/D3lMA
	RE1sst93C5D5j2hOvaBiiL2OPGzvGQ67xC74bhSC6QJy676bXZMzsuLOz7BTuQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id CZ5O5x4VDz-p; Mon, 15 Jun 2026 20:00:52 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 15 Jun 2026 20:00:52 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net 2/2] net: pse-pd: guard against freed PI data on regulator disable
Date: Mon, 15 Jun 2026 20:00:48 +0200
Message-ID: <20260615180048.828053-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527122418.2410341-2-horms@kernel.org>
References: <20260527122418.2410341-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299557-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,szelinsky.de:dkim,szelinsky.de:mid,szelinsky.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BFEA68907E

Hi Simon,

Thanks for forwarding this... I'd missed it the first time round.
Both points are valid; answering inline.

> [High]
> Is the pcdev->pi = NULL store correctly synchronized with the readers?
> ...
> Would taking pcdev->lock around the kfree()+NULL store in
> pse_release_pis() (so the NULL observation under pcdev->lock is
> authoritative) close that window? Alternatively, can the regulator
> unregister be ordered to run before pse_release_pis() so no consumer
> can invoke a regulator op while the PI array is being torn down?

Agreed, the guard is not authoritative as it stands. For v2 I'd take
pcdev->lock around the kfree() + pcdev->pi = NULL in pse_release_pis(),
so the NULL observed under the lock is authoritative.

I leaned away from reordering the regulator unregister, because both
the PI regulators and their consumer are devm-bound to pcdev->dev
(devm_regulator_register() and devm_regulator_get_exclusive()), so
reordering means tearing the regulators down by hand in
pse_controller_unregister() instead of letting devres do it, heavier
than a net fix wants. Does the contained fix (lock around the free)
work for you, or would you rather see the reorder?

One thing I'd like your read on for the commit message: the consumer
get is exclusive on pcdev->dev, so I couldn't pin down a concrete
external consumer that calls a regulator op on another CPU during
unbind. Do you have a specific path in mind, or should I describe the
lock as closing a narrow theoretical window rather than a proven race?
I'll add it either way.. I just want to make sure we are aligned :-)

> [High]
> Should the same NULL guard be applied to pse_pi_is_enabled() and
> pse_pi_enable()?
> ...
> Should these two callbacks receive the same guard, or alternatively
> should the unwind order be changed so that no callback can fire after
> the PI array is freed?

Yes. Both follow the same rdev_get_drvdata() -> mutex_lock() ->
unconditional pcdev->pi[id] pattern as the disable path, so for v2 I'll
add the same !pcdev->pi guard to pse_pi_is_enabled() and
pse_pi_enable().

Thanks,
Carlo

