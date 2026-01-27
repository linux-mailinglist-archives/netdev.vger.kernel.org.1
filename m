Return-Path: <netdev+bounces-254029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM+9I8BBeWmAwAEAu9opvQ
	(envelope-from <netdev+bounces-254029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:52:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 049459B401
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F34430432EE
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B162EBDC0;
	Tue, 27 Jan 2026 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UxiOGLfz"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325061D9346;
	Tue, 27 Jan 2026 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769554326; cv=none; b=m89bOmXXDB5Uw1h7i/7MEDko4ZeRV0FmWbrUMMZcNp/FEVXFzvRMUhhaCMfk0vC8niDus6Vs3/VR5RRjFsejAQoi3vmixiXJjZZbBxQOHvuzMtdwMOCezwKTv193yqERvnZWnG2tuXG+C1uFYgINraDvxvIzf0mE5II+egTNHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769554326; c=relaxed/simple;
	bh=vtxknKF/ZXq5o33bB0vF38r/1onhLX3epf6M5aavci4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JiT5PTU0sSgV7f5FQF04kN02kbu6x8QGdItBKDzw2+Y3SylrNc39Tmn1MaEjpqlXeGwCi/ypO9lHG0Yrfnz+enKl6veWmgXxn4mx98Mi+sJyhHjLUogqLo6XvydwEm4PU9uPz/bWt7XpAroaHq3feduq+I/ab2633sbdc3Kp6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=UxiOGLfz; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=Ld3ED09LEVDRnegWuYHO03LTqeQQlpZJYm4QJKr3ODk=; b=UxiOGLfzoYwL
	3so4yELsm6G9AH6+EJ2jGg6go5knzCzX+LyLMEkISPYWL4cX14DOxBiyVpw6aGhgbkslBGq6480uh
	YLXjUSMWmzimFk+d1L7/Vhx/m1E7G482jySzyuGAhzGOjBFKulOO+hym4aaouegusuRdX4GW8Aamk
	yQZVaEdS2J+BilxA+zwZN9rLg38yB2HUyFoWng40XObfqFgT0DF/zRaZdRmtLTpZxUTj2jnq/ujZd
	9MIOGQ4Con033KILQj41zVjWOJeQkzLRZltw+JFzhb5RnXqCsJq5CGVC2FV5kx0hWPkr60lOwU6mj
	F6rnBU5e5fyVkPJCZonzLg==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vkrtt-0080Sz-1z;
	Tue, 27 Jan 2026 23:51:39 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60RMpmDM304383
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 22:51:48 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60RMpk5N304382;
	Tue, 27 Jan 2026 22:51:46 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH v2 0/5] selftests: net: fix false failures due to missing features and host interference
Date: Tue, 27 Jan 2026 22:51:29 +0000
Message-ID: <20260127225134.304362-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
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
	TAGGED_FROM(0.00)[bounces-254029-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:email,virtuozzo.com:dkim,virtuozzo.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovs-dpctl.py:url]
X-Rspamd-Queue-Id: 049459B401
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
3,4. Move reuseport and pmtu.sh tests info dedicated network namespaces.
   This prevents failures caused by port conflicts with host processes
   or interference from host firewall rules.
5. Ensures io_uring is enabled via sysctl before running io_uring_zerocopy
   test, preventing failures on systems where kernel.io_uring_disabled
   is set.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>

Changes in v2:
- Fixed a typo by adding the missing backslash in Makefile
- Added a Fixes: tag to the appropriate commit as requested
- Link to v1: https://lore.kernel.org/linux-kselftest/20260120230558.328423-1-aleksey.oladko@virtuozzo.com
---
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


