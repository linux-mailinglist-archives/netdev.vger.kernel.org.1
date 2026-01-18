Return-Path: <netdev+bounces-250913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0FFD398A2
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 18:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F372C3009573
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07362FD7B3;
	Sun, 18 Jan 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1PFhJyW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03552FD691
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768758743; cv=none; b=NHf9jtC5BtNl9DzMv/9ZOzETiS14Wkp8T8zjveGKOu8vQlQft26HyuyAIqt3ex26cYI3DaZ4nEPLdk65WPcbikS89MEFAPB9H1hQAt0V1NYhzSx2kclpegZBXmh6B4r6a8Km6HnVsn8AZDQ+SXSdRyhCKWDEnNY1j/meevGRWKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768758743; c=relaxed/simple;
	bh=qEG8W+iXPCChN+rsqU7ShDmWYPWBLq9atvzzf+9ff/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=inc1nsYw6UTIskLJlQ+jNpccZVLrmIFjLBZgwiY1RBjzAP9KWRaRhEH/l1cTfqrEfiwX9I/uXbRxOcRFouocN/I+fHCVei2VUXITFxLY1Uzz9d5tuq1U0qyT01QhNtbN6KE2T2R+J3nvzmjodsvty2gSExm3uNASasptyfeWWcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1PFhJyW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-78d694a1eb2so36336427b3.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768758740; x=1769363540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsOFJn4EZiKQ337yr9Dz5asIEvy6XfYTAcnE7gOIqmc=;
        b=F1PFhJyWYtU2hTR10n3m7ukzO76PB4OJ1Opt0rdFHs42Q1533VSRL7+Ai06OID8CUv
         LY/edur9XovUMLWriOmAzquBMO6Ng2ZaWqxdy/4Q6GqzwGqr0iGjDxBoaZ3vO3A8RqvP
         +511UBcY0MYc82q2S7TsgBBxNAuAfhfASqgrgliRPL+K06NHvG8uzrYS8HG7lWcSqz22
         MIdXdG4awIFPFAH1Qp7x0ie34nA1jSKWc4MUDIgNz8rw+VHSEjlD1TfZwtNBW0n7TaRE
         scqaxfUsdJ2bJO00HkW57AxTMKXZGfZ35PeUpJl/m3HtFxreJLvveZH+Drf66/CTzuUv
         MMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768758740; x=1769363540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsOFJn4EZiKQ337yr9Dz5asIEvy6XfYTAcnE7gOIqmc=;
        b=MKRslTnRV4d+ubMQk07z3G4PFlT9y7ZFDNO+EPx5wrz6iW+LM+7XFzh9Sr9B1S98U6
         RUo47jIPFGcg6vtwv+FsLqf54uQWqxMANB+UFIKIS7miFnRxVRz2rjnsNiP49p4y8Fh4
         hg5ugOIcl89k37Nfwj25KBrWsBewaMSY4M1Tk3KwoktvE6TDmd28/w3WqzJYkC1tnbHf
         /g0DhRJM1hM6z1yhfiYYQs171AfhteoB6RmZ5dtevJHkSD/lPmmbEGR9oCrXEOksn+HT
         utKx4JO6RpP/0oh3KMIxwGdMtfQ52wree1AV+wJzcYJpFIl+wHAGWbK95g7ro/dcWt/t
         OD2g==
X-Forwarded-Encrypted: i=1; AJvYcCXhucCwVBFNQkD2JqE5EDdIFQkfTpBfRUsTGq4ypdu6Z5uL5rr+iER4JlJSUFH4y97Gf8jPF1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybs831EMmfuLDqYNvUdY1sItboauN1udMSkWSwAnyX0h8iemUP
	yX4pBcI+5ZMVzvzoz2fI3NR1HdgCm7xkKzblRjYyI1987xc5gqO0x97GOQ+2jI2XQco/AMWOOLv
	mGZgTMrcqEDWIyA==
X-Received: from yxzz17-n1.prod.google.com ([2002:a05:690e:1551:10b0:646:e5d7:6a37])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:c512:b0:789:61ca:88f6 with SMTP id 00721157ae682-793c523ce57mr160830907b3.4.1768758739697;
 Sun, 18 Jan 2026 09:52:19 -0800 (PST)
Date: Sun, 18 Jan 2026 17:52:13 +0000
In-Reply-To: <20260118175215.2871535-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260118175215.2871535-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260118175215.2871535-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/3] net: always inline __skb_incr_checksum_unnecessary()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

clang does not inline this helper in GRO fast path.

We can save space and cpu cycles.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
add/remove: 0/2 grow/shrink: 2/0 up/down: 156/-218 (-62)
Function                                     old     new   delta
tcp6_gro_complete                            227     311     +84
tcp4_gro_complete                            325     397     +72
__pfx___skb_incr_checksum_unnecessary         32       -     -32
__skb_incr_checksum_unnecessary              186       -    -186
Total: Before=22592724, After=22592662, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d4a8452e90fe78adcdcfdefb79169..e6bfe5d0c5252b2e7540e1fef9317aab83feced2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4763,7 +4763,7 @@ static inline void __skb_decr_checksum_unnecessary(struct sk_buff *skb)
 	}
 }
 
-static inline void __skb_incr_checksum_unnecessary(struct sk_buff *skb)
+static __always_inline void __skb_incr_checksum_unnecessary(struct sk_buff *skb)
 {
 	if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
 		if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
-- 
2.52.0.457.g6b5491de43-goog


