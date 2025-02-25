Return-Path: <netdev+bounces-169424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C323A43D35
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CB1189FECA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49F15B980;
	Tue, 25 Feb 2025 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgyLMwWX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E01A2391
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482200; cv=none; b=XwtpCs2HegqYq1P5JIQsWPaFnsGoMhzd1c/fX+q3NXSHoYCvOKhDfGRlI0QbKM8x4yv6RagWi3JOv3kCe9+ABtI6KhL6mbs72O5dae7bPJgD9DgAmHEFdLDOkPsElRhg23hHEJn4XM9I2Of2DcMBWqcCktL5HjeBB+BREdTrXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482200; c=relaxed/simple;
	bh=+0SGeGqvlX2P/c/CVzOljl0rY4nOTh8AV9Oqn8buWvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzDN1Kd+qAsuc1N/yLtH1F25plohfZJIfVTKWpwuEC4op2gyGfoCq2EtFXh1N8IKS8ShGqcO2iJ+/Ecibj9C/6ECVy8Mqd9al2EF9koc/yTSgyViuTq2/gKWXyT/NoTAP/vwo67gY59wvP9AHIGmaed1TpBC/NLwDRzvtNXHBDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgyLMwWX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740482197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XTA/8Gabkk6ltL47ua5fE2TSIjCfzz6q8URaEZ28VHo=;
	b=FgyLMwWX9iLdOiSoO59DQwHCxKFSxbbZV6IoByqzCYhAQDLMc14JCmpxC+VJD6S1rrWbH6
	01roVX4VyjuHNGlWPSR3PWN618CZV8/2RtPeNY3kXzQ3R3U6H11TJ4KEjsw1qBeY31XytA
	1Axpq5DVCW6kkFviVzQXEa7utREonTU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-b5Nl2XOwPcaBcaEGVyl4Xg-1; Tue,
 25 Feb 2025 06:16:35 -0500
X-MC-Unique: b5Nl2XOwPcaBcaEGVyl4Xg-1
X-Mimecast-MFC-AGG-ID: b5Nl2XOwPcaBcaEGVyl4Xg_1740482194
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B9D318EB2C3;
	Tue, 25 Feb 2025 11:16:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.47.238.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3C2219560A3;
	Tue, 25 Feb 2025 11:16:31 +0000 (UTC)
From: Mohammad Heib <mheib@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net v2] net: Clear old fragment checksum value in napi_reuse_skb
Date: Tue, 25 Feb 2025 13:16:18 +0200
Message-ID: <20250225111618.2389383-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In certain cases, napi_get_frags() returns an skb that points to an old
received fragment, This skb may have its skb->ip_summed, csum, and other
fields set from previous fragment handling.

Some network drivers set skb->ip_summed to either CHECKSUM_COMPLETE or
CHECKSUM_UNNECESSARY when getting skb from napi_get_frags(), while
others only set skb->ip_summed when RX checksum offload is enabled on
the device, and do not set any value for skb->ip_summed when hardware
checksum offload is disabled, assuming that the skb->ip_summed
initiated to zero by napi_reuse_skb.

This inconsistency sometimes leads to checksum validation issues in the
upper layers of the network stack.

To resolve this, this patch clears the skb->ip_summed value for each
reused skb in by napi_reuse_skb(), ensuring that the caller is responsible
for setting the correct checksum status. This eliminates potential
checksum validation issues caused by improper handling of
skb->ip_summed.

Fixes: 76620aafd66f ("gro: New frags interface to avoid copying shinfo")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 net/core/gro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 78b320b63174..0ad549b07e03 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -653,6 +653,7 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 	skb->pkt_type = PACKET_HOST;
 
 	skb->encapsulation = 0;
+	skb->ip_summed = CHECKSUM_NONE;
 	skb_shinfo(skb)->gso_type = 0;
 	skb_shinfo(skb)->gso_size = 0;
 	if (unlikely(skb->slow_gro)) {
-- 
2.48.1


