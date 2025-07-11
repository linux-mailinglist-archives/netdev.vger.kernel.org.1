Return-Path: <netdev+bounces-206040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E849B011EB
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 06:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B1F3AF87B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 04:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A6F1991C9;
	Fri, 11 Jul 2025 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EomCmYsZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76148F7D
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206799; cv=none; b=X6oFKDaolhMPQpbgw3Pw7LM2FiMtp1SF7uPoW6ZxL8aPftCAlril4jYgpDlWYNWKblfcbBv4sBQYhqqFQrrvq8iFRL2ptUzaakzKILHeD6E3qRJTJfZLR1ZoMWRNYxsGmXoY6FUptaw6KQlaJobJxeyT0htlpY9NN0bV4PpGJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206799; c=relaxed/simple;
	bh=SDiFjXIEY2k6EMivsiiZ56S4N+J1jLx/2bscGVPuYxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNAoSQqVSHDMGzjlHyFnOWbHfAF9SZH8zzrydBYKBasDRsRui2djGtNVrgpROf8pGbyBgweFuwTtj58qx/d1GZihhDTZ0TLfQ1Q6Z7xxgl630gQoqCmtJzTp9bYwr+YLwFGYGSZVyssoiAyH8nyGQVE+YXZDA1w97AJq0uoz9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EomCmYsZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752206796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJknBKO1gBSr73F5TeVtWsmcBQA8Lx7LIgsYwMB0ZDw=;
	b=EomCmYsZLjTbxCQHTl08SSC+b8MJERCBrm68vZFbGKCyS8rRnnaouW0MKGXhSM/gyb2Uii
	Z0HZgSY3Zw5Ck/GZpA8qBmxLBwzpZeBXarBopNAM735Z2F2ONRm96w30l+9zo0qVMN7q3+
	9ULQgSLf6GtWDV3As8TsNhYAjMdgyIY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-k7gJBKogMC-KM-ws_bsRqA-1; Fri,
 11 Jul 2025 00:06:34 -0400
X-MC-Unique: k7gJBKogMC-KM-ws_bsRqA-1
X-Mimecast-MFC-AGG-ID: k7gJBKogMC-KM-ws_bsRqA_1752206792
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0F8D1800366;
	Fri, 11 Jul 2025 04:06:32 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.72.116.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90AA41977029;
	Fri, 11 Jul 2025 04:06:26 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
Date: Fri, 11 Jul 2025 12:06:23 +0800
Message-ID: <20250711040623.12605-1-litian@redhat.com>
In-Reply-To: <20250710024603.10162-1-litian@redhat.com>
References: <20250710024603.10162-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.

Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")

This new flag change was not made to hv_netvsc resulting in the VF being
assinged an IPv6.

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


