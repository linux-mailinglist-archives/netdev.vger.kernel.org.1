Return-Path: <netdev+bounces-207323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D1B06A63
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AF2563D3E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0246171C9;
	Wed, 16 Jul 2025 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmyreoV/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D886846F
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625581; cv=none; b=UNSRXwxfYLywLamKlinYvgp/xChdATPENAxJaDZ+h6JgIc3ZdBWUzS8EzCiBMZcbtMoTL+7J/VV8WeiSNTGbx5SYaKQ4ttKYD6jc4u+y2TCz92RUThf50w2e9iU81WVUN/LTfJYfNl2h6n+bG/5fYe2h5oSQZKRUE2ZraDzIQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625581; c=relaxed/simple;
	bh=PNMSNhGTqYtxYIU/awGFqnGG3CMyqS2mKddMzgIHmc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/Xd0RMlLCNq37wscvQgnKFnu9/lup2D/rdOveObVM5UPASJBD/0g3+RdhdwHudv8I7YURn2HrcE1Oyt7xwunzwriQygZ7BH0f+J9ARFZrH8jPXhj7p4JDPv5twsKjsMKe5yCPqtLqdIrITfO2ptWD4lN18abapyk4NIPiL3E7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmyreoV/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752625578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bJN0js1mXFtPosWS7Mr0CZxy87n73HJjlADNnzxbL/Y=;
	b=OmyreoV//grjnLPUqxr8eYkXmh5gSfBoYNmPcbCPY68aZ8w/rfmPzlUhd2UzLcsxD62RX2
	RdPlYCsM0bdHg5thHzVhd2ot/J3YHAZB2/83IdUV5yHWLy/gZXhh54HoVYiPJvaXY3kzEG
	0G3n4a5gyXl68PIq1jLsUqhlWBGYYIQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-MnMiEhQwMyOfLCSitGfOUw-1; Tue,
 15 Jul 2025 20:26:16 -0400
X-MC-Unique: MnMiEhQwMyOfLCSitGfOUw-1
X-Mimecast-MFC-AGG-ID: MnMiEhQwMyOfLCSitGfOUw_1752625575
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 387C11800366;
	Wed, 16 Jul 2025 00:26:15 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.72.112.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 380F8180035E;
	Wed, 16 Jul 2025 00:26:09 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v3] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
Date: Wed, 16 Jul 2025 08:26:05 +0800
Message-ID: <20250716002607.4927-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.

Commit under Fixes added a new flag change that was not made
to hv_netvsc resulting in the VF being assinged an IPv6.

Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
Suggested-by: Cathy Avery <cavery@redhat.com>
Signed-off-by: Li Tian <litian@redhat.com>
---
v3:
  - only fixes commit message.
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


