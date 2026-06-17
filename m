Return-Path: <netdev+bounces-300176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i+/4GTCbMmoC2wUAu9opvQ
	(envelope-from <netdev+bounces-300176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:03:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C9C699F18
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:03:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=Bg2O086R;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300176-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300176-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D601E302B382
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9013090C2;
	Wed, 17 Jun 2026 13:03:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com [209.85.208.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45154306D3F
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 13:03:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701399; cv=none; b=GFPjTh5Wce0QixNex3avHdsxVfGHoDHIA98KhayGbop61jp149ziZjpE0wF5KW9PDilFRR5Mb4pw6Kf3Cli5950DKPd32KFvgJ9GUW2q1iqPHhjmz/Hsk5iD02uBaP1pTmvvJcvk5bzrPD3Uh2fY2JH8kd64dy0/kAqiGrzdoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701399; c=relaxed/simple;
	bh=ts1rRBosKQFZ+v5qJKwv8dDssbtcNP04PVKunA0itA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LunMmrQpFjn4JFILlZyQYnrIr11adPnSPyy4vUFnZP6FaGOQuqDN7Jka+FhBt+uyNg8YwETFj9tBuvmWEdwIbfyGJCGS5JxkWZdeNz7uvxfpctqne2lTyzc0z+QdMWXnsEqfn3OCJuEM+27i5j3mJ/kdB54RzeZ7G7BZhCLKdyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Bg2O086R; arc=none smtp.client-ip=209.85.208.97
Received: by mail-ed1-f97.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so10504432a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781701396; x=1782306196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcApDTh8G83mAxbEBCd++ik2ha9o+kyBGpiZ1fdPeto=;
        b=Bg2O086RqQnQTeqTWCiuktLU5nhWjH3VuzjLm/GxTS492ajOeYhTYuUCccDHwK2aQG
         GjKt+gBc3V8fUVnwHZ2z5+BFgDKMW9ngjrQJyA7evCdmOB9uaaAH8W7RZLl7Dt9skTRS
         FsmtThofbN0LJg9v9WJq6u4H1WdbOMQXCNIQ30DOfejgZ4m6UuKHkSk9XzPozMy7BEWG
         wVLPKYOl1qvhxz+dloWCQk4PDGiu9te4GSa93Ofdb4GJRPpSQbAG/Nm7G10sjSMgXp/X
         Bs0Og7GBzWPKNI1Cbyfs22AcXOLom1dozzJgHfPVqKkLL82LHPB5x2a+6Iu6AN0jMcZu
         s+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781701396; x=1782306196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcApDTh8G83mAxbEBCd++ik2ha9o+kyBGpiZ1fdPeto=;
        b=jOUcn2IJkJaKoVvEcZW4/dADKHAdeHG6+VEGRq/oUvjxwFCDHIN2wZhdMPiLYAb0e1
         hvgM+ymyHDubHFQZy2mUsc2aTiRDfxDggQY9YeyWsz3SoUFttxDRJHhCQXdkuJNxvk3+
         nMmaTkJBd8ow6kbUiLEFZgkAq+fjkiGn3K9MSoc9k7EkKZvFTJ4bIIAe2CUoA5fvMkcj
         U7IXss79jYm6zvkTT+7W9sBZqxYjDTJhDA1WuCAVd0tcGvo2aTXMnLqzTAzatKdDlfM4
         o5pqdhmOFIHLyXIMHzviqpfu6gwj9JVmNqVNINuYUX227XLwor71fS/9XRu8d5z88vgV
         6J5Q==
X-Gm-Message-State: AOJu0YwmGv3Q74/p6p1sSanhkyOlLoemo9MtqGw8mmK1IUKSKJ812R+z
	YoaNO1pWdrmm/UpbTaUExmG0/tHWfHynbyUBRoeGXVoXwqhsD2rjpV3ZcdKexcwa3nPZM7dt9HZ
	jWVoP5P/YkdH62y1fAEcH607msIfLQKoCO26F
X-Gm-Gg: Acq92OGALm2skWG9Hb0OXOipY629OBYGQudqzIWCqnZsWUu0m84x0YAZv5Ryw69g78C
	JRJgJ3y25/oMg5ZPeKImJ7Mpc3aob4RSVDvV6yvWiur4nnIySr5WfHF0S+xiPBlDgN/HEJDXQiJ
	5hcUHmFg99FDYWNE3+aTSdObISP6Ct4EBcj8xOQRf10b8MtoGO7DGQHFe3oVuYlUhMPUGtW7YRD
	N5OFV9NfEdE/McsBfxJ6VD3sFafItYTT8QC9hysEcsjQ2HwZuxijiJQm0DW8baEZ98OPAH6udIb
	8bLyjm7bvbEDlmG1rsSyz6CZMxmfxIRzM9F/dzKJJ1tb5f/25SDcRC6hR0/yStINM4gnwHMEq22
	52GCBX9xD2lMvhcirqXjLOu7Sx5ZU+wAriTl0DigBMw==
X-Received: by 2002:a17:907:948a:b0:bf4:1188:f288 with SMTP id a640c23a62f3a-c05a274143amr279681266b.17.1781701396300;
        Wed, 17 Jun 2026 06:03:16 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-bfdb5ce72f3sm114038066b.51.2026.06.17.06.03.16;
        Wed, 17 Jun 2026 06:03:16 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 1DFDC179D5;
	Wed, 17 Jun 2026 15:03:16 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	jonas.gorski@gmail.com,
	horms@kernel.org,
	stephen@networkplumber.org,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH iproute2-next v4] ip/bond: add lacp_strict support
Date: Wed, 17 Jun 2026 15:03:14 +0200
Message-Id: <20260617130314.3893243-1-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300176-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,networkplumber.org,6wind.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:jv@jvosburgh.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:stephen@networkplumber.org,m:louis.scalbert@6wind.com,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42C9C699F18

lacp_strict defines the behavior of a LACP bonding interface
when no slaves are in Collecting_Distributing state while at least
'min_links' slaves have carrier.

In the default (off) mode, the bonding master remains up and a
single slave is selected for TX/RX, while traffic received on other
slaves is dropped. This preserves the existing behavior.

In lacp_strict mode, the bonding master reports carrier down in this
situation.

Link: https://lore.kernel.org/netdev/20260603150331.1919611-1-louis.scalbert@6wind.com/
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 include/uapi/linux/if_link.h |  1 +
 ip/iplink_bond.c             | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 70aee114..d3a21fba 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1601,6 +1601,7 @@ enum {
 	IFLA_BOND_NS_IP6_TARGET,
 	IFLA_BOND_COUPLED_CONTROL,
 	IFLA_BOND_BROADCAST_NEIGH,
+	IFLA_BOND_LACP_STRICT,
 	__IFLA_BOND_MAX,
 };
 
diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 714fe7bd..d2d822cd 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -87,6 +87,12 @@ static const char *lacp_rate_tbl[] = {
 	NULL,
 };
 
+static const char *lacp_strict_tbl[] = {
+	"off",
+	"on",
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
+		"                [ lacp_strict LACP_STRICT ]\n"
 		"                [ arp_missed_max MISSED_MAX ]\n"
 		"\n"
 		"BONDMODE := balance-rr|active-backup|balance-xor|broadcast|802.3ad|balance-tlb|balance-alb\n"
@@ -168,6 +175,7 @@ static void print_explain(FILE *f)
 		"AD_SELECT := stable|bandwidth|count\n"
 		"COUPLED_CONTROL := off|on\n"
 		"BROADCAST_NEIGHBOR := off|on\n"
+		"LACP_STRICT := off|on\n"
 	);
 }
 
@@ -188,6 +196,7 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 	__u32 packets_per_slave;
 	__u8 missed_max;
 	__u8 broadcast_neighbor;
+	__u8 lacp_strict;
 	unsigned int ifindex;
 	int ret;
 
@@ -417,6 +426,13 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 				return -1;
 			addattr_l(n, 1024, IFLA_BOND_AD_ACTOR_SYSTEM,
 				  abuf, len);
+		} else if (matches(*argv, "lacp_strict") == 0) {
+			NEXT_ARG();
+			if (get_index(lacp_strict_tbl, *argv) < 0)
+				invarg("invalid lacp_strict", *argv);
+
+			lacp_strict = get_index(lacp_strict_tbl, *argv);
+			addattr8(n, 1024, IFLA_BOND_LACP_STRICT, lacp_strict);
 		} else if (matches(*argv, "tlb_dynamic_lb") == 0) {
 			NEXT_ARG();
 			if (get_u8(&tlb_dynamic_lb, *argv, 0)) {
@@ -642,6 +658,15 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "all_slaves_active %u ",
 			   rta_getattr_u8(tb[IFLA_BOND_ALL_SLAVES_ACTIVE]));
 
+	if (tb[IFLA_BOND_LACP_STRICT]) {
+		__u8 lacp_strict = rta_getattr_u8(tb[IFLA_BOND_LACP_STRICT]);
+		print_string(PRINT_FP,
+			     "lacp_strict",
+			     "lacp_strict %s ",
+			     get_name(lacp_strict_tbl, lacp_strict));
+		print_bool(PRINT_JSON, "lacp_strict", NULL, lacp_strict);
+	}
+
 	if (tb[IFLA_BOND_MIN_LINKS])
 		print_uint(PRINT_ANY,
 			   "min_links",
-- 
2.39.2


