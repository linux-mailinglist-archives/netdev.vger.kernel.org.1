Return-Path: <netdev+bounces-160939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 432B4A1C5E8
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 00:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1A63A8BC7
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 23:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5220A5F3;
	Sat, 25 Jan 2025 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="uZ7qRFSP"
X-Original-To: netdev@vger.kernel.org
Received: from ci74p00im-qukt09081901.me.com (ci74p00im-qukt09081901.me.com [17.57.156.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BF20A5ED
	for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737849305; cv=none; b=I50gjoQEBcXtqjP2Hcb6mUq33A0imVpru6BTYjNjAbUAS+cEK4F7qdPLx8RSWopeHBHdD1HVoTdztM4pEq3iYwQdokNMEZgodgdR8QuBZZ37Yhd/+MwFHzr3thP5ncKlk/WjHvGleo1YhzjFVbhMF5SEwEBINac3HzAztG9oiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737849305; c=relaxed/simple;
	bh=DGuO7TlKUa6pyOpfjBb+ApWsz3kZK2sk4PWVnQ94SeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lz9xeuUCI9okZxYK/KHalcXgM2xhiYYgRKKrP6sYcdRDrwjltrUBqKt/lc2kyJh26XetLNs/PT1YWRCQlEABbsvRkbKCNVaNvH2hL9lzhpD7GFt4YQv3UBRjwESHzFiTffLNjKm0zmQXeUTK4X5GNqboSYLjhcB5/mvc28VITaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=uZ7qRFSP; arc=none smtp.client-ip=17.57.156.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	bh=bl4FRmnikIquDofpR5WYLZVKN0mG3Op/eGbhERBKyiI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=uZ7qRFSPy+E6F8ae6ELwd+VciXOygjWmKiFnxCVe4JlQLtoUJ6K8ex4ajMrp4hJR1
	 sG8qjJ/JsmJn1oFKZ3oo24/8FqR+zrSVvifH48obpbtnLlw6zsa5ntq454Gu+3MHf8
	 YMCKNwDOqrZoEh4mPSn5T/VycYqxArJIPLkTBE4SQrmMdGI8TrAeLQpHEVkZjHd+1P
	 nPFsP3Z/E8GoWuSluNwETwNnmDzVln3UcGoYFfSgyjPj6NfBO1I41iX9J6uh3vhyMM
	 5ow1m3m7vkH0uXJpXjSLoGAnbFPF7W+dDAweglE0SiEZIR+eBlYVrhQ1qqWyK48Upe
	 sbCy9Qbyeumfw==
Received: from fossa.se1.pen.gy (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09081901.me.com (Postfix) with ESMTPSA id 428DD5AC01E7;
	Sat, 25 Jan 2025 23:54:59 +0000 (UTC)
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
Subject: [PATCH net v5 6/7] usbnet: ipheth: fix DPE OoB read
Date: Sun, 26 Jan 2025 00:54:08 +0100
Message-ID: <20250125235409.3106594-7-forst@pen.gy>
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
X-Proofpoint-ORIG-GUID: kt6AUo67MxJ0SkeWAqT_i0JtkgmaEmQt
X-Proofpoint-GUID: kt6AUo67MxJ0SkeWAqT_i0JtkgmaEmQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_11,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=734 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1030
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501250183

Fix an out-of-bounds DPE read, limit the number of processed DPEs to
the amount that fits into the fixed-size NDP16 header.

Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
Cc: stable@vger.kernel.org
Signed-off-by: Foster Snowhill <forst@pen.gy>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v5:
    No code changes. Added Cc to stable and Reviewed-by Jakub tags.
v4: https://lore.kernel.org/netdev/20250105010121.12546-7-forst@pen.gy/
    Split from "usbnet: ipheth: refactor NCM datagram loop, fix DPE OoB
    read" in v3. This commit is responsible for addressing the potential
    OoB read.
v3: https://lore.kernel.org/netdev/20241123235432.821220-5-forst@pen.gy/
    Split out from a monolithic patch in v2 as an atomic change.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
---
 drivers/net/usb/ipheth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 03249208612e..5347cd7e295b 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -246,7 +246,7 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 		goto rx_error;
 
 	dpe = ncm0->dpe16;
-	while (true) {
+	for (int dpe_i = 0; dpe_i < IPHETH_NDP16_MAX_DPE; ++dpe_i, ++dpe) {
 		dg_idx = le16_to_cpu(dpe->wDatagramIndex);
 		dg_len = le16_to_cpu(dpe->wDatagramLength);
 
@@ -268,8 +268,6 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 		retval = ipheth_consume_skb(buf, dg_len, dev);
 		if (retval != 0)
 			return retval;
-
-		dpe++;
 	}
 
 rx_error:
-- 
2.45.1


