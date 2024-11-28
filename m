Return-Path: <netdev+bounces-147787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B0B9DBCAE
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 20:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22781624F2
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBC61C302E;
	Thu, 28 Nov 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYqTaA7l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DF1C231D
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822996; cv=none; b=n2PjqEmOn8Q9UQKC8GomGmLWa10Uilqx8XP2G7mx6uuHxNpk/qVS9ryF5yMqPVBDmUieAZLZRV8ciUkNhjm/yL7lLN7R3OTHwSDZyeBUHSS8VhiQeIesdAKIJpsIqq8oFkYnWeQ374Es38oxvQnKkP2gIvzf2jLwIDQtD4odENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822996; c=relaxed/simple;
	bh=VaTHl5CWYXaEUg5GJy076IuF06Ppro6TIwGO5pxBuO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WTCwQnvzJ5Q+uEwPIZpyWTT/4Y8v3PjkEmVRzwqp+b6hjGixxvkahNMQFX/B4i1GujGcAAnorzWoWtJRye0iCkW7aq9zGmMZ6S0ZTie5Gc0D+5WIp4FYDLiaywSa5PSLZQxdARp/+AfeYN4/KFIHrfghoxzSPrBvG+cZdHFRZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYqTaA7l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732822993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PGHdr5xe6OO2VfVdzoKzmBYzOtEMeKKpC50tlN0vOu0=;
	b=FYqTaA7ltxX7VfLkNB+1VOmt36SgJsBUkgDpNjV7+HxiqYWB3BxoEfkl/LYvBj2l9c1uFS
	HcuTxN3aFs+Z99yxWEbGmdDXUY2hnMyxheGGTpDB/IsXZwoPnWjj5I7jnytPTzCRlJwHCi
	hYi0QzxgXaTWhonp7T1P94znBo2cPfQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-pQL-K4C2OSu2dQbquJMVrw-1; Thu,
 28 Nov 2024 14:43:10 -0500
X-MC-Unique: pQL-K4C2OSu2dQbquJMVrw-1
X-Mimecast-MFC-AGG-ID: pQL-K4C2OSu2dQbquJMVrw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF1651954197;
	Thu, 28 Nov 2024 19:43:04 +0000 (UTC)
Received: from starship.lan (unknown [10.22.88.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7ECDB195605A;
	Thu, 28 Nov 2024 19:43:01 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Leon Romanovsky <leon@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: mana: Fix memory leak in mana_gd_setup_irqs
Date: Thu, 28 Nov 2024 14:43:00 -0500
Message-Id: <20241128194300.87605-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Commit 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
added memory allocation in mana_gd_setup_irqs of 'irqs' but the code
doesn't free this temporary array in the success path.

This was caught by kmemleak.

Fixes: 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index e97af7ac2bb2..aba188f9f10f 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1375,6 +1375,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	gc->max_num_msix = nvec;
 	gc->num_msix_usable = nvec;
 	cpus_read_unlock();
+	kfree(irqs);
 	return 0;
 
 free_irq:
-- 
2.26.3


