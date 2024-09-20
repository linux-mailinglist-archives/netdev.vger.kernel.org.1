Return-Path: <netdev+bounces-129125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEED97D9B7
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6D81F2391E
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C7185B4F;
	Fri, 20 Sep 2024 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDFM1BF/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE7185957
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726858805; cv=none; b=ftNUA4VV6X0h73efKiBwORS5G+ec0g2SmCryF9qirPMTWE3z/Odg4sPEaNf5d2AnJEM2/PA4KFrKXjmfj+qkhhPYAxWnCSNkD4jhEEbv2Lss4gdejERla32SbTO7uYtqa+rhKQMNosgBX/ghTuM8UYfv7Kef2eDH5/d23g//mSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726858805; c=relaxed/simple;
	bh=4+tH/ylmpVF5iddSl+fgs5b1qIcWb3VcWqW3OFYCP7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkt1ne5UsHJLnia26QZNEvkg1cLTTSyWA0FCEeiFPvfAnZovgGF0bfOgAZfgIYlL3HrCRP25DuAomSfKRfohUkVKBEKnZos+5ThlLOTquAVXWbssOlHexMKBcjHg4MdMlswynPVG2ObKEVBYGMNacJODX7METvPSntoV8SxfOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDFM1BF/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726858803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llCgb+Xxiy1ho4t2E4Qpu90griCJANrCZWM8/TQaOmo=;
	b=DDFM1BF/IN2oLfeIFoTGUg11akxl2XLISu5fx6z1Fe1OMSA3I2geSzggyM3b8LdmsC+cCi
	IpLOLdEFpsG6gxF9huGFS2mJIa7dBqiOWmwrI9Dt00Tza+K6d9Xd7+cGULMlbqLhBsu28W
	XHtcXeWoJ8Jbg+LIOeJoiuhVOLxbwNA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-uzQqO-ASNdmooo6JDg1orw-1; Fri,
 20 Sep 2024 14:59:58 -0400
X-MC-Unique: uzQqO-ASNdmooo6JDg1orw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD98D1979049;
	Fri, 20 Sep 2024 18:59:56 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.33.41])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EA9E19560AA;
	Fri, 20 Sep 2024 18:59:53 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 2/2] igbvf: remove unused spinlock
Date: Fri, 20 Sep 2024 15:59:17 -0300
Message-ID: <20240920185918.616302-3-wander@redhat.com>
In-Reply-To: <20240920185918.616302-1-wander@redhat.com>
References: <20240920185918.616302-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

tx_queue_lock and stats_lock are declared and initialized, but never
used. Remove them.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/net/ethernet/intel/igbvf/igbvf.h  | 3 ---
 drivers/net/ethernet/intel/igbvf/netdev.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index 6ad35a00a287..ca6e44245a7b 100644
--- a/drivers/net/ethernet/intel/igbvf/igbvf.h
+++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
@@ -169,8 +169,6 @@ struct igbvf_adapter {
 	u16 link_speed;
 	u16 link_duplex;
 
-	spinlock_t tx_queue_lock; /* prevent concurrent tail updates */
-
 	/* track device up/down/testing state */
 	unsigned long state;
 
@@ -220,7 +218,6 @@ struct igbvf_adapter {
 	/* OS defined structs */
 	struct net_device *netdev;
 	struct pci_dev *pdev;
-	spinlock_t stats_lock; /* prevent concurrent stats updates */
 
 	/* structs defined in e1000_hw.h */
 	struct e1000_hw hw;
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 925d7286a8ee..02044aa2181b 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1656,12 +1656,9 @@ static int igbvf_sw_init(struct igbvf_adapter *adapter)
 	if (igbvf_alloc_queues(adapter))
 		return -ENOMEM;
 
-	spin_lock_init(&adapter->tx_queue_lock);
-
 	/* Explicitly disable IRQ since the NIC can be in any state. */
 	igbvf_irq_disable(adapter);
 
-	spin_lock_init(&adapter->stats_lock);
 	spin_lock_init(&adapter->hw.mbx_lock);
 
 	set_bit(__IGBVF_DOWN, &adapter->state);
-- 
2.46.1


