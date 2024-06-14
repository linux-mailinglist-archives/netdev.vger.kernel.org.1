Return-Path: <netdev+bounces-103645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC97908DE4
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C528288688
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D8C121;
	Fri, 14 Jun 2024 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYkIX0+B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5EBE65
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376763; cv=none; b=Olkwr0xaGxi7Z65GFglW4pDhBlz6/yXjWlKA3fLjMLAoIxpY+ffk1K4b70K6xUx1x6xBeHKi/wYS8z2bbCro9tPh+V4zj8m+K0lLex/WzVC0ixw1fs89eD8dFEG/XOk6cXlWBkcRU0ZxxiZL3u/2GwP0nuO9R3GQ3TMOfQ+p9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376763; c=relaxed/simple;
	bh=rGIR/8k9eXv/gnpx3GqoAphOuvDbdQ/Y3p6Ynj9I6G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgsTBYzZ/y8sOPyhciHs2V1c1PqYENaRDBiHqJeJHCq2dL2Uh6TKOINNIKm1c/ZYd4Bi6XOLuJp+pN+YJOaAkIfE9y0hrlRRi4zDaBWlEeCaMaz2PyH+sh1yFd+/CMUVn0/MxfD4oKdbMnegsidKOYTsrM7Y2DKOrdwZnkAbx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYkIX0+B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718376760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w3Tj40xdXz1V8iDRdZxj++51q//lWoAPJZZ30wVGOuE=;
	b=VYkIX0+Bken7H41j/8C2/kwUtFMEXTWIWLaXbwOZPr52HNtAV4u34q64jynWhX3AotYOc6
	xxJn6yciizgsNWBbkJcFbLkAgChJ262mypG16thYOgExpyIkWGGjdcy5c11UpcZarMnANe
	+LwAttgjUAHhFZFpC8Kgu2MpZipG568=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-BtliFC6RPKmv5vHt8N8GMA-1; Fri,
 14 Jun 2024 10:52:37 -0400
X-MC-Unique: BtliFC6RPKmv5vHt8N8GMA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1F8619560B0;
	Fri, 14 Jun 2024 14:52:35 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.18.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75E923000219;
	Fri, 14 Jun 2024 14:52:34 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next] net: sun3lance: Remove redundant assignment
Date: Fri, 14 Jun 2024 10:52:31 -0400
Message-ID: <20240614145231.13322-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

There is no point in initializing an ndo to NULL, therefore the
assignment is redundant and can be removed.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/net/ethernet/amd/sun3lance.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/sun3lance.c b/drivers/net/ethernet/amd/sun3lance.c
index 246f34c43765..fe12051d8471 100644
--- a/drivers/net/ethernet/amd/sun3lance.c
+++ b/drivers/net/ethernet/amd/sun3lance.c
@@ -296,7 +296,6 @@ static const struct net_device_ops lance_netdev_ops = {
 	.ndo_stop		= lance_close,
 	.ndo_start_xmit		= lance_start_xmit,
 	.ndo_set_rx_mode	= set_multicast_list,
-	.ndo_set_mac_address	= NULL,
 	.ndo_validate_addr	= eth_validate_addr,
 };
 
-- 
2.45.2


