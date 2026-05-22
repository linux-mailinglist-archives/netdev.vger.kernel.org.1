Return-Path: <netdev+bounces-290818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOonCgJKEGpvVwYAu9opvQ
	(envelope-from <netdev+bounces-290818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:20:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B7C5B3CBB
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DC1C308E4EB
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308036606A;
	Fri, 22 May 2026 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhRcAvVF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208D33BBC0;
	Fri, 22 May 2026 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451612; cv=none; b=icpfpflzIbKWAJRMI+FD5uFJ6G3HOPGZ3M1oRNm5uJBTR3bCMHMfMkWr8lOD4MPyAymswXVKDn3o7Y1xfFbl3Pr9Ww9iHCTt1eGro+BptIOC9brJ4KSNMRYFUXFEJx4jLKb/GVtmxMh1o7RBmPW3kKmqGl+KAHeGOWW2hHs7X0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451612; c=relaxed/simple;
	bh=GjTiZt/xj6UNkgjEW+4mkYdrEGDd52xNFyaWXFgkbIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HgIPNVOdxrCddqYhF+DCMYFtVNw+/EAvHBqFD2QWeyzMEo/x1WCu3C0P1NG9itLXZudONS94sIL6wFHGpn+C13upe9W4lLqnEJiXJyIcF/ouk1Hr4ovSK01qs8+L2Xkhds9TaregTkTNt6K3hnkrnnbUW3YzIghDV3xr9+WXLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhRcAvVF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C171F000E9;
	Fri, 22 May 2026 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779451610;
	bh=d1krxEP8uuaD7ldT0A55o740Jb3B+aiza+neGDFsH9U=;
	h=From:To:Cc:Subject:Date;
	b=KhRcAvVFnaEkL4XwtHj6d/jlKk66wybCh7dbAujO4oo42tVYsL7Sa5nyYONhFm9vI
	 C9wf2nqFEBhWJ8Tz01Oyy9YtuzYcIhe4upZ+0YB2JEmF/0hgOe3qZYqMhRM35p0hm+
	 ZjbDYmvO0yOMnnJ1jpuBuxq6u4OTC0JKF0BgmJwcYacrUpeW7uI0bhTKFMfVqx75q2
	 pfCYS1MrgoQL8aNtS5unRvON0sUstl9XAVbWNK0gOlR4Tto5HB/BXp0NIqCsZAjhIN
	 pD2sM0SdjRR7GPYr46yvViRvj3K2z2lFY4A1F7PSNRbBsBKb81Jmr7dLDM0gOocz++
	 etJDv/dv7gYAw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: Avoid checksumming unreadable skb tail on trim
Date: Fri, 22 May 2026 14:06:40 +0200
Message-ID: <20260522120643.242974-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.39 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.77)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290818-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 79B7C5B3CBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pskb_trim_rcsum_slow() keeps CHECKSUM_COMPLETE valid by subtracting
the checksum of the bytes removed from the skb tail. That assumes the
removed bytes can be read.

io_uring zcrx skbs may contain unreadable net_iov frags. With fbnic
header/data split, small TCP/IPv4 packets can carry Ethernet padding
in such a frag. ip_rcv_core() trims the skb to iph->tot_len before TCP
sees it, and the CHECKSUM_COMPLETE adjustment then calls
skb_checksum() on the padding.

This is exposed by IPv4 because small TCP/IPv4 frames can be shorter
than the Ethernet minimum payload. TCP/IPv6 frames are large enough in
the normal zcrx path, so they do not hit the same padding trim.

Keep the existing checksum adjustment for readable skbs. If the
remaining packet is fully linear, drop CHECKSUM_COMPLETE and let the
stack validate the packet after trimming. If unreadable payload would
remain, fail the trim; the checksum cannot be adjusted without reading
the trimmed tail.

Also clear skb->unreadable when trimming removes all frags.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 net/core/skbuff.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 44ac121cfccb..d247acd447e4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2787,6 +2787,8 @@ int ___pskb_trim(struct sk_buff *skb, unsigned int len)
 		skb->data_len  = 0;
 		skb_set_tail_pointer(skb, len);
 	}
+	if (!skb_shinfo(skb)->nr_frags && !skb_has_frag_list(skb))
+		skb->unreadable = 0;
 
 	if (!skb->sk || skb->destructor == sock_edemux)
 		skb_condense(skb);
@@ -2794,16 +2796,37 @@ int ___pskb_trim(struct sk_buff *skb, unsigned int len)
 }
 EXPORT_SYMBOL(___pskb_trim);
 
+static int pskb_trim_rcsum_complete(struct sk_buff *skb, unsigned int len)
+{
+	int delta = skb->len - len;
+
+	if (skb_frags_readable(skb)) {
+		skb->csum = csum_block_sub(skb->csum,
+					   skb_checksum(skb, len, delta, 0),
+					   len);
+		return 0;
+	}
+
+	if (len > skb_headlen(skb))
+		return -EFAULT;
+
+	/* The trimmed bytes are unreadable, but the remaining packet can be
+	 * checksummed by software after trimming.
+	 */
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
 /* Note : use pskb_trim_rcsum() instead of calling this directly
  */
 int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
 {
 	if (skb->ip_summed == CHECKSUM_COMPLETE) {
-		int delta = skb->len - len;
+		int err;
 
-		skb->csum = csum_block_sub(skb->csum,
-					   skb_checksum(skb, len, delta, 0),
-					   len);
+		err = pskb_trim_rcsum_complete(skb, len);
+		if (err)
+			return err;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int hdlen = (len > skb_headlen(skb)) ? skb_headlen(skb) : len;
 		int offset = skb_checksum_start_offset(skb) + skb->csum_offset;

base-commit: 68993ced0f618e36cf33388f1e50223e5e6e78cc
-- 
2.54.0


