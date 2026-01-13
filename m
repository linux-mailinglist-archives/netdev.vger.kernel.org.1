Return-Path: <netdev+bounces-249580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD94D1B321
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F84301FFAA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E135EDD1;
	Tue, 13 Jan 2026 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="V/Rz3VlQ"
X-Original-To: netdev@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D962314B8C;
	Tue, 13 Jan 2026 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335931; cv=none; b=cGMwijmba80c5dY0PvPiyWm1yNaEy1H1Vkzij/c0odaBoCN19XPpAgV+zic7hzQ0H7FPbpxaVqq47aZ3SdMZwBmEwyLyxqeEMYSr4XLSCJVk2UVWd6nHdN3ylL9Vr9wPZZgL25Rp/H6xKJmnmR7XAoCpLzpTnVvye1LT6Pgg7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335931; c=relaxed/simple;
	bh=4Of0pXbEKRd6/roPjE9S3whSAywi0aAXU48qNwVbw0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXGvQPa+iOrAtXPxfzbwQQSZsrp9JnYARQ8C4DqasmzVhUaPJCDaLtxY+ZRDfNfjzBXVRbbZ6xrWbuqrc/MwXZ7VXSZ9pmL2hNpOWSWOkVRolYJQYPNgINsB2NZUcksGE70RpB+fIh6cLr1GgvneXDDevzIN85mXvAIfJbYHV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=V/Rz3VlQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xk1mjmbWrXmG0wBHXJxyTxVjJKuAglaxoz4eMNJyvvc=; b=V/Rz3VlQui4YIPQWc/3LMfdDxs
	M6g/KVllpIC16Z9mRvmF/hFxBAjWS/Q56VErNPYL4qvzEk5l+E6ZPoJDf+sSSsDZDjXLeLBQ4+jOf
	qRrdoSumFxqk90v/0vYq2qwrkrE0DWxfUGlXbBKQlRDrVlfM05qOJ6v8Zu/gxyeG5lEMy4bs6uzNt
	F/Xu8QfFUr3gfMVbDYoR7EEoLqsJP21uIFaBk0CPNY8F+XgtOKO0+kJpFnV4sBXBg118b6DuMExpv
	v3afaLDI9gpOAxRrFO5vJdCyfrnazdZcKm9j0geSTDdpYfCGk6xznbO/havbhWo4VH0qBxG/fnADc
	8wTw50Aw==;
Received: from 179-125-92-250-dinamico.pombonet.net.br ([179.125.92.250] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vfkx7-004zvf-OJ; Tue, 13 Jan 2026 21:25:22 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bongsu Jeon <bongsu.jeon@samsung.com>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH net] Revert "nfc/nci: Add the inconsistency check between the input data length and count"
Date: Tue, 13 Jan 2026 17:24:58 -0300
Message-ID: <20260113202458.449455-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 068648aab72c9ba7b0597354ef4d81ffaac7b979.

NFC packets may have NUL-bytes. Checking for string length is not a correct
assumption here. As long as there is a check for the length copied from
copy_from_user, all should be fine.

The fix only prevented the syzbot reproducer from triggering the bug
because the packet is not enqueued anymore and the code that triggers the
bug is not exercised.

The fix even broke
testing/selftests/nci/nci_dev, making all tests there fail. After the
revert, 6 out of 8 tests pass.

Fixes: 068648aab72c ("nfc/nci: Add the inconsistency check between the input data length and count")
Cc: stable@vger.kernel.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/nfc/virtual_ncidev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index 9ef8ef2d4363..b957fce83b7c 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -125,10 +125,6 @@ static ssize_t virtual_ncidev_write(struct file *file,
 		kfree_skb(skb);
 		return -EFAULT;
 	}
-	if (strnlen(skb->data, count) != count) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
 
 	nci_recv_frame(vdev->ndev, skb);
 	return count;
-- 
2.47.3


