Return-Path: <netdev+bounces-302401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZgFWBW0+QWrmmgkAu9opvQ
	(envelope-from <netdev+bounces-302401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 17:31:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 560DF6D44B6
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 17:31:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=OE9PIx8o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302401-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302401-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2BF030097F1
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97503A0B31;
	Sun, 28 Jun 2026 15:31:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997432D7FA;
	Sun, 28 Jun 2026 15:31:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782660713; cv=none; b=fWWH+B/SSwjvUPYKe6QN/smBYKAtRCeFAmq077X0Pz97u4kfDyAt2/U99ZWdiSAudrXR+EyosYc4gw7Maiir8K8qQ3IzzRUX7VeaL+H/vh9AOjPmX5f8Jrocq4QEbPzaT951N2szkQU4kqlImP3w/KG+OkJf4jHhFwFZ0QOj+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782660713; c=relaxed/simple;
	bh=hrho+VCEM+PMn9utCj/hdI2qNbx+XRvATBOImWER0fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0l3OvM366XmLdpZbcV/GES8Ql7aOx0lkJtJ2dNikdHbvjbMJVxu65qeXW4mBEsQxGoL1vH0WYvxyyb0dKvPfR7I3ZrGPeHc/xWyy9TUftxcnwmx9BLVXF8gH18PLvsZg3d+/tZWSNcQNGoTBmsiolL84lTDQv7kKrrhsfm8xzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=OE9PIx8o; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id C34B9E83957;
	Sun, 28 Jun 2026 17:31:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1782660703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ifs9Rqu4NSwYS2nYn0dX6lUO6UMTsxCOrL6aDSb7bAw=;
	b=OE9PIx8oyIlU71IPVUpEHjYWYzihV/oEvOTqIFw+eFEuSrDmom4O/C0seDKXJt4lv7umJi
	yRfQnubKEqC2CU8pcz0y2S+ObQJXw8dXjAEgb/AN+34iqRNiOiKDGKYamS5VG9kFKuJtnO
	rNIun7oMSJ2nTL1tRuZDyg9rsV616U1gO/8fk9u2bLm9Qvg0QrEUpZIXPb4J4R5OtAfGPu
	GiLOyFemQowS1UTNW0Y/tcrL2Xe4g+kNaIKdspGFsyKy4zoijGoIOvPNhFM6oR7IuNuSiV
	6XAuAl9jwQp6YZ7rSm3jwuZrDpBgD1UfXouXaIhzsMkbze9Z1CsBx+c8+iP+VQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 2VweZJsA0lRj; Sun, 28 Jun 2026 17:31:43 +0200 (CEST)
Received: from p14sgen5.lan (p5784dea5.dip0.t-ipconnect.de [87.132.222.165])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 28 Jun 2026 17:31:43 +0200 (CEST)
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
Date: Sun, 28 Jun 2026 17:31:29 +0200
Message-ID: <20260628153129.2995903-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615180048.828053-1-github@szelinsky.de>
References: <20260615180048.828053-1-github@szelinsky.de>
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
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302401-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 560DF6D44B6

Hi Simon,

Gentle ping on this one... I think I'm just waiting on your read before
I send v2, and I'd like to get it unblocked :-)

v2 would take pcdev->lock around the kfree() + pcdev->pi = NULL in
pse_release_pis() so the NULL is authoritative, and add the same
!pcdev->pi guard to pse_pi_is_enabled() and pse_pi_enable().

Two things I'd value your view on before I send the next version:

 - Is the contained fix (lock around the free) ok, or would you prefer
   the regulator unregister reordered ahead of pse_release_pis()?

 - I couldn't find a concrete consumer hitting a regulator op on
   another CPU during unbind, so I'd describe it as a narrow window
   rather than a proven race. Does that sound right to you?

Happy to just send v2 with the lock fix if that works for you.

Thanks,
Carlo

