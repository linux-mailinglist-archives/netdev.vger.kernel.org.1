Return-Path: <netdev+bounces-147771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8049DBB1A
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3092B1640DD
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DEC192B74;
	Thu, 28 Nov 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFhcRffA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2E3232
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810730; cv=none; b=GKlmw90C6wGLL8q7Dcb3sa4eUwEIayBmP0Q+uMHlZoz32CiT+2fNpxi708KXZdiuMa7XVOyGztotCCtBeS9FLvAns9K7Ez1bLBXB8yOg/a5Wbts0gqqR6Xrn76659opk9PxHv5jAVYIyxwMNn4/yLy75QKOKkynmLSh9NxHeHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810730; c=relaxed/simple;
	bh=vcF/m3VHl3X+0CaxwimqX6LQRM5aPFRqK2232P7rTgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQwMZlIOSLlDy/AYJEYY+xhnV4e4pQkrw1cavmbyiCPOqGI5U4grk7hTZP9kYTRnGYP3BPBCCNGMmbCu1uJaAUNQwq+REAq0gAKWuZJKQ6qQ+cNwckE6K/JPsuTphwWN9Fy0vFFnEOTpNIGvnxO0+K3GyTa+OQkK8u0crdswzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFhcRffA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732810727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8TpZW/0x5ZTX4XhnDq5xcfBFx5qLPPHHuzpNI/p3pEg=;
	b=CFhcRffA81uHpICP/sW+qhAQCDykEyBWu/Z/Px2HToiwcvOocP+QSkq4AMqfhUvaG1gyi6
	qZFhRrqe3d7LY9mrYzwzZFhl/IGek4q3HyK2dmuZ8W5NpQkvEpf2AHjPnjPzfYcsXZKs3M
	OdsotHe3H0IsKo+YLVvzaDXn3rTxMbk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-kFZ5ttA1M_qKmeVAl0aVrA-1; Thu,
 28 Nov 2024 11:18:42 -0500
X-MC-Unique: kFZ5ttA1M_qKmeVAl0aVrA-1
X-Mimecast-MFC-AGG-ID: kFZ5ttA1M_qKmeVAl0aVrA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 700F71954AF2;
	Thu, 28 Nov 2024 16:18:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.69])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E24C7195608A;
	Thu, 28 Nov 2024 16:18:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	sashal@kernel.org
Subject: [PATCH net] ipmr: fix build with clang and DEBUG_NET disabled.
Date: Thu, 28 Nov 2024 17:18:04 +0100
Message-ID: <ee75faa926b2446b8302ee5fc30e129d2df73b90.1732810228.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Sasha reported a build issue in ipmr::

net/ipv4/ipmr.c:320:13: error: function 'ipmr_can_free_table' is not \
	needed and will not be emitted \
	[-Werror,-Wunneeded-internal-declaration]
   320 | static bool ipmr_can_free_table(struct net *net)

Apparently clang is too smart with BUILD_BUG_ON_INVALID(), let's
fallback to a plain WARN_ON_ONCE().

Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25635-g6813e2326f1e/testrun/26111580/suite/build/test/clang-nightly-lkftconfig/details/
Fixes: 11b6e701bce9 ("ipmr: add debug check for mr table cleanup")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/ipmr.c  | 2 +-
 net/ipv6/ip6mr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 383ea8b91cc7..c5b8ec5c0a8c 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -437,7 +437,7 @@ static void ipmr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);
 
-	DEBUG_NET_WARN_ON_ONCE(!ipmr_can_free_table(net));
+	WARN_ON_ONCE(!ipmr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 4147890fe98f..7f1902ac3586 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -416,7 +416,7 @@ static void ip6mr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);
 
-	DEBUG_NET_WARN_ON_ONCE(!ip6mr_can_free_table(net));
+	WARN_ON_ONCE(!ip6mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
-- 
2.45.2


