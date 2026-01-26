Return-Path: <netdev+bounces-253333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG+TCKAId2lGawEAu9opvQ
	(envelope-from <netdev+bounces-253333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:24:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 502BF847B9
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3E20300980E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFED283CBF;
	Mon, 26 Jan 2026 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bfP+VeGp"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547327877D;
	Mon, 26 Jan 2026 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408589; cv=none; b=LodmbGSmqFFkrF8WC2tgyWcygI72JuqyModcyeyUK+futWBLhjtOeHgD9KGJZIfH5XetTxRPzptn9xf164e4z0q8haaE3vWv0Xxu4wfHz3x8tooJY0oa8eX8wHsC6rLJRNfvPkf3TOUVP0gA61bjJusvkLYR3PFuiQwEk7FsDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408589; c=relaxed/simple;
	bh=hPpGrhBm7dswjrLDv/THjvYEQrlbFx3TtA9jAFW1hNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZpAOkaYfPfok+BEM8wKjyYB7Emn015AvdfH0HzQAY9cJzsgRDQJNxrCn7Uth2bFUzNRt5TVMKtE7SfxoeaG/zfi3Q4aJZwHOxIH4Kt16c0l+4/YozL0CMkuqhEPkwOb2QANaVDBpmugBjSWAMFc149pInvtOk6muo6RHSDKoR/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bfP+VeGp; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/4
	b01nswZlIsKdbMEMUcNlPloW0gjn+e2EWs/AY2u78=; b=bfP+VeGpXawUJ1U7qg
	Jm3JxskRS5QeC8yy1hMayXe2ucmppG65A7loKbkJ5M5e2MeOCJEqxIVWivEyMCmR
	L20w5FcKGqZ+1v+4knbDsfagFstECVUU0cxmKmVFL2U7AL4Qz1HhhYyju+PC5aOE
	7EX0NVO0M7xDgucwox96Nclc8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHzzkJCHdpL7kRIg--.5216S10;
	Mon, 26 Jan 2026 14:22:18 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slark_xiao@163.com
Subject: [net-next v8 8/8] net: wwan: mhi_wwan_ctrl: Add NMEA channel support
Date: Mon, 26 Jan 2026 14:21:58 +0800
Message-Id: <20260126062158.308598-9-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260126062158.308598-1-slark_xiao@163.com>
References: <20260126062158.308598-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHzzkJCHdpL7kRIg--.5216S10
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3Xw48Gr4fGr4kur1rJFb_yoWfKrgE9w
	1kXF9rJrW3J347KFsF9F13urWfK3W0qF4kXFnaqr9Yv347XFyfWw1kZF4Dtr9F9r17CF9r
	urnxWayFyw4fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi4rW5UUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwBtApGl3CBt1MQAA32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253333-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slark_xiao@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 502BF847B9
X-Rspamd-Action: no action

For MHI WWAN device, we need a match between NMEA channel and
WWAN_PORT_NMEA type. Then the GNSS subsystem could create the
gnss device succssfully.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/net/wwan/mhi_wwan_ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index e9f979d2d851..e13c0b078175 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -263,6 +263,7 @@ static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
 	{ .chan = "QMI", .driver_data = WWAN_PORT_QMI },
 	{ .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },
 	{ .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
+	{ .chan = "NMEA", .driver_data = WWAN_PORT_NMEA },
 	{},
 };
 MODULE_DEVICE_TABLE(mhi, mhi_wwan_ctrl_match_table);
-- 
2.25.1


