Return-Path: <netdev+bounces-155882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29922A042F5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1FC7A06E6
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A211F37B6;
	Tue,  7 Jan 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwVmBmny"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92B1F3D52
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261032; cv=none; b=lw/u0Jx0OSsHcF6+BY6Cc47TWrgotvTxSKLMIhKQCiTD80W46bJxUhib0VlL/FX1ico/zB7RZ94EwvDfWOmHsQoweB8bPnMn1PcVrDOYTMjUZU5K1hNtdrgklmv4YcHq+UyO258El0hZ/QFYpYLNLMMvYF4DtvzqinVpl1x/iU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261032; c=relaxed/simple;
	bh=p9gH1d5QE1Ji8+mqSR01mwK3tpHjbACubAk6mr+Pstc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=amCjxy2kod6JZjtONjoyzCLbeKm8XFE9En2vhMn1tlPIkS/f5didx4SE3tB0bn0zN/EKU2H3MjqIZn3L0SREPLHslyKm+o64zzQ7gImfnzjhyuO+qfhEE9QD+Ug9sjEp2zXt0RuLBJPg/CNYiC/W7aiRuS4SLiiHFp/wZ0baJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwVmBmny; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-8611c7e6c05so3097508241.2
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 06:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736261030; x=1736865830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6UzSU7iUTFbZRWM3n448aIXygNmHHryEeL2Rq3/LbQ8=;
        b=cwVmBmny7uSs6/nrAlRTs9KL6OrpWoaOZwKPrQBi4R0NVQe1mcpp/X5o28VmTpsZHy
         bZ4aPj9wra3xA/gUcYEVcDQvEOPWQqlmO98cz6mRpc7i1Qcb2g9vhDSi4iVzTj2t+tP4
         ER5R3GaktQYfuUrDpCL3hUQuEx2Oe/oHABerdmb1yz1ZFxtez/T2Iq3XFnZ0+ZF7Pg0A
         2Fh6iQqilpTYI6kXbETlZx1rn8/JLOYOt4a6CjDnHo9t3S853pMvOejWr0OlI+UIYrWo
         IppKNb2jZzE/ahDD1DtTIM5euQMGOylHoL4fnZi1bLEnRBHVGfk9HH1DUe1ZVQRo7Jcv
         72QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261030; x=1736865830;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6UzSU7iUTFbZRWM3n448aIXygNmHHryEeL2Rq3/LbQ8=;
        b=P3QxqSxLTGPXMqnNJvLiqJfEkCDpn9rMRBsERYiRBZ9Usw8XxaINUlwGn+Whi+keVv
         kokuqlKSB2z7WfQYcP32k3TrVSGYFefX2v1oh/9joNzLuWD7lSsUa38dJkmtKdK8LUta
         geWoPeeQalN9N8sIso7+MieHccPLYCBZi+I18KD1/8ShLaL2MWQ169IssiezYMl99ARn
         BjeAoMusJcQ2d3SC6aOKdxe6kXEJFEcsX9p3nWpF7xz2a3199KlCtkhpCY1ev7gFp64Z
         x+i/vJh4UmOU4UDAPWcHLflfD90lY/5coIa+0ExwIQHgigMiUBLSgKbx6spVbdTwqrWr
         E3ug==
X-Gm-Message-State: AOJu0YyxPXIaDVtHOgVws4nl3xjfQHaDONKoLJDnnBE8jsusVY9keAAc
	3MU0XzaGNLX2T3NZIiPbiT1izFKfXJMnd/3TWmifCpqZKZs+VzAraCicZEUiqmcH0+i7Slzi50l
	Tx2GOogeG1Q==
X-Google-Smtp-Source: AGHT+IF/S2whDBgWjOu8Kq8mxiALlT7Vy+H2DOTk4VMQwNhqFbzSZdMIvE18qDJXIjJAHjZub+wogS5qaXBA3A==
X-Received: from vsvf5.prod.google.com ([2002:a05:6102:1505:b0:4b2:5d64:7c7b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:6cf:b0:4b1:16f8:efc4 with SMTP id ada2fe7eead31-4b2cc36a2f3mr53391049137.12.1736261029866;
 Tue, 07 Jan 2025 06:43:49 -0800 (PST)
Date: Tue,  7 Jan 2025 14:43:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250107144342.499759-1-edumazet@google.com>
Subject: [PATCH net-next] net: no longer reset transport_header in __netif_receive_skb_core()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In commit 66e4c8d95008 ("net: warn if transport header was not set")
I added a debug check in skb_transport_header() to detect
if a caller expects the transport_header to be set to a meaningful
value by a prior code path.

Unfortunately, __netif_receive_skb_core() resets the transport header
to the same value than the network header, defeating this check
in receive paths.

Pretending the transport and network headers are the same
is usually wrong.

This patch removes this reset for CONFIG_DEBUG_NET=y builds
to let fuzzers and CI find bugs.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 073f682a9653a212198b12bae17fafe7b46f96e9..d2b6b3b96459159dc6fbd34143821516e9d0c5bd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5476,8 +5476,14 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	orig_dev = skb->dev;
 
 	skb_reset_network_header(skb);
+#if !defined(CONFIG_DEBUG_NET)
+	/* We plan to no longer reset the transport header here.
+	 * Give some time to fuzzers and dev build to catch bugs
+	 * in network stacks.
+	 */
 	if (!skb_transport_header_was_set(skb))
 		skb_reset_transport_header(skb);
+#endif
 	skb_reset_mac_len(skb);
 
 	pt_prev = NULL;
-- 
2.47.1.613.gc27f4b7a9f-goog


