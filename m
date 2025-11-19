Return-Path: <netdev+bounces-239879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E3AC6D87B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 842484F74BF
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D643074AE;
	Wed, 19 Nov 2025 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJEtwpg8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41E3002AE
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542099; cv=none; b=R45F6DG5b1IRZ8i7FMPhKyZKJU0kWiMaEnGMP3g328dfPTfRGpdisnAPf/T0Cf/V2SQZZZZ1oAWl//3L2qUdZxQr2N+i/mnal4AZurhvBsnVjtcXj/L9Sz2xv7+oLlK3RSJbdYy3LhaXIhDGiDJhhidR4ogCY69FMcOjw8ejZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542099; c=relaxed/simple;
	bh=l0po9VZfdqcqFueN5tohExwGoSfDo/jVGegi4WqIxhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qp0b1HyrcTvE+f3P//UKymR/kQQyPp+2WxNxVbgQ2jMgtos9gklJJNTXkCwaWIu6SfWg965yrO4EWR5Bw8X2IlXcET4e3WdpClmaJP3HSa2js/9YzTom/fiMFMQo2mWM75llw4/5TeIeygIEtP1zdcif431vxZG5R5yIy1A7xuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJEtwpg8; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b234bae2a7so1915429585a.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763542097; x=1764146897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVov7PKRCBJzt2eWJu2ClwczfohUOwgZT/HjMe2xTPs=;
        b=ZJEtwpg8ek2nKepBhOIi/8Wk4JJIv5rbdYZCcm3Jb7BEYmoHjkfX+R643C6KrlorLe
         p8msLjM2meSje83mbtyOaWJHscoyD6h3qlEwZJtfujWfVfxU+glTpeJ1Z5eRx8uYkb9G
         uSIphMDxi+FdC3NU+gAXLHoEnjQ3ajXzHbC2vdFnuW5YgOo1Mt+4EX8zJTLPmLF/+GUe
         gkDdiyGMlfIbkD9Ircs+DWhV4l16ZUx6f8jqbOxKVJ4IgukvyIdhs9xG3LZuIQlBQo5t
         YkDAn0UYOWH7eBVnFiUIAz9bEEXh0gzb01hlD5/RFeGhZIrHlTVrDgOXdHLSxJtat4ZE
         P4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763542097; x=1764146897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVov7PKRCBJzt2eWJu2ClwczfohUOwgZT/HjMe2xTPs=;
        b=SI9TBArNC/sN0PUuBLukP6QBAVIjUkaq7wLkjUQ2rH5yzzsz8PsP/ezxfkZu8bxRBi
         mpHyIY2GBASx4hnMP+kyUMVB68wLonLlSCDL0SsmwqbuCtK2GTDts/4QsgDdKNw9Hb/i
         4gJXEQLmFrudSqlqe84qCs0B2oNKOwJPVkjsmLXr3Q6i6QqKi8grkkQxCDogr0VJEU+a
         IkAbNPvXXCWWjiDgzJlFGNqpbh+YFxG2WdD9geR1t4SQ+59snbOa4rfnqyGtTRhIK+4Z
         MuaeqDFDrf5MhoWXwvbs7AgpLR1C/GIsfjWC4J794YxWoGV6csj5Ll6wAM1fXPwOrHqm
         B5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXVP2qT9WrSX2Lx7e991GaVcx/knjLC3ywebupFkAQm4QRgqQyZ2b093VNXFEi5p5bWi8EWwow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy625U/2j+1+d0s8u0sid0s7bK44CAr1l+Dd+c+9QaJKz8Mv7Ds
	ZxgJNuM8eS85oU+3171ihPLYv5wo6Fnu+caBc+Q141g4dHv+6m3YHE8QX660/okKGylp28iE0A1
	8LHqQQaFK9r8ESA==
X-Google-Smtp-Source: AGHT+IETGExgFUdaI6ZhA/ePfJuItnmZSHHttxODpdG3ubR5rQri/MoH9gdmxRVDu2I0O3BblJkVPwD293HASQ==
X-Received: from qkpb6.prod.google.com ([2002:a05:620a:2706:b0:8b2:e20f:d088])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:258e:b0:8b2:5d6e:48b5 with SMTP id af79cd13be357-8b317007f66mr237682685a.30.1763542096669;
 Wed, 19 Nov 2025 00:48:16 -0800 (PST)
Date: Wed, 19 Nov 2025 08:48:12 +0000
In-Reply-To: <20251119084813.3684576-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119084813.3684576-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119084813.3684576-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/2] tcp: tcp_moderate_rcvbuf is only used in rx path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Rick Jones <jonesrick@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sysctl_tcp_moderate_rcvbuf is only used from tcp_rcvbuf_grow().

Move it to netns_ipv4_read_rx group.

Remove various CACHELINE_ASSERT_GROUP_SIZE() from netns_ipv4_struct_check(),
as they have no real benefit but cause pain for all changes.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
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


