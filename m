Return-Path: <netdev+bounces-307049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K4lcCkuWVGq4nwMAu9opvQ
	(envelope-from <netdev+bounces-307049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:39:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DDE748454
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:39:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307049-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307049-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BFC4301BEFB
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E0439023A;
	Mon, 13 Jul 2026 07:39:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A439099B
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:39:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928373; cv=none; b=TXIKRMMqx3zSs9vjr30FnGX2J40iGuezSI5h4lc/TQPRZgsT6eiEUWgRxcVEypwM4bPvOE/nY5B0onXaetFf4IRc38xwfzmEsvTYbBVghhiPH2NWSnGj06m9N65A8J5piyy1DPCX9ho1H2d1/3B9gcJ+dgdtneD1VUsFC51OCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928373; c=relaxed/simple;
	bh=MGcOqSGsVEqJ/zaYb4Qq0DtdLiMi/G5Vx0tmSpaSogk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pa90jG+ZUtpk32TvRD8VeJQp+QHhjrAuFGHXnUmcEAHvVJQuL69OGwDzR1nfyAh1fQQRs5PQVesXjESZ6iCaUj618i3IaJ7GR070GFSBrag1t1C3TOS1olNGfX8aFVeDwIS8/+CFUF1mESSKKuBMqoPghuav08FBINFZSTfAZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: f88c92de7e8d11f1aa26b74ffac11d73-20260713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:31cce9d5-c41f-4613-947d-ea62013d0af3,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:083d79a2aede1a9c6bcda69e5eca236d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f88c92de7e8d11f1aa26b74ffac11d73-20260713
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1229545399; Mon, 13 Jul 2026 15:39:25 +0800
From: Minhong He <heminhong@kylinos.cn>
To: netdev@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Subject: [PATCH] mctp: check register_netdevice_notifier() error in mctp_device_init()
Date: Mon, 13 Jul 2026 15:39:18 +0800
Message-Id: <20260713073918.419422-1-heminhong@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_FROM(0.00)[bounces-307049-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[heminhong@kylinos.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heminhong@kylinos.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75DDE748454

mctp_device_init() handles errors from rtnl_af_register() and
rtnl_register_many(), but ignores the return value of
register_netdevice_notifier(). If notifier registration fails, init can
still return success while the module is only partially initialized.

Check the notifier registration error and fail module init early.

Fixes: d51705614f66 ("mctp: Handle error of rtnl_register_module().")

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/mctp/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 2c84df674669..822120e860c8 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -536,7 +536,9 @@ int __init mctp_device_init(void)
 {
 	int err;
 
-	register_netdevice_notifier(&mctp_dev_nb);
+	err = register_netdevice_notifier(&mctp_dev_nb);
+	if (err)
+		return err;
 
 	err = rtnl_af_register(&mctp_af_ops);
 	if (err)
-- 
2.25.1


