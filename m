Return-Path: <netdev+bounces-160934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A07A1C5DF
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 00:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEACE166195
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 23:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27AD20A5D1;
	Sat, 25 Jan 2025 23:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="qKS3FLIN"
X-Original-To: netdev@vger.kernel.org
Received: from ci74p00im-qukt09081901.me.com (ci74p00im-qukt09081901.me.com [17.57.156.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C222066E5
	for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737849285; cv=none; b=uYLuB4hQbN+xink1fG6ukMh2rGCSG9uGFvr+yFwy4PJYUd4imdWOAma5ORi71JjXuuqDL/+TZnOnC+vBKcXZf3hl9jwBqfZ8JnTKKix0cidoteuA2AsZLf+zyFnTN8+jg22MnYHq1mtjZgsNLyG4rz4gjB0lQ4CX27yk+gEou/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737849285; c=relaxed/simple;
	bh=bdjryjI9zyF2uXSXIVjyqdeV7IohiaYXfLNPmiiuY6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNTq/ay04qEVPm3mU5NZZV/qI0ZOi0k+XjPc0rqY8bSLwwEHEhejrYe2VGjMfgDOO2vL9bkQhdDiorJMySvyfYcDXdz7C5VKAYbjppwxsp64r4uMuo1jdkvm6mVMQvH+DJAk1yp4NcDwIBzgMuvxZl2iKJaPizWs5evOT7slnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=qKS3FLIN; arc=none smtp.client-ip=17.57.156.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	bh=NO3ktCMh3wSfaToy35Cacua85eQzHdak8/MTQl8j+kk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=qKS3FLINsGH9Pm3Prpxv8ksWC0begBeZRjiFW9j8Cm7tCW92mkXeSWt6MuJb/EcKZ
	 VTjvkksFZphgvb4TxLbN8DD5LAeJDvAcPxN1wqVcgt96P3QoNTsl+A9mVkKstHYW/8
	 3/9i8NoM61wZwvCTmPCXrPjZvIMdafW9Ld2b96Aln3U0iQ7Df20xJoY1RKwjCwqp/L
	 cLphiX6+xoBMIY/oUA8Unaj9V4qcUu4/bg/weJrpAv+OaSQSU6dZ5JbyokGWQuVQ+5
	 bNBE2IbXxcb8M6ckVe2eXzhOCVa7ABUQNKcRbfLb1V70YMWG1yg0eNINwv+ow/htuB
	 xAZK4vY5cH8yQ==
Received: from fossa.se1.pen.gy (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09081901.me.com (Postfix) with ESMTPSA id CEEB65AC0107;
	Sat, 25 Jan 2025 23:54:39 +0000 (UTC)
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
Subject: [PATCH net v5 1/7] usbnet: ipheth: fix possible overflow in DPE length check
Date: Sun, 26 Jan 2025 00:54:03 +0100
Message-ID: <20250125235409.3106594-2-forst@pen.gy>
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
X-Proofpoint-ORIG-GUID: UGb2UpjwBRa72tpLU-r3jJT9klJun5UK
X-Proofpoint-GUID: UGb2UpjwBRa72tpLU-r3jJT9klJun5UK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_11,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=647 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1030
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501250183

Originally, it was possible for the DPE length check to overflow if
wDatagramIndex + wDatagramLength > U16_MAX. This could lead to an OoB
read.

Move the wDatagramIndex term to the other side of the inequality.

An existing condition ensures that wDatagramIndex < urb->actual_length.

Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
Cc: stable@vger.kernel.org
Signed-off-by: Foster Snowhill <forst@pen.gy>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v5:
    No code changes. Added Cc to stable and Reviewed-by Jakub tags.
v4: https://lore.kernel.org/netdev/20250105010121.12546-3-forst@pen.gy/
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
index 46afb95ffabe..45daae234cb8 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -243,8 +243,8 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
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


