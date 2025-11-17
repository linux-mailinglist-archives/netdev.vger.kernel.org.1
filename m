Return-Path: <netdev+bounces-239126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8EBC645D9
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C373AAED7
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E703321D9;
	Mon, 17 Nov 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5XbdEE8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651F03321BA
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386089; cv=none; b=GrHebBJcON6ODJQqqtI+CUr1ymPl9ODqo+abm+hWRfhr6sEUYUl7dJYCUaroVRLcNzp9wQaoKDgvFIgR3vW91i1ee6lER3kJ+Zm6aOJS9vaB8h+0/6FHt6xaQl9+UVXHL9ya1wCwfjUKE5o1h/CJcBLk+5APd2XEBxWmf3oztb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386089; c=relaxed/simple;
	bh=BmdR2DD9YduBvdQF/Y/jIVsrhexwEm0eJFavUkbYBqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uc9rLuH1cnBYisdkEfA37Bdc+Nc2bjC9PXvyziBhCwLhhvbaH+KKk3NimzHdDEzhBpRkYGeWZiwUDUK06r/KSmtX+CrCvg54qFRrwLoJCoCzf6y88PEqnS+Y8R3JY2IKUp5j7tswHCryhbZUbulVHx+I9GJmFWF52oBmtQT6I1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5XbdEE8; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88237204cc8so136196016d6.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 05:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763386086; x=1763990886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YBzLfCxexbHJE6v3rnotNFxRSypm7U373ra5EKtPMss=;
        b=a5XbdEE81dhosY2FMbW6E0vFFngefVTTA7sZWqieaBjWsqJz8maRJE7VGUfQuBleGS
         Zhgbud96fjPhCoh4aQvYpBbKqA6oJObAPpXnw+9kdXcKo3doxTk28Av3LFPGUVOZCQDO
         dZwDlL0eNK7drrCJNrj4HPrNHPVjuDI0JYohChEAlDoDD1SGQxKT+5ZHIjsI4nZdLPSt
         +14yUZzLk2M2Cn4uvoFTVM1JUzw1Xvb3Lpi4ph3aH92qdPsIWrwAZN3VWSWM/A5sd4WE
         ZOpshTaVEWHXCXNQk4c2eQt61dCXT93gulqnKk+dVih9u6TDoMw3Gk7/ScuGnNpnXRyU
         ZP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763386086; x=1763990886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBzLfCxexbHJE6v3rnotNFxRSypm7U373ra5EKtPMss=;
        b=OfGkfu7eUfTwOGDqjjyFl6Gue09C5dV4i6WKQ8bPKnGX75EPN7s/h6pjHM4LxI/RXd
         VYOdllTM2IY8Swmw+xTvBusZDMt5B850zRfKBkX9Yq8u5PyvcNdOaYwORQFlzD/Nbu3Y
         g5m5wruQmcr1YU1+/scizAbWMUscsW3dqIxgQcLdcbffrW2WImvwngBBNzhXeQim38uf
         Xn6oPcOnYn/kOZxVOnmhqbW0H0EUnzPMpYdWU9TYb/tdwzP3I3XkFKiBzU8h1rX+U4i9
         v3QjMPwCTH9LL6lWb0uW7phmdQH8E9rlCZmNWaqXYCmXzo7iNlq2yH4YGrPrc8cCFwbX
         BJPw==
X-Forwarded-Encrypted: i=1; AJvYcCU2nBk1wTSAXy+pMZ1HJbIUExkxqhKP/xsQ1Xpbqt63TBUFxvJiziBohAAGLkDySWiSb1Gv2yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyILytR3ctPgCI55gTMD1k04BE/uQGZqUBgdJfCOeEPqlxvujTu
	N1XPG+VDfR+bHsrDW9Rh265C13sbLhWJCVh1M6MQseE0KTBPgULVHONBxwtGDgOAPu2o1Z0fVEu
	gMvXTUTZL8q+7Cw==
X-Google-Smtp-Source: AGHT+IEjVmYsVX2e/PU8MJzKO+50R9WLlq+64yc8ZyaRedYXLB4suqjR09tj0JebpYl7MQ63DuuinHWMdOzaQA==
X-Received: from qvbql7.prod.google.com ([2002:a05:6214:5407:b0:882:4668:dfc9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1947:b0:880:4272:9a5d with SMTP id 6a1803df08f44-882925871a6mr166547286d6.14.1763386085591;
 Mon, 17 Nov 2025 05:28:05 -0800 (PST)
Date: Mon, 17 Nov 2025 13:28:01 +0000
In-Reply-To: <20251117132802.2083206-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251117132802.2083206-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117132802.2083206-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: tcp_moderate_rcvbuf is only used in rx path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sysctl_tcp_moderate_rcvbuf is only used from tcp_rcvbuf_grow().

Move it to netns_ipv4_read_rx group.

Remove various CACHELINE_ASSERT_GROUP_SIZE() from netns_ipv4_struct_check(),
as they have no real benefit but cause pain for all changes.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../networking/net_cachelines/netns_ipv4_sysctl.rst      | 2 +-
 include/net/netns/ipv4.h                                 | 2 +-
 net/core/net_namespace.c                                 | 9 ++-------
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 6e7b20afd2d4984233e91d713ee9acd4b2e007f2..5d5d54fb6ab1b2697d06e0b0ba8c0a91b5dbd438 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -102,7 +102,7 @@ u8                              sysctl_tcp_app_win
 u8                              sysctl_tcp_frto                                                                      tcp_enter_loss
 u8                              sysctl_tcp_nometrics_save                                                            TCP_LAST_ACK/tcp_update_metrics
 u8                              sysctl_tcp_no_ssthresh_metrics_save                                                  TCP_LAST_ACK/tcp_(update/init)_metrics
-u8                              sysctl_tcp_moderate_rcvbuf                   read_mostly         read_mostly         tcp_tso_should_defer(tx);tcp_rcv_space_adjust(rx)
+u8                              sysctl_tcp_moderate_rcvbuf                                       read_mostly         tcp_rcvbuf_grow()
 u8                              sysctl_tcp_tso_win_divisor                   read_mostly                             tcp_tso_should_defer(tcp_write_xmit)
 u8                              sysctl_tcp_workaround_signed_windows                                                 tcp_select_window
 int                             sysctl_tcp_limit_output_bytes                read_mostly                             tcp_small_queue_check(tcp_write_xmit)
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index de9d36acc8e22d3203120d8015b3d172e85de121..11837d3ccc0ab6dbd6eaacc32536c912b3752202 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -74,11 +74,11 @@ struct netns_ipv4 {
 
 	/* TXRX readonly hotpath cache lines */
 	__cacheline_group_begin(netns_ipv4_read_txrx);
-	u8 sysctl_tcp_moderate_rcvbuf;
 	__cacheline_group_end(netns_ipv4_read_txrx);
 
 	/* RX readonly hotpath cache line */
 	__cacheline_group_begin(netns_ipv4_read_rx);
+	u8 sysctl_tcp_moderate_rcvbuf;
 	u8 sysctl_ip_early_demux;
 	u8 sysctl_tcp_early_demux;
 	u8 sysctl_tcp_l3mdev_accept;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index adcfef55a66f1691cb76d954af32334e532864bb..c8adbbe014518602857b5f36b90da64333fbeafd 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1223,14 +1223,10 @@ static void __init netns_ipv4_struct_check(void)
 				      sysctl_tcp_wmem);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
 				      sysctl_ip_fwd_use_pmtu);
-	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_tx, 33);
-
-	/* TXRX readonly hotpath cache lines */
-	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_txrx,
-				      sysctl_tcp_moderate_rcvbuf);
-	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_txrx, 1);
 
 	/* RX readonly hotpath cache line */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
+				      sysctl_tcp_moderate_rcvbuf);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
 				      sysctl_ip_early_demux);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
@@ -1241,7 +1237,6 @@ static void __init netns_ipv4_struct_check(void)
 				      sysctl_tcp_reordering);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
 				      sysctl_tcp_rmem);
-	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_rx, 22);
 }
 #endif
 
-- 
2.52.0.rc1.455.g30608eb744-goog


