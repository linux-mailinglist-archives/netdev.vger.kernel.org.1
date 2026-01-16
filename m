Return-Path: <netdev+bounces-250564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76771D3334A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F1243029AF5
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29427335542;
	Fri, 16 Jan 2026 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRaz4TlL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E3337B84
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577404; cv=none; b=TVA/sLg+fh1yHD/cyf9Ke2yIbvoQuvTOSOTm3I2Xcxj41Z42diRUBMIOovRdHhAOwTHggu90chlWb5+FvDxJeGadG1RGpLiByaKj67vRs4xDSIrwSlld6iXz3fi9Z4u1DZOibxHDQKEhXHcoqTXYb+0B7P5dHUwN/Lpctg+NYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577404; c=relaxed/simple;
	bh=qEG8W+iXPCChN+rsqU7ShDmWYPWBLq9atvzzf+9ff/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NRAfTqcvQYhZIVKuXi0h3eH6XQdFF4XPCso7OiF9TL8FCywn5BDQs9/BxnaE1POYZAMa0k/lMIFPmpJf8+LTFsvjv0KB+V8GHhd+YDcwgPPrUVSOrOL3KSGoCYMTcy3yUbOWhdvW31q4ivV/b4rF9X/Ku8bCtK9Qyx7i5W4teik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRaz4TlL; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88a3a4af701so51493356d6.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 07:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768577401; x=1769182201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsOFJn4EZiKQ337yr9Dz5asIEvy6XfYTAcnE7gOIqmc=;
        b=FRaz4TlL/9p3BKWmSfOtRKo7TnXLn6y9sabbokZFgRM/MDpML6cWmX5k9c2D6KBHqL
         HS42/uYrVUpYbIyUS/1GbpHusrnVqVEjin+aVE/PWWBcvNpUHaMMJcInlVb44CUurKAQ
         bE/1zYdua/DFHZiNP0Qk9m6zWW2qyjGlQZDCWt+7mO/5viR3QSuml99FLP3Y9IdW5Vc/
         vAZWt0i7PO/km6b//jqhVmuFXf74NMNL3fUwSfNCoPeA4AyeWnLa2hptP7M0OiF/u0f1
         +SijlPXbaFbMAwqGE436K1PQPlKJ8y3Qaw0d84UKzN3q6Weo0xJ/W4TCRQAYge/YLUtk
         +YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768577401; x=1769182201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsOFJn4EZiKQ337yr9Dz5asIEvy6XfYTAcnE7gOIqmc=;
        b=mV0OSoRhgCIkrUNUWtVwjdT0IZCB7yltDy+jFknB0AOmmL8NxGo5R5LE/oKUnOQWAt
         ui8SIw7OBgBvRK2Y7Qwu4ST9xymlefqfl/Mx4+r6QbadlFbcB78+0ZUYHkNaCN3uk8DM
         V1zQO7HNHYYSr/XqNldcglwSB5HQZ8mnFrPEX/K+4en5j7TT+OYlZwhS61G6pGP5W69g
         u5bwc7jKDXxlW4p/rLeNQBc4S+tJkrqwHDgl48Jobx8d0iozXiJDfk33BoyiIGCovQX4
         JcTI3PTNh/4aVbZ/Iittd8vrdavJXzQqsSnoYEpPu2m6Xsy2EohB6aOblq2W+cN/VA/5
         ED4w==
X-Forwarded-Encrypted: i=1; AJvYcCUGmSsDiFLaNreX081ERF4CGI7Hxfga8Q0amlCVlalbSpS05oXhR+ckngqVlAGBc0CtO3lYdp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl1aZMCt0fu5h5msP2QgisOh/pbE1cWXwTIj53AtrNh2tivEFJ
	hXLCufzsZPqXpPF6XXUlQQxcPUCFHMmIXj4NOAkuhCN4HbhoOaHrj+VirJJYyzI6Z4qCp0b8Gl2
	XH9PeZ30SjXAySQ==
X-Received: from qvbmu13.prod.google.com ([2002:a05:6214:328d:b0:888:8a39:14d3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1d22:b0:888:57f3:ac07 with SMTP id 6a1803df08f44-8942dd9d671mr44910706d6.54.1768577401453;
 Fri, 16 Jan 2026 07:30:01 -0800 (PST)
Date: Fri, 16 Jan 2026 15:29:55 +0000
In-Reply-To: <20260116152957.1825626-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260116152957.1825626-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260116152957.1825626-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] net: always inline __skb_incr_checksum_unnecessary()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, eric.dumazet@gmail.com, 
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


