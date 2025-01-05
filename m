Return-Path: <netdev+bounces-155225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ECCA0179D
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181191884266
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF4F3594D;
	Sun,  5 Jan 2025 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="fkzeQRYQ"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246A17C91
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038933; cv=none; b=iBxqg9TfxZsUmNhbv1Cl6d8aaHFhrV1jBycsuVfEkiCFuB6A139fgYKtHdafgt748YmGDbxG9GZ1YOOVDiYwTv3EbDXVFwZ21NCWiGYRj2xmXmQnUtZB+dcj3ZgG/0x9FR+FG5w1hfhSN+YoaClPCqavf0F2w5FEi/hsiiNo2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038933; c=relaxed/simple;
	bh=v08LP/vA38rMGaE48oYXJiKyqTcyaBXnpqHV1cBNF/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ok7XhaClKp8EDNFcKZqb7V/5ASq2bcVidYbg+WWDH7Qhr84vim+EYK+lv26i3VHdMxtd+jqB/8ArBXjUMcf41JFqRU9OeETqmKef1ICMGpUKJHC7r/K8Kg/CP65eNsUisIERUYiO1957e8VEScWLvHZ/EeBYYhGho48ladQICkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=fkzeQRYQ; arc=none smtp.client-ip=17.57.155.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1736038930; bh=jA5Elsv6DJ1PRK/AyDutknBxgJAPX7pUFb8V5z5GRWw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=fkzeQRYQ/byD/2KFnLzI+zDnZ/HzzutKpSKhtrO8/xoOi+cVk3dB03EWVGxTbgMgQ
	 2Mn7yA883bzXNd3g/5jlOwfbVOrKSqjvRdhMANzd0henzGSz3dIfb0+y/FUs47bsiW
	 0UCkpbb3M1I/7AV29Ol164+VKSjUoh9S8IQ8qYqP97AtPlCjbGmhlNIXheIVyOaOGz
	 agNAr4W8Zf9tWTyHHLHHWBf2yIFpJQXi6gdk1mFBE6lqce+FLSfxyVTpG6EVbovUca
	 OItMkgwuQ9g1/8Jn+zyEepxWFQM5gKR+/zm3e8mt1M7+PyQaSOTzZx0sUJvDMmDR6i
	 jvnjThLe7sSzw==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id D43B54E40302;
	Sun,  5 Jan 2025 01:02:07 +0000 (UTC)
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
Subject: [PATCH net v4 4/7] usbnet: ipheth: use static NDP16 location in URB
Date: Sun,  5 Jan 2025 02:01:18 +0100
Message-ID: <20250105010121.12546-5-forst@pen.gy>
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
X-Proofpoint-GUID: 19I-srsZhN7ftCtPly6qMe1jvkUlC3kC
X-Proofpoint-ORIG-GUID: 19I-srsZhN7ftCtPly6qMe1jvkUlC3kC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=578 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501050007

Original code allowed for the start of NDP16 to be anywhere within the
URB based on the `wNdpIndex` value in NTH16. Only the start position of
NDP16 was checked, so it was possible for even the fixed-length part
of NDP16 to extend past the end of URB, leading to an out-of-bounds
read.

On iOS devices, the NDP16 header always directly follows NTH16. Rely on
and check for this specific format.

This, along with NCM-specific minimal URB length check that already
exists, will ensure that the fixed-length part of NDP16 plus a set
amount of DPEs fit within the URB.

Note that this commit alone does not fully address the OoB read.
The limit on the amount of DPEs needs to be enforced separately.

Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
Signed-off-by: Foster Snowhill <forst@pen.gy>
---
v4:
    Additionally check that ncmh->wNdpIndex points immediately after
    NTH16. This covers an unexpected on real devices, and highly
    unlikely otherwise, case where the bytes after NTH16 are set to
    `USB_CDC_NCM_NDP16_NOCRC_SIGN`, yet aren't the beginning of the
    NDP16 header.
v3: https://lore.kernel.org/netdev/20241123235432.821220-4-forst@pen.gy/
    Split out from a monolithic patch in v2 as an atomic change.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
---
 drivers/net/usb/ipheth.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 48c79e69bb7b..35f507db2c4a 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -237,15 +237,14 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 
 	ncmh = urb->transfer_buffer;
 	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN) ||
-	    le16_to_cpu(ncmh->wNdpIndex) >= urb->actual_length) {
+	    /* On iOS, NDP16 directly follows NTH16 */
+	    ncmh->wNdpIndex != cpu_to_le16(sizeof(struct usb_cdc_ncm_nth16))) {
 		dev->net->stats.rx_errors++;
 		return retval;
 	}
 
-	ncm0 = urb->transfer_buffer + le16_to_cpu(ncmh->wNdpIndex);
-	if (ncm0->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN) ||
-	    le16_to_cpu(ncmh->wHeaderLength) + le16_to_cpu(ncm0->wLength) >=
-	    urb->actual_length) {
+	ncm0 = urb->transfer_buffer + sizeof(struct usb_cdc_ncm_nth16);
+	if (ncm0->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN)) {
 		dev->net->stats.rx_errors++;
 		return retval;
 	}
-- 
2.45.1


