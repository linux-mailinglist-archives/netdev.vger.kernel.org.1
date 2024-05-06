Return-Path: <netdev+bounces-93731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB988BCFD1
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707391C218A5
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1719C13D290;
	Mon,  6 May 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="I50FXy1H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D113CF96
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004907; cv=none; b=ELRJpeltXU1RwiPMRu5kCpjQbDnv1Poy9v9I2dAWJeZujPIyAZJuBTzpTudmZ2yfNAk4O4CKdvIdiXF4ZMLB4Z64K7ImLKIYuo78GqqKsyUJdeq1+l7Jrm1go+d8Ke/oy/taY1WYoei0OssYWcDkPX6OPI96Lxj1ye1RQYZMl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004907; c=relaxed/simple;
	bh=+Z/Lsq8TfQLRqsZxO6NPI1XpawG5p6DBMinswkhWeM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P5gkwgZZJVMFlNrTDw97rnHNbkGM2A7s/OaQ7BTy+Lwv7hrmcTkZmruyo6VGmShHDtX8DdxCrYJrdw2hsax7yNEc//EeMY2Or5fFPg302AOg0BfGzMTmtrHFwbUQeZ+LDqottQDq3yzcfPlqPtjcH/8TVLHhsHPV12gNyEBvLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=I50FXy1H; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 644E8424AC
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715004898;
	bh=OqRb1xOZql2PU0k7U3099kOtm3MQu6nOgdSdRzcue2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=I50FXy1HTgagt0UGN7IKLjGuyGasJnUJnAoIbgN9vUzDLSg4DXqmUXL1ZFtH1vtkH
	 aPRdNuDu+MZKXXwVyGXxzOyjbTgSzm2q3gRNJPgWMMWjc4IQ3i1seMpCRdlZI6+jrG
	 dPfWPfTAN3Lxg+NMMqnDG5I9OwYMo5H8CQAWVjMC/0wWPRctma7ha9Jf5GR8O2FE87
	 LR4+pEOPRXUFhuwe3FL9c+vQM+0lvTfDYxrDB9nddnCRmBM7s8Yk8ognb444d7cou8
	 JL4X+m+oCXcBcv27JMsiSD3dli77XXLYBY78HnU3AQJpeA1QBySTA47R6paaKqjocY
	 khRvau5fAF97g==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a599dbd2b6aso112032866b.2
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 07:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715004897; x=1715609697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqRb1xOZql2PU0k7U3099kOtm3MQu6nOgdSdRzcue2o=;
        b=q1h7wTWfAnTqiNPlIl1xOIE440hImDP+anV7oVEma/X160lfa2KxrbptdeDOloNKCg
         B6Ef47LZquHwVw6wkpIiydDqQVekUVxdtW1CS7yiZWhwJtxrlToA4FSzjeVzuToZ1L62
         79aI1Tk36ehpYSUazrmVpkZ40TPmzRD2P0arGdDNOlT3cJDf6aKPAYgejH24vSxmGoyy
         7saQNqzGj5hMerAsBvqGDNPHZfiQari87UXHJ2SlWws5VIhipxvT4yk4G0ujy3Y9DQK4
         I2Wi1ANva8PHLZ7tWHcGM7yRkQSrrvHfM5E994iWhUDkJF/O9NeO4TF9OPv/+6nOfJYV
         BfgQ==
X-Gm-Message-State: AOJu0YxkJiKdoXc2s8vc0aYHZl6JmgoZTH+bSdT/0maTKYrml1DtvFt5
	ZUYMyD/8rK3f8P3Li9zJaNTBOC3Xuh4oy7kIxx/bkgbC/CurEXZzWwi8VbRHEuDGwJ2qppVO+oU
	puxp52lEcEsA3+pN5IWG+D635+7n5QZH5bLV/5eDxb87dm2CUMX/X1qGZDUDCwd+/eTiafEO4aG
	IfDg==
X-Received: by 2002:a17:906:6a1b:b0:a59:ba18:2fb9 with SMTP id qw27-20020a1709066a1b00b00a59ba182fb9mr3733801ejc.12.1715004897347;
        Mon, 06 May 2024 07:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa1Vw6hfo0afKISW9+EzWZA3flJUxebMlVAlpg8F9CpQGamqKcFf6weBYpMVMzl1sqbbZYOA==
X-Received: by 2002:a17:906:6a1b:b0:a59:ba18:2fb9 with SMTP id qw27-20020a1709066a1b00b00a59ba182fb9mr3733786ejc.12.1715004897093;
        Mon, 06 May 2024 07:14:57 -0700 (PDT)
Received: from amikhalitsyn.lan ([2001:470:6d:781:4703:a034:4f89:f1de])
        by smtp.gmail.com with ESMTPSA id xh9-20020a170906da8900b00a597ff2fc0dsm4663754ejb.69.2024.05.06.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:14:56 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: horms@verge.net.au
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH v4 2/2] ipvs: allow some sysctls in non-init user namespaces
Date: Mon,  6 May 2024 16:14:44 +0200
Message-Id: <20240506141444.145946-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506141444.145946-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240506141444.145946-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Link: https://github.com/lxc/lxc/issues/4278 [1]
Link: https://github.com/kubernetes/kubernetes/blob/b722d017a34b300a2284b890448e5a605f21d01e/pkg/proxy/ipvs/proxier.go#L103 [2]
Link: https://github.com/moby/libnetwork/blob/3797618f9a38372e8107d8c06f6ae199e1133ae8/osl/namespace_linux.go#L682 [3]

Cc: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index e122fa367b81..b6d0dcf3a5c3 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -4269,6 +4269,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	struct ctl_table *tbl;
 	int idx, ret;
 	size_t ctl_table_size = ARRAY_SIZE(vs_vars);
+	bool unpriv = net->user_ns != &init_user_ns;
 
 	atomic_set(&ipvs->dropentry, 0);
 	spin_lock_init(&ipvs->dropentry_lock);
@@ -4283,10 +4284,6 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 		tbl = kmemdup(vs_vars, sizeof(vs_vars), GFP_KERNEL);
 		if (tbl == NULL)
 			return -ENOMEM;
-
-		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
-			ctl_table_size = 0;
 	} else
 		tbl = vs_vars;
 	/* Initialize sysctl defaults */
@@ -4312,10 +4309,17 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
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
@@ -4338,15 +4342,22 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
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


