Return-Path: <netdev+bounces-291216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNPHCsp8E2r8BwcAu9opvQ
	(envelope-from <netdev+bounces-291216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:33:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76D5C496F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52995300A7C6
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BD037C0E9;
	Sun, 24 May 2026 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Hda1125G"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F42EA754;
	Sun, 24 May 2026 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779662021; cv=none; b=aRXN6u708S9GTCmHk5xqaY4UbmSyicdmcLs8w/AnHEJ3LyprsX3OH7oFoqrtB8D+mSJOPcPEhvIphFQn/IWzIaXE78fctPmEwAOzNajUPyhTsO+5zub5x8LofnJQ1CDdggLdCh3SMqhCqRooqyP3oraQbrMPCdX87oGcoRfiGwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779662021; c=relaxed/simple;
	bh=OVbfiwCbrU4CT66OqWxe6Mc7D+zSr21RsiEvCGFJr5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhRUP1aTRl6lK23QEsPKKAIi+0q+slvr5J9PATxp53M3A204byx91pd6FOTxp8CaOYZ+4iK25xBjpCPA5Aur9Lw51lC2yuyRT+gp27vGYai1e8TydEb5jYsG7gUjSu0K6MUpQUw1Rf7ioSjRkyjW/iC43nKuP3wJJ1hbFc0cJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Hda1125G; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 481C7E8373D;
	Mon, 25 May 2026 00:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1779662013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8r3fhUUfMKs8GQRpFB5yeIGJc6QQ+n9U2QnXlTreW2w=;
	b=Hda1125GbtB3XQop91bpH18D9r+/bcNgwAo6hZQuuiR3hdnm9TJ52NZpTrIMsjVvLyYpkb
	5U8m5mnZyMUmLvPJ3ucCm0rk7qGVQ3G4CPa6noy+epu29eCALA1lCvcv1B8qqlBsXNdTbU
	9q4S1YDli/1F46rfehjn7PAS8RWCtUpPLBKo+Kq7LHujuHfXN64QECfpKkojHcIZ/2Xo4m
	tEwcyezfqXD0Eqd1z7zOpNItHL+KBYBH1xgYCh6bN6bXdRpUCpqCeIvoLwpVzhrp8jEL2h
	tDwxYFDPa/VyQZRhB38zK0g8f4MADBmQPqWbNIAtSwnRNN9Y8cztbDZ6j6CFcg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 7EYSFVpVwEi8; Mon, 25 May 2026 00:33:33 +0200 (CEST)
Received: from p14sgen5.lan (p5784d936.dip0.t-ipconnect.de [87.132.217.54])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 25 May 2026 00:33:32 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net 1/2] net: pse-pd: disable IRQ before freeing PI data in unregister
Date: Mon, 25 May 2026 00:33:05 +0200
Message-ID: <20260524223306.2570676-2-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524223306.2570676-1-github@szelinsky.de>
References: <20260524223306.2570676-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291216-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.959];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szelinsky.de:email,szelinsky.de:mid,szelinsky.de:dkim]
X-Rspamd-Queue-Id: DA76D5C496F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pse_controller_unregister() frees the PI array via pse_release_pis()
before disabling the controller IRQ. The threaded IRQ handler pse_isr()
walks pcdev->pi[] (via pse_set_config_isr() and
regulator_notifier_call_chain() on pcdev->pi[i].rdev), so an interrupt
arriving in the window between pse_release_pis() and disable_irq()
dereferences freed memory.

Disable the IRQ first, then release the PI array. cancel_work_sync()
for the notification worker stays after pse_release_pis(): the worker
only touches the kfifo and the pse_control list, not pcdev->pi.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 87aa4f4e9724..17f45e4b672b 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1115,9 +1115,9 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
 	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
 	if (pcdev->irq)
 		disable_irq(pcdev->irq);
+	pse_release_pis(pcdev);
 	cancel_work_sync(&pcdev->ntf_work);
 	kfifo_free(&pcdev->ntf_fifo);
 	mutex_lock(&pse_list_mutex);
-- 
2.43.0


