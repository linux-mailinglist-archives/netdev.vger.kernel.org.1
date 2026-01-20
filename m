Return-Path: <netdev+bounces-251645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFyLFvkLcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:12:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4484D92F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54B373EF9E3
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825A437A49B;
	Tue, 20 Jan 2026 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bqcloqWe"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F49295D90;
	Tue, 20 Jan 2026 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950377; cv=none; b=Z6/OuCrDcRlJ8kKcCyLp9xBbcnq0kZINx8v8ms1HixEwjozz0ghRfcZCgVzE/PDbeSzY2/bRlGX2GR1PFYFXpRH46HRGyR/k/3lhc32nwjpM2oXt9QVshs0W7D37T0x6nsA88wtzL8VUYo6jpo3XmfFIKIv6wkFfwUI6GhtcOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950377; c=relaxed/simple;
	bh=BWR+w9i4lHTE9BoUVM80o24OSUY5ELCL8c3O4LRK2Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9Jt8wqhvnh/+zVME4sKk5vW9uzMUi3For8sBL/R7NFdx+6YOcSyHf7tXmcWzfNY8h/EsGvY6ZWAdRjG+i4Fr3ZcPpKeqzD3YUI6h+7stERo7L43YmLmhDmDKzlIr95zp4O8xrjnGsf5k+9azvCbwTlC1TDmRAnY2k4Rq6OJ6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=bqcloqWe; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=uD3OzJK3U6FJfLW+VQVXnqqRNKs7YhmVzNkwRn6ZJNc=; b=bqcloqWeXZjU
	+igK2zVpqBaea2n1QV9qYUOblviFECyHOIKJu7+h85o/WxOCmhj1TYLAKEyt1wlDICd5vyUy5V5NK
	m/lwkNPzScGdJSIF4qHop63kJZrB/iMZIk3bHTZT5Ya4Bo/o9jx9ngXokyX4qf9JckLwAaLSTZKhw
	zdHvdGC5tqfIufGCY8NLbovsXYLJoeuP48a0E52wDifJpTJNEe51HFR8xaGHuVgBloubg2kt5pSs2
	10SSDolCMUnnQfH3t76ua0ljunCTcwMMNgrOEmQ9PFlUr4JrM6AsfmTClJp/VG0VYD4R0RpmWRUFs
	ocfpUCK6YW3QlI4vKNsuWA==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1viKn6-00Fnsd-2r;
	Wed, 21 Jan 2026 00:06:01 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60KN6ACI328450
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 23:06:10 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60KN6920328449;
	Tue, 20 Jan 2026 23:06:09 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 0/5] selftests: net: fix false failures due to missing features and host interference
Date: Tue, 20 Jan 2026 23:05:53 +0000
Message-ID: <20260120230558.328423-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
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
	TAGGED_FROM(0.00)[bounces-251645-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[virtuozzo.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovs-dpctl.py:url,pmtu.sh:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,virtuozzo.com:mid,virtuozzo.com:dkim]
X-Rspamd-Queue-Id: 0C4484D92F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series addresses several issues in the networking kselftests
that cause false-positive failures depending on the host environment,
kernel configuration, or library versions.

The main focus of these changes is to isolate tests from the host
environment (using namespaces) and to ensure proper fallback or
skipping when dependencies are missing.

Summary of changes:
1. Adds a check for cls_basic module in fib_tests. Without this
   module, the test fails when attempting to add tc rules instead
   of skipping.
2. Fixes ovs-dpctl.py to return a non-zero exit code when pyroute2
   is too old. This allows pmtu.sh to correctly fall back to ovs-vsctl
   instead of assuming the configuration was successful.
3,4. Move reuseport and pmtu.sh tests info dedicated network namespaces.
   This prevents failures caused by port conflicts with host processes
   or interference from host firewall rules.
5. Ensures io_uring is enabled via sysctl before running io_uring_zerocopy
   test, preventing failures on systems where kernel.io_uring_disabled
   is set.

Aleksei Oladko (3):
  selftests: net: fib_tests: skip rp_filter test if cls_basic is
    unavailable
  selftests: net: make ovs-dpctl.py fail when pyroute2 is unsupported
  selftests: net: io_uring_zerocopy: enable io_uring for the test

Konstantin Khorenko (2):
  selftests: net: run reuseport tests in netns to avoid port conflicts
  selftests: net: run pmtu.sh in netns to avoid host firewall
    interference

 tools/testing/selftests/net/Makefile               | 14 +++++++++-----
 tools/testing/selftests/net/fib_tests.sh           |  2 ++
 .../testing/selftests/net/io_uring_zerocopy_tx.sh  |  9 +++++++++
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |  2 +-
 tools/testing/selftests/net/pmtu_wrapper.sh        |  4 ++++
 tools/testing/selftests/net/reuseport_bpf.sh       |  4 ++++
 tools/testing/selftests/net/reuseport_bpf_cpu.sh   |  4 ++++
 tools/testing/selftests/net/reuseport_bpf_numa.sh  |  4 ++++
 tools/testing/selftests/net/reuseport_dualstack.sh |  4 ++++
 9 files changed, 41 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/net/pmtu_wrapper.sh
 create mode 100755 tools/testing/selftests/net/reuseport_bpf.sh
 create mode 100755 tools/testing/selftests/net/reuseport_bpf_cpu.sh
 create mode 100755 tools/testing/selftests/net/reuseport_bpf_numa.sh
 create mode 100755 tools/testing/selftests/net/reuseport_dualstack.sh

-- 
2.43.0


