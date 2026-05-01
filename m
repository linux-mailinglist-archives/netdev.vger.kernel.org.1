Return-Path: <netdev+bounces-283059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL02DG3/82n99QEAu9opvQ
	(envelope-from <netdev+bounces-283059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:18:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1484A98B9
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48771304C4E3
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0735B2DCBFA;
	Fri,  1 May 2026 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM79vSMu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DD2DA75B
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598185; cv=none; b=hM7sa++3NP8axUZQG0afiKjpBLzQmPOr3G5eM7cCxYPq4+39LIV0sW6qieQYjiHnN9KtQl891Dd9tncha/l1OoHhBAWhPIVkq++LTDD58KOcjF/AM4kWndDrd8WWH7AUhQzeHuozFTbmVUx+sGFuoDlKz4kLUF0o2CNYaSUwpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598185; c=relaxed/simple;
	bh=RxokoSXbktcWQ7LbvVcNKheJEF3d7ICAu9T50l6Meu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArJMz38FscI+idGJH4fuOgt4xAIv9SiLZtR99GU96hq5RSM4f5PbxGnChEWQqGU6NoBX6Li2M/c/27oxhPp4wCCj2dVIoNLKX13blbJm+6x/IrXZbHUNzHMPPKFh3zGHvSpbHPX+lIzu+F5iRM5gnieNdz35wQrRxcpf4VlgWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM79vSMu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so15576595e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777598182; x=1778202982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWP6fzXh/PxWf7mD469ALYU9SA4281WoINojMuLywKg=;
        b=jM79vSMuRKRZPMqThF5qXRx3ClDXWPVZH9Fp0TJZbjH3RFtrpqIlzT59sGI6Gz3RWk
         CD0qQqHOtRjJ6/US2Y2C1RmVVIOv0Yfq0fDQYcZtGPkFPrGCeOHkfk6RYKGD+Aot6Ptw
         E8VfiCuoArBlbiVtvE9gdT609L6v4X5v+cZNFzN97Yd6e3wEVgriwE0oHssgJFF+yH4Z
         pOomuLc83xVY6ImhX/3IY2XsdgEBX8GqVF2I3cx2yrwHWxRBa13t6wPHdx0GFZjt6xbJ
         1HlZVV6P7I0pBdLvjTET5xmw7FdOJPa9H6gIhqrK/9/QdtlhgLg4oQ2dtHk5rzphp7gv
         22Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777598182; x=1778202982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VWP6fzXh/PxWf7mD469ALYU9SA4281WoINojMuLywKg=;
        b=Culm0ikoByMI18REqCgsL3SmX+0JJYLTf25JH53B2DqjJNZSCDLnBcqTVSxuUd0awU
         +9NGeiEEjOo0HFYCjV5nrWzoK4YUsarTMZ9SbOsPXhT8kqiIj6YT3KjBFnw7wgpJE53R
         Ln0Tyw4nhXuIhunmD64lalxjiFaAEGOWQwAG7Ds5BS+g8rIGbfaOKVvmbPVBUZ9MzfJc
         gAdral+nIRWAY5x0cv4boD4dI4Z550RKpU0ZJzWB6ScSYMUSj7q/yvXmLbGHe/FUFzhB
         U19/BvUoy1gJBqKweubgjbfQUi+E/V4v4uOaOxnNfSAFYeGGbMS/HYYja35tGzb72xGs
         qXFg==
X-Gm-Message-State: AOJu0YxaE7tVByYh3CGNJHj/nVaJ9Y72y96DSLit0eLC3T3g5Maq3Le9
	ZkAuXDeYPE6BCDRL73fwI7DK2QwXuJlnCcr0C3WA8Levz/BvhPnBLZaka8oJgUCo
X-Gm-Gg: AeBDiesshX9bRgvxS+AbirzikrloYvC7aLPMPrKystjzl93TcuziJ0YcFD8Cn5+LEih
	UjRkKBrdB+Xkbfj+MMZnZJggGfBEN/OUYauM6BlcnM0CDZtuknSEzEzmy7eBainnEz0I2jYz/Q+
	QjQpjNL591D8GS1LTkee8jA/5n0ReT646AyVsAB/qLfpkM2FdiHfzTMBGwsbsip7xZuOXvmFdqP
	ieT1e/lBNZ+QaZk3BVNdYhbct0DeGqRg0TxCYNMcis40bN8ojDQ4Wxk3xU0LgwB13oe3wbxQw25
	FC7In41ZwF4KGfgpNOAIIF1QEDw9GKov1xfaiebZZlFUcPuDegi2+m6vXnewXIoAG5224kgM7DG
	pOg3Op5uZoYRY8AXsF0J7HhKZohFfXoxUKBsLXbLBGCD1ziYQ6+S4gTzAFRDiRHZ+SsINYBXgCa
	OdAbDd5XZEM1cxUtYXztnvdYEuJ4xy+3DgrOXs9Q8fNQ==
X-Received: by 2002:a05:600c:4f52:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48a85e684a8mr70503615e9.6.1777598182342;
        Thu, 30 Apr 2026 18:16:22 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:41::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm32792805e9.0.2026.04.30.18.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:16:21 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next 3/5] netshaper: Extend show output with parent, bw-min and weight
Date: Thu, 30 Apr 2026 18:16:09 -0700
Message-ID: <20260501011611.3533573-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
References: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA1484A98B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-283059-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Extend print_netshaper_attrs() to display parent scope/id, bw-min,
and weight fields in the show output. Replace the switch-based
iteration with direct attribute checks for cleaner output formatting.
Verify the support by setting the rate for a queue and attempt to read it
back.

Before:
 ./netshaper set dev eth2 handle scope queue id 0 bw-min 10mbit weight 5
 ./netshaper show dev eth2 handle scope queue id 0
scope: queue
id: 0
dev: eth2

After:
 ./netshaper set dev eth2 handle scope queue id 0 bw-min 10mbit weight 5
 ./netshaper show dev eth2 handle scope queue id 0
dev: eth2 scope queue id 1 parent scope netdev bw-min 10 mbps weight 5

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 netshaper/netshaper.c | 89 ++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 34 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 4ee30525..53a5eae3 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -72,53 +72,74 @@ static int parse_rate(const char *str, __u64 *rate_bps)
 
 static void print_netshaper_attrs(struct nlmsghdr *answer)
 {
+	struct rtattr *parent_tb[NET_SHAPER_A_HANDLE_MAX + 1] = {};
 	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
 	int len = answer->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
 	struct rtattr *tb[NET_SHAPER_A_MAX + 1] = {};
 	struct rtattr *handle_tb[NET_SHAPER_A_HANDLE_MAX + 1] = {};
-	__u32 bw_max_mbps, scope, id;
-	__u64 bw_max_bps;
+	__u32 scope, id;
 	int ifindex;
 
 	parse_rtattr_flags(tb, NET_SHAPER_A_MAX,
 			   (struct rtattr *)((char *)ghdr + GENL_HDRLEN),
 			   len, NLA_F_NESTED);
 
-	for (int i = 1; i <= NET_SHAPER_A_MAX; ++i) {
-		if (!tb[i])
-			continue;
-		switch (i) {
-		case NET_SHAPER_A_BW_MAX:
-			bw_max_bps = rta_getattr_uint(tb[i]);
-			bw_max_mbps = (bw_max_bps / 1000000);
+	if (tb[NET_SHAPER_A_IFINDEX]) {
+		ifindex = rta_getattr_u32(tb[NET_SHAPER_A_IFINDEX]);
+		print_color_string(PRINT_ANY, COLOR_IFNAME, "dev",
+				   "dev: %s ", ll_index_to_name(ifindex));
+	}
 
-			print_uint(PRINT_ANY, "bw-max", "bw-max: %u mbps\n",
-				   bw_max_mbps);
-			break;
-		case NET_SHAPER_A_IFINDEX:
-			ifindex = rta_getattr_u32(tb[i]);
-			print_color_string(PRINT_ANY, COLOR_IFNAME, "dev",
-					   "dev: %s\n",
-					   ll_index_to_name(ifindex));
-			break;
-		case NET_SHAPER_A_HANDLE:
-			parse_rtattr_nested(handle_tb, NET_SHAPER_A_HANDLE_MAX,
-					    tb[NET_SHAPER_A_HANDLE]);
-			if (handle_tb[NET_SHAPER_A_HANDLE_SCOPE]) {
-				scope = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_SCOPE]);
-				print_string(PRINT_ANY, "scope",
-					     "scope: %s\n",
-					     net_shaper_scope_names[scope]);
-			}
-			if (handle_tb[NET_SHAPER_A_HANDLE_ID]) {
-				id = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_ID]);
-				print_uint(PRINT_ANY, "id", "id: %u\n", id);
-			}
-			break;
-		default:
-			break;
+	if (tb[NET_SHAPER_A_HANDLE]) {
+		parse_rtattr_nested(handle_tb, NET_SHAPER_A_HANDLE_MAX,
+				    tb[NET_SHAPER_A_HANDLE]);
+		if (handle_tb[NET_SHAPER_A_HANDLE_SCOPE]) {
+			scope = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_SCOPE]);
+			print_string(PRINT_ANY, "scope", "scope %s ",
+				     net_shaper_scope_names[scope]);
+		}
+		if (handle_tb[NET_SHAPER_A_HANDLE_ID]) {
+			id = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_ID]);
+			print_uint(PRINT_ANY, "id", "id %u ", id);
+		}
+	}
+
+	if (tb[NET_SHAPER_A_PARENT]) {
+		parse_rtattr_nested(parent_tb, NET_SHAPER_A_HANDLE_MAX,
+				    tb[NET_SHAPER_A_PARENT]);
+		if (parent_tb[NET_SHAPER_A_HANDLE_SCOPE]) {
+			scope = rta_getattr_u32(parent_tb[NET_SHAPER_A_HANDLE_SCOPE]);
+			print_string(PRINT_ANY, "parent-scope",
+				     "parent scope %s ",
+				     net_shaper_scope_names[scope]);
 		}
+		if (parent_tb[NET_SHAPER_A_HANDLE_ID]) {
+			id = rta_getattr_u32(parent_tb[NET_SHAPER_A_HANDLE_ID]);
+			print_uint(PRINT_ANY, "parent-id", "id %u ", id);
+		}
+	}
+
+	if (tb[NET_SHAPER_A_BW_MAX]) {
+		__u64 bw = rta_getattr_uint(tb[NET_SHAPER_A_BW_MAX]);
+
+		print_uint(PRINT_ANY, "bw-max", "bw-max %u mbps ",
+			   (__u32)(bw / 1000000));
 	}
+
+	if (tb[NET_SHAPER_A_BW_MIN]) {
+		__u64 bw = rta_getattr_uint(tb[NET_SHAPER_A_BW_MIN]);
+
+		print_uint(PRINT_ANY, "bw-min", "bw-min %u mbps ",
+			   (__u32)(bw / 1000000));
+	}
+
+	if (tb[NET_SHAPER_A_WEIGHT]) {
+		__u32 weight = rta_getattr_u32(tb[NET_SHAPER_A_WEIGHT]);
+
+		print_uint(PRINT_ANY, "weight", "weight %u ", weight);
+	}
+
+	printf("\n");
 }
 
 static int do_cmd(int argc, char **argv, int cmd)
-- 
2.52.0


