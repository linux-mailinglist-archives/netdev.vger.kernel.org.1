Return-Path: <netdev+bounces-253922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHl8OqXYeGmftgEAu9opvQ
	(envelope-from <netdev+bounces-253922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:24:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF65969F2
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26C9A3079612
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4F36607E;
	Tue, 27 Jan 2026 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="cBTbtAk0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75656366051;
	Tue, 27 Jan 2026 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526783; cv=none; b=DEi46EPImIdSZkWLN6GPvVVB4YZ5iMlZWKiSCUFdb4D2KGDfmmlducHsa9BjxeaMq8zEByJUG8jqpXq++s/pTRFQhTQ7YJ6bUfNOlTsPbnHGdAKz3joCicZm/fS04G7oYnZkVo8ue/LgaFNBJ3g38AvEuqEb0WO+bkwQEHie43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526783; c=relaxed/simple;
	bh=cIXqT5FnicbiGpytwx5r3gF/Cd0q8kd1fuH3bp8cggg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FdSFEcJbtgUyv1X0+q7iaCbZuJBmMakFeXsjZMDXZGrvNVEniB0vKeLrkM/f3EfX3uPkJNW7evgkmaM+IPTArTOPKsSIlz/UBqixlvLjGzn8RD7J9WEYOj+EowbCD2u7nX4YWhyIUDD0YVBO2+FViH/yaSInUu8VevYF6SCMNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=cBTbtAk0; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 32272e8ee;
	Tue, 27 Jan 2026 23:12:52 +0800 (GMT+08:00)
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
Subject: [PATCH net v3 1/3] net: liquidio: Fix off-by-one error in PF setup_nic_devices() cleanup
Date: Tue, 27 Jan 2026 15:12:39 +0000
Message-Id: <20260127151241.1144039-2-zilin@seu.edu.cn>
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
X-HM-Tid: 0a9c0003c22203a1kunmaea0ca6058ce6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHR4eVh0dH0hCHUNLHxkaHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=cBTbtAk0xhLj12HmCc3DtgaA7hCTolYl+2ZHbuavgHEYXHF6o1r3fo6W+tETmU4ecnhAbVcAMebjkXnwiRH9K9N2uHDwqP4qu1sds10pp8MUm9/nazJ5muohN6uJoJDSNy7yBbSDmsUlwJU/Ar1f+bYQ/OsEFtGSQl3WAuLa4jc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=0sd9aewjv4fvCJ9HVyUnkC7myYx922OsGGV1uHmx4Ww=;
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
	TAGGED_FROM(0.00)[bounces-253922-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,seu.edu.cn:email,seu.edu.cn:dkim,seu.edu.cn:mid]
X-Rspamd-Queue-Id: 7FF65969F2
X-Rspamd-Action: no action

In setup_nic_devices(), the initialization loop jumps to the label
setup_nic_dev_free on failure. The current cleanup loop while(i--)
skip the failing index i, causing a memory leak.

Fix this by changing the loop to iterate from the current index i
down to 0.

Also, decrement i in the devlink_alloc failure path to point to the
last successfully allocated index.

Compile tested only. Issue found using code review.

Fixes: f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 0732440eeacd..e9a728997689 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3750,6 +3750,7 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 	if (!devlink) {
 		device_unlock(&octeon_dev->pci_dev->dev);
 		dev_err(&octeon_dev->pci_dev->dev, "devlink alloc failed\n");
+		i--;
 		goto setup_nic_dev_free;
 	}
 
@@ -3765,10 +3766,11 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 
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


