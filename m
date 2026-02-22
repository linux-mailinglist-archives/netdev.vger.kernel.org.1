Return-Path: <netdev+bounces-259871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD2yN4TmmmnImgMAu9opvQ
	(envelope-from <netdev+bounces-259871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 12:20:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEDE16EF7C
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 12:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 139863012250
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C1521ADCB;
	Sun, 22 Feb 2026 11:19:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA1214A8B
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771759163; cv=none; b=bxeqC84/HBlnDWP5gLAptB8OmYaUIT+Thf34lveUHAcOPT5KbvcRMpPVVNbBWtD3+bQjvwwm2LW9MhFDU2PnDtNSMmD0eZMwAqyiY2YLB+D9ujZQQ7wCkCJbdil7oL5WZTlAIbuvq12u+X0pB1Td2HnBUTPC8QUyZt14gHEl8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771759163; c=relaxed/simple;
	bh=w4eesFSGAhob1SRC4Ny62emszbbwR/4p7ozeomnA+0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkCCHnVO3fHIgvyFS/KYUpeHJCHBQeDF+Hm/AxxYKFkiVsrGbrbMDq/SJ9de3NyFNFEyD8KTfhxpaEx8x9VXtR8y/a7wNqveIc/3b08zZg2KfVzVO56chk1cDd9JJW72debWgJ+DtiSrx0Eo0flsDTkfDBN3+SmN4SPfSLK13Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61MBJKCW074179;
	Sun, 22 Feb 2026 20:19:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61MBJJI7074176
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 22 Feb 2026 20:19:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <43ab8835-83af-43b5-8317-37fd2b25e1c1@I-love.SAKURA.ne.jp>
Date: Sun, 22 Feb 2026 20:19:20 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] selftests/net: team: add team unregister test
To: Ido Schimmel <idosch@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <stfomichev@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Network Development
 <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@nvidia.com>
References: <4d69abe1-ca8d-4f0b-bcf8-13899b211e57@I-love.SAKURA.ne.jp>
 <aXl_MwhS9AJXTYi4@mini-arch> <20260129191243.767e3005@kernel.org>
 <14ed1845-370f-4b28-83e2-d8424db3ab36@I-love.SAKURA.ne.jp>
 <20260222093413.GA30085@shredder>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260222093413.GA30085@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259871-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,I-love.SAKURA.ne.jp:mid,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: CBEDE16EF7C
X-Rspamd-Action: no action

Add selftest for "team: avoid NETDEV_CHANGEMTU event when unregistering
slave" patch.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Does Makefile look OK?

 tools/testing/selftests/net/team/Makefile     |  7 ++++++
 .../selftests/net/team/team_unregister.sh     | 24 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/net/team/Makefile
 create mode 100755 tools/testing/selftests/net/team/team_unregister.sh

diff --git a/tools/testing/selftests/net/team/Makefile b/tools/testing/selftests/net/team/Makefile
new file mode 100644
index 000000000000..aa8ef0590022
--- /dev/null
+++ b/tools/testing/selftests/net/team/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+top_srcdir = ../../../../..
+
+TEST_PROGS := team_unregister.sh
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/team/team_unregister.sh b/tools/testing/selftests/net/team/team_unregister.sh
new file mode 100755
index 000000000000..94dd49b0c21b
--- /dev/null
+++ b/tools/testing/selftests/net/team/team_unregister.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+
+source ../lib.sh
+
+NS_NAME="ns-"$RANDOM
+TEAM_NAME="team-"$RANDOM
+DUMMY_NAME="dummy-"$RANDOM
+
+cleanup() {
+    cleanup_ns $NS_NAME
+    ip link del $TEAM_NAME
+}
+
+trap cleanup EXIT
+ip link add name $TEAM_NAME type team
+ip link add name $DUMMY_NAME mtu 1499 master $TEAM_NAME type dummy
+ip netns add $NS_NAME
+echo "Setting $DUMMY_NAME to $NS_NAME"
+ip link set dev $DUMMY_NAME netns $NS_NAME
+echo "Deleting $DUMMY_NAME from $NS_NAME"
+ip -n $NS_NAME link del dev $DUMMY_NAME
+echo "Test completed successfully."
-- 
2.53.0



