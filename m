Return-Path: <netdev+bounces-301947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D+SOJvIUPWoIwwgAu9opvQ
	(envelope-from <netdev+bounces-301947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:45:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2E56C53DF
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:45:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=Vr1P80KJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301947-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301947-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74F6B3045C25
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1BB3DC4DC;
	Thu, 25 Jun 2026 11:42:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f228.google.com (mail-lj1-f228.google.com [209.85.208.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A989C3DC4B9
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 11:42:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387742; cv=none; b=nUlIdn2mBwcvj+re4rTU48hTpmW2EH/OsG8we+ATd1OB6KaWCLAqBgPG8oQeNjDP3LzyhcgIQZGiv9DTBY99aap6N4C5vO3JcibaX+tdfFoKgHEHlpyhrrIoQNldvPsGYTcn4QOLmlxz8R/T20FQLrYQsZ+rvFFXx74TaqA2+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387742; c=relaxed/simple;
	bh=FUzVITK/BjvOAOI59NXhPmdX5PZ0j08kBriBhhvCmLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LraOl0J/lXqvWwYvhIC+kzhlIEa4yjCco0616sJvXHypW0Uyp2BjsAhcaW7UM2dm+K3oRQCvZcIRDiO4i5oDGJDuv8tmSyBZ4mmKCizrZs2PIe6DZOfoqodK6sFjkhMsW1P/gxLrk6fjbNuuP6iV/OChlO24EoXxz4BJYP0mrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Vr1P80KJ; arc=none smtp.client-ip=209.85.208.228
Received: by mail-lj1-f228.google.com with SMTP id 38308e7fff4ca-3997a448ecbso21588851fa.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 04:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1782387738; x=1782992538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIL76MiyPf2fJRdYDFHzC2Jb98hJ7+aQ1jeJ+4iDHC0=;
        b=Vr1P80KJ9eZxuHiB1L3dfBnSm9etSEj+urpZng2x6bl1ZJPqUwELhXCfpST/IO/uGP
         thTwOeKbHi3RwyL9DnUGFffcQrqX0Vg5RORTkGAjaqbd+R4KfjjGKpgiQaHzN4fEEjZF
         BiDTi1aelRWgtrVj+tBmEBNxgb4Z/+vpMERx0nOn6dtF44WAcsjXRQ4rT0TJxfYzO5u6
         YZRedWK3HxGRo72b4rVsOZLRd+VOZlNUivUllJzFpwFco+EQIA705OOWYXopKIm9ezUS
         jWqa6SGbyS21Fs7R+5y4f1pmfOPYoX2VzDVi9dd0yEyjUwqWxTKJpNKLxkOvPU/dHnLa
         QzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782387738; x=1782992538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIL76MiyPf2fJRdYDFHzC2Jb98hJ7+aQ1jeJ+4iDHC0=;
        b=p03siIATr2ZV6rFYx/G4M7BjOgwRKPcRE7chC/1cGkmhC+r6+NxorcJuIzlhcgcSBe
         RrdXi7CR3hd1OMHpWWGcKaTogzLQVerSHoeNVJ+ZBhlsQuC2Bc1BiuPw+LlL3T6O+Jyp
         foj1DHf93JMZLlH5M0PUWHPl1gCZ27E197JUsFTsSN1DNFoYUCw9LMphxbHwZLhx8ZFG
         3t5SLJxdmk94dzltJ25S8qqSCrY4PvPDbR+xmO87SGhscykTAG9vgLVsN8vyvt5NrJcz
         q/cD3Qtn1cAnsEMIDsj1LkGNqnXTlP2VbNF1060g+4Qut8rgY+xPaq1a+nzMljPKnfxt
         iodA==
X-Gm-Message-State: AOJu0YyuRe3WTHBTUKYtHRlrmJbGwt/bBySMkRshif4+x1cWSMMxWa+X
	AXxWdknjFKwJCoxGKdpwX/RVGVwJKR7lN22PnURqOlvJPl0xD6womV1cURrsqwjBJ6y/dYgEhWx
	/FDpAvZRAJrwry02EVE2PmPcuVBWc9BXF16+7
X-Gm-Gg: AfdE7cnLuqqht1vcBPKyMOLPrcji6i3i5phojQAjlwBFAOF3Y/xLPy/mrXwp62MRBBA
	Rzdn4cv4dghvXhc37nnCligkTm0/NTh+bsvQRJrOLcPix4dSDtUe/f5YpzRHn0WXDgUxPY6445O
	sy33nmtV324RSYtlDBiWxdL1Ppzbg/EggIV/btkXgnT3zt0mhTaFkb9sbjs1v7KxEzPjIK09mtF
	jlt5DaS6h69HcWX4V3JzdH+r7QGtHT28zMAS1+RhIAMqrtYmTxJZFvhFmrpsNulUvEsIFY9FPVX
	bVaZOot7tM+465NP8AmDavffxe/k+2gKsk3adrAKSw1sIyjP6ctYsKo9PX4IN6EXKk+EfYSOD72
	Iqp3FpyEMzeqnXCJUqGdgUxd7MYIK4jlNBLULBhsKcw==
X-Received: by 2002:a05:6512:b9e:b0:5aa:8562:2a7c with SMTP id 2adb3069b0e04-5aea1f5f77bmr767871e87.31.1782387737558;
        Thu, 25 Jun 2026 04:42:17 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-39ad5c13aecsm10501fa.22.2026.06.25.04.42.17;
        Thu, 25 Jun 2026 04:42:17 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 2561819B06;
	Thu, 25 Jun 2026 13:42:17 +0200 (CEST)
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
Subject: [PATCH iproute2-next v5] ip/bond: add lacp_strict support
Date: Thu, 25 Jun 2026 13:42:16 +0200
Message-Id: <20260625114216.2507435-1-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301947-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C2E56C53DF

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
 ip/iplink_bond.c             | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index 714fe7bd..7e2e397a 100644
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
+			lacp_strict = parse_on_off("lacp_strict", *argv, &ret);
+			if (ret)
+				return ret;
+			lacp_strict = get_index(lacp_strict_tbl, *argv);
+			addattr8(n, 1024, IFLA_BOND_LACP_STRICT, lacp_strict);
 		} else if (matches(*argv, "tlb_dynamic_lb") == 0) {
 			NEXT_ARG();
 			if (get_u8(&tlb_dynamic_lb, *argv, 0)) {
@@ -642,6 +658,10 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "all_slaves_active %u ",
 			   rta_getattr_u8(tb[IFLA_BOND_ALL_SLAVES_ACTIVE]));
 
+	if (tb[IFLA_BOND_LACP_STRICT])
+		print_on_off(PRINT_ANY, "lacp_strict", "lacp_strict %s ",
+			     rta_getattr_u8(tb[IFLA_BOND_LACP_STRICT]));
+
 	if (tb[IFLA_BOND_MIN_LINKS])
 		print_uint(PRINT_ANY,
 			   "min_links",
-- 
2.39.2


