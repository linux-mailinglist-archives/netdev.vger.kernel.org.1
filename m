Return-Path: <netdev+bounces-146926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAA79D6C4C
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 00:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DD228159A
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 23:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4A11ABEBB;
	Sat, 23 Nov 2024 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="NgvUv7fr"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFFE1ABEA7
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732406144; cv=none; b=Xd/Mv9b70ZECsFNTND6nB+2GxR/qGg6PqeLZB4E4bEVnhY7dcYWLP935tuaCYjLP8eazSqisqt6JTaMq2uFfr9B9ChEwxheeZZbRgVkUPihf9PHLBUGraVNQHg62kFdD12t4vCAEh8FzhPbOxc73LqazQTru0VB8Jx3AjFWqOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732406144; c=relaxed/simple;
	bh=oXQZ2VDpv1/BrJk0Vu+5FPKR77QM9/qErsjYaXDm+wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iePwf9oNbngqZbS1/taNmdaZ86ZN3+M43M5CREpYfHSFLzxuyjmsOkgNQd+/5uhFKb+RBtSzrajWFU1LzSvfVBNSEUT+ooZtL7rxxNajY0BW6yVbcI5GkjClgp5XdUC1rZNxqMO8kKqoDe+S2TPq4s5HPHMzgNa1T5m0Wgd+bLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=NgvUv7fr; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1732406142; bh=NcPVdecsLpad7zKtLOlVRkPyAjVC/v4Y7h1/Q3t03Cw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=NgvUv7frQv9OaDXSaqH1CAyxylMkiYMw3Th7U3c6PBp7wSqntGPyp0MTGec0eyQrB
	 DrrZPGPIlZvCuo1JZO7q+eLpkMgtMVOzkdY+OFZoJdVHZ5T1nzFTahR9cDGYGZr0hz
	 4b9trRyKm77TBkQua7+A+/WIvuYF05vo9tqlMPmy6F4s7d4uGUlfT7GHiSfA7rFdWA
	 mud+jb24BuqnwOsk+E7gn0l7/BZZqjzFCLUEgmnU194ypkP1WUYZMdRXUevrC2V8aZ
	 2Lu57bidaWfzuEGi8u42EtlzYnmQcNyICjcUzy1SkUhEAxAuLAmnS8O15IDufWrbVb
	 9QfNkT6qpd6IA==
Received: from fossa.se1.pen.gy (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id ED8CCA0179;
	Sat, 23 Nov 2024 23:55:37 +0000 (UTC)
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
Subject: [PATCH net v3 6/6] usbnet: ipheth: document scope of NCM implementation
Date: Sun, 24 Nov 2024 00:54:32 +0100
Message-ID: <20241123235432.821220-6-forst@pen.gy>
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
X-Proofpoint-GUID: 6Ni2wP-kL7_kiiZ8VNi83iHAvl3uEL17
X-Proofpoint-ORIG-GUID: 6Ni2wP-kL7_kiiZ8VNi83iHAvl3uEL17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-23_19,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=925 malwarescore=0 clxscore=1030 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411230200

Clarify that the "NCM" implementation in `ipheth` is very limited, as
iOS devices aren't compatible with the CDC NCM specification in regular
tethering mode.

For a standards-compliant implementation, one shall turn to
the `cdc_ncm` module.

Signed-off-by: Foster Snowhill <forst@pen.gy>
---
v3:
    This comment was part of the commit message for v2. With v3, given
    how the patches are split up, it makes more sense to add the comment
    directly in code.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: n/a
---
 drivers/net/usb/ipheth.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 122557b5e5a9..e906ec4b7969 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -218,6 +218,14 @@ static int ipheth_rcvbulk_callback_legacy(struct urb *urb)
 	return ipheth_consume_skb(buf, len, dev);
 }
 
+/* In "NCM mode", the iOS device encapsulates RX (phone->computer) traffic
+ * in NCM Transfer Blocks (similarly to CDC NCM). However, unlike reverse
+ * tethering (handled by the `cdc_ncm` driver), regular tethering is not
+ * compliant with the CDC NCM spec, as the device is missing the necessary
+ * descriptors, and TX (computer->phone) traffic is not encapsulated
+ * at all. Thus `ipheth` implements a very limited subset of the spec with
+ * the sole purpose of parsing RX URBs.
+ */
 static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 {
 	struct usb_cdc_ncm_nth16 *ncmh;
-- 
2.45.1


