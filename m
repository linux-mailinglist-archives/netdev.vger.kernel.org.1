Return-Path: <netdev+bounces-203497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF243AF6295
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB65E4A843C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50252BE655;
	Wed,  2 Jul 2025 19:26:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BFE1A3168;
	Wed,  2 Jul 2025 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484377; cv=none; b=MjpGhBLja83ABo7Qrbt0AelQax+OK8OD+ik0AE7FaGusniywjPlX9eEd60jwfs0k9E1vqBoXQ+A/Y1XcCXqhcuGGIi3r4lnkui22eD2p6rhG7bb41xls0kf0yAd7/gv6rPma7VZ7x/Ao8j8i6jeEh55EmvBELdBE3yyx++7cRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484377; c=relaxed/simple;
	bh=1FprbJCOjhBvFKmkocfnqc/yP2VIf6fib2j6Q3hUr84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWdWkKv5ZmfPqNO4eBYpjHbRSU6Ei3t5Vj3NMnOpVnzrqpm4vgIyA6RMxrzihU7e+/ro3YOwl9qJj/Fqb/M4HEUoRmtrqHYQ68FUhVao7YdxQ72BPGlwZ9pm1pgY9B80cfmq35c0P6Ufz0fmpjYzz/oeC2CD20Gb3/Gcc9YoEPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uX35s-000810-Ab; Wed, 02 Jul 2025 19:26:08 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Su Hui <suhui@nfschina.com>,
	Simon Horman <horms@kernel.org>,
	Lee Trager <lee@trager.us>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 2/6] eth: fbnic: Use FIELD_PREP to generate minimum firmware version
Date: Wed,  2 Jul 2025 12:12:08 -0700
Message-ID: <20250702192207.697368-3-lee@trager.us>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702192207.697368-1-lee@trager.us>
References: <20250702192207.697368-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new macro based on FIELD_PREP to generate easily readable minimum
firmware version ints. This macro will prevent the mistake from the
previous patch from happening again.

Signed-off-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h | 13 +++++++------
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  | 13 ++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index e2b251eddbb3..06b9c49e51a2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -12,13 +12,14 @@
 #define DESC_BIT(nr)		BIT_ULL(nr)
 #define DESC_GENMASK(h, l)	GENMASK_ULL(h, l)

+#define FW_VER_CODE(_major, _minor, _patch, _build) (		      \
+		FIELD_PREP(FBNIC_FW_CAP_RESP_VERSION_MAJOR, _major) | \
+		FIELD_PREP(FBNIC_FW_CAP_RESP_VERSION_MINOR, _minor) | \
+		FIELD_PREP(FBNIC_FW_CAP_RESP_VERSION_PATCH, _patch) | \
+		FIELD_PREP(FBNIC_FW_CAP_RESP_VERSION_BUILD, _build))
+
 /* Defines the minimum firmware version required by the driver */
-#define MIN_FW_MAJOR_VERSION    0
-#define MIN_FW_MINOR_VERSION    10
-#define MIN_FW_PATCH_VERSION    6
-#define MIN_FW_VERSION_CODE     (MIN_FW_MAJOR_VERSION * (1u << 24) + \
-				 MIN_FW_MINOR_VERSION * (1u << 16) + \
-				 MIN_FW_PATCH_VERSION * (1u << 8))
+#define MIN_FW_VER_CODE				FW_VER_CODE(0, 10, 6, 0)

 #define PCI_DEVICE_ID_META_FBNIC_ASIC		0x0013

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index cdc1e2938a64..ac7804a8a22c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -573,16 +573,15 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 	if (!fbd->fw_cap.running.mgmt.version)
 		return -EINVAL;

-	if (fbd->fw_cap.running.mgmt.version < MIN_FW_VERSION_CODE) {
+	if (fbd->fw_cap.running.mgmt.version < MIN_FW_VER_CODE) {
+		char required_ver[FBNIC_FW_VER_MAX_SIZE];
 		char running_ver[FBNIC_FW_VER_MAX_SIZE];

 		fbnic_mk_fw_ver_str(fbd->fw_cap.running.mgmt.version,
 				    running_ver);
-		dev_err(fbd->dev, "Device firmware version(%s) is older than minimum required version(%02d.%02d.%02d)\n",
-			running_ver,
-			MIN_FW_MAJOR_VERSION,
-			MIN_FW_MINOR_VERSION,
-			MIN_FW_PATCH_VERSION);
+		fbnic_mk_fw_ver_str(MIN_FW_VER_CODE, required_ver);
+		dev_err(fbd->dev, "Device firmware version(%s) is older than minimum required version(%s)\n",
+			running_ver, required_ver);
 		/* Disable TX mailbox to prevent card use until firmware is
 		 * updated.
 		 */
@@ -1167,7 +1166,7 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 	 * to indicate we entered the polling state waiting for a response
 	 */
 	for (fbd->fw_cap.running.mgmt.version = 1;
-	     fbd->fw_cap.running.mgmt.version < MIN_FW_VERSION_CODE;) {
+	     fbd->fw_cap.running.mgmt.version < MIN_FW_VER_CODE;) {
 		if (!tx_mbx->ready)
 			err = -ENODEV;
 		if (err)
--
2.47.1

