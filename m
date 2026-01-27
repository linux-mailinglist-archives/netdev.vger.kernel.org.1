Return-Path: <netdev+bounces-254028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOzyEZtBeWmAwAEAu9opvQ
	(envelope-from <netdev+bounces-254028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:52:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D779B3CD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09FA302866A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1282E92B7;
	Tue, 27 Jan 2026 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="saPOUfTH"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262923D297;
	Tue, 27 Jan 2026 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769554326; cv=none; b=i12lD8wWnvo9opSe+A2eMLPPUc7JzFWgrgwQk/uZSStxoX23Oux9hquIw1XKJfC/TIfdjibqKO0kN/l3+AGMEBwevhIGqAX6z26G/uZC6HK9dOBvkuKOtB/omJTGSBXCZYVi5JO6OcTNSlTcnKVSS+VddAV4xAA+2lpC3xOI0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769554326; c=relaxed/simple;
	bh=mIZg6LyAQ5YLRYCvmDB1mT2AHmhvCBdfgRYz3Jhgt6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/kzPcWgcU1HWqoUHI1XXey5Vmvbu3P0/0KoJCVc6mY71caaU9fp4OEOc1yg5er8/hV646OTONBDA7fpO32nAOH0KiiosvPVv8L3aTHztJL5eTmI5P6EbLU0ufjLL19edGrx+/tNtFMSRfpmEmBxFIT4k0NTxwfShaT0n+2pHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=saPOUfTH; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=8dIBwwgRdF0bXQt/KiXpNGJQK1PK9H5//g4wCSNy9ag=; b=saPOUfTHinNi
	GvHyiwwUAlqttTIvTrrIukdZAgYYVQ5+GH0cY36F1Bjle465h8HUKfoVdX2dchHnH4pYBJbQw9B77
	veXGPhivF0bO+ehhRXyT17l0ZLTG3OUZPIxcngi5CVjjdsmMTN2oApBgKdZRoX9G1TQ5NuFdWjn8I
	KaTNnV9n6zyJAYE/m2kpSV9k5B5alwagG9ArBKfBfcloMX3ltabXxvImse1Io3+9gJsj2oR3bfTbT
	pCFlbR/jJGVVTKzbPC3OwKUvHjtKbbVTDfcWrYcnyJwruVk3zMjFr4HmSj3zFRuRPpC2yjKR6b2Zw
	GAmZNB7u5bmsIL1lwPhVNg==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vkrtu-0080T1-29;
	Tue, 27 Jan 2026 23:51:40 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60RMpoqd304387
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 22:51:50 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60RMpnYw304386;
	Tue, 27 Jan 2026 22:51:49 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH v2 1/5] selftests: net: fib_tests: skip rp_filter test if cls_basic is unavailable
Date: Tue, 27 Jan 2026 22:51:30 +0000
Message-ID: <20260127225134.304362-2-aleksey.oladko@virtuozzo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254028-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7D779B3CD
X-Rspamd-Action: no action

The rp_filter test in fib_tests.sh installs tc filters using the
"basic" classifier but does not verify the corresponding kernel
module (cls_basic) is available. On kernels built without
CONFIG_NET_CLS_BASIC, the tc command fails and the rp_filter test
is reported as a failure.

Add a check for the presence of the cls_basic module and skip
the rp_filter test when the classifier is not available.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/fib_tests.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index c5694cc4ddd2..fa58f9b6bed0 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -441,6 +441,8 @@ fib_rp_filter_test()
 	echo
 	echo "IPv4 rp_filter tests"
 
+	modprobe cls_basic || return $ksft_skip
+
 	setup
 
 	set -e
-- 
2.43.0


