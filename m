Return-Path: <netdev+bounces-117114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0455694CC1F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3182830D6
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABC918DF9F;
	Fri,  9 Aug 2024 08:24:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37418C326
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191890; cv=none; b=hKbkWJoiLavO0S4RSA7ptXo3/GT9xKXCP5IqAsF3yDsHsr0EG88u6xUfvnajmElF+AEB49/KP+3FjCrhsMlpeKyzsKN/ZZqmIAqdWR8k/hLJ+QVamI1WeHnxuiTMuMuTHuu7h+RiRj3Gq8j8yw9I4B0t00L2m+DFuMseyN7D7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191890; c=relaxed/simple;
	bh=cbgTpwOS/qRfqB5SjxeDdukIKfKA58ahGwKHhqhrTEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uz4D5eZbn5i3sTWFlx6PE+IPNkxVNaadf8ef5OuE6Q7WMq03r/Q0f3Sf3gpkMqCqEXLUkdhWLzc+DnTRM7fUOa8fEODa3ogMyZUWYHfGgGGT+g+6tQzrPJn8g3XGsygN3u8xedXgUePZzIfLQp4YzRyQw6yaOiflfJUbwioQGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 507AB7D120;
	Fri,  9 Aug 2024 08:24:47 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v1 1/2] net: refactor common skb header copy code for re-use
Date: Fri,  9 Aug 2024 04:23:13 -0400
Message-ID: <20240809082314.2810408-2-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809082314.2810408-1-chopps@chopps.org>
References: <20240809082314.2810408-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Factor out some common skb header copying code so that it can be re-used
outside of skbuff.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 include/linux/skbuff.h | 1 +
 net/core/skbuff.c      | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 29c3ea5b6e93..8626f9a343db 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1374,6 +1374,7 @@ struct sk_buff *skb_morph(struct sk_buff *dst, struct sk_buff *src);
 void skb_headers_offset_update(struct sk_buff *skb, int off);
 int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask);
 struct sk_buff *skb_clone(struct sk_buff *skb, gfp_t priority);
+void ___copy_skb_header(struct sk_buff *new, const struct sk_buff *old);
 void skb_copy_header(struct sk_buff *new, const struct sk_buff *old);
 struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t priority);
 struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d1..da5a47d2c9ab 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1515,7 +1515,7 @@ EXPORT_SYMBOL(napi_consume_skb);
 	BUILD_BUG_ON(offsetof(struct sk_buff, field) !=		\
 		     offsetof(struct sk_buff, headers.field));	\
 
-static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
+void ___copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 {
 	new->tstamp		= old->tstamp;
 	/* We do not copy old->sk */
@@ -1524,6 +1524,12 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 	skb_dst_copy(new, old);
 	__skb_ext_copy(new, old);
 	__nf_copy(new, old, false);
+}
+EXPORT_SYMBOL_GPL(___copy_skb_header);
+
+static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
+{
+	___copy_skb_header(new, old);
 
 	/* Note : this field could be in the headers group.
 	 * It is not yet because we do not want to have a 16 bit hole
-- 
2.46.0


