Return-Path: <netdev+bounces-269519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GhMGRgfvGnQswIAu9opvQ
	(envelope-from <netdev+bounces-269519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:06:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B932CE5AF
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D14B8325B12F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A13E92AC;
	Thu, 19 Mar 2026 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="gdFgbrAo"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374503ECBED;
	Thu, 19 Mar 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935992; cv=none; b=SlLIMfhl4Q1OCazD1NXSiYh3YQlrbFpQTtvhoFYQnsS7Q7AuIoM6qchdfzJQlOHX4jRqNLFOGSKbph2U4mSapYd8jYCpk+1JCoBRvNY3U9/ZS8YIKft0fMwRQmcJvr0UwPkNlo0R8HwfrQisMHbOKUqjrcmLpG0sSQdACAhiTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935992; c=relaxed/simple;
	bh=ZIbL8O3aZl5ul6YYE2WhB6DNFvoF5FLE6NgalzEmeKE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ovBytAcQU81Odz50wXsKZ91SOwi4wC3xT9MlRVU2QUB7ljXS8l4UfH01OfNBgBkjunItegTBATVt7ZlErzcL81ngaylqLIUO6zaTYA9MCkbbr/EsuBVHG+ghjqpPNfFKstJywR2IznmKi4dP3chm1WNp9WYdG0YyCYUCTU7QloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=gdFgbrAo; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id AB7ADA1F50;
	Thu, 19 Mar 2026 16:59:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=IIVPZ8hHZTMlGdVC1NhCotK5Ln5lWFWOjoay+zBfjxM=; b=
	gdFgbrAoXJzIWTJ4zcwXiGK1MpldNHCafm5jGTfYjeOlXgYzrI8GB52esmqjoHG8
	3ssWuOH1AZosk81LIUAknSneePV1rHZyjJdMGPk4wg8IXLAw+kVwQbE9nAGz20u/
	CWzQSOrGUwdKQUuV6SJzUB38Zum8HXd/ZfJC52t8KMLQFOiG7Tn23PrCH2ZMCms5
	7t33nsQe7H4vJixOqaNqoDr1JcavkPanf4Yx2HHkdsFMMkWYloDUGRKORQYJk5DU
	Zv62pZm/liEbTiOPjuUmCRJunhnN6fgIXtexTqqA8p6zh5Wal9hI+kEi+dRU/EKA
	nYVUkLsQOPer/fvJB0FKpYTbQoQ82v97dvUyAJFz636+hOe4ms4FY14JS+uFEsos
	mCJSVMtbIIwXpK1rgXlnP2eotFvGkjHk74KhS/xmoMMhgfxkWcFMMYTHLe42tKJK
	5DueDv8+N+BVXq8oACd4cqVKJ0L3uG6iYPYlIqBZPlStNsC6KKavmF25ctzv1Hue
	n7aYsIDGXfwyHoxHG0DX47q/qGMvMp96OWYXsZm96WDMA99iP22HXPagCkUJDJPK
	aHi/0VFkRvIE05nEnEjiuP1EYuomaYs+1F5c9J61G5La0NylRmoi/x+vf4IVIz01
	TsduB3US2HBv3JqFpsF++ULb8EYQOseRNGYoLO+38xk=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?=
	<bence98@sch.bme.hu>, Francesco Dolcini <francesco.dolcini@toradex.com>,
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net v2 1/1] net: fec: fix the PTP periodic output sysfs interface
Date: Thu, 19 Mar 2026 16:59:34 +0100
Message-ID: <7012fbf90b844083d5fa7d764ed6372fe0288157.1773928309.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1773935977;VERSION=8008;MC=505402051;ID=100136;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD5150627D6A
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[prolan.hu,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[prolan.hu:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,sch.bme.hu,toradex.com,lists.linux.dev,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269519-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[prolan.hu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[buday.csaba@prolan.hu,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A5B932CE5AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the PPS channel configuration was implemented, the number of
supported periodic outputs (`n_per_out`) was left at 1.

This prohibits using channels 1..3 from the sysfs interface, since
period_store() rejects channel numbers greater than `n_per_out`.

Fix by increasing `n_per_out` to the number of channels supported
by the hardware.

Fixes: 566c2d83887f ("net: fec: make PPS channel configurable")
Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 4b7bad9a485d..1a7aa280e7f6 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -756,7 +756,7 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	fep->ptp_caps.max_adj = 250000000;
 	fep->ptp_caps.n_alarm = 0;
 	fep->ptp_caps.n_ext_ts = 0;
-	fep->ptp_caps.n_per_out = 1;
+	fep->ptp_caps.n_per_out = 4;
 	fep->ptp_caps.n_pins = 0;
 	fep->ptp_caps.pps = 1;
 	fep->ptp_caps.adjfine = fec_ptp_adjfine;

base-commit: 8a63baadf08453f66eb582fdb6dd234f72024723
-- 
2.39.5



