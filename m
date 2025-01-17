Return-Path: <netdev+bounces-159151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049C4A1486F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 04:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2442C1669E6
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 03:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A971F63C7;
	Fri, 17 Jan 2025 03:13:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF801E2007;
	Fri, 17 Jan 2025 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737083632; cv=none; b=IC/UjPQqqA+Bc8lUKJSWfdaNy1ycmEl+/aE/PNaWOIQNrwjb/hF7QHjgYbKzvBp3euz+Pb+Vs2XfiHAExNt/KVgga4rv8D9UoIn3jT18hNbuhzaAQTEnbg6GM9gZZM7TvXi++oMv7Ija6Xzg3XIwcd2VOJx4yr6RzestHXIBLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737083632; c=relaxed/simple;
	bh=QxWMZbHvRHVAtwjmgXMCkNTFSXgB0fpvFQ2ZW1v/2dc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C8WMXnfxbWi3EeffcIcorH1fdscYpShjARBya327hrp+lakBOdXOeXJ7UpMvMDc0WniVPDyetbJPcgVKSO5JCh/tJNDlD62RGl135OPFqwH/tsW4xowS1TrRykiwVkPcd/TmqSELb27ZqjATm1hrFaz2C8Cz73vTYQ82oIgPQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id OUE00135;
        Fri, 17 Jan 2025 11:13:35 +0800
Received: from localhost.localdomain (10.94.16.224) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 17 Jan 2025 11:13:34 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <ayush.sawal@chelsio.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<atul.gupta@chelsio.com>, <werner@chelsio.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] crypto: chtls: Add check alloc_skb() returned value
Date: Fri, 17 Jan 2025 11:13:28 +0800
Message-ID: <20250117031328.13908-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025117111335812317183cb004884c5bceb49f553c23
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

alloc_skb() can return a NULL pointer on failure.But these returned
value in send_defer_abort_rpl() and chtls_close_conn()  not checked.

Fixes: cc35c88ae4db ("crypto : chtls - CPL handler definition")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 .../net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c  | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 6f6525983130..725cce34f25a 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -306,6 +306,10 @@ static void chtls_close_conn(struct sock *sk)
 	tid = csk->tid;
 
 	skb = alloc_skb(len, GFP_KERNEL | __GFP_NOFAIL);
+	if (!skb) {
+		pr_warn("%s: cannot allocate skb!\n", __func__);
+		return;
+	}
 	req = (struct cpl_close_con_req *)__skb_put(skb, len);
 	memset(req, 0, len);
 	req->wr.wr_hi = htonl(FW_WR_OP_V(FW_TP_WR) |
@@ -1991,6 +1995,11 @@ static void send_defer_abort_rpl(struct chtls_dev *cdev, struct sk_buff *skb)
 
 	reply_skb = alloc_skb(sizeof(struct cpl_abort_rpl),
 			      GFP_KERNEL | __GFP_NOFAIL);
+	if (!reply_skb) {
+		pr_warn("%s: cannot allocate skb!\n", __func__);
+		return;
+	}
+
 	__skb_put(reply_skb, sizeof(struct cpl_abort_rpl));
 	set_abort_rpl_wr(reply_skb, GET_TID(req),
 			 (req->status & CPL_ABORT_NO_RST));
-- 
2.31.1


