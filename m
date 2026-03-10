Return-Path: <netdev+bounces-265988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePqVMzL0r2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:36:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FC6249749
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6D50312FF2E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F0371046;
	Tue, 10 Mar 2026 10:36:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0E36EA9A
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138965; cv=none; b=d7uIe0lxzcspks3oGE/t0wi9c5s1L3R+n/JssoszCe1LO9QBwH1laNWF7bQpxfhz/7KEFDCNSyI/+/OtmtmnseEuwKGYIvLkW7O4EzUQ6dTKMov82stWDnFv2cYk0fad8AlEwMUH4LrMLKEBNaT9E1QKvSHnsk2pZeZBH90/7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138965; c=relaxed/simple;
	bh=tN6JaS7gg5JiKDF60xeQwht2M7cFmnKGfq6sCUyl7NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaHcctnwMLfuafW+viRbOtWbF2Awga/M7Lu8Y78rI3HjMmMR+pGO7XwHJE95XERjNjGzGOFQD4ZjTnd34fFitYcuKhziqtPbKXHS9uBzCTpaRWyUmnRGgeQTAJSFWYlGJDyct5cRppliwS+3VWg2o7hIBO6XNkR5VJUTcrX868U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzuRO-0001Ko-Mi; Tue, 10 Mar 2026 11:35:54 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzuRM-004gN5-1D;
	Tue, 10 Mar 2026 11:35:53 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6C50B4FD2B1;
	Tue, 10 Mar 2026 10:35:53 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Haibo Chen <haibo.chen@nxp.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/2] can: dev: keep the max bitrate error at 5%
Date: Tue, 10 Mar 2026 11:30:34 +0100
Message-ID: <20260310103547.2299403-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310103547.2299403-1-mkl@pengutronix.de>
References: <20260310103547.2299403-1-mkl@pengutronix.de>
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
X-Rspamd-Queue-Id: 30FC6249749
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
	TAGGED_FROM(0.00)[bounces-265988-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pengutronix.de:mid,pengutronix.de:email,nxp.com:email]
X-Rspamd-Action: no action

From: Haibo Chen <haibo.chen@nxp.com>

Commit b360a13d44db ("can: dev: print bitrate error with two decimal
digits") changed calculation of the bit rate error from on-tenth of a
percent to on-hundredth of a percent, but forgot to adjust the scale of the
CAN_CALC_MAX_ERROR constant.

Keeping the existing logic unchanged: Only when the bitrate error exceeds
5% should an error be returned. Otherwise, simply output a warning log.

Fixes: b360a13d44db ("can: dev: print bitrate error with two decimal digits")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://patch.msgid.link/20260306-can-fix-v1-1-ac526cec6777@nxp.com
Cc: stable@kernel.org
[mkl: improve commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index cc4022241553..42498e9d3f38 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -8,7 +8,7 @@
 #include <linux/units.h>
 #include <linux/can/dev.h>
 
-#define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
+#define CAN_CALC_MAX_ERROR 500 /* max error 5% */
 
 /* CiA recommended sample points for Non Return to Zero encoding. */
 static int can_calc_sample_point_nrz(const struct can_bittiming *bt)

base-commit: e3f5e0f22cfc2371e7471c9fd5b4da78f9df7c69
-- 
2.51.0


