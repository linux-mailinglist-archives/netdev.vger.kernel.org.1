Return-Path: <netdev+bounces-216504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C83B34291
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E325205802
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410AA2EF651;
	Mon, 25 Aug 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b="aSCLy44z"
X-Original-To: netdev@vger.kernel.org
Received: from natrix.sarinay.com (natrix.sarinay.com [159.100.251.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15B2EE60A;
	Mon, 25 Aug 2025 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.251.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130110; cv=none; b=FHiwdhWu0u128yUDM2QzqKJSZwk6pGuUU5O4hKV6JW5wPUws3ZIsHLcrsGtPuBYrJ8Ak0CsI34ar1OMKIjQmJcCxpVQyvYSlV9W2J7z2htpGBQ4VovOEuSrk5Yi85gymZDdThoiAGhMyyKX8KEoDqV56Feqw7Un79jRSOJleYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130110; c=relaxed/simple;
	bh=sH2Snquom2oIN37A/b+r7YUU98JLVeGli8KO5sObNHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QBcvA4dBv2sjQyhNyxRady6jhtoElisiRji5S5cTVbSizQG4pa7+jLKyGId3UCnwOlNuRo1T3Q3MpkZ0V1Yml1DDRM0m0vjQ16NtUfmUy9RT0yeMkJ7KTdNhZiKGAYEUoV9ALyTz2DKJQ8ZSxfPj+GlM1q/80zktRgdynqm++ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com; spf=pass smtp.mailfrom=sarinay.com; dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b=aSCLy44z; arc=none smtp.client-ip=159.100.251.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sarinay.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sarinay.com; s=2023;
	t=1756129632; bh=sH2Snquom2oIN37A/b+r7YUU98JLVeGli8KO5sObNHE=;
	h=From:To:Cc:Subject:Date;
	b=aSCLy44zqka7FudE5gQGZJwUX4EpX/HKOL3RtWC9AxcJGPh0h0O2h9kLRr9RgJtzu
	 YehOeuc54pk8ywhL3yFZKQXGecS84wpBgxskO3dzVFf95PF2+JZMHMd8PkxoDWQemM
	 njfNF4x6+GSvscdRjqCoDc7/fV2jLzgpdl87eHGaqNd9NfdGGr7wi+sB9/pj/Yf0yj
	 RZtqQMoZB5+z1OgWv9pKVALUOkpGe9xBoWUSep0cj4q8ra6fp8kp7Sg60BpdfSPuin
	 R7Xmt/LAaPQvASEPdMzs7YCNH+mqPZ3ode5SaxPc5onApACqlb0tp76423+e1eaNQO
	 /fKGcQ0N2d61A==
From: =?UTF-8?q?Juraj=20=C5=A0arinay?= <juraj@sarinay.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Juraj=20=C5=A0arinay?= <juraj@sarinay.com>,
	krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next] net: nfc: nci: Turn data timeout into a module parameter and increase the default
Date: Mon, 25 Aug 2025 15:46:43 +0200
Message-ID: <20250825134644.135448-1-juraj@sarinay.com>
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
 include/net/nfc/nci_core.h | 4 +++-
 net/nfc/nci/core.c         | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
index fc921cd2cdff..089a8757dbbb 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -31,6 +31,10 @@
 #include <net/nfc/nci_core.h>
 #include <linux/nfc.h>
 
+unsigned int nci_data_timeout = 3000;
+module_param_named(data_timeout, nci_data_timeout, uint, 0644);
+MODULE_PARM_DESC(data_timeout, "Round-trip communication timeout in milliseconds");
+
 struct core_conn_create_data {
 	int length;
 	struct nci_core_conn_create_cmd *cmd;
-- 
2.47.2


