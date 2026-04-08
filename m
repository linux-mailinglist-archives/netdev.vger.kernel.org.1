Return-Path: <netdev+bounces-276598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGwqNiJz1ml2FQgAu9opvQ
	(envelope-from <netdev+bounces-276598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:24:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BCA3BE24C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 176E03011C5F
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68843D47C0;
	Wed,  8 Apr 2026 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="dlmGXuS+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f225.google.com (mail-lj1-f225.google.com [209.85.208.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C03D47B3
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661854; cv=none; b=rxzhE6EX/LB2DMweAEoNfSPNHHTns/0gpcz3Q6EJJ9dAcTl+rIxm5zlx4fL1oJCnNRedNvOcfVSOHDhJ960tSlBBpKzeQcOJVN6mvVZ7Y3tqfBit8aSNB8ULvnTY6/30sgyq2ra8CAhK9avMNcpxdfInENro8NRIwS54gY4u9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661854; c=relaxed/simple;
	bh=K1dKURet3J0/M3usaAl++UniLgcowsoxxi0g23wCoHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iN/YH32dYbPMQ8bQXs0aE6OYb5kZLB8RDxbw/lrHGg5mLu3IM4eekcBARWJfCHvT0mXzDA4bG6YZIaXhNxLMHwwGzpenrrl5d5ImFFaBRwjh4REfi4VNP80PDDcgfbpF2z8hfITlPLFD2jeXK+7sOOxlLUgSwMVyMwy311UzQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=dlmGXuS+; arc=none smtp.client-ip=209.85.208.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f225.google.com with SMTP id 38308e7fff4ca-38e0ef48ac0so125231fa.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1775661852; x=1776266652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUlY4X31eB+kAELbhntPD+zzJcIcCma3OFMBAfgwm6U=;
        b=dlmGXuS+VVUH0jxElkoN7l73W4Al991D6jy6xWtrDD++/mk0jqduCoKlABRZk9ddYn
         tuQWrcZqsLxd2nPDVHyCink4SbIh0EJDPOL9QKJY4BEo2oX8X9RqhaE4TnsiO1+B6YFf
         1Zq0N78dUoMKrp6A0jJXCgC0X7/GXN3YPqhuCghzO9I6b1A9KuRwYgaX83PrJLVbkZ2z
         x46DqV52PSMGQGtxknMU0Kcl/tXLSwqgkuNaYeLs/f9F46N1/AsRAxyFDmrohzrhPhvN
         xJ4e5mg9g5tnaH5MGGr/FX8jiAklkYTny90trc8t6saahDY8LVdquDQQo6vEYYXFuEM9
         neWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661852; x=1776266652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUlY4X31eB+kAELbhntPD+zzJcIcCma3OFMBAfgwm6U=;
        b=Om7SFmU7WicivTCIs8MhN41UOTNq0XSJkHUb235OqqfRPhB7RNLhCJKo1ZG7H5Qudk
         CYIjCwtX3+2wwnEvfGLLnp1Pu7huxZll25JmuQlVbepIfHWwP0ttPafuY0/cppWzefFn
         oLrCdwMvXg0ISytY2C1Jl7f9e4gWmKwZiM6YOWerAeW6h7L7nxTFZuYvwsUZbgpP2vvu
         xOiEUBk8+XFZXlNLMZHh/YtsqjpH/vmGUC+JbbLCoYlAPTVGCMkSI5bcv3tHveEC2gqH
         rbUkhR+Vjml3bblQn4jYjqJxvbvY959kx542PrPXyZTNTeRYySYTTwk/p9Dcr5dWfLS/
         yeeQ==
X-Gm-Message-State: AOJu0Yz7TISCn5p9QAF1VyGKqaYqiBIOcswLbX+whj9lm1ZeFYyCnNyM
	qs4DwtGD6J2MgJPckEoawuaY5FkECM6M3+g7L1CcewbLhN1foT239PsjBAox5lPzoUKhwwqH07f
	4aUuAwO1ZwYwOSO2s3tf48nWcTwGzZOcNMnMK
X-Gm-Gg: AeBDiesBvz3DKCRgZNfNfn7trrDyujB+WIh+CD7hY4su3xFcXP6UeyDnoUCc+rAkDV8
	Ycabii+FUt4PbzjQTd+llyGe3HkpeZvSncNNKMMhvLV0qxx2qrZu7jEIGNBHqZFzPUukNT7Zg/D
	OnTqJt2cwyDdyJvzsvdYzAvkljSoG1PVObDoB8NpVsv9MMMnIa4s6rz7S1Tdol2+UPLxjMKFGvn
	shgQC+FPpY7fKqWFNmXD5lG8djjVWBNfpxKwW18dHpI0vDB+vFnQ7+D8bDGstZPLRji27dtCSws
	Dh/W964i6zsnzZymywQHCFrdFLFY9smT0aUOr3/dD3SlA2KQyyy6L2hZQ4HHhq6iLoG5PsJTBGN
	mBQ2CxsCmN438NyKlYKjcwK3epL37Vi/k+1zM0glXE60d1kqdHjED
X-Received: by 2002:a2e:b889:0:b0:38d:eb82:d7f9 with SMTP id 38308e7fff4ca-38e3369925bmr321311fa.20.1775661851593;
        Wed, 08 Apr 2026 08:24:11 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-38cd21e4fd1sm16687451fa.22.2026.04.08.08.24.11;
        Wed, 08 Apr 2026 08:24:11 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 45F3A27058;
	Wed,  8 Apr 2026 17:24:11 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [RFC PATCH iproute2] ip/bond: add lacp_fallback support
Date: Wed,  8 Apr 2026 17:24:09 +0200
Message-Id: <20260408152409.276358-1-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276598-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid]
X-Rspamd-Queue-Id: 57BCA3BE24C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

lacp_fallback defines the behavior of a LACP bonding interface
when no slaves are in collecting(/distributing) state while at least
'min_links' slaves have carrier.

In the default (legacy) mode, the bonding master remains up and a
single slave is selected for TX/RX, while traffic received on other
slaves is dropped. This preserves the existing behavior.

In strict mode, the bonding master reports carrier down in this
situation.

Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 include/uapi/linux/if_link.h |  1 +
 ip/iplink_bond.c             | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 2037afbc..1588d520 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1537,6 +1537,7 @@ enum {
 	IFLA_BOND_NS_IP6_TARGET,
 	IFLA_BOND_COUPLED_CONTROL,
 	IFLA_BOND_BROADCAST_NEIGH,
+	IFLA_BOND_LACP_FALLBACK,
 	__IFLA_BOND_MAX,
 };
 
diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 714fe7bd..f33252e8 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -87,6 +87,12 @@ static const char *lacp_rate_tbl[] = {
 	NULL,
 };
 
+static const char *lacp_fallback_tbl[] = {
+	"legacy",
+	"strict",
+	NULL,
+};
+
 static const char *ad_select_tbl[] = {
 	"stable",
 	"bandwidth",
@@ -155,6 +161,7 @@ static void print_explain(FILE *f)
 		"                [ ad_user_port_key PORTKEY ]\n"
 		"                [ ad_actor_sys_prio SYSPRIO ]\n"
 		"                [ ad_actor_system LLADDR ]\n"
+		"                [ lacp_fallback LACP_FALLBACK ]\n"
 		"                [ arp_missed_max MISSED_MAX ]\n"
 		"\n"
 		"BONDMODE := balance-rr|active-backup|balance-xor|broadcast|802.3ad|balance-tlb|balance-alb\n"
@@ -168,6 +175,7 @@ static void print_explain(FILE *f)
 		"AD_SELECT := stable|bandwidth|count\n"
 		"COUPLED_CONTROL := off|on\n"
 		"BROADCAST_NEIGHBOR := off|on\n"
+		"LACP_FALLBACK := legacy|strict\n"
 	);
 }
 
@@ -188,6 +196,7 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 	__u32 packets_per_slave;
 	__u8 missed_max;
 	__u8 broadcast_neighbor;
+	__u8 lacp_fallback;
 	unsigned int ifindex;
 	int ret;
 
@@ -417,6 +426,13 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 				return -1;
 			addattr_l(n, 1024, IFLA_BOND_AD_ACTOR_SYSTEM,
 				  abuf, len);
+		} else if (matches(*argv, "lacp_fallback") == 0) {
+			NEXT_ARG();
+			if (get_index(lacp_fallback_tbl, *argv) < 0)
+				invarg("invalid lacp_rate", *argv);
+
+			lacp_fallback = get_index(lacp_fallback_tbl, *argv);
+			addattr8(n, 1024, IFLA_BOND_LACP_FALLBACK, lacp_fallback);
 		} else if (matches(*argv, "tlb_dynamic_lb") == 0) {
 			NEXT_ARG();
 			if (get_u8(&tlb_dynamic_lb, *argv, 0)) {
@@ -642,6 +658,15 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "all_slaves_active %u ",
 			   rta_getattr_u8(tb[IFLA_BOND_ALL_SLAVES_ACTIVE]));
 
+	if (tb[IFLA_BOND_LACP_FALLBACK]) {
+		const char *lacp_fallback = get_name(lacp_fallback_tbl,
+						 rta_getattr_u8(tb[IFLA_BOND_LACP_FALLBACK]));
+		print_string(PRINT_ANY,
+			     "lacp_fallback",
+			     "lacp_fallback %s ",
+			     lacp_fallback);
+	}
+
 	if (tb[IFLA_BOND_MIN_LINKS])
 		print_uint(PRINT_ANY,
 			   "min_links",
-- 
2.39.2


