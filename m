Return-Path: <netdev+bounces-78453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3608752FF
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5999028351F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C4B12F38E;
	Thu,  7 Mar 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vpj2DKEw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F912EBEE
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824744; cv=none; b=JFoRh6ea0gxivPxrTX0WlbFJaSxdNrtl07LSJJPwAv/9DBHrZIJZXKHrEXvg1yanXP4hxBRggmaMjuztsGY/9h8YC08pgD9dq8BlveIn2A/qz6VwoIbSsWkzv0OpShlGiwKOH7nnSS+zQ7SAHhD5I7z8RUCxblhDmGOvt3xaMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824744; c=relaxed/simple;
	bh=F538wWwrWNGys6pnOQ9df4zbII3ziF8/UbjeRm0Fg7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTcfngRBNVQdodo4qHSdVZhVJw0mkWE96KSIyxT29cXg1eqsl3mTXgQFkKzEEDnyZ4GQSEtCxYukrsFTNymrDsAveobm4l2ruREz3fmobUrB7JOzKHdNWNjBzOkfDB2PUJsUD+TE38xyQ+5hLSGr8vD+rWck7zZNK3xEkjhh/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vpj2DKEw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709824742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIW3JyZh1fUFBM3pmhtVMUMIH3+B+DvwKnOOaDtsKkY=;
	b=Vpj2DKEwKp0XfhRdzxpoSINwru0EEG1+6c94ZALWA89Veg1CzmkXl208MEd3bbOUJZ7haG
	3KYTrt8G8E8H5FBhicn7c6FRg3L/ANKs+0m/IxaHNyq/UaLUksNlCiik7pRQj3pBwx8+ve
	A7q2CfhiZbCJmhf1VJtWPBdRbteHgDg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-gU3X7Bb4M6qhkm3DDtoInA-1; Thu, 07 Mar 2024 10:18:58 -0500
X-MC-Unique: gU3X7Bb4M6qhkm3DDtoInA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34FB08007A7;
	Thu,  7 Mar 2024 15:18:58 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AFD152166AF0;
	Thu,  7 Mar 2024 15:18:56 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	cmi@nvidia.com,
	yotam.gi@gmail.com,
	i.maximets@ovn.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org
Subject: [RFC PATCH 3/4] net:openvswitch: Avoid extra copy if no listeners.
Date: Thu,  7 Mar 2024 16:18:47 +0100
Message-ID: <20240307151849.394962-4-amorenoz@redhat.com>
In-Reply-To: <20240307151849.394962-1-amorenoz@redhat.com>
References: <20240307151849.394962-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

If there are no listeneres in the multicast group, there is no need for
building the upcall packet. Exit early in that case.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/datapath.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 5a2c0b3b4112..5171aefa6a7c 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -455,6 +455,10 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	if (!dp_ifindex)
 		return -ENODEV;
 
+	if (upcall_info->portid == MCAST_PID &&
+	    !genl_has_listeners(&dp_packet_genl_family, ovs_dp_get_net(dp), 0))
+		return 0;
+
 	if (skb_vlan_tag_present(skb)) {
 		nskb = skb_clone(skb, GFP_ATOMIC);
 		if (!nskb)
-- 
2.44.0


