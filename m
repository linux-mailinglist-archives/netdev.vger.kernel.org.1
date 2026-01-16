Return-Path: <netdev+bounces-250488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCFED2E690
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 10:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C69A30C9CF2
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F53128AE;
	Fri, 16 Jan 2026 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QOuHqid2"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-101.ptr.blmpb.com (sg-1-101.ptr.blmpb.com [118.26.132.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF012940D
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553954; cv=none; b=Cj3fkpD8oE51rbQjJPq/no938QpB+aP62h/cQJW/J9635J9trU4oRStgsCiSCvbdD55xbAyv/fczf6VgV+3vDn8TRORrAlbn8tZxc7oJ6YiW5HsLmB1JsZrtV1kbcMs5ZteWvmkWsD8ahP8drzewmGMGNZSOLMPnzvuJNUD4NIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553954; c=relaxed/simple;
	bh=QkEqfAg81XmgEjIb9AsSjt2DNUAJVx30o5YbwK7ya4s=;
	h=Mime-Version:Message-Id:Date:From:Subject:Content-Type:To; b=AYrW1HywygrfISFQM1+H/8o2YMBIQFMHAh8u2Em/qwDWb98PFF9P+QX4SAZamfbKOLTRQ/o/13f06vqDzoBaG9siMU/E3s+VCiNHr5iGZHVO3A8L1CI9GqRzawTapE1uxertW8QgQc9ShGxsGjUO6wLx9ZuV3pMpkqhp2LwATX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QOuHqid2; arc=none smtp.client-ip=118.26.132.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1768553934; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=8AaJtUtjIptHEHqur2hwHmgGsdGdRM/pF4MvVTWiJ7U=;
 b=QOuHqid2S/GuMdy4mpAApcosveXApq0h0jppyPc1TE2nQECNsZHk/99JIFITe4Uz7EN1+K
 fDRSlypygFOACqwNUTgDqZ3tF0jzEK4mg7x4cxeBtPZZwTYvgLrcJS7MahBOieFZ3otgqo
 Ubu38F/UobLoVHyRvb6FrdAaylGWugbyE5ypcAZV8FFFf480Owv9yfPxbBnxqc5G8/fLYg
 MkLkJ0Hr0t4joD4CGuT+tmlvpqJUethxDwbHHOPXyegNQWmSlpTf5tTJz91WIxo9VFGGKc
 UBdkESJ36PPjt6QCvTv+9fsBVbAE4Y844FfI/NyzeOC8ROPIxw707mSQFjrKiw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260116085840.1946398-1-zhangjian.3032@bytedance.com>
Date: Fri, 16 Jan 2026 16:58:39 +0800
X-Mailer: git-send-email 2.20.1
X-Original-From: Jian Zhang <zhangjian.3032@bytedance.com>
From: "Jian Zhang" <zhangjian.3032@bytedance.com>
Subject: [PATCH net-next v2 v2 1/2] net: mctp-i2c: notify user space on TX failure
Content-Type: text/plain; charset=UTF-8
To: "Jeremy Kerr" <jk@codeconstruct.com.au>, 
	"Matt Johnston" <matt@codeconstruct.com.au>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>
X-Lms-Return-Path: <lba+26969fdcc+9254ee+vger.kernel.org+zhangjian.3032@bytedance.com>

Report local transmit errors from the MCTP I2C transport using
sock_queue_err_skb(), allowing the socket layer to be notified
of failed transmissions.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
Changelog v2:
- use sock_queue_err_skb() instead of sk_error_report()
- link to v1: https://lore.kernel.org/all/20241108094206.2808293-1-zhangjian.3032@bytedance.com/

 drivers/net/mctp/mctp-i2c.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index f782d93f826e..f6e329b66240 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -24,6 +24,7 @@
 #include <linux/if_arp.h>
 #include <net/mctp.h>
 #include <net/mctpdevice.h>
+#include <linux/errqueue.h>
 
 /* byte_count is limited to u8 */
 #define MCTP_I2C_MAXBLOCK 255
@@ -477,6 +478,23 @@ static void mctp_i2c_invalidate_tx_flow(struct mctp_i2c_dev *midev,
 		mctp_i2c_unlock_nest(midev);
 }
 
+static void mctp_i2c_report_error(struct sock *sk, struct sk_buff *skb, int rc)
+{
+	struct sock_exterr_skb *serr;
+
+	skb = skb_clone(skb, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	serr = SKB_EXT_ERR(skb);
+	memset(serr, 0, sizeof(*serr));
+	serr->ee.ee_errno = -rc;
+	serr->ee.ee_origin = SO_EE_ORIGIN_LOCAL;
+
+	if (sock_queue_err_skb(sk, skb))
+		kfree_skb(skb);
+}
+
 static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 {
 	struct net_device_stats *stats = &midev->ndev->stats;
@@ -537,8 +555,11 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 		rc = __i2c_transfer(midev->adapter, &msg, 1);
 
 		/* on tx errors, the flow can no longer be considered valid */
-		if (rc < 0)
+		if (rc < 0) {
 			mctp_i2c_invalidate_tx_flow(midev, skb);
+			if (skb->sk)
+				mctp_i2c_report_error(skb->sk, skb, rc);
+		}
 
 		break;
 
-- 
2.20.1

