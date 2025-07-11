Return-Path: <netdev+bounces-206047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D7B01215
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 06:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF825463E6
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 04:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5351ACEDE;
	Fri, 11 Jul 2025 04:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpIEQgcZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACAB1A2389
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207445; cv=none; b=sUbBspxKZ2Hd8KRHiVKsMcnsmvZbGT5I1jWefVR5wyChdwxVqCMSCfYylZJAoQUBwRoh+8rqwZqCiF0HYlnMS77GGo/PXxkl8DHo+N1Y4VCakmsyP2sXglY9QNcDwwYaoVv8VbWoMJ3KVyGRwSueUigx/OPd47H1KpPVbXvQuK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207445; c=relaxed/simple;
	bh=VGjzDZZ1+cEoortXl63nVR2f4+drZLd97eNMlNObsxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVzXSmowJt0mHcgvpjSWTr23Lia5HZ37eNH7LbWT4CcwO4FFL49ZUxyjUGi9JFxqEKDfXbyL6k60+07wvcShKGrDVU3Bnx4oRWWF8v6W2m0N3yvhAYcsCRCL0ZSua4SkCTqc+737Jd/CVCZ5j8N4/87NW3VoeZc5Ys2cLLdi8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpIEQgcZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752207442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrgWwIjSYaWR14oGi13NO50VuL8N7hygSneHcVyTJRg=;
	b=FpIEQgcZGUWwixWzZbHOuwb2mxYMBD3qMorKgqk5C7vmCHczMBe5frqTFu5JcAzoj9/vt0
	jExDsTGqMoRC3kDyseAZ8zH/FDFZYeQZtW1Yk9jJf0O9G6bPvF+WRMmH32NUtxkPyDZQvf
	lJxbWNO8RBSqufHS8TqTphrqjAyvnkU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-udV0WTznP6uO1Q1QBSRUxQ-1; Fri,
 11 Jul 2025 00:17:16 -0400
X-MC-Unique: udV0WTznP6uO1Q1QBSRUxQ-1
X-Mimecast-MFC-AGG-ID: udV0WTznP6uO1Q1QBSRUxQ_1752207435
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E92CA1956096;
	Fri, 11 Jul 2025 04:17:14 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.72.116.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2A7E19560A3;
	Fri, 11 Jul 2025 04:17:08 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v2] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
Date: Fri, 11 Jul 2025 12:17:00 +0800
Message-ID: <20250711041700.13103-1-litian@redhat.com>
In-Reply-To: <20250710024603.10162-1-litian@redhat.com>
References: <20250710024603.10162-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.

Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")

This new flag change was not made to hv_netvsc resulting in the VF being
assinged an IPv6.

Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")

Suggested-by: Cathy Avery <cavery@redhat.com>

Signed-off-by: Li Tian <litian@redhat.com>
---
 drivers/net/hyperv/netvsc_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index c41a025c66f0..8be9bce66a4e 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2317,8 +2317,11 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	if (!ndev)
 		return NOTIFY_DONE;
 
-	/* set slave flag before open to prevent IPv6 addrconf */
+	/* Set slave flag and no addrconf flag before open
+	 * to prevent IPv6 addrconf.
+	 */
 	vf_netdev->flags |= IFF_SLAVE;
+	vf_netdev->priv_flags |= IFF_NO_ADDRCONF;
 	return NOTIFY_DONE;
 }
 
-- 
2.50.0


