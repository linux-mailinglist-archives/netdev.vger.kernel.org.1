Return-Path: <netdev+bounces-119227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 427BE954D94
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06E71F276CE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F1C16F831;
	Fri, 16 Aug 2024 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5rTgdys"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B813CF86
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821647; cv=none; b=W/dJbiugoktmAy6Y8TAok2CL+AaBW1iX4j1yx3T8tpPl3zd5XB0dxjPOSFMj9xqQ0UOkF6OTPElYyjGWTOCOvPDNzwKlWMHJ4EMwKrr2gDp2FDMVv83IRPTkvRGd30AGBIemhSqvtDO3SsWnJhh/q19vrRRFoMhcCqrXeQgmpYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821647; c=relaxed/simple;
	bh=K1+VKir0cVoh0i4hJNitZAps1JN69SvIXV2kBZWfsNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cC/+hZBa/UctQpAd12EROO267wCgPP1V5sdvVK/eFhPhTaUq+fo8xq7RLsHi9wFDOzlpwnoxS4ldp4ksuv9nN0mrR/zritZQOKTjvoNWGf4LdiSO3KWuMo7ZivRSxRnJ3bGYgs87LvIGQaGE4YnbCm2h4jNpYV8GLmfUPGAa3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5rTgdys; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723821644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4UoO1U2g7LUID0LDP1Gf00/pKKAKOTut19E2FMPwsqs=;
	b=B5rTgdysn87GA7fE/yYqVMKTQDTuPhRK3m4EAsjNW07vSrgKAy8bbVoZN5KvviMDAQ1MEu
	mDL63LpKcQO0uv4TZbmnZj2fEkFUPFPLwlcECk0OC+T2XBVMw3kKDi+YlGeLV2qHBenTaX
	VnW0ED+LVp9KRdhO5iU3lASIdP8i53I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-vEAI-sA-On6mxT5WDZpkVw-1; Fri,
 16 Aug 2024 11:20:40 -0400
X-MC-Unique: vEAI-sA-On6mxT5WDZpkVw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7B3E1955D57;
	Fri, 16 Aug 2024 15:20:37 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.193.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEA31300019A;
	Fri, 16 Aug 2024 15:20:36 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4B9E4A80739; Fri, 16 Aug 2024 17:20:34 +0200 (CEST)
From: Corinna Vinschen <vinschen@redhat.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jan Tluka <jtluka@redhat.com>,
	Jirka Hladky <jhladky@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Corinna Vinschen <vinschen@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
Date: Fri, 16 Aug 2024 17:20:34 +0200
Message-ID: <20240816152034.1453285-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Paolo Abeni <pabeni@redhat.com>

Sabrina reports that the igb driver does not cope well with large
MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
corruption on TX.

An easy reproducer is to run ssh to connect to the machine.  With
MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.  This has
been reported originally in
https://bugzilla.redhat.com/show_bug.cgi?id=2265320

The root cause of the issue is that the driver does not take into
account properly the (possibly large) shared info size when selecting
the ring layout, and will try to fit two packets inside the same 4K
page even when the 1st fraglist will trump over the 2nd head.

Address the issue by checking if 2K buffers are insufficient.

Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
Reported-by: Jan Tluka <jtluka@redhat.com>
Reported-by: Jirka Hladky <jhladky@redhat.com>
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Tested-by: Sabrina Dubroca <sd@queasysnail.net>
Tested-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

v2: utilize IGB_2K_TOO_SMALL_WITH_PADDING

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 11be39f435f3..33a42b4c21e0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4808,6 +4808,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 
 #if (PAGE_SIZE < 8192)
 	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
+	    IGB_2K_TOO_SMALL_WITH_PADDING ||
 	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
 		set_ring_uses_large_buffer(rx_ring);
 #endif
-- 
2.45.2


