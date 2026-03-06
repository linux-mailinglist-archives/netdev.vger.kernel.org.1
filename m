Return-Path: <netdev+bounces-264592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIpfNvsZqmkqLQEAu9opvQ
	(envelope-from <netdev+bounces-264592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:04:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB0219A8B
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2930D30D0B2C
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 00:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA504224AF7;
	Fri,  6 Mar 2026 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ckrkB93l"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6AA1F3BA4;
	Fri,  6 Mar 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755307; cv=none; b=gLcp83zAaGSWOjsx/2mltZVV8QPgbxQYBcwzu/aPo2fLePTS8iiAGfpf2cnL2F8limiM4lUbTf6Q2R7TxgszpJj/t1uOSEUcTo8XOkZ3lH+IYPZY+rzNhyr1RKl6OJFhzlfAEebW4q6EHcZyDJzsIPhdlyAdYvICl7yfoQV+Tok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755307; c=relaxed/simple;
	bh=F5R/HzOo+2aYhyz7WWmZaiSz/+GLsAEzEoVVbmjeyDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAcfosE3tPFmOd8DcxHcjU3Z1n6hIdO446fCTGrH95W/iAuUKV1OQk8BoIsBR5x9h4FEqQqzvIFSRMY+OekyY7QaT9E7suJ/lWRDsE+pbVurKdKkijXkyL2slKcAtkB5nbUSjDCQxqZdrLT6UUnqxttcqmyrpSCErBmwkNEzJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=ckrkB93l; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=1Ng2JCLkEw+qHZebwe8cQikws2towcWTqyU4dFvUKMw=; b=ckrkB93lqeKR
	97mNnTLZFUgP+AMCA+X9WiIUT+vqRPa9vglRCN1kdmcS6GP58oZPlnepVt2gXdb/huLIvzFw4emfl
	wjIfu59zvuni67x4/GUsaaWnwoqPY7Z8enP9DHCxfGP+prKpY4YGP5EK+ud2zsI1A1eYK7wwihLuf
	LAfxmZGszNsgBG9kCPpGK4jfMKlVl6STPARx4T1+9COco67/pAnMYIK/pXUBpiTmVlf0woJ0zggcs
	5zMS9OBVvbxdveH955vd5FVkzY7bbG3yioC/9mhRQK6Ranbb3YfgIJYYK0hfSp5UDkZM6GBbdlyC4
	emowW0x2+p4r/8BsO8vs4g==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vyIbm-006Foq-1C;
	Fri, 06 Mar 2026 01:01:29 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 62601VXc519087
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Mar 2026 00:01:31 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 62601TkU519086;
	Fri, 6 Mar 2026 00:01:29 GMT
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
Subject: [PATCH net v3 0/6] selftests: net: fix false failures due to missing features and host interference
Date: Fri,  6 Mar 2026 00:01:21 +0000
Message-ID: <20260306000127.519064-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 49AB0219A8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264592-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pmtu-test.sh:url,pmtu.sh:url,ovs-dpctl.py:url]
X-Rspamd-Action: no action

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
3,4,5. Move reuseport test into dedicated network namespaces. This prevents
   failures caused by port conflicts with host processes or interference
   from host firewall rules.
6. Ensures io_uring is enabled via sysctl before running io_uring_zerocopy
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

Aleksei Oladko (4):
  selftests: net: fib_tests: skip rp_filter test if cls_basic is
    unavailable
  selftests: net: make ovs-dpctl.py fail when pyroute2 is unsupported
  selftests: net: rename pmtu.sh to pmtu-test.sh
  selftests: net: io_uring_zerocopy: enable io_uring for the test

Konstantin Khorenko (2):
  selftests: net: run reuseport tests in netns to avoid port conflicts
  selftests: net: run pmtu.sh in netns to avoid host firewall
    interference

 tools/testing/selftests/net/Makefile          |   13 +-
 tools/testing/selftests/net/fib_tests.sh      |    2 +
 .../selftests/net/io_uring_zerocopy_tx.sh     |    9 +
 .../selftests/net/openvswitch/ovs-dpctl.py    |    2 +-
 tools/testing/selftests/net/pmtu-test.sh      | 2492 +++++++++++++++++
 tools/testing/selftests/net/pmtu.sh           | 2492 +----------------
 tools/testing/selftests/net/reuseport_bpf.sh  |    4 +
 .../selftests/net/reuseport_bpf_cpu.sh        |    4 +
 .../selftests/net/reuseport_bpf_numa.sh       |    4 +
 .../selftests/net/reuseport_dualstack.sh      |    4 +
 10 files changed, 2531 insertions(+), 2495 deletions(-)
 create mode 100755 tools/testing/selftests/net/pmtu-test.sh
 create mode 100755 tools/testing/selftests/net/reuseport_bpf.sh
 create mode 100755 tools/testing/selftests/net/reuseport_bpf_cpu.sh
 create mode 100755 tools/testing/selftests/net/reuseport_bpf_numa.sh
 create mode 100755 tools/testing/selftests/net/reuseport_dualstack.sh

-- 
2.43.0


