Return-Path: <netdev+bounces-99493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48ED8D50EB
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4BC2844CA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BC546433;
	Thu, 30 May 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzG0j/4f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FAA45BF0
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089682; cv=none; b=ViDoGkd8L/ycYYqPunlm61Olg8wciXbC7tKcm6uUIkZYRk42mem1fpn+ccOi3qzExzAuwZZBbZkPYHVKL5ISwPOYHG3t8tCBZP0ARMiFtEi4KhSeMVefaWqHhndMDuyTQIaPRHp6UQSXTJQYrlf5I5VjDDAtNpgwCxgmf4f3CPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089682; c=relaxed/simple;
	bh=q7MD1ZITGxBpDMNdMo6pep4ioSjdd1BINvsplsHdRcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci2Dn1iwScEQv6+4Yr4V14c/fx8VxPlY3j/hePzl8lo/mvnr6L3DtK1V46cZrlHWvcCQ1uvKiD5BL81SgkpZjS7Un4hLCC9vHY4olLUDZnbzoiMD6vYVMpD9xrUJOsDdwRScT/TWoh6gYVQIatP3jurXvaQVDszZLvIhGizL1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QzG0j/4f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717089679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BS30nG4qU9JzrpDo4ZZ7QONBVCca7tSabRhuQfFb0PI=;
	b=QzG0j/4fZQfATLDltX2VS+N0VnonAXZxPcx7fUDhlA56bOzshug/W4jHqShHXdhB0vMhiY
	WvhHI/XrJAaZo1xSW4Ol72cHZjHFr/4CHEWcvEyUynjHUXUhF4eZiDth0KWQfA9FFJBlYe
	aghNsx1D9CPusks98n1rVEcWrwII/4E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-HNLyi8z8Ooyf1NB3id7wuA-1; Thu,
 30 May 2024 13:21:16 -0400
X-MC-Unique: HNLyi8z8Ooyf1NB3id7wuA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8139329AA381;
	Thu, 30 May 2024 17:21:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 67C6A4026B8;
	Thu, 30 May 2024 17:21:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] ipv6: use a new flag to indicate elevated refcount.
Date: Thu, 30 May 2024 19:21:01 +0200
Message-ID: <7c3ec1f7c7e4098045d1e42961df8af11619089e.1717087015.git.pabeni@redhat.com>
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

ip6_pol_route() can return a dst entry with elevated reference count
even when the caller ask for the RT6_LOOKUP_F_DST_NOREF flag.

Currently the caller uses the rt_uncached list entry field to detect
such scenario: the reference is elevated only for entry in the uncached
list.

Soon we are going to insert in the uncached list even entry held by
the dst_cache(s), potentially fooling the above check and causing
reference underflow.

To avoid such issue, introduce and use a new field to mark the entries
with refcount elevated. No functional change intended.

Before:
pahole -EC rt6_info
/* size: 224, cachelines: 4, members: 9 */
/* sum members: 218, holes: 1, sum holes: 4 */

After:
pahole: -EC rt6_info
/* size: 224, cachelines: 4, members: 10 */
/* sum members: 219, holes: 1, sum holes: 4 */

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/ip6_fib.h | 3 +++
 net/ipv6/route.c      | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 6cb867ce4878..eb997af5523c 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -216,6 +216,9 @@ struct rt6_info {
 
 	/* more non-fragment space at head required */
 	unsigned short			rt6i_nfheader_len;
+
+	/* route lookup always acquires a reference */
+	bool				rt6i_count_held;
 };
 
 struct fib6_result {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index bbc2a0dd9314..3b729ab86c55 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2251,6 +2251,7 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 			 * this refcnt is always returned to the caller even
 			 * if caller sets RT6_LOOKUP_F_DST_NOREF flag.
 			 */
+			rt->rt6i_count_held = true;
 			rt6_uncached_list_add(rt);
 			rcu_read_unlock();
 
@@ -2648,8 +2649,7 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
 	rcu_read_lock();
 	dst = ip6_route_output_flags_noref(net, sk, fl6, flags);
 	rt6 = dst_rt6_info(dst);
-	/* For dst cached in uncached_list, refcnt is already taken. */
-	if (list_empty(&rt6->dst.rt_uncached) && !dst_hold_safe(dst)) {
+	if (!rt6->rt6i_count_held && !dst_hold_safe(dst)) {
 		dst = &net->ipv6.ip6_null_entry->dst;
 		dst_hold(dst);
 	}
-- 
2.43.2


