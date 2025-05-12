Return-Path: <netdev+bounces-189873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F869AB4444
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE10E189E2D2
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442E296FB2;
	Mon, 12 May 2025 19:05:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758B229B0E;
	Mon, 12 May 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076738; cv=none; b=ZFv+GC957pY8RJ9q260K7BTZAi33fNWOwBUnpEe40MxME7I2IwMZeANxAa4vpentftGO1GCv2J0bUFV0tO91QlkeAO08xV4KV7BgSSJV2uUSK8ZYw8wupf6OOHQlwUg5Ai+gjRxGpNMwZAbbICSIomFIY2BKrasA1ppfvBP5iLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076738; c=relaxed/simple;
	bh=Yja4TOHIrtdjTPCKRGBi4xZHwODXhoMhqg1PZ6Id9y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I32F7mSpgcmbFEZbOmHRaNA59xZ6SgPgFHBFWH/IwsQK1Swz3/zSR2GWLYuT54JFwjOQaiNjXoImQQI5IFkOVa+arT99mhoFJJl/qRAoaELg9e36mVDcfTLVkksc78eWu6t04ptrPGt1p84VuxxNIE5w6ccGJ6v/ra5aRKZ9dok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from [163.114.132.130] (helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uEYSv-00071q-FO; Mon, 12 May 2025 19:05:29 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>,
	Lee Trager <lee@trager.us>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/5] eth: fbnic: Accept minimum anti-rollback version from firmware
Date: Mon, 12 May 2025 11:53:58 -0700
Message-ID: <20250512190109.2475614-3-lee@trager.us>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512190109.2475614-1-lee@trager.us>
References: <20250512190109.2475614-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic supports applying firmware which may not be rolled back. This is
implemented in firmware however it is useful for the driver to know the
minimum supported firmware version. This will enable the driver validate
new firmware before it is sent to the NIC. If it is too old the driver can
provide a clear message that the version is too old.

Signed-off-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 4 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 3d9636a6c968..e4f72fb730a6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -464,6 +464,7 @@ static const struct fbnic_tlv_index fbnic_fw_cap_resp_index[] = {
 	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_UEFI_VERSION),
 	FBNIC_TLV_ATTR_STRING(FBNIC_FW_CAP_RESP_UEFI_COMMIT_STR,
 			      FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_ANTI_ROLLBACK_VERSION),
 	FBNIC_TLV_ATTR_LAST
 };

@@ -586,6 +587,9 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 	if (results[FBNIC_FW_CAP_RESP_BMC_ALL_MULTI] || !bmc_present)
 		fbd->fw_cap.all_multi = all_multi;

+	fbd->fw_cap.anti_rollback_version =
+		fta_get_uint(results, FBNIC_FW_CAP_RESP_ANTI_ROLLBACK_VERSION);
+
 	return 0;
 }

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index a3618e7826c2..692dfd8746e7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -42,6 +42,7 @@ struct fbnic_fw_cap {
 	u8	all_multi	: 1;
 	u8	link_speed;
 	u8	link_fec;
+	u32	anti_rollback_version;
 };

 struct fbnic_fw_completion {
@@ -122,6 +123,7 @@ enum {
 	FBNIC_FW_CAP_RESP_STORED_CMRT_COMMIT_STR	= 0x10,
 	FBNIC_FW_CAP_RESP_UEFI_VERSION			= 0x11,
 	FBNIC_FW_CAP_RESP_UEFI_COMMIT_STR		= 0x12,
+	FBNIC_FW_CAP_RESP_ANTI_ROLLBACK_VERSION		= 0x15,
 	FBNIC_FW_CAP_RESP_MSG_MAX
 };

--
2.47.1

