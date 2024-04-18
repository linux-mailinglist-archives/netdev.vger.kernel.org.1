Return-Path: <netdev+bounces-89135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22B8A983F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495961F21EE3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBF915E5A7;
	Thu, 18 Apr 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YPa1yuy6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BE15E207
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438566; cv=none; b=gU6Rbvul7HjXNeR+32HSjoRtUhZfUASPZIf9rYFsnnsNe/Zl1rmfIPIef4wYChvp7r/XwthevKLXmUSJRzy90NVa2Q0afjh/VwmP+7WhjZJBbLFXpLkT4pGN3+SmEr7aQwCfOsF7+hlXYTnQQ4eyrbPWpDsa49bo+SRgOfAN2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438566; c=relaxed/simple;
	bh=aWz5Gig2xv2dqOzuJfPq1HgDbmDRmwb4+kS753Y/Y7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYk41AZj05UE4hnqKIKL/Sg53C6ZDbr/r7IFAshevl+olDjiKbUbV5sLhzO3vwlIEngUYFcmXX2SjkxkZpoe4RrZklGS+czDy6xIRM3CbiBoSKH803+80rKKCViNR7JI4buo9z23jK6lkk1/fHxNLZKOWz3NdDVV/U6/5OcP3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YPa1yuy6; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DAEDE3F68F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713438128;
	bh=ktW00F9DIAhL7DS4TlvR8U57g+A/C2nEvJUjlW8cwMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=YPa1yuy6jHLMmT5EM9hdKB5AvKvfEOHSKuAj5E7jV/uMds7RbV07k+i6G1So6Ogbq
	 urxCNbhHAa0P+IMRNG1s19LCKEKLuLJ+U+ZdNM2OwlvdZuDBJ1pxwE7i8KczfaeifT
	 V+6a2U68AMBqWn8kg0AwPNgrELPxcxf05LwwvjnUV/pX51M5/i9+aNXrizrTVFNsR7
	 Ae6NmVvlCmJzBvrxSg6FvsCym6Xen8iiWjrJ/RoU7RqB8Gzlenmwuibk9ZhYF6qfEj
	 CPPHVYJ8YJ9+u0gYMQCaMyLeRmQPVfIkacZqq3lDNht7t+T3C9q0wGpOrIG8BvJ9na
	 dXu5zdQsoHoEg==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-570255977efso2100428a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 04:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438128; x=1714042928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktW00F9DIAhL7DS4TlvR8U57g+A/C2nEvJUjlW8cwMw=;
        b=q/rDPiYDQcA+mZTV0DEmIQyBqQpp4uzvNBd+vyOJ8WfU5zW8HNGgpMBP7U6NhtvNGd
         mv3kOPL47nYKkx5iLmtdpbvDBBCLC9b9fdFX6jHiJdVMLoLWBnWUMyyPyw/VM17BA6pf
         kdjrKmyphWVa37huOMEUONUQqg4c9hWYMCebPUmCBTU+UpOeq/NRJ7BKVDMRYXPOVSce
         f2afDPvuUMgWlQv2bsNkHoQXwIVjTZudvQwxfo4SOqUjU8MqT1ht5vpbWRwloR7IIXwi
         2BrqAatwWBrq73daLCUE6Llry7lP9oyJIfPaHBksb/AgTjwpF/Pd+zPFMNyR5e6Q7aCv
         abUQ==
X-Gm-Message-State: AOJu0Yw0+hlYEVijQkeDoYBhRSEAGCeKxESXkRCDmm/BvW1JBZWjeQkO
	9vtgrP7+4x1HCa/ZOUOrag0c+5AcOYoFkf/4wbSDv5wMPb0S97It2JlRpPUHoLeb7QyxNsx6NkI
	Y1zU86CZ1L7Ef0NwoMcjWEmzf7iiiX3NnJUgXYeWCgDjdpru15CiFmxqngv8ZpOLU/hSnBw==
X-Received: by 2002:a17:907:9447:b0:a52:30d4:20e6 with SMTP id dl7-20020a170907944700b00a5230d420e6mr1974026ejc.10.1713438128373;
        Thu, 18 Apr 2024 04:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv+5q9kt1eWZoXNQEPQAWf0LPsfHN7n2d9j+DQUT0Ja9+xBCd4zGciLDlc/mEh9WbiEhFr4w==
X-Received: by 2002:a17:907:9447:b0:a52:30d4:20e6 with SMTP id dl7-20020a170907944700b00a5230d420e6mr1974004ejc.10.1713438128069;
        Thu, 18 Apr 2024 04:02:08 -0700 (PDT)
Received: from amikhalitsyn.lan ([2001:470:6d:781:320c:9c91:fb97:fbfc])
        by smtp.gmail.com with ESMTPSA id yk18-20020a17090770d200b00a51983e6190sm728594ejb.205.2024.04.18.04.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:02:07 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: horms@verge.net.au
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Christian Brauner <brauner@kernel.org>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next v2 2/2] ipvs: allow some sysctls in non-init user namespaces
Date: Thu, 18 Apr 2024 13:01:53 +0200
Message-Id: <20240418110153.102781-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418110153.102781-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240418110153.102781-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's make all IPVS sysctls writtable even when
network namespace is owned by non-initial user namespace.

Let's make a few sysctls to be read-only for non-privileged users:
- sync_qlen_max
- sync_sock_size
- run_estimation
- est_cpulist
- est_nice

I'm trying to be conservative with this to prevent
introducing any security issues in there. Maybe,
we can allow more sysctls to be writable, but let's
do this on-demand and when we see real use-case.

This patch is motivated by user request in the LXC
project [1]. Having this can help with running some
Kubernetes [2] or Docker Swarm [3] workloads inside the system
containers.

[1] https://github.com/lxc/lxc/issues/4278
[2] https://github.com/kubernetes/kubernetes/blob/b722d017a34b300a2284b890448e5a605f21d01e/pkg/proxy/ipvs/proxier.go#L103
[3] https://github.com/moby/libnetwork/blob/3797618f9a38372e8107d8c06f6ae199e1133ae8/osl/namespace_linux.go#L682

Cc: Stéphane Graber <stgraber@stgraber.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index daa62b8b2dd1..f84f091626ef 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -4272,6 +4272,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	struct ctl_table *tbl;
 	int idx, ret;
 	size_t ctl_table_size = ARRAY_SIZE(vs_vars);
+	bool unpriv = net->user_ns != &init_user_ns;
 
 	atomic_set(&ipvs->dropentry, 0);
 	spin_lock_init(&ipvs->dropentry_lock);
@@ -4286,12 +4287,6 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 		tbl = kmemdup(vs_vars, sizeof(vs_vars), GFP_KERNEL);
 		if (tbl == NULL)
 			return -ENOMEM;
-
-		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns) {
-			tbl[0].procname = NULL;
-			ctl_table_size = 0;
-		}
 	} else
 		tbl = vs_vars;
 	/* Initialize sysctl defaults */
@@ -4317,10 +4312,17 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->sysctl_sync_ports = 1;
 	tbl[idx++].data = &ipvs->sysctl_sync_ports;
 	tbl[idx++].data = &ipvs->sysctl_sync_persist_mode;
+
 	ipvs->sysctl_sync_qlen_max = nr_free_buffer_pages() / 32;
+	if (unpriv)
+		tbl[idx].mode = 0444;
 	tbl[idx++].data = &ipvs->sysctl_sync_qlen_max;
+
 	ipvs->sysctl_sync_sock_size = 0;
+	if (unpriv)
+		tbl[idx].mode = 0444;
 	tbl[idx++].data = &ipvs->sysctl_sync_sock_size;
+
 	tbl[idx++].data = &ipvs->sysctl_cache_bypass;
 	tbl[idx++].data = &ipvs->sysctl_expire_nodest_conn;
 	tbl[idx++].data = &ipvs->sysctl_sloppy_tcp;
@@ -4343,15 +4345,22 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	tbl[idx++].data = &ipvs->sysctl_conn_reuse_mode;
 	tbl[idx++].data = &ipvs->sysctl_schedule_icmp;
 	tbl[idx++].data = &ipvs->sysctl_ignore_tunneled;
+
 	ipvs->sysctl_run_estimation = 1;
+	if (unpriv)
+		tbl[idx].mode = 0444;
 	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_run_estimation;
 
 	ipvs->est_cpulist_valid = 0;
+	if (unpriv)
+		tbl[idx].mode = 0444;
 	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_est_cpulist;
 
 	ipvs->sysctl_est_nice = IPVS_EST_NICE;
+	if (unpriv)
+		tbl[idx].mode = 0444;
 	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_est_nice;
 
-- 
2.34.1


