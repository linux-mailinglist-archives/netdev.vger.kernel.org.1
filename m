Return-Path: <netdev+bounces-251640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIMLNSEOcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:22:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D44DB89
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 141E150F7EC
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A53F0773;
	Tue, 20 Jan 2026 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UTYwl138"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244F33B6EA;
	Tue, 20 Jan 2026 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950156; cv=none; b=aBSOHbZpkxLEwl9mlk766sdKON8p6ZcKuhZNbKP2Y2iwfmh8XWNECVrRwK18D0ctLF+d3PeW+t1EOaGw57Aj4ff3lXNmC9V/lTTkvzSNx5dRcYRq+9uptEjLGXqcNsl/ZAGH8pygkL7JZquOnxYirEB8kShFaCi9H2OT61Sy4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950156; c=relaxed/simple;
	bh=J2PrXGpy1pLQl9kSJ2m2J1uMGpMK2jZj4gqH6swdvg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LR7LmrSFdpvX7jKGvB6UwJr4rdtLyik9jXH0Tc5vYDuyk75w7BC7iAMYxoU7c9bdy7jZg+g3VO6O7JfWT9+scwxQOn7YWRj9a9pTzZdHisMFdPWp4PlbN6B5eHynZaBsP7iM7quxPSCbaG9J2ucsxlXuihMlg5loIS9PA+fcfUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=UTYwl138; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=gsaFz6I/pLkw/aWwH2yyMqIImP27kXuxuklnw7KpnUU=; b=UTYwl138lx55
	c4TsfPjgeFivGcDduxFPohI9wnwEzgZJGtWixWNbPW3+7p7iT31l+yUc0kQt0IY6+ZRW1LKlyuo+E
	L6vMQHngvo0KAFZhEv/1ijnBvL0UlxY5SSfU/4QeFAkRlNUedLSrGPgDzS55LlzbK1U4nBEdJ+acv
	jsG6h8Qnum6wGb1JAi+TTMqO+dMu9zXmX+CXYyEqKhHHMgUNyN2ryiRcz1KPAD0A4rfMCg4ZWg7gR
	Wq7NaS0eRu7UBYbrjgFckB+i3kqBVgAdRwxps9m3UyKTjoQJqlqu0ReNuDpTeEWzZqqj0ufzRPj5O
	YwAclkjXjftklnNjqKT8kA==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1viKjW-00Fh60-3B;
	Wed, 21 Jan 2026 00:02:19 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60KN2S9B328368
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 23:02:28 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60KN2R1o328367;
	Tue, 20 Jan 2026 23:02:27 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 2/6] selftests: forwarding: sch_ets: skip test if cls_basic module is missing
Date: Tue, 20 Jan 2026 23:02:04 +0000
Message-ID: <20260120230208.328337-3-aleksey.oladko@virtuozzo.com>
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
	TAGGED_FROM(0.00)[bounces-251640-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,virtuozzo.com:email,virtuozzo.com:dkim,virtuozzo.com:mid,sch_ets.sh:url]
X-Rspamd-Queue-Id: 799D44DB89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The sch_ets.sh test requires the cls_basic kernel module to function
properly. If the kernel is compiled without CONFIG_NET_CLS_BASIC,
the test fails instead of being gracefully skipped.

Add a check to attempt loading the cls_basic module. If modprobe fails,
the test will be skipped.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/forwarding/sch_ets_core.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/forwarding/sch_ets_core.sh b/tools/testing/selftests/net/forwarding/sch_ets_core.sh
index 0453210271dc..ff3ac3e43c33 100644
--- a/tools/testing/selftests/net/forwarding/sch_ets_core.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets_core.sh
@@ -98,6 +98,7 @@ classifier_mode()
 {
 	echo "Running in classifier mode"
 	ets_delete_qdisc
+	modprobe cls_basic || exit $ksft_skip
 	ETS_CHANGE_QDISC=ets_change_qdisc_classifier
 }
 
-- 
2.43.0


