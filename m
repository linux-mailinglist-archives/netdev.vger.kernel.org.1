Return-Path: <netdev+bounces-251639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGZ2GjUMcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:13:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0300C4D971
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA2E8B4D421
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30B13E9F82;
	Tue, 20 Jan 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UOx8uHN9"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876FC3D3480;
	Tue, 20 Jan 2026 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950155; cv=none; b=e55iOdpjKlmTdJ6zURzu7ELWEA1vB59msgRxJvwvmHseYT/dLTqO2/TFma1ZpfjQ3AZYPYuuk8tuQHX1H5Iso5eVbclMBIlQpB4Y8lvjPVLi5/IB/Rqy2iUNcOJo0m094AQ0GrLI3MKWkcdFbrnJ7NC/56ZThLqO/TURQ6oGl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950155; c=relaxed/simple;
	bh=Qzq0EhbZ78DUlnVCDJEwC9dQdZKwxeWeAe1rR0FxzUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfLfPwl5WQcfnx31lpT3AsTyRC0eYUft+e2Y32WIG2vmo1anXHWeXnGiUWmzKDckjgu1OOgCXfSfK8npIXQUjKU0UpWR8C7a9ycXWOomArJirjlLLki/sT69UZ0Q1UhOI30VWUe+lMRWcGn2ga8Ab9euvAjihpTNdbtdvVvM8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=UOx8uHN9; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=8tpR1oMDG6Gq6WVuLMc5q4DQ69hK0HrbFlTunTJ68EI=; b=UOx8uHN9Xx8J
	Lf48hUsTa5yTAWkmXNYnIU+PJi77TxsKFcdIa/maOLUtk/EZek9PLiAdI+BpBFdp9dMJb1Y8mMh+o
	KubWGYpYDsuoqADjzO8XB2cNXEhNl6BIdryNv+XwmJmu3J5/TwmE6JM4y3JsPZ8PTHSwgxrlSOyIN
	99fiCpod3tP42GqCXC26oGKwjqGhGlUycJLOJCpBehDt7JEr9AYVOAyarcNw3qS7aKJE+psOhGwS9
	I3L4UNkil/pGaBcfv7VNkhFDc5PZEsxs08muWgSXWLRy8BUcHd5MNUjKHZaBCpQg8ZUR+hNq4kKgO
	x/kosndmGKqR+o//+O0dug==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1viKjV-00Fh5g-0p;
	Wed, 21 Jan 2026 00:02:17 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60KN2Qb8328364
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 23:02:26 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60KN2QSh328363;
	Tue, 20 Jan 2026 23:02:26 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 1/6] selftests: forwarding: lib: skip test if team driver is not supported
Date: Tue, 20 Jan 2026 23:02:03 +0000
Message-ID: <20260120230208.328337-2-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120230208.328337-1-aleksey.oladko@virtuozzo.com>
References: <20260120230208.328337-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251639-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_POLICY_ALLOW(0.00)[virtuozzo.com,quarantine];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:email,virtuozzo.com:dkim,virtuozzo.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0300C4D971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some kselftests rely on teamd to create LAG devices. If the kernel is
built without CONFIG_NET_TEAM, the teamd command fails with:
Failed: Operation not supported

Currently, the exit code of teamd is not properly checked, causing
the test to proceed and eventually fail instead of being skipped.

Add a check for the teamd exit code, mark the test as skipped
to avoid self-positive failures.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index a9034f0bb58b..0a474b02371d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -771,9 +771,21 @@ team_create()
 {
 	local if_name=$1; shift
 	local mode=$1; shift
+	local output
+	local status
 
 	require_command $TEAMD
-	$TEAMD -t $if_name -d -c '{"runner": {"name": "'$mode'"}}'
+	output=$($TEAMD -t $if_name -d -c '{"runner": {"name": "'$mode'"}}' 2>&1)
+	status=$?
+
+	if [ $status -ne 0 ]; then
+		if echo "$output" | grep -q "Operation not supported"; then
+			exit $ksft_skip
+		else
+			exit 1
+		fi
+	fi
+
 	for slave in "$@"; do
 		ip link set dev $slave down
 		ip link set dev $slave master $if_name
-- 
2.43.0


