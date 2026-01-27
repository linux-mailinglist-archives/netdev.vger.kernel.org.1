Return-Path: <netdev+bounces-253920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP/nLXzYeGmftgEAu9opvQ
	(envelope-from <netdev+bounces-253920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:23:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5550B969BD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8A75305DB43
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5F43644DE;
	Tue, 27 Jan 2026 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="HEQ1Qa3D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C135F8B1;
	Tue, 27 Jan 2026 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526779; cv=none; b=loF8JQ5XUzoyqDLN3nc9Ib+CaT+Yg1rhJhuL8NsegYcZT++PxfQif7IcLlOM8QnJGYj03togNO11nGHKHwr+ljza53qBsqCS3g6+acKp/zgtCrhIPE9UQkI4UEMfJUbrhHqy+S4LE9IbDdxetZLgdtUkK3+dqYunQrAfNNsfGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526779; c=relaxed/simple;
	bh=dMB145a7yMhOOQBd500anVWAgo8E3r+vL2gn4Qbd7ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kg8Qnk0s5Gs1nIxI7QbG3tOulh7mWD838AW/rTfE9Wz4d0jyGTbKMvm9uz92ZWbNkXUvt8TcuvMqe47CCtnPBsRh0GTW8yNvUztfUM05sBVGDhWYGL9apLnNnfc1XuWxT7wDoyeP+7xw73jIn0npkI7rNQWJ2MoBveDxyBLVN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=HEQ1Qa3D; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 32272e8f0;
	Tue, 27 Jan 2026 23:12:53 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jianhao.xu@seu.edu.cn,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	marco.crivellari@suse.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net v3 2/3] net: liquidio: Fix off-by-one error in VF setup_nic_devices() cleanup
Date: Tue, 27 Jan 2026 15:12:40 +0000
Message-Id: <20260127151241.1144039-3-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127151241.1144039-1-zilin@seu.edu.cn>
References: <20260127151241.1144039-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c0003c87803a1kunmaea0ca6058ce9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0oZVkpOTUNLQ0oYShpPQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=HEQ1Qa3DA+mhBv/ToqIpSeJ1qwbAuFXgYzEFwzJAHOU6Bw3Xs9jnKmERtV0l7L7BLBeD+Kjv4yChF9Dy2ol7l3ZdWvWqPOnyKBwRr7SHfQaEnahzDQiObLB31IOnfbGeIDsERWKNUJmfxsBhnk4AK1m2HDAk8yKVYVhHGpcXHGM=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=p4sgQiaqSyqHzCtFus3lKv0CQYdeiD7QQJX5j8ux/Rw=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253920-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,seu.edu.cn:dkim,seu.edu.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5550B969BD
X-Rspamd-Action: no action

In setup_nic_devices(), the initialization loop jumps to the label
setup_nic_dev_free on failure. The current cleanup loop while(i--)
skip the failing index i, causing a memory leak.

Fix this by changing the loop to iterate from the current index i
down to 0.

Compile tested only. Issue found using code review.

Fixes: 846b46873eeb ("liquidio CN23XX: VF offload features")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index e02942dbbcce..050f9feb0b4a 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -2212,10 +2212,11 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 
 setup_nic_dev_free:
 
-	while (i--) {
+	while (i >= 0) {
 		dev_err(&octeon_dev->pci_dev->dev,
 			"NIC ifidx:%d Setup failed\n", i);
 		liquidio_destroy_nic_device(octeon_dev, i);
+		i--;
 	}
 
 setup_nic_dev_done:
-- 
2.34.1


