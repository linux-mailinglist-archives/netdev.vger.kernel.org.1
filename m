Return-Path: <netdev+bounces-279327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGYGFUU/4mmB3wAAu9opvQ
	(envelope-from <netdev+bounces-279327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:10:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 837CA41BE3E
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF9C930469A0
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E18B27E1DC;
	Fri, 17 Apr 2026 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="VwbfYp2P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f97.google.com (mail-wr1-f97.google.com [209.85.221.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1779A22CBE6
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434869; cv=none; b=hEyO4MTs6fHBAdPcQlsv4x+Kd8eifkHqObPtPWOL7kMi5mBkj84UGYZoPwJVY6Y6NJ3szKKOIk0dywVJUgIwkeSS54ZsTYBIRxM2k7NQ3cXYdpzb5f8tqw0s2bFBnFgsLlK0aLGQfB0vvgmCwwYBHrKTl5ulsCQcEZRJTsuTLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434869; c=relaxed/simple;
	bh=3vQJdcHfusmEwZFYonB6GQJ2LSIInNi3PNld/dWvuNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cgs3mkGd806oXf/JOjQ0372xhUGmvgiq2jbQZtvzFK0muNBl9U141SywrjR/MksS3zSvVtwWHQwbxZZFGny6l0kf9ecBln8aeNsuSFFUtyjMsobOxcaqymccVuTHsBTOkSkC3KV3/gdrSzunaISQwuclJtfGRTyDG0cfKsLpfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=VwbfYp2P; arc=none smtp.client-ip=209.85.221.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f97.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso702496f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1776434866; x=1777039666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5MH/1iHqV8r8YEtFLFSgeqxDRAgy9f8KKojlnNFJyI=;
        b=VwbfYp2PfOPxaa4jFNKDEshFYVUF/R3zrsloh8J9bgPFoA8RWKYuUPlw+9ilehsTYU
         6vSzUr1KdEY6rOhlkF7kBFG9Xx56rLvhNG1EWzlTKLzYNr3nyRR79YctfrLg6UFh/eHX
         DZ9z+bLpXp2ipNXIs5I5kDO6UFJdUsO0mRQB14w5yWbFOwLfDgEuQ8sT1ZLQHcUd33OI
         vCmWRzWpIkGZFQAdpLfO5yPtYV2KbKkzVFNzrgGCsisFUa2HSqPeye2NA1qqNClHx/nN
         4uAYRxbMgdaT/A1zn4HzMaDnnEYHJF6lQCobfEihjiJ7DKWS6Dvtl5vSi4XfCpzCFV6e
         3jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776434866; x=1777039666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5MH/1iHqV8r8YEtFLFSgeqxDRAgy9f8KKojlnNFJyI=;
        b=U4AYdU+/xz84vAzi3jlaFBUg2RkXJd9Ppib/Cnu9N/3C6nIGr89PlabIy9A2Y0bM72
         9AAhApaqLUrx/wM7leMkEyAimC+i+Aj72IAnpUqGYDfeMU41KNRshS+y/3f4qRHl7J7a
         KY9HRnh/NNVkOy76ngLVREmYnO0QgXGz8JhFq7yytzonGsuHhAlCs22KKbB/BAQvoZYs
         kpbBKIEIebIMRwoUMGB49ocYkCG5H3BVANjmnyDOJGIQ/qfBS/ZCzOEpHGjvStQt5yyQ
         pOzTlurMLskV+1OBTW7bjpPQv9D8SZAsTIczDBnQZJqU7k36Lz+PyYrKCSGari7funiV
         utKw==
X-Gm-Message-State: AOJu0YzqhqTqg91KUUaVFdVq32SKMAmoZg7tDhUIusGZAahXsdF8a/65
	EbekfiklSZtfuog8ECOgBxrtwv7tR+qNaSjhN/d9z6yTKrj+UlgEix/eexURb5No+xc1PuWE2/a
	mUL07bTz/il7Rqehqpg0QBxZFCUtFWqEiBSCm
X-Gm-Gg: AeBDiesqXU2RB9Mv5XFepwCX+PApMo2/TgpERdd2eRg9r2CjfSepAa74Kld2Yvq/D+D
	2ymivuSiCxNvy4M75w8F75EjKcLgUgdNtkmqDmDi5mMw/2znd3Q37SkCoemapKry/AONKNAES6T
	VRl/qZgOJqUfvWjijxes3Z1sIXQaajN4hfP5w5KFlROuja9pkceD643MwsAb/RAHdT6n+2PKjSd
	6N3OnGrlNyiNFONewKbCP+Cg6bN/vKoKhmj9n88KaqWBnvYK22/PPaxC1A2Sol7/mWw7SF4P1HI
	XV8odkOSVx+PCKRa9exRj6sJpFIjUupvXxLH2fZxX37YHyu0T8IaN1sfeqdlaOr+oTTBG3VaUpW
	UaQWCV0FHUkdHJBFFWa9JMkdYYUVgJYfO37dlCO0izoKB2mCLdEhAYRL46HrcKzE=
X-Received: by 2002:a05:6000:4201:b0:43f:e7fa:a6f1 with SMTP id ffacd0b85a97d-43fe7faa7admr2131754f8f.24.1776434866424;
        Fri, 17 Apr 2026 07:07:46 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-43fe4e26294sm112610f8f.19.2026.04.17.07.07.46;
        Fri, 17 Apr 2026 07:07:46 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 4B39B13655;
	Fri, 17 Apr 2026 16:07:46 +0200 (CEST)
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
Subject: [RFC PATCH iproute2 v2] ip/bond: add lacp_strict support
Date: Fri, 17 Apr 2026 16:07:45 +0200
Message-Id: <20260417140745.3861041-1-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279327-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:email,6wind.com:dkim,6wind.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 837CA41BE3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

lacp_strict defines the behavior of a LACP bonding interface
when no slaves are in Collecting_Distributing state while at least
'min_links' slaves have carrier.

In the default (off) mode, the bonding master remains up and a
single slave is selected for TX/RX, while traffic received on other
slaves is dropped. This preserves the existing behavior.

In lacp_strict mode, the bonding master reports carrier down in this
situation.

Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 include/uapi/linux/if_link.h |  1 +
 ip/iplink_bond.c             | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 2037afbc..fadcb57b 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1537,6 +1537,7 @@ enum {
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


