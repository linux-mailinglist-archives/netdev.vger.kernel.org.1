Return-Path: <netdev+bounces-257625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKJVG7ghhmm/JwQAu9opvQ
	(envelope-from <netdev+bounces-257625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:15:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BEE100D48
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D7343006837
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCC83A1E72;
	Fri,  6 Feb 2026 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5tG2MhE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678CD29AAFA
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398129; cv=none; b=tLVYAbv/xo6v+8+8URdRkACPD2uCku1uafBu60wxwv+98fQEsYYWLgTtsHjOeWmd8ych/TmYYRETeFCQEoyZikeD6ETCch0xlFf91h0s2wOG7HZiR1Dp1EPIV2qfbkLSetXM8XLs8A5QKgonc+lY3ojHhhA7HZ0yXoPhHQgZies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398129; c=relaxed/simple;
	bh=HkElroGZVk3RRscduN3Kmk506Ncb/7nmteEuajK1CPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZadyZsAPC8qZ8rI1S0pwBQy7hT+uNHPj8g8Hr+fmZCjlrjb7uLpLctFXMqc2EHe8wX1fYnaSWqT0w2k2/iOwGVBOeEblJyLvVxHtYj48eLzsSfJwT2vC5c6i1dhVZJwe6418wnQsFXCxpwFQbp59ZCTw2y63g5D9wrzOJHjqlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5tG2MhE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770398128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k5Fx3pdcilBHfzUSMjvyCmeVm379Jrzk5/xcce1yxgk=;
	b=Z5tG2MhEc8IS78pCLznjpams7bKotpk5770fanzWkWibOsvdcK9wy6RE5uINAtwm21qa7J
	2Z4JY5CU4l88yhBN8j4hXAaxUrbQTHsfNqPKbP15idGTMXR9xb4HhvAWfzAhx3Bm/MZlzi
	21M3++8U9bWVikyma+5dhGOsLtItXfM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-Zpe13dnFN7KvQ6EHjYtUIQ-1; Fri,
 06 Feb 2026 12:15:25 -0500
X-MC-Unique: Zpe13dnFN7KvQ6EHjYtUIQ-1
X-Mimecast-MFC-AGG-ID: Zpe13dnFN7KvQ6EHjYtUIQ_1770398123
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A5111955F20;
	Fri,  6 Feb 2026 17:15:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.134])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CBD118003F6;
	Fri,  6 Feb 2026 17:15:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next] xfrm: reduce struct sec_path size
Date: Fri,  6 Feb 2026 18:14:36 +0100
Message-ID: <83846bd2e3fa08899bd0162e41bfadfec95e82ef.1770398071.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257625-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87BEE100D48
X-Rspamd-Action: no action

The mentioned struct has an hole and uses unnecessary wide type to
store MAC length and indexes of very small arrays.

It's also embedded into the skb_extensions, and the latter, due
to recent CAN changes, may exceeds the 192 bytes mark (3 cachelines
on x86_64 arch) on some reasonable configurations.

Reordering and the sec_path fields, shrinking xfrm_offload.orig_mac_len
to 16 bits and xfrm_offload.{len,olen,verified_cnt} to u8, we can save
16 bytes and keep skb_extensions size under control.

Before:

struct sec_path {
	int                        len;
	int                        olen;
	int                        verified_cnt;

	/* XXX 4 bytes hole, try to pack */$
	struct xfrm_state *        xvec[6];
	struct xfrm_offload ovec[1];

	/* size: 88, cachelines: 2, members: 5 */
	/* sum members: 84, holes: 1, sum holes: 4 */
	/* last cacheline: 24 bytes */
};

After:

struct sec_path {
	struct xfrm_state *        xvec[6];
	struct xfrm_offload        ovec[1];
	/* typedef u8 -> __u8 */ unsigned char              len;
	/* typedef u8 -> __u8 */ unsigned char              olen;
	/* typedef u8 -> __u8 */ unsigned char              verified_cnt;

	/* size: 72, cachelines: 2, members: 5 */
	/* padding: 1 */
	/* last cacheline: 8 bytes */
};

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
RFC -> v1:
  - shrink lens fields - thanks Florian
- RFC: https://lore.kernel.org/netdev/a2552992ca2fa29754340eaa05b1a185fca7a381.1770309837.git.pabeni@redhat.com/
---
 include/net/xfrm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 0a14daaa5dd4..10d3edde6b2f 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1156,19 +1156,19 @@ struct xfrm_offload {
 #define CRYPTO_INVALID_PROTOCOL			128
 
 	/* Used to keep whole l2 header for transport mode GRO */
-	__u32			orig_mac_len;
+	__u16			orig_mac_len;
 
 	__u8			proto;
 	__u8			inner_ipproto;
 };
 
 struct sec_path {
-	int			len;
-	int			olen;
-	int			verified_cnt;
-
 	struct xfrm_state	*xvec[XFRM_MAX_DEPTH];
 	struct xfrm_offload	ovec[XFRM_MAX_OFFLOAD_DEPTH];
+
+	u8			len;
+	u8			olen;
+	u8			verified_cnt;
 };
 
 struct sec_path *secpath_set(struct sk_buff *skb);
-- 
2.52.0


