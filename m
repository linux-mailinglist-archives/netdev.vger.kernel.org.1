Return-Path: <netdev+bounces-155224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC28A0179B
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1658B162E20
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C7A1E884;
	Sun,  5 Jan 2025 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="G+bjnCk8"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA053596D
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038930; cv=none; b=LBE+VSU/8AGFb3odBonVBImlDwoqKARrpKD4N4bET8TKX2JaoumWuWcyB7Fa9lRfMYKv6c9IYSt82dQd9Qp4vB3/xJApzYnOtjroRzOONwCFVxNgjjGmwWiZl1l6RgPILAVyXsegLeB1kIxc2uyjgqqoX451AgJnDTTbKIkBgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038930; c=relaxed/simple;
	bh=gdr3lIbDeeu3lGJcPUIXZI0GtBHkqV3idA1+n3n94LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwmYUxb6ZiBJebNPZFqR/luPmLXFaN4QDbR1juhVp7K9MdraFMoMjza/B9wSxw0dEcYRWArmllCfJur9wfod3/0GIg6GzfEDGrp3XFKM7zK10EU+4TE93LhZRsb/pWtbE+LhW/BjJbGEuUdXcBs0WyXdsAJYfH0QpOIEiqbEUwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=G+bjnCk8; arc=none smtp.client-ip=17.57.155.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1736038927; bh=Uu90pAf2wJ+haot8QoQIW/G/7kp2o6NfhKfyyk60q8w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=G+bjnCk83fhhQui33+48toUdg68Q30GYvvuATIbMPsI2lGW2ZNOWq9txzak2FI69G
	 3Tvjte70F1NRz8c5yBteAcSOP0cWRiF3pBUxTFB5jCNx9qiY5tAYjx7RCbYA2KvW8a
	 2gPK+h+7ad8ZLZFbl9X+l5WzawG1WxaLmg0t3ZGIIZQ48w0L/XNeuEbof5ddngAJgm
	 0FCVYEjuCAj+0I1byWiEA4anHON5Wi7FAq/BmMppioOXZfz6utvWXlgyKdC6xcycye
	 cXYw905Rs9D+unc2RbTyGxDVYMyCXrDPFL5gUovF52vbX4T9RPn7b9Iov/8seP5nyh
	 X3Kkvblcsn6lw==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id 723D24E4031C;
	Sun,  5 Jan 2025 01:02:04 +0000 (UTC)
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
Subject: [PATCH net v4 3/7] usbnet: ipheth: check that DPE points past NCM header
Date: Sun,  5 Jan 2025 02:01:17 +0100
Message-ID: <20250105010121.12546-4-forst@pen.gy>
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
X-Proofpoint-GUID: mziyVBly5qccvB1Ec9ktIaQqUcZFa1xY
X-Proofpoint-ORIG-GUID: mziyVBly5qccvB1Ec9ktIaQqUcZFa1xY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=470 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501050007

By definition, a DPE points at the start of a network frame/datagram.
Thus it makes no sense for it to point at anything that's part of the
NCM header. It is not a security issue, but merely an indication of
a malformed DPE.

Enforce that all DPEs point at the data portion of the URB, past the
NCM header.

Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
Signed-off-by: Foster Snowhill <forst@pen.gy>
---
v4:
    No change since v3.
v3: https://lore.kernel.org/netdev/20241123235432.821220-3-forst@pen.gy/
    Split out from a monolithic patch in v2 as an atomic change.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
---
 drivers/net/usb/ipheth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 4b590a5269fd..48c79e69bb7b 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -253,7 +253,8 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 	dpe = ncm0->dpe16;
 	while (le16_to_cpu(dpe->wDatagramIndex) != 0 &&
 	       le16_to_cpu(dpe->wDatagramLength) != 0) {
-		if (le16_to_cpu(dpe->wDatagramIndex) >= urb->actual_length ||
+		if (le16_to_cpu(dpe->wDatagramIndex) < IPHETH_NCM_HEADER_SIZE ||
+		    le16_to_cpu(dpe->wDatagramIndex) >= urb->actual_length ||
 		    le16_to_cpu(dpe->wDatagramLength) > urb->actual_length -
 		    le16_to_cpu(dpe->wDatagramIndex)) {
 			dev->net->stats.rx_length_errors++;
-- 
2.45.1


