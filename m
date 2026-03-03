Return-Path: <netdev+bounces-263020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDTmC01SpmkbOAAAu9opvQ
	(envelope-from <netdev+bounces-263020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:15:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8B1E8627
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EF313064163
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303AD37DE89;
	Tue,  3 Mar 2026 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TBRG1ocm"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5037CD5B
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507652; cv=none; b=pxocX9l4zottAjxKrcZGUw8XFolCJgT8o2qknG8n2ComeJ1StvbAA/py0q4TENBdTDxj5Nh5SO+AJf8QkO+5IlXIVL5ji9YnET8GauL1gAeOQ67yttVMN2y+sg9W6trjZrmJwMM3IKhDcFoZuWvME9rN4PANrFupSI9PHjux1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507652; c=relaxed/simple;
	bh=g0zsyX5L4EjBrrYoCc53vN2N/abj8Y7XpyE4Qa9FYoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ0lZJss3V6cueWwdqVMC/Mw9XtYoGrXC4esQKLk2IdPmMkhXJMfNPASAdPKj8/Jc/v2Qvvatg48ikNXHikaQaUFHSbK0A0H6ncCtxKxwZqsbltOk1COWnbekak+sVJy+A9Hh2jevBbUom5+QwGopx8BKPaCdmWMudYKY/XwAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TBRG1ocm; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772507648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pya4KvUPnvgrc1pzLQK2NnEUBs5WZG3BUAj2N7xy7TE=;
	b=TBRG1ocmDMDIs32tTlSpGaW/vxUxiqtDFm/1EAYS5bnDLabf44SzGa029DRcX+LIY+tBS7
	jp+od9Fp1iwHFXS4UZayvYCJBBiCc+Did1vVhURCBfbkoX1s4EoNCZc5Zj3eofakL9zJqQ
	KglecdUEb9XT3yY7ALXwtXXqBM4BQfs=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuna.chen@linux.dev,
	jiayuna.chen@shopee.com,
	idosch@nvidia.com,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 2/2] selftests: net: add test for IPv4 route with loopback IPv6 nexthop
Date: Tue,  3 Mar 2026 11:13:15 +0800
Message-ID: <20260303031318.339716-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260303031318.339716-1-jiayuan.chen@linux.dev>
References: <20260303031318.339716-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E4F8B1E8627
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263020-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,shopee.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Add a regression test for a panic triggered when an IPv4 route
references a loopback IPv6 nexthop object. Without the fix, this
sequence causes a NULL pointer dereference in __mkroute_output()
because nhc_pcpu_rth_output is not allocated for the nexthop.

./fib_nexthops.sh
Tests passed: 249
Tests failed:   0
Tests skipped:  2

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


