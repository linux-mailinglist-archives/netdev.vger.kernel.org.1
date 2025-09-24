Return-Path: <netdev+bounces-225864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3F1B98D6F
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DA9168AB7
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61C62BE643;
	Wed, 24 Sep 2025 08:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE52877E5
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702115; cv=none; b=thMTBelb4hyP/ZxqSrCDKXHjxDsDNBD8grJx6ufYvhunw71wB2EaSALygtEDFqc8GKaJyVR+1Np/PSw0Eo64TgN+tvjfDnj+95rLgdapwCl9WUndGd4NAm95EKsgCdxhotIwHALgsGt2jsZyJhkC2XCYOX/vvR1oVHfyJRJ31ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702115; c=relaxed/simple;
	bh=ufAB8RsL7GnbYV8hEwh8am0wgYyRKz5q9d9U4oB6K3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQ6lvnckOH/J9yqNTjec75p0hhIEXzqZsPMhSdLohVTkC9eUgLsWRNpIAqDPcGToCS/ps6hZUu5cmhGhkYCMou0ofeW7kAwAU5YL3xPwLWvb7Wf+Qd8vmoWANk70eXUn1Q2yznTA7hATmgq2YbFigtqch1VyPhjxQzMple19MuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-0001E1-8h; Wed, 24 Sep 2025 10:21:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000DvH-0T;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1052A478890;
	Wed, 24 Sep 2025 08:21:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 22/48] can: raw: reorder struct uniqframe's members to optimise packing
Date: Wed, 24 Sep 2025 10:06:39 +0200
Message-ID: <20250924082104.595459-23-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

struct uniqframe has one hole. Reorder the fields to save 8 bytes.

Statistics before:

  $ pahole --class_name=uniqframe net/can/raw.o
  struct uniqframe {
  	int                        skbcnt;               /*     0     4 */

  	/* XXX 4 bytes hole, try to pack */

  	const struct sk_buff  *    skb;                  /*     8     8 */
  	unsigned int               join_rx_count;        /*    16     4 */

  	/* size: 24, cachelines: 1, members: 3 */
  	/* sum members: 16, holes: 1, sum holes: 4 */
  	/* padding: 4 */
  	/* last cacheline: 24 bytes */
  };

...and after:

  $ pahole --class_name=uniqframe net/can/raw.o
  struct uniqframe {
  	const struct sk_buff  *    skb;                  /*     0     8 */
  	int                        skbcnt;               /*     8     4 */
  	unsigned int               join_rx_count;        /*    12     4 */

  	/* size: 16, cachelines: 1, members: 3 */
  	/* last cacheline: 16 bytes */
  };

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250917-can-raw-repack-v2-1-395e8b3a4437@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 76b867d21def..db21d8a8c54d 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -75,8 +75,8 @@ MODULE_ALIAS("can-proto-1");
  */
 
 struct uniqframe {
-	int skbcnt;
 	const struct sk_buff *skb;
+	int skbcnt;
 	unsigned int join_rx_count;
 };
 
-- 
2.51.0


