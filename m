Return-Path: <netdev+bounces-126269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF5C970470
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 01:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DF7B21DA7
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 23:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64741607A3;
	Sat,  7 Sep 2024 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="fTMPCgpw"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8BE200CB
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725750100; cv=none; b=tje8KrD31gbot+7xWRhQUnPTzpGUR1y/1eKrGZsxx4SsceQ5fz4Sj6Cc/3QDJgQZueeo3BZODMTW9R1TjflvAh/EWQj4wX4SJEv/Hz+vmyAsPM6J0cNa4GW2cfrvLMhwr7CRasbUxHRLC7a/6qK84BFfSDYGYA1IElEHf7Bu6sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725750100; c=relaxed/simple;
	bh=t8NXUXJ2UYDRW2Hia90fsYHK5pU+gn9obpMauNDNOv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJkBGDDrMzCxbHF8p4MjuLdeXzqvLL6xRT8/dPAjWr2h+uwPamSoxonz1b+G94n1DdRZhpZVkfweFHavofQJfBPSJLandFQsm5ErBrrwgRbIlXRMEtZ0UtIVo9NSuSmLI56oDgD5EJKpE3eQXa0xSloQr0W5LfYSX1yJ/iwwys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=fTMPCgpw; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1725750098; bh=7Qi/LCZqf4hpZjcaRzVVYAVRnlZ9gOUsZ7aAger/xaM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fTMPCgpw16n0RsT5x2OV3Hb7CD3S895WyIdafEJuYqRSBtrj8XHYtV6e2Yb8AI0IA
	 G8RJeaYYETXRCfYvoSFYuvqJTs9JoAHicnjwnVf6XGfE6s4G8vei34QAOPedX85/WK
	 47LsWx3xfRtH/A7DwF1QUZq8lK6Q0XW1O+kZEGUMQCo5bNAEFLCt3Ot28BbvrEspGf
	 BjYuB3vGScBbSBYGhs/ME1Zr3FYnD8S2dYMkvxv9Pe5+h7TGYD/hNuUmuPlG8J5fP3
	 33V3We5HneBULGx4Bk69bYrhdLSkAZgLVtVNk1ejU9wkq9slXLYbs24Oakm10PDsR8
	 mLge064n0V2Lw==
Received: from fossa.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 11FA5A00A3;
	Sat,  7 Sep 2024 23:01:33 +0000 (UTC)
From: Foster Snowhill <forst@pen.gy>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH net-next] usbnet: ipheth: prevent OoB reads of NDP16
Date: Sun,  8 Sep 2024 01:01:08 +0200
Message-ID: <20240907230108.978355-1-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b3pPLcYv25b23hrRA9NDV3APsY2qQXjI
X-Proofpoint-GUID: b3pPLcYv25b23hrRA9NDV3APsY2qQXjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-07_12,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=613 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409070191

There were a few potential out of bounds reads when processing
malformed URBs received from a connected device in NCM mode:

* Only the start of NDP16 (wNdpIndex) was checked to fit in the URB
  buffer.
* Datagram length check as part of DPEs could overflow.
* DPEs could be read past the end of NDP16 and even end of URB buffer
  if a trailer DPE wasn't encountered.

The above is not expected to happen in normal device operation.

To address the above issues without reimplementing more of CDC NCM,
rely on and check for a specific fixed format of incoming URBs
expected from an iOS device:

* 12-byte NTH16
* 96-byte NDP16, allowing up to 22 DPEs (up to 21 datagrams + trailer)

On iOS, NDP16 directly follows NTH16, and its length is constant
regardless of the DPE count.

Adapt the driver to use the fixed URB format. Set an upper bound for
the DPE count based on the expected header size. Always expect a null
trailer DPE.

The minimal URB length of 108 bytes (IPHETH_NCM_HEADER_SIZE) in NCM mode
is already enforced in ipheth since introduction of NCM support.

Signed-off-by: Foster Snowhill <forst@pen.gy>
Tested-by: Georgi Valkov <gvalkov@gmail.com>
---
This should perhaps go into "net" rather than "net-next"? I submitted
the previous patch series to "net-next", but it got merged into "net"
[1]. However it's quite late in the 6.11-rc cycle, I see that 6.11-rc7
net stuff was already merged into Linus' tree ~two days ago.

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


