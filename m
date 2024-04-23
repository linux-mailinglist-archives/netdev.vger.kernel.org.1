Return-Path: <netdev+bounces-90570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD558AE890
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C1F1F235DF
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA62136E22;
	Tue, 23 Apr 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxpO4Pw/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73230136E05
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880060; cv=none; b=rTq3Sx56eeeDpYy6/N+DPCwYLQlVSVhm3pdAYXI33sDyBD1BnuTEugQqxONCngQzFteGhvYPLssQzb18i4M5V+ivb1roWylDJ2wXEnqRsOOqOGVR3MjuZhlJG31jfn1jjnJLkAwueCfcDQZ2Zu5Ww4KBxQdMc0J3/QsT5r4QOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880060; c=relaxed/simple;
	bh=SLVehTKF+44M8nOQRcYo9sNLtTeGWb/0pP2ZXk9JzXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GR6EIT4xMkOiw1LGY8vhguU07fhauQmGCcTvyUMrcr8KWdTsnAMH8rBkdU7ubVU86DmkpmnfnSUYahhNTlzql3a89Im5Mtt1mFYerRJkjUHUmbTqHM8I827jZK6GbFLLdQoAita2bnD4HmDMG8PRBaGazfU5H8CzjtFXCC44By0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxpO4Pw/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713880057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hMZp7vYlgNuZhS/jUXjj83MHWi0SFemcDgb6WZEyykI=;
	b=TxpO4Pw/6d8A+ibfJXVCGMOFudJtwKMVo1U+Z2t5MPq0tZWwHVajvPRAe1MIMB9Ge42lgs
	e+NZ3MrNYbF1IK2THU+pGmAhNQu6gKQVogdwgl8Dm9Qbp7foI/wpebqT5rG0cCQxQxHjNL
	re0dlKmmep48IOQKeMSK51cgTXJ28G0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-Rxv05-80N6mL9QIoHLVtCw-1; Tue,
 23 Apr 2024 09:47:34 -0400
X-MC-Unique: Rxv05-80N6mL9QIoHLVtCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BAC13C3D0C5;
	Tue, 23 Apr 2024 13:47:33 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DF92D200A5C5;
	Tue, 23 Apr 2024 13:47:32 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 88233A80CED; Tue, 23 Apr 2024 15:47:31 +0200 (CEST)
From: Corinna Vinschen <vinschen@redhat.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
Date: Tue, 23 Apr 2024 15:47:31 +0200
Message-ID: <20240423134731.918157-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Paolo Abeni <pabeni@redhat.com>

Sabrina reports that the igb driver does not cope well with large
MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
corruption on TX.

An easy reproducer is to run ssh to connect to the machine.  With
MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.

The root cause of the issue is that the driver does not take into
account properly the (possibly large) shared info size when selecting
the ring layout, and will try to fit two packets inside the same 4K
page even when the 1st fraglist will trump over the 2nd head.

Address the issue forcing the driver to fit a single packet per page,
leaving there enough room to store the (currently) largest possible
skb_shared_info.

Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAG")
Reported-by: Jan Tluka <jtluka@redhat.com>
Reported-by: Jirka Hladky <jhladky@redhat.com>
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Tested-by: Sabrina Dubroca <sd@queasysnail.net>
Tested-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2: fix subject, add a simple reproducer

 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a3f100769e39..22fb2c322bca 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4833,6 +4833,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 
 #if (PAGE_SIZE < 8192)
 	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
+	    SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||
 	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
 		set_ring_uses_large_buffer(rx_ring);
 #endif
-- 
2.44.0


