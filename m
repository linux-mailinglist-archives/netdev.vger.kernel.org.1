Return-Path: <netdev+bounces-268166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMJPJbwHuGkWYQEAu9opvQ
	(envelope-from <netdev+bounces-268166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:38:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1062729A949
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09878301E6DC
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5A3988F5;
	Mon, 16 Mar 2026 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEqHNnW4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02101399018
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667895; cv=none; b=ZUZSRCGxxvyhwZ1BB0mfFJREWGZaVMDEp5pReSoGpkvNsjRsdA2qJasPxoPGv33EAl6oN/SlhkNpZK4Z+vbc3T5j506z8Yzc58xM7EW+l/vdEeOaExCoLKZTRHP/BLPiKjcXyODKeATnjP5cumSSeq+u0gL+9mQvy66KPuf13C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667895; c=relaxed/simple;
	bh=jZeAnJzI44R6wOTnRGzT9h5fC0ja+VnMrJcNvDLiKj0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GyraSSpPIDCvovUYvM1gBITgcjIWrgT4tFb9nkGGN+wXaNk6I279co1jQmXAlIOiE62HJ5QKgSLyIdiml9ERnHzb5Tflhwae1ar5rXvxfV1OklfoWkiIRjhI0MXiqr4fJJhm42KMATnIIjfgjsA9tCw83bdaq8VAiCPNLqyIta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEqHNnW4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-829fd367abfso2191360b3a.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773667891; x=1774272691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o0CCoiWJM5C0sFGetYORRFQ8zd99isLJh3dMgAeQZHQ=;
        b=LEqHNnW4YhHiQYaxKWWSG7Ea2VFfQu9dxySvSXOS0SW0yhlxesQ0dfyjRvUs3BMdwi
         EpGcEjcKXziVe14pB4Q2DjDJjB6m1roV87R7msFuS9FcVoFQqgLQ5sJw4lF9OHS/mTa1
         SaPhyjHvpIYHqrCCFHGSABBFaaFdTUqa1HRIMMGfRcTV/vLU+m6oYUGO/g+JCUggqmg4
         0IIYcpWVK/0+fO6MrrTLA8bumdZIv0YY/ImZdnMOwiW4UgPq2lMo63R4HSOVpfno9m8y
         deTgmS4Z2r8GcPGOVZLH/Fz+0Oh0gCn3FkjWVCQH5W1nRcNprckun4I5jB2h08lizr4U
         AAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667891; x=1774272691;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0CCoiWJM5C0sFGetYORRFQ8zd99isLJh3dMgAeQZHQ=;
        b=OCKHSJ/MH3grVRMhyHpkMLxya3TUxPO8y5H6e+ECQotJ79xQnbKg5HOu9zhZ7DoK9y
         Ek42s+yovCUjk13FRtNHFwKWDDSehZ+7sR+X9/p7zt9LwuzLXwGNIOqW0SvhrcWNVMh7
         jPW+1HAUmZG8dTD22iwbj/LxfbH509NlEBmXOn0YOMWqLo4dIWopFSqEtWHf61L6pKBf
         C74lIy7YfkZJKPgQaNmMorz9G905GxCh1xQ45MgffASZEFzLpU+bwCuwKUCSDKA5s2ts
         6s6lZ2xxkclxqmTCQBP6qFJTxw5WeSqMdtL7MWNADKpyv05J6QZz7L6GuwAAxjettcRb
         8vzw==
X-Forwarded-Encrypted: i=1; AJvYcCX8vkvRkFnlUzNGO4EnpbzvX3J1z/m4sj1A7+bvfXHZJJhX/Ma3yWsQYLGDXkGKFcj1Xs6OHhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6vIvOtPXhEe8ctj918DIRS+gZWoZ6a0aKvZjrFM98pr+H8287
	wssY4jSgz94IsB9GhqC1v/uFTQoukReeESzVG4UtyTsCrvZaLZcwQVwweyJ0YsksXCyK281PU5x
	dxNVvGA==
X-Received: from pfbdh21.prod.google.com ([2002:a05:6a00:4795:b0:824:a65c:adf])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6d4d:b0:81f:9f14:ecc8
 with SMTP id d2e1a72fcca58-82a19867210mr10153903b3a.27.1773667890888; Mon, 16
 Mar 2026 06:31:30 -0700 (PDT)
Date: Mon, 16 Mar 2026 13:31:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260316133127.2646421-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] fou: Remove IPPROTO_UDPLITE check in gue_err()
 and gue6_err().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268166-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1062729A949
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

UDP-Lite has been removed, and its error handler is no
longer found in either inet_protos[IPPROTO_UDPLITE] or
inet6_protos[IPPROTO_UDPLITE].

The recursion fixed by the protocol check in gue_err()
and gue6_err() no longer occurs with UDP-Lite.

Let's remove the checks.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fou_core.c | 3 +--
 net/ipv6/fou6.c     | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 3baaa4df7e42..5bae3cf7fe76 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -1150,8 +1150,7 @@ static int gue_err(struct sk_buff *skb, u32 info)
 	 * recursion. Besides, this kind of encapsulation can't even be
 	 * configured currently. Discard this.
 	 */
-	if (guehdr->proto_ctype == IPPROTO_UDP ||
-	    guehdr->proto_ctype == IPPROTO_UDPLITE)
+	if (guehdr->proto_ctype == IPPROTO_UDP)
 		return -EOPNOTSUPP;
 
 	skb_set_transport_header(skb, -(int)sizeof(struct icmphdr));
diff --git a/net/ipv6/fou6.c b/net/ipv6/fou6.c
index 430518ae26fa..157765259e2f 100644
--- a/net/ipv6/fou6.c
+++ b/net/ipv6/fou6.c
@@ -141,8 +141,7 @@ static int gue6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	 * recursion. Besides, this kind of encapsulation can't even be
 	 * configured currently. Discard this.
 	 */
-	if (guehdr->proto_ctype == IPPROTO_UDP ||
-	    guehdr->proto_ctype == IPPROTO_UDPLITE)
+	if (guehdr->proto_ctype == IPPROTO_UDP)
 		return -EOPNOTSUPP;
 
 	skb_set_transport_header(skb, -(int)sizeof(struct icmp6hdr));
-- 
2.53.0.851.ga537e3e6e9-goog


