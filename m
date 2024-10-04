Return-Path: <netdev+bounces-132174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7097B990A7E
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C635282D0D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B661DAC83;
	Fri,  4 Oct 2024 17:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from EX-PRD-EDGE02.vmware.com (EX-PRD-EDGE02.vmware.com [208.91.3.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35811DAC81;
	Fri,  4 Oct 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.91.3.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064708; cv=none; b=oJ7tRp6XQxjvZmRdjlfBb1221OeoWk71RZnA5YZzbzaWu+H6uLOgLANVKqXyX6FYCbhszf3v8y5onHO9zmfI0roPop20/gWQ6RKP4gLYmZyfeWXR8/XFTUlEd/5tn8etzuapwXGfEangLhEU4DUt9U5JZCtSuAtkX91rXEWtaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064708; c=relaxed/simple;
	bh=82Q7svt3R4M4yC3bhbWJtKCF34dSkGAdVUDAFHdGfxU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRrg9B30drVvBOpnyVp6yAslYkQXxaSSWnFEGTCGbJkNFSR7iTAYXPyQtYzcTUkjjabfCvOQQQr0YGb/PaZg3X2JL0RuCsgQ+yexyOdkIAOc/tD8mQgIv3CQtYb/BmMLwgUVSFB8D4sBjvk7x1vcgjKJ+DmOxK9ZKe8RzuiNOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; arc=none smtp.client-ip=208.91.3.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX-PRD-EDGE02.vmware.com (10.188.245.7) with Microsoft SMTP Server id
 15.1.2375.34; Fri, 4 Oct 2024 10:42:09 -0700
Received: from htb-1n-eng-dhcp122.eng.vmware.com (unknown [10.172.6.252])
	by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 9A21926071;
	Fri,  4 Oct 2024 10:43:07 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: <netdev@vger.kernel.org>
CC: Ronak Doshi <ronak.doshi@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 net-next] vmxnet3: support higher link speeds from vmxnet3 v9
Date: Fri, 4 Oct 2024 10:43:03 -0700
Message-ID: <20241004174303.5370-1-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: SoftFail (EX-PRD-EDGE02.vmware.com: domain of transitioning
 ronak.doshi@broadcom.com discourages use of 10.113.161.72 as permitted
 sender)

Until now, vmxnet3 was default reporting 10Gbps as link speed.
Vmxnet3 v9 adds support for user to configure higher link speeds.
User can configure the link speed via VMs advanced parameters options
in VCenter. This speed is reported in gbps by hypervisor.

This patch adds support for vmxnet3 to report higher link speeds and
converts it to mbps as expected by Linux stack.

Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
---
Changes in v1:
  - Add a comment to explain the changes
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index b70654c7ad34..6793fa09f9d1 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -201,6 +201,14 @@ vmxnet3_check_link(struct vmxnet3_adapter *adapter, bool affectTxQueue)
 
 	adapter->link_speed = ret >> 16;
 	if (ret & 1) { /* Link is up. */
+		/*
+		 * From vmxnet3 v9, the hypervisor reports the speed in Gbps.
+		 * Convert the speed to Mbps before rporting it to the kernel.
+		 * Max link speed supported is 10000G.
+		 */
+		if (VMXNET3_VERSION_GE_9(adapter) &&
+		    adapter->link_speed < 10000)
+			adapter->link_speed = adapter->link_speed * 1000;
 		netdev_info(adapter->netdev, "NIC Link is Up %d Mbps\n",
 			    adapter->link_speed);
 		netif_carrier_on(adapter->netdev);
-- 
2.11.0


