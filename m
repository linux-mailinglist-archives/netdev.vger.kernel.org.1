Return-Path: <netdev+bounces-274569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFZ5HGN4zmmMnwYAu9opvQ
	(envelope-from <netdev+bounces-274569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:08:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE61038A3FA
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFB1530547D1
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18883E95B7;
	Thu,  2 Apr 2026 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iyKros1N"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE583E5572;
	Thu,  2 Apr 2026 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138781; cv=none; b=kJFEiOvT0fjOc/H2Ycd5RRZ+/ua+14Dn1LZ1gnd8v0WKOyqEl/hd1RElo6ptCzTjtIfLm+UEWOMb+TOifvrtT1wbHXh1Z0uc1Zw7e21PpzMM3KqM278IiAigJoYK1XV4lW131+70L8BaVsepISO1uDd48OVXNShBHR4KdUDKzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138781; c=relaxed/simple;
	bh=GXb20nkXo6T6BgKn83E1TM/izC7kHdADZ4Ec9KXUCvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+FtoqUyJfmVm/pl6zTD/Rlb+epQ4wR2nhpQ0ujldoR2rrVsdI22I4Yf/ptIULx7nrPGaNWW8w1xfdoT/h4wHnO3cELqX1/Cwvawv8K9OZGYoGe//mNi+mSHeqMHEQFh6ecTJuAQkGh1HfOcucq3YIXs4fG6SIG8VVc2FdjbynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=iyKros1N; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=v5DoRbybaak/aBKjL15idmC5WFcut5EgrWjERUEtSm8=; b=iyKros1NIL3Z
	6mndrlPmkSbrkZt+1bOAXD3veozlFe3djB3bTdoC3WxOqmdi2NVLsz4S3bYN7PdRPu+3i6/XqU1Sl
	wIj92Nrlt62p5DmtkiJY+qSOzo75hJZrggxvV6m9zkNNpYJoVW04XJUkbhPYBBiVzGZrYKfuYNUgl
	q3YFb9kvSvaO7Hp+mPT+3uEvTswg4bCSipumMKdcD+aHYflkZoXZwsxCpButfIr3+CunASHd7RfJO
	b0bbHpchDiyZF//GXAdr6QdA1LP/VcYZNBhe1wNhrj+9vW8jc2tGl6Bq7pJxn4r+nzrTrIDwSEBZp
	du5ZzNcHRI3uCXFEpfIigg==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w8Ie8-003MIM-1H;
	Thu, 02 Apr 2026 16:05:56 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Subject: [PATCH 0/2] net: fix skb_ext BUILD_BUG_ON failures with GCOV
Date: Thu,  2 Apr 2026 17:05:56 +0300
Message-ID: <20260402140558.1437002-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274569-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE61038A3FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This mini-series fixes build failures in net/core/skbuff.c when the
kernel is built with CONFIG_GCOV_PROFILE_ALL=y.

This is part of a larger effort to add -fprofile-update=atomic to
global CFLAGS_GCOV (posted earlier as a combined series):
  https://lore.kernel.org/lkml/20260401142020.1434243-1-khorenko@virtuozzo.com/T/#t

That combined series was split per subsystem as requested by Jakub.
The companion patches are:

 - iommu: disable GCOV for iommu_amdv1.o (sent to iommu maintainers)
 - gcov: add -fprofile-update=atomic globally (sent to gcov/kbuild
   maintainers, depends on this series and the iommu patch)

Patch 1/2 fixes a pre-existing build failure with CONFIG_GCOV_PROFILE_ALL:
GCOV counters prevent GCC from constant-folding the skb_ext_total_length()
loop.  This is v3 of a previously posted standalone fix:
  https://lore.kernel.org/lkml/20260331165125.959833-1-khorenko@virtuozzo.com/T/#t

Patch 2/2 is an additional fix needed when -fprofile-update=atomic is
added to CFLAGS_GCOV: __no_profile on the __always_inline function alone
is insufficient because after inlining, the code resides in the caller's
profiled body.  The caller needs __no_profile as well.

Konstantin Khorenko (2):
  net: fix skb_ext_total_length() BUILD_BUG_ON with CONFIG_GCOV_PROFILE_ALL
  net: add __no_profile to skb_extensions_init() for GCOV compatibility

 net/core/skbuff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.43.5

