Return-Path: <netdev+bounces-306847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EhoAGHU2UmqtNAMAu9opvQ
	(envelope-from <netdev+bounces-306847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:26:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C127417F7
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:26:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=c24xmyAu;
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306847-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306847-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92239302A6C0
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A348A3C73C1;
	Sat, 11 Jul 2026 12:25:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53953BB13A;
	Sat, 11 Jul 2026 12:25:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772745; cv=none; b=h4K3h8QozdO+WI6UvjR7pfoxpOEG9Id40uA1TSMU7JhJc2PxEM4JvPHNkRdW5GECTGePMwLEJRDSaSTcgY8TDhic0fyO8FXkyk+XWdsphMeZNnk3wX7dIYRN2W2zHcSfrcNlDL7srCASZjwVbnxB9vE5fNBF6vQOEnd3HICfQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772745; c=relaxed/simple;
	bh=LwDCR1lz0avgJNwP8GcIJl5pmBAIKyrag4DMWJASX9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7rpFfOX2qmxFTuh4ZBzruYX50Bc33zxAngmnXAnXA8FPoIs5/cRlXTuTluni5iSiIelIJNvbHi/H/C2K2ra8peqJYpl4LbdT0gmX0KCS2viSsExGGA9TbTI4FiRo/E3R1840EecDrqToNGZRWkTvfF8iTFOvHZM7uYJfO0zROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=c24xmyAu; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 59B58E836F6;
	Sat, 11 Jul 2026 14:16:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1783772187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MuPwlX3iVF53Pa6MkqOOzhjtclyijbwe3DZmBYmblAY=;
	b=c24xmyAuzJQNPLA9sIj6lkOVhKcbJtNpnTcy5lAVL4Jjlhr4Tc+kT5VyKHdyzMAZ0NcdZT
	bcOWJ1Naf5yKnOfhdfy8dtwEtpk3J9jr2SEt1oYgC8E9tEyZz67wq0D1TavJrynIOYm2Q8
	dAedmT5oSZhMgWx/nudAx3aqHKitqMavkr7k4kY+aK6FW+xoqFRZpbHUl8pePaOyZySAr3
	1M7UgBGBJWuApo079aP+xm1NlWJ8qehjrhnIQ7y9aILroAZVKfupTCSKzSF0Do1snKeZBA
	sk8TS01CluCCOm3hDfqzgxoo5YjWKu+T1KKiWAaLnMFzl78l5MtJRBxSqUZdww==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id b434LwQR-sUV; Sat, 11 Jul 2026 14:16:27 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-088-070-183-212.088.070.pools.vodafone-ip.de [88.70.183.212])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sat, 11 Jul 2026 14:16:26 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v2 0/2] net: pse-pd: fix use-after-free of PI array on controller unregister
Date: Sat, 11 Jul 2026 14:16:09 +0200
Message-ID: <20260711121611.1639086-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306847-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szelinsky.de:from_mime,szelinsky.de:dkim,szelinsky.de:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8C127417F7

This series fixes use-after-free bugs in the PSE core teardown path.

When a PSE controller is unregistered, pse_controller_unregister() frees
the PI array (pcdev->pi) and the power domain supplies. But the IRQ
handler, the notification worker, and the regulator disable path can
still run at that point and touch this freed memory.

Patch 1 reorders pse_controller_unregister() so the IRQ and the worker
are stopped before anything they use is freed.

Patch 2 clears pcdev->pi under the lock after freeing it, and makes the
three regulator ops that read pcdev->pi return early when it is NULL.

This series closes the use-after-free reachable from the regulator core
and the controller's own IRQ and worker during unregister. The wider
case - a pse_control consumer (the ethtool path) whose handle outlives
the controller - is a separate lifetime problem handled by the PSE
notifier decoupling work for net-next, not this fix.

Both bugs are pre-existing. They are teardown races, so there is no easy
way to trigger them on purpose and no simple reproducer. The fix is based
on code review. It is compile tested and checkpatch clean.

v1: https://lore.kernel.org/all/20260524223306.2570676-1-github@szelinsky.de/

Changes in v2:
- Patch 1: also stop the IRQ before pse_flush_pw_ds(), and cancel the
  notification worker before pse_release_pis(). v1 only moved
  disable_irq() ahead of pse_release_pis(). Also fix the commit message,
  which wrongly said the worker does not touch pcdev->pi.
- Patch 2: take pcdev->lock around the kfree() and the pcdev->pi = NULL
  store, so a reader sees an authoritative NULL. Add the same NULL guard
  to pse_pi_enable() and pse_pi_is_enabled(), not just pse_pi_disable().
- Thanks to Simon Horman for the review.

Carlo Szelinsky (2):
  net: pse-pd: stop async event sources before freeing PI data in
    unregister
  net: pse-pd: guard regulator ops against freed PI data during
    unregister

 drivers/net/pse-pd/pse_core.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

-- 
2.43.0


