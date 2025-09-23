Return-Path: <netdev+bounces-225522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28665B9508C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEEA2E1280
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DCA31D38A;
	Tue, 23 Sep 2025 08:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D431D741
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616830; cv=none; b=AF78aHuReG0JdVdQAlB2ZLcnzesNUD7Ug/pxu7Dj5dsZczZhEC75MWZDunplfSJ0eDT19FMg21yYnuVr6b6pCmmTL07UvMWR1f9S12juPNclhYrQgbYU3mzew6uDUv8JS82a5xKx5pWmFvN94VlVnkX8lpJOxWTE2kWmPFXF9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616830; c=relaxed/simple;
	bh=q4eeJLqMoq08nHB3H6vwt+kTaSLJsauUW+ZSIELNuOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eVThO1uVSLLcUOnQ4UmLr0MES3spCeVyvcK6WKEnGBTnEoNZy44k58f3FP5l7qOy+pNpCD5NJyzhr90wR3kcZUyuR7pXODAdI7OIs41chNfbew6ST4XS6iJ0rQhCarQ9Lxi0otg3iyglANWxtTwAKpu91VALQncDE1NPXD87SzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz18t1758616806teba17e7f
X-QQ-Originating-IP: Y65HDPkAjT9I/dzKRWpqjqEX1/dZ3RUV9curQL0kqRY=
Received: from localhost.localdomain ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Sep 2025 16:40:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2421286488052786642
EX-QQ-RecipientCnt: 5
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH RESEND] ip/bond: add broadcast_neighbor support
Date: Tue, 23 Sep 2025 16:39:53 +0800
Message-Id: <20250923083953.16363-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MpO6L0LObisW1Tosg/bqpUTPHFrjYAfIkgFgg0siPUxAUk94fP9Mt/77
	j/+85MIhjWX0cqt5lJzi5X19J2N8v9k2U7mfbLNbOVt/QElfe0n36KumZ8jbfVL9qmjw5Fd
	q8MsV6Pc6m2wYtSY+SS4YqhYij7mhvdB3YGd7VUSBwtWMw03Trwo+VgxBnZIjXTIRZj3kXA
	rz+vmEdyKxwj1XSAYYU7IW7b0yjNTDVm6Gq9mhAmw4tRUdFRvfBz3C5iifzRKnfCCMrwsxT
	q32z5xn2n84QOU11b/F/CgmbrZTisAFbHfQCU7RWQ+X/3pnh6/7u6kXperE2Cp5S9kPWs0E
	nZ295MJ2KCInWGHMsApho5IbqkBbzhj1RHv77CT96wyQRYTIumENII90cVqejf+moLEuXl6
	bndwyVdrzuUl6AP+vdIJjLW8B9U95uMXS/kg3SCwV1flrTzQngkil1QGzDnnswzLgiSSh7E
	MCu2dge2curvO4hHAXdCsciZ03HTH70nTZkVZv7+s760DmOUxNvU9O//P4PR85E4AGbGZCh
	7qxiVk9Ot3+GGILbB6RSx61IT3dEjgTxqj6x3Iwdq/uRtH0yzZrLxqEbObpPxmR12Pt8xwD
	5N4cjSkkyJtMdSapqNXEhcb5ioUTDMv7uCn7/QxDaqUO0NmiWbYkY7whIUrsSZ+sFUYVKQK
	kXYtrKXLCMKwc5YkX02LcAa42FaAMNgSe7ZnrB0PYhU2jA5SlrXlhaFjV/IztcGUTdr4oeZ
	u+ZmY3xle9m7WN7T5bcCIZ+AuPFktT7Zm1GFzfDaDGP9mrqbPj4YGYj+CFoa9d+C8RCrMBK
	YCEAZSGoPslxL+Tnjl/L7y4BbwCTYWZbzXxqYP5vY9OSP5C3Og8lZZYEic9fPswjR2yjiE0
	Ukh9X05AHUFDsqA2hek5zqmHCd0wkxJnZfbkRsTc6nXCfEi6uvunrzfgkUxueBncbe7ohTK
	K1G9oZEOsweG0eyNdbYbLSM9TsGvHoR4Yzodh5Y3LXTHP4aHq2P2ERBupdgUa6dGUHp5FJp
	SOIGm+fLC1Bcu/snRIKKiO2yZw5f8=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

This option has no effect in modes other than 802.3ad mode.
When this option enabled, the bond device will broadcast ARP/ND
packets to all active slaves.

Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>
---
1. no update uapi header.
2. the kernel patch is accpted, https://patchwork.kernel.org/project/netdevbpf/patch/84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com/
---
 ip/iplink_bond.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 3ae626a0..714fe7bd 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -150,6 +150,7 @@ static void print_explain(FILE *f)
 		"                [ lacp_rate LACP_RATE ]\n"
 		"                [ lacp_active LACP_ACTIVE]\n"
 		"                [ coupled_control COUPLED_CONTROL ]\n"
+		"                [ broadcast_neighbor BROADCAST_NEIGHBOR ]\n"
 		"                [ ad_select AD_SELECT ]\n"
 		"                [ ad_user_port_key PORTKEY ]\n"
 		"                [ ad_actor_sys_prio SYSPRIO ]\n"
@@ -166,6 +167,7 @@ static void print_explain(FILE *f)
 		"LACP_RATE := slow|fast\n"
 		"AD_SELECT := stable|bandwidth|count\n"
 		"COUPLED_CONTROL := off|on\n"
+		"BROADCAST_NEIGHBOR := off|on\n"
 	);
 }
 
@@ -185,6 +187,7 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 	__u32 arp_all_targets, resend_igmp, min_links, lp_interval;
 	__u32 packets_per_slave;
 	__u8 missed_max;
+	__u8 broadcast_neighbor;
 	unsigned int ifindex;
 	int ret;
 
@@ -377,6 +380,12 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (ret)
 				return ret;
 			addattr8(n, 1024, IFLA_BOND_COUPLED_CONTROL, coupled_control);
+		} else if (strcmp(*argv, "broadcast_neighbor") == 0) {
+			NEXT_ARG();
+			broadcast_neighbor = parse_on_off("broadcast_neighbor", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr8(n, 1024, IFLA_BOND_BROADCAST_NEIGH, broadcast_neighbor);
 		} else if (matches(*argv, "ad_select") == 0) {
 			NEXT_ARG();
 			if (get_index(ad_select_tbl, *argv) < 0)
@@ -676,6 +685,13 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			     rta_getattr_u8(tb[IFLA_BOND_COUPLED_CONTROL]));
 	}
 
+	if (tb[IFLA_BOND_BROADCAST_NEIGH]) {
+		print_on_off(PRINT_ANY,
+			     "broadcast_neighbor",
+			     "broadcast_neighbor %s ",
+			     rta_getattr_u8(tb[IFLA_BOND_BROADCAST_NEIGH]));
+	}
+
 	if (tb[IFLA_BOND_AD_SELECT]) {
 		const char *ad_select = get_name(ad_select_tbl,
 						 rta_getattr_u8(tb[IFLA_BOND_AD_SELECT]));
-- 
2.34.1


