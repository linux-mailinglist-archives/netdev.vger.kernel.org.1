Return-Path: <netdev+bounces-263773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP9BGxAbqGmgnwAAu9opvQ
	(envelope-from <netdev+bounces-263773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:44:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C90231FF319
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C0B13165825
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 11:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562B737266F;
	Wed,  4 Mar 2026 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FuQnxeSY"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C4E36AB5E
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624322; cv=none; b=J/mot070638t1+0ALB7pkyaKYFRbmmHvyS5u40LXIzdrCEdABpF1FD2AfopWtgcUEhS/R2EZHgdPEUWofAkX5CWZFdcUu2qE4Ai3vcV1shapqoGmoiwr3GF8Rn8Qzte3/D58LFZzM2OJ6ktdkc8unp5iMHDYbFIeqPM1bUNdwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624322; c=relaxed/simple;
	bh=hYuvfZFIDL2epZbB6+3TRrBKA058KlOCCRxcolYWUiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7TBBTL9579BI2lsWp3AWvdLSDDAGN0vf76HI+gTTgxNi/S2zhdZnFxZKBeOAJuFV3QD9LA1dQEjWa51xV3D4MeVqx66T5VH0dIk/Ij06Cu8nzDu8jjzViDmRzXkYruzHhBOEJpAbNqv8YjXLsMoMHx35Ns9ourZGpUbUYniHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FuQnxeSY; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772624319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODRuQKMggAAl7kuSnucVregyJTgYXXmbngTapckW4oo=;
	b=FuQnxeSYWWRvrIm9SqC4OBL8Hcx7IXArhHXPQD9IJmNvff6yaSumUyvBhReBbCTykwRc1B
	3std9PThFmv2IItlt4Zq+tm+1kwCucl5NilAUdFxZHMADlOrWjx+nnAB7zzePt81e8ueyb
	Y2n/fnSeC+InKXUDglVGUGzDjW7NrSw=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v4 2/2] selftests: net: add test for IPv4 route with loopback IPv6 nexthop
Date: Wed,  4 Mar 2026 19:38:14 +0800
Message-ID: <20260304113817.294966-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260304113817.294966-1-jiayuan.chen@linux.dev>
References: <20260304113817.294966-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C90231FF319
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263773-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shopee.com:email,nvidia.com:email]
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Add a regression test for a kernel panic that occurs when an IPv4 route
references an IPv6 nexthop object created on the loopback device.

The test creates an IPv6 nexthop on lo, binds an IPv4 route to it, then
triggers a route lookup via ping to verify the kernel does not crash.

  ./fib_nexthops.sh
  Tests passed: 249
  Tests failed:   0

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 tools/testing/selftests/net/fib_nexthops.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 21026b667667..6eb7f95e70e1 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -1672,6 +1672,17 @@ ipv4_withv6_fcnal()
 
 	run_cmd "$IP ro replace 172.16.101.1/32 via inet6 2001:db8:50::1 dev veth1"
 	log_test $? 2 "IPv4 route with invalid IPv6 gateway"
+
+	# Test IPv4 route with loopback IPv6 nexthop
+	# Regression test: loopback IPv6 nexthop was misclassified as reject
+	# route, skipping nhc_pcpu_rth_output allocation, causing panic when
+	# an IPv4 route references it and triggers __mkroute_output().
+	run_cmd "$IP -6 nexthop add id 20 dev lo"
+	run_cmd "$IP ro add 172.20.20.0/24 nhid 20"
+	run_cmd "ip netns exec $me ping -c1 -W1 172.20.20.1"
+	log_test $? 1 "IPv4 route with loopback IPv6 nexthop (no crash)"
+	run_cmd "$IP ro del 172.20.20.0/24"
+	run_cmd "$IP nexthop del id 20"
 }
 
 ipv4_fcnal_runtime()
-- 
2.43.0


