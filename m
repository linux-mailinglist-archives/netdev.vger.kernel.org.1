Return-Path: <netdev+bounces-251649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA0GNWgPcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:27:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D094DC98
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B239582F9FA
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55D41C2EB;
	Tue, 20 Jan 2026 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="yJrpIYU2"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E9F3F075C;
	Tue, 20 Jan 2026 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950382; cv=none; b=kevPd4ADCMHC2L+lMT4acNgxcOyM0HSimlwrIXybhsk7dV/tJzeGAwLjTVXrMbSeolpAWH0NxAdjmmElZ7FsAoIBY23h+uamK2BBxyiM+2pybWqVYCdzg5zotlcAc9O2jAxxVNDe+rMShP6ZtDghZIBP0q+kFwH888TdRmXiqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950382; c=relaxed/simple;
	bh=1pBPr/1O+Zc9ubpe25bP3E87XGakOzFEtSPpaxOVux4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdKKhtkI2SZ0dnLfUwjT06jeWTvczNglzFpv6P1pQsPE2GCn3OTjs8RhnEYHXG6ohAWbfe3HMCMyGZK2ucpocyXhi2R7sL94OAG1eMJgrdizBYHMyejaRLUqwYdUGEGqF+d/z5RPGF0dgVPvBpoPGdiVoIekOWw0o6X1GZUuddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=yJrpIYU2; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=xH68nDre/GSdA+pta6G83GvGfKOp/YUqjmBjhttBy3A=; b=yJrpIYU2RXbl
	cdNpuj3meMnPZ2E6m1XvFODnWDSP1uQ5RNMZN7vKURW6Yn5vMiivEkHCzPCXJir0vQPbgXU2OA41a
	nNT5hQ1mzjmiomHDGFTJ76AT/59dD7Dk8bZuuL7YK49H98twNJo7v0vlPVGjimeeTc8t0kMC4nRrB
	6o2+eF0YimCPwNwXKjxZdEm/O8pb02UHPkl+qSpkgli/zdbHJkINDNu6VKkPn1t8yCPkPneKIp8kA
	6zKkpKRujyerUCxkD6mX7rPbwa7v0eeh/xqKyyW477jxtPuftSa0TzVOFLY1FYKmxV0DLhDmavFlI
	5vlF7zuxpr5/7uk+um8NaQ==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1viKnB-00Fnt7-2f;
	Wed, 21 Jan 2026 00:06:05 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60KN6FOD328466
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 23:06:15 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60KN6Emu328465;
	Tue, 20 Jan 2026 23:06:14 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH 4/5] selftests: net: run pmtu.sh in netns to avoid host firewall interference
Date: Tue, 20 Jan 2026 23:05:57 +0000
Message-ID: <20260120230558.328423-5-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120230558.328423-1-aleksey.oladko@virtuozzo.com>
References: <20260120230558.328423-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	TAGGED_FROM(0.00)[bounces-251649-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[virtuozzo.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pmtu_wrapper.sh:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,virtuozzo.com:email,virtuozzo.com:dkim,virtuozzo.com:mid,pmtu.sh:url]
X-Rspamd-Queue-Id: 46D094DC98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Konstantin Khorenko <khorenko@virtuozzo.com>

The pmtu.sh kselftest sets up a multi-namespace test topology where the
host network itself is part of the test setup. Test packets originating
from the created namespace are expected to reach test interface created
in the host. When firewall rules are present on the host, this traffic
may be blocked, causing the test to fail.

Run the test in an isolated network namespace to avoid interference
from host firewall rules.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 tools/testing/selftests/net/Makefile        | 2 +-
 tools/testing/selftests/net/pmtu_wrapper.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/pmtu_wrapper.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a160e0d816d9..7c6b61e90062 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -60,7 +60,7 @@ TEST_PROGS := \
 	netns-name.sh \
 	netns-sysctl.sh \
 	nl_netdev.py \
-	pmtu.sh \
+	pmtu_wrapper.sh \
 	psock_snd.sh \
 	reuseaddr_ports_exhausted.sh \
 	reuseport_addr_any.sh \
diff --git a/tools/testing/selftests/net/pmtu_wrapper.sh b/tools/testing/selftests/net/pmtu_wrapper.sh
new file mode 100755
index 000000000000..d43c23ba5155
--- /dev/null
+++ b/tools/testing/selftests/net/pmtu_wrapper.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+./in_netns.sh ./pmtu.sh "$@"
-- 
2.43.0


