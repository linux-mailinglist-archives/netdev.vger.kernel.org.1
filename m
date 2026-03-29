Return-Path: <netdev+bounces-272933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id utm5GQNPyWm/xQUAu9opvQ
	(envelope-from <netdev+bounces-272933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:10:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AAF352CCC
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93EAF300B74D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BDD376496;
	Sun, 29 Mar 2026 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="PigQn7ND"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EED175A77;
	Sun, 29 Mar 2026 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774800638; cv=none; b=YL45GxUhl3L3QA2LjuEHlSvr7VL5534iEuz1hOZsooJmFhdT25KicA3TA/cSMTrZ0sidcut2G2Tqkf7OTSEiYiDI+CJUDJQOIk7klBmVwsjISIjhbQe03RsbUKj8tgifIdzR2VJ5o68zrczV7tB3u0dp+YJvGdhQ7Y/B9C5rl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774800638; c=relaxed/simple;
	bh=AS/H8fmULQvYPJ81mC/TS1BO30sxihN04jibKkpIXac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kbb9NaRkiSpgWNqvhbJbmuSPS3Uc2F2OXNwhCiVp9qG5aLTdQjV2XKhV7emJ+3RAwX2Oo4hGOFglU9uCUSkGoj5U6+72MPsOhKe5cTn/Qloft1A8TDWvHAcfdt4tbRV8gK8QB5W410EN8rGplY+3xM7WxfYUuca4fm2LleLReXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=PigQn7ND; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id B6C68E83A8D;
	Sun, 29 Mar 2026 18:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1774800633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UwUmuP5Hynn5LFllgu+vhPSxq6Jeq0BREsFtKFFclHc=;
	b=PigQn7NDTZS9Aa3wKWVG0tRo5lWeAsCudZMbNocRIL4YE3fHbIu8dSJZoQfc22ZoeEtdSq
	GQi6v0getvdBx9f8GxO8OZaHaW5hRfm17cVENrQMNlkFcVDhxeQFXtj9kaZo8f2/YxR87V
	tzAWuG0uTJ21aOHq8Ad11fOcS2Urk5spGehIN2V8yayBxd26N3emKNP0kJJ12T+HZtjf/I
	Tx84J7xYto0uNZhYDuVm/0jxmslP7ZfjvuIHJKXdN5TI+vCLC85qxcNBK4vVxdm9zlAD+e
	HKomnh5Egsf6ympNalhk8WaKkVNsiOLgItYJtlMy/eMbdMVSAMiqSvd+HNbJLw==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id DjtqCSgkenQe; Sun, 29 Mar 2026 18:10:33 +0200 (CEST)
Received: from p14sgen5.fritz.box (dslb-002-205-089-102.002.205.pools.vodafone-ip.de [2.205.89.102])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 29 Mar 2026 18:10:33 +0200 (CEST)
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
Subject: [PATCH 0/3] net: pse-pd: support module-based PSE controller drivers
Date: Sun, 29 Mar 2026 18:10:11 +0200
Message-ID: <20260329161014.2908509-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,szelinsky.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-272933-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6AAF352CCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a PSE controller driver is built as a module, it may not be probed
yet when PHYs are registered on the MDIO bus. This causes
of_pse_control_get() to return -EPROBE_DEFER, destroying the PHY device.
Later, regulator_late_cleanup disables the unclaimed PSE regulators,
permanently killing PoE.

This series fixes the issue in three steps:

  1. Treat -EPROBE_DEFER as non-fatal during PHY registration, allowing
     the PHY to register with psec=NULL.

  2. Add an admin_state_synced flag to pse_pi so that pse_pi_is_enabled()
     reports unclaimed PIs as disabled, preventing regulator_late_cleanup
     from shutting them down. The existing dual-path behavior (software-
     tracked vs. hardware-queried state) is preserved for claimed PIs.

  3. Add pse_control_try_resolve() for lazy PSE control resolution on
     first ethtool access, serialized by RTNL.

This is tested on my setup, but I am not fully sure if this is the right
approach to solve this problem. I would love to get feedback from the
maintainers on whether the overall design direction makes sense, or if
there is a better way to handle the deferred PSE control acquisition.

Carlo Szelinsky (3):
  net: mdio: treat PSE EPROBE_DEFER as non-fatal during PHY registration
  net: pse-pd: prevent regulator cleanup from disabling unclaimed PSE
    PIs
  net: pse-pd: add lazy PSE control resolution for modular drivers

 drivers/net/mdio/fwnode_mdio.c |  8 ++++--
 drivers/net/pse-pd/pse_core.c  | 49 ++++++++++++++++++++++++++++++++++
 include/linux/pse-pd/pse.h     |  6 +++++
 net/ethtool/pse-pd.c           |  4 +++
 4 files changed, 65 insertions(+), 2 deletions(-)

--
2.43.0


