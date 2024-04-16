Return-Path: <netdev+bounces-88384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FA28A6F2A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3EB28246B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA4312F5A6;
	Tue, 16 Apr 2024 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bTNnjpIa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6E12EBE1
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279560; cv=none; b=Y/h//bxXtlTEd2SXCMDy91olBJjOzp3s2bjXw3X2cj+oLHMcrRxwRZJCmyriSJ6nITKAW+omsyPOcDIJDIc/kPpEiw70u3qbcJYHcxdtvDhIc6WRoctxrmjHglZXnxTpx/zUD/oeNX1Gf1LVbK9qtBq/x3XgeX4zHdgpLVpatE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279560; c=relaxed/simple;
	bh=7lyToubjndBkFS/xjTwm6ZMyDvw4t6Soiztt3CZy43I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Cp3jTmISmCgo1TI2W1R08OxeYpnzoU5z+MZatnBU+AUYMflozkE6GAZbYf+u+Y5WmvtztQRzWuEKIkuf/ffsDDufnQbmDrNLFB2yekc5IZBUofR1rVLnumQCyakvNfJYpk+4dYYiKU5D10H3Br5vHl/flbZxK4Z+c8BqbjjCEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bTNnjpIa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2C30D4031E
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713278952;
	bh=SQh3gD+ToMzBSqvlRyRoPbaP+xTFtE8pqccMPR/X80o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=bTNnjpIaXCd5s6ImaVwHNR7OSVdldJr9ZXp9rizlLvN0oab5b/ipYE1rYNTdWZcki
	 sZiYr2Lria1r4Y3P94FTAa6fggkFwnfmoN2+KShG2m4/2STcSOG9IHkidpZ2O4Iug3
	 kZArQ6TkTQkayjwKRqUoNi3Be6Aip/zaV/5es6pil2Y+fW2rJVAJOEXUWZFbGIjFFD
	 ss2W4hgwqToocZT+FvWrvBkcKhYaAiN9S4dDRjGBw3n5gH65e4/4Gx67ThzOrQQTzA
	 Ew+p07TB13snTlofinejF86g628ukNRtOZL4zmzXpAuPav7cFQ31/HxJ2tgLFg/9pV
	 5oT28nwGfqUmg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a52539e4970so177230066b.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278952; x=1713883752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQh3gD+ToMzBSqvlRyRoPbaP+xTFtE8pqccMPR/X80o=;
        b=FnIj+yjeu3TRTuMshS5UD/zLKJBCES1upA+UDJlPwquOXyrzemeXceBj0avrw1hAmn
         LZnyBS+/cVI39SXSyNBIIT85ozdzAIi6zDYj0tv3vJQ+x14Yr3tn4NEHYWoNjWfb5MUV
         pDEJ28oeyQCpZfmmCmPTqkNc9e+hoYPw7p6m5Js3QsYVohwh+sbQlzJrpgZUNLXZAq28
         /IFFqaeudZAa6v+lEJeOQGvz56jaCwllyww3kIpZisZQ+geohJML/olJOcl2ioMJajtv
         FwFSTSKZR3ezQcrq8FBzlcr1UK0f1f+LnYSvNtP1h4wgd0lH3xWFV4tAATM3ai7tE0Uk
         QAsA==
X-Gm-Message-State: AOJu0YwH/QBUYmOWo91yOe3l+pJV//Eom0FbnE9HO0uPDvIN0zr5vGKX
	ubQXu6bYTZZf02RQNyiNLHecgN0WXllvEO2s3puudBeP8Jug3wKyD0oU1tUu/2Y0i+EC/UArBs+
	vUagqK5fMD72dSX0Xcc9ootUr6XAINccSwGawEMdloGMmlZOe8w3II6Aw6gofBzVzgOQRGQ==
X-Received: by 2002:a17:906:4956:b0:a52:6a4b:c810 with SMTP id f22-20020a170906495600b00a526a4bc810mr3400655ejt.35.1713278951885;
        Tue, 16 Apr 2024 07:49:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyz7nSFg/BkyuaXVLZ2ohQQZlKhJDri29PE7VWvk9uGXGz9gTCezlFmTExiTaW78zWQV6OQA==
X-Received: by 2002:a17:906:4956:b0:a52:6a4b:c810 with SMTP id f22-20020a170906495600b00a526a4bc810mr3400639ejt.35.1713278951519;
        Tue, 16 Apr 2024 07:49:11 -0700 (PDT)
Received: from amikhalitsyn.lan ([2001:470:6d:781:ef8b:47ab:e73a:9349])
        by smtp.gmail.com with ESMTPSA id gv15-20020a170906f10f00b00a517995c070sm6916856ejb.33.2024.04.16.07.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:49:11 -0700 (PDT)
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
Subject: [PATCH net-next] ipvs: allow some sysctls in non-init user namespaces
Date: Tue, 16 Apr 2024 16:48:14 +0200
Message-Id: <20240416144814.173185-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's make all IPVS sysctls visible and RO even when
network namespace is owned by non-initial user namespace.

Let's make a few sysctls to be writable:
- conntrack
- conn_reuse_mode
- expire_nodest_conn
- expire_quiescent_template

I'm trying to be conservative with this to prevent
introducing any security issues in there. Maybe,
we can allow more sysctls to be writable, but let's
do this on-demand and when we see real use-case.

This list of sysctls was chosen because I can't
see any security risks allowing them and also
Kubernetes uses [2] these specific sysctls.

This patch is motivated by user request in the LXC
project [1].

[1] https://github.com/lxc/lxc/issues/4278
[2] https://github.com/kubernetes/kubernetes/blob/b722d017a34b300a2284b890448e5a605f21d01e/pkg/proxy/ipvs/proxier.go#L103

Cc: Stéphane Graber <stgraber@stgraber.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 143a341bbc0a..92a818c2f783 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -4285,10 +4285,22 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 		if (tbl == NULL)
 			return -ENOMEM;
 
-		/* Don't export sysctls to unprivileged users */
+		/* Let's show all sysctls in non-init user namespace-owned
+		 * net namespaces, but make them read-only.
+		 *
+		 * Allow only a few specific sysctls to be writable.
+		 */
 		if (net->user_ns != &init_user_ns) {
-			tbl[0].procname = NULL;
-			ctl_table_size = 0;
+			for (idx = 0; idx < ARRAY_SIZE(vs_vars); idx++) {
+				if (!tbl[idx].procname)
+					continue;
+
+				if (!((strcmp(tbl[idx].procname, "conntrack") == 0) ||
+				      (strcmp(tbl[idx].procname, "conn_reuse_mode") == 0) ||
+				      (strcmp(tbl[idx].procname, "expire_nodest_conn") == 0) ||
+				      (strcmp(tbl[idx].procname, "expire_quiescent_template") == 0)))
+					tbl[idx].mode = 0444;
+			}
 		}
 	} else
 		tbl = vs_vars;
-- 
2.34.1


