Return-Path: <netdev+bounces-278055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGcEBnzX3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:46:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A1C3EB77F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF6CF300AD4C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027A21D88B4;
	Mon, 13 Apr 2026 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hbArPeTk"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69274325705
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080743; cv=none; b=fdK2OxvHzBTkmKbMIVEK6d/jy7/NUuodW5qwmm0sfroA4lYzTlQMapEE5+WFb6jiWDotWAnzqUpxAajsqp7xfLNjy3cZCpndPEk11eh9mv1mFQWh55AYK6+aW+lLHEX6T15NoE/mA7XTAOhosCLQnBzmBClUjLOq3VtiHGE+VM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080743; c=relaxed/simple;
	bh=hCJh4/UwcFIBqciPag1pRPDPGv/I08GrFXiSqV+a7Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4XPF79qxJ0qeIk98douMZDF2GqW1mmt446PONUvOsWo1n5gRmkcVat8LqU+Rmku9Ff6AAAbwPIdklz+R/QT67GtOaHKvKevXkFxXdZoxkhqWGlV73ie/9xgPaLywiIx+kVkGnvQtBTyeaI75jMalWfxWIVaj7StYp3X7Qc7uP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hbArPeTk; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776080740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36p91HX2vO7swSdum+9wp3akDB7giTjH3rDrZvdJPNQ=;
	b=hbArPeTkquh5qEo4eshnKgGOvtVQ6I4ZF8efrZi5JyoXvK/OsVmJcRKx8+493m5DwpqcVq
	kX9RB+cnLxiKf74zbJeQCCkDHS4T+ceapclKI7lf46wCdjGAv9+7jf+IWuMEoYlJz76Mrt
	rL4lBoPeFdqDP0rESR5j+DChfutA0EI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v1 2/2] selftests: fib_nexthops: test stale has_v4 on nexthop replace
Date: Mon, 13 Apr 2026 19:45:20 +0800
Message-ID: <20260413114522.147784-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260413114522.147784-1-jiayuan.chen@linux.dev>
References: <20260413114522.147784-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278055-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: D9A1C3EB77F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add test cases that exercise the scenario where an IPv6 nexthop is
replaced with an IPv4 nexthop while being part of a group. The group's
has_v4 flag must be updated so that subsequent IPv6 route additions are
properly rejected.

Two cases are covered:
  1. Gateway nexthop replaced across families with an existing IPv6
     route on the group (rejected by fib6_check_nh_list).
  2. Blackhole nexthop replaced across families with no existing IPv6
     route on the group (fib6_check_nh_list returns early) — this is
     the path that triggers a NULL ptr deref without the kernel fix.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/testing/selftests/net/fib_nexthops.sh | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 6eb7f95e70e1..ac868a731694 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -1209,6 +1209,28 @@ ipv6_fcnal_runtime()
 	run_cmd "$IP ro replace 2001:db8:101::1/128 nhid 124"
 	log_test $? 0 "IPv6 route using a group after replacing v4 gateways"
 
+	# Replacing an IPv6 nexthop with an IPv4 nexthop should update has_v4
+	# for all groups using it, preventing IPv6 routes from referencing the
+	# group after the replace.
+	run_cmd "$IP nexthop add id 89 via 2001:db8:91::2 dev veth1"
+	run_cmd "$IP nexthop add id 125 group 89"
+	run_cmd "$IP nexthop replace id 89 via 172.16.1.1 dev veth1"
+	run_cmd "$IP ro replace 2001:db8:101::1/128 nhid 125"
+	log_test $? 2 "IPv6 route can not use group after v6 nexthop replaced by v4"
+
+	# Same scenario but with a blackhole nexthop: the group has no IPv6
+	# routes yet when the replace happens, so fib6_check_nh_list returns
+	# early without checking. has_v4 must still be updated to block
+	# subsequent IPv6 route additions.
+	run_cmd "$IP nexthop flush >/dev/null 2>&1"
+	run_cmd "$IP -6 nexthop add id 90 blackhole"
+	run_cmd "$IP nexthop add id 125 group 90"
+	run_cmd "$IP nexthop replace id 90 blackhole"
+	run_cmd "$IP -6 ro add 2001:db8:101::1/128 nhid 125"
+	log_test $? 2 "IPv6 route reject v6 blackhole replaced by v4 blackhole"
+	run_cmd "ip netns exec $me ping -6 2001:db8:101::1 -c1 -w$PING_TIMEOUT"
+	log_test $? 2 "Ping unreachable after rejected route"
+
 	$IP nexthop flush >/dev/null 2>&1
 
 	#
-- 
2.43.0


