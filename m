Return-Path: <netdev+bounces-254030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLI/I8NBeWmAwAEAu9opvQ
	(envelope-from <netdev+bounces-254030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:52:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2398B9B408
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C023046510
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D852EBDCD;
	Tue, 27 Jan 2026 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="de+2aBdV"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E23B26C3B0;
	Tue, 27 Jan 2026 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769554326; cv=none; b=YOZa6I/NZqipTVgUDNREJu2YPV53KUrkA9HF9ghjL32k9HRt0bw3lMmWgtXY4+YUwjAgb5AAgrqn7/NVFyZ7eKoMabjzO8KFbeiKvm2y6XLr24yWzgA6Xq0es2TumGQ1e9+gX9P5934S1fa4yZ4ljGiaTSh7wYWsBgKY9+fRE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769554326; c=relaxed/simple;
	bh=cup0bCUk/lNTrWk4tM8eA6a6bf6h4KPh7ieNzbcZWqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEqaK79/iyoOFtczA59CNomPIvglXE2UjnU/IeLwJlWNil05zEV3xrYY/DYXco7ytWnsomcaZBJkULqKDNmxPImoMOi7ikX5DRwIiFn1xbrJSGoOv1OX+gmrmrogGcNPixAfdmg/Y+OFDdTi7Ue967TySXlJOwtDY5C/oxk+d+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=de+2aBdV; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=KFcpsybEbQCcJVnoCf7kqdbKPGLMpiaYK1Bhi1Tec/8=; b=de+2aBdVgC8g
	Fddz6EMsjFf178DjM97chvd4N1Adc3km4/KSpMjDOdj3gBkDHylJ8PFZwTI4Wo448QhAyco3TtixO
	IAfrpMxWD8Nnmg3+VqZphTW3YOoCwsMiNDOIKo3ucU8CzoD0jVUqnJED/+PryFj2tVv3BfJ/eYp/8
	3Wxhk3S+p+c5Nj+I/khAhDOBTNFW2Z0ABR/F3qvONoAaxeS8IPaz8kO9S/S0R/rvrkP5DhLquVbFB
	iuzmLd0SQbwW0Dp2MnEdKCoBVfLSc2C1MrGkh2P8aV0aI7s9Gww+zcG2rVH6QvkikD5JYtmEEVY3U
	TYw/r53ivNsADweJ5JEurQ==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vkru4-0080TU-20;
	Tue, 27 Jan 2026 23:51:50 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60RMq0fm304399
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 22:52:00 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60RMpxdE304398;
	Tue, 27 Jan 2026 22:51:59 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v2 4/5] selftests: net: run pmtu.sh in netns to avoid host firewall interference
Date: Tue, 27 Jan 2026 22:51:33 +0000
Message-ID: <20260127225134.304362-5-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127225134.304362-1-aleksey.oladko@virtuozzo.com>
References: <20260127225134.304362-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254030-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:email,virtuozzo.com:dkim,virtuozzo.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pmtu_wrapper.sh:url]
X-Rspamd-Queue-Id: 2398B9B408
X-Rspamd-Action: no action

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
index ce65763e74ef..f84f7111adf9 100644
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


