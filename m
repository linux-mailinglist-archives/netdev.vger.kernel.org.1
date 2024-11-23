Return-Path: <netdev+bounces-146923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7458A9D6C47
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 00:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC101B216FA
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 23:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880D21AAE28;
	Sat, 23 Nov 2024 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="Fi2oAJKJ"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C45198E7B
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732406129; cv=none; b=Fty8vjoZ+PFZj4WgtJwaEtMXH8jb9tEH1jARvtJfXiCW5gGFgo0AMiD3bYki3y1DAODeDgZwQglI0tDjxWo5aDryTQqGCl+1WFg2cvAnm7NBjrBcsiQ8lPVMwlrL1k86XTlAVVaVkPuirEhiJjEEadNwiaiTXaMzz8DiLUPquDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732406129; c=relaxed/simple;
	bh=1HzHn8mPky2y7uM1dLkqc3wa/hd6LwgPbDLZVE5ggOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiWgZhbB5jXfUeacdcwvXs8OqzYTi+yQbEHNUhSzosR/9Ewl03cEk8BQcEDHOMwgJSdY+pKhaYME1pMEl9c2FlXRt9e9J7Kja3l75rKnz+P4UZCZALGWKkG3E3tNDnKBtJNmj73t6XvN4M/QNVgLxdlVPxVucrdnvG6+KYMVgms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=Fi2oAJKJ; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1732406127; bh=MpSWz+5ERIrifCs4KMNySygiKsVPGa3ccAhJpp7M/ps=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=Fi2oAJKJWVbTx8eZ5H37gMQik93kRg4raMYtshct8WSimBnIqE+BQNINJRO9sIWUF
	 7oS7mSn29iOg2IqHZim2A8fuII5o0lQxwwYmeIH2VzH1cHowW33uklP8O1DX3/nABy
	 jI6HFsvipnxY8OIcb5j5AqEbG8ag5uuzAuJnFQWon48wxT9lImVNlreeYgYGkg0aWK
	 7O0whjfb/EOUF3GuJvDVQzED9UBDTdHTkvJDlmAXRCukfnbS5X8K4zu0e4cBZ9uYL5
	 9pRC0b4q1fRSDKjDXnK+MYAaIVdpnGyppMQ9ITvdOt5HRt2h6Kz3s34b07ftKUc+IG
	 keO2/iYBJi5Sg==
Received: from fossa.se1.pen.gy (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 596B0A0175;
	Sat, 23 Nov 2024 23:55:22 +0000 (UTC)
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
Subject: [PATCH net v3 3/6] usbnet: ipheth: check that DPE points past NCM header
Date: Sun, 24 Nov 2024 00:54:29 +0100
Message-ID: <20241123235432.821220-3-forst@pen.gy>
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
X-Proofpoint-GUID: m-uMfCjaxZBRV6aylzxpaEfnAa8h-LFz
X-Proofpoint-ORIG-GUID: m-uMfCjaxZBRV6aylzxpaEfnAa8h-LFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-23_19,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=481 malwarescore=0 clxscore=1030 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411230200

By definition, a DPE points at the start of a network frame/datagram.
Thus it makes no sense for it to point at anything that's part of the
NCM header. It is not a security issue, but merely an indication of
a malformed DPE.

Enforce that all DPEs point at the data portion of the URB, past the
NCM header.

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


