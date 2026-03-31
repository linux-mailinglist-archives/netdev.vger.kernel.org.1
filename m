Return-Path: <netdev+bounces-273708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK3YBJD9y2nqNAYAu9opvQ
	(envelope-from <netdev+bounces-273708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:00:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A3236DA05
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4BC327BEF0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB521426D09;
	Tue, 31 Mar 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d9pE7yCM"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10B4266B9;
	Tue, 31 Mar 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975907; cv=none; b=PVdVea2FCOunZ1RdOesAL+Nm6WAhgfvgJcs5iR6woglF+AW4zpU5q92EHymVdjqrhUlRr1vAkicPRMJL9Dvw3+W6qXDNgWhuC6827B/cdrCzjK/N9smPfKzKkVC1qil9YUl8tele7Kuoo/t8kTWELJALjz3TMpuyb4Ha3EwqXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975907; c=relaxed/simple;
	bh=EiaNJVPttYdBYeGu7j4d2onwXrFeVG6ElVAQoG/6AGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gWrc/DU6P1ztlANPWnVuBAl+djm6ndupCWVG3ag4Rmy5+P6p0eoStJvrAOewswDiv/qVq1ZGWHS2IHlzkdBqY1gPqX61SRTo2ZjjK9VNG2pB4HzmLhlDlTQ0m2bxpMLFi7d4VXWbW7HnBUNRyjBCZY2IfUuqlaGH00F04FmScgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=d9pE7yCM; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:From; bh=ILcBB2yY0igmjaQ5LWrShiOv0Mp8hiYCVu036AOf+A4=; b=d9pE7yCM0H9Yk5xjWae
	URhM0+2lwISsx4HPNWjhO/UBrqB+kOt5ScGuCanG6j6gDVRn9vOUH3Q3xVq+D47/tmXKDRsaUbwzv
	dp110q9oKtsQm3WbM5OT5otTiQ+lUI5pmd2wiGGMrzhAVYwz86PwtqGmwASoIjQJqovqTTELV8kRS
	KBulxj4xQxgNTiUArjJvKyApHvSSGoOYsEmVANDh2eLPQqj4C4ew8P9lUTikyNTRi2SWGgTcer72x
	KLZrDQSGwqJKCZ46Imft9RFQQkTcm+rUgEAc2QJW5qCMOlMpO/xUgm6zUPyGzJBtAM+5yru2lypDu
	vOdmZLK3Ej25M2A==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w7cHB-00HHGg-32;
	Tue, 31 Mar 2026 18:51:16 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v2 0/1] Fix kernel build failure with CONFIG_GCOV_PROFILE_ALL=y
Date: Tue, 31 Mar 2026 19:50:26 +0300
Message-ID: <20260331165125.959833-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[virtuozzo.com:?];
	TAGGED_FROM(0.00)[bounces-273708-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.974];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_DNSFAIL(0.00)[virtuozzo.com : query timed out];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_TEMPFAIL(0.00)[virtuozzo.com:s=relay];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4A3236DA05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch fixes a build failure in net/core/skbuff.c that occurs when
CONFIG_GCOV_PROFILE_ALL=y is enabled.

v2: use __no_profile instead of preprocessor guards, as suggested
    by Thomas Weißschuh.  This solves the root cause (GCOV counters
    preventing constant folding) and also removes the existing
    CONFIG_KCOV_INSTRUMENT_ALL guard which is no longer needed.

Build failure without this patch
---------------------------------

With the following configuration:

  CONFIG_GCOV_KERNEL=y
  CONFIG_GCOV_PROFILE_ALL=y
  # CONFIG_GCOV_PROFILE_FTRACE is not set
  CONFIG_GCOV_PROFILE_RDS=y
  CONFIG_GCOV_PROFILE_URING=y

The kernel fails to build with:

  In file included from <command-line>:
  In function 'skb_extensions_init',
      inlined from 'skb_init' at net/core/skbuff.c:5214:2:
  ././include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_1490' declared with attribute error: BUILD_BUG_ON failed: skb_ext_total_length() > 255
    706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |                                             ^
  ././include/linux/compiler_types.h:687:25: note: in definition of macro '__compiletime_assert'
    687 |                         prefix ## suffix();                             \
        |                         ^~~~~~
  ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
    706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |         ^~~~~~~~~~~~~~~~~~~
  ./include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
     40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
        |                                     ^~~~~~~~~~~~~~~~~~
  ./include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
        |         ^~~~~~~~~~~~~~~~
  net/core/skbuff.c:5163:9: note: in expansion of macro 'BUILD_BUG_ON'
   5163 |         BUILD_BUG_ON(skb_ext_total_length() > 255);
        |         ^~~~~~~~~~~~
  make[4]: *** [scripts/Makefile.build:289: net/core/skbuff.o] Error 1

Testing
-------

Tested with GCC 11.4.1 and GCC 16.0.1 20260327 (experimental) - both
exhibit the same build failure without the patch.  Both compile
successfully with the patch applied.

Konstantin Khorenko (1):
  net: fix skb_ext_total_length() BUILD_BUG_ON with CONFIG_GCOV_PROFILE_ALL

 net/core/skbuff.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.43.5

