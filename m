Return-Path: <netdev+bounces-251644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNgWCF0ScGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:40:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9D84DFA3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AA1366FA4F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9E41B34E;
	Tue, 20 Jan 2026 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QVDKI4A2"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E016410D05;
	Tue, 20 Jan 2026 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950164; cv=none; b=lKQ3fL1vzMxppmk7+pukVPBwC3de6DezSlEeyJzMBOJx+kSU3pNwev92OO9UTBxKDTuUcQ1nnKyZplISeXdACE12pas/vX5BybUv3dHq3fLANYBQwrX6MHVxut6vl4GYJnLqml+UMl6kHGyFnKXXQ8T9SAnknQ4gYZVWpd6PstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950164; c=relaxed/simple;
	bh=Vjbn/gb4cZlIm6Os9TlJNCnlFAc5ESXEKTbzjQUgOg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ck6UtWmxPwxo+nMV5rGCK1clWQR/SnXel2kp4r8O+zzXty5ugdrahYIP+dsWNfg+ukZT4gKoeWiDCAovz2v/hzh/PYUZNRXRdL4YAx37JJ+KLnBOcWCM+hRWuxv5M4ADQs0+vB716cYnZEkUVV9auVN70pza9Il4S6Djzeq60Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=QVDKI4A2; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=h251P67okuH0sc4CUwKqL3Anvu1/8P1pvdAz3glIJws=; b=QVDKI4A2Qkzz
	bkawLJrvscyLuhJ1zxTDMivzeeAv73BMw4mxb9xq1iB8dcBh8UpH3PAW5ypZdU42JWyCUAi84KqY9
	bl7QQ06xCmaFusF98wgo/iho/G5KkLUVL4/YumfL1iJgHgSYoRnmr9/9DsgorzLAgeD/+VE5EmwB/
	LgDebTogAZCvTzuzuxMNR/Ieq4pevN6OSGtBnQfaeHJugHD2sQYcrUhi3VXXrYM7FW0kOaO0XH/+Q
	I5+VQrDP7X+YvdDWvHvsBtFlAE3dLF9HOvmu8mnzyvrMe3tSDAPpJ8ss2Y8UJgLnTLghd32AL9wTO
	viuD6B1zrhuIPDcF0pDG+w==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1viKjc-00Fh6h-30;
	Wed, 21 Jan 2026 00:02:25 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60KN2YQB328384
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 23:02:34 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60KN2Xk1328383;
	Tue, 20 Jan 2026 23:02:33 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 6/6] selftests: forwarding: router_mpath_seed: skip tests if tools or feats are missing
Date: Tue, 20 Jan 2026 23:02:08 +0000
Message-ID: <20260120230208.328337-7-aleksey.oladko@virtuozzo.com>
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
	TAGGED_FROM(0.00)[bounces-251644-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[router_mpath_seed.sh:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,virtuozzo.com:email,virtuozzo.com:dkim,virtuozzo.com:mid]
X-Rspamd-Queue-Id: 9C9D84DFA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The router_mpath_seed.sh selftest assume the presence of iproute2
support for the `hw_stats` keyword in `ip nexthop` commands. These
assumptions can cause test failures.

This patch improves test robustness by skipping the test if
ip nexthop add help does not mention hw_stats

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/forwarding/router_mpath_seed.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/router_mpath_seed.sh b/tools/testing/selftests/net/forwarding/router_mpath_seed.sh
index 314cb906c1eb..d9dc5d3a10d5 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_seed.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_seed.sh
@@ -322,6 +322,8 @@ test_mpath_seed_stability_ipv6()
 			-p 64 -d 0 -c 10 -t udp
 }
 
+run_cmd_grep 'hw_stats' ip nexthop add help || exit $ksft_skip
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.43.0


