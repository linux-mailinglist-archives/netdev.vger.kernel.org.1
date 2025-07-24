Return-Path: <netdev+bounces-209832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A155B110AF
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCFE586A3F
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789182EB5D4;
	Thu, 24 Jul 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="ING8lML4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D791A23BB
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753380861; cv=none; b=oHvK+gNczucZ/+BQejS54DxomR8CV7+RSd08XmK+pT/+rxwMOW+NEvOP41+8oKNnjW+TvrJQ8cl7vdlTB+Qgnp4Mc40XNCWb3RWXvNcN9KajpRkdqOqYtoUWWlnSbee3NIAJHHk2JnqjyrJ/F++bbqezdmv3e84o28SnqVUvmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753380861; c=relaxed/simple;
	bh=5jks/iRh0a/1aDKiLgt0AnZmU9i3FXnTkvgaW6JYbWw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qWdx9cPAhCCjElfy9tzD2n8MtwRwvP/Z0GAhyOu5ygdcflqYD3BdYGplGkecjHeGyKh5aM1cfePsqMDQ/969h4PnSRQ5NOdbYU1rMsQ8Ebs9WQnpKVSZ1meNhyeh/OvnltFiEkEDLjvatyClkbNmuAR/UwJMuoJ5Hg2DHa23kq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=ING8lML4; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazoncorp2; t=1753380859; x=1784916859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JsW0M6F2wkYAEXbg1vCjIJaVdwndN+h+LkOh7xfqoTo=;
  b=ING8lML4f7FYNnUGo5DrPwNjKTESe2krhQK0qCw0elKFEOINToUaNiT6
   0Mbts+7WJpBB4llItXf99hyUDfAO9CEiQiC8rYFwn7xAPY1pRzt1smRgH
   YKr7PjN/t0a3avQoBvvC67h8KiOilFyU7IHBqqu2aSg2mo0L3rGeBJVwy
   c/P4okOCrmmVRobYjltPIbtydpeq6mOGYozXmcBRN87UVuWsB45r2MKXG
   /2n0sX1yeAYhVsoh2ewpc8x8gmngk5faq9Lt8n8DpoAOqzfXzbZABflFL
   wgxPLojYS2twBbcMzHOlzYS+EAsDh9SBhDb+8quJCpph1PKR55B579mSl
   w==;
X-IronPort-AV: E=Sophos;i="6.16,337,1744070400"; 
   d="scan'208";a="217275362"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 18:14:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:64321]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.29:2525] with esmtp (Farcaster)
 id 0cb89c7d-78dc-42d9-bbaa-210dcb81ab33; Thu, 24 Jul 2025 18:14:17 +0000 (UTC)
X-Farcaster-Flow-ID: 0cb89c7d-78dc-42d9-bbaa-210dcb81ab33
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Jul 2025 18:14:17 +0000
Received: from 80a9974c3af6.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Jul 2025 18:14:15 +0000
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
Subject: [PATCH v1 net] net/sched: taprio: enforce minimum value for picos_per_byte
Date: Fri, 25 Jul 2025 03:13:45 +0900
Message-ID: <20250724181345.40961-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Syzbot reported a WARNING in taprio_get_start_time().

When link speed is 470589 or greater, q->picos_per_byte becomes too
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
calculated value would be lower.

Fixes: 68ce6688a5ba ("net: sched: taprio: Fix potential integer overflow in taprio_set_picos_per_byte")
Reported-by: syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=398e1ee4ca2cac05fddb
Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>
---
 net/sched/sch_taprio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 2b14c81a87e5..bcfdb9446657 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -43,6 +43,12 @@ static struct static_key_false taprio_have_working_mqprio;
 #define TAPRIO_SUPPORTED_FLAGS \
 	(TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST | TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
 #define TAPRIO_FLAGS_INVALID U32_MAX
+/* Minimum value for picos_per_byte to ensure non-zero duration
+ * for minimum-sized Ethernet frames (ETH_ZLEN = 60).
+ * 60 * 17 > PSEC_PER_NSEC (1000)
+ */
+#define TAPRIO_PICOS_PER_BYTE_MIN 17
+
 
 struct sched_entry {
 	/* Durations between this GCL entry and the GCL entry where the
@@ -1299,7 +1305,7 @@ static void taprio_set_picos_per_byte(struct net_device *dev,
 		speed = ecmd.base.speed;
 
 skip:
-	picos_per_byte = (USEC_PER_SEC * 8) / speed;
+	picos_per_byte = max((USEC_PER_SEC * 8) / speed, TAPRIO_PICOS_PER_BYTE_MIN);
 
 	atomic64_set(&q->picos_per_byte, picos_per_byte);
 	netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %lld, linkspeed: %d\n",
-- 
2.39.5 (Apple Git-154)


