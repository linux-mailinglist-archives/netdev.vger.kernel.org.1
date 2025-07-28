Return-Path: <netdev+bounces-210629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F6CB1413C
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4604C3A66CF
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8C7215F72;
	Mon, 28 Jul 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="ftoE4u/w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770615278E
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753723936; cv=none; b=QFif/4elD4kPD6F7+/KgVOR0uVQjC4Yhb+4S7qSH7M1BiAonqtWa1u+j/PmldGNuJSizlVLSuGJ2Amqt7fN5ZBsFIItsuAInO0Rn7ksROnoksqjOl+z4IOBtElVTH1m10tNZqdWQ1BhkB6GDyZefFLOE9Tq7Qh1Har/YksFtp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753723936; c=relaxed/simple;
	bh=QtQi60iaj+zTiuCYqu/0y6MYZWNZxVi/rT1e31gMDAA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kCQHMxkoXmm0hUTBnnXb7U3mtAATkKTjPt67/9M/nXqLNwxoLhgXVu2IdTAn0L6/wY+IpiCnodSwBirrC6AOEKRbJb2fPHDIj7Nnl2jEO1qK3y5d7SGO2ntgft+gFr4+Pe2cwpL8sImETaVIT2M+7qFuYfvYENEmqt0uaSoS9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=ftoE4u/w; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazoncorp2; t=1753723935; x=1785259935;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7QBDy7Ce4qHq/paw4Em69sNOKGghO6SndVKUkR9DPYI=;
  b=ftoE4u/wqH+0qZa7gdgdI3UHLfnlGdU9e3xOoRyAhjN9lShk15zcOzsu
   CwHfgMzJoLpjE9KM9TXsZSwgO4kUSivie5lDVntn79g3WQPJvsO2dFrLh
   fwH2n6ZhxKy7IO8CsMa1zDeSKMaMPNm3auuEwrqYq5S5UQuDKMxbTdIRW
   LuHZn45eVBQT57kOMSNm+PN5CcFFe1hepWq9zZ/beoFpaXX7A+SpSVldy
   5WYK2W+QgYB61pHgQ39UPEpJ+r1knkIYlmyPkXePl1prG11V7v9Cagzqs
   FGR1EokdPxTGHj7/0uMJHB7RyB0xIAP8plW7ZZAAX6HlVB5crx6p21jgw
   w==;
X-IronPort-AV: E=Sophos;i="6.16,339,1744070400"; 
   d="scan'208";a="513118610"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 17:32:13 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:55157]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.29:2525] with esmtp (Farcaster)
 id ef399a78-0d97-4330-a32f-0da10e907343; Mon, 28 Jul 2025 17:32:12 +0000 (UTC)
X-Farcaster-Flow-ID: ef399a78-0d97-4330-a32f-0da10e907343
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 28 Jul 2025 17:32:11 +0000
Received: from 80a9974c3af6.amazon.com (10.37.244.13) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 28 Jul 2025 17:32:09 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
	<takamitz@amazon.com>, Takamitsu Iwai <takamitz@amazon.co.jp>,
	<syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com>
Subject: [PATCH v3 net] net/sched: taprio: enforce minimum value for picos_per_byte
Date: Tue, 29 Jul 2025 02:31:49 +0900
Message-ID: <20250728173149.45585-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Syzbot reported a WARNING in taprio_get_start_time().

When link speed is 470,589 or greater, q->picos_per_byte becomes too
small, causing length_to_duration(q, ETH_ZLEN) to return zero.

This zero value leads to validation failures in fill_sched_entry() and
parse_taprio_schedule(), allowing arbitrary values to be assigned to
entry->interval and cycle_time. As a result, sched->cycle can become zero.

Since SPEED_800000 is the largest defined speed in
include/uapi/linux/ethtool.h, this issue can occur in realistic scenarios.

To ensure length_to_duration() returns a non-zero value for minimum-sized
Ethernet frames (ETH_ZLEN = 60), picos_per_byte must be at least 17
(60 * 17 > PSEC_PER_NSEC which is 1000).

This patch enforces a minimum value of 17 for picos_per_byte when the
calculated value would be lower, and adds a warning message to inform
users that scheduling accuracy may be affected at very high link speeds.

Fixes: fb66df20a720 ("net/sched: taprio: extend minimum interval restriction to entire cycle too")
Reported-by: syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=398e1ee4ca2cac05fddb
Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>
---
Changes:
  v3:
    - Remove unnecessary blank line.
    - Add NL_SET_ERR_MSG_FMT_MOD() to show warning directly to the users
      when taprio_set_picos_per_byte() is called from taprio_change().

  v2: https://lore.kernel.org/all/20250726010815.20198-1-takamitz@amazon.co.jp/
    - Add pr_warn() for users to inform link speed is too high for scheduling.
    - Correct fixes tag to indicate appropriate commit.

  v1: https://lore.kernel.org/all/20250724181345.40961-1-takamitz@amazon.co.jp/

 net/sched/sch_taprio.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index e759e43ad27e..39b735386996 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -43,6 +43,11 @@ static struct static_key_false taprio_have_working_mqprio;
 #define TAPRIO_SUPPORTED_FLAGS \
 	(TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST | TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
 #define TAPRIO_FLAGS_INVALID U32_MAX
+/* Minimum value for picos_per_byte to ensure non-zero duration
+ * for minimum-sized Ethernet frames (ETH_ZLEN = 60).
+ * 60 * 17 > PSEC_PER_NSEC (1000)
+ */
+#define TAPRIO_PICOS_PER_BYTE_MIN 17
 
 struct sched_entry {
 	/* Durations between this GCL entry and the GCL entry where the
@@ -1284,7 +1289,8 @@ static void taprio_start_sched(struct Qdisc *sch,
 }
 
 static void taprio_set_picos_per_byte(struct net_device *dev,
-				      struct taprio_sched *q)
+				      struct taprio_sched *q,
+				      struct netlink_ext_ack *extack)
 {
 	struct ethtool_link_ksettings ecmd;
 	int speed = SPEED_10;
@@ -1300,6 +1306,15 @@ static void taprio_set_picos_per_byte(struct net_device *dev,
 
 skip:
 	picos_per_byte = (USEC_PER_SEC * 8) / speed;
+	if (picos_per_byte < TAPRIO_PICOS_PER_BYTE_MIN) {
+		if (!extack)
+			pr_warn("Link speed %d is too high. Schedule may be inaccurate.\n",
+				speed);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Link speed %d is too high. Schedule may be inaccurate.",
+				       speed);
+		picos_per_byte = TAPRIO_PICOS_PER_BYTE_MIN;
+	}
 
 	atomic64_set(&q->picos_per_byte, picos_per_byte);
 	netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %lld, linkspeed: %d\n",
@@ -1324,7 +1339,7 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
 		if (dev != qdisc_dev(q->root))
 			continue;
 
-		taprio_set_picos_per_byte(dev, q);
+		taprio_set_picos_per_byte(dev, q, NULL);
 
 		stab = rtnl_dereference(q->root->stab);
 
@@ -1844,7 +1859,7 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	q->flags = taprio_flags;
 
 	/* Needed for length_to_duration() during netlink attribute parsing */
-	taprio_set_picos_per_byte(dev, q);
+	taprio_set_picos_per_byte(dev, q, extack);
 
 	err = taprio_parse_mqprio_opt(dev, mqprio, extack, q->flags);
 	if (err < 0)
-- 
2.39.5 (Apple Git-154)


