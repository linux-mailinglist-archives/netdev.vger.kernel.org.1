Return-Path: <netdev+bounces-274875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE3kBSBDz2k3ugYAu9opvQ
	(envelope-from <netdev+bounces-274875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E14390E9A
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB9F73069DCE
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18642317164;
	Fri,  3 Apr 2026 04:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXtUzTvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF62FFF8F
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190770; cv=none; b=KqhEJn4Zkrabz3ISUcezVOQPBFhjEAhb2fOBysXQ3WMbyOfjkaZWwqnoDE5WqrC5ZgLZ767kueEu8OGtQtc/RdXV7XH1zNHOn3bG0nGcoH9RKNXjam3MWy8rydBJw33uSbdM/djooorEFgyoMk3haRjTGemhVaUvZ3XXHI7TcQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190770; c=relaxed/simple;
	bh=a1JB8SRyfi5UU4T0YbcXVilgnyd7C9KNeDPzvkBXfa0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IY75V0ZP1JDyqzmDWBXAEtynz1zFVy6wA2X4yChN5iwFgtphNDQo36YlP5W+wYxPjtJ0d7GZ7SWSxwDYgjA5kHosIwmK87HzskK0JvfOeOOhRHB3W0bBDqzaHains8oTgihWV/kSuE79hniRPEyC9EWfmRInjDeu5hPeu91R+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kXtUzTvl; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b4b81c632so18781531cf.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775190768; x=1775795568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDng1DPkWpD/U6pPHEd7ZryLY/PVqTSrAeKbwOVIjbM=;
        b=kXtUzTvlp8qOsvS/fd8vEl99sZWKK6MZ34OhczYieML6oXw1xxNP1CGpsX+Xt5zhQ0
         JLfG+nMxS+WfGLa3LCBGCkYl2F9og0jmDiOKONeKhMIAn5IZ3Qpd784A3k80gxtWOOoy
         mTDeqWVxv6aBQGa1zdkt5wcea3L2LxkPXnA7mmVDwnKsVJgrhnfojpNVavpE8GYuhhk6
         Sw/1yeV0dI30qfl+mfdTORZd4SNAt4+NmTjm2q593vk6raHXFZKX9Tce8oO8JjmVTk5m
         F0EmDNvgxiwmBDDITYwuq/oj3n6xG8NtfArrZgxEdU4C2VdtjHH6u0+9KYy9j2pyXys1
         8XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190768; x=1775795568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDng1DPkWpD/U6pPHEd7ZryLY/PVqTSrAeKbwOVIjbM=;
        b=jer77ITY0BJFNOy1BtMhAav5dS1WKcg8fJ0Qw8j3tDciu1/TdUS4by97TXqN5hD7Gx
         gBqA0bd8dLmfcmhwkHdhzrFi5EM79o1Dtzb/JQLBd/wxppBssJlKvPtuVwtL58hC5cgq
         4xRfcGl+zeXtCiDh+KrYd8nRLPEiF8JwM5D0s8TQFbEJ7r1VSB6wdrnXYfKPZTS9CFNR
         Vs5TH7fvc4tvj4uNkUgysIc+Z7Z7yy0PyaPmqM7eL9IqBlL+i7c5g9k90fy5VqFrbsmg
         sWNfOnob8WicCo7Oyf9i/+0kkV8zULwtIwdLphdVyW+n/uaLdWq59QoheXym+0G2UBsL
         F1jg==
X-Forwarded-Encrypted: i=1; AJvYcCU7XcqstGn2NwKSaZUtV2OnNETIAMBoqA7Rsmat/tWlyyd/9si6NNeVeXkd7c7WuTS2Y9y6sZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJjZEchVicNPszHFdcGdrsFcJBRI9jj+17V39yFGBtAhj5Idk
	3A64Q6vg2q4UyIDzbjJX7B0oeQ5VvTv2nj+7F1gq6ZOs5re9A317M8ctWjZiULXil15trunGgwU
	0axioFHjvIj5D3Q==
X-Received: from qtqb22.prod.google.com ([2002:ac8:5416:0:b0:509:12ca:fa57])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:7002:b0:509:164b:5b44 with SMTP id d75a77b69052e-50d62b87d03mr16890471cf.67.1775190767405;
 Thu, 02 Apr 2026 21:32:47 -0700 (PDT)
Date: Fri,  3 Apr 2026 04:32:33 +0000
In-Reply-To: <20260403043237.3909226-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403043237.3909226-6-edumazet@google.com>
Subject: [PATCH net-next 5/9] net: enetc: use tso_features_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Ioana Ciornei <ioana.ciornei@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com,nxp.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274875-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 81E14390E9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We must fallback to GSO if a TSO packet has too big headers,
or risk corruptions.

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c     | 2 ++
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 2 ++
 drivers/net/ethernet/freescale/enetc/enetc_pf.c  | 2 ++
 drivers/net/ethernet/freescale/enetc/enetc_vf.c  | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index aa8a87124b103261348fe371ef158571d4c9000c..a39aaf2d2f5345f71027bc0b813a96eb36ac3e5d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -887,6 +887,8 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 
 	/* Initialize the TSO handler, and prepare the first payload */
 	hdr_len = tso_start(skb, &tso);
+	DEBUG_NET_WARN_ON_ONCE(hdr_len > TSO_HEADER_SIZE);
+
 	total_len = skb->len - hdr_len;
 	i = tx_ring->next_to_use;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 56899f2254aaa2d87a184bc9dbf09298186148cf..52393c42d45ea1a50abbc9ee4e8e8b2fa462f70e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -6,6 +6,7 @@
 #include <linux/of_net.h>
 #include <linux/of_platform.h>
 #include <linux/unaligned.h>
+#include <net/tso.h>
 
 #include "enetc_pf_common.h"
 #include "enetc4_debugfs.h"
@@ -564,6 +565,7 @@ static int enetc4_pf_set_features(struct net_device *ndev,
 static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_open		= enetc_open,
 	.ndo_stop		= enetc_close,
+	.ndo_features_check	= tso_features_check,
 	.ndo_start_xmit		= enetc_xmit,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a12fd54a475f6cd0516185aa817f2d8c430a0a1d..6b5c3b1f43fc8f00cf0c58c28e5b5b035c0eec41 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -7,6 +7,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_net.h>
 #include <linux/pcs-lynx.h>
+#include <net/tso.h>
 #include "enetc_ierb.h"
 #include "enetc_pf_common.h"
 
@@ -617,6 +618,7 @@ static int enetc_pf_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_open		= enetc_open,
 	.ndo_stop		= enetc_close,
+	.ndo_features_check	= tso_features_check,
 	.ndo_start_xmit		= enetc_xmit,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 6c4b374bcb0ef14284d2ea153d8bd4112fe5309a..7c9f3c7e9a5685530bf203ced3514d6dac574099 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -3,6 +3,7 @@
 
 #include <linux/module.h>
 #include "enetc.h"
+#include <net/tso.h>
 
 #define ENETC_DRV_NAME_STR "ENETC VF driver"
 
@@ -115,6 +116,7 @@ static int enetc_vf_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_open		= enetc_open,
 	.ndo_stop		= enetc_close,
+	.ndo_features_check	= tso_features_check,
 	.ndo_start_xmit		= enetc_xmit,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_vf_set_mac_addr,
-- 
2.53.0.1213.gd9a14994de-goog


