Return-Path: <netdev+bounces-251642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cObeM2sNcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:19:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 404BF4DAE9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CA38B4E9AB
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182CC40FDAF;
	Tue, 20 Jan 2026 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gb3x8bac"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA840B6E9;
	Tue, 20 Jan 2026 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950160; cv=none; b=mShUd29ioOI/ZLE+HT8u5svoMDtCmT4jwd+Omr94SvWwDMAMRp3m6Pk1Q1o+eh4C3rd6mF1983oLeZXmeaPcL+IddkNQdZou5fwEVkaZjwnm52poDMYdqhSnSfpCX7Dda2XDsg/y6x4xudJxSUgKxm5/pPgKF/mu328Do2HG3vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950160; c=relaxed/simple;
	bh=uaKPuSPCTmKqFEglb9Ynhb27mSJkH1HQt5gXpGAWXxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rd9vwD1F7NYxongHr4Gc5/5R8e+IJ6I5pNQFqC2O1Y+pMjGVAROIVcy8FPREIddLBUd6bucBwN4JwKcOGIx2wgCC38Z28H92tl0E+KkVe454mZZYkVdYmLwUFUzszQwF7NuZLwbVU9L5T6ymbDObLapGQy7NYsfBW+WGcpzXLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=gb3x8bac; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=KKX0mNLTijdouMrVgWumsUt3u8mgh2Z9iuCZGTIqXgQ=; b=gb3x8bach6aS
	T8mdjxMemmWX47sDNjVHdUWmAf4kac78jClePlDdac40S+U7oSc6SEfWnPwMJ5tp7m4GV00YHpT0m
	1gj07Uf5FUdHkiznc+G2ZiZ2VoWfKZcyvZzFfElpnfjItdKcAqqLXlX9LAUFf6JahjxlOPP3jPc+w
	3ggz0BgwGqqXU1LxsFh5ktM1Y/nJihnArSoKUDEsPfgl5Gzqlne7pY5F9oN25XFa2KFX9YSqeKnfL
	CEMeS0fmM60mJpL/hZ8FgBFd43NGNXA9brVNx6GbUtR4JfI8vAy1/elaFlNplNlcx4W/TD4WfuiRn
	O8/o6qok5EEZf/5FqFwVbw==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1viKjb-00Fh6W-1P;
	Wed, 21 Jan 2026 00:02:23 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60KN2Wfd328380
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 23:02:32 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60KN2WRB328379;
	Tue, 20 Jan 2026 23:02:32 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 5/6] selftests: forwarding: tc_flower_l2_miss: skip tests if tools or feats are missing
Date: Tue, 20 Jan 2026 23:02:07 +0000
Message-ID: <20260120230208.328337-6-aleksey.oladko@virtuozzo.com>
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
	TAGGED_FROM(0.00)[bounces-251642-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,virtuozzo.com:email,virtuozzo.com:dkim,virtuozzo.com:mid,tc_flower_l2_miss.sh:url]
X-Rspamd-Queue-Id: 404BF4DAE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The tc_flower_l2_miss.sh selftest assume the presence of iproute2
support for the `l2_miss` keyword in `tc filter` commands. These
assumptions can cause test failures.

This patch improves test robustness by skipping the test if
tc filter help does not mention l2 miss

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh b/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
index c2420bb72c12..c28569b8948f 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
@@ -347,6 +347,8 @@ cleanup()
 	vrf_cleanup
 }
 
+run_cmd_grep 'l2_miss' tc filter add dev lo ingress flower help || exit $ksft_skip
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.43.0


