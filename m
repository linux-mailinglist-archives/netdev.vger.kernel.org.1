Return-Path: <netdev+bounces-259315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP64JiDJlWkrUwIAu9opvQ
	(envelope-from <netdev+bounces-259315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 15:13:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B44156FD1
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 15:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AEC4301050E
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB40329E70;
	Wed, 18 Feb 2026 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DjT3FkAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D33629B78D
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424029; cv=none; b=u5j3vRgIFMa9EcYAyBatYvd+fF8WqiwSPCWRCsNt/gChJG3GmzUfLagsOl5Aa7hAabBynAPkjn9rnhIVwQo5M9yiZylXS0DiR8Yxps2cfLiIu9tR1tXeEvowX7BuVtPNS3Xl9Ra/QRilP3vrdxA5T8VFXlWxN8Z4YhIt6HKswSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424029; c=relaxed/simple;
	bh=fUsK/1wSOyxT8Uza1ypic0MyT0+1naThS29o5HKP0HQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XbbeJh7UwnEX+fuSfanblTShTjn/F53X78Q2nxwsKNfmW0ynGxb1gUn3ED7fmWcnSju/gLpTs5PZ3o/TnqZjZxnOAHrSSx76mJ7wwicz8564RB7NSCmkS+jkFLBskrj3yEN3UHfGMvknd/pWNT49s+AbOaLORbHu5t80xS1pSoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DjT3FkAy; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-64adb64a043so9266494d50.3
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 06:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771424027; x=1772028827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oEbEQHETU+wWkRSEHCJbQqDGDFcZphgAHD76Avzy45g=;
        b=DjT3FkAyVWYgqhU1eWtydbB9m5HqG1HI+nyTPQ0aGDvZWhrEYDI4/oyBmknraXm3mp
         RtTAETGzpnHGrIgnROgvlKC53aIWE8Q2R2ENe+vRq2ON8SMlMPMWAdZkrSOCkLiBMRPi
         nP9FLzdKd4iNIbpGoJmUJ4BVJLsKD90bW+wsJk1ZDa/q7vD1JjNFRL6qInEOPKGzy4ha
         8h8H2BMz9VBsE533JUp4Plu6IWdmsVJLiTHjQsMKQbCx7VsV9hk9dopVBwIzRtxYfVqW
         FMoD99/ovPUF5V0VC8fOrUSi1xGoRbUV49WXab+KjrpQ2f4KwJClOBhdA++8SLaNiuqc
         e04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771424027; x=1772028827;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEbEQHETU+wWkRSEHCJbQqDGDFcZphgAHD76Avzy45g=;
        b=DKGLO1LKcLB95ifvFCSYmaQW9tJzym1WHOeqnuxnMDVZFeBdydJ+lFwjAg2inuCe7q
         fBGHzqS67YZCCkpsTtbfSNfX67VhsDNfChtkwnM1PUCJXaI5pkcyALz4k6Lt6K2rPRDx
         Na7FvfsAQ6fgcRTXquPZOMk5nsXvEBUjVwqJxh8bkGOp+SOrETAFJ7wciiFLVFpIGirS
         qrjQElbcyfa4sJw9DdACwfSKiFyf0fdsYpj0/VSCDCQNU9nqY9knxAIR/7U3DJBtvfqD
         3MwexaMHcIoXd8xVqqnTXBNHVnFs7K2aXryrc/85CSkDrnEwayKzUHi1JFrQEPDwk6Hm
         iXjg==
X-Forwarded-Encrypted: i=1; AJvYcCW69kur5NdrdLlbJtaHoyV1dF4f95yFoIg9qtt81tlZsejYlY6CCA6cIDWsUCuo6f/tYbkIIzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9WFY2wuv7MVKIOfbZ0yvOqXqBjP1fY/+k+Ni4YDZohj4veIu
	wmrNu33Vey9A4Vgk3fN9vlNz5k+7yp+S+V4HpCoQKH89flUOxZU8MfXUiiGgmEZtZNmR8P9BUfL
	XvcIsIVAG54ZfAA==
X-Received: from yxom16.prod.google.com ([2002:a53:c350:0:b0:644:7109:1048])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1209:b0:649:5423:c10e with SMTP id 956f58d0204a3-64c21a9a618mr9175464d50.38.1771424027141;
 Wed, 18 Feb 2026 06:13:47 -0800 (PST)
Date: Wed, 18 Feb 2026 14:13:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260218141337.999945-1-edumazet@google.com>
Subject: [PATCH net] psp: use sk->sk_hash in psp_write_headers()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Raed Salem <raeds@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259315-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,nvidia.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1B44156FD1
X-Rspamd-Action: no action

udp_flow_src_port() is indirectly using sk->sk_txhash as a base,
because __tcp_transmit_skb() uses skb_set_hash_from_sk().

This is problematic because this field can change over the
lifetime of a TCP flow, thanks to calls to sk_rethink_txhash().

Problem is that some NIC might (ab)use the PSP UDP source port in their
RSS computation, and PSP packets for a given flow could jump
from one queue to another.

In order to avoid surprises, it is safer to let Protective Load
Balancing (PLB) get its entropy from the IPv6 flowlabel,
and change psp_write_headers() to use sk->sk_hash which
does not change for the duration of the flow.

We might add a sysctl to select the behavior, if there
is a need for it.

Fixes: fc724515741a ("psp: provide encapsulation helper for drivers")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Raed Salem <raeds@nvidia.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/psp/psp_main.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index a8534124f62669cf8b3611d5352e3827982d871d..066222eb56c4af187791445f30a70443aef8a6d8 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -166,9 +166,46 @@ static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
 {
 	struct udphdr *uh = udp_hdr(skb);
 	struct psphdr *psph = (struct psphdr *)(uh + 1);
+	const struct sock *sk = skb->sk;
 
 	uh->dest = htons(PSP_DEFAULT_UDP_PORT);
-	uh->source = udp_flow_src_port(net, skb, 0, 0, false);
+
+	/* A bit of theory: Selection of the source port.
+	 *
+	 * We need some entropy, so that multiple flows use different
+	 * source ports for better RSS spreading at the receiver.
+	 *
+	 * We also need that all packets belonging to one TCP flow
+	 * use the same source port through their duration,
+	 * so that all these packets land in the same receive queue.
+	 *
+	 * udp_flow_src_port() is using sk_txhash, inherited from
+	 * skb_set_hash_from_sk() call in __tcp_transmit_skb().
+	 * This field is subject to reshuffling, thanks to
+	 * sk_rethink_txhash() calls in various TCP functions.
+	 *
+	 * Instead, use sk->sk_hash which is constant through
+	 * the whole flow duration.
+	 */
+	if (likely(sk)) {
+		u32 hash = sk->sk_hash;
+		int min, max;
+
+		/* These operations are cheap, no need to cache the result
+		 * in another socket field.
+		 */
+		inet_get_local_port_range(net, &min, &max);
+		/* Since this is being sent on the wire obfuscate hash a bit
+		 * to minimize possibility that any useful information to an
+		 * attacker is leaked. Only upper 16 bits are relevant in the
+		 * computation for 16 bit port value because we use a
+		 * reciprocal divide.
+		 */
+		hash ^= hash << 16;
+		uh->source = htons((((u64)hash * (max - min)) >> 32) + min);
+	} else {
+		uh->source = udp_flow_src_port(net, skb, 0, 0, false);
+	}
 	uh->check = 0;
 	uh->len = htons(udp_len);
 
-- 
2.53.0.310.g728cabbaf7-goog


