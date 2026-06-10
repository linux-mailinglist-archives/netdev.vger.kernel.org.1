Return-Path: <netdev+bounces-297802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tZy+LjS0KWrKcAMAu9opvQ
	(envelope-from <netdev+bounces-297802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:00:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AED66C66F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:00:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b=PanIYzWQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297802-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297802-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=wp.pl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E4930E94B7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4271357CEA;
	Wed, 10 Jun 2026 19:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D82110E
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 18:59:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118001; cv=none; b=VSN9twCoUKf5iY9s9hlZ0XVKLGmJ4wZV8CHeiLYT+a7utnJjy/pKyIxOO66FFVBZ6bvjJ+eS6JoQL5xp+qB78go9qC4DJRzSMOhEJQoXxEMhlrqHAkmRMCLbq8GLLkWX/rdIctau+clZ7lZJjBjxuXc3ySix2ZJaCr4Ap6E8KN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118001; c=relaxed/simple;
	bh=1kyn1VR//42jnmQGMzQ18Vzmwi7spfpQEIuTQbYvfU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s595EDdWUsjZm+i5+WboCCpBN27inX4ExVKnqdbHWLC1qcjDFcvhKgEjMm1yi1CtUTlbz93cx0LLlifQ/EUQ2qu7BWp3SaWdajg2iroMyaaVBRK3VXosHmox9360DKqdH0SGTkDpRgPN0E3C32DA5zI2McjyDsPcO9nqjxGoHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=PanIYzWQ; arc=none smtp.client-ip=212.77.101.12
Received: (wp-smtpd smtp.wp.pl 35321 invoked from network); 10 Jun 2026 20:53:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1781117589; bh=j4Mcj03/td0lnW1QLvJhjAVWTCPO1S2DLEnc9vtshok=;
          h=From:To:Cc:Subject;
          b=PanIYzWQzHpvNpgQIMS4culp/2fcIWVo8UD7yJXhwZ+zAPz3t8u6P+7jNaxhY1b1U
           qZVgywktRbOBNvpaW6wR6xZAFCbbsvMvTthWRi8Su7IIkrJFpKlAN5Bm1x/I/Ibivj
           9MLzncjNhgt8uB6ZwMpXTD9mH5AZv94xpL13gdVcMxasIJ6O470dVqohqeGc+PHz/U
           K+rIn50w01+2h+HoA6nKGY9cHo8MogRMiAtARyRDNj25pacZMNYSyK8Kz/MiMzwYNq
           DxWV0Kce2yvD/1ZJXg6XQ/R06J0Fk2yNlvCaW04xokRAG4Y1d9xl1r2T0rRJrjGWOc
           AUxxV6BXXksnA==
Received: from 83.24.121.144.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.24.121.144])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <netdev@vger.kernel.org>; 10 Jun 2026 20:53:09 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: netdev@vger.kernel.org,
	mkubecek@suse.cz
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH ethtool-next] sfpid: fix 10G Base-ER module detection
Date: Wed, 10 Jun 2026 20:51:55 +0200
Message-ID: <20260610185308.61643-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 3c6886ac775323a906d4b187028d080a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [EXN0]                               
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297802-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:olek2@wp.pl,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wp.pl:+];
	FREEMAIL_FROM(0.00)[wp.pl];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,wp.pl:dkim,wp.pl:email,wp.pl:mid,wp.pl:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0AED66C66F

According to the specification[1], byte 3 bit 7 corresponds to the
10G Base-ER standard.

1. SFF_8472 Rev 12.5a dated Jan 16, 2026
Fixes: 4071862f58d8 ("sfpid: Add JSON output handling to --module-info in SFF8079 modules")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 sfpid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sfpid.c b/sfpid.c
index 228b3ee..8123fe8 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -73,7 +73,7 @@ static void sff8079_show_transceiver(const __u8 *id)
 	/* 10G Ethernet Compliance Codes */
 	if (id[3] & (1 << 7))
 		sprintf(value, "%s",
-			"10G Ethernet: 10G Base-LRM [SFF-8472 rev10.4 onwards]");
+			"10G Ethernet: 10G Base-ER [SFF-8472 rev10.4 onwards]");
 	if (id[3] & (1 << 6))
 		sprintf(value, "%s", "10G Ethernet: 10G Base-LRM");
 	if (id[3] & (1 << 5))
-- 
2.53.0


