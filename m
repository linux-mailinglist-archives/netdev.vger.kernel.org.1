Return-Path: <netdev+bounces-229244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D3BD9BC6
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90FA18971D0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290792D248A;
	Tue, 14 Oct 2025 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5vQ1s+E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A512FF16E
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448562; cv=none; b=uMsy21UKPJqEEgc5J00hK8idcFuwB8yqeoSblqrb8NtN8NNnKlFWXn+YWKjAqbdbfDML4dTU3bgzTQBSUJg+ABNUvA9G/E7VjsP6pw59UFkXzPwTs2wfwOMfSgtS5uPi7YKXsw1+0BwtaHAbl5/ggFmeZ5UoVvqjW3iF8cBCowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448562; c=relaxed/simple;
	bh=iFEXAUYhEbtaFOvQNq0M6KoJc3TYT+PzZKCpgUZAqCg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mR5P2eQgQMaQmwfoAW3TBPRQb4VsCCpUWK6Ad3zMyBSUVkmGsZdYxC6IjygYQ62pa+D17F/s+iirzuHNFzuIttU9b+1FhY0MhCgGjY/wikaFsF+TANxe3gDjlMbPu3yCEDXojLJhW9UNpGf3HP+gzrlm07H3wR7x3f2UjoMEIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5vQ1s+E; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-78f3a8ee4d8so235936756d6.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760448559; x=1761053359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jqMUrm9//4gjpAGJkbFbjJlkJnBDuRCs7DQ6smojVQI=;
        b=Y5vQ1s+Ei08l8VEzIiJa/io4KQzsWUPvJRog+ilM7p/WHz2Y+1XQ453EX5ST47K9p9
         gFCVlX1R2hgqxugeZGX0t/o0zcH7oTqM7KB20hqSKqqJC6REsHrbve9kCh3QCL0hb3zX
         kqB42qqKC4mDfALRnxshQOEkaJZascb7iimEX8WZUJq0hxIoWCUlsMiQOxrvVn1YVkvy
         zlaTXLcf7VCSaIgOGI2/3zL0zyszGcSth2bU2sgJ1akGrVujVbBiKGpRoekRL7N6VQs8
         t9rH0/8FFzU4p5MEV8kcEqhpyO/jm81tLa5U4DD9ZhQCErBgZGOo4DeRgMGSIEgaC3xm
         x8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760448559; x=1761053359;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqMUrm9//4gjpAGJkbFbjJlkJnBDuRCs7DQ6smojVQI=;
        b=Op3D9+mJHnbbu1LF8Ys6QPBHGnJKp54PM/g+35BGnX32oVoXEaop68OOF2AUklEHWS
         3fGYnoaat5pEkCoqX+acI4MlaSqZmUwlaXg7NfB0MApChcQ9cqBO4Vh10SumXiLY029i
         rlThEloD3onNgXbrh8IY6yDPK5C+pwLVGUXBmH89SZ7JdcNAFmyXyd1wYWDhAMz0Uofw
         MDvL2DJQTySj0xnVqpNhV0ZiPU42EoskdMbQQUBszjUzw6roZTLjSCXM6G7uPSK6dtVE
         h6YbPS3Hib6GSBYZvvEybtbSkRrPTJTkPVZ1DtBmHvNCcjqRjeUl0f/uafuQld4Z5SAE
         LdlA==
X-Forwarded-Encrypted: i=1; AJvYcCX4h87hEcz4FBjs68mKX9lnsL6NYsJaCtTM9AZ7W9CRvC9vsVy8zihQ1prBLhuJwHr/E1awtQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa9bWg97nYbLNHlihSISJnnzracPzmxPhXVJdyqHf00GeecvIP
	D+qeSM8/CCQCdvFw/x/amrq7JVTMe8ldKJ6aRWBd5jQbzotpjbbJ3lSYKlEkfNyILINmzfCB5kj
	6eUv4vag7bYtDew==
X-Google-Smtp-Source: AGHT+IEH7nC/3QLp2oUANlPjzUYbHkPVmzRr27KNAe6xxQEdypXPGxXKj34T2Bhx/zKZLz1jJNF+u4F6aJTYYg==
X-Received: from qvbqu8.prod.google.com ([2002:a05:6214:4708:b0:874:d15f:ea59])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:4ae7:0:b0:879:beb:2123 with SMTP id 6a1803df08f44-87b2f00514emr248172136d6.64.1760448559257;
 Tue, 14 Oct 2025 06:29:19 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:29:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014132917.2841932-1-edumazet@google.com>
Subject: [PATCH V2 net] udp: do not use skb_release_head_state() before skb_attempt_defer_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Michal Kubecek <mkubecek@suse.cz>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"

Michal reported and bisected an issue after recent adoption
of skb_attempt_defer_free() in UDP.

The issue here is that skb_release_head_state() is called twice per skb,
one time from skb_consume_udp(), then a second time from skb_defer_free_flush()
and napi_consume_skb().

As Sabrina suggested, remove skb_release_head_state() call from
skb_consume_udp() before calling skb_attempt_defer_free().

Add three DEBUG_NET_WARN_ON_ONCE() to check that dst, destructor
and skb_nfct() are not set at this point.

Many thanks to Michal, Sabrina and Paolo for their help.

Fixes: 6471658dc66c ("udp: use skb_attempt_defer_free()")
Reported-and-bisected-by: Michal Kubecek <mkubecek@suse.cz>
Closes: https://lore.kernel.org/netdev/gpjh4lrotyephiqpuldtxxizrsg6job7cvhiqrw72saz2ubs3h@g6fgbvexgl3r/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Tested-by: Michal Kubecek <mkubecek@suse.cz>
Cc: Sabrina Dubroca <sd@queasysnail.net>
---
v2: Adopted Sabrina suggestion.
v1: https://lore.kernel.org/netdev/aO3_hBg5expKNv6v@krikkit/T/#m8a88669b801d85f57b73710cdb0c8ee63854af11

 net/ipv4/udp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 95241093b7f0..d66f273f9070 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1851,8 +1851,13 @@ void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
 		sk_peek_offset_bwd(sk, len);
 
 	if (!skb_shared(skb)) {
-		if (unlikely(udp_skb_has_head_state(skb)))
-			skb_release_head_state(skb);
+		/* Make sure that this skb has no dst, destructor
+		 * or conntracking parts, because it might stay
+		 * in a remote cpu list for a very long time.
+		 */
+		DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
+		DEBUG_NET_WARN_ON_ONCE(skb->destructor);
+		DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
 		skb_attempt_defer_free(skb);
 		return;
 	}
-- 
2.51.0.788.g6d19910ace-goog


