Return-Path: <netdev+bounces-257254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FOGLfzIhGk45QMAu9opvQ
	(envelope-from <netdev+bounces-257254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:44:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A7F5669
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C48113003369
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB243901A;
	Thu,  5 Feb 2026 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmMj+7Nr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C3439016
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309881; cv=none; b=SCLlm6PCcyHiVf6YgOdMDRsgHDjpoil9YMJjP+93HZ+dfOV3EFd3MjnUtCHBQ7VmV8RSB2g+pfqkqmv9ScxnRz2Zo7nAgFy7lamlCT2YQ13OYWbYZ/2JcQuZlA3oBY4CdHZFwn+wdl8Q6oeeAD/2ZF2Z4qodPvXMrb8gK5hAdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309881; c=relaxed/simple;
	bh=cC780z+ULXpn2R422iIuY4bndlsWdpYrl4S52PEPcmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=owgDKOm5zK2Xsxjpy3H66WageZhew0LSVO0dxhD8RIFJZ6d0Jxs8WxVw9g/oVBNIJdqgY+s0rBMwwQ0gz4pf6hcXWr6XHlFUDvMLJaGKpA+BzZQwX08CeQ+TDp96ynSxrM2e9YO+/A4BNOWjwkwqt0H66J3y3gmf1Z7HumQTEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmMj+7Nr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770309879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gg8TKjFriCRv5ixuZCBnxbOHh9q0a85XR/N3Qj2Urq8=;
	b=GmMj+7Nrq2rmaa+JIzRPK08I4zRxgH0ZXRykvK0myf5sU8KaW0vLQ85+Ql/7lvX2w4Lyj3
	Pcwy27FYnhJmD6BGYgbKYxbHqBXCwTwmoUz6lko7pw34SkqtLUCegyk55K+54dJMK/+5vR
	bM+3Q41wwHaYBZxR54z6FgVwyQop3O8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-jNuQsJroOUe8WsjOGsQydQ-1; Thu,
 05 Feb 2026 11:44:38 -0500
X-MC-Unique: jNuQsJroOUe8WsjOGsQydQ-1
X-Mimecast-MFC-AGG-ID: jNuQsJroOUe8WsjOGsQydQ_1770309877
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2BEE195609F;
	Thu,  5 Feb 2026 16:44:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DCE019560B5;
	Thu,  5 Feb 2026 16:44:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [RFC PATCH] xfrm: reduce struct sec_path size
Date: Thu,  5 Feb 2026 17:44:14 +0100
Message-ID: <a2552992ca2fa29754340eaa05b1a185fca7a381.1770309837.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257254-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A9A7F5669
X-Rspamd-Action: no action

The mentioned struct has an hole and uses unnecessary wide type to
store a MAC length.

It's also embedded into the skb_extensions, and the latter, due
to recent CAN changes, may exceeds the 192 bytes mark (3 cachelines
on x86_64 arch) on some reasonable configuration.

Reordering and the sec_path fields and shrinking xfrm_offload.orig_mac_len
to 16 bits, we can save 8 bytes and keep skb_extensions size under
control.

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
	int                        len;
	int                        olen;
	struct xfrm_offload        ovec[1];
	int                        verified_cnt;
	struct xfrm_state *        xvec[6];

	/* size: 80, cachelines: 2, members: 5 */
	/* last cacheline: 16 bytes */
};

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
only build tested, any feedback appreciated.
---
 include/net/xfrm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 0a14daaa5dd4..41122cb83901 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1156,7 +1156,7 @@ struct xfrm_offload {
 #define CRYPTO_INVALID_PROTOCOL			128
 
 	/* Used to keep whole l2 header for transport mode GRO */
-	__u32			orig_mac_len;
+	__u16			orig_mac_len;
 
 	__u8			proto;
 	__u8			inner_ipproto;
@@ -1165,10 +1165,10 @@ struct xfrm_offload {
 struct sec_path {
 	int			len;
 	int			olen;
+	struct xfrm_offload	ovec[XFRM_MAX_OFFLOAD_DEPTH];
 	int			verified_cnt;
 
 	struct xfrm_state	*xvec[XFRM_MAX_DEPTH];
-	struct xfrm_offload	ovec[XFRM_MAX_OFFLOAD_DEPTH];
 };
 
 struct sec_path *secpath_set(struct sk_buff *skb);
-- 
2.52.0


