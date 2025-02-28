Return-Path: <netdev+bounces-170832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B23A4A29C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 20:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9703B298D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5B31F8740;
	Fri, 28 Feb 2025 19:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA71C3BE6;
	Fri, 28 Feb 2025 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770486; cv=none; b=AuFrdr9QjTZf6QGiGFQN2lsuo4W4k70idK5gFlG30GGS2cC6HbH7o3ogJkXhgAkRl+qxAGfvVZnYOHyvwlxCRn02xUnf78lEneOhcCYNO3PRz/1wH12JX08sfzRpUy4YTv7ZJbd5KI7rVXKak3dNd2eMvqBvbJkukWXHLvvxA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770486; c=relaxed/simple;
	bh=OKS85ithCySh7YJ5Z9u2mKRH/lYnOC6wb/Y82GLKHUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5Id68X7Rn0BHDKk+bmRFgoX2zh7wT6V7c9wAvHvM628ydbVcXyaPcvCAZqr5e+o1qFz9g2VV6A1ZjIWz/hMs9uCp/WfBrN//yUqj5E6Piw0iOJMIlM1jUtMUJBkUENepLbIHq8rcrzwbQV1ZbFkk5YQ0C+d+X+MyZ4WS5wytdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1to5vB-0001Pr-S4; Fri, 28 Feb 2025 19:21:18 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Trager <lee@trager.us>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Su Hui <suhui@nfschina.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] eth: fbnic: Prepend TSENE FW fields with FBNIC_FW
Date: Fri, 28 Feb 2025 11:15:26 -0800
Message-ID: <20250228191935.3953712-2-lee@trager.us>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250228191935.3953712-1-lee@trager.us>
References: <20250228191935.3953712-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All other firmware fields are prepended with FBNIC_FW. Update TSENE fields
to follow the same format.

Signed-off-by: Lee Trager <lee@trager.us>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 16 ++++++++--------
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index bbc7c1c0c37e..76a225f01718 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -743,9 +743,9 @@ int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 }

 static const struct fbnic_tlv_index fbnic_tsene_read_resp_index[] = {
-	FBNIC_TLV_ATTR_S32(FBNIC_TSENE_THERM),
-	FBNIC_TLV_ATTR_S32(FBNIC_TSENE_VOLT),
-	FBNIC_TLV_ATTR_S32(FBNIC_TSENE_ERROR),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_TSENE_THERM),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_TSENE_VOLT),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_TSENE_ERROR),
 	FBNIC_TLV_ATTR_LAST
 };

@@ -762,21 +762,21 @@ static int fbnic_fw_parse_tsene_read_resp(void *opaque,
 	if (!cmpl_data)
 		return -EINVAL;

-	if (results[FBNIC_TSENE_ERROR]) {
-		err = fbnic_tlv_attr_get_unsigned(results[FBNIC_TSENE_ERROR]);
+	if (results[FBNIC_FW_TSENE_ERROR]) {
+		err = fbnic_tlv_attr_get_unsigned(results[FBNIC_FW_TSENE_ERROR]);
 		if (err)
 			goto exit_complete;
 	}

-	if (!results[FBNIC_TSENE_THERM] || !results[FBNIC_TSENE_VOLT]) {
+	if (!results[FBNIC_FW_TSENE_THERM] || !results[FBNIC_FW_TSENE_VOLT]) {
 		err = -EINVAL;
 		goto exit_complete;
 	}

 	cmpl_data->u.tsene.millidegrees =
-		fbnic_tlv_attr_get_signed(results[FBNIC_TSENE_THERM]);
+		fbnic_tlv_attr_get_signed(results[FBNIC_FW_TSENE_THERM]);
 	cmpl_data->u.tsene.millivolts =
-		fbnic_tlv_attr_get_signed(results[FBNIC_TSENE_VOLT]);
+		fbnic_tlv_attr_get_signed(results[FBNIC_FW_TSENE_VOLT]);

 exit_complete:
 	cmpl_data->result = err;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index fe68333d51b1..a3618e7826c2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -139,10 +139,10 @@ enum {
 };

 enum {
-	FBNIC_TSENE_THERM			= 0x0,
-	FBNIC_TSENE_VOLT			= 0x1,
-	FBNIC_TSENE_ERROR			= 0x2,
-	FBNIC_TSENE_MSG_MAX
+	FBNIC_FW_TSENE_THERM			= 0x0,
+	FBNIC_FW_TSENE_VOLT			= 0x1,
+	FBNIC_FW_TSENE_ERROR			= 0x2,
+	FBNIC_FW_TSENE_MSG_MAX
 };

 enum {
--
2.43.5

