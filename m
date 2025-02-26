Return-Path: <netdev+bounces-169955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59DAA469DF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9D7188955A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE8A233724;
	Wed, 26 Feb 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhNKbqyf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052BB18DB2E
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594886; cv=none; b=D0HtpMxuqvzCdnQDvFWgxlGHcaUgoeahaxEQYBFttsg0cNLdGmc88smJdVQh4FI3YlbEyEC7IoilylzSOksro1dtvN5tyd6lVZCS/7qVau+Mwko6Pg2w0bJgQ9vx/UOJJjZcYoyUS5+kNT9eo5VRMrQDJg3mzISrQDQf1ldrs8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594886; c=relaxed/simple;
	bh=XAXVOAaXzAMvjnz5/ocTIWEawKKQ7e3an2hytysT4G8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FMD+BJ2GyXbShLFDDVuVBa8lLfCheEN4QAIPtccD0mqP+irJqyD1L8RR4DsX+NgNSsTAk0CkQataG8fNRaeQ3Q6lN8BLW7ieNgRmVnYx0+nDEn+AsUZgjQjwMwbZna0+YWjCv8l2R154Uf3kmdB4cEn71UYIAGf5aQkZIx6cyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FhNKbqyf; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c09a206b3eso14651385a.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740594884; x=1741199684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QDCHglNOXVQ4LCS+WnT8RTJFt8fFnMWZqyMLSSz4QAE=;
        b=FhNKbqyf1+YDolfjOSkADsSolVJowGvnbaa1SGK+f4cyWljuqE3djdMbw8mcvPB/w1
         AZ01kFl0uG+FkFNdHEUwt3xcSCLB7P+JU/HON8fauDXhhKLJDCry8kpGh2WqIASlBMng
         suN44Vm8ewhbTO8W/YxGNYxTcE59wOxJGpexPXHnDpEMvJPPR0GFrUqG6BrftLD3FhvL
         rW988TlTbH2IAt4k3YFL3IgzxmRaHsNmiBfGaet9UFVbFebfBz6jGoInjj0ORw6YWqPY
         5gUWfezhHLQltz4dcJc0Yw+unBkgNUPfB4pTDUYf4IatUiRVMrwTEMdkbLNuMBEjbpZm
         VXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594884; x=1741199684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDCHglNOXVQ4LCS+WnT8RTJFt8fFnMWZqyMLSSz4QAE=;
        b=WlehBor/w3haI8CQXWdBk9eCIjkcrVVSWo6Y94CBYJHQqAeIEgO7j4T4JUCaFnlg9w
         /xCys92Kx6AfhrVPVcD3+rnQxgNPBa9oq6wlMyvxich8J3teR3UJC39eT2TIc6WOgyAx
         3GTQ8j1LyVEOq5paIeF1LyOQPy4VNv+z4aW7u1op1o/Jr3T8XY1sGAL243hJOwPGr6+p
         8FpGODENzPEFlGny3YFWf37AYOqQ1nAMSAf+AOIIYfFXI5uEhkGlM+AuEXxOWjv98i8Y
         TeBmpnrIXkb2aLg7uayNomBO8NoiuiNcXj7R7w0E99e8qD2m+lEBxSQTMW/jR3dAA6xQ
         Zy/w==
X-Forwarded-Encrypted: i=1; AJvYcCVcLB194QqWBORACGi7OsSd90bgpm+grRyxJt1tfnKhXMkL999EhU5mGvVKT31zvoAZY4byRZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/kdLq3L+PQC8KjEJOAMdVmEPGQIp/nylTJA1YzBM49oxVv2b
	Ae4BqtvDVHQCKk5SazU3Rnexj1cGmB+2Q8gdU4xOYRAu7ZPuosyNdfooq3bNac5eIbIshim8hhs
	0nXiipfaSUg==
X-Google-Smtp-Source: AGHT+IEtf3KDJ7PlVhC3BZeM5InR9XnPuPsAz96iltPm6VznnSrti/7SfTfNyZ0BZYPCfY96wxUdOim4qPxZqw==
X-Received: from qknpw8.prod.google.com ([2002:a05:620a:63c8:b0:7c0:ac00:8021])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:45a1:b0:7c0:a431:6c5e with SMTP id af79cd13be357-7c247f433c1mr590859685a.31.1740594883921;
 Wed, 26 Feb 2025 10:34:43 -0800 (PST)
Date: Wed, 26 Feb 2025 18:34:36 +0000
In-Reply-To: <20250226183437.1457318-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226183437.1457318-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226183437.1457318-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] ipv4: icmp: do not process ICMP_EXT_ECHOREPLY
 for broadcast/multicast addresses
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

There is no point processing ICMP_EXT_ECHOREPLY for routes
which would drop ICMP_ECHOREPLY (RFC 1122 3.2.2.6, 3.2.2.8)

This seems an oversight of the initial implementation.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 799775ba97d4f1bad1f070fb2a2596650df177af..058d4c1e300d0c0be7a04fd67e8e39924dfcd2cc 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1248,22 +1248,6 @@ int icmp_rcv(struct sk_buff *skb)
 		goto reason_check;
 	}
 
-	if (icmph->type == ICMP_EXT_ECHOREPLY) {
-		reason = ping_rcv(skb);
-		goto reason_check;
-	}
-
-	/*
-	 *	18 is the highest 'known' ICMP type. Anything else is a mystery
-	 *
-	 *	RFC 1122: 3.2.2  Unknown ICMP messages types MUST be silently
-	 *		  discarded.
-	 */
-	if (icmph->type > NR_ICMP_TYPES) {
-		reason = SKB_DROP_REASON_UNHANDLED_PROTO;
-		goto error;
-	}
-
 	/*
 	 *	Parse the ICMP message
 	 */
@@ -1290,6 +1274,22 @@ int icmp_rcv(struct sk_buff *skb)
 		}
 	}
 
+	if (icmph->type == ICMP_EXT_ECHOREPLY) {
+		reason = ping_rcv(skb);
+		goto reason_check;
+	}
+
+	/*
+	 *	18 is the highest 'known' ICMP type. Anything else is a mystery
+	 *
+	 *	RFC 1122: 3.2.2  Unknown ICMP messages types MUST be silently
+	 *		  discarded.
+	 */
+	if (icmph->type > NR_ICMP_TYPES) {
+		reason = SKB_DROP_REASON_UNHANDLED_PROTO;
+		goto error;
+	}
+
 	reason = icmp_pointers[icmph->type].handler(skb);
 reason_check:
 	if (!reason)  {
-- 
2.48.1.658.g4767266eb4-goog


