Return-Path: <netdev+bounces-70692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0688500E7
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD7F1C2384A
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 23:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234872134B;
	Fri,  9 Feb 2024 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYcpUFvJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37EA37712
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 23:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522856; cv=none; b=NFyDunBuRg64FZoxmE5UPPNcZwn6otsNjYxkaXFzerYEk10ce4yLlA+Yr6rskcLMNig/91FRktyBFUYShjbx50K0v7afM1NygoELWBLdWBqZ6sS8Z8oxgzFCUpw1YAYwp8MTrOL/9TAexxc2ptKnNxhucdA4Koe7ugUi0YbjNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522856; c=relaxed/simple;
	bh=2+py5KH0QykGnUIvDMw0ZhdeEHGCGRIa7cVUCRZas5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcXmEvHmkk37/GV0RGh3GxPuk/jsB7Cwc+zvyJkIyk5huWeUzbQJ/7pekkp8H+U4nXmVGof3BgWQFAM8fVsFY3n1+nqbwLwFNUzrFyhUwYmyKVHxp5N0ziQyju65zVp8uG823fqgDUQMBdC58pgCVAADQp6T2m1mCbWbU70zFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYcpUFvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E80BC433F1;
	Fri,  9 Feb 2024 23:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707522855;
	bh=2+py5KH0QykGnUIvDMw0ZhdeEHGCGRIa7cVUCRZas5g=;
	h=From:To:Cc:Subject:Date:From;
	b=NYcpUFvJJ0FNZsMHGf/YLtyH09VR+AKeW/t4sIl0kOlTNInuVhhG2GrT1nROAzrB3
	 Wz+3AGQ2sZ2QQ8xW4oz8LEiDrDE/7+/jpnpJSm+TVCoo5df3T7FKti6GLVHaYkIOFe
	 xZ/g+4S0CFDo7opMlsfR5UWMt7vs7cZ4YJOrfqC9JROePUilVw9dUj4aOl6SrPZprd
	 nXFhmO3fvgNN3vqScIPbqMggTevdg+KLLIBzjQvThHe1RAmspOcTEIxSIn1d7y/DdX
	 3twmd9AnQrd0x7p2+QJZtdWGz19BEojEIsDn4xj12DkJg2nJ0Bfp7D/An/CVit16sV
	 CBSwJDHmKOV7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shmulik.ladkani@gmail.com
Subject: [PATCH net] net/sched: act_mirred: use the backlog for mirred ingress
Date: Fri,  9 Feb 2024 15:54:13 -0800
Message-ID: <20240209235413.3717039-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlog
for nested calls to mirred ingress") hangs our testing VMs every 10 or so
runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
lockdep.

In the past there was a concern that the backlog indirection will
lead to loss of error reporting / less accurate stats. But the current
workaround does not seem to address the issue.

Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions")
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Suggested-by: Davide Caratti <dcaratti@redhat.com>
Link: https://lore.kernel.org/netdev/33dc43f587ec1388ba456b4915c75f02a8aae226.1663945716.git.dcaratti@redhat.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
CC: shmulik.ladkani@gmail.com
---
 net/sched/act_mirred.c                             | 14 +++++---------
 .../testing/selftests/net/forwarding/tc_actions.sh |  3 ---
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 93a96e9d8d90..35c366f043d9 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -232,18 +232,14 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 	return err;
 }
 
-static bool is_mirred_nested(void)
-{
-	return unlikely(__this_cpu_read(mirred_nest_level) > 1);
-}
-
-static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
+static int
+tcf_mirred_forward(bool at_ingress, bool want_ingress, struct sk_buff *skb)
 {
 	int err;
 
 	if (!want_ingress)
 		err = tcf_dev_queue_xmit(skb, dev_queue_xmit);
-	else if (is_mirred_nested())
+	else if (!at_ingress)
 		err = netif_rx(skb);
 	else
 		err = netif_receive_skb(skb);
@@ -319,9 +315,9 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 
 		skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingress);
 
-		err = tcf_mirred_forward(want_ingress, skb_to_send);
+		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
 	} else {
-		err = tcf_mirred_forward(want_ingress, skb_to_send);
+		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
 	}
 
 	if (err) {
diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index b0f5e55d2d0b..589629636502 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -235,9 +235,6 @@ mirred_egress_to_ingress_tcp_test()
 	check_err $? "didn't mirred redirect ICMP"
 	tc_check_packets "dev $h1 ingress" 102 10
 	check_err $? "didn't drop mirred ICMP"
-	local overlimits=$(tc_rule_stats_get ${h1} 101 egress .overlimits)
-	test ${overlimits} = 10
-	check_err $? "wrong overlimits, expected 10 got ${overlimits}"
 
 	tc filter del dev $h1 egress protocol ip pref 100 handle 100 flower
 	tc filter del dev $h1 egress protocol ip pref 101 handle 101 flower
-- 
2.43.0


