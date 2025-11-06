Return-Path: <netdev+bounces-236509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C5AC3D5B9
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 21:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5392C4E554D
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 20:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6D22FD69A;
	Thu,  6 Nov 2025 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rU+UZwk8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA82FD1CE
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460988; cv=none; b=ghWAyNUMFMPnjhwptLTuDZgNk09HkuzesATba4Bm8l8hBV26ikbb2Z5xITvQOsrv3e9/5TPpqnvvnrVwgWCe3D+cjtphTZbwUDAcr4olxx6RsEsh0/DLSktG0Wgf41bDxVJza97bhmckZA9q7/9MgtXKsdgtXsTh+BG6ZjcTBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460988; c=relaxed/simple;
	bh=s3j0iTvihKR3dlvXzt2IjatUcZ/rcf2fJ3aHQzhA8No=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TNRjyoNBUybYka3Ey5EvZTBibpRNWT00HjxKBoia9Oofj5P9SIrPHyTzNk2bMltsQiPQ/KK/wGbZKd8YfcozKH5SRgy8REvu9itIPPT3kwUgOa3U06/abdJWdqKvow1gRUYLWvNdPlYkzRe267bzM6++M0cRFLgbPt2Dhps5cng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rU+UZwk8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-786a0fe77d9so827927b3.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 12:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762460986; x=1763065786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlav3UbLPRE//9ZpsrAxh5Zr/PEntl/GCOzpL6MdjR8=;
        b=rU+UZwk8SNFPiZ+OF8JTAQK97pgzfB+N9gXeiIbcWf+XbG16i82FBD9GwyV9dYYnzF
         OtEU6kbS21R46WHfMKsbUEHIDVa7P5jcSQ621Kxb0i8iOxPVG50upUMOiN4HmsxEXuhl
         h8jQf07T/SosmVF8T6mCUp8Xo9Ub8IgBH5lLs1nudM9s4JgKTbT7Jbzd2jpa0b9+DNhD
         fMpzZG+Q5ltxLJ+qr6D3jtRQc31Pea5Wn4/StuEM/tPpQ8MC/hRIOxeZxKpXiZuLgEQN
         chsr17Xhmk+OC5ydAkahHefV3K2dBwOBjuaUDXeIeW5rFCOJ0gSzeA5rFfwahoa5wbNj
         eNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762460986; x=1763065786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlav3UbLPRE//9ZpsrAxh5Zr/PEntl/GCOzpL6MdjR8=;
        b=JLU8m8OqYFHGuL4Tg0xwob83zrMQoC3H6kSliZcG7jJFIWBDVuyuI8jc+mDLPG4jt9
         d6nd/8092T3sSQRvvytSNImCODwxPABZU3Wt0S1elXgmww6B1n1qbGKk5O36HEq0DziL
         68hfJ8Nb8l4179Mh6krk9/dYHnkfjv+7Yf+PoNugFMW/kSY2i60j8N4ba2YDlbRmcIA2
         hi2IcHohn/8oR8xMYeswt9aCcWcF/Vs6oEK638YnU4cuYXO8m5tT6VOgz/DJBWLv/4+O
         EB+Xw8nj6wED8rtTLwDjVN/5Y/7QfRwvMq0TmopuMoBylwmaqaq4NhBHBy2PtV+qGAUJ
         ElTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJjl0SINU2+E1GYqCErxUZteEAcLu4fiHlvpLzJw3Lo1heugMk9P1/ihFmDfORvCNQpDLXbvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySYiaWzx4UqcNnW/vIwxWoFCD2e3WzPLThZviHBpHZvKMs/JcJ
	t5nJ+2EHcyTdcf5HpdoI4WXSjTSn6zp6AeVFI0DtZtWfMZZJu8XPNX/GVmLmb6WwT9tP5nY6/N3
	kIGZCvLps+OuVuA==
X-Google-Smtp-Source: AGHT+IHzfA+K+zY0b6XLaqzgmJqgFL29PP+QidNNBA18T1dk2d8I6pCs2jCXMBVQ8BmFAUBFA3CUKnd7RXPPKw==
X-Received: from yxab9-n2.prod.google.com ([2002:a05:690e:1589:20b0:63f:391b:6f24])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:158e:10b0:63f:9fe6:9479 with SMTP id 956f58d0204a3-640c41bee0emr619065d50.19.1762460986294;
 Thu, 06 Nov 2025 12:29:46 -0800 (PST)
Date: Thu,  6 Nov 2025 20:29:35 +0000
In-Reply-To: <20251106202935.1776179-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106202935.1776179-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

skb_defer_max value is very conservative, and can be increased
to avoid too many calls to kick_defer_list_purge().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/admin-guide/sysctl/net.rst | 4 ++--
 net/core/hotdata.c                       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 991773dcb9cfe57f64bffabc018549b712aed9b0..369a738a68193e897d880eeb2c5a22cd90833938 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -355,9 +355,9 @@ skb_defer_max
 -------------
 
 Max size (in skbs) of the per-cpu list of skbs being freed
-by the cpu which allocated them. Used by TCP stack so far.
+by the cpu which allocated them.
 
-Default: 64
+Default: 128
 
 optmem_max
 ----------
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index 95d0a4df10069e4529fb9e5b58e8391574085cf1..dddd5c287cf08ba75aec1cc546fd1bc48c0f7b26 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -20,7 +20,7 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 	.dev_tx_weight = 64,
 	.dev_rx_weight = 64,
 	.sysctl_max_skb_frags = MAX_SKB_FRAGS,
-	.sysctl_skb_defer_max = 64,
+	.sysctl_skb_defer_max = 128,
 	.sysctl_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE
 };
 EXPORT_SYMBOL(net_hotdata);
-- 
2.51.2.1041.gc1ab5b90ca-goog


