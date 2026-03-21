Return-Path: <netdev+bounces-270262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGvGMO4Uv2n3tQMAu9opvQ
	(envelope-from <netdev+bounces-270262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 23:00:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E0F2E7624
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 23:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4507C3024128
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E5436BCFB;
	Sat, 21 Mar 2026 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Nc+7kW0I"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D7307AE3;
	Sat, 21 Mar 2026 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774130374; cv=none; b=ri5bN779kt9NWPbPPlmoRCuHG1SJtkkRaSrhyez4tK8gxNZdYCj0W72MCWWN+w8BvdMZpCTCsP+eMjetsCKmNd80qXjkdvhZAuZOVRCH++oVWFgcgK5UKdXl3+NRb0cumedOu2CEvSqeNUuo2/MpMgGoEbeMwbA/qJFSRPoJ8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774130374; c=relaxed/simple;
	bh=BUbB4pM9SOWbVKAqdWi01xLmiYXU4EkqkFp4dppQPkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFv9boPH+CZn6hgEIH48s6EtzxcakzLgVe3f/F95WNU+JnyAGYv09nvvMvLKxAEuPESObQvb+9jOkjepEvHnInF1XoPZyZ5uhrc19IpRVwttCj2RUaLEHsogszMXmmYNDHUqp8kkEp6hu+SSKKexX/fYZE2w7jNVK8W2DQbdjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Nc+7kW0I; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=J1zGNOWt9SusoSqUv+knriB/jDxlsOa1nJwVKNGQK84=; b=Nc+7kW0IRBth
	Q4sFCZ59Mgb6Dg35+gKRA7D07cfE6NTsHb8RuQZhziQfh2jgxED3U4cbasY2Xq+H0UT59y20+Bzzn
	dKqpYqpnp5WDgwJQmmM4bVpznDzjoRVa78/kWX6q9B18DYcbfSsTFEPfbUUTvNSrReaEvYyFBJx4b
	0WLyZf4nBQEq1CbHSm7NhAiRPI1XJS9Jty03a6vXS16g/rtcVmtrsvUcfZ5t/7+jxr2XBOwGZ5LBG
	hkihQE/8Yd+k9NYahOvLNe+RLTpGNJ9oZNPHOk81lGQqRMetjmEemTcPDVsryTrkFJcDx6HVqz/7p
	lPe/r+G1SqGOoIFfmJ/DjQ==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1w44Jn-001hil-27;
	Sat, 21 Mar 2026 22:59:07 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 62LLxCE0175484
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 21:59:12 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 62LLx9FM175483;
	Sat, 21 Mar 2026 21:59:09 GMT
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
Subject: [PATCH net-next v6 0/4] selftests: net: fix false failures due to missing features and host interference
Date: Sat, 21 Mar 2026 21:59:04 +0000
Message-ID: <20260321215908.175465-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-270262-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pmtu-test.sh:url,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,in_netns.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovs-dpctl.py:url]
X-Rspamd-Queue-Id: 62E0F2E7624
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

Changes in v5:
- changed patch prefix/tag from "net" to "net-next"
- Link to v4: https://lore.kernel.org/linux-kselftest/20260309152013.565216-1-aleksey.oladko@virtuozzo.com/T/#t

Changes in v6:
- rebased on "net-next"
- Link to v5: https://lore.kernel.org/linux-kselftest/20260319103123.146112-1-aleksey.oladko@virtuozzo.com/T/#t

Aleksei Oladko (3):
  selftests: net: run reuseport in an isolated netns
  selftests: net: rename pmtu.sh to pmtu-test.sh
  selftests: net: io_uring_zerocopy: enable io_uring for the test

Konstantin Khorenko (1):
  selftests: net: run pmtu.sh in netns to avoid host firewall
    interference

 tools/testing/selftests/net/Makefile          |    1 +
 .../selftests/net/io_uring_zerocopy_tx.sh     |    9 +
 tools/testing/selftests/net/pmtu-test.sh      | 2492 +++++++++++++++++
 tools/testing/selftests/net/pmtu.sh           | 2492 +----------------
 tools/testing/selftests/net/reuseport_bpf.c   |   11 +
 .../testing/selftests/net/reuseport_bpf_cpu.c |   10 +
 .../selftests/net/reuseport_bpf_numa.c        |   10 +
 .../selftests/net/reuseport_dualstack.c       |   11 +
 8 files changed, 2546 insertions(+), 2490 deletions(-)
 create mode 100755 tools/testing/selftests/net/pmtu-test.sh

-- 
2.43.0


