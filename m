Return-Path: <netdev+bounces-258609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ7rNeYkj2lNKAEAu9opvQ
	(envelope-from <netdev+bounces-258609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 14:19:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D9A136491
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 14:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9E403015884
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4253590C3;
	Fri, 13 Feb 2026 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="snq2FEev"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8078CA5A;
	Fri, 13 Feb 2026 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770988771; cv=none; b=koEmXpSvzSn1F6/H7CTAMvWvje6WDKkNJ+ER558c0X/KcBV29iPMrSi25EiAchNjl6dfQHrWtKdVw3LEzQyl0/b6RY6lflzPMLgaOVZzaM77/UrbLzfjfnCZzt0WJhIDGGaC3sS9PgMBN9rS6ss5ULyzOFrt50tUcjNwRfs2iYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770988771; c=relaxed/simple;
	bh=IxiFmLLs//uQgpXVZzvly8fD0zfQla47F+czGjQAI0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yh5QYsATmoKAJkJNDoCtmDT7M/HXAsRViccgghDgoWoQZQX1RhEBvg7o+sm7Goj1OoV0gg3va85iTBAPghymIhZVZrMRi9hI12u48PkAi2oaLAAOnEunGp62qQBsLP43gYioI2Cw7YpLvUKDWABMW0GeqPl4BcmPh8H2AQxcqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=snq2FEev; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:From; bh=KLNYh7klbqTf1ytmWVMbQwmLLWqKUw7PqJT19WiTQtQ=; b=snq2FEevRCPIICTtL1p
	MToT1MpKT3hjHkX/DKmvYNQEtRDCFajNz+GSiCjhFK1OLj+l67s5N4P/1qrHVlKp07/VQP/+VfEww
	grtfdNnycvC8qSfXd42Y2up1erKxiVcZ276077rywk3X3qkxgfBdmRgAjpy17Wh2GJUPI1+C8TQVV
	g/JUo7srUETvVIMe7pd7R/f7mWzpqHmuDTn5lKnWTF7wXLrEz3Crxjmq/kX6phsKt+EOZJ1+5UFke
	bQXGWIGn943GVLl7LVuPJbtyrofcb2E2LkBAWT9YM0xf2aGUK9rX7VKJB2tzpxR5rwPSKXS36cH2v
	yytQR5ur+NYxkXg==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vqt3f-0014LI-2B;
	Fri, 13 Feb 2026 14:19:08 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 61DDJAd2043368
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 13:19:11 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 61DDJ8p1043367;
	Fri, 13 Feb 2026 13:19:08 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH net v2 0/3] selftests: forwarding: fix br_netfilter related test failures
Date: Fri, 13 Feb 2026 13:19:04 +0000
Message-ID: <20260213131907.43351-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-258609-lists,netdev=lfdr.de];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+]
X-Rspamd-Queue-Id: 68D9A136491
X-Rspamd-Action: no action

Hello

This patch series fixes kselftests that fail when the br_nefilter
module is loaded. The failures occur because the tests generate
packets that are either modified or encapsulated, but their IP
headers are not fully correct for sanity checks performed by
be_netfilter.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>

Changes in v2:
- Changed the fix for pedit tests from adding 'action csum' to disabling
  br_netfilter via sytsctl
- Mentioned in the commit message that the fix vxlan_bridge_1d utilizes
  helpers available since v6.3 kernel.
- Updated subject prefix to include 'net'.
- Added a Fixes: tag to the appropriate commit as requested
- Link to v1: https://lore.kernel.org/linux-kselftest/20260210185129.480015-1-aleksey.oladko@virtuozzo.com/T/#t
---
Aleksei Oladko (3):
  selftests: forwarding: vxlan_bridge_1d: fix test failure with
    br_netfilter enabled
  selftests: forwarding: vxlan_bridge_1d_ipv6: fix test failure with
    br_netfilter enabled
  selftests: forwarding: fix pedit tests failure with br_netfilter
    enabled

 .../selftests/net/forwarding/pedit_dsfield.sh |  8 ++++++
 .../selftests/net/forwarding/pedit_ip.sh      |  8 ++++++
 .../net/forwarding/vxlan_bridge_1d.sh         | 26 ++++++++++++-------
 .../net/forwarding/vxlan_bridge_1d_ipv6.sh    |  2 +-
 4 files changed, 33 insertions(+), 11 deletions(-)

-- 
2.43.0


