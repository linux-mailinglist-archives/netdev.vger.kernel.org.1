Return-Path: <netdev+bounces-206319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB3CB02A5A
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 12:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17DF4A68FB
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 10:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6FB254848;
	Sat, 12 Jul 2025 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoQ0V1zX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B921A435
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752314851; cv=none; b=Qz+pd5ompufi9QuJ8cf409kZSsHPpba94ZmNLV2bpNQ1UKKWyFCGVInS6J+lvC+ncTzLkNPK4V1KrA7QkSGgZSAIaz8GGImxhoSWcNrHI88BwGhWVSNtKjeJzUhImSmw9Vcy/3fJAo4EZ9PEfyb2X1qIOaXunRbcrhPZTW4jWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752314851; c=relaxed/simple;
	bh=TSgntFvzr417mI13H6PTNr1hCaOX+YBqsxPHSlM77Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gI8CsXo56DIrWHnyQDL3VRpXT/TyW5ywNW2BMjl9/MP8x5BKE7agRkvopfNq/r/bhSG3cD/cd7sEFolJmih/8/658l5J2tc5TDVC/VRfu8avJAI6wIpD0c3x3Bx9ri0EHqlmAh8i0lWQS+/LmE/498H63ZIrYcDhX7Kx2uzeCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZoQ0V1zX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752314848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1JlNlY2tra3Y/oEZeo/U+AdvcEDBVVOybPTu1N4/msQ=;
	b=ZoQ0V1zXFZ0fKJpzoM31vJ004tfSDSEdd0PU5x1Rg5OyeEDba5UUA9UFyOrtcT4b66Ev5p
	enJSkaRW7hbhS/oeNIzY369fCYm670m6qc0zj8j/+CvlCn0jp4Xx49pnIznvNGt6mUQNat
	ofFF3jOKbGPR+FuhG18clfjL3ryn1rg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-3-4kF6wINMOowt8-iPjmsw-1; Sat,
 12 Jul 2025 06:07:25 -0400
X-MC-Unique: 3-4kF6wINMOowt8-iPjmsw-1
X-Mimecast-MFC-AGG-ID: 3-4kF6wINMOowt8-iPjmsw_1752314844
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6A211956086;
	Sat, 12 Jul 2025 10:07:23 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.72.116.11])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75F1D1956094;
	Sat, 12 Jul 2025 10:07:18 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Long Li <longli@microsoft.com>
Subject: [PATCH net v3] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
Date: Sat, 12 Jul 2025 18:07:08 +0800
Message-ID: <20250712100716.3991-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.

Commit 8a321cf7becc
("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")

This new flag change was not made to hv_netvsc resulting in the VF being
assinged an IPv6.

Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
Suggested-by: Cathy Avery <cavery@redhat.com>
Signed-off-by: Li Tian <litian@redhat.com>
---
v3:
  - only fix commit message.
v2: https://lore.kernel.org/netdev/20250710024603.10162-1-litian@redhat.com/
  - instead of replacing flag, add it.
v1: https://lore.kernel.org/netdev/20250710024603.10162-1-litian@redhat.com/
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


