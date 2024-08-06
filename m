Return-Path: <netdev+bounces-116193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D79496C1
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEB11F26D0C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982E4558B6;
	Tue,  6 Aug 2024 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="Hk3tL4ex"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01072501.me.com (qs51p00im-qukt01072501.me.com [17.57.155.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002978C7B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965335; cv=none; b=oAH2H2usqtYnjD0XXZqARNjP5UycNClnzKMGETffJirHKo1kg0AgeWU2gZob3+ezCa+fLdYZKXtK8hQdZBG2LVcS0qNICC5iQtqfOuSKkZ9RS0zuBwlx9sxW3MrFAklAo0b5z1Ek/oZd/StrvnYmW6f5ZXSot1Di868RdUkURec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965335; c=relaxed/simple;
	bh=ubdVxvBRHK4prX4q7OyKXte/DltU0dS/J02go08lMhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIORWlgwsAkdi/pp+feRkMVUTO43Set5GsC5ISfJsxkgISsedOodbE2zDVy00Q2j0q03KTP/bjGQDGuxRBFZEmoqHCU/HdtanEoYNyjgrQqjMhundH6NdTOmmqqalJv++BVJOpADV25LTvhqTTb2qfvyhtuup1HsfNYneSpFIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=Hk3tL4ex; arc=none smtp.client-ip=17.57.155.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1722965333; bh=UxeYWQSz4iOwxX9retJ70LoYdSG2m+FccOYF6P9/oL4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Hk3tL4expbi8Jy4Iu9fvDvIloQn/jIUVaAslSk8ehMLFW0EptlyPhAa1+KkfWlSx0
	 O2KAV5TfOVaKdeJwcqrEN/8JTLigkGOp1k7Ro60418QoVqseFhdls/JFNpIzLu93VR
	 OqKzK/2hzGDbTD3mRl3AKclPti+hMb7VdWIWn3cMK8EskF7iVc2jghBoYzfNyr9eau
	 9vAoErCwJwh3NKv4UbzVolA5eVxWw57v0beNaBuZflE4kufFSEIHvDFjmeXLgHr9zO
	 EnxR9tFMWgCEDAh8IYYjEBjfmt47tfUW+CRn0OWu6OGAkeZhaXw9cV3AGSmio8/7zd
	 nrJJgsEP2ImAQ==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072501.me.com (Postfix) with ESMTPSA id 3ACA9440246;
	Tue,  6 Aug 2024 17:28:49 +0000 (UTC)
From: Foster Snowhill <forst@pen.gy>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>,
	Oliver Neukum <oneukum@suse.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH net-next 3/5] usbnet: ipheth: drop RX URBs with no payload
Date: Tue,  6 Aug 2024 19:28:07 +0200
Message-ID: <20240806172809.675044-3-forst@pen.gy>
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
X-Proofpoint-GUID: gz1XCD9jyqy-1Bkt9juS1LWuYCyzDpYe
X-Proofpoint-ORIG-GUID: gz1XCD9jyqy-1Bkt9juS1LWuYCyzDpYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_14,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=584 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408060123

On iPhone 15 Pro Max one can observe periodic URBs with no payload
on the "bulk in" (RX) endpoint. These don't seem to do anything
meaningful. Reproduced on iOS 17.5.1 and 17.6.

This behaviour isn't observed on iPhone 11 on the same iOS version. The
nature of these zero-length URBs is so far unknown.

Drop RX URBs with no payload.

Signed-off-by: Foster Snowhill <forst@pen.gy>
---
 drivers/net/usb/ipheth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 017255615508..f04c7bf79665 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -286,6 +286,12 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 		return;
 	}
 
+	/* iPhone may periodically send URBs with no payload
+	 * on the "bulk in" endpoint. It is safe to ignore them.
+	 */
+	if (urb->actual_length == 0)
+		goto rx_submit;
+
 	/* RX URBs starting with 0x00 0x01 do not encapsulate Ethernet frames,
 	 * but rather are control frames. Their purpose is not documented, and
 	 * they don't affect driver functionality, okay to drop them.
-- 
2.45.1


