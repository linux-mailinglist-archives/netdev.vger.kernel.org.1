Return-Path: <netdev+bounces-155228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA022A017A3
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2731883E80
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B562C125;
	Sun,  5 Jan 2025 01:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="hDmST1Jc"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D97081D
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038944; cv=none; b=CAk2INh4UrPgb1zBvSIu0vfoDYxBSiyc67QD54HpLGQE+3eDFTX790QK0UkDmfDDdDyRSRx7mN21dB8gE/0G+3vGtLlwsfSdNTuEOH4FYgeNRdG8/uCCtE/ectwAuyC+vtrLrzCByrzE1HwlHIYbaD0iNCkdUi2epRxa3JBs+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038944; c=relaxed/simple;
	bh=7be0LKI8J6P79iL2Z6CX4v1J7IZCLTyouES9PtvD490=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuF6Ip5lX2KsYRx7eWgo0TKZCuSJETTZUMgm1UgELfua0jYwR4RaFqlo3QDVb+xbwzs8kZ3SAVBdVkrIFzHHAdJH/eX/nH+6DG4dQQsitjBUZHen6ohDn9wSk79V3xVbsh6HR/p1BQ9YjsoGxGVw+OsL8+uSfIKlA+gHnZcekLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=hDmST1Jc; arc=none smtp.client-ip=17.57.155.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1736038941; bh=zcmrmEqKEMywVUX7+JCLUV11PBm/zi7E6GUyhzlfy34=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=hDmST1JcAOXvECHYQLmgaacormVJqC+5gVephqFyPisinEZYOHGC6KGecbFYJg769
	 ZPfCqFjoM8UwdILLUR1Pkd4NE4ffecFVHp3LE0AXsLo6lSaTIdnjEPySr8QfTM+vuJ
	 4XrQ0VqEfcQeSRa8dzkzw7xAynGCX2T2ECpx9M+C4jrIZ0IFbDV0mWm7HOQGnkJ0cZ
	 bvl9L0SCsjclkb/i+tGKrQIhmLx44BSyw2RVa5O88ZJPeK4j0fZ4xU3LdGnMpu+IdM
	 o42dvFYptkH2mNy424k/tGYQmzBbZYgg4RjElmb8XOA9h7/Cn2+k5FrOKlJtncHh0f
	 Gwm/Xm6FdBmMA==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id 2AFEB4E40252;
	Sun,  5 Jan 2025 01:02:17 +0000 (UTC)
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
Subject: [PATCH net v4 7/7] usbnet: ipheth: document scope of NCM implementation
Date: Sun,  5 Jan 2025 02:01:21 +0100
Message-ID: <20250105010121.12546-8-forst@pen.gy>
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
X-Proofpoint-GUID: YLcBdPzalQ8M7NOmGtUvNfCdHpnFO_R1
X-Proofpoint-ORIG-GUID: YLcBdPzalQ8M7NOmGtUvNfCdHpnFO_R1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=948 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501050007

Clarify that the "NCM" implementation in `ipheth` is very limited, as
iOS devices aren't compatible with the CDC NCM specification in regular
tethering mode.

For a standards-compliant implementation, one shall turn to
the `cdc_ncm` module.

Signed-off-by: Foster Snowhill <forst@pen.gy>
---
v4:
    No changes.
v3: https://lore.kernel.org/netdev/20241123235432.821220-6-forst@pen.gy/
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
index 5347cd7e295b..a19789b57190 100644
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


