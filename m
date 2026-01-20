Return-Path: <netdev+bounces-251638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAcWMDAVcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:52:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CAA4E255
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAD30B4D351
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0013EFD20;
	Tue, 20 Jan 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="u4lTxDEx"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8766F3BC4F9;
	Tue, 20 Jan 2026 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950155; cv=none; b=rfLZwVmW7V1JbsxZ/CgSYrN0gi8B04TTQzsBEhfIcoNKTDRk1pPRPnFlLJV9TOtvwrRCYIIrXiSgapDSghXWBFHfZHb2dnalx8psydl4HERrOz8EPDvrPNsByTKXn/vNirOiJgufnRS4CYASFZqpOY3iUPls3Z2Fe3qHbpvexms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950155; c=relaxed/simple;
	bh=7dIGmphmOa9A0XAO6S9InjNv1e/PuEM8Ak4ck95o6IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NziHCx5wUdDqz7/+QuPovr+f3L33jR2S+hGLW225ZGpYlk3cgCL8hxmxsNtmmLgEPTcEhunyV57Uf8dr5bdMnwrUr2Xytv2En2eIHwakhtjkX4I1yiTcXCeAkutv+61+Xpbp2OvcPpooZvKTV+O3Kb6jj6Xen/QUWAyJV7UYOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=u4lTxDEx; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=ZTAtFTgk7uARkJXJYDNwpGg25TMStLOOPYSoCkPmX8Y=; b=u4lTxDExsdK+
	XaSEkYemRQFxwEHrSsHUV1apoYb8Z/Pw+azEasitQJNIeVxbRmhDGhF7KTJN8qoIb4GZn8MST+uGF
	WU6pu6DttzB1/ZUL6RWvUeLsWYmz+T5ysTOtjjY5F0jgT7y1GHff611IljnCPa9v0FyrlV6iHJPgI
	qKy7V2uDF1EVtleHtKzz60lg/sUPCvwnzD4uXLKJhDFB1umuFkGtEj1/MmN5+RX63l7Q8XFxFUTA6
	1VQrCSa1lnkfpEIeTB6yyKKR79Q40Q/Um+TBuTF1Ok2Qrur8O1MDmiuJoyTSq7ghwAUwQ+z5KzBDl
	q6Lv3BPuDnM/Df2q2PHY2A==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1viKjT-00Fh5d-27;
	Wed, 21 Jan 2026 00:02:15 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60KN2OKT328360
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 23:02:24 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60KN2LHU328359;
	Tue, 20 Jan 2026 23:02:21 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 0/6] selftests: forwarding: skip tests when kernel or userspace support is missing
Date: Tue, 20 Jan 2026 23:02:02 +0000
Message-ID: <20260120230208.328337-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
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
	TAGGED_FROM(0.00)[bounces-251638-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,virtuozzo.com:mid,virtuozzo.com:dkim]
X-Rspamd-Queue-Id: 35CAA4E255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Several forwarding selftests currently assume that certain kernel
features or tc/ip capabilities are always present. When this is no the
case (e.g. kernel built without specific CONFIG options or older
iproute2).

This series adds explicit feature probing and conditional skips to
avoid false negatives.

Summary of changes:
1. forwarding/lib: skip tests that require LAG devices when the team
   driver is not supported (CONFIG_NET_TEAM disabled)
2. forwarding/sch_ets: skip tests if the cls_basic module is not
   available (CONFIG_NET_CLS_BASIC disabled)
3. forwarding/lib introduce run_cmd_grep helper to probe userspace
   feature support by matching keywords in command help output
4. forwarding/tc_flower_cfm: skip test when tc does not support cfm
5. forwarding/tc_flower_l2_miss: skip test when tc does not support
   l2_miss
6. forwarding/router_mpath_seed: skip tests then ip does not support
   hw_stats

Aleksei Oladko (6):
  selftests: forwarding: lib: skip test if team driver is not supported
  selftests: forwarding: sch_ets: skip test if cls_basic module is
    missing
  selftests: forwarding: lib: add run_cmd_grep helper for feature
    probing
  selftests: forwarding: tc_flower_cfm: skip tests if tools or feats are
    missing
  selftests: forwarding: tc_flower_l2_miss: skip tests if tools or feats
    are missing
  selftests: forwarding: router_mpath_seed: skip tests if tools or feats
    are missing

 tools/testing/selftests/net/forwarding/lib.sh | 33 ++++++++++++++++++-
 .../net/forwarding/router_mpath_seed.sh       |  2 ++
 .../selftests/net/forwarding/sch_ets_core.sh  |  1 +
 .../selftests/net/forwarding/tc_flower_cfm.sh |  2 ++
 .../net/forwarding/tc_flower_l2_miss.sh       |  2 ++
 5 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.43.0


