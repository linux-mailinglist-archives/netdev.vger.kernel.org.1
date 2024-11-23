Return-Path: <netdev+bounces-146925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D519D6C4B
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 00:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472C5161B67
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3C71A9B4F;
	Sat, 23 Nov 2024 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="JbJodhNX"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8375A1ABED7
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732406139; cv=none; b=KavuQJoTp6rumWwKyRqqOYyiChaq+4r+Onf8JVqMoTJAdNb0QrRpyQAWYvtecXpicnEA8z6Oi0Y36BEqlT5s4qOEjp5R58sGnYVoeS+1mfkW/fqxVQE+imWyybjGve0M0MbYcw8yzSn9I47IvHYcgy4Y5RCLONnhQw7X2f1NEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732406139; c=relaxed/simple;
	bh=mSKgNv+8pEY9lOW+d989YvSCydnI59nBODLjbYnN1uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCuf6kErXm1/qtIwXloIveUOdraM/7OldPnK7goUiv+2NhADl5ltCAQhRr1E3wbQyTKlONDJrFcPB3+hvfVP3ykEOCD7UPZs/pmm0Oc27yEs4PuMqSw6CT4OwnHU/s24mA06dOJxs631nacpk+e5vSailk4nbjUzt0J7NbXQCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=JbJodhNX; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1732406137; bh=NCS0BS66uf7Asgthxy+WGil5SatQ+cnWgHoOGK0eBeY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=JbJodhNXraoXEngwxXM7ASHn1EXDfQsVrHos4K/sn9iuZmuoSE4QRiSGQrN22taq0
	 3HY/PFdYT5PCXLT7bsX5XUcDKGNr1DmqEdwhj3hF0yQfZeAEpfE6XRluGHI/R4LHBc
	 nh8wFVxBdsReXUe2Lti4IfaCIjfp+NXeJE+xX8JnSI6WQZ+2rsAJ4NKoFOGcOJIf9f
	 UwBz01xGpVIZwn3jJhqeqm12urcfI3D25Kfxww+AeaDFADGAylfjYzsDhaEomFkl/8
	 wVJgL2ieucf+KWRjLaPQMA5Yd/0b3soWecLjGffI+5B1ONFKZjktyE+mOwEYGI9qN3
	 oJ8Wjf2JzUsZQ==
Received: from fossa.se1.pen.gy (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 25801A006F;
	Sat, 23 Nov 2024 23:55:32 +0000 (UTC)
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
Subject: [PATCH net v3 5/6] usbnet: ipheth: refactor NCM datagram loop, fix DPE OoB read
Date: Sun, 24 Nov 2024 00:54:31 +0100
Message-ID: <20241123235432.821220-5-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241123235432.821220-1-forst@pen.gy>
References: <20241123235432.821220-1-forst@pen.gy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: twy898kQTSRr558DFtDHPKr2za0R4I2r
X-Proofpoint-ORIG-GUID: twy898kQTSRr558DFtDHPKr2za0R4I2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-23_19,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=741 malwarescore=0 clxscore=1030 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411230200

Introduce an rx_error label to reduce repetitions in the header signature
checks.

Store wDatagramIndex and wDatagramLength after endianness conversion to
avoid repeated le16_to_cpu() calls.

Rewrite the loop to return on a null trailing DPE, which is required
by the CDC NCM spec. In case it is missing, fall through to rx_error.

Fix an out-of-bounds DPE read, limit the number of processed DPEs to
the amount that fits into the fixed-size NDP16 header.

Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
Signed-off-by: Foster Snowhill <forst@pen.gy>
---
v3:
    Split out from a monolithic patch in v2 as an atomic change.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
---
 drivers/net/usb/ipheth.c | 44 +++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 3f9ea6546720..122557b5e5a9 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -224,9 +224,9 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 	struct usb_cdc_ncm_ndp16 *ncm0;
 	struct usb_cdc_ncm_dpe16 *dpe;
 	struct ipheth_device *dev;
+	u16 dg_idx, dg_len;
 	int retval = -EINVAL;
 	char *buf;
-	int len;
 
 	dev = urb->context;
 
@@ -236,40 +236,42 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 	}
 
 	ncmh = urb->transfer_buffer;
-	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN)) {
-		dev->net->stats.rx_errors++;
-		return retval;
-	}
+	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN))
+		goto rx_error;
 
 	/* On iOS, NDP16 directly follows NTH16 */
 	ncm0 = urb->transfer_buffer + sizeof(struct usb_cdc_ncm_nth16);
-	if (ncm0->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN)) {
-		dev->net->stats.rx_errors++;
-		return retval;
-	}
+	if (ncm0->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN))
+		goto rx_error;
 
 	dpe = ncm0->dpe16;
-	while (le16_to_cpu(dpe->wDatagramIndex) != 0 &&
-	       le16_to_cpu(dpe->wDatagramLength) != 0) {
-		if (le16_to_cpu(dpe->wDatagramIndex) < IPHETH_NCM_HEADER_SIZE ||
-		    le16_to_cpu(dpe->wDatagramIndex) >= urb->actual_length ||
-		    le16_to_cpu(dpe->wDatagramLength) > urb->actual_length -
-		    le16_to_cpu(dpe->wDatagramIndex)) {
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
+		    dg_len > urb->actual_length - dg_idx) {
 			dev->net->stats.rx_length_errors++;
 			return retval;
 		}
 
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


