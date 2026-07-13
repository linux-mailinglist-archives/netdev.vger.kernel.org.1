Return-Path: <netdev+bounces-307053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id agTwEE6ZVGpgoAMAu9opvQ
	(envelope-from <netdev+bounces-307053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:52:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C065748642
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:52:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307053-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307053-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC89230068E7
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF6A394794;
	Mon, 13 Jul 2026 07:52:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BE3932CE
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:52:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929155; cv=none; b=bWh6xsIZHDiFaHYJRAh4ugiQVDnA3XX8viWkqZ06rqJzjMXoDzAiVwlW5RYL+H9ole3z9k2DTVjxS6zap1xHrCjTw0778nUVhuLUqRW13TyHarHDqp0bMrJ2r5juLasGWdbU+Z5ccCtvwYdwq/cysVZmT94df6vpTrhsnFSjWyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929155; c=relaxed/simple;
	bh=lLFo85v/OqsPVD//y9vy7l5rrYW1ERl7YcFRTbJ/wls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kKsWGhcLu2iss25GFlFKoG6Yub0/6o6hyXgyfvHeW/ypbX7DVCnzaZOMDql0JkqDRF3qiiYwVnAeOlsrOq6l96awfsHWfVb/2o4FI0HMP8rNZAbm5UFTMn/mTC6ofi392eqjHbg571GvO3OZGvySP0K2ezc2psBfM04iV3BA2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: c93fe22c7e8f11f1aa26b74ffac11d73-20260713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:96db0c3d-7415-44ec-91b4-c9f7fe34ec4a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:42bd8647ce1d024411f3802dff6fc483,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c93fe22c7e8f11f1aa26b74ffac11d73-20260713
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 989106873; Mon, 13 Jul 2026 15:52:24 +0800
From: Minhong He <heminhong@kylinos.cn>
To: netdev@vger.kernel.org
Cc: Remi Denis-Courmont <courmisch@gmail.com>
Subject: [PATCH] phonet: check register_netdevice_notifier() error in phonet_device_init()
Date: Mon, 13 Jul 2026 15:52:12 +0800
Message-Id: <20260713075212.431455-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_FROM(0.00)[bounces-307053-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:courmisch@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[heminhong@kylinos.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heminhong@kylinos.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C065748642

phonet_device_init() registers a netdevice notifier before calling
phonet_netlink_register(), but does not check whether notifier
registration succeeded. On failure, netlink setup still proceeds and
init may return success without the notifier in place.

Check the notifier registration error and unwind through
phonet_device_exit() on failure.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/phonet/pn_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index ad44831d6745..0445f7ef0320 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -356,7 +356,11 @@ int __init phonet_device_init(void)
 
 	proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
 			sizeof(struct seq_net_private));
-	register_netdevice_notifier(&phonet_device_notifier);
+	err = register_netdevice_notifier(&phonet_device_notifier);
+	if (err) {
+		phonet_device_exit();
+		return err;
+	}
 	err = phonet_netlink_register();
 	if (err)
 		phonet_device_exit();
-- 
2.25.1


