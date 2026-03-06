Return-Path: <netdev+bounces-264590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBDaBGoZqmlfLAEAu9opvQ
	(envelope-from <netdev+bounces-264590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:01:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B570D2199FB
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D288C3014A14
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 00:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4C1D5141;
	Fri,  6 Mar 2026 00:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lYgFzp+v"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD417BED0;
	Fri,  6 Mar 2026 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755303; cv=none; b=ngYueTqeAg/Zd6Z+eZ6R7BYQerSaopQ7C8Tr3u1SG2EVJf7CYSm1pGMuxRhioFGLJ/AWgYJu5cyCoGczrpqDHGjpRsyIhK2RnG2mHncJqco8vsOhHup3XqSZ3e4sfSFt1H1aOSi35BrseJOMjyvF1xkD58Wzoowls37EokLBppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755303; c=relaxed/simple;
	bh=mIZg6LyAQ5YLRYCvmDB1mT2AHmhvCBdfgRYz3Jhgt6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bun4JkePBdfv3UMN8VHLVhQHb8W/8iW/nLljjy/eUh98npkD5Bf+EBFp0qC52EY+Sz2diZgH9AEx307RhCe4Zt0kNVhACsLkBclzLtLyFYwmk2AkMS2aE8/5OEFxuxtvUQ/u6hG/WEcqfx2H39k6fcPMPs6wJetMLDhnPUGCXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=lYgFzp+v; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=8dIBwwgRdF0bXQt/KiXpNGJQK1PK9H5//g4wCSNy9ag=; b=lYgFzp+vz8bV
	jRIFRxHPef/AbXW9/p++zVXQSlf4cx8lCeiDXXzeGOJczHb0fCHQSdmyHjWPfUj5M8We2fU76s0LW
	z8+zohTzZ8RZw0piuzVsN96EoD3qnn0X8UAmTW0ZkkAWPxxBGazF0UoR/fEyAySDkfV17ukUI/F8G
	VIzNQXIMHvUEn2crLmgZOMfu9C9ryJU4pMQ8QjVvHdAP2VcblnDzV/L/zM8X7HBPOcvpvmAg50PuC
	O2hRX/+bi9otBy0euIi58Nd53CVkBhyWdaN6zNvMZa9PBPSXMbaMJzayri2reWd9e+Lv8hYYz35UC
	JO+jyRwahhB9fhMgwKxkkQ==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vyIbn-006Fos-1v;
	Fri, 06 Mar 2026 01:01:30 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 62601WJB519091
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Mar 2026 00:01:32 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 62601WXt519090;
	Fri, 6 Mar 2026 00:01:32 GMT
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
Subject: [PATCH net v3 1/6] selftests: net: fib_tests: skip rp_filter test if cls_basic is unavailable
Date: Fri,  6 Mar 2026 00:01:22 +0000
Message-ID: <20260306000127.519064-2-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306000127.519064-1-aleksey.oladko@virtuozzo.com>
References: <20260306000127.519064-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B570D2199FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264590-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,fib_tests.sh:url]
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


