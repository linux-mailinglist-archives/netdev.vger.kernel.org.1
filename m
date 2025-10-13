Return-Path: <netdev+bounces-228819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D6BD456D
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE4D188966E
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE5D30FF03;
	Mon, 13 Oct 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQkWchd6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F830FC15
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368966; cv=none; b=qwY4Zm+jLleBOJEcYIgpir8Yvo89JU/RV/05RFKv/p6zaxYiveIC0K7RsdFYInJuYI9U1Gowi3uPwd40MO3T4Zwav2pFO4p+Erd0jOhtphTw2fQ7NXVgqh6eP9sItUcmEeQb6AGPuxMUmcUIS5FMpeFuwbO08VvUfUg2n/BHRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368966; c=relaxed/simple;
	bh=E+7n9u5GVio0lTpz4cAzVxwQWAXK0PzviTrxpvgA4xM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=st9EF82GXALHSOl2b2p3ozJP0Fn0Nfi63J32fesQUn7+GvE/k1WI+10sNO757Eo+YFGGM4L1quT9r8DyI2fx3RqgBVYuqEPyle2KT87h/mUwjkw9vNO2D5sK0WCwoP/0mBqfTWXWdL2uyvaYQsKl+4k2DY8HRi+Wj3qG3fuTGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQkWchd6; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-78e30eaca8eso353690326d6.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760368964; x=1760973764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YVF8yg0BdQ9CbjB7tliRtsM/S4VUaU8cby62JgJB72E=;
        b=mQkWchd6nlTz0UhQNoP+DYRIiNL6kOmx6QT0JH+K3wbqYIUsOqnCMnK7Tc4jAlvMkc
         KvE0YAOHRlcSwkdQzSFi3kgy/EYHwXHnvMooMZ6nmtYxU8yO6I8eFU1ksoTzoUuu/VxN
         OiElVC1CR7cll7Fxj2bSaoORmmSTLki5uh822lW2pUBavctzo79NrDf9vI3hyGz+CVpP
         qNbU2XDTj9lWdVzN7aH+oIS15kLzBkQXI5qxD4aPJGP2Kh7sHJICtc3pt38jQjjv4dAX
         cNkp7TM/QAp+Z6LASMFOybmNg7U4N/+Jmv1WjboEAad4p104FS2W9OYFkFtXsFu0i5Z+
         nWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368964; x=1760973764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVF8yg0BdQ9CbjB7tliRtsM/S4VUaU8cby62JgJB72E=;
        b=l2R6Gf+rp7yc/fe0fBU4ngOxwQMuLAJ1WikD/hTM9dDwH5HH0FllTEbOBxSqfdQiQL
         CX6em8K+N8YKJETiLIhw+zObk37Leyb5JPqPPLKjEdu0hECynrw4IvwPsDL343+B2f2A
         KY3jihMMwPqlgBMTeE27sTiBqFhN3E8HDRR8BvQ7Ut1U4OYKiXbU7uXs5x6j/dJCplol
         B6y7fbtTFKnis3VRqMTpZ1N2JzrETgoxTugl0n/h5YafXWf6u84K3JgUE2YKUdoDmDzy
         xyQhl97JPG/eA1De6wdVbK21q6TmcadLvstA08mtjvXNWIiv2a+XRiyNXwqRA1nO7Vy3
         IdBg==
X-Forwarded-Encrypted: i=1; AJvYcCWMUApvnyZvC3VfhUkH5IxiWWQVwCoGP9nNS8hA9I4SgGuKhVO92Mlj4z84hRhkp3OxPVG95W0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuog/sL5av1aWRnVyLazhP0kpRD1fR0QN+H4Z9zTCnsXILd0uJ
	AZAVOvViq/Bw111h/3UP5Ve4C5W7RnDJ1Din4wDr/cBk56xX2FrynvUK3IvjsjkxBfnJY/SFNRb
	reL63ULlFCb/3/w==
X-Google-Smtp-Source: AGHT+IHNfsKe1nW6sacXFqp3oUppZjr3P2R4+2H9y0EFxPA3VdaGl4r0S9jbjN+UlKFKClBi9/xATC385bE0Zw==
X-Received: from qtbew10.prod.google.com ([2002:a05:622a:514a:b0:4b3:ba3:354e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:996:b0:4d0:cf85:9f9b with SMTP id d75a77b69052e-4e6ead54473mr344132461cf.46.1760368964007;
 Mon, 13 Oct 2025 08:22:44 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:22:33 +0000
In-Reply-To: <20251013152234.842065-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013152234.842065-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013152234.842065-4-edumazet@google.com>
Subject: [PATCH v1 net-next 3/4] net: add /proc/sys/net/core/txq_reselection_ms
 control
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new sysctl to control how often a queue reselection
can happen even if a flow has a persistent queue of skbs
in a Qdisc or NIC queue.

A value of zero means the feature is disabled.

Default is 1000 (1 second).

This sysctl is used in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
---
 Documentation/admin-guide/sysctl/net.rst | 17 +++++++++++++++++
 include/net/netns/core.h                 |  1 +
 net/core/net_namespace.c                 |  1 +
 net/core/sysctl_net_core.c               |  7 +++++++
 4 files changed, 26 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 2ef50828aff16b01baf32f5ded9b75a6e699b184..40749b3cd356973b9990add5dfdc87bb18711e2d 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -406,6 +406,23 @@ to SOCK_TXREHASH_DEFAULT (i. e. not overridden by setsockopt).
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
+To disable this feature, set the value to 0.
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
2.51.0.740.g6adb054d12-goog


