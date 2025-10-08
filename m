Return-Path: <netdev+bounces-228197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A5BC46D5
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 12:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F0F3BC7C9
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6092F6571;
	Wed,  8 Oct 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2lFEaz/5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B452F6190
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920383; cv=none; b=KwpvjAG5spXtdMM3JqO/Op6Ha7rW1zVVdjsGf/MsTwdSuADHFANtkhSKju2uQ93HFuH/S3m0PpAT+f0whG8BbAMaDiA19FN5CBEFrDLwHnWV3KaaGKa4AtEdfK7kwLzliWGxZxaGsQxRx9nFdAdbtsP07MTF9ocP+Tnjjt2I0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920383; c=relaxed/simple;
	bh=ZoC+dcRnCSB0APmXBPk9aMJkpdIvYd7BMCpp/kvvZyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m0CHaRIEB0Nn5ahUm4w7LkGZ+VGzwNJ26iQzvVTcJnnpsJeZOQSQLcraLx0swIpg8qsUJrd0RfJGuzhvQA1U8x22b8kiTNQUOIXcPkkvvz27G+b5X4YyHEn1w8qoMqDsX9y65Kv1fyGrP1H8sRr8E8W5A7EL/CumeXNwH3BT6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2lFEaz/5; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8217df6d44cso1476161185a.2
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759920380; x=1760525180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti4dbnfu7xJeBIMZAoETC3nGIprigt51PJVmxSNNxmc=;
        b=2lFEaz/5qwDYHQMb+IFsOcXmviz4wi94IGYQuJCJNPohI8tVKy0dliXOMgTgUFFLgG
         5QB+8IPhOJzCVDCThCdVnm/yHzuX9PeEkqi5VHZ5XGtaL9f+hCm47Rcdc40jvj7Ea9Pa
         EUbT13436FfzuZjG+GpNST6R29V7+OWY14GOSeq1944LYrhF0TRpZ5xGIZJhrHid1WTW
         WDES1tgz5sI/msqcGRwREgh4X6yPMqVyvN3LHWu+7hQmxa3uXt/9a4nzE8pPsqOAWVJB
         IHYHYwL9Hs0tKUhxURkkAavArJcd1qQVu2jScT4QZPYx7J7nxZlG6EA69q8BbFxpEO1Z
         XMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920380; x=1760525180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti4dbnfu7xJeBIMZAoETC3nGIprigt51PJVmxSNNxmc=;
        b=X3/jWPbfiAYOR9tt3UlNnnVucdNDQmYPnWr0g1mlsI2gEOHwTMdsHzNV5uZYPec2DK
         b5M/22YVP8coUCdVblqQI6FDcavmWjyzWUujQVk5ggbca2NiapuRO9B2WrQ7+voGchl9
         yuYNeoYXNO27ed2EQFGUVs00fJ/eBjcdqjbZmjLeLWa3yD1T+xleQhJUedcDvQEDjcG1
         cncfrr+PFashWtJdv9T6hwluYs8BwMplIVuPI/YhJ+t9SNNzZ5z20kF7sEStECxHejqW
         YV8E5p6Pv63i6SLwEoFWwP5p6B837AnNjsbfO2RG92X1PrFYls+g/AY3kHe+SAfLvOM4
         7IUA==
X-Forwarded-Encrypted: i=1; AJvYcCW2pwmgD4Q2eKPQJ1ijIjtMjsbsPe4G8FxRf/v8PPnkcbQFimYK1NPxRgRzvB3KhRTw1eCLdBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYDHSDD6pJjEkTqc2+Q8PI8Havue5d9AE1nk6mhvWqM8W79X4
	fX9WHdV2ddtpp7VvgLQUlfDXePsvahCF+zeb9wMkRognUi5zAIUSIkygtEBBJt4gONTA9mHTHUj
	1IK9t0DUjOzgJIg==
X-Google-Smtp-Source: AGHT+IHLGZjfR3lH1OEZT47iL3DtkZ0w3cZOkCnOEqgRmge0VEuVjZ1eBvsuu1mETfphcdNqNSP6c1UZqinaVA==
X-Received: from qkaq4.prod.google.com ([2002:a05:620a:aa04:b0:870:91a7:9f67])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:400f:b0:86e:8d29:4629 with SMTP id af79cd13be357-88352d96daamr362507785a.80.1759920380335;
 Wed, 08 Oct 2025 03:46:20 -0700 (PDT)
Date: Wed,  8 Oct 2025 10:46:10 +0000
In-Reply-To: <20251008104612.1824200-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008104612.1824200-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008104612.1824200-4-edumazet@google.com>
Subject: [PATCH RFC net-next 3/4] net: add /proc/sys/net/core/txq_reselection_ms
 control
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new sysctl to control how often a queue reselection
can happen even if a flow has a persistent queue of skbs
in a Qdisc or NIC queue.

This sysctl is used in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/admin-guide/sysctl/net.rst | 15 +++++++++++++++
 include/net/netns/core.h                 |  1 +
 net/core/net_namespace.c                 |  1 +
 net/core/sysctl_net_core.c               |  7 +++++++
 4 files changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 2ef50828aff16b01baf32f5ded9b75a6e699b184..6cfc2655dd489aa4a9233c09b1ab4ebe0bc76b0c 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -406,6 +406,21 @@ to SOCK_TXREHASH_DEFAULT (i. e. not overridden by setsockopt).
 If set to 1 (default), hash rethink is performed on listening socket.
 If set to 0, hash rethink is not performed.
 
+txq_reselection_ms
+------------------
+
+Controls how often (in ms) a busy connected flow can select another tx queue.
+
+A resection is desirable when/if user thread has migrated and XPS
+would select a different queue. Same can occur without XPS
+if the flow hash has changed.
+
+But switching txq can introduce reorders, especially if the
+old queue is under high pressure. Modern TCP stacks deal
+well with reorders if they happen not too often.
+
+Default : 1000
+
 gro_normal_batch
 ----------------
 
diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 9b36f0ff0c200c9cf89753f2c78a3ee0fe5256b7..cb9c3e4cd7385016de3ac87dac65411d54bd093b 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -13,6 +13,7 @@ struct netns_core {
 	struct ctl_table_header	*sysctl_hdr;
 
 	int	sysctl_somaxconn;
+	int	sysctl_txq_reselection;
 	int	sysctl_optmem_max;
 	u8	sysctl_txrehash;
 	u8	sysctl_tstamp_allow_data;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index b0e0f22d7b213c522c2b83a5fcbcabb43e72cd11..adcfef55a66f1691cb76d954af32334e532864bb 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -395,6 +395,7 @@ static __net_init void preinit_net_sysctl(struct net *net)
 	net->core.sysctl_optmem_max = 128 * 1024;
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
 	net->core.sysctl_tstamp_allow_data = 1;
+	net->core.sysctl_txq_reselection = msecs_to_jiffies(1000);
 }
 
 /* init code that must occur even if setup_net() is not called. */
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 8cf04b57ade1e0bf61ad4ac219ab4eccf638658a..f79137826d7f9d653e2e22d8f42e23bec08e083c 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -667,6 +667,13 @@ static struct ctl_table netns_core_table[] = {
 		.extra2		= SYSCTL_ONE,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+	{
+		.procname	= "txq_reselection_ms",
+		.data		= &init_net.core.sysctl_txq_reselection,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_ms_jiffies,
+	},
 	{
 		.procname	= "tstamp_allow_data",
 		.data		= &init_net.core.sysctl_tstamp_allow_data,
-- 
2.51.0.710.ga91ca5db03-goog


