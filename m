Return-Path: <netdev+bounces-265591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCf/D67mrmlfKAIAu9opvQ
	(envelope-from <netdev+bounces-265591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:26:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6423B9E3
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87CBE321D49E
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0AE3DFC89;
	Mon,  9 Mar 2026 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="N16O0awR"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BFF3CE4B2;
	Mon,  9 Mar 2026 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069640; cv=none; b=rzTdV+8UQUrGIBDD06xdO7mQAX/vk0UU5HKQxPPPZbO2j/sy9tn2gDMsbidat/yYHQUQ49atnbsg9dsyl0tYPfzx7nKmZQQZ8XHzF2z6f+H1h7E2EFn3mLxhAS45InmWPcy7FdEF17KCrdLZGaGhSkXdc8O6TgqDiRgu1o4nF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069640; c=relaxed/simple;
	bh=y30ItdlDiXroLPPL9UoZq2MYbzDl9/X7mDaprO+A4j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z05FNFZnPZ3nfjKBeIID/rUKxwnp7A1VaIkr8seOxKzutleK7kbH1S/elDyhrjRKypau10HjRPgP7ls6QardVGkOA5Q4rhmnJvGAk8HBpkckTeYmr+FvSkoY9sLJwRrgOJ2ESvzKbR7S+KlodVZHtlhnPZHFaON2FAVCfL9Hxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=N16O0awR; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=SQcC4wUPkVhzHGo+Ki6zloWaUldoEUcF03QYWsdomuo=; b=N16O0awRUUY9
	+aBa1dbBqcF5sO2z3fW0NIypMhl8+T88B2Lw5QABnHKxJn7uRB/WPDt1200YmvN7LHT0aYQjVhVMy
	L1F6yygRVlx2tl7s6gSftn3xt4aDMerbKqAP161Y4BM2FaXdEb64206z71LIZCeNt58FiQK0tiFX+
	8WoVJJZ2sXMdcCrodUHv9CV2r0ny3e6sBnh7DkzS36yoaf70GyA/KDXdtio2LWlj45NkIEcMRK3Ud
	CsnBvXQLmF9xLZykGNMUDUTue4Z/sqytzbC2sdfj+lT7di95uYcqgQUIlbkOG/0YKvXxnuuOZMrOM
	4rAcCNvZ5W521mXjCG+aOA==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vzcNS-006Tet-2I;
	Mon, 09 Mar 2026 16:20:09 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 629FKGDa565237
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 9 Mar 2026 15:20:16 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 629FKEHT565236;
	Mon, 9 Mar 2026 15:20:14 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>,
        Ilya Maximets <imaximet@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@openvswitch.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH net v4 0/5] selftests: net: fix false failures due to missing features and host interference
Date: Mon,  9 Mar 2026 15:20:08 +0000
Message-ID: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ABB6423B9E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265591-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,ovs-dpctl.py:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pmtu.sh:url,pmtu-test.sh:url,in_netns.sh:url]
X-Rspamd-Action: no action

Hi,

This series addresses several issues in the networking kselftests
that cause false-positive failures depending on the host environment,
kernel configuration, or library versions.

The main focus of these changes is to isolate tests from the host
environment (using namespaces) and to ensure proper fallback or
skipping when dependencies are missing.

Summary of changes:
1. Fixes ovs-dpctl.py to return a non-zero exit code when pyroute2
   is too old. This allows pmtu.sh to correctly fall back to ovs-vsctl
   instead of assuming the configuration was successful.
2-4. Move reuseport test into dedicated network namespaces. This prevents
   failures caused by port conflicts with host processes or interference
   from host firewall rules.
5. Ensures io_uring is enabled via sysctl before running io_uring_zerocopy
   test, preventing failures on systems where kernel.io_uring_disabled
   is set.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>

Changes in v2:
- Fixed a typo by adding the missing backslash in Makefile
- Added a Fixes: tag to the appropriate commit as requested
- Link to v1: https://lore.kernel.org/linux-kselftest/20260120230558.328423-1-aleksey.oladko@virtuozzo.com

Changes in v3:
- renamed pmtu.sh to pmtu-test.sh and used pmtu.sh as the name
  of the wrapper. 
- since the test now runs in a dedicated netns, updates the ovs
  test case to correctly move network interfaces into the target
  namespace.
- Link to v2: https://lore.kernel.org/linux-kselftest/f7t1pj9v8h7.fsf@redhat.com/T/#t

Changes in v4:
- dropped the patch "selftests: net: fib_tests: skip rp_filter test if
  cls_basic is unavailable" since the test environment is expected to
  have all mandatory config options enabled.
- moved isolation logic from in_netns.sh wrapper to unshare() call in
  reuseport_ tests
- Link to v3: https://lore.kernel.org/linux-kselftest/20260306000127.519064-1-aleksey.oladko@virtuozzo.com/T/#t

Aleksei Oladko (4):
  selftests: net: make ovs-dpctl.py fail when pyroute2 is unsupported
  selftests: net: run reuseport in an isolated netns
  selftests: net: rename pmtu.sh to pmtu-test.sh
  selftests: net: io_uring_zerocopy: enable io_uring for the test

Konstantin Khorenko (1):
  selftests: net: run pmtu.sh in netns to avoid host firewall
    interference

 tools/testing/selftests/net/Makefile          |    1 +
 .../selftests/net/io_uring_zerocopy_tx.sh     |    9 +
 .../selftests/net/openvswitch/ovs-dpctl.py    |    2 +-
 tools/testing/selftests/net/pmtu-test.sh      | 2492 +++++++++++++++++
 tools/testing/selftests/net/pmtu.sh           | 2492 +----------------
 tools/testing/selftests/net/reuseport_bpf.c   |   11 +
 .../testing/selftests/net/reuseport_bpf_cpu.c |   10 +
 .../selftests/net/reuseport_bpf_numa.c        |   10 +
 .../selftests/net/reuseport_dualstack.c       |   11 +
 9 files changed, 2547 insertions(+), 2491 deletions(-)
 create mode 100755 tools/testing/selftests/net/pmtu-test.sh

-- 
2.43.0


