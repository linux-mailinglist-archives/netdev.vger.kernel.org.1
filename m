Return-Path: <netdev+bounces-224433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F5B84B19
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21F71C2378B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80DF302CBD;
	Thu, 18 Sep 2025 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U08Jvs2O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416F2FD7A7
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200079; cv=none; b=p9h+wJQmzB+FVGRdDCAzhHL/R2y3cK2J2kVx1KoYdqZ4hvJO1SZNNryv0GHP6s+O/fVSq4IKI1S60DUDUmWBO6uGojZQPdkVpwo4LX+LaPc525J01PM6V/xUtxvHoQjmvN9vlpnGOjwmvHivSIwdmZjaMbVDRCD3RKF33J8l4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200079; c=relaxed/simple;
	bh=rDQbR7T4BLMMyagfq04ij6Gmcs2FFBL8I5q5eJUJW0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/D8UEi91elCfw0qBL5bgYxaETFunObjWXP54CcFcUEvYxLr0BAWKSkRSlo1Re2KT7EwEQjGgBuPMkoVzApjXr+XDoMNynvo7uJPb8tV/Nla1wwciw71K6Wqp8bMgyPWzFlE+78+9+RWH2/gFWDIcIznOUBofo6BzYjWJKX6s4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U08Jvs2O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758200077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FQ96GSn4sjUReO37A413swNltvEMDzBOmLabQkswZvE=;
	b=U08Jvs2OhqGmBZGUPTnuMctj6g7QhdmQWd2QL+FlLmsrLv1+CnjOHUKfWmJjCVOzpWvunY
	6Hm8tWdZST6QwtbOd5TXn5hV3PqcowAJpMSDYSJWg72mf7Z4vYSCU/PGzeSc3R/z0+hqah
	AcdYPUpW+dZVQnOyBJWsiKN+aX//hN4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-63yuSS1oPZCE2NTW5PpEWg-1; Thu,
 18 Sep 2025 08:54:34 -0400
X-MC-Unique: 63yuSS1oPZCE2NTW5PpEWg-1
X-Mimecast-MFC-AGG-ID: 63yuSS1oPZCE2NTW5PpEWg_1758200072
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 467A4195609E;
	Thu, 18 Sep 2025 12:54:32 +0000 (UTC)
Received: from fedora (unknown [10.44.32.211])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4E941800446;
	Thu, 18 Sep 2025 12:54:29 +0000 (UTC)
From: Jan Vaclav <jvaclav@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Jan Vaclav <jvaclav@redhat.com>
Subject: [PATCH net-next] net/hsr: add protocol version to fill_info output
Date: Thu, 18 Sep 2025 14:53:38 +0200
Message-ID: <20250918125337.111641-2-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Currently, it is possible to configure IFLA_HSR_VERSION, but
there is no way to check in userspace what the currently
configured HSR protocol version is.

Add it to the output of hsr_fill_info().

Signed-off-by: Jan Vaclav <jvaclav@redhat.com>
---
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


