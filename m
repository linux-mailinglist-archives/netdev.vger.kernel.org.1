Return-Path: <netdev+bounces-86219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 319A889E0AE
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44826B22E85
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1F8153574;
	Tue,  9 Apr 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="lvM1jpc9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BF12FB38
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681060; cv=none; b=KSeUMQddTwiWrHtrWKwJCHh3jo3c8C2ae+IB+gpPqn1dxD0ZHKjMSY9V2SmR1Q7ywONPgDZ+zrFxmrLg/5vfDhWJRz3MMZjf14e/VSPWB/FcIIiZFaWV1qWaxV2KCBnRnaB5NQ1MVpd/lxnRpyZmKCSaDN6uRxZwsYV00OhpliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681060; c=relaxed/simple;
	bh=CdpJGAEXXXNAgx3aGCK/nVQpHRQb5I3Wu1z30rm8qjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6gSY/2KqhaTvs1XrTtf3DQeD0L8cR+Fhfz5dr943d4G9MQfuamxRFyYYpVWfLM7eUKoPdY+0EdivS7cygEJpEWyI3Ina4Ti0xQIYFYnk8mUWV07O6Ld3FNj9lmKKr5E5XSztRshk89hssICIqRbqC80eJYk6FzusperMbedN4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=lvM1jpc9; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1e3ff14f249so17977005ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1712681058; x=1713285858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WprSy5gaOswrxUq16HxLGVIpP7UNz6Zb1HwY60dlbPQ=;
        b=lvM1jpc93GMdacQubdrD3lfzxP5SrGS2tD84FyeGFBpApw6AaP5LoUFSv3SU5tZmCy
         FriYHh6CZdNQDlCa9S45IDWiD0OaNJv4KdK3yXn/hBIW5+0nN+mdgsOYdCLoeQ1MoLQw
         3OIEAs2fiiHfLxtBePXdzDE5c4clogBakPakc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712681058; x=1713285858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WprSy5gaOswrxUq16HxLGVIpP7UNz6Zb1HwY60dlbPQ=;
        b=Ea7rIBHFhI0MjIeZ8vRNbUueC3EhfUbAN9yIVfn9mIvquxiBa9uy/Fe4dUOtLcqGlC
         Lb9mekKo81w465GgI6PzYs2WCJ2Fwo0tVgD0sght+Do/87R4wSH+GyaWATkO/NDn+zVu
         +1LzcF0nl4CC9jpt8AR1xeBOZyzEQmzfdSPmvH/AkGNH6rLsJtaGPuzqzpND3f+Srqyu
         MbIPj51ZxfLp+ZG46iEZ6TpSaB0o0jVdMVwzf/rYac6fAuWKW0Ff+R8OtZ/Fagn4QuC3
         iPOSamFCaQNjULk9iccUQ9u6J4FlFEpD+8As8yO2exS+mp8H3Uqfz1vI0M5RDbPmJb39
         /ElQ==
X-Gm-Message-State: AOJu0YyTDiruwPxdRu9RH9SXYBpr1v2q564F7EtN01ETCWsf5WUbWceS
	cyU1Vli5Iz1ym4NuXzQmpEyCS7V/IcEExPpSyMKZ1K4FaGCYYwm/eE5NKAQGtYA=
X-Google-Smtp-Source: AGHT+IGpjfjW9TJ7hzyoZ0nVHwp6ng6JTjp9cytMntyKurIPB35t8pr+lqldK0ZW1LQpTLC/OpHYjg==
X-Received: by 2002:a17:903:32d2:b0:1e4:7bf1:521 with SMTP id i18-20020a17090332d200b001e47bf10521mr4936530plr.19.1712681057550;
        Tue, 09 Apr 2024 09:44:17 -0700 (PDT)
Received: from localhost ([2607:fb10:7302::1])
        by smtp.gmail.com with UTF8SMTPSA id e7-20020a170902784700b001e2ad8cd0f0sm9259911pln.133.2024.04.09.09.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 09:44:16 -0700 (PDT)
From: Hechao Li <hli@netflix.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Soheil Hassas Yeganeh <soheil@google.com>
Cc: netdev@vger.kernel.org,
	Hechao Li <hli@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH net-next v3] tcp: increase the default TCP scaling ratio
Date: Tue,  9 Apr 2024 09:43:55 -0700
Message-Id: <20240409164355.1721078-1-hli@netflix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iKe=GCvSp1u5=6F+NYNUoGeOLyp0-ce8_Y-z8Vo=6-xMA@mail.gmail.com>
References: <CANn89iKe=GCvSp1u5=6F+NYNUoGeOLyp0-ce8_Y-z8Vo=6-xMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"),
we noticed an application-level timeout due to reduced throughput.

Before the commit, for a client that sets SO_RCVBUF to 65k, it takes
around 22 seconds to transfer 10M data. After the commit, it takes 40
seconds. Because our application has a 30-second timeout, this
regression broke the application.

The reason that it takes longer to transfer data is that
tp->scaling_ratio is initialized to a value that results in ~0.25 of
rcvbuf. In our case, SO_RCVBUF is set to 65536 by the application, which
translates to 2 * 65536 = 131,072 bytes in rcvbuf and hence a ~28k
initial receive window.

Later, even though the scaling_ratio is updated to a more accurate
skb->len/skb->truesize, which is ~0.66 in our environment, the window
stays at ~0.25 * rcvbuf. This is because tp->window_clamp does not
change together with the tp->scaling_ratio update when autotuning is
disabled due to SO_RCVBUF. As a result, the window size is capped at the
initial window_clamp, which is also ~0.25 * rcvbuf, and never grows
bigger.

Most modern applications let the kernel do autotuning, and benefit from
the increased scaling_ratio. But there are applications such as kafka
that has a default setting of SO_RCVBUF=64k.

This patch increases the initial scaling_ratio from ~25% to 50% in order
to make it backward compatible with the original default
sysctl_tcp_adv_win_scale for applications setting SO_RCVBUF.

Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
Signed-off-by: Hechao Li <hli@netflix.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/20240402215405.432863-1-hli@netflix.com/

---
v1->v2: increase the default tcp scaling ratio instead of updating
window_clamp and update the commit message
v2->v3: Update commit message and add the link to v1
---
 include/net/tcp.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6ae35199d3b3..2bcf30381d75 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1539,11 +1539,10 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
 }
 
-/* Assume a conservative default of 1200 bytes of payload per 4K page.
+/* Assume a 50% default for skb->len/skb->truesize ratio.
  * This may be adjusted later in tcp_measure_rcv_mss().
  */
-#define TCP_DEFAULT_SCALING_RATIO ((1200 << TCP_RMEM_TO_WIN_SCALE) / \
-				   SKB_TRUESIZE(4096))
+#define TCP_DEFAULT_SCALING_RATIO (1 << (TCP_RMEM_TO_WIN_SCALE - 1))
 
 static inline void tcp_scaling_ratio_init(struct sock *sk)
 {
-- 
2.34.1


