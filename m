Return-Path: <netdev+bounces-287686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDNyO7OyBGoQNQIAu9opvQ
	(envelope-from <netdev+bounces-287686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:19:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A73537EAA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D125312C192
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEF148BD37;
	Wed, 13 May 2026 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAc4oru2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689623911C6
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690962; cv=none; b=u59x/Q4X4jh8ucGUWuqEruLx6wGmyriYBq0ckg/nx5ib/uRn3hmNm8H0EhywG399Fl8TyMKFMkyPL/POjDAHQldLF8fTUB96HYOM7G4k32LxrLxEcceLz09MfQGeNU4QxC0uRKJYzkn9RvnbU3Fhoog5M9YuMufnE6hKvBD3f3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690962; c=relaxed/simple;
	bh=54zp18B98llZ85HXlGDx2qPTv0WRGGbWEyB/lqatiw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnInj9kJzf9QFpdCIiE5Zz0197yfgLhVKgTHFHN4GlsHQGnu6JjSTiNcxmFZjqg1AmR+hJjJcEYzu32nQZh0suv80eUcOaPHS3AgIRPnCoSQhFgFpOuJ36tI+lnA+yKNdahNWlysn5718RTBLLfNEGc9+fXnsChztQ5onZ8NI9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAc4oru2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6958C2BCC6;
	Wed, 13 May 2026 16:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778690962;
	bh=54zp18B98llZ85HXlGDx2qPTv0WRGGbWEyB/lqatiw4=;
	h=From:To:Cc:Subject:Date:From;
	b=EAc4oru2lRMJQSQ6NPcAHQuzCNaBP4ZktB00iK3UxLcu6KPfuvdCUSE++2QjP3jJu
	 yanzCl3pSbeML69MuFVg2T7Ut+sfYqWMmMedQa8LkgGeGW+G2VXU4T/CMUeBFrAoxN
	 v5cODF8kj17daOwicnTx0Kw3Yz1GeLss5KKRtAvoOgu3yfabpXeSJbAKFKHTN2Fv7W
	 yZ+1HU1BVBWCljs0E1DF0jxBrJ3BPLa4mcS4nLVAcPHm1zb2lO8R9jk1amfipucKsJ
	 fz8G1U0z0TjVN0O+07RA/U2K8RejQUVi+T9cZh+3blNI33v2zFIly3NDVRKFvz85/0
	 gx4FCSF7wu6qw==
From: David Ahern <dsahern@kernel.org>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	David Ahern <dahern@nvidia.com>,
	Leo Lin <leo@depthfirst.com>
Subject: [PATCH net] xfrm: Check for underflow in xfrm_state_mtu
Date: Wed, 13 May 2026 10:49:14 -0600
Message-ID: <20260513164918.33145-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 59A73537EAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287686-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: David Ahern <dahern@nvidia.com>

Leo Lin reported OOB write issue in esp component:

  xfrm_state_mtu() returns u32 but performs its arithmetic in unsigned
  modulo-2^32 space using an attacker-influenced "header_len + authsize +
  net_adj" subtracted from a small "mtu" argument. A nobody user can
  install an IPv4 ESP tunnel SA with a large authentication key
  (XFRMA_ALG_AUTH_TRUNC, e.g. hmac(sha512), 64-byte key, 64-byte trunc),
  configure a small interface MTU (68 bytes), and set XFRMA_TFCPAD to a
  large value. When a single UDP datagram is then sent through the
  tunnel, xfrm_state_mtu() underflows to a near-2^32 value, and
  esp_output() consumes it as a signed int via:

        padto      = min(x->tfcpad, xfrm_state_mtu(x, mtu_cached))
        esp.tfclen = padto - skb->len   (assigned to int)

  esp.tfclen ends up negative (e.g. -207). It is sign-extended to size_t
  when passed to memset() inside esp_output_fill_trailer(), producing a
  ~16 EB write of zeroes at skb_tail_pointer(skb). KASAN logs it as
  "Write of size 18446744073709551537 at addr ffff888...".

Check for underflow and return 1. This causes the sendmsg attempt to
fail with ENETUNREACH.

Fixes: c5c252389374 ("[XFRM]: Optimize MTU calculation")
Reported-by: Leo Lin <leo@depthfirst.com>
Assisted-by: Codex:26.506.31004
Signed-off-by: David Ahern <dahern@nvidia.com>
---
 net/xfrm/xfrm_state.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 686014d39429..f597e4996bb2 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3114,10 +3114,14 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 	const struct xfrm_type *type = READ_ONCE(x->type);
 	struct crypto_aead *aead;
 	u32 blksize, net_adj = 0;
+	u32 overhead, payload_mtu;
 
 	if (x->km.state != XFRM_STATE_VALID ||
-	    !type || type->proto != IPPROTO_ESP)
+	    !type || type->proto != IPPROTO_ESP) {
+		if (mtu <= x->props.header_len)
+			return 1;
 		return mtu - x->props.header_len;
+	}
 
 	aead = x->data;
 	blksize = ALIGN(crypto_aead_blocksize(aead), 4);
@@ -3140,8 +3144,17 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 		break;
 	}
 
-	return ((mtu - x->props.header_len - crypto_aead_authsize(aead) -
-		 net_adj) & ~(blksize - 1)) + net_adj - 2;
+	overhead = x->props.header_len + crypto_aead_authsize(aead) + net_adj;
+	if (mtu <= overhead)
+		return 1;
+
+	payload_mtu = mtu - overhead;
+	payload_mtu &= ~(blksize - 1);
+	if (payload_mtu <= 2)
+		return 1;
+
+	return payload_mtu + net_adj - 2;
+
 }
 EXPORT_SYMBOL_GPL(xfrm_state_mtu);
 
-- 
2.43.0


