Return-Path: <netdev+bounces-177079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4537CA6DC24
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E4C16B394
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF311EDA31;
	Mon, 24 Mar 2025 13:53:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421825EF8E
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824394; cv=none; b=pI2wRD19MG2FYWKKaL6jROO7WEkO1xLPbhF1KkCM18kK2lUAYQARmLQhqai6pq0F+BWB9t3WanjRNuDhl2cKRrvF0btcHwaG4kLqXT+uO9guiyJ4wbBUKG3eyVpCnkRZEsWc+paqTw2JbiDXt2FPVPFS2lTXGjMo8bBplMUnv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824394; c=relaxed/simple;
	bh=WyxQ9gw43wcho1e1q+Al5XR4eH4uzvOGoWTo5UWHN+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CsBpjtxGHjbV5W1UmKuBKeeOdOoHSEmOWFm+HcxE8zCOGfxEa8GbM2QuBrmJCCX6vAz0ARIDM4x89X4E7ePBF2vBxkssubO0Ihu6a9AG45WqQLvNgjiP8Ygpwl2HKNcq6HxJmBJPY6WWx7n3GG9sl9I/zM8aQma2Co/DNcLELhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1twiEp-0007ny-JP; Mon, 24 Mar 2025 14:53:11 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1twiEo-001Q7D-2w;
	Mon, 24 Mar 2025 14:53:11 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1twiEp-000TcX-0t;
	Mon, 24 Mar 2025 14:53:11 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	netdev@vger.kernel.org
Subject: [PATCH ethtool v1 1/1] ethtool: fix incorrect MDI-X "Unknown" output for MDI mode
Date: Mon, 24 Mar 2025 14:53:10 +0100
Message-Id: <20250324135310.113824-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add a missing case to handle the MDI mode correctly when showing the
current MDI/MDI-X status. Without this, the code may show "Unknown" even
when the status is valid. This regression was introduced in commit
bd1341cd2146 ("add json support for base command").

The logic assumed that `mdi_x = false` was already set at function start
and omitted the `case ETH_TP_MDI:` branch in the switch statement. However,
without an explicit `break`, the code continued into the default case,
resulting in "Unknown" being printed even when the mode was valid.

This patch adds a missing `case ETH_TP_MDI:` with an explicit `break` to
avoid falling into the default case. As a result, users will now correctly
see `MDI-X: off` instead of `Unknown` when the resolved state is MDI.

Fixes: bd1341cd2146 ("add json support for base command")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common.c b/common.c
index 4fda4b49d2fd..1ba27e7577b4 100644
--- a/common.c
+++ b/common.c
@@ -171,6 +171,8 @@ void dump_mdix(u8 mdix, u8 mdix_ctrl)
 		mdi_x_forced = true;
 	} else {
 		switch (mdix) {
+		case ETH_TP_MDI:
+			break;
 		case ETH_TP_MDI_X:
 			mdi_x = true;
 			break;
--
2.39.5


