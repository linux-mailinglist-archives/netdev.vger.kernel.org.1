Return-Path: <netdev+bounces-274455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGnmLSlDzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:21:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AA0387A15
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEB613009F3B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A17739E6C7;
	Thu,  2 Apr 2026 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUkx+KdP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D310537DE88
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125056; cv=none; b=ZnzUIVbnVAPGt3N/TgeWxeR117tB3XEQ8NvqofjXxQSkumxoZItrmuhhwvN6e86vLrX/nL5vEhLup1KBA9wnGXy+egqBu8hrTBXGIubiJaox2KWzFZrY7Hh3K3IhbFQiChZKsLlyVF5c7j5pyczYb+ChYxya9DKVWTtrJXvYUc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125056; c=relaxed/simple;
	bh=SerJ/08bf9rTo+kdHRdoRxKtcpjzCujtq0QR6ap7oSo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G/foOsamZXgjULhfRDTM8z5m/F0tVDF/RzcHSQTdJccBNu/yDZXzHZIvZLW5zlZ4YzECgs5W0czAq2CMv8K4i2N5CkJ9zwIMif8J+aWsGV7B4iDcKF6mqX3u2EuPD5TFKSFlVJ6kXjyX+1QTz79j6SoF5bXPHPIEa/p9Eg0Of9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUkx+KdP; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50937cf66b5so31585791cf.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775125054; x=1775729854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pOuoDznHeNQdGkd3woq0Fme91skGEJ8sQNsxXLx9f1A=;
        b=gUkx+KdPPhUFKlZHO+LO6GLmVv7wju2rwMopB9oFPNOHtPeWKuTlUfY86K0vHQqrDv
         tSQx/x0uP1+/nddPKTUytzcVypA60gftCrpWd73V9tUJoCV2vQa7quqn2j0bAjzI/RR5
         szo4aXw95MiubXYaPT736ueSRSZ5PNJxtoKngXVx009INzHsjqIKgN+wvoSmw+a6GI35
         +VL2XlI9vXW28GkFf3+4vYIEmKzodwPzpMyyKyZq2t3UgFX/jyoXxwH6Ieg0CLo5ZYvQ
         8hhf2W/9jwEZDla9gENLc1ts7Syb37IvONlKOrf8rKZSc6BrWbM3C8BHdWzDQdiyXRsN
         9ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775125054; x=1775729854;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOuoDznHeNQdGkd3woq0Fme91skGEJ8sQNsxXLx9f1A=;
        b=oAajhEUfuAyIICK1l2gJRWiu8O7Ma647S1GvJcGZlYyR803WCNwIk+FrCEbiHHrzVG
         PXWrSdnhZamysuNH1jrs0bvP+y7TlUwpkIj6c9NKfP0Wy6b1ZCwETKPhJ9uUitey5Co5
         UKM9aH/A73RTXZ/BOCPmUExw4DhI3KEtaLkd8ApViB4Q0g0mOOxzCfIZvdCGRifjLSI3
         sxmt8AWg3WqYuMV7He5yQqnRkWfTayC1UZ/xiHXWMpx+Mlp/ubBF32BqWpIVGPCq3R1O
         iZaoqZ4yfjVCYx8LJrgy2R/qcmufdL0yQgOSxSIEr2GT2Rmdl6uQKZmOxxYR+UKIjdj+
         83iA==
X-Forwarded-Encrypted: i=1; AJvYcCXxl/ULU+D8/1Nb9UzY4lTOprjI05WeH/4JpPZBxaOAyY4pWcwfYpkkmpMku1Vtu1f1W0xGCBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweRvJw33FZgaxIv6TPzNv3G8SCWvS2Vb+nxudyZlgF/a2sf9rR
	HCELDyUtbQ46goP+0UHrrR+wqkNMHRteKiIOVC7fRKhuxMGQGSw0aBKPDWDXofDPHNgvgWTzRQf
	WpPVeuu0v9RsBkg==
X-Received: from qtug16.prod.google.com ([2002:ac8:7750:0:b0:509:19dc:f99])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f52:0:b0:509:4198:5474 with SMTP id d75a77b69052e-50d3bb5c7cemr98357591cf.2.1775125053536;
 Thu, 02 Apr 2026 03:17:33 -0700 (PDT)
Date: Thu,  2 Apr 2026 10:17:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260402101732.1188059-1-edumazet@google.com>
Subject: [PATCH net] ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Yiming Qian <yimingqian591@gmail.com>, Justin Iurman <justin.iurman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274455-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28AA0387A15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We need to check __in6_dev_get() for possible NULL value, as
suggested by Yiming Qian.

Also add skb_dst_dev_rcu() instead of skb_dst_dev(),
and two missing READ_ONCE().

Note that @dev can't be NULL.

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Justin Iurman <justin.iurman@gmail.com>
---
 net/ipv6/ioam6.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 3978773bec424890cd18db78cf7cac9d3d652130..05a0b7d7e2aac35f634641fc4a791d1965dc85fd 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -710,7 +710,9 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 				    struct ioam6_schema *sc,
 				    unsigned int sclen, bool is_input)
 {
-	struct net_device *dev = skb_dst_dev(skb);
+	/* Note: skb_dst_dev_rcu() can't be NULL at this point. */
+	struct net_device *dev = skb_dst_dev_rcu(skb);
+	struct inet6_dev *i_skb_dev, *idev;
 	struct timespec64 ts;
 	ktime_t tstamp;
 	u64 raw64;
@@ -721,13 +723,16 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 
 	data = trace->data + trace->remlen * 4 - trace->nodelen * 4 - sclen * 4;
 
+	i_skb_dev = skb->dev ? __in6_dev_get(skb->dev) : NULL;
+	idev = __in6_dev_get(dev);
+
 	/* hop_lim and node_id */
 	if (trace->type.bit0) {
 		byte = ipv6_hdr(skb)->hop_limit;
 		if (is_input)
 			byte--;
 
-		raw32 = dev_net(dev)->ipv6.sysctl.ioam6_id;
+		raw32 = READ_ONCE(dev_net(dev)->ipv6.sysctl.ioam6_id);
 
 		*(__be32 *)data = cpu_to_be32((byte << 24) | raw32);
 		data += sizeof(__be32);
@@ -735,18 +740,18 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 
 	/* ingress_if_id and egress_if_id */
 	if (trace->type.bit1) {
-		if (!skb->dev)
+		if (!i_skb_dev)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id);
+			raw16 = (__force u16)READ_ONCE(i_skb_dev->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
 
-		if (dev->flags & IFF_LOOPBACK)
+		if ((dev->flags & IFF_LOOPBACK) || !idev)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id);
+			raw16 = (__force u16)READ_ONCE(idev->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
@@ -822,7 +827,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (is_input)
 			byte--;
 
-		raw64 = dev_net(dev)->ipv6.sysctl.ioam6_id_wide;
+		raw64 = READ_ONCE(dev_net(dev)->ipv6.sysctl.ioam6_id_wide);
 
 		*(__be64 *)data = cpu_to_be64(((u64)byte << 56) | raw64);
 		data += sizeof(__be64);
@@ -830,18 +835,18 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 
 	/* ingress_if_id and egress_if_id (wide) */
 	if (trace->type.bit9) {
-		if (!skb->dev)
+		if (!i_skb_dev)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id_wide);
+			raw32 = READ_ONCE(i_skb_dev->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
 
-		if (dev->flags & IFF_LOOPBACK)
+		if ((dev->flags & IFF_LOOPBACK) || !idev)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id_wide);
+			raw32 = READ_ONCE(idev->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
-- 
2.53.0.1185.g05d4b7b318-goog


