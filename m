Return-Path: <netdev+bounces-202224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88476AECC57
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 13:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC807A1A1A
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48220219A67;
	Sun, 29 Jun 2025 11:52:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0FC204C0C
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197973; cv=none; b=azTVqe9O6VPEIWYHUmugj82dwUez3w4+pH2VcGytkNGd0G/OjvPpzdwbRbLuPt4C4/Nn4TeAFs8+z/CnN5eUiSTQRNM53/dRFuuCWo4W1iS6wq/2MXkZvbkwY884le6X5rufuPQ2eqs8I7u2qge4jp9vFasB7ReslNABtOkjYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197973; c=relaxed/simple;
	bh=6ey9R1dUAfYjzlkbSsWMiJxsq8/DmzD1abjkHvhLD1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PnTkyy1tH9RA6lyB4eNxndo3j6EKc+5HlUOkDxxuvjhL4oxV2IXncGhcvUQYp0XVsNwj1wvayvkQ807FGzQfHyBoLlGHlAbZcac9kkyX5q+Lu3+1cbYC+1+YCNRBAldexhZMXjPHMdZfnDx8Z9UREltlJ0erHARKpcUiq/3VB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz21t1751197938tda63f881
X-QQ-Originating-IP: rYNIS71dsZN3vC8CVGtgAD/fB+BXFl7jyjXCqSdzXT0=
Received: from bogon.xiaojukeji.com ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 29 Jun 2025 19:52:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2213489673698014419
EX-QQ-RecipientCnt: 4
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2-next] ip/bond: add broadcast_neighbor support
Date: Sun, 29 Jun 2025 19:52:12 +0800
Message-Id: <20250629115212.95397-1-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: MX2TrL0qDY4jgfhzgae4YedHlIPf5eW5ObsZ7zYkj50d65SoQslTtrVC
	cWRcBhJPw5Uydv0Uvvb4cy35ntJZNoGKluW9L8zmhTNkgxUJuamiQucd0wg8sxMVhUJZjvG
	yrVeG6yZVQAawlwF2cktcnfVONTobcEbBYRCyj5SMMpPz/aWcpbC/eI8XnJzVb4KEYSV76d
	+X24nb7yT7S7PAFNv71h3ltgzf5KtcMYiJ0G3h+7SdWcBUvF89BPq12oBud26KSpeXZbmqe
	nOh90NcM2k3TFFyQGo3UiNv2jd+r4v22jTeXL7l6bR6zHk9Srq64NfACsbdf9TpXOBtjBAo
	KLQue90FI/PZkjhOo4hUVXi74sS5+BqFMPWrb9pzTG0FgXE8tUpIVZqlCYYpeeO1D8v8LJa
	cXvlLx51mvgOS97PruaFGUIy0B8Jg72vcxHHw5jUAdUmrJjryh0MsA+A2eB3Czy4sC+z6nj
	a8wPPNliC8pAjYai5CXprE4NTTVmgwLU0ZuM7nJhvGziJbec+NlQitygDI5xmziWmonFNiP
	LsKe1YaniuyykfDvwyFSk5HLQhYHBoxwbl/d/KOqQpKFukZUJaTsKpVD37uL683mt19YMUv
	G+qYStQddIRmx25wEHS8jNxQgwUdJYZtd/mwrZVHZ6mBQ+X3tOk5CHSo/ZU9WE4J8lHGnQD
	RDWIMZxHRJXALRWbAvRdr2Hn57ESjCu9fuvRllAksekAdGzvg3mSuxKEr2+4+NNOkLL60Uz
	DWMIOLTA5RLX8XhheobkBdVm4pa4NoZIqbRrSAF3FGZ+JMD+n+KkmOoV2AMbJd92kuE72Uw
	FKTp53yan8S9z+6p7OxPM6lxkufjUdBFqJHA6mLol2fT0TjoWMKio/xFarr/+TnI2U6Cj5P
	7btQmoHIspnoj3czdSWSekcrTck0sJZcwbZ6NUOntqgtx3XcPPA2Wqf8+q5aUUx+rJ+Wu+U
	SdWYZzoiBmhpewfZboZFfyyExW5wUlVkyO0m8CiCbcdOyagr12q12/0A2
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

This option has no effect in modes other than 802.3ad mode.
When this option enabled, the bond device will broadcast ARP/ND
packets to all active slaves.

Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
no update uapi header: https://marc.info/?l=linux-netdev&m=170614774224160&w=3
net-next patch: https://patchwork.kernel.org/project/netdevbpf/patch/84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com/
---
 ip/iplink_bond.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index a964f547..b1b144fb 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -149,6 +149,7 @@ static void print_explain(FILE *f)
 		"                [ lacp_rate LACP_RATE ]\n"
 		"                [ lacp_active LACP_ACTIVE]\n"
 		"                [ coupled_control COUPLED_CONTROL ]\n"
+		"                [ broadcast_neighbor BROADCAST_NEIGHBOR ]\n"
 		"                [ ad_select AD_SELECT ]\n"
 		"                [ ad_user_port_key PORTKEY ]\n"
 		"                [ ad_actor_sys_prio SYSPRIO ]\n"
@@ -165,6 +166,7 @@ static void print_explain(FILE *f)
 		"LACP_RATE := slow|fast\n"
 		"AD_SELECT := stable|bandwidth|count\n"
 		"COUPLED_CONTROL := off|on\n"
+		"BROADCAST_NEIGHBOR := off|on\n"
 	);
 }

@@ -184,6 +186,7 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 	__u32 arp_all_targets, resend_igmp, min_links, lp_interval;
 	__u32 packets_per_slave;
 	__u8 missed_max;
+	__u8 broadcast_neighbor;
 	unsigned int ifindex;
 	int ret;

@@ -376,6 +379,12 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
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
@@ -675,6 +684,13 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
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


