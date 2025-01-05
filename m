Return-Path: <netdev+bounces-155226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916ECA017A0
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094033A2FCF
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818403F9D5;
	Sun,  5 Jan 2025 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="BlOITIZo"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8521BC4E
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038937; cv=none; b=oCsZapbVTZRTX99DSq+6kWGHQnqczLK5SO0GqBLd4Z0NZDOD6y6SrEIx5DvhfwMK4/tO8ygpjXHEcK4AqguEWj6JhlXlGXz+adGIBnbQfEpBkpFX9JsJ/ftiRxr78aEv5jzkMpM10Ua0k1QgZNnR/lFTUEBIRL8BPLpiLlGHLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038937; c=relaxed/simple;
	bh=7UK33KbsyogV1PhFZAF0ip1dQdedZRcjLQ/JjRRQ7J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8bhPu8nL5EdQEjch379ThyBSEH1uaOGUecv+Cef3NlHpAm5ihZFHpjNqaniNc379bNgWGGWpoNay9V6klfQNJ20o3Mb3LBFUL4LPX/VOUw8Tmjhsgnxs6AM+nYZvAGUtdikz0tzaePyHJ9kmlYAIUiGToOeAK3tDFL2EnNW+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=BlOITIZo; arc=none smtp.client-ip=17.57.155.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1736038934; bh=7x+tWKXx3m/5m2X6cl5M0NW7QXghK6MQ/ArleBnvwAw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=BlOITIZo580/64veO1TBvdEdT4txzU6KAAKBl11CiJ0D+AsfBOT3zrVEo4lgYQGu0
	 TND4GTHV1baDGDb5yb2djcl2MKEGINOEG7ryiH4f7/bTccn8huuZkxMHE9eFz4HOow
	 50Wg1DszSu8fDzek9PnzJINV0O3nnjv6YDBhjMNjt0+2s48kyTRZy16jjpoaWCs/y8
	 KG/8JHw9J9PBpoDe/Xb3RDK3RDEl122UHonnfstOIo/pki63vf5qFeHRqfq+tW8NyB
	 +NuzC4aCvIkIjLyApFMySTlpAcE8rOBnfV00Ma6WZMBG2qDd7dcWgWVIJsrs2411c3
	 +JgkPRY3b6kLQ==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id 470564E401A5;
	Sun,  5 Jan 2025 01:02:11 +0000 (UTC)
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
Subject: [PATCH net v4 5/7] usbnet: ipheth: refactor NCM datagram loop
Date: Sun,  5 Jan 2025 02:01:19 +0100
Message-ID: <20250105010121.12546-6-forst@pen.gy>
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
X-Proofpoint-GUID: FsV0s8q3dVdA-Frb-5dkAPXMrwn69fLs
X-Proofpoint-ORIG-GUID: FsV0s8q3dVdA-Frb-5dkAPXMrwn69fLs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=713 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501050007

Introduce an rx_error label to reduce repetitions in the header
signature checks.

Store wDatagramIndex and wDatagramLength after endianness conversion to
avoid repeated le16_to_cpu() calls.

Rewrite the loop to return on a null trailing DPE, which is required
by the CDC NCM spec. In case it is missing, fall through to rx_error.

This change does not fix any particular issue. Its purpose is to
simplify a subsequent commit that fixes a potential OoB read by limiting
the maximum amount of processed DPEs.

Fix an out-of-bounds DPE read, limit the number of processed DPEs to
the amount that fits into the fixed-size NDP16 header.

Signed-off-by: Foster Snowhill <forst@pen.gy>
---
v4:
    Split from "usbnet: ipheth: refactor NCM datagram loop, fix DPE OoB
    read" in v3. This commit is responsible for the code refactor, while
    keeping the behaviour the same.
v3: https://lore.kernel.org/netdev/20241123235432.821220-5-forst@pen.gy/
    Split out from a monolithic patch in v2 as an atomic change.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
---
 drivers/net/usb/ipheth.c | 42 ++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 35f507db2c4a..03249208612e 100644
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
 
@@ -238,39 +238,43 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 	ncmh = urb->transfer_buffer;
 	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN) ||
 	    /* On iOS, NDP16 directly follows NTH16 */
-	    ncmh->wNdpIndex != cpu_to_le16(sizeof(struct usb_cdc_ncm_nth16))) {
-		dev->net->stats.rx_errors++;
-		return retval;
-	}
+	    ncmh->wNdpIndex != cpu_to_le16(sizeof(struct usb_cdc_ncm_nth16)))
+		goto rx_error;
 
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
+	while (true) {
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
 
 		dpe++;
 	}
 
-	return 0;
+rx_error:
+	dev->net->stats.rx_errors++;
+	return retval;
 }
 
 static void ipheth_rcvbulk_callback(struct urb *urb)
-- 
2.45.1


