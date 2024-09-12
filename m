Return-Path: <netdev+bounces-127958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D393977383
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA98284BDC
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4D31B9853;
	Thu, 12 Sep 2024 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="Es30tNfZ"
X-Original-To: netdev@vger.kernel.org
Received: from ci74p00im-qukt09081902.me.com (ci74p00im-qukt09081902.me.com [17.57.156.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9A13D89D
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175944; cv=none; b=tyoKrdnw46Wo1PG2f2i/KkYSGWKY8abHiHquHDqoeOaA4YD/Qe77R++HBvn++7FbYTE3LozEY4XT2t9rYoG5P4ejJ/T7GT07JrahxC8td4FiGsRAtKYTIQynccGZ12ONR/PHHTC8WdVDcLi5fYwWXdN4ZJWRt2TohrQPrCasZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175944; c=relaxed/simple;
	bh=89xDsc8rPiqQdYQrasQa/ym5eXT7n4JZWt8JY+1zNKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzIhBX8/+6uMsCOwRdE/FMuCDY4lOZ1c76DwCQnxaBzW3TEjHADE3i2hyGcyoNVsfFWfUopYcm1eYuAr+ANF0GwjDc4MEEd+6w1rmOblAOC/u+XmLxW1c5IGcFz4LwMcg948Y2xhzdHPuiML8t60D+RWdToeCVvVpvqO6tT7ChY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=Es30tNfZ; arc=none smtp.client-ip=17.57.156.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1726175941; bh=vovF47F5HplS3Hx4Wtm0+Hlb8XzHo4WlYQMicnj+0uw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Es30tNfZDCL8vQkj0rMAlE0J/5Dy2y1J5tV//Kdms1rilFqJ4viDAXbOQgZaJiH6N
	 JjdtGK7XeBY8ffleDq3MCxHQcsgq9t99XciRghGCNJ+iWQZqnJ3p0D7JfB0XjjUBZC
	 UoYY/du9UI1hd8aHQejg/9pLd0OwP3bh92A0dI89Yrb6aYy5/b59icuCONgw0LC4XU
	 jWinksd7zngbcsd+I+VvtijEHCip5vwtTS1XAorD7ysXjKbZCtSZTzpgNVFPW8+iK4
	 yuSPoc4pqh3OmFLM9y4ViyIuQE9IvgNSUd5UIN3GVGK7D/+Hy6gMFiWj6UVDeDh9iP
	 /EJDNbUcmI0BA==
Received: from fossa.iopsys.eu (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09081902.me.com (Postfix) with ESMTPSA id B426E290031F;
	Thu, 12 Sep 2024 21:18:58 +0000 (UTC)
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
Subject: [PATCH net-next v2] usbnet: ipheth: prevent OoB reads of NDP16
Date: Thu, 12 Sep 2024 23:18:17 +0200
Message-ID: <20240912211817.1707844-1-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9zy841-CfjNvdSs-yK8ol7y2yKXUlhJA
X-Proofpoint-ORIG-GUID: 9zy841-CfjNvdSs-yK8ol7y2yKXUlhJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_08,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=917 bulkscore=0 clxscore=1030 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409120155

In "NCM mode", the iOS device encapsulates RX (phone->computer) traffic
in NCM Transfer Blocks (similarly to CDC NCM). However, unlike reverse
tethering (handled by the `cdc_ncm` driver), regular tethering is not
compliant with the CDC NCM spec, as the device is missing the necessary
descriptors, and TX (computer->phone) traffic is not encapsulated
at all. Thus `ipheth` implements a very limited subset of the spec with
the sole purpose of parsing RX URBs.

In the first iteration of the NCM mode implementation, there were a few
potential out of bounds reads when processing malformed URBs received
from a connected device:

* Only the start of NDP16 (wNdpIndex) was checked to fit in the URB
  buffer.
* Datagram length check as part of DPEs could overflow.
* DPEs could be read past the end of NDP16 and even end of URB buffer
  if a trailer DPE wasn't encountered.

The above is not expected to happen in normal device operation.

To address the above issues for iOS devices in NCM mode, rely on
and check for a specific fixed format of incoming URBs expected from
an iOS device:

* 12-byte NTH16
* 96-byte NDP16, allowing up to 22 DPEs (up to 21 datagrams + trailer)

On iOS, NDP16 directly follows NTH16, and its length is constant
regardless of the DPE count.

Adapt the driver to use the fixed URB format. Set an upper bound for
the DPE count based on the expected header size. Always expect a null
trailer DPE.

The minimal URB length of 108 bytes (IPHETH_NCM_HEADER_SIZE) in NCM mode
is already enforced in ipheth since introduction of NCM mode support.

Signed-off-by: Foster Snowhill <forst@pen.gy>
Tested-by: Georgi Valkov <gvalkov@gmail.com>
---
v2: No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/

This should perhaps go into "net" rather than "net-next"? I submitted
the previous patch series to "net-next", but it got merged into "net"
[1]. However it's quite late in the 6.11-rc cycle, so not sure.

[1]: https://lore.kernel.org/netdev/172320844026.3782387.2037318141249570355.git-patchwork-notify@kernel.org/
---
 drivers/net/usb/ipheth.c | 64 ++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 46afb95ffabe..8c62501f47a9 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -61,7 +61,16 @@
 #define IPHETH_USBINTF_PROTO    1
 
 #define IPHETH_IP_ALIGN		2	/* padding at front of URB */
-#define IPHETH_NCM_HEADER_SIZE  (12 + 96) /* NCMH + NCM0 */
+/* On iOS devices, NCM headers in RX have a fixed size:
+ * - NTH16 (NCMH): 12 bytes, as per CDC NCM 1.0 spec
+ * - NDP16 (NCM0): 96 bytes
+ */
+#define IPHETH_NDP16_HEADER_SIZE 96
+#define IPHETH_NDP16_MAX_DPE	((IPHETH_NDP16_HEADER_SIZE - \
+				  sizeof(struct usb_cdc_ncm_ndp16)) / \
+				 sizeof(struct usb_cdc_ncm_dpe16))
+#define IPHETH_NCM_HEADER_SIZE	(sizeof(struct usb_cdc_ncm_nth16) + \
+				 IPHETH_NDP16_HEADER_SIZE)
 #define IPHETH_TX_BUF_SIZE      ETH_FRAME_LEN
 #define IPHETH_RX_BUF_SIZE_LEGACY (IPHETH_IP_ALIGN + ETH_FRAME_LEN)
 #define IPHETH_RX_BUF_SIZE_NCM	65536
@@ -213,9 +222,9 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 	struct usb_cdc_ncm_ndp16 *ncm0;
 	struct usb_cdc_ncm_dpe16 *dpe;
 	struct ipheth_device *dev;
+	u16 dg_idx, dg_len;
 	int retval = -EINVAL;
 	char *buf;
-	int len;
 
 	dev = urb->context;
 
@@ -225,41 +234,40 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 	}
 
 	ncmh = urb->transfer_buffer;
-	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN) ||
-	    le16_to_cpu(ncmh->wNdpIndex) >= urb->actual_length) {
-		dev->net->stats.rx_errors++;
-		return retval;
-	}
+	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN))
+		goto rx_error;
 
-	ncm0 = urb->transfer_buffer + le16_to_cpu(ncmh->wNdpIndex);
-	if (ncm0->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN) ||
-	    le16_to_cpu(ncmh->wHeaderLength) + le16_to_cpu(ncm0->wLength) >=
-	    urb->actual_length) {
-		dev->net->stats.rx_errors++;
-		return retval;
-	}
+	/* On iOS, NDP16 directly follows NTH16 */
+	ncm0 = urb->transfer_buffer + sizeof(struct usb_cdc_ncm_nth16);
+	if (ncm0->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN))
+		goto rx_error;
 
 	dpe = ncm0->dpe16;
-	while (le16_to_cpu(dpe->wDatagramIndex) != 0 &&
-	       le16_to_cpu(dpe->wDatagramLength) != 0) {
-		if (le16_to_cpu(dpe->wDatagramIndex) >= urb->actual_length ||
-		    le16_to_cpu(dpe->wDatagramIndex) +
-		    le16_to_cpu(dpe->wDatagramLength) > urb->actual_length) {
-			dev->net->stats.rx_length_errors++;
-			return retval;
-		}
+	for (int dpe_i = 0; dpe_i < IPHETH_NDP16_MAX_DPE; ++dpe_i, ++dpe) {
+		dg_idx = le16_to_cpu(dpe->wDatagramIndex);
+		dg_len = le16_to_cpu(dpe->wDatagramLength);
+
+		/* Null DPE must be present after last datagram pointer entry
+		 * (3.3.1 USB CDC NCM spec v1.0)
+		 */
+		if (dg_idx == 0 && dg_len == 0)
+			return 0;
+
+		if (dg_idx < IPHETH_NCM_HEADER_SIZE ||
+		    dg_idx >= urb->actual_length ||
+		    dg_len > urb->actual_length - dg_idx)
+			goto rx_error;
 
-		buf = urb->transfer_buffer + le16_to_cpu(dpe->wDatagramIndex);
-		len = le16_to_cpu(dpe->wDatagramLength);
+		buf = urb->transfer_buffer + dg_idx;
 
-		retval = ipheth_consume_skb(buf, len, dev);
+		retval = ipheth_consume_skb(buf, dg_len, dev);
 		if (retval != 0)
 			return retval;
-
-		dpe++;
 	}
 
-	return 0;
+rx_error:
+	dev->net->stats.rx_errors++;
+	return retval;
 }
 
 static void ipheth_rcvbulk_callback(struct urb *urb)
-- 
2.45.1


