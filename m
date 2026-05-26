Return-Path: <netdev+bounces-291648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMJuAYd2FWrHVAcAu9opvQ
	(envelope-from <netdev+bounces-291648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:31:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 124BE5D4331
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C027C3008D1C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3E13DC4B9;
	Tue, 26 May 2026 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXotgQgG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534B3D7D61
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791489; cv=none; b=aF18pWPByLkPiLAusto+H/ze7+LCn0FHGKmni4ZmsGRUGcFSvKA8EwGahKWlQYYdpkJmkI9jjDX9roeQQG0OXd55pkRorXL4ouXWrjgJee62UF7bsszvLiUcDdnaVEZUuAGHeDF8yOSnbTGTlswn0hZOy5WUbQbCa99wcqjq/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791489; c=relaxed/simple;
	bh=eCUSq0yXcaXdss2t/OeDizEGW7NgwIY3Wb6Ip4WJApU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdMLU1MG9B5DA98adJSRV/+6vLZDmLDBR2+KFyhUZ5sb0vpdZfisNBU+HQNaauKSMrxCoha4GHYlloZ0ccgQKAhJYKQbVQbTu9HsfWmaOhzt8MTro6ykHsDxzzqQE5fkirEBGaZcNP+9HS1ysaSY9gq5KBzimgTIoyu24ZNrQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXotgQgG; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-834f1075805so7961640b3a.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791488; x=1780396288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfqSqHtgE1ylnsRBAV2SrbX9MosYsTB5633n9D4BIkU=;
        b=TXotgQgGlg818BG1MVQ5mGx5cikQcvaZ3fJ6xCijgukH2KtIx/VLcHOoaZbm68uFq+
         vjiJZ96+vymtNq/E7u6MuW8BuiexCkZXZObF9PN3BctO/+4cCRAwpGWW3KG5/YPa2Wkl
         h/latoCiVZCqlD7q2i9miXiJNirUYOIQ+2ZRNttlx4YLVtAIeHHZY1WzaPoGWO0yQeVr
         0ZkRz9D/VCV+CokRCHFxgxdcjhyAWAyuD/R1+EW0BNa/7UEEHbpFdhrl3BHMzYYN7cdg
         kufgU2jvRnGxjSOQeRlv6rvfkdKOXDZq1FO32TKgTxQGLQK49nZFbkXI29CFbyKamCg5
         h6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791488; x=1780396288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfqSqHtgE1ylnsRBAV2SrbX9MosYsTB5633n9D4BIkU=;
        b=tH294pcErL6LUy292aU5iXX2dJ4WQGDFQgWYT+oIcYzddR2xPT4m9NCam+njqL2rdN
         x3SqaURzwtvG6GZ6Z01FV/5XoTbDTSQIKHbYDsWjKGYk4tH3/kjWiVIp6nFMZmJo4Pi1
         evrhL3gpt67GK27aunl73udri3Ebx83A/bgKPCb7mCDLIpyWZ8r/x9nH5aonfW6D2Kcq
         LPU7jR5SDjAaqaiqW5MPO3EpGAFoCRgBfqbOkPIhhwmLfFOZ7sHapCdJDHGQ6/gKuxtQ
         2GlWWEJFtwdihtF6ncgQQorE9eYFE9rsJ6Wp6PVnnCmDuoxKE9NAZquHZXLreX/ryqrX
         +eog==
X-Forwarded-Encrypted: i=1; AFNElJ94vBptPtug47zvdMbhwU1OkrAvebDe5v8iUF87nDJ0fNWAdYZ4a4SLrUhbZv4tIR5L/RSiUtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6inoG/m8JjZAWJyrR6h/D+GfzyfcIIB6EIA4MxILxlGqJ7gU
	urH1l1EUt+rKJ7+KE+YN1+TM2P1/XylFuPKBqSYqJmVrX2UOyn6jL7Xm
X-Gm-Gg: Acq92OHyNAbGWsSJOY52whZF7Eec7GoFMa/+n3+KES3jBSwiTcS9gP8K0lXLAsPgYZK
	P5yr/tFGOeQ9KBXRD2TD7P2OxHws7JKDuBXZPGjhtFhrNAU9ll2mju/H4OjQLnbnVEj2FiKfgnU
	0ogevZpTqBPEa8m1sOH0pLboJ1UubpF2DkLHx9LqKbQpjuYa51mPgJvqO7aAZYhr5REAM0Apbi7
	UoGOM5XReMdPceBP6hIcJ+Yfgtw7gvRlr7GESe3w5UftDOJrhn8ccqLiRYD/HIhFsnGGv+wr1cr
	Vv0lxSmV/hyvZ7K52f53qdNfISgVTqCgPm4STvgnK4xMuTfbrGEkKBZditAuKZXIqrh0SdBIRZJ
	aQIpH9dtx6wy4VdJ0SOzxBTQnQUR8cNFcvjbTuyqM4gu0IgseBsJmqVEvJPTfIpi4JGoDcUae/V
	ZBoalicAHSHxyHRY608t6KV0S86m7xA8aDUHsKfd6q8yGGNrKqAGpQULH6E5e7TuWbiODxlHfIq
	hynsqLPLQ==
X-Received: by 2002:a05:6a00:1822:b0:835:4776:7d69 with SMTP id d2e1a72fcca58-8415f38fd64mr17301068b3a.41.1779791487608;
        Tue, 26 May 2026 03:31:27 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fd80cdsm14276188b3a.49.2026.05.26.03.31.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:31:26 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: David Heidelberg <david+nfc@ixit.cz>,
	Jakub Kicinski <kuba@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH nfc] nfc: nci: fix double completion race in nci_data_exchange_complete
Date: Tue, 26 May 2026 18:31:21 +0800
Message-ID: <20260526103121.47957-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-291648-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,nfc];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 124BE5D4331
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nci_close_device() and nci_rx_work can both call
nci_data_exchange_complete() concurrently.  After commit 4527025d440ce8
("nfc: nci: fix circular locking dependency in nci_close_device") moved
flush_workqueue(ndev->rx_wq) after mutex_unlock(&ndev->req_lock),
rx_work is no longer serialized with the explicit completion call in the
close path.  Both callers read the non-NULL callback pointer and invoke
rawsock_data_exchange_complete(), which calls sock_put() -- but only one
sock_hold() was taken, so the second sock_put() underflows the refcount
and frees the socket while it is still in use.

Replace the bare clear_bit(NCI_DATA_EXCHANGE) with
test_and_clear_bit() so that only the first caller proceeds to invoke
the callback.

Fixes: 4527025d440c ("nfc: nci: fix circular locking dependency in nci_close_device")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 net/nfc/nci/data.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 5f98c73db5af..4253edea5c8d 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -46,11 +46,11 @@ void nci_data_exchange_complete(struct nci_dev *ndev, struct sk_buff *skb,
 	timer_delete_sync(&ndev->data_timer);
 	clear_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags);
 
-	/* Mark the exchange as done before calling the callback.
-	 * The callback (e.g. rawsock_data_exchange_complete) may
-	 * want to immediately queue another data exchange.
-	 */
-	clear_bit(NCI_DATA_EXCHANGE, &ndev->flags);
+	/* Claim completion atomically -- both close and rx_work may race here */
+	if (!test_and_clear_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
+		kfree_skb(skb);
+		return;
+	}
 
 	if (cb) {
 		/* forward skb to nfc core */
-- 
2.50.1 (Apple Git-155)


