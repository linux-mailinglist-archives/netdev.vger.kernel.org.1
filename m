Return-Path: <netdev+bounces-210111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40194B121D8
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84CDF7B88B4
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D992EF291;
	Fri, 25 Jul 2025 16:21:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD42EE97B
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460479; cv=none; b=DPmQ2RAfVtJv8QyCIgUkkRXp22REk2DNuoBJlku++4HUkBy3FFrunqmVJaYaX09orkDAlRlvUo/cj/+TqAMjWvMjGdhJnwCNKTec3YlKTRhSjf1ceEcxDLtysnlOK6jo30i4Hw0KPrGw1fb5LG6VtfgzR66fJvCVu0BPM1F14yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460479; c=relaxed/simple;
	bh=gFoKJIxlTdT5KJ3HHf1mXD60dnuLyxBwdLGvfHryUD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcoMAXfd3eEt6lZpQWwgpNtiAZnk+bdGt/HRDyt05+zvn1IBCUSkqjILf+kKI/pZIHOC0hTqFVHtvg+6VlGnQgBT8qM27gE0rMxPwRGZC75+/p+tM0lR1LznpjVfh7MPrjbK4dpjCFPP7kS0mRTf/ZGwA40oV/wNhL8BHOlLNBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufLAa-0000oQ-7Z
	for netdev@vger.kernel.org; Fri, 25 Jul 2025 18:21:16 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufLAa-00AFhG-01
	for netdev@vger.kernel.org;
	Fri, 25 Jul 2025 18:21:16 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 468B6449882
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0E54F44980E;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9e5ba3d1;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Pavel Pisa <pisa@fel.cvut.cz>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/27] docs: Fix kernel-doc error in CAN driver
Date: Fri, 25 Jul 2025 18:05:16 +0200
Message-ID: <20250725161327.4165174-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
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

From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>

Fix kernel-doc formatting issue causing unexpected indentation error
in ctucanfd driver documentation build. Convert main return values
to bullet list format while preserving numbered sub-list in order to
correct indentation error and visual structure in rendered html.

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
Link: https://patch.msgid.link/20250722035352.21807-1-luis.hernandez093@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index bf6398772960..8bd3f0fc385c 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -506,11 +506,12 @@ static bool ctucan_is_txt_buf_writable(struct ctucan_priv *priv, u8 buf)
  * @buf:	TXT Buffer index to which frame is inserted (0-based)
  * @isfdf:	True - CAN FD Frame, False - CAN 2.0 Frame
  *
- * Return: True - Frame inserted successfully
- *	   False - Frame was not inserted due to one of:
- *			1. TXT Buffer is not writable (it is in wrong state)
- *			2. Invalid TXT buffer index
- *			3. Invalid frame length
+ * Return:
+ * * True - Frame inserted successfully
+ * * False - Frame was not inserted due to one of:
+ *	1. TXT Buffer is not writable (it is in wrong state)
+ *	2. Invalid TXT buffer index
+ *	3. Invalid frame length
  */
 static bool ctucan_insert_frame(struct ctucan_priv *priv, const struct canfd_frame *cf, u8 buf,
 				bool isfdf)
-- 
2.47.2



