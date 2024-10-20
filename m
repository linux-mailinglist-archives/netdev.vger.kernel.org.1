Return-Path: <netdev+bounces-137268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149019A53B5
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 13:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C141C20A17
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2EF1917E7;
	Sun, 20 Oct 2024 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J8ufdvJy"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28073EAF1
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729423411; cv=none; b=BW+CBo76lqB1s7MKLnlLoa2cB11JAdG91mUv1K45HVvPNMKZBuuNsw1FojutJ8XRbfk8bT2XajHkYUU4zHcD2DCe1Rr6WTRBkY/bgTyXd1eMvZrbg3yNZBWMlUx2CcMMSoYO0X3SYYGKugRPJJLHrYb+ocA83vWBhEts13UbnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729423411; c=relaxed/simple;
	bh=7ab6qhqpOr1ssykYDytup+FJiV1Hjtf3sZnKjdc3abA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFxSvCwPjivUMEERjsUVVi5Tl2D0q6QvFfZGmPP2FEquGNIjjHNHQrgruaKLIkgAsGBRHOYZFmelmT6CzC529VijFanCMoi3KNjc+p+Z4H+VMVx+yK36O8MiJsj5IvZstQLHFKSAAXTBD8YARQbNNkvCnckE52yC2DfHq4UDNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J8ufdvJy; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729423406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HakpnS82zsiPFFcOCMvXL4ULTEn0kEgh+KDi+4EqXVQ=;
	b=J8ufdvJyDC5yOgEJbbgu29wPam8PL+9XepPZ6/m109PAPFElp48Kt2Jx4qmn6f1GFCXRMX
	hvOnqBxl7LaHUfnDXp1PbjQadEbwSZlOZ+r0u2z/cggVTwOJXPCLBJvWyfUSNz6K7k1GhX
	6xh3rdo5x+8wKwvW7wnn1MAni4FQIN8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ieee802154: Replace BOOL_TO_STR() with str_true_false()
Date: Sun, 20 Oct 2024 13:23:13 +0200
Message-ID: <20241020112313.53174-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the custom BOOL_TO_STR() macro with the str_true_false() helper
function and remove the macro.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/ieee802154/trace.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
index 591ce0a16fc0..284b63a0834e 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -35,8 +35,6 @@
 #define WPAN_CCA_PR_FMT	"cca_mode: %d, cca_opt: %d"
 #define WPAN_CCA_PR_ARG __entry->cca_mode, __entry->cca_opt
 
-#define BOOL_TO_STR(bo) (bo) ? "true" : "false"
-
 /*************************************************************
  *			rdev->ops traces		     *
  *************************************************************/
@@ -273,7 +271,7 @@ TRACE_EVENT(802154_rdev_set_lbt_mode,
 	),
 	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT
 		", lbt mode: %s", WPAN_PHY_PR_ARG,
-		WPAN_DEV_PR_ARG, BOOL_TO_STR(__entry->mode))
+		WPAN_DEV_PR_ARG, str_true_false(__entry->mode))
 );
 
 TRACE_EVENT(802154_rdev_set_ackreq_default,
@@ -292,7 +290,7 @@ TRACE_EVENT(802154_rdev_set_ackreq_default,
 	),
 	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT
 		", ackreq default: %s", WPAN_PHY_PR_ARG,
-		WPAN_DEV_PR_ARG, BOOL_TO_STR(__entry->ackreq))
+		WPAN_DEV_PR_ARG, str_true_false(__entry->ackreq))
 );
 
 TRACE_EVENT(802154_rdev_trigger_scan,
-- 
2.47.0


