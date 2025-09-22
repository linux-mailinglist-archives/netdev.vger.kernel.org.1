Return-Path: <netdev+bounces-225182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4112B8FC90
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B7118A1949
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F5F28980F;
	Mon, 22 Sep 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/aWKbvj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0A324BBFD
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533972; cv=none; b=B9BvCn7IrLLiFOYhe4YlzfYzbAoXJjA1rMijjp48OSzIy1rd59siz2e/TalNTH5jxfrDRGZf6dtJ27x4ar4W0GK6P2RrIoGiJv4kmOaQ0DVXQXUebGmjGeQxW6ff8gL2si6n4xHb/Zce91PAROeKOTf+3BxJL/zkzmxthkI+JDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533972; c=relaxed/simple;
	bh=agOnLhRM1uZJlfKJJgdD8Ng8v3XMNcv3dTS5cIAsP04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjeQ4jyDNzlJHdKzg4G5x37lL3uWeRovpVCvFt69J/Wb7zkgZGprgqkWr7lwCDvoQfXghKiC6a3b/44Z3yvfmAOvcmSZDhmLK6VELLY2mjWt3nsaKOLWlng1TZn4ylZg9rHrdEhrFiInTpoXTgA7yz0eph6ML1X/uma81dEJxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/aWKbvj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758533969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FbGEf/Y7RGek3hJ8Pl8Y/1fEQXXY32dAIYc754A6qMo=;
	b=a/aWKbvjKJDnSL4a0BnEC1ucPcBGOTuBSQenOAlZcatcA7ZloovvvqxLpYWduMLY3sAvpe
	ICBZy4HtHtQuqoHEjROBH/PWDVaKDFBCVOKy48kK+4SOyoPFWoT8KobMpFUepGkwNizABR
	SWIu6aZQb9IQ1mYy2hnO2RSfuHGSZto=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-EEANMSU_PSK6NiTVwy6K6g-1; Mon,
 22 Sep 2025 05:39:26 -0400
X-MC-Unique: EEANMSU_PSK6NiTVwy6K6g-1
X-Mimecast-MFC-AGG-ID: EEANMSU_PSK6NiTVwy6K6g_1758533964
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AE6C19560B5;
	Mon, 22 Sep 2025 09:39:24 +0000 (UTC)
Received: from fedora (unknown [10.44.32.211])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FA46180035E;
	Mon, 22 Sep 2025 09:39:21 +0000 (UTC)
From: Jan Vaclav <jvaclav@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Jan Vaclav <jvaclav@redhat.com>
Subject: [PATCH v2 net-next] net/hsr: add protocol version to fill_info output
Date: Mon, 22 Sep 2025 11:37:45 +0200
Message-ID: <20250922093743.1347351-3-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, it is possible to configure IFLA_HSR_VERSION, but
there is no way to check in userspace what the currently
configured HSR protocol version is.

Add it to the output of hsr_fill_info().

This info could then be used by e.g. ip(8), like so:
$ ip -d link show hsr0
12: hsr0: <BROADCAST,MULTICAST> mtu ...
    ...
    hsr slave1 veth0 slave2 veth1 ... proto 0 version 1

Signed-off-by: Jan Vaclav <jvaclav@redhat.com>
---
v2: Added an example to the commit message to show
    how userspace programs could use this property.

v1: https://lore.kernel.org/netdev/20250918125337.111641-2-jvaclav@redhat.com/

 net/hsr/hsr_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index b12047024..3d0bd24c6 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -166,6 +166,8 @@ static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		goto nla_put_failure;
 	if (hsr->prot_version == PRP_V1)
 		proto = HSR_PROTOCOL_PRP;
+	if (nla_put_u8(skb, IFLA_HSR_VERSION, hsr->prot_version))
+		goto nla_put_failure;
 	if (nla_put_u8(skb, IFLA_HSR_PROTOCOL, proto))
 		goto nla_put_failure;
 
-- 
2.51.0


