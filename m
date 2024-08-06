Return-Path: <netdev+bounces-116192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F79496BE
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD361C20A48
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A992770E8;
	Tue,  6 Aug 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="VflxrJZB"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01072501.me.com (qs51p00im-qukt01072501.me.com [17.57.155.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAFC5A7AA
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965332; cv=none; b=KAfj69IZgs33iaTtju21gXGulXjM8WBtOFwKUR2uBa+97BWaM23xv9Ox/b6vnZOaN7sJ6D5ZIBXrefTPCEpgQ8Bp//pJhFT3e12oJuNE01pwYLkgBajHovTKoBTWW9JZ/ODoqQAv2jqR9y77R+oXJu78fj7jiVV/xy2vaNwblDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965332; c=relaxed/simple;
	bh=KxjFJ439U5Uqr++yvMpYfMvkYLK6KAI8Z1y6rGxbyCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRxGi5OT4qASWYUe1m6sGm1DOcALWSDtz1MZQ05bnVwHeCEfd1puzFFunni14EIcrjYUEYHpak34E3eHH08UdZ5F5JFSigz7t2z4pgSd/Z+32CefV8UNc0qoduyvF+S6cRD05iDl+VWw1rrAqgbkIp7/6CTFE57LRFXSiQkJqso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=VflxrJZB; arc=none smtp.client-ip=17.57.155.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1722965329; bh=Uo+aXk6YogbsVi8I+aNJDJsTpJ8HfpCSJvx3xAXPcm0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VflxrJZB46adtHidkAft7qb3+nI5lhZJ+35CGfr+MIpDD+SixAQ0kdsaDdgEfHsoZ
	 mEibU8+gDdpeUsDCrmGW4XLA2SephK4LGjI/xd5cKkN6CZqyFRbYiCFVU3+aOmFJA7
	 +0QRNEhAZsl5SVCJe4JrIN6TRPWLVxJCvCLVKj1mHLTmcbGi1eQ7ee33Cq2PObGAWJ
	 wz0oWIHgt9bBfqDAVO4oP5Se4X5rfK3FYxAfbS7LFK1Eej0N2DuvhRzkExQP+3dFQt
	 gdNkuDvUfWKghEbK9tGBQGtC/PmsQMP3OlZRa5/1ozVTlCeydyZ6Ssgi7In3Oz/uDk
	 LRyfc8KikHpSw==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072501.me.com (Postfix) with ESMTPSA id D6CDA440249;
	Tue,  6 Aug 2024 17:28:46 +0000 (UTC)
From: Foster Snowhill <forst@pen.gy>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>,
	Oliver Neukum <oneukum@suse.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH net-next 2/5] usbnet: ipheth: remove extraneous rx URB length check
Date: Tue,  6 Aug 2024 19:28:06 +0200
Message-ID: <20240806172809.675044-2-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240806172809.675044-1-forst@pen.gy>
References: <20240806172809.675044-1-forst@pen.gy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KAo4SPFZVPe8yg9ihCvIBLFODIVc-d3I
X-Proofpoint-ORIG-GUID: KAo4SPFZVPe8yg9ihCvIBLFODIVc-d3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_14,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=724 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408060123

Rx URB length was already checked in ipheth_rcvbulk_callback_legacy()
and ipheth_rcvbulk_callback_ncm(), depending on the current mode.
The check in ipheth_rcvbulk_callback() was thus mostly a duplicate.

The only place in ipheth_rcvbulk_callback() where we care about the URB
length is for the initial control frame. These frames are always 4 bytes
long. This has been checked as far back as iOS 4.2.1 on iPhone 3G.

Remove the extraneous URB length check. For control frames, check for
the specific 4-byte length instead.

Signed-off-by: Foster Snowhill <forst@pen.gy>
Tested-by: Georgi Valkov <gvalkov@gmail.com>
---
 drivers/net/usb/ipheth.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 6eeef10edada..017255615508 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -286,11 +286,6 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 		return;
 	}
 
-	if (urb->actual_length <= IPHETH_IP_ALIGN) {
-		dev->net->stats.rx_length_errors++;
-		return;
-	}
-
 	/* RX URBs starting with 0x00 0x01 do not encapsulate Ethernet frames,
 	 * but rather are control frames. Their purpose is not documented, and
 	 * they don't affect driver functionality, okay to drop them.
@@ -298,7 +293,8 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 	 * URB received from the bulk IN endpoint.
 	 */
 	if (unlikely
-		(((char *)urb->transfer_buffer)[0] == 0 &&
+		(urb->actual_length == 4 &&
+		 ((char *)urb->transfer_buffer)[0] == 0 &&
 		 ((char *)urb->transfer_buffer)[1] == 1))
 		goto rx_submit;
 
-- 
2.45.1


