Return-Path: <netdev+bounces-296316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xJo+AX7qJWqMNgIAu9opvQ
	(envelope-from <netdev+bounces-296316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 00:02:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB34651C71
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 00:02:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b=AkEv3xpX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296316-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296316-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=wp.pl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0516C3009FAE
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3B926ED3C;
	Sun,  7 Jun 2026 22:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6201F91E3
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 22:01:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780869683; cv=none; b=OsnY48OuALTEqI7Rb2UbQy0zYQEK5AGVEMUDR1ttQmqAE31sPmGB2qMzaro9oO5g0wMVTGhr66etRYCMshuG3BZNHR8FbuJRS+RgVvVQdbJDY848gEJc5vZkfrg+z/ujZb+6EQXuATE5j66/84Hi8DtWeZIgpSFXWGqMKv416uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780869683; c=relaxed/simple;
	bh=pbYbfzHZJn15jKp3lFFOAkIDquD3wszzxKyRjN5oI28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rW61i7Nr8iXavt4bMpO65KPYlN/SchNUVkV1gY6AWxoeqJHtN8MG3qrfAK9rNh2GsYe1SLpXe4i5Yd5kvoWUyCmbp9ioaLbsM/nNuInmhxWDob9S+fpAP0X1CFn+RIOZN+pXghdRd5hFnq+GPaAzUsoNuKHD6hZjDtYDhT+lmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=AkEv3xpX; arc=none smtp.client-ip=212.77.101.12
Received: (wp-smtpd smtp.wp.pl 23065 invoked from network); 7 Jun 2026 23:54:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1780869279; bh=3dBNDhJiHQlxvdBDrnFrEN6RfO7AKAcPS9WPFBjqqV4=;
          h=From:To:Cc:Subject;
          b=AkEv3xpXPb4a/IvB0OYO1Wa9EuqcMEr1HCsle4YrDAFYwPoSGKfRY0QqHB3iVsQB9
           lR3dvNA0o1HJ8gX2smy9w4rJj72JLGN/ZG6hLFbkPDefS1HglQBNg7OaBf4kzu6ARM
           9Fyq155sA5qR6Qc1I4ik++o6o2u8xAHODm2MKuj3d5ME14ooB0TPJJIwc5ba1OUPPh
           TgHwWMM8E6WhvWI63zYPgiSeRxEJ2Yhgq/qblqhkn5XOv37rIYVlhhV0TSKxNs/NWK
           uKbd5Czz1AcoNFYt7PpZGtoB1Srf17NSzpUKTLPNHBADlqn8iPeRI/Fm2QxE/yhT80
           O049hkdqlnQuw==
Received: from 83.24.121.144.ipv4.supernova.orange.pl (HELO abajkowski.home) (olek2@wp.pl@[83.24.121.144])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <netdev@vger.kernel.org>; 7 Jun 2026 23:54:38 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: netdev@vger.kernel.org,
	mkubecek@suse.cz
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH ethtool-next] sfpid: add support for newer SFF-8472 compliance codes
Date: Sun,  7 Jun 2026 23:54:25 +0200
Message-ID: <20260607215437.1644059-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 0936d93fac4d7caa57477f48870c6ef0
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kYOk]                               
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
	TAGGED_FROM(0.00)[bounces-296316-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,wp.pl:mid,wp.pl:dkim,wp.pl:from_mime,wp.pl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BB34651C71

This change adds support for newer compliance codes defined in
SFF-8472.

Standards for SFF-8472
a) SFF_8472 Rev 12.5a dated Jan 16, 2026

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 sfpid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sfpid.c b/sfpid.c
index 228b3ee..9e49544 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -188,8 +188,12 @@ static void sff8079_show_transceiver(const __u8 *id)
 		sprintf(value, "%s", "FC: 1200 MBytes/sec");
 	if (id[10] & (1 << 6))
 		sprintf(value, "%s", "FC: 800 MBytes/sec");
+	if (id[10] & (1 << 5))
+		sprintf(value, "%s", "FC: 1600 MBytes/sec");
 	if (id[10] & (1 << 4))
 		sprintf(value, "%s", "FC: 400 MBytes/sec");
+	if (id[10] & (1 << 3))
+		sprintf(value, "%s", "FC: 3200 MBytes/sec");
 	if (id[10] & (1 << 2))
 		sprintf(value, "%s", "FC: 200 MBytes/sec");
 	if (id[10] & (1 << 0))
-- 
2.53.0


