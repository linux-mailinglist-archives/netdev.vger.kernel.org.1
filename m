Return-Path: <netdev+bounces-155222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F9BA01797
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A39B161241
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086AF1F61C;
	Sun,  5 Jan 2025 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="auO+Y1rO"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197D1E4A4
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038923; cv=none; b=A5GrZockl84F3hwe1HUifgxPD1G9etvOnT8H0DBKgDoExQt/blkZev2vhv2500alESGWIOZ66Kr0I0ffkGN9Qb8WqWayg9aUtx/Dw5rJoHTiNN0Btpdgx6sokI/PDi9bvGW8wgQi52tLNQkAiEa+u6tSGpAp+mgwBPw2c6diNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038923; c=relaxed/simple;
	bh=GS4W9TFShLkwq5Q22eLZbZcw7ENoNIixuDAsQuWQVss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fr54e1ju3TRMAxr7BFIVnC5uGhWK2slYV3nuxY2zO/pvexQLpfQeUDN/3eLxsLJ3j8mqhpucotdxkwQ0yIwojFzxNACL4wrXqkBy+LQ3Tg3cHbYTt8Vv3BEyIB4/kmHLVdenB2aIMXpb6PMKG1ve5+pCNp/8/3ERf9CAWYXXejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=auO+Y1rO; arc=none smtp.client-ip=17.57.155.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1736038920; bh=9PgIIZNI9c9i2ldCA3Cf/AEZv9ZPkrBocNBdDv800Ps=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=auO+Y1rOkJSk2AP+h+l9+qp5USGhUjaalfdv8/Rj3pLEAWZgQt5eacDACJez0TJyo
	 HyMYlnQAcq8Wk+VjI/vihHA7VKZzS+eT60BLNZUc04oYVDHdfXEEKaTpX8gAz37+X9
	 3sa1PN9uhcHlyhTx/gp35kDGj9alMUrJPzz3a8tJE6uXcnyvsbxfy1FlSTX2RrZ5A+
	 SJH86EP+ZmuDwsqUkTQ00RuPFubf0Mfge+KUlkQXu0o2v2OcXxa4f2saqoGbZNFSg3
	 3NtxoNTEaGAKNA6bk//7BLk3eCeTd6bJ5t5IssILcMo2owQ7RyZl0ROPeQ7EQIePak
	 tLJfnCah06M6A==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id 2B30C4E40199;
	Sun,  5 Jan 2025 01:01:56 +0000 (UTC)
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
Subject: [PATCH net v4 1/7] usbnet: ipheth: break up NCM header size computation
Date: Sun,  5 Jan 2025 02:01:15 +0100
Message-ID: <20250105010121.12546-2-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250105010121.12546-1-forst@pen.gy>
References: <20250105010121.12546-1-forst@pen.gy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tNpCVvBSkQCyAD-R_uiy5B2X-6oAW6vX
X-Proofpoint-ORIG-GUID: tNpCVvBSkQCyAD-R_uiy5B2X-6oAW6vX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=522 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501050007

Originally, the total NCM header size was computed as the sum of two
vaguely labelled constants. While accurate, it wasn't particularly clear
where they were coming from.

Use sizes of existing NCM structs where available. Define the total
NDP16 size based on the maximum amount of DPEs that can fit into the
iOS-specific fixed-size header.

This change does not fix any particular issue. Rather, it introduces
intermediate constants that will simplify subsequent commits.
It should also make it clearer for the reader where the constant values
come from.

Signed-off-by: Foster Snowhill <forst@pen.gy>
---
v4:
    No code changes. Remove "Fixes" from the commit message, and clarify
    the purpose/scope of the commit.
v3: https://lore.kernel.org/netdev/20241123235432.821220-1-forst@pen.gy/
    * NDP16 header size is computed from max DPE count constant,
    not the other way around.
    * Split out from a monolithic patch in v2.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
---
 drivers/net/usb/ipheth.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 46afb95ffabe..2084b940b4ea 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -61,7 +61,18 @@
 #define IPHETH_USBINTF_PROTO    1
 
 #define IPHETH_IP_ALIGN		2	/* padding at front of URB */
-#define IPHETH_NCM_HEADER_SIZE  (12 + 96) /* NCMH + NCM0 */
+/* On iOS devices, NCM headers in RX have a fixed size regardless of DPE count:
+ * - NTH16 (NCMH): 12 bytes, as per CDC NCM 1.0 spec
+ * - NDP16 (NCM0): 96 bytes, of which
+ *    - NDP16 fixed header: 8 bytes
+ *    - maximum of 22 DPEs (21 datagrams + trailer), 4 bytes each
+ */
+#define IPHETH_NDP16_MAX_DPE	22
+#define IPHETH_NDP16_HEADER_SIZE (sizeof(struct usb_cdc_ncm_ndp16) + \
+				  IPHETH_NDP16_MAX_DPE * \
+				  sizeof(struct usb_cdc_ncm_dpe16))
+#define IPHETH_NCM_HEADER_SIZE	(sizeof(struct usb_cdc_ncm_nth16) + \
+				 IPHETH_NDP16_HEADER_SIZE)
 #define IPHETH_TX_BUF_SIZE      ETH_FRAME_LEN
 #define IPHETH_RX_BUF_SIZE_LEGACY (IPHETH_IP_ALIGN + ETH_FRAME_LEN)
 #define IPHETH_RX_BUF_SIZE_NCM	65536
-- 
2.45.1


