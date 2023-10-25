Return-Path: <netdev+bounces-44210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F907D719E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B4D1C20E72
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063A330CE8;
	Wed, 25 Oct 2023 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOtbQR9d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8130CE5
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45F2C433C7;
	Wed, 25 Oct 2023 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698250927;
	bh=Q4J6Dffc3q5PWdgWmRB3IZ2LYtpt04/UvFaVkkyJyno=;
	h=From:To:Cc:Subject:Date:From;
	b=FOtbQR9dXqxXC+HsGXAsWb+9SDQB0Dxdpj3ZNLkhGQncx7+ACS2CLTNdHyV4xQ+9u
	 K6EsShyjN5ARObfT6jC0oVPxw/ganpWUJdPT8uOOZlO5DaaKgUCyUoaDU7uqm690yP
	 NVoQC1TCIdG3Zj4Yaz0rf5AYc7GHDZPlbkI9IPnNJjcjh/9wVnSGXZI2VzevauWsv/
	 YT6NnuSmuM6/oOrCwu4SY7G9j/9pe3vShCRskBrMnN7JFksqGuxLnJmMj3xtTCv7tl
	 uI+qWLCgE5F3ut2rWIbACXEc9hXWnsTXwnBPqDLsyaytfb4rT4gGd1BJMfhsEi8uDx
	 64AXTjTMPOVqA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	j.vosburgh@gmail.com,
	andy@greyhouse.net,
	dsahern@kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	vinicius.gomes@intel.com,
	johannes@sipsolutions.net,
	razor@blackwall.org,
	idosch@nvidia.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH net-next] netlink: make range pointers in policies const
Date: Wed, 25 Oct 2023 09:22:04 -0700
Message-ID: <20231025162204.132528-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct nla_policy is usually constant itself, but unless
we make the ranges inside constant we won't be able to
make range structs const. The ranges are not modified
by the core.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: j.vosburgh@gmail.com
CC: andy@greyhouse.net
CC: dsahern@kernel.org
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
CC: vinicius.gomes@intel.com
CC: johannes@sipsolutions.net
CC: razor@blackwall.org
CC: idosch@nvidia.com
CC: linux-wireless@vger.kernel.org
---
 drivers/net/bonding/bond_netlink.c | 2 +-
 drivers/net/vxlan/vxlan_mdb.c      | 2 +-
 include/net/netlink.h              | 4 ++--
 net/ipv6/ioam6_iptunnel.c          | 2 +-
 net/sched/sch_fq.c                 | 2 +-
 net/sched/sch_fq_pie.c             | 2 +-
 net/sched/sch_qfq.c                | 2 +-
 net/sched/sch_taprio.c             | 2 +-
 net/wireless/nl80211.c             | 2 +-
 tools/net/ynl/ynl-gen-c.py         | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 27cbe148f0db..cfa74cf8bb1a 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -85,7 +85,7 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 }
 
 /* Limit the max delay range to 300s */
-static struct netlink_range_validation delay_range = {
+static const struct netlink_range_validation delay_range = {
 	.max = 300000,
 };
 
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 5e041622261a..3a21389658ce 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -311,7 +311,7 @@ vxlan_mdbe_src_list_pol[MDBE_SRC_LIST_MAX + 1] = {
 	[MDBE_SRC_LIST_ENTRY] = NLA_POLICY_NESTED(vxlan_mdbe_src_list_entry_pol),
 };
 
-static struct netlink_range_validation vni_range = {
+static const struct netlink_range_validation vni_range = {
 	.max = VXLAN_N_VID - 1,
 };
 
diff --git a/include/net/netlink.h b/include/net/netlink.h
index aba2b162a226..83bdf787aeee 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -360,8 +360,8 @@ struct nla_policy {
 		const u32 mask;
 		const char *reject_message;
 		const struct nla_policy *nested_policy;
-		struct netlink_range_validation *range;
-		struct netlink_range_validation_signed *range_signed;
+		const struct netlink_range_validation *range;
+		const struct netlink_range_validation_signed *range_signed;
 		struct {
 			s16 min, max;
 		};
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index f6f5b83dd954..7563f8c6aa87 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -46,7 +46,7 @@ struct ioam6_lwt {
 	struct ioam6_lwt_encap	tuninfo;
 };
 
-static struct netlink_range_validation freq_range = {
+static const struct netlink_range_validation freq_range = {
 	.min = IOAM6_IPTUNNEL_FREQ_MIN,
 	.max = IOAM6_IPTUNNEL_FREQ_MAX,
 };
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index bf9d00518a60..0fd18c344ab5 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -897,7 +897,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
 	return 0;
 }
 
-static struct netlink_range_validation iq_range = {
+static const struct netlink_range_validation iq_range = {
 	.max = INT_MAX,
 };
 
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 68e6acd0f130..5b595773e59b 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -202,7 +202,7 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	return NET_XMIT_CN;
 }
 
-static struct netlink_range_validation fq_pie_q_range = {
+static const struct netlink_range_validation fq_pie_q_range = {
 	.min = 1,
 	.max = 1 << 20,
 };
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 5598f8be18ae..28315166fe8e 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -213,7 +213,7 @@ static struct qfq_class *qfq_find_class(struct Qdisc *sch, u32 classid)
 	return container_of(clc, struct qfq_class, common);
 }
 
-static struct netlink_range_validation lmax_range = {
+static const struct netlink_range_validation lmax_range = {
 	.min = QFQ_MIN_LMAX,
 	.max = QFQ_MAX_LMAX,
 };
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1cb5e41c0ec7..2e1949de4171 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1015,7 +1015,7 @@ static const struct nla_policy taprio_tc_policy[TCA_TAPRIO_TC_ENTRY_MAX + 1] = {
 							      TC_FP_PREEMPTIBLE),
 };
 
-static struct netlink_range_validation_signed taprio_cycle_time_range = {
+static const struct netlink_range_validation_signed taprio_cycle_time_range = {
 	.min = 0,
 	.max = INT_MAX,
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2650543dcebe..2f8353bf603c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -463,7 +463,7 @@ nl80211_sta_wme_policy[NL80211_STA_WME_MAX + 1] = {
 	[NL80211_STA_WME_MAX_SP] = { .type = NLA_U8 },
 };
 
-static struct netlink_range_validation nl80211_punct_bitmap_range = {
+static const struct netlink_range_validation nl80211_punct_bitmap_range = {
 	.min = 0,
 	.max = 0xffff,
 };
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 0fee68863db4..31fd96f14fc0 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2038,7 +2038,7 @@ _C_KW = {
                 first = False
 
             sign = '' if attr.type[0] == 'u' else '_signed'
-            cw.block_start(line=f'struct netlink_range_validation{sign} {c_lower(attr.enum_name)}_range =')
+            cw.block_start(line=f'static const struct netlink_range_validation{sign} {c_lower(attr.enum_name)}_range =')
             members = []
             if 'min' in attr.checks:
                 members.append(('min', attr.get_limit('min')))
-- 
2.41.0


