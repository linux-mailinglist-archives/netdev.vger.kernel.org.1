Return-Path: <netdev+bounces-271500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKooLgnHw2lKuAQAu9opvQ
	(envelope-from <netdev+bounces-271500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:29:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E43323E46
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56F99313B429
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95B347536;
	Wed, 25 Mar 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zdjcJNJH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QGzhLg7T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zdjcJNJH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QGzhLg7T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8A3C6A27
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437664; cv=none; b=QjoCIbZrxVJQKFhAfYRxi+y/eGohbi6WxAvAr2hR+j64EHZEkvFlux8KcIM6typ9vAYm+WZUuT0QdIFLtelw8fFX4q7idinzaJzDchAXgZkKxwwFo+quykQaO69L+2QP2NmrEXnw4vWxWvIte2/2YOqEe8eaWKIbh5yLETYYd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437664; c=relaxed/simple;
	bh=GG0nl2on0VewYM1GlAFT6peou8owq2vZ8Sq7vLDd9XE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T4Kb0ufSMHzpWt/+z77p7oc7qW4JFjrRxNSkmLxkzqa1q/uFoC7jd6bAwGWkq8Sv+G/DQVaeq9lgMNwkwiqJ2ZdZLkosjyoZJL5/LXWk2Rweb3kFEtO7JS2alHu+BuE8zbWZvNV7ABv96rMm1/lRmfKq9w1DhquM9rU4Y1lglw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zdjcJNJH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QGzhLg7T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zdjcJNJH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QGzhLg7T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F42265BCE8;
	Wed, 25 Mar 2026 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774437662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YtQXCFM9mJfWQys+devYf0oIE8i/ZK8S4Lnr93L1wpI=;
	b=zdjcJNJH+9NdJHUl9iwaxG7iAFk1+P2rmA/NpY9I8MXTZhkkFI82dS2q6sgN2WIExKaCKJ
	yfMy1qY8TPbvGE15zDTo3DxtxqCdw/o5gSr0ceYNmRV3VOMnjof+tPzqe444m/F5p8HdJb
	VbICkq3V6xkbCc6PltDY4rIGwYROWAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774437662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YtQXCFM9mJfWQys+devYf0oIE8i/ZK8S4Lnr93L1wpI=;
	b=QGzhLg7ToJUufv2TXySOGiny/XjPiP3Y3jQGd9DR7vKSVevz1ggDEVdRaF4DEzIoz4R0BF
	fVSZo0MtWZ0RCPDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774437662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YtQXCFM9mJfWQys+devYf0oIE8i/ZK8S4Lnr93L1wpI=;
	b=zdjcJNJH+9NdJHUl9iwaxG7iAFk1+P2rmA/NpY9I8MXTZhkkFI82dS2q6sgN2WIExKaCKJ
	yfMy1qY8TPbvGE15zDTo3DxtxqCdw/o5gSr0ceYNmRV3VOMnjof+tPzqe444m/F5p8HdJb
	VbICkq3V6xkbCc6PltDY4rIGwYROWAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774437662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YtQXCFM9mJfWQys+devYf0oIE8i/ZK8S4Lnr93L1wpI=;
	b=QGzhLg7ToJUufv2TXySOGiny/XjPiP3Y3jQGd9DR7vKSVevz1ggDEVdRaF4DEzIoz4R0BF
	fVSZo0MtWZ0RCPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8E374438D;
	Wed, 25 Mar 2026 11:21:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FjzgLB3Fw2kTBAAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Wed, 25 Mar 2026 11:21:01 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nithin Sujir <nsujir@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tg3: Fix race for querying speed/duplex
Date: Wed, 25 Mar 2026 12:20:53 +0100
Message-ID: <20260325112054.108988-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[tbogendoerfer@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271500-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 36E43323E46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When driver signals carrier up via netif_carrier_on() its internal
link_up state isn't updated immediately. This leads to inconsistent
speed/duplex in /proc/net/bonding/bondX where the speed and duplex
is shown as unknown while ethtool shows correct values. Fix this by
using netif_carrier_ok() for link checking in get_ksettings function.

Fixes: 84421b99cedc ("tg3: Update link_up flag for phylib devices")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/broadcom/tg3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 21a5dd342724..73a4b569b03e 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -12299,7 +12299,7 @@ static int tg3_get_link_ksettings(struct net_device *dev,
 	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
 						advertising);
 
-	if (netif_running(dev) && tp->link_up) {
+	if (netif_running(dev) && netif_carrier_ok(dev)) {
 		cmd->base.speed = tp->link_config.active_speed;
 		cmd->base.duplex = tp->link_config.active_duplex;
 		ethtool_convert_legacy_u32_to_link_mode(
-- 
2.43.0


