Return-Path: <netdev+bounces-209666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3596EB10372
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BA01CE3D17
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8268E1FF1AD;
	Thu, 24 Jul 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYjhzIiy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F22749CD
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345338; cv=none; b=YxrZseeQ8TLGiRdzZ/fTvfz7Kpl1V9uh7vru+DmiBhjZdtLF2YPnJNhqi1N9P0oUKQIxQrUrqk3hiqxKZofKdyS4L2w6aUYf9FHQn/ZTIw7e/xqjofpcTWrHsHbx9fPQefE7uIz9hEMkqLiREC9+meA//UzQ1S/Hhmlmo4un5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345338; c=relaxed/simple;
	bh=e8tzGHbqbegSRA5Fz038Nl0iW7nMJkEXaBB3S/5pMRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TM1QYu+TWkNFYxYu7i6aPHZq6yFqp4n1nVxYkxexPvvgDjvPeqqKsCzdB60oeoWXD75pb+OW32rkxUkEk2YMUSdxtamOPn5sSFUB688fXrlF33DHq8nPL+Q2foQys9fnUdl6PNSMUsStgCr06j4BT29zReSLCG1IQyQoP+T/2rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYjhzIiy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso711486a91.3
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753345336; x=1753950136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMdJTwJ5ROAiejid3oRRiuxrTFi9ZZNPzrx97k3uXrs=;
        b=PYjhzIiyII7cuAWBRxBeIzNBRufpRBvATcnR7ev6ANwibKvk10or+tUv2gT21+3xjY
         vAsZmDrB16gsn+5xb2k0SkkEegtefPK8w0AGB4TKQIwPQr0zHrCPGAjB17iRzLqK0jqZ
         eKX1JverTgBBH3CUYTiY//cr7lopGRuuQaSuSQ3Gk6GjlCLj3TWzMD+4RfPDwhOGcwBu
         7FHy2jkd7z7norL3UyP/JbIeS5bb1yilcmbwtTErQ1Gv25k661tZl8brduPQtERq2mPO
         LbgJTv8/wSyi+Wa5BGRek339P4AQPn7GMjI3rO+2t+/uD+CDlszEBlmzkGL5AYw8fSZN
         ciUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345336; x=1753950136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMdJTwJ5ROAiejid3oRRiuxrTFi9ZZNPzrx97k3uXrs=;
        b=qWogYVFwwo3hXhqXDlywar3zmkTkrh75skW7FjkcfLjYXBH5Sz2hk29zBUA0TGK9Ik
         qxBaJ+ih0Slpxglg+NC1tbhPk2WzGXtD5i07uQmv7op4QrJvq1gl+q849aWUXlS1P2M/
         G3ayKVcFBASDZShjPno/nrupz9LJtNIoQXd7RUVZbuMcMoqbBCJEs/ccsgz25OKyaWKe
         KpRdWE2HEAyWIO4kB/28nX+71J3EBVN7E2/rDyuSEh+IsFVPCM55mAlkWNjo3Yxyqn1y
         2E1aCOymBeP3b3Uch1eIwpwOYEpnm52w+dXG8qA6yo6cGW5qeQwz+sCmMVvUGf6KaS0P
         FyRQ==
X-Gm-Message-State: AOJu0YxXx+GNZnIN0fTKtpXRM49M090R7B2ayCCBcK6g5ql2U30po/d8
	FE3AyBDdMoFXHmGBvqsa0e/QFUV1fi8U7+jbch+FaniIZ5DZoR5JOHbAk3BxmSRO
X-Gm-Gg: ASbGncsk3BATbBcj+/u+p4NMOQCBSJTRsKc5EdDTeVCuQjNx5l5z58jxmTd3XNVcRkj
	TmhYKmzieVxXw19/DNTHj2y3B/tn17kkFJgj/lbHbDdh+HHCl/ADOxH9ndZ4qzkzf5j1fQSxptU
	svkBE02xi7jSu3uF/eeANjEAUUayk4dCtQhi3v3VXJMbThaIbXXaEaetFlc/663szfqNTsydwx3
	kwmGt0ycEQ/K4ZLDdk5TAXtg56DfinzbB2bJNXI6LxVwkAByeqM2PgQkSflT4sH+hDEOfvd8ULz
	OwBnbwVum51NNZWl7p+cGRygxTMrqeqjdRTCXD1B4SlJj2/NFwqPGOJdccMxLgvtQWX15bBWIGm
	XY8Pg4e/XleRbNjwlXMpsuVM193OQ3pjgB3xtIlclYBJrijw=
X-Google-Smtp-Source: AGHT+IHlgyAMT21mEzyOJXo8/bbOtfMlWMfTQ4Rz3LDSE05DP1q0EQ/DRhAkx4VW/QxlZ+hGA0DqwQ==
X-Received: by 2002:a17:90b:4985:b0:31c:9dc1:c700 with SMTP id 98e67ed59e1d1-31e507dc7a7mr8373413a91.26.1753345335975;
        Thu, 24 Jul 2025 01:22:15 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e662fcc18sm792054a91.39.2025.07.24.01.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:22:15 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH iproute2-next] iplink: bond_slave: add support for ad_actor_port_prio
Date: Thu, 24 Jul 2025 08:21:57 +0000
Message-ID: <20250724082157.13233-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the ad_actor_port_prio option for bond slaves.
This per-port priority can be used by the bonding driver in ad_select to
choose the higher-priority aggregator during failover.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 ip/iplink_bond.c       |  1 +
 ip/iplink_bond_slave.c | 18 ++++++++++++++++--
 man/man8/ip-link.8.in  |  6 ++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index d6960f6d9b03..1a2c1b3042a0 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -91,6 +91,7 @@ static const char *ad_select_tbl[] = {
 	"stable",
 	"bandwidth",
 	"count",
+	"prio",
 	NULL,
 };
 
diff --git a/ip/iplink_bond_slave.c b/ip/iplink_bond_slave.c
index ad6875006950..67b154e194f7 100644
--- a/ip/iplink_bond_slave.c
+++ b/ip/iplink_bond_slave.c
@@ -15,7 +15,9 @@
 
 static void print_explain(FILE *f)
 {
-	fprintf(f, "Usage: ... bond_slave [ queue_id ID ] [ prio PRIORITY ]\n");
+	fprintf(f, "Usage: ... bond_slave [ queue_id ID ] [ prio PRIORITY ]\n"
+		   "                      [ ad_actor_port_prio PRIORITY ]\n"
+	);
 }
 
 static void explain(void)
@@ -145,12 +147,18 @@ static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *t
 			  state);
 		print_slave_oper_state(f, "ad_partner_oper_port_state_str", state);
 	}
+
+	if (tb[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO])
+		print_int(PRINT_ANY,
+			  "ad_actor_port_prio",
+			  "ad_actor_port_prio %d ",
+			  rta_getattr_u16(tb[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO]));
 }
 
 static int bond_slave_parse_opt(struct link_util *lu, int argc, char **argv,
 				struct nlmsghdr *n)
 {
-	__u16 queue_id;
+	__u16 queue_id, ad_actor_port_prio;
 	int prio;
 
 	while (argc > 0) {
@@ -164,6 +172,12 @@ static int bond_slave_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (get_s32(&prio, *argv, 0))
 				invarg("prio is invalid", *argv);
 			addattr32(n, 1024, IFLA_BOND_SLAVE_PRIO, prio);
+		} else if (strcmp(*argv, "ad_actor_port_prio") == 0) {
+			NEXT_ARG();
+			if (get_u16(&ad_actor_port_prio, *argv, 0))
+				invarg("actor prio is invalid", *argv);
+			addattr16(n, 1024, IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO,
+				  ad_actor_port_prio);
 		} else {
 			if (matches(*argv, "help") != 0)
 				fprintf(stderr,
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index e3297c577152..5714dbecabcf 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2846,6 +2846,12 @@ the following additional arguments are supported:
 (a 32bit signed value). This option only valid for active-backup(1),
 balance-tlb (5) and balance-alb (6) mode.
 
+.sp
+.BI ad_actor_port_prio " PRIORITY"
+- set the slave's ad actor port priority for 802.3ad aggregation selection
+logic during failover (a 16bit unsigned value). This option only valid for
+802.3ad (4) mode.
+
 .in -8
 
 .TP
-- 
2.46.0


