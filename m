Return-Path: <netdev+bounces-306845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HBEjCUs2UmqbNAMAu9opvQ
	(envelope-from <netdev+bounces-306845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:25:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CDB7417E6
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:25:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=fuEQCHKY;
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306845-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306845-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C3863011855
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18533C1091;
	Sat, 11 Jul 2026 12:25:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FD3A5E7B;
	Sat, 11 Jul 2026 12:25:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772744; cv=none; b=cBXzpIDnry/KWQzfWvttsAvQz+UQPHxqX4HyB9G2/nxqbxgbiHsmZuExYIzOl6cQSUibfXmcIDkP2AUPSTnJyajXg8R5T0P0ldwEQJ/SxlpJLHUFN+jg/3gshMJMmiSt0fDxW2ya99+WVFFbCwKSV7dPxFbYidJZc6mmNE5I6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772744; c=relaxed/simple;
	bh=v5RP6dafiN+NxcGVWt9uSyo1rnCKYimMZ8hgqdy58h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDtW3Lv2GmvsbLBHVS0g65cp8ekU4rsaTfiEmTqYl+9J2RZ7JcH+2fVJxuQSCLLt12h5OjRKsWBSOdEO2OZe2+QLMRUT//9uKs0FXHOEX8gZXqzfP2aHc80hbxyjqq3JheLk96TYuuLi9RBQXP9339rZlkxAJ+11fvnHoLJKHFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=fuEQCHKY; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 67B56E83F45;
	Sat, 11 Jul 2026 14:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1783772190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xTKfCywjkvLn8eD1WkkdEFWe7Xznd8kz3Fq2QB7I5c=;
	b=fuEQCHKYW+iL4Pkwh8hPMR/n1a1rBNzPHnGRqWPhzYhauy5pEYZZHey9ouZnOYeRExlhbh
	wmeKjk8f5XXWJOSTWSAHk4uD+xjB+8g86jebA67ilnmvdSiBcWIrKM/xCbMopsuH8lmtfg
	93VlXHKkGDK7x515Pao77kDoc1JxoSSjbK3dy5OjWebKryl1cb5KLIpgIoOqgLtJdV2Fgo
	BjNjyiI4f7rtZYE6j0xNQefzW6nvQ0+YWX/303x7hXyQcaI9cBgpJDv75Y5LwYKtEUh8yg
	huL5QO7aXVGStug2L30SLqlla3MsedovFqepeBXvoGdCThYT0XCwX27cPJCLpw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id Rx6REogGpesC; Sat, 11 Jul 2026 14:16:30 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-088-070-183-212.088.070.pools.vodafone-ip.de [88.70.183.212])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sat, 11 Jul 2026 14:16:30 +0200 (CEST)
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
Subject: [PATCH net v2 1/2] net: pse-pd: stop async event sources before freeing PI data in unregister
Date: Sat, 11 Jul 2026 14:16:10 +0200
Message-ID: <20260711121611.1639086-2-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260711121611.1639086-1-github@szelinsky.de>
References: <20260711121611.1639086-1-github@szelinsky.de>
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
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306845-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,szelinsky.de:from_mime,szelinsky.de:email,szelinsky.de:mid,szelinsky.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62CDB7417E6

pse_controller_unregister() frees resources that its own asynchronous
event sources are still using:

 * The PI array (pcdev->pi) is freed by pse_release_pis() while the
   threaded IRQ handler pse_isr() can still be running. pse_isr() walks
   pcdev->pi[] (via pse_set_config_isr() and
   regulator_notifier_call_chain() on pcdev->pi[i].rdev), so an interrupt
   arriving before disable_irq() dereferences freed memory.

 * pse_flush_pw_ds() runs before disable_irq() and drops the power domain
   references, which can free pw_d->supply via __pse_pw_d_release().
   A concurrent interrupt reaches that supply through
   _pse_pi_disable() -> pse_pw_d_retry_power_delivery() ->
   regulator_request_power_budget(pw_d->supply), another use-after-free.

 * cancel_work_sync(&pcdev->ntf_work) runs after pse_release_pis(), but
   the notification worker reaches pcdev->pi too: pse_send_ntf_worker()
   -> pse_control_put() -> __pse_control_release() dereferences
   psec->pcdev->pi[psec->id].admin_state_enabled. Draining the worker
   after the PI array is freed is therefore also a use-after-free.

Reorder teardown so every asynchronous accessor is stopped first:
disable the IRQ, drain the notification worker, and only then flush the
power domains and release the PI array.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a5e6d7b26b9f..6045b6c399c2 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1114,11 +1114,15 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
-	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
+	/* Stop the IRQ and notification worker before freeing what they
+	 * reach: both touch pcdev->pi, and the IRQ also uses pw_d->supply
+	 * that pse_flush_pw_ds() drops.
+	 */
 	if (pcdev->irq)
 		disable_irq(pcdev->irq);
 	cancel_work_sync(&pcdev->ntf_work);
+	pse_flush_pw_ds(pcdev);
+	pse_release_pis(pcdev);
 	kfifo_free(&pcdev->ntf_fifo);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
-- 
2.43.0


