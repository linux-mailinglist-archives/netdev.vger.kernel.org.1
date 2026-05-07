Return-Path: <netdev+bounces-285272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOaFLd52/Gm3QQAAu9opvQ
	(envelope-from <netdev+bounces-285272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:26:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3595A4E7710
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26ECE304D244
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0083C3BF5;
	Thu,  7 May 2026 11:23:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05EC3C9ECF
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153015; cv=none; b=Xc+0kfK6y+qWswV/8QLrusf7Vb0qML40zQr1LGkIzEoLFb4fFabW6Jd73k1s4X3Qr0Ku4gnajXuzaco6jRb0eSaSvszPehwd5qBhwdumaa28SBebosgXfDpZWf/i3PmvL4KzFktXr5AJ9fDIEbvJ3w6cUQ0AuLtXW0GpabPvx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153015; c=relaxed/simple;
	bh=AXqnKFwPhagRw4/AFW8BZoUlS1dCiO0WVwVT7qeTPFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1xNCHmLI+XKR5M+WNOGYJ/yg+4SrQjJlxb0MbGzGUxupNhEdUCbEz9lC8Rnx+dKWpYS4vCQDwRdd4jpEdfqMAdtXzhE31GYHp+diNAKgN73Ug0Us4S+kyDc6M5kHsc5HRXGFUeVkq8HcQH3FDjjP5CTGEa5GMEFnJXIzk0YWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKwp9-0002vk-NS; Thu, 07 May 2026 13:23:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKwp8-000ufe-39;
	Thu, 07 May 2026 13:23:23 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 20FB4530407;
	Thu, 07 May 2026 11:23:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Lee Jones <lee@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/6] can: bcm: prevent thrtimer UAF in rx path by checking RX_NO_AUTOTIMER
Date: Thu,  7 May 2026 10:22:24 +0200
Message-ID: <20260507112321.439968-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507112321.439968-1-mkl@pengutronix.de>
References: <20260507112321.439968-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Queue-Id: 3595A4E7710
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-285272-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,pengutronix.de:email,pengutronix.de:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Lee Jones <lee@kernel.org>

Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
synchronize_rcu()") removed the synchronize_rcu() call from
bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
timers from being rearmed during deletion.  However, it only applied
this check to op->timer via bcm_rx_starttimer().

It missed the fact that op->thrtimer can also be rearmed by an
in-flight bcm_rx_handler() (which runs as an RCU reader) via
bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
bcm_remove_op() has already cancelled it, leading to a use-after-free
when the timer fires on the deferred-freed struct bcm_op.

Address the omission by checking the RX_NO_AUTOTIMER flag
in bcm_rx_update_and_send() before starting op->thrtimer, effectively
preventing it from being rearmed concurrently with teardown.

Signed-off-by: Lee Jones <lee@kernel.org>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
Link: https://patch.msgid.link/20260422102239.948594-1-lee@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a4bef2c48a55..67e5b3149a8f 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -539,6 +539,12 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
 	if (hrtimer_active(&op->thrtimer))
 		return;
 
+	/* bcm_remove_op() may have cancelled thrtimer concurrently with this
+	 * RCU-protected handler; do not rearm it. Mirrors bcm_rx_starttimer().
+	 */
+	if (op->flags & RX_NO_AUTOTIMER)
+		return;
+
 	/* first reception with enabled throttling mode */
 	if (!op->kt_lastmsg)
 		goto rx_changed_settime;
-- 
2.53.0


