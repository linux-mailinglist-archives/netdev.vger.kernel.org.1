Return-Path: <netdev+bounces-146924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B69E9D6C49
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 00:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8305F161B1F
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 23:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825071AA1EB;
	Sat, 23 Nov 2024 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="GsMGn05x"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A61AAE39
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732406134; cv=none; b=Sfp+0YqPfNL7bnaWNv6qJcbMrIC0W2P6WVQ3VuYtjZNryLLX23js9kuN9QDa30o87QuRuAWBNmb2BK1Phn15gS/4H6oZLcria6t8qu9vAt3CkGcB71CBB1GHVE838cmFpDQ3RzYSJyYJcmjcbtff5MHeNSuQxOWeNrU/3Ikdw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732406134; c=relaxed/simple;
	bh=/c/T2n02Jza0P2IpNMrW20I5Ahg5Ww4mKJyItH+JWXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEvdRUOrkpfGQlKOAJ5RstGICHx57dx3FJrUI1OoXCxHIgwCfzcRTjafGbRtgtAqqMrro/NVbqwJ9p906QEiGr2F34u0BNb33B8Oo0CwA31bL7pMHMR6hRhQB6KdEUXyMh0dbfIcx3XZH0db6n0cMJkQlOKrCgrYYgJQ3DJKilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=GsMGn05x; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1732406132; bh=NuPwDG3I3id9LvvDEZwalmCEDEPYz7UUsfKG/NaauWY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=GsMGn05xQJCQNVszaJEp+dNQeGwu17ZIUcpK6hmmHcBspWp3zxjuaCPf6SsqXy7/J
	 vsjUPBhWokCxAxOOWUXxgS3k1srwFIpjBbkY2dZAnf4LAJNaMR7xYRAPR5pviQyE6J
	 kro6OsazRptxDR1NP0yitf+pfxKmO21vz4A4E9NoZESjgdH3lGrs/L+fRlcfAqP2o9
	 5gGEsncCJ9E78UoeEwFEUxBkzt6ZpQFNNmXYlLw0y7RLOUm3qMvmDo3YJAcYvIwkvt
	 tVgL78lLmbFDHStz1eg1cHYJ576v2Pl7/bgG0RRzSe9KN9tv++IKgTHFS3ap1bzuqa
	 kqoCcmXq0cJ6w==
Received: from fossa.se1.pen.gy (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 47592A01D5;
	Sat, 23 Nov 2024 23:55:27 +0000 (UTC)
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
Subject: [PATCH net v3 4/6] usbnet: ipheth: use static NDP16 location in URB
Date: Sun, 24 Nov 2024 00:54:30 +0100
Message-ID: <20241123235432.821220-4-forst@pen.gy>
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
X-Proofpoint-GUID: FRIZSRD39wQz7kYVc_zx5ostTj_KTMYd
X-Proofpoint-ORIG-GUID: FRIZSRD39wQz7kYVc_zx5ostTj_KTMYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-23_19,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=548 malwarescore=0 clxscore=1030 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411230200

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
v3:
    Split out from a monolithic patch in v2 as an atomic change.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
---
 drivers/net/usb/ipheth.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 48c79e69bb7b..3f9ea6546720 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -236,16 +236,14 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 	}
 
 	ncmh = urb->transfer_buffer;
-	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN) ||
-	    le16_to_cpu(ncmh->wNdpIndex) >= urb->actual_length) {
+	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN)) {
 		dev->net->stats.rx_errors++;
 		return retval;
 	}
 
-	ncm0 = urb->transfer_buffer + le16_to_cpu(ncmh->wNdpIndex);
-	if (ncm0->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN) ||
-	    le16_to_cpu(ncmh->wHeaderLength) + le16_to_cpu(ncm0->wLength) >=
-	    urb->actual_length) {
+	/* On iOS, NDP16 directly follows NTH16 */
+	ncm0 = urb->transfer_buffer + sizeof(struct usb_cdc_ncm_nth16);
+	if (ncm0->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN)) {
 		dev->net->stats.rx_errors++;
 		return retval;
 	}
-- 
2.45.1


