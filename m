Return-Path: <netdev+bounces-155223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C405DA0179A
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B44188427F
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C1035957;
	Sun,  5 Jan 2025 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="ev/RzBbr"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C62628D
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038927; cv=none; b=WbIUkuzivSgwnbXHYI3akpfyIf4Ltj749XILtC+F8UaFi6PhcSQ+uZJy7X1D8Y8+W5/DMBlKzvPa1JeEz5CcrVRdvUSS0ssJFck+yXW7CMaHygNYRlDAPEhdDD0I8k+jEJVJuzVHR1dnTL0VB836LFM8Dw2NOx4UEo0iQ3p05Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038927; c=relaxed/simple;
	bh=v48SwYQToZkEEuFw38f6V78gYlZ0/JB0VB4uCu3g/6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5dK1rDvnAQqC3dCpD6LtdWeJ8wFfkEr/7aihMCPksqHWXV2+Imp/Suqzw+zKC5Dvk7rtauW3319aJdH5iK/aiYsESiTw33K3GVxcq4DgR0o6RGFPagRKIZDdGlQWEgipU/a7Qc8TJfFJV3uOkZmIryW7gnJQOqHeQnwCgFhNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=ev/RzBbr; arc=none smtp.client-ip=17.57.155.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1736038924; bh=UBQCEhKGnnf26A1CQv5YwjWX3q/4vt5KvKPq9EdLqT4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=ev/RzBbrm5Qd0/4504Zt1/Bgy2VQdTzJJajWaYf4sSHv51wZt92pc33QFGIayUbe8
	 fRbiRUU17Wpd7RZgS64gjKtLstS7Im72EizQkxkp1uUBIGfnzdChw22DlEEYb9PrM1
	 qCR0mNBy5qujDzFjN4nWDuQuP9FNRIu0Kc3dK79//Wbp75P5fcFmAZA1I5PKNVMXp8
	 CDXfDM/LdCpEcVhT8UsMyQEsLKsAn2m+EL38GvWwOlBmTzk9VGSXCiXO6SSb1OvuWo
	 vtX5l9B+HUqGcFp5C8oyuSUjx7kAwDKTW/djT0qC2LNGYO9XXPTUhemDlwWgaBAgpi
	 WkM5Ie+kLHxIQ==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id A9EB94E4030D;
	Sun,  5 Jan 2025 01:02:00 +0000 (UTC)
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
Subject: [PATCH net v4 2/7] usbnet: ipheth: fix possible overflow in DPE length check
Date: Sun,  5 Jan 2025 02:01:16 +0100
Message-ID: <20250105010121.12546-3-forst@pen.gy>
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
X-Proofpoint-GUID: gs-J8ilmDYTYXLzeDW4-0ncSSaxOu_Ws
X-Proofpoint-ORIG-GUID: gs-J8ilmDYTYXLzeDW4-0ncSSaxOu_Ws
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=661 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501050007

Originally, it was possible for the DPE length check to overflow if
wDatagramIndex + wDatagramLength > U16_MAX. This could lead to an OoB
read.

Move the wDatagramIndex term to the other side of the inequality.

An existing condition ensures that wDatagramIndex < urb->actual_length.

Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
Signed-off-by: Foster Snowhill <forst@pen.gy>
---
v4:
    No change since v3.
v3: https://lore.kernel.org/netdev/20241123235432.821220-2-forst@pen.gy/
    Split out from a monolithic patch in v2 as an atomic change.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
---
 drivers/net/usb/ipheth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 2084b940b4ea..4b590a5269fd 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -254,8 +254,8 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 	while (le16_to_cpu(dpe->wDatagramIndex) != 0 &&
 	       le16_to_cpu(dpe->wDatagramLength) != 0) {
 		if (le16_to_cpu(dpe->wDatagramIndex) >= urb->actual_length ||
-		    le16_to_cpu(dpe->wDatagramIndex) +
-		    le16_to_cpu(dpe->wDatagramLength) > urb->actual_length) {
+		    le16_to_cpu(dpe->wDatagramLength) > urb->actual_length -
+		    le16_to_cpu(dpe->wDatagramIndex)) {
 			dev->net->stats.rx_length_errors++;
 			return retval;
 		}
-- 
2.45.1


