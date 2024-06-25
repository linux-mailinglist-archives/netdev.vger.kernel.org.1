Return-Path: <netdev+bounces-106666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D969172B9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5803B221A7
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AD317FABE;
	Tue, 25 Jun 2024 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9yz9f50"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B8D17FAB2
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348763; cv=none; b=fZk54qDwf+24H15uV/LSOI4zfMLfzc3vrBUErpY6ju7VeSfzNOuV67wLef5Ne82aa3AW5utIp/uDxcono9/vfmuybwiemsDV7XUJds82qcWLCfpS6SvWA0PaRV+io6e3geg2aWfg83/OvEn28uTYSUV2163v4EIbFoiP9V5cUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348763; c=relaxed/simple;
	bh=5pAd5l8SzMmlQSEbbBoeGexj0e42jZKo6+z9g7T1oew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZoF0iJPs+a3bCr70gcnFkuJIpix2rZNGgC5fr7b6/53+7aa5PBr1uQ+umD2MigjDJ4IoejiRP62Fdi76O5qdf+J7m3JefyYYYTv6Pq/eDA0U638k/Tp4PKD4ZaOBu1Rx8m4cPlRaK16Cyt4xzfYApirbssYyjCIDfwa/vSGDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z9yz9f50; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719348761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maZ9TMPYGbzb/EBP71+0JWLbUHEakzvhjd9HxWMo8cg=;
	b=Z9yz9f501FrZRZF9Hgav6raWPhQADLOhpT9N354wGEz4F0TYrv7Amw+0dFz2RlX3HoWNO7
	GIEq/YsUpTrvHjdRoZV++hhy7PA2TjXPfGOgrlRVlqnrP7CH2lCFccps1Tj6RAJX/+mQ3s
	KBBay2ogOnh2e5ZR54kBMgxAhp/dtYI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-IGAhzAbvPL2BL4pKwl-8dA-1; Tue,
 25 Jun 2024 16:52:38 -0400
X-MC-Unique: IGAhzAbvPL2BL4pKwl-8dA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 900B11955D84;
	Tue, 25 Jun 2024 20:52:36 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.93])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D02E19560BF;
	Tue, 25 Jun 2024 20:52:31 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 03/10] net: psample: skip packet copy if no listeners
Date: Tue, 25 Jun 2024 22:51:46 +0200
Message-ID: <20240625205204.3199050-4-amorenoz@redhat.com>
In-Reply-To: <20240625205204.3199050-1-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If nobody is listening on the multicast group, generating the sample,
which involves copying packet data, seems completely unnecessary.

Return fast in this case.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/psample/psample.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/psample/psample.c b/net/psample/psample.c
index b37488f426bc..1c76f3e48dcd 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -376,6 +376,10 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 	void *data;
 	int ret;
 
+	if (!genl_has_listeners(&psample_nl_family, group->net,
+				PSAMPLE_NL_MCGRP_SAMPLE))
+		return;
+
 	meta_len = (in_ifindex ? nla_total_size(sizeof(u16)) : 0) +
 		   (out_ifindex ? nla_total_size(sizeof(u16)) : 0) +
 		   (md->out_tc_valid ? nla_total_size(sizeof(u16)) : 0) +
-- 
2.45.1


