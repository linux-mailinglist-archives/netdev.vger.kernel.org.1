Return-Path: <netdev+bounces-191101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F82DABA10B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494F1189E94C
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588451BEF7E;
	Fri, 16 May 2025 16:51:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA21BE49;
	Fri, 16 May 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414312; cv=none; b=XdyENGlacsYQJ8B3EfM25ozuP72OcKUnL4b1SQeneP4BRdLoGYD7Hu8js8CG71O4wPM6w6OVIxNGAmGpxdyiNvQb6iPm4qLYmWn4/4Wxw8Rsmnws/eEBnMmXwQptSc9ga4U92Vb3Of1x/afRTpSQ5DGkjlVIaK9RRjxgNJvBe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414312; c=relaxed/simple;
	bh=Tt2r9xz8sdUiv4K9lYnzrHLicK9+65q1WYWpfLsk8d4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMvePdWmZECnq3uls/vdfkdaUUUcuCGPP3GI0kAGyYUni6GQjysEJRf8Agg+ym09oDsvQyYfW8FdjcJ/w3eTZXYj3WeuttNLIcKZ+6IY7N/fI0dot+rdJn1yOtq/ERm30ZSyw4MfsthclT6/h3tM/F8kxiAeh5RBh7dEECk4Ecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uFyHS-00021S-7A; Fri, 16 May 2025 16:51:30 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Trager <lee@trager.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Sanman Pradhan <sanmanpradhan@meta.com>,
	Su Hui <suhui@nfschina.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] eth: fbnic: Replace kzalloc/fbnic_fw_init_cmpl with fbnic_fw_alloc_cmpl
Date: Fri, 16 May 2025 09:46:41 -0700
Message-ID: <20250516164804.741348-1-lee@trager.us>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the pattern of calling and validating kzalloc then
fbnic_fw_init_cmpl with a single function, fbnic_fw_alloc_cmpl.

Signed-off-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c |  6 ++----
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c      | 17 ++++++++++++-----
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h      |  3 +--
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |  5 +----
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index 71d9461a0d1b..4c4938eedd7b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -166,11 +166,10 @@ fbnic_flash_start(struct fbnic_dev *fbd, struct pldmfw_component *component)
 	struct fbnic_fw_completion *cmpl;
 	int err;

-	cmpl = kzalloc(sizeof(*cmpl), GFP_KERNEL);
+	cmpl = fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_FW_START_UPGRADE_REQ);
 	if (!cmpl)
 		return -ENOMEM;

-	fbnic_fw_init_cmpl(cmpl, FBNIC_TLV_MSG_ID_FW_START_UPGRADE_REQ);
 	err = fbnic_fw_xmit_fw_start_upgrade(fbd, cmpl,
 					     component->identifier,
 					     component->component_size);
@@ -237,11 +236,10 @@ fbnic_flash_component(struct pldmfw *context,
 	 * Setup completions for write before issuing the start message so
 	 * the driver can catch both messages.
 	 */
-	cmpl = kzalloc(sizeof(*cmpl), GFP_KERNEL);
+	cmpl = fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ);
 	if (!cmpl)
 		return -ENOMEM;

-	fbnic_fw_init_cmpl(cmpl, FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ);
 	err = fbnic_mbx_set_cmpl(fbd, cmpl);
 	if (err)
 		goto cmpl_free;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 6a803a59dc25..e2368075ab8c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -1232,12 +1232,19 @@ void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
 				 fw_version, str_sz);
 }

-void fbnic_fw_init_cmpl(struct fbnic_fw_completion *fw_cmpl,
-			u32 msg_type)
+struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type)
 {
-	fw_cmpl->msg_type = msg_type;
-	init_completion(&fw_cmpl->done);
-	kref_init(&fw_cmpl->ref_count);
+	struct fbnic_fw_completion *cmpl;
+
+	cmpl = kzalloc(sizeof(*cmpl), GFP_KERNEL);
+	if (!cmpl)
+		return NULL;
+
+	cmpl->msg_type = msg_type;
+	init_completion(&cmpl->done);
+	kref_init(&cmpl->ref_count);
+
+	return cmpl;
 }

 void fbnic_fw_clear_cmpl(struct fbnic_dev *fbd,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 6baac10fd688..08bc4b918de7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -80,8 +80,7 @@ int fbnic_fw_xmit_fw_write_chunk(struct fbnic_dev *fbd,
 				 int cancel_error);
 int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 				 struct fbnic_fw_completion *cmpl_data);
-void fbnic_fw_init_cmpl(struct fbnic_fw_completion *cmpl_data,
-			u32 msg_type);
+struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type);
 void fbnic_fw_clear_cmpl(struct fbnic_dev *fbd,
 			 struct fbnic_fw_completion *cmpl_data);
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 4ba6f8d10775..10e108c1fcd0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -687,13 +687,10 @@ static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,
 	int err = 0, retries = 5;
 	s32 *sensor;

-	fw_cmpl = kzalloc(sizeof(*fw_cmpl), GFP_KERNEL);
+	fw_cmpl = fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_TSENE_READ_RESP);
 	if (!fw_cmpl)
 		return -ENOMEM;

-	/* Initialize completion and queue it for FW to process */
-	fbnic_fw_init_cmpl(fw_cmpl, FBNIC_TLV_MSG_ID_TSENE_READ_RESP);
-
 	switch (id) {
 	case FBNIC_SENSOR_TEMP:
 		sensor = &fw_cmpl->u.tsene.millidegrees;
--
2.47.1

