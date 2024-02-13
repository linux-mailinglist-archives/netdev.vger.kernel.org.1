Return-Path: <netdev+bounces-71321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E1852F9C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE791F23D11
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F9524BD;
	Tue, 13 Feb 2024 11:34:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3237C39AC3
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824095; cv=none; b=m+pYoocw/vn2WS2jpAS52ecK2BYwGDXEWhbki/VniX8PdcPbSL9fEBFPwGwA5oCo63u+VItPk89ZYZzUC0gD43rXXcc5b7YxPblQztkv/LEtxmJu78rMrIyf04IPLW8kkELe56h03nU+vfL8IepkVrwgs5Kf7OUM+Mlj85n9wOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824095; c=relaxed/simple;
	bh=2rNLbwWvLJd2aboP9iJEjPS3sFtiUPS6h/KHyM+/rBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQxEGVeooyhBroxXvk4HyoLzow4/Aof7PUagrT5RizxjXhkAz4du4CLidn+nKl/UUFp5AJbiSUCCutnCp3ML5nvskeZ9otiGWjNz4RnlD5EAy52IcX9YzHJ5/X6ZC1FufKt1+9J8QG6TmBM0H5pyHbzf2XtkHE6lIi7Er6uqjzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3p-0001BX-B1
	for netdev@vger.kernel.org; Tue, 13 Feb 2024 12:34:49 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3k-000TXc-LR
	for netdev@vger.kernel.org; Tue, 13 Feb 2024 12:34:44 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5752828D6D9
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:34:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7A6E528D66E;
	Tue, 13 Feb 2024 11:34:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5585ae4e;
	Tue, 13 Feb 2024 11:34:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH net-next 19/23] can: change can network drivers maintainer
Date: Tue, 13 Feb 2024 12:25:22 +0100
Message-ID: <20240213113437.1884372-20-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113437.1884372-1-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Wolfgang has not been active on the linux-can mailing list other the
last two years, his last activity being on November 2021 [1].

In replacement, I would like to nominate myself (Vincent Mailhol) as
the second maintainer of the CAN drivers subtree.

Wolfgang is already listed in the CREDITS since [2], so despite this
removal, his legacy remains credited.

Thank you for all your contributions!

[1] https://lore.kernel.org/linux-can/?q=f%3AWolfgang+Grandegger

[2] commit 4261a2043f1b ("can: Update MAINTAINERS and CREDITS file")
Link: https://git.kernel.org/torvalds/c/4261a2043f1b

CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240205111743.920528-2-mailhol.vincent@wanadoo.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f3e554671c4..a5a17a463685 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4632,8 +4632,8 @@ S:	Maintained
 F:	net/sched/sch_cake.c
 
 CAN NETWORK DRIVERS
-M:	Wolfgang Grandegger <wg@grandegger.com>
 M:	Marc Kleine-Budde <mkl@pengutronix.de>
+M:	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 W:	https://github.com/linux-can
-- 
2.43.0



