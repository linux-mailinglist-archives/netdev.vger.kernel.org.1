Return-Path: <netdev+bounces-210269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF535B1285E
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 03:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF04188EFE2
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC10198E8C;
	Sat, 26 Jul 2025 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="q023xOWM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4634D1459EA
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753492152; cv=none; b=VwJyI8a2eJbZyP1m0KTqg6UnUDDy2yCVs7rPkhRte8kNCKX4QV5y3He90n666HwTeO5LcgODfhwyaFeiG+Ut1RprdfyhxBUlkg+CD9Mrce2ZCLgLUEoTorS11cOQhS36sIPyI7W8Aob0pz++PDYOHBjOewJjkdhgXYGJmQI+UxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753492152; c=relaxed/simple;
	bh=KQ3oid4xO3RCd/zxROC4pH/4mRLF7mmmwSdndZh+EH8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CEwD8JPnBlnV4Vc/VNdllOpfPr3IYhhbhn1yFXDpeGhcIlBlKLRzkdj70G/dMJPHrRff8z9l3PIRyfV8AWurtHiqBU3TXQaktsry2FJN90TJ/rn5b/fyZcS+vtGU9/lzktHYvlPRgHdexV0MUwVY3pNaS98Y8kpav0uXawYrd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=q023xOWM; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazoncorp2; t=1753492151; x=1785028151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IJ8q0ua2J4KYTFB7/vBSLOOq0tkC07kt9F3YzAHkSXg=;
  b=q023xOWMvq0tKW+kOZIS98YK/nMbKnnCLd/p0G//DDmWTyjj2x3T9tvr
   Ihk/kq+5reRyHKKycva+aVz9+itPS2RWJiXmrV6Vgw1fXMLX0jKoVxb/8
   AevPs6NaI3KRjCcHQuLrZvy1v0Tp1yP4oUPXGOiYrp893fFfsNFEv2I7J
   0NQSRXa6v32bC/bPP5Vpkv40WKwBZx6dygf40+3AkhW6+hA8hlHP1j6/T
   j+OAR3oTMKpBOYFOqh7hHfkw+u//29EplAeoaMgLiA14OL8WbFsFIHmg3
   8IGX1QXrzBI52qcVwWAVGpsE2oxA05bJ4229uvGGb17RDObtYOB9lr38I
   g==;
X-IronPort-AV: E=Sophos;i="6.16,339,1744070400"; 
   d="scan'208";a="541102522"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 01:09:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:51356]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.72:2525] with esmtp (Farcaster)
 id e9743b6a-953d-4139-9606-6d9616bb05d6; Sat, 26 Jul 2025 01:09:10 +0000 (UTC)
X-Farcaster-Flow-ID: e9743b6a-953d-4139-9606-6d9616bb05d6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 26 Jul 2025 01:09:08 +0000
Received: from 80a9974c3af6.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 26 Jul 2025 01:09:06 +0000
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
Subject: [PATCH v2 net] net/sched: taprio: enforce minimum value for picos_per_byte
Date: Sat, 26 Jul 2025 10:08:15 +0900
Message-ID: <20250726010815.20198-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
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
  v2:
    - Add warning for users to inform link speed is too high for scheduling.
    - Correct fixes tag to indicate appropriate commit.
  v1: https://lore.kernel.org/all/20250724181345.40961-1-takamitz@amazon.co.jp/
  
 net/sched/sch_taprio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 2b14c81a87e5..55c8ca4f946d 100644
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
@@ -1300,6 +1306,11 @@ static void taprio_set_picos_per_byte(struct net_device *dev,
 
 skip:
 	picos_per_byte = (USEC_PER_SEC * 8) / speed;
+	if (picos_per_byte < TAPRIO_PICOS_PER_BYTE_MIN) {
+		pr_warn("Link speed %d is too high. Schedule may be inaccurate.\n",
+			speed);
+		picos_per_byte = TAPRIO_PICOS_PER_BYTE_MIN;
+	}
 
 	atomic64_set(&q->picos_per_byte, picos_per_byte);
 	netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %lld, linkspeed: %d\n",
-- 
2.39.5 (Apple Git-154)


