Return-Path: <netdev+bounces-241814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C99C88AF3
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47220356CCC
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982A31A7F8;
	Wed, 26 Nov 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOhfm09c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520D308F3E
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146252; cv=none; b=E63ReVZrItzeLGUpE5AmseK5SWsRBrQInZaajd2f7dwWdpQjdt+/XU1AO48FqF2jHKIBnrP9TRzTTN+AWa0GtoR2FWzqH0xoZDv2DXNEOHQoief6MUCCZVomhipYJIaznbCOvEmFCExdvd3DbwgzPI8u8WLCR4ojB0mMjOcfJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146252; c=relaxed/simple;
	bh=L6d7JX2NxpV70mdYJdWuFktVN1TIheRJ7MTJjYmywf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AotTmmi/h098lmpXsqNwJmYZhpiTdVtjwcBkAevQ4YCn7vXOGWRPJoP21Gq6RTBlre0adaLryHRz71TmJ7MNUTWZFS3Rho081sE7h+xU5WrZlKRPxRKySUJaLvEpQNZa6o0Y2zh5VcoakyfGj75jcSXqS6CbaEKouvTJKfRFNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOhfm09c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764146249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WfsOQjgF7/xWI1YakLoR+iRc3/E3a/SKTOgGp8KeRUE=;
	b=XOhfm09c43t+u7lZgxUwtvT9AdiUJIx7zPhyxqAJp3iDqgUBbX9pGZ34QAnhI0qS9QBb1v
	qBXmsVDq3B734pry2CcK6295MSFaJh+tZf2KJMDCLodTA1/IsT0x196Ia8yVrntftJbHv+
	7JZD3DhfZux8jSZq9WIoCdzSFzmMODE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-Lkow2B6ZOseDFBbYdfvDYw-1; Wed,
 26 Nov 2025 03:37:26 -0500
X-MC-Unique: Lkow2B6ZOseDFBbYdfvDYw-1
X-Mimecast-MFC-AGG-ID: Lkow2B6ZOseDFBbYdfvDYw_1764146244
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A053B19560A7;
	Wed, 26 Nov 2025 08:37:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.147])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F59918004A3;
	Wed, 26 Nov 2025 08:37:18 +0000 (UTC)
From: Yumei Huang <yuhuang@redhat.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: sbrivio@redhat.com,
	david@gibson.dropbear.id.au,
	yuhuang@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH] ipv6: preserve insertion order for same-scope addresses
Date: Wed, 26 Nov 2025 16:37:14 +0800
Message-ID: <20251126083714.115172-1-yuhuang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

IPv6 addresses with the same scope were returned in reverse insertion
order, unlike IPv4. For example, when adding a -> b -> c, the list was
reported as c -> b -> a, while IPv4 preserved the original order.

This patch aligns IPv6 address ordering with IPv4 for consistency.

Signed-off-by: Yumei Huang <yuhuang@redhat.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 40e9c336f6c5..ca998bf46863 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1013,7 +1013,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
 	list_for_each(p, &idev->addr_list) {
 		struct inet6_ifaddr *ifa
 			= list_entry(p, struct inet6_ifaddr, if_list);
-		if (ifp_scope >= ipv6_addr_src_scope(&ifa->addr))
+		if (ifp_scope > ipv6_addr_src_scope(&ifa->addr))
 			break;
 	}
 
-- 
2.51.1


