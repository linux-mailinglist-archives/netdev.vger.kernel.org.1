Return-Path: <netdev+bounces-128746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0F97B603
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 01:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14311F24FD3
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 23:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA80174EFA;
	Tue, 17 Sep 2024 23:15:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from EX-PRD-EDGE02.vmware.com (EX-PRD-EDGE02.vmware.com [208.91.3.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA57158D6A;
	Tue, 17 Sep 2024 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.91.3.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726614912; cv=none; b=Y6Z9sfJhmtYD+K1A2r+dIcgl0tya5m5lrkUI+DFHmpFEAVhoowCFY67VIyxQhJzHIAUAQ3jMDi2RzDG2bPgN/Us4bO3S5qDN8wuWG03ooXfW5fm6P5VuJA0l9HOOl2CAd4nmO7+5jxvArUes1WNRdUjGkOvSjt21X5t19Eq6ypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726614912; c=relaxed/simple;
	bh=j7/oWfb/LNMvzAvE1sJqEkfjlf4b9qxffkaD5ATBRJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ImTsOl7nXKRD7SYCYLvPhejDz3fLcSR0zfDp+sSWFj54W6E0D+0eN0iNFuz5E8VqHvlNg8pOcr7vAmcRGwVnwU4YbYVpGiAzFc1ESP8iIxULPdLbqYHcCjUHTXblR1TvUAanWzEZkdVD8tK798CjqAtkutoLrq4ZcKvu/TwXFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; arc=none smtp.client-ip=208.91.3.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from sc9-mailhost1.vmware.com (10.113.161.71) by
 EX-PRD-EDGE02.vmware.com (10.188.245.7) with Microsoft SMTP Server id
 15.1.2375.34; Tue, 17 Sep 2024 15:59:06 -0700
Received: from htb-1n-eng-dhcp122.eng.vmware.com (unknown [10.172.6.252])
	by sc9-mailhost1.vmware.com (Postfix) with ESMTP id C8A0B20346;
	Tue, 17 Sep 2024 15:59:50 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: <netdev@vger.kernel.org>
CC: Ronak Doshi <ronak.doshi@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] vmxnet3: support higher link speeds from vmxnet3 v9
Date: Tue, 17 Sep 2024 15:59:46 -0700
Message-ID: <20240917225947.23742-1-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: SoftFail (EX-PRD-EDGE02.vmware.com: domain of transitioning
 ronak.doshi@broadcom.com discourages use of 10.113.161.71 as permitted
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
 drivers/net/vmxnet3/vmxnet3_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index b70654c7ad34..bb514b72c8b5 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -201,6 +201,8 @@ vmxnet3_check_link(struct vmxnet3_adapter *adapter, bool affectTxQueue)
 
 	adapter->link_speed = ret >> 16;
 	if (ret & 1) { /* Link is up. */
+		if (VMXNET3_VERSION_GE_9(adapter) && adapter->link_speed < 10000)
+			adapter->link_speed = adapter->link_speed * 1000;
 		netdev_info(adapter->netdev, "NIC Link is Up %d Mbps\n",
 			    adapter->link_speed);
 		netif_carrier_on(adapter->netdev);
-- 
2.11.0


