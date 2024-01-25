Return-Path: <netdev+bounces-66036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD01483D068
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 00:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6361C23221
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 23:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A712B9B;
	Thu, 25 Jan 2024 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IBcq/bD+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657F79D9
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224315; cv=none; b=MWOBjh4m1TYpGwQtfuI+pfCpOIqfcGVxxW3/zBf8Q6s9Xy6awIxOvTmZLz1oXosXfPx/K62B/+5OUghZKpuzCUW7Ib705TiCLzWNjMU5Zzgaxn+KyezvnGzSe9jVkAwohgxWXfNgCJKgY2I8acDpR/m13abtG/7hDIyWMk1d/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224315; c=relaxed/simple;
	bh=ywdmNDFmmWTvMaTS50URRjQBtyO1h6ITYkb02UigJCs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=twiYKILLRopc629gkGeYeNNQ7uUACx1WDOZ3XjHH9CnrIkPtNfuMgf0MKFfJfe1HTVPQsKXaVATOajOpe6xabr6S0yEdCS/wncFKM1odSgSUazQBcR9Kf8WNyHBkUpT81PnZbsFz7d5CxdZzYnW0RU7Nhia1nFsSw01o5d2k//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IBcq/bD+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc221ed88d9so9693933276.3
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 15:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706224312; x=1706829112; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=errAaYmV/b3qzBtLburPqntFItPSjeNH4tQPLoTwL2Q=;
        b=IBcq/bD+N49CFQk2c1x5aQe6hqSlkWQEOC1q54VWsuZtWsnFswjS1GsJhl/Keyhpga
         T+swgHkcUeYw+i/Lkm6pkJ8zZ5ne+zoC1NlPnk2oGt9akP8pkD5Nk/tkIpYSPzwoalQF
         KyIPnkJuRAjVw487zfCLzjI4jQpIN+F4pypc8Pbz07IwGONBRbd8C0Lj0aVbC1ZzJ2BW
         qzl91FIkRVb8FiFqx5Xe2LtasgcEZo9fq7rGam1UjoQoamzHalSxxiIfiJsOtp6WCJcs
         JmOE0VarXTHCd9MjUNVS+ssZDljXc+U2eEbbQHwSWV7cGSFLDCmoC5BOhjj9+1wVc4En
         TeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706224312; x=1706829112;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=errAaYmV/b3qzBtLburPqntFItPSjeNH4tQPLoTwL2Q=;
        b=GR5Qi6WIXlfGtB4KOuoSqCaJ7tMW+RDHb7WoHdUDaco1ydjpAUXNrQBuFOdyGSHSsC
         61BMg4JdF/wwCzQzCu30c6G6WnFdyCzZI3gD2ocvf+5wrXl10xeIexzyJLJvbquKpfNx
         B0kvdvAvmO3S4WYFi+R43w+LWzLUhZUUn28cXM/pgXzOXipQQ1Kt0wK1O7MJTPvs7gkt
         b1mG2ksmBTcw0gIBnvYbpUMTSevAfCqX3m5J6oq2SWQi/SLjlVaieeZws+D3vCh1k0su
         KRR2HWb4vDi0GnZMTrerSjclUL/mcRa3GlRk3dZvmqrGNeoKylFo7LW67eeydTokhwbx
         WD3w==
X-Gm-Message-State: AOJu0YystZhK7TJwdovs100CYMarAjuhaPkOdHD+h959u7Jn8KN1wFkG
	dzYUTU/VtTBDGymqSvxeTR25hz8uxUwA8cc0B3h7b3TTFPwNOOqs7qOWpNFuGklHsdpr3t4C34x
	icg==
X-Google-Smtp-Source: AGHT+IH14PTJzp/+jF4j0uadI/hs/tOufCmRj2j9SaIDRDPZ42NjzzJCrCMfQc885hkt+NVvKO9c+dITLtc=
X-Received: from aahila.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2f3])
 (user=aahila job=sendgmr) by 2002:a05:6902:2783:b0:dc2:3cf3:5471 with SMTP id
 eb3-20020a056902278300b00dc23cf35471mr86128ybb.6.1706224312646; Thu, 25 Jan
 2024 15:11:52 -0800 (PST)
Date: Thu, 25 Jan 2024 23:11:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125231148.416193-1-aahila@google.com>
Subject: [PATCH iproute2-next] ip/bond: add coupled_control support
From: Aahil Awatramani <aahila@google.com>
To: Aahil Awatramani <aahila@google.com>, Mahesh Bandewar <maheshb@google.com>, 
	David Dillow <dillow@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	David Ahern <dsahern@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

coupled_control specifies whether the LACP state machine's MUX in the
802.3ad mode should have separate Collecting and Distributing states per
IEEE 802.1AX-2008 5.4.15 for coupled and independent control state.

By default this setting is on and does not separate the Collecting and
Distributing states, maintaining the bond in coupled control. If set off,
will toggle independent control state machine which will seperate
Collecting and Distributing states.

Signed-off-by: Aahil Awatramani <aahila@google.com>

v2:
  Dropped uapi header change
  Use of print_on_off and parse_on_off

---
 ip/iplink_bond.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 214244da..19af67d0 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -148,6 +148,7 @@ static void print_explain(FILE *f)
 		"                [ tlb_dynamic_lb TLB_DYNAMIC_LB ]\n"
 		"                [ lacp_rate LACP_RATE ]\n"
 		"                [ lacp_active LACP_ACTIVE]\n"
+		"                [ coupled_control COUPLED_CONTROL ]\n"
 		"                [ ad_select AD_SELECT ]\n"
 		"                [ ad_user_port_key PORTKEY ]\n"
 		"                [ ad_actor_sys_prio SYSPRIO ]\n"
@@ -163,6 +164,7 @@ static void print_explain(FILE *f)
 		"LACP_ACTIVE := off|on\n"
 		"LACP_RATE := slow|fast\n"
 		"AD_SELECT := stable|bandwidth|count\n"
+		"COUPLED_CONTROL := off|on\n"
 	);
 }
 
@@ -176,13 +178,14 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 {
 	__u8 mode, use_carrier, primary_reselect, fail_over_mac;
 	__u8 xmit_hash_policy, num_peer_notif, all_slaves_active;
-	__u8 lacp_active, lacp_rate, ad_select, tlb_dynamic_lb;
+	__u8 lacp_active, lacp_rate, ad_select, tlb_dynamic_lb, coupled_control;
 	__u16 ad_user_port_key, ad_actor_sys_prio;
 	__u32 miimon, updelay, downdelay, peer_notify_delay, arp_interval, arp_validate;
 	__u32 arp_all_targets, resend_igmp, min_links, lp_interval;
 	__u32 packets_per_slave;
 	__u8 missed_max;
 	unsigned int ifindex;
+	int ret;
 
 	while (argc > 0) {
 		if (matches(*argv, "mode") == 0) {
@@ -367,6 +370,12 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 
 			lacp_active = get_index(lacp_active_tbl, *argv);
 			addattr8(n, 1024, IFLA_BOND_AD_LACP_ACTIVE, lacp_active);
+		} else if (strcmp(*argv, "coupled_control") == 0) {
+			NEXT_ARG();
+			coupled_control = parse_on_off("coupled_control", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr8(n, 1024, IFLA_BOND_COUPLED_CONTROL, coupled_control);
 		} else if (matches(*argv, "ad_select") == 0) {
 			NEXT_ARG();
 			if (get_index(ad_select_tbl, *argv) < 0)
@@ -659,6 +668,13 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			     lacp_rate);
 	}
 
+	if (tb[IFLA_BOND_COUPLED_CONTROL]) {
+		print_on_off(PRINT_ANY,
+			     "coupled_control",
+			     "coupled_control %s ",
+			     rta_getattr_u8(tb[IFLA_BOND_COUPLED_CONTROL]));
+	}
+
 	if (tb[IFLA_BOND_AD_SELECT]) {
 		const char *ad_select = get_name(ad_select_tbl,
 						 rta_getattr_u8(tb[IFLA_BOND_AD_SELECT]));
-- 
2.43.0.429.g432eaa2c6b-goog


