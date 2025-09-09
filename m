Return-Path: <netdev+bounces-221244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33121B4FE25
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD52441D9B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B44D3431FF;
	Tue,  9 Sep 2025 13:48:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09221FF24
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425728; cv=none; b=M43CNq8rAvxm7BwNRYxIF7ckX4bp2kYxetZXBrGv8ogRCI5Ia6D1ih4iy2QpjFX6xJWktjVcj/e7FjAzgcCu5LR4aTmbdT7SoHJeigAvxqjmqFyN6uKNkAwY9IWJkJSyOw48hjpJUSmOkbLMfxBYOFxF/kAZDPg3NmBm6pteXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425728; c=relaxed/simple;
	bh=9ThQkVd2Zi531Rvyvscgu2Z1Af6VCj646K62Dybge8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1xEff3jWVUVa3m3oc2F8fvSSxC7btpy1Bith8tyUxUpiXeF00vpTDvAnKo1lklxtgk0VKXDo7X/5HQVo63EIc05vwugpz0VkeOLsAo6cJKebE90NyFZnsWklAjkTt2lt2Jp54dp7dd8pabVnz5Uq1JPBVLSpgUnIlx+wUUfwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvyiD-0002km-DX
	for netdev@vger.kernel.org; Tue, 09 Sep 2025 15:48:45 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvyiC-000Qm8-2P
	for netdev@vger.kernel.org;
	Tue, 09 Sep 2025 15:48:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 73C6546A052
	for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 13:48:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 522E646A024;
	Tue, 09 Sep 2025 13:48:42 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 02955764;
	Tue, 9 Sep 2025 13:48:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Alex Tran <alex.t.tran@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/7] docs: networking: can: change bcm_msg_head frames member to support flexible array
Date: Tue,  9 Sep 2025 15:34:54 +0200
Message-ID: <20250909134840.783785-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909134840.783785-1-mkl@pengutronix.de>
References: <20250909134840.783785-1-mkl@pengutronix.de>
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

From: Alex Tran <alex.t.tran@gmail.com>

The documentation of the 'bcm_msg_head' struct does not match how
it is defined in 'bcm.h'. Changed the frames member to a flexible array,
matching the definition in the header file.

See commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
flexible-array members")

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20250904031709.1426895-1-alex.t.tran@gmail.com
Fixes: 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with flexible-array members")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217783
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/can.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index bc1b585355f7..7650c4b5be5f 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -742,7 +742,7 @@ The broadcast manager sends responses to user space in the same form:
             struct timeval ival1, ival2;    /* count and subsequent interval */
             canid_t can_id;                 /* unique can_id for task */
             __u32 nframes;                  /* number of can_frames following */
-            struct can_frame frames[0];
+            struct can_frame frames[];
     };
 
 The aligned payload 'frames' uses the same basic CAN frame structure defined

base-commit: d3b28612bc5500133260aaf36794a0a0c287d61b
-- 
2.51.0



