Return-Path: <netdev+bounces-65697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5869183B620
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 01:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC44FB22428
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 00:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058962B;
	Thu, 25 Jan 2024 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+KPlNZ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD585C9A
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143122; cv=none; b=ILOT2k+eAZELEVsU0CQ7s5mzfVEfkrLD7xEJID1acZyk3hwo+bGh4W3Cj27Tq+vzde5aQArQgbha9OEk9r1VQ5xKeMpaNTRq0FiJtWHu0O4Jf+ih99n769UYKsFEapPiO6LFV+nEMq7MTpxkDxoRkMJ/90nWfROFtTYZakKpW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143122; c=relaxed/simple;
	bh=UXLqFLPksc8TBX/fRVryVJZhDzQr4mi4A1tE1ruVOXw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=MDbSvXhf9r7ymZjjtmrxY13NedCwWXdCyXOhHVR0vkep+wV3OtBKXQybdHhhBqnu8Ji7HycM9o8VtGXeTWgX4tJp6PII2ahlSHR8fKzkXW8Fg/npPh72JqNybE+2dOx+TXKveoZ/il6FgMx71MX/FjHZ7G3lUOg0gJr5nOW5fFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+KPlNZ1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ddcf5f19b1so11693b3a.3
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 16:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706143120; x=1706747920; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qn8BdPFqvNPf3y3XhmI+SBitz5j0kIGn7Bzsh51rVlY=;
        b=q+KPlNZ1MZXhnXm5hTYk0cIfz2cPAnNd82XquMh+Gg9MhCHJ4L1EFf85v5XZBf3Jc4
         7Anl6kKF5qCtY3RlgcvezLN/azbI9NmM8GKonzFek05UXHC8KnU5hzQ/poIhWS6jARXj
         RNTAy0042UCCtooXrO6CcH5P3l0CNHMuIYxZcm5IfYAWLc8q8J9wOAPCY2pRu1n/jR1b
         6HyENu3a3U7u/G0M9EkFnjsrPrA2MLjXYXT59Us1kY+u4cfSvuXICsaaZfPUyG7alEUU
         i/tUP9HwXtOp97t1Lc82W44gxMCYGcngem1IkJ/sDQBlZJDhsxWf8x3+0dP7bFq0d//O
         +TXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706143120; x=1706747920;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qn8BdPFqvNPf3y3XhmI+SBitz5j0kIGn7Bzsh51rVlY=;
        b=qjqOkvec5XgAYMornydF3Diea4VOsethgmd+PGjDwdDWBCApluAQyV5Zn0UD2Uk5Mz
         RCljoDNCFxOoKmcf7EgT9M7OJC2Ksb9m+zftxD5kiZnwWS8HwpBOfDUIhMEtqb4+0b7i
         pP3wPfhADnEarOxJutElFwHdbGQO/yVMFjec9lALSJBD+b36ua7Ix4xYV5MPm1tMkhfV
         fZDR/xdsz2UDvYUCf4S0d2FNYmCBeEMr3mLoEcYCJE0qLWsYjQR1vp2Xe3RNRSJC+idU
         7ZvU8hamzTTXAauBjlWGmw5ZIIHsb1GPx0j+26UyRDQlOR/tAwYQfC4g1K5yB7CKsk5t
         GHdw==
X-Gm-Message-State: AOJu0YxAGeitU2Rduzmo3pEpXi6P8IlyxRpk4SaiSY5nwOfcQuvYMkST
	m0xjZUMtD09yxeWpWQk9NfMyZFamEYsY85BA1ob17TB5DF1BUGyrNgZF4LDCnkxFWjX8om8Rh9B
	QbA==
X-Google-Smtp-Source: AGHT+IFa8Yq0GOgKUEbFmsa3YIW/J5CoVPcUUnAXHVJbLjsY5ctlLjWC3/Y4MB07S0ZXLnxh8t0tgnNqgsI=
X-Received: from aahila.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2f3])
 (user=aahila job=sendgmr) by 2002:a05:6a00:190d:b0:6dd:8444:d141 with SMTP id
 y13-20020a056a00190d00b006dd8444d141mr6837pfi.4.1706143120068; Wed, 24 Jan
 2024 16:38:40 -0800 (PST)
Date: Thu, 25 Jan 2024 00:38:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125003816.1403636-1-aahila@google.com>
Subject: [PATCH] ip/bond: add coupled_control support
From: Aahil Awatramani <aahila@google.com>
To: Aahil Awatramani <aahila@google.com>, Mahesh Bandewar <maheshb@google.com>, 
	David Dillow <dillow@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	David Ahern <dsahern@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

coupled_control specifies whether the LACP state machine's MUX in the
802.3ad mode should have separate Collecting and Distributing states per
IEEE 802.1AX-2008 5.4.15 for coupled and independent control state.

By default this setting is on and does not separate the Collecting and
Distributing states, maintaining the bond in coupled control. If set off,
will toggle independent control state machine which will seperate
Collecting and Distributing states.

Signed-off-by: Aahil Awatramani <aahila@google.com>
---
 include/uapi/linux/if_link.h |  1 +
 ip/iplink_bond.c             | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index d17271fb..ff4ceeaf 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1503,6 +1503,7 @@ enum {
 	IFLA_BOND_AD_LACP_ACTIVE,
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
+	IFLA_BOND_COUPLED_CONTROL,
 	__IFLA_BOND_MAX,
 };
 
diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 214244da..68bc157a 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -87,6 +87,12 @@ static const char *lacp_rate_tbl[] = {
 	NULL,
 };
 
+static const char *coupled_control_tbl[] = {
+	"off",
+	"on",
+	NULL,
+};
+
 static const char *ad_select_tbl[] = {
 	"stable",
 	"bandwidth",
@@ -148,6 +154,7 @@ static void print_explain(FILE *f)
 		"                [ tlb_dynamic_lb TLB_DYNAMIC_LB ]\n"
 		"                [ lacp_rate LACP_RATE ]\n"
 		"                [ lacp_active LACP_ACTIVE]\n"
+		"                [ coupled_control COUPLED_CONTROL]\n"
 		"                [ ad_select AD_SELECT ]\n"
 		"                [ ad_user_port_key PORTKEY ]\n"
 		"                [ ad_actor_sys_prio SYSPRIO ]\n"
@@ -162,6 +169,7 @@ static void print_explain(FILE *f)
 		"XMIT_HASH_POLICY := layer2|layer2+3|layer3+4|encap2+3|encap3+4|vlan+srcmac\n"
 		"LACP_ACTIVE := off|on\n"
 		"LACP_RATE := slow|fast\n"
+		"COUPLED_CONTROL := on|off\n"
 		"AD_SELECT := stable|bandwidth|count\n"
 	);
 }
@@ -176,7 +184,7 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 {
 	__u8 mode, use_carrier, primary_reselect, fail_over_mac;
 	__u8 xmit_hash_policy, num_peer_notif, all_slaves_active;
-	__u8 lacp_active, lacp_rate, ad_select, tlb_dynamic_lb;
+	__u8 lacp_active, lacp_rate, ad_select, tlb_dynamic_lb, coupled_control;
 	__u16 ad_user_port_key, ad_actor_sys_prio;
 	__u32 miimon, updelay, downdelay, peer_notify_delay, arp_interval, arp_validate;
 	__u32 arp_all_targets, resend_igmp, min_links, lp_interval;
@@ -367,6 +375,13 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 
 			lacp_active = get_index(lacp_active_tbl, *argv);
 			addattr8(n, 1024, IFLA_BOND_AD_LACP_ACTIVE, lacp_active);
+		} else if (strcmp(*argv, "coupled_control") == 0) {
+			NEXT_ARG();
+			if (get_index(coupled_control_tbl, *argv) < 0)
+				invarg("invalid coupled_control", *argv);
+
+			coupled_control = get_index(coupled_control_tbl, *argv);
+			addattr8(n, 1024, IFLA_BOND_COUPLED_CONTROL, coupled_control);
 		} else if (matches(*argv, "ad_select") == 0) {
 			NEXT_ARG();
 			if (get_index(ad_select_tbl, *argv) < 0)
@@ -659,6 +674,15 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			     lacp_rate);
 	}
 
+	if (tb[IFLA_BOND_COUPLED_CONTROL]) {
+		const char *coupled_control = get_name(coupled_control_tbl,
+						   rta_getattr_u8(tb[IFLA_BOND_COUPLED_CONTROL]));
+		print_string(PRINT_ANY,
+			     "coupled_control",
+			     "coupled_control %s ",
+			     coupled_control);
+	}
+
 	if (tb[IFLA_BOND_AD_SELECT]) {
 		const char *ad_select = get_name(ad_select_tbl,
 						 rta_getattr_u8(tb[IFLA_BOND_AD_SELECT]));
-- 
2.43.0.429.g432eaa2c6b-goog


