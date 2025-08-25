Return-Path: <netdev+bounces-216713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18BB34FC9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D046948660B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5556244667;
	Mon, 25 Aug 2025 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b="LgYfYa0q"
X-Original-To: netdev@vger.kernel.org
Received: from natrix.sarinay.com (natrix.sarinay.com [159.100.251.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87DD1A314E;
	Mon, 25 Aug 2025 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.251.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756165721; cv=none; b=unVZyodUJT+M2R8ojZXYoW3EAOIRnEgrqW3Gi0n6MFt1H8kjvG/UhpDCtuPN/CEhervdnCoFvUFGquqZYuMZfqCScAHN3ptJyWZmZSZwdcjkqLYM1xSQPuSW+bg7r67vMmP0lMH4jn4AK/EIwstU4U+HE6ZkRFWA0JCT7vZjPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756165721; c=relaxed/simple;
	bh=cqmQ5Fj/MEGS7SskcrLs3VuOJjoCYvmvMNy3btPhxU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QQOsAZiJRt0mL05caoS1tWPIYwr5vV0hnZaxhPPd5DkXj8tZHIJGVB/eg4HL8U3V3Fv5QuPA8k/TGg1SeQp4Ikol+CNTN3Pjf3CbJs+Nfe/y87/yr1aWUf3EaB4Zltio9QfP9lv+glN4t3uWtXxxNB1hOfsMJQmr2dgYk2gZqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com; spf=pass smtp.mailfrom=sarinay.com; dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b=LgYfYa0q; arc=none smtp.client-ip=159.100.251.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sarinay.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sarinay.com; s=2023;
	t=1756165717; bh=cqmQ5Fj/MEGS7SskcrLs3VuOJjoCYvmvMNy3btPhxU8=;
	h=From:To:Cc:Subject:Date;
	b=LgYfYa0qRMw5G7cjT8ny0kFVwfjXcmznlLC0rziELgYck9gtJSsG3VqT8aQ5/CU8t
	 tee6REAEB+9Nv0ZG/Epn8014eoo0HpIGSDANKFO5z1WV/UxoWHhUGPcxOUR2+eS4jU
	 PftiUQn0+yKUPH+WSx2lVZK0h/sbrz9cpkh0OtuaG5HkTu2+oOWKDFh4N+RP62/rYI
	 y4Hq7lNN2xbsJBHIFK+WjjL6pbGr1VENNY1yar3TtXovI86TdtXD2xCdrGTLZeG7kj
	 abCHXPiQ/epaSoBxCuD4Q9ume/CbpfL0D45SAtkMf7j5Z5ECZufocjKF/qHnoP6HjR
	 dUrK5LiY116rg==
From: =?UTF-8?q?Juraj=20=C5=A0arinay?= <juraj@sarinay.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Juraj=20=C5=A0arinay?= <juraj@sarinay.com>,
	krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mingo@kernel.org,
	horms@kernel.org,
	tglx@linutronix.de
Subject: [PATCH net-next v2] net: nfc: nci: Turn data timeout into a module parameter and increase the default
Date: Tue, 26 Aug 2025 01:43:49 +0200
Message-ID: <20250825234354.855755-1-juraj@sarinay.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An exchange with a NFC target must complete within NCI_DATA_TIMEOUT.
A delay of 700 ms is not sufficient for cryptographic operations on smart
cards. CardOS 6.0 may need up to 1.3 seconds to perform 256-bit ECDH
or 3072-bit RSA. To prevent brute-force attacks, passports and similar
documents introduce even longer delays into access control protocols
(BAC/PACE).

The timeout should be higher, but not too much. The expiration allows
us to detect that a NFC target has disappeared.

Expose data_timeout as a parameter of nci.ko. Keep the value in uint
nci_data_timeout, set the default to 3 seconds. Point NCI_DATA_TIMEOUT
to the new variable.

Signed-off-by: Juraj Šarinay <juraj@sarinay.com>
---
v2:
  - export nci_data_timeout to survive make allmodconfig
v1: https://lore.kernel.org/netdev/20250825134644.135448-1-juraj@sarinay.com/

 include/net/nfc/nci_core.h | 4 +++-
 net/nfc/nci/core.c         | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index e180bdf2f82b..da62f0da1fb2 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -52,7 +52,9 @@ enum nci_state {
 #define NCI_RF_DISC_SELECT_TIMEOUT		5000
 #define NCI_RF_DEACTIVATE_TIMEOUT		30000
 #define NCI_CMD_TIMEOUT				5000
-#define NCI_DATA_TIMEOUT			700
+
+extern unsigned int nci_data_timeout;
+#define NCI_DATA_TIMEOUT			nci_data_timeout
 
 struct nci_dev;
 
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index fc921cd2cdff..29fac0dd6c77 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -31,6 +31,11 @@
 #include <net/nfc/nci_core.h>
 #include <linux/nfc.h>
 
+unsigned int nci_data_timeout = 3000;
+module_param_named(data_timeout, nci_data_timeout, uint, 0644);
+MODULE_PARM_DESC(data_timeout, "Round-trip communication timeout in milliseconds");
+EXPORT_SYMBOL_GPL(nci_data_timeout);
+
 struct core_conn_create_data {
 	int length;
 	struct nci_core_conn_create_cmd *cmd;
-- 
2.47.2


