Return-Path: <netdev+bounces-273188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMTrETN8ymnk9AUAu9opvQ
	(envelope-from <netdev+bounces-273188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:35:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E2035C141
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4FB13015160
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83453242D6A;
	Mon, 30 Mar 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Bv0zOFWx"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7640DFB4;
	Mon, 30 Mar 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877432; cv=none; b=jFGwfJj+5ZtEvZ0IbTN6TxOwf3R5AjQTOyign0pyenS7ftmA78E8xOPrwalET8+BXoAcZFx1EKT44o+5yApEEb2438rdBoBJ++1Td3TwfmeyH9oQLotAaIIdbIcSYitPkKAmZBvNAPEFV1MT6BrvGZtQ3oUfZD2iMaa4p6EQpgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877432; c=relaxed/simple;
	bh=I53+4x8QLsRQYCUgrpPnllpmhk7T0pUCk75VG9OJeKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z81XtMksq3vHphevr78q3pdaKlYN904QmfSDdqGrWhi1sR2bD5BzGEe3B2EhGGoSDX6QIdpKaL37aIg8/ovOktyw2LgmOjb7qLbaUfXtEZbPr96VBVwqlRPNyx4ESXhm7ubTCHMUzjf6qv+WnCdVfOUu4Iajpdx/KehjYFBzzTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Bv0zOFWx; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 84596E838DF;
	Mon, 30 Mar 2026 15:30:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1774877427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JnZMBJsLnU7PkgxfK7Y/dVM7d0dGIFtqowGcQ6qE3Ws=;
	b=Bv0zOFWx0KArdynhA602lO1md03zYfV44BWf2LGrFXpO4KQStsyQgPXv/A0Z3ftKxjaUbC
	oIAmaaKxAvp+RuZRHBAdSPT7gNv++50QQ9ASd9SAhvXlsD/KkXYbA0QSVISspEfF/N6zaw
	PcriUxTCx9B82S+z7dsMpHcagKgksgEfdqd52HwcSyDa0MV+ufhh9+QuzfktTkv7l7YUUr
	xZKAobmgZGkzFGxjbu+GZfPwSZwes8fMDC9Nfm/Bh0r0lgT1PJ/9IzV91L5YF+b6ix8Cm0
	UiV14JqqkWy+wTKJFE6vVzDeXu8AkZFMfdIHXngL3eQugwjcbNZ+T8mbWfZGjQ==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id oho3NqL8rmRx; Mon, 30 Mar 2026 15:30:27 +0200 (CEST)
Received: from p14sgen5.fritz.box (dslb-002-205-089-102.002.205.pools.vodafone-ip.de [2.205.89.102])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 30 Mar 2026 15:30:27 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v2 0/3] net: pse-pd: support module-based PSE controller drivers
Date: Mon, 30 Mar 2026 15:29:49 +0200
Message-ID: <20260330132952.2950531-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329161014.2908509-1-github@szelinsky.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,szelinsky.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-273188-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,szelinsky.de:dkim,szelinsky.de:mid]
X-Rspamd-Queue-Id: 28E2035C141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a PSE controller driver is built as a module, it may not be probed
yet when PHYs are registered on the MDIO bus. This causes
of_pse_control_get() to return -EPROBE_DEFER, destroying the PHY device.
Later, regulator_late_cleanup disables the unclaimed PSE regulators,
permanently killing PoE.

This series fixes the issue in three steps:

  1. Add an admin_state_synced flag to pse_pi so that pse_pi_is_enabled()
     reports unclaimed PIs as disabled, preventing regulator_late_cleanup
     from shutting them down. The existing dual-path behavior (software-
     tracked vs. hardware-queried state) is preserved for claimed PIs.

  2. Add pse_control_try_resolve() for lazy PSE control resolution on
     first ethtool access, serialized by RTNL.

  3. Treat -EPROBE_DEFER as non-fatal during PHY registration, allowing
     the PHY to register with psec=NULL. This is ordered last because it
     changes probe behavior and relies on patches 1 and 2 for correct
     lazy resolution.

Thanks to Kory Maincent for the review and feedback on v1.

Changes in v2:
  - Reordered patches: moved the EPROBE_DEFER patch last since it
    changes probe behavior and depends on the other two patches for
    correct lazy resolution (Kory Maincent)
  - Added net-next to subject prefix (Kory Maincent)
  - Collected Acked-by tags

Carlo Szelinsky (3):
  net: pse-pd: prevent regulator cleanup from disabling unclaimed PSE
    PIs
  net: pse-pd: add lazy PSE control resolution for modular drivers
  net: mdio: treat PSE EPROBE_DEFER as non-fatal during PHY registration

 drivers/net/mdio/fwnode_mdio.c |  8 ++++--
 drivers/net/pse-pd/pse_core.c  | 49 ++++++++++++++++++++++++++++++++++
 include/linux/pse-pd/pse.h     |  6 +++++
 net/ethtool/pse-pd.c           |  4 +++
 4 files changed, 65 insertions(+), 2 deletions(-)


base-commit: cf0d9080c6f795bc6be08babbffa29b62c06e9b0
--
2.43.0


