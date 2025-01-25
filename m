Return-Path: <netdev+bounces-160936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47EFA1C5E3
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 00:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C3B1670E7
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 23:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DDD20A5D1;
	Sat, 25 Jan 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="kAiGWKpc"
X-Original-To: netdev@vger.kernel.org
Received: from ci74p00im-qukt09081901.me.com (ci74p00im-qukt09081901.me.com [17.57.156.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCF2066E3
	for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737849294; cv=none; b=CKnq1azBMhJd8KO3BrJN+rSYamZjvHDObUWBUEWHTCfWn+/3PG32C5s7maMiXMBehVI11pdq0H1QD1BhwSfaHSQXRdn+Z2RbbsqcCcuzzYW+IN+HSIvEovNbZjlOC0EZw18dk03wHuwOJB/9vYzJvgQqFZTGWdd2YSXHKtRWbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737849294; c=relaxed/simple;
	bh=yAezLCf3sL/xyEXXHmjuMG8Vmf3ZU7WdJSdoJuy2RT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJQe/k580e1Jr3r7N0Lv8IFeld0EHLmQpquR0Y7iieVj9kVCwQQNkGZ9mHQHap6a6LreNuI8OwJfkNv6Oni+9t6nMFdLV4mrcQLhJ8efO2Xfq9IBi7Uq6RAOdA9JVneXS4Imoqh2b8+NvufEbyc7AsaNUBzcSzjq6jrhRogKJQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=kAiGWKpc; arc=none smtp.client-ip=17.57.156.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	bh=ROb1MbEkJEsKoBRZN5KIVcKLJLOWT5N4PgijIhXcNCc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=kAiGWKpcJhgvI2BUcJnSGkYd1W7If7dLEJDuq/zX0HdRAPJQupHBxmCHk3P0ot2rh
	 Yn/UR1tlM+Q/6RuOi6cl9tT5qc0XBL7UdaHMT2fCFUkozkH2UnxxRDgwnOPgej1qG3
	 DLwt+SA/je8Sh+qnvJxu+BNEPTl5Cb18TNmgG7RzMTgY1pZuxZRi3FOe4iMAt5cSE9
	 sagsBAHE2kqqFxKYSfM1X0nhlTndAhOEQ3frjzxCsKlZQYrp+2FCI2fh1zCetAL9tm
	 dy7egkitADCoCjIpSeXb8XAFaKdYk/js9ye6JcDX7c0nGFdR+gDPjU5QPNjvsoCCxu
	 aBVwnd80FuMvg==
Received: from fossa.se1.pen.gy (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09081901.me.com (Postfix) with ESMTPSA id 419725AC0107;
	Sat, 25 Jan 2025 23:54:47 +0000 (UTC)
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
Subject: [PATCH net v5 3/7] usbnet: ipheth: use static NDP16 location in URB
Date: Sun, 26 Jan 2025 00:54:05 +0100
Message-ID: <20250125235409.3106594-4-forst@pen.gy>
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
X-Proofpoint-ORIG-GUID: qyXH2cwgft0pV76oK8zTS8U0dIDGsXyt
X-Proofpoint-GUID: qyXH2cwgft0pV76oK8zTS8U0dIDGsXyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_11,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=560 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1030
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501250183

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
Cc: stable@vger.kernel.org
Signed-off-by: Foster Snowhill <forst@pen.gy>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v5:
    No code changes. Added Cc to stable and Reviewed-by Jakub tags.
v4: https://lore.kernel.org/netdev/20250105010121.12546-5-forst@pen.gy/
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
index 1ff5f7076ad5..c385623596d2 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -226,15 +226,14 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 
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


