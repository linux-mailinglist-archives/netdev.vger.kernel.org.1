Return-Path: <netdev+bounces-160940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ED4A1C5EB
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 00:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6343A8BE1
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A2D20ADC3;
	Sat, 25 Jan 2025 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="Zp4qXN9e"
X-Original-To: netdev@vger.kernel.org
Received: from ci74p00im-qukt09081901.me.com (ci74p00im-qukt09081901.me.com [17.57.156.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387C20A5E7
	for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737849310; cv=none; b=HO3+/CzxU4jDL0R7GBXcjnFFRQnal7oWRgaUc/XjTCF/+oqWn8jp+ssHEUCsukvTi8O7uJP3AvjRSJNnDyfGkBbTIlDwdPnqXqOPMhKWS4guXQn5vVu/yGLD2I9Aj989aLGr7bIzzTV5OZniTQyC6xVcSWiqG5DwDoRvBG6u4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737849310; c=relaxed/simple;
	bh=bJuWLljkVyoePxGrUFio0TJXY/etfCOcNW50W+svjBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itN97zX34eOO87xy80YBDi5VrbTQ4agYrw1HMI8Ua1omJXuE8W5vLOG/Ll8bCKMrOP+XTXGcIkXrZI3D5ngU2Rz5wrM5+GwqbRsfhI4Lx+eCzX1XlQv8Ap3nyRJU/jJ6KWV2Y2jD+4VxHBehTITmqVpTWSAhY34o+88LCP73njk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=Zp4qXN9e; arc=none smtp.client-ip=17.57.156.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	bh=x2y+Y+MmmvlF9GZ+lzwqAiszYOs2lA7NdwGFv67/xjQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=Zp4qXN9eON5vMb9Qkv1DKYm3aVJTviSfambmJz+lv6QAuMzh9hQDTZXXL0pba/4t9
	 ppN3+sh2MGN7rqwSELDAGhkrvId8CFmYn3YOtMi5pRnEJATxlmrt5PIdi6Y41WcZBe
	 SRhOORTHLsmusAvV5bxTIa3vcHruQmnV6bBHtV0Q9Yi1cptSIy9ZFz2jOM5PI2RjI2
	 f5e9b0uDUmROt2p/DM6ngtr0Ml3hthh9aiFGIMs1Y4pXU6Yq7q/ddEGBoP9xeQ1UBF
	 /5gQ9OzcMXvsZJWZBoJMps320FHAH57Pxp7Qlg261Cw2Gkp40UsC4rwIdeKpTexjMG
	 sBz7LXwbuBiug==
Received: from fossa.se1.pen.gy (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09081901.me.com (Postfix) with ESMTPSA id 27E045AC01D8;
	Sat, 25 Jan 2025 23:55:03 +0000 (UTC)
From: Foster Snowhill <forst@pen.gy>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH net v5 7/7] usbnet: ipheth: document scope of NCM implementation
Date: Sun, 26 Jan 2025 00:54:09 +0100
Message-ID: <20250125235409.3106594-8-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250125235409.3106594-1-forst@pen.gy>
References: <20250125235409.3106594-1-forst@pen.gy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P8TGLKtoKamGVk0qdEMVbjqCf3hMmMGI
X-Proofpoint-GUID: P8TGLKtoKamGVk0qdEMVbjqCf3hMmMGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_11,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=930 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1030
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501250183

Clarify that the "NCM" implementation in `ipheth` is very limited, as
iOS devices aren't compatible with the CDC NCM specification in regular
tethering mode.

For a standards-compliant implementation, one shall turn to
the `cdc_ncm` module.

Cc: stable@vger.kernel.org # 6.5.x
Signed-off-by: Foster Snowhill <forst@pen.gy>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v5:
    No code changes. Added Cc to stable and Reviewed-by Jakub tags.
v4: https://lore.kernel.org/netdev/20250105010121.12546-8-forst@pen.gy/
    No changes.
v3: https://lore.kernel.org/netdev/20241123235432.821220-6-forst@pen.gy/
    This comment was part of the commit message for v2. With v3, given
    how the patches are split up, it makes more sense to add the comment
    directly in code.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: n/a
---
 drivers/net/usb/ipheth.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 5347cd7e295b..a19789b57190 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -218,6 +218,14 @@ static int ipheth_rcvbulk_callback_legacy(struct urb *urb)
 	return ipheth_consume_skb(buf, len, dev);
 }
 
+/* In "NCM mode", the iOS device encapsulates RX (phone->computer) traffic
+ * in NCM Transfer Blocks (similarly to CDC NCM). However, unlike reverse
+ * tethering (handled by the `cdc_ncm` driver), regular tethering is not
+ * compliant with the CDC NCM spec, as the device is missing the necessary
+ * descriptors, and TX (computer->phone) traffic is not encapsulated
+ * at all. Thus `ipheth` implements a very limited subset of the spec with
+ * the sole purpose of parsing RX URBs.
+ */
 static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 {
 	struct usb_cdc_ncm_nth16 *ncmh;
-- 
2.45.1


