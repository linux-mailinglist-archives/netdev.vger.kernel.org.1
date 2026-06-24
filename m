Return-Path: <netdev+bounces-301771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7PC+JRZBPGoAlwgAu9opvQ
	(envelope-from <netdev+bounces-301771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:41:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F32396C13C0
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:41:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=d12+JvNh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301771-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301771-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A8B830969EF
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF543E2AB6;
	Wed, 24 Jun 2026 20:39:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA153E1712;
	Wed, 24 Jun 2026 20:39:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333548; cv=none; b=ju0aD+GgFgdsffm4vlQb6nA3iMLH4U2pVz9ju5/dHoT/A0CrFzhqUY1CbJ9s5JLzS2j99KGt9RA/1qHwyRwAS8WysSrxmGu26F0u1fk7A04YXdR8U6f3VX4yGm6Aw/TpLn7k7vpSLlEZHgqOQwM99k7jaYrG6L1dlCYBIYXXXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333548; c=relaxed/simple;
	bh=b5dDnXxY3EFt6zM5Aw/fQEbsgkWUQBKOPuEumJYeFfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyP9AvZRoD6icRcPFAt/q+vP3+pjmwqAvhvsK3NkaPllRS4hicQIvhLUs07Icxgio5vy30vICTYPUF7b2crRTxXW6YN0ftwEtJrnxzgpc+tSKQL0uqsbmkOiGem7Te68Uoecd8AT0wcyywzouRgn+4ucDt+1WodL8sQijc5V8gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=d12+JvNh; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id AD417E83305;
	Wed, 24 Jun 2026 22:38:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1782333534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evnqU9FBKSv931iuv0osk+mVAyurs+Vq/0LPNwssx+c=;
	b=d12+JvNhXiHGUG6Z6BS6AYLKhL/IDivTcvV2NfqnjYNTf8CmmLprMYG6HlPk30PKjzNZwB
	VlNZA9WLBVkkxfLLbjSIuH9FBNASFrciIf8FPI+VXYyjsI6bH2TdjGWUKwkMkMrbKN4Hjf
	F5AewB+jXxv/jli7cu/gOaleLXgx9Lbj5KNSko0loUrI3V0D5ZJpmVj+oInqNJIT8lkytv
	RnC0irD2CnapVpm9YigobEVXThfFkolrGKhslmTt23E3X5f5uWAHUoLV3RxdXwJdcyQyCX
	E4B+1fLrYkyMhVciVXrU7AVLqKd3MvupUHDjPOhoD4VmTfAOm5a5mtuO60UMGg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 13SIbVwJrVLX; Wed, 24 Jun 2026 22:38:54 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-088-070-183-212.088.070.pools.vodafone-ip.de [88.70.183.212])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 24 Jun 2026 22:38:54 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Corey Leavitt <corey@leavitt.info>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net] net: pse-pd: scope pse_control regulator handle to kref lifetime
Date: Wed, 24 Jun 2026 22:38:38 +0200
Message-ID: <20260624203838.2752376-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624151251.1137250-1-horms@kernel.org>
References: <20260624151251.1137250-1-horms@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301771-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corey@leavitt.info,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F32396C13C0

On Wed, 24 Jun 2026 16:12:51 +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
[...]
> [High]
> Does this fix the use-after-free completely, or only the regulator-put
> part of it?
[...]
> Would a more complete fix also need pse_controller_unregister() to
> drain outstanding pse_control references, or have pse_control hold a
> refcount on pcdev, so that psec cannot outlive pcdev->pi and pcdev?

Thanks, the review is correct. This patch only fixes the regulator
handle. In the same unbind-while-held case __pse_control_release()
also reads psec->pcdev->pi[] and psec->pcdev->owner after
pse_controller_unregister() has freed pcdev->pi, so those are still
use-after-free reads on their own.

That wider problem is exactly what you describe: the controller does
not drain its outstanding pse_control references on unregister. It is
fixed by draining them, which is what the PSE notifier series does --
PSE_UNREGISTERED drops every phydev->psec before pse_release_pis()
frees pcdev->pi. This patch is patch 1 of that series (by Corey
Leavitt); the rest targets net-next and is deferred until it reopens:

  https://lore.kernel.org/netdev/20260620112440.1734404-1-github@szelinsky.de/

Jakub suggested sending this one to net on its own since it is a fix,
so it is here without the notifier patches. My v1 commit message
overclaimed by saying it makes __pse_control_release() correct
regardless of the controller's devres state, which is only true for
the regulator handle. I have reworded it in v2 to scope it to the
regulator put and to point at the series for the wider lifetime fix.

Does you agree? Another option would be to wait for the entire series.

cheers Carlo

