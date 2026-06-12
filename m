Return-Path: <netdev+bounces-298699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j57YD+AYLGpkLQQAu9opvQ
	(envelope-from <netdev+bounces-298699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:34:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 489C867A37D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:34:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=StBrhwhT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298699-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298699-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4725D301C9E4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F713644DE;
	Fri, 12 Jun 2026 14:31:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD02C11E4
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:31:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274699; cv=none; b=JEieW6ZiBtCf62NqEyf0yIySXacVMpHNlUMKQ3xZ/tnAIIPK4LNNKYcxScKpN9kNZ08hN1MSeJADIFgy3zLYT9uZTMo7YmKYMW+lcJoCfnGzd4vgg3q4kOHjF7Bq+n9i7VBbE8RmM9awDEIlv7iVV1ICryGLKYZt6QTjKr7bVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274699; c=relaxed/simple;
	bh=rIJKM5/053AiDmXa/XWUOJMXc6/st/Ne0BkaH2g+rLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t1GS5LfiH8j+X5no7uWCSHUCKPU37Og2PWWzGFVMj7lemCfa9WB+oK9uYmp9hwIVssz5GpVBvHpKDWEIquVEvR3m4o3Oz08EdBcxecKEKZG4ewB7taLi5WPlhvzy1z2+kXAi3kAabI8P4/4uFpScBkE25Zs+8KtdfxkWH9odEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=StBrhwhT; arc=none smtp.client-ip=209.85.167.97
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-5aa6792e7b8so926061e87.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781274696; x=1781879496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y5ffxV3jOcRBWKCOHImdnd26+zc70BGw17ekei8AkzU=;
        b=StBrhwhTz3Jbm2nbcTExWLt6w4dcF9rZE0k39wSUE/K22fOtB1YuRtus6+9Tl0oU5K
         tp7XQGcFbmpInTbYBIM7bqchPYu3SiBr7c0bl1TrkqIKULxsQ5epUnHH1UktMtzJMgMr
         svJ9KBZr9iI5gxbZrxM/P1TVTX5UJNWcniyX/J3r7e88/89J+4JqjR9AzjpGGpPD60dW
         6Flc1mujHB5c3IKD5LOk7ulFuLRK2QXBpfUcEd5oDuWtZ0JOLqv1YuC+DlBEloRnwHwG
         xPd90jxJxkh/aGEfiXa6wOuUFDe6dQVn/UNfh9OHmFsndr2m5hkVnG86CAaAVvnCQ3KZ
         PWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274696; x=1781879496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5ffxV3jOcRBWKCOHImdnd26+zc70BGw17ekei8AkzU=;
        b=sw20wVStOdjMI5fij7zUh5cYr8P9kmZZ7sfoJ/9ZBTGMoK1utM9e2epcTm+zZplwHV
         L7N4FUQ1/DshFzLS2jLK4mGWDKigMmq64EeNj5wgBvNnMldrCjbUqZhH7spiIMRaGzRa
         aBs/8jI1A8zdsh4JJyVqGyYNUXDZxwTnrNd6XRJ1uYuYCpfVKA4JrqN/n5beKM5kAsEy
         28AN56ckQ2wHSfqrG1dZsqKWTJL2PVagxrVSlLwBLaOb8ny/4VoX0+D9y2Mk81av/AjD
         SP9tRJrUC/SU9NSRmIyprBe8GT7aCZEw9UG3+pozla4pno0G37PZluMfVsGat8i/1EXz
         2fzQ==
X-Gm-Message-State: AOJu0Yy1VHmjIW77CdHUxEzqMHolFTBAg3VTWwmnMujt2U0npyM0ORzX
	EzGMwvARzn+qW8AII1Oj4/o7/FNfIUqKFWznIafIX3yDRNhAPCZ5W8rnnRhphsRyO5ColUNFC7+
	bIqu0O9NuzF7G+Yr7efiJKfjUGqArVcqFqJTY
X-Gm-Gg: Acq92OEh1kdBOJwboACIi+mxjZlUSUV4B6LVcjTqJVGu44d8ZSc2onh+HwbgDC4ZaUY
	NFQbP2qyootp6M4y2+m59Rc6ZBVSnlN3UUXOdb1GubXt0a2hu6w/P526lXsYwqeVg5BJttdt6dE
	Lg08PglQlxX6fan2BQLvwjQcHWEUJi2ngFVLNEUmudCZFGPlOH4vPyXIja4/1rxcCW/DAc5i51H
	3d5c67dCD5gladcSEKkC/kiRAPFzrBwAwBjGh8kYDq4dnxywVti7aOkeL3oWfoDh7SMZ3UlKMz3
	mIGhre82KISDbvkx7FoLTH5Gt/Wah0oOa0qe6sVk/Y2CBddMcDAZ7o9jpd6SGMRA12qIeeWOzX1
	71qH5r/sHzxL9T5q5RCqfsjwsEOr3QkzBqdOT63plolVAWfQLfg8c
X-Received: by 2002:ac2:42cf:0:b0:5aa:6ede:51 with SMTP id 2adb3069b0e04-5ad2db5d98dmr692059e87.27.1781274695787;
        Fri, 12 Jun 2026 07:31:35 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5ad2e1ab667sm167942e87.49.2026.06.12.07.31.35;
        Fri, 12 Jun 2026 07:31:35 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 4EA1016A4F;
	Fri, 12 Jun 2026 16:31:35 +0200 (CEST)
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
Subject: [PATCH iproute2-next v3] ip/bond: add lacp_strict support
Date: Fri, 12 Jun 2026 16:31:33 +0200
Message-Id: <20260612143133.1638767-1-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298699-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 489C867A37D

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
index 714fe7bd..7ee29175 100644
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
+		const char *lacp_strict = get_name(lacp_strict_tbl,
+						 rta_getattr_u8(tb[IFLA_BOND_LACP_STRICT]));
+		print_string(PRINT_ANY,
+			     "lacp_strict",
+			     "lacp_strict %s ",
+			     lacp_strict);
+	}
+
 	if (tb[IFLA_BOND_MIN_LINKS])
 		print_uint(PRINT_ANY,
 			   "min_links",
-- 
2.39.2


