Return-Path: <netdev+bounces-99494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2AB8D50EC
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10090B21430
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829654596F;
	Thu, 30 May 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/ISREk0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0746521
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089684; cv=none; b=QGYjH16dUZRcgCJt4RN0DsidCcULVw4uxRJoKiuMqCApIQ2JFUrNq5msN1uzrk9t/7kHy5Nt53vCz5sLrV6JV4/XlXLS1L0Y+X6Ng1bbgeNwFf4pEC1iXkV3ds1ne6nyf61nveFqaiQpDse4hxzS3EhWdN1Xg7gUUso+VCJ3a0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089684; c=relaxed/simple;
	bh=82pkty1ED0gQueP3yMD4YElnZzpXECk/MJ4v+UBLHAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXvVY+Nb2ekvkmk0z2s/x4OUxV/WS5lBA2dkRLHJpba+1i9ZOYrUR+UheZWV/IWAK2eV91N2u8301Bd7OL2fRRPg6RaKIdzGI2M6FzNM0i9D++/t2qtQ5CdY/FzZIgP/PEzsjsU3zHU3FwsmuoAITl1JcMglE3g3cLrs8j7la+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/ISREk0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717089682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pU3iIHwv0Sd8cVDwSWtWQ4345lVcCCW8j/o0ndZ+2WE=;
	b=M/ISREk0prOaZ94ghcgQQjNsdGZE6LplwQIw6Oz09xFMtTkblhrekyHhAtd94V+JxHDr3I
	XgcVTXfRDElxG4nRlDVw7LQzukSJrrAnsjRy5zpuOyuQmtqU4MGfm12B8+Y/WZCH4+liYD
	+iZ04TUmxpCxcq6WJBwOc8Q80IotWdk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-6yo8pXZWNqymfwqo2jfpxA-1; Thu,
 30 May 2024 13:21:17 -0400
X-MC-Unique: 6yo8pXZWNqymfwqo2jfpxA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E248C29AA386;
	Thu, 30 May 2024 17:21:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C396340C5CB;
	Thu, 30 May 2024 17:21:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] ipv4: obsolete routes moved out of per cpu cache
Date: Thu, 30 May 2024 19:21:02 +0200
Message-ID: <97703169844b3ae14e2e7623281546aa9533b48a.1717087015.git.pabeni@redhat.com>
In-Reply-To: <cover.1717087015.git.pabeni@redhat.com>
References: <cover.1717087015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

When a new entry replaces an existing one in the next hop per cpu cache,
the old entry is added to the uncached list.

Soon we are going to insert in the uncached list even entries held by
the dst_cache(s), the above could cause double add.

Avoid the potential issue obsoleting the old entry instead. This
additionally make the stack more consistent with ipv6, as the latter
already calls dst_dev_put() when replacing per cpu cached entries.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5fd54103174f..506452f1395d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1473,7 +1473,7 @@ static bool rt_cache_route(struct fib_nh_common *nhc, struct rtable *rt)
 	prev = cmpxchg(p, orig, rt);
 	if (prev == orig) {
 		if (orig) {
-			rt_add_uncached_list(orig);
+			dst_dev_put(&orig->dst);
 			dst_release(&orig->dst);
 		}
 	} else {
-- 
2.43.2


