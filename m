Return-Path: <netdev+bounces-145120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D49CD528
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985EA284A09
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BFB43156;
	Fri, 15 Nov 2024 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="te67Nzol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6763B9
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635291; cv=none; b=soMo3+a/HjOxp8hmBDPOGpmkg9BCLDsTs1neD8pZjqGJEKCGpg4ZLDj/UuTcGbozU7wCL8tkMo4JU2OOQLAqet3QH2TVFlROom4kSPVN+oTconsUdO/1TVIe+GHmEeCdw1LMhgJZ9Oa8pg8RtM/ZAVdgq4EDCU3EmSoIkcIEzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635291; c=relaxed/simple;
	bh=HgvV5xE6qEOFstn5OpN0rAnQ1tp2xgtwtx2zzjBPPqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oz8+pSfJBuwWjslb8OVIOEaWXMABUsAdhfHnebGJXtorsHcj65ufFvC+H3pOgZQ5c1UULjWcvuVg6byrCv0Y9FFarF+c3OGiMsCJKAVGJxkzaGSBQe+aE3fd4gr0KKBi613oWX4oIaVcmqhNcmAnwIZqWbdVJMXI9R5+x/Ge31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=te67Nzol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BFBC4CECD;
	Fri, 15 Nov 2024 01:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731635291;
	bh=HgvV5xE6qEOFstn5OpN0rAnQ1tp2xgtwtx2zzjBPPqM=;
	h=From:To:Cc:Subject:Date:From;
	b=te67NzolkzscDGy3eBCLgEVN0uhqeTsoddXpKykzLd9q6HMZExfoDb2sQjeUHAzQr
	 8QrBh//qcE/Yqox0vQrpErsFLddak9EYCmIrA0BZyjBGGCY1zIkySiO+WcVUvKiaOR
	 ZE3GUx4A3tyjZtZxabZwFpi9axUTRwb3XcyP0fC8/fNyYH40EjT8uUG51eTVQkviLz
	 O1VyX6oCisZ57vIwPQEAUtGWKanry7BEzmDRv+smriVZJ8tA1aqtLgl9cxNerJDp/E
	 q58PVD38GaEMLo7PGLIl0K2l8IUiioCmFhBuG1EDy4wTfwc/pgr99/RyUNn9P05JH4
	 u3ZWj/ex8Hmow==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	kernel-team@meta.com
Subject: [PATCH net] eth: fbnic: don't disable the PCI device twice
Date: Thu, 14 Nov 2024 17:48:09 -0800
Message-ID: <20241115014809.754860-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use pcim_enable_device(), there is no need to call pci_disable_device().

Fixes: 546dd90be979 ("eth: fbnic: Add scaffolding for Meta's NIC driver")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexanderduyck@fb.com
CC: kernel-team@meta.com
---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index e110c2ceafcf..32702dc4a066 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -334,7 +334,6 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 free_irqs:
 	fbnic_free_irqs(fbd);
 free_fbd:
-	pci_disable_device(pdev);
 	fbnic_devlink_free(fbd);
 
 	return err;
@@ -367,7 +366,6 @@ static void fbnic_remove(struct pci_dev *pdev)
 	fbnic_fw_disable_mbx(fbd);
 	fbnic_free_irqs(fbd);
 
-	pci_disable_device(pdev);
 	fbnic_devlink_free(fbd);
 }
 
-- 
2.47.0


