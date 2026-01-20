Return-Path: <netdev+bounces-251641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHBDK1wOcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:23:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 420964DB9F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7562B4DD2D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD4740B6D6;
	Tue, 20 Jan 2026 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m6kQw8MU"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296543EFD35;
	Tue, 20 Jan 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950158; cv=none; b=NQzlWqYxoQtNydQVw3q1HfqNg9eunOUI78JVbFrolaEbDBhhdOFW8ksibKdl02bpsfGB/yleAG3apZlLUhITPkITyXjrCNFzAjI6pBJEnxJ9FnShYI7NxzdF2mwoUBChPlvlos/Y4NOhPoYg2/12QymoWGmdJnK4kS8dnFJ+MkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950158; c=relaxed/simple;
	bh=1cE5Q+qCzFeRecZEJg0DPLGLMO7Igf/N3wb2+0LRfqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoTb5JjXNIADKbkYv8sZ4rWeHDRC+2mRTAWcQV7zi1LefJL+LVeMqRAPbX2I9Llfxb9pNVTQBz1IIaT5qDJJHcWiP7fAJOvx6aSc0Kg/1AFhnTku+gJb8pe611VwLiLAr/xHjUcs7+y2PLVn3sCy7VEOVUm6PyJiUejls9U+nfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=m6kQw8MU; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=eHCuxOToLaaRCzh21nUsxbUTmt/pR8HS2KcqmI4jslg=; b=m6kQw8MUkMEJ
	yjL3UIow41740tUhfjPW80QKFrzwR+8M12XJjGg9vwRz8Qh+4/2a/ZD0As4jlFUBmCRu2Q64Fv2N8
	ZteFgznAPnTKI7Gwsp6YoFH61RGF4X2/vm4Kms6yrE+kSOy6r7vU6UJPRMVdNO4AKIpN9okPBXCui
	Gu2WAF7k0zn9otbUSEYb3qOddRU7R62BYOqq29Ehyge5oo7a2vAkHWYP+RIZsbBmYTFpyemRfl4hD
	E9v6qzh6LJq9I0erBJoirRnQyLWitltoOvVMEWInmpUYOTQ2bIsCsV5XAUs02hcUwfqMZ7eRGkNV3
	yEvyiiOX91LPz3PsKI1Saw==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1viKjY-00Fh69-1e;
	Wed, 21 Jan 2026 00:02:20 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60KN2TTT328372
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 23:02:29 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60KN2T7T328371;
	Tue, 20 Jan 2026 23:02:29 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 3/6] selftests: forwarding: lib: add run_cmd_grep helper for feature probing
Date: Tue, 20 Jan 2026 23:02:05 +0000
Message-ID: <20260120230208.328337-4-aleksey.oladko@virtuozzo.com>
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
	TAGGED_FROM(0.00)[bounces-251641-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 420964DB9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In some forwarding tests, it is necessary to check for features or
specific keywords in command output before proceeding.

Introduce the run_cmd_grep helper in lib.sh. This helper executes a
command and searches for a specific pattern in its output.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 0a474b02371d..dcf17c19ad77 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -2163,3 +2163,22 @@ has_unicast_flt()
 
 	[[ $promisc == 1 ]] && echo "no" || echo "yes"
 }
+
+run_cmd_grep_common()
+{
+	local find="$1"; shift
+	local cmd="$*"
+
+	if [ "$VERBOSE" = "1" ]; then
+		echo "COMMAND: ${cmd} 2>&1 | grep -q '${find}'"
+	fi
+	$cmd 2>&1 | grep -q "${find}"
+	return $?
+}
+
+run_cmd_grep() {
+	run_cmd_grep_common "$@"
+	rc=$?
+	check_err $rc
+	return $rc
+}
-- 
2.43.0


