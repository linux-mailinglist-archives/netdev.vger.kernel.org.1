Return-Path: <netdev+bounces-160938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8298A1C5E7
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 00:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDB9167E43
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 23:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BCC20A5CD;
	Sat, 25 Jan 2025 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="kZDi1mNZ"
X-Original-To: netdev@vger.kernel.org
Received: from ci74p00im-qukt09081901.me.com (ci74p00im-qukt09081901.me.com [17.57.156.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010220A5F3
	for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737849301; cv=none; b=Y5iZX+uqAkh7yyOSeQ/AiAjs3Yz4axrz3AgIr1X8ToMMcFpyQ2oHHrlCHKXnZ/VFnSCpPIiRQGzm/s/XwXtIzoS/IzLOfBS40Q0yE/r6e4IVLrNKXsUT2xvaS9jvmTPWWctTrEBL5j17KoOOj8fsunOxWJjklZl296d1On+TqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737849301; c=relaxed/simple;
	bh=OmUwIl748E1NiRp4NDBMx2YVi2CKtxjAJuOW59bABlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibmr1w+yicebbVoOHg2Yhgm3VfmOtF2sj+OewXSKNmDTnLZ7mn5r9EIIUjhLbZRbxpMLBqhiwSO6OISTv6cHVRkU/H79vw2/kCCv/w0It4QGknRW52NodIsSE5XIS7kzdgP8b4VK9zS8BpZ1wFovJOqNHEOPToIIvgEuEM2BhSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=kZDi1mNZ; arc=none smtp.client-ip=17.57.156.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	bh=PD5FeGTwLG0+0QPNJJgudxv+cer6F45p803rYPvQLjI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=kZDi1mNZKU9eyRgcDoG7trbtkHEuOvriEQlPHN60o80o4nZ8/MywYMBX0XYJZhGmH
	 W0LMDamEp0LFoZmFxnvUHCA4y9DtfXK/NioptDKhDnQNDFQgY/ql/Gvny38a4Gd69i
	 hYY55eLADbgOUZCesmpIwAbDq7DDoxHqeK2hoSr/kKBVI5ykjQIwxA8KXriD4XF242
	 D/IeAEzxLuPJNPuvs4f8moNM5fom4n8pfFHqPO2RzR+86wcKb0RFMYJEpnV28zNUZ6
	 G5b/eNv/02i/N5KMtn30Do5JAOfYSjUFCSHZsWU2Wj8N4Aeol8ctjPRsXpslktPt5L
	 q3TGXEa9L8oXw==
Received: from fossa.se1.pen.gy (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09081901.me.com (Postfix) with ESMTPSA id 3E5855AC0129;
	Sat, 25 Jan 2025 23:54:55 +0000 (UTC)
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
Subject: [PATCH net v5 5/7] usbnet: ipheth: break up NCM header size computation
Date: Sun, 26 Jan 2025 00:54:07 +0100
Message-ID: <20250125235409.3106594-6-forst@pen.gy>
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
X-Proofpoint-ORIG-GUID: NNBvOkX-DEhe-bROStvtWOMObw_B8bA3
X-Proofpoint-GUID: NNBvOkX-DEhe-bROStvtWOMObw_B8bA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_11,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=446 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1030
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501250183

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

Cc: stable@vger.kernel.org # 6.5.x
Signed-off-by: Foster Snowhill <forst@pen.gy>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v5:
    No code changes. Moved patch closer in series to subsequent patch
    "usbnet: ipheth: fix DPE OoB read", as that is when one of the
    introduced preprocessor constants is first used. Added Cc to stable
    and Reviewed-by Jakub tags.
v4: https://lore.kernel.org/netdev/20250105010121.12546-2-forst@pen.gy/
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
index 069979e2bb6e..03249208612e 100644
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


