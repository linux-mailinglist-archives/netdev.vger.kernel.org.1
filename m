Return-Path: <netdev+bounces-273202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNPnM0OCymkW9gUAu9opvQ
	(envelope-from <netdev+bounces-273202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:01:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDEF35C7FB
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB12330774DB
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447613A3E78;
	Mon, 30 Mar 2026 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NVBgBEre"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C43D6CBF;
	Mon, 30 Mar 2026 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878851; cv=none; b=a+cQRqWcEaIIId4LWeopkbRUp3f4QcVxwGv20UTVx0/23xQP/8bsvQp1rGPCQo1cVIzj2iDoUhhaz+b1JUinrTR61SCUVGhLygLREdO+Dx2IWSzxMhzQ4Ksx/zP+suVwNYdoebckeQR3OE41j0DLMes1BT6EnZhhD2QpxotiWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878851; c=relaxed/simple;
	bh=3wqL/ZOabGJTKHQkIzSyfktrSZelS5TutLBuqcE2hJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhP5PIJM4A3XxC/kB30nKCOWhT2gmOdqzMHDw+M6T2CTuVm3yM3tiA/No4zKrWaPA2BnUdtBJFiJTTGrZznP1/TeOEfbuD5cSGWt/QBEoydr16xY8r3CkVjXTyfma2ZrlZpIoYGvVVPhUJuBtUxddqqIXVUHxAlvjZJTHiElPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=NVBgBEre; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=RvpF4NWzXA5Zk+Axwgkhf4Kh3Qtm2TPo14q5EXgxvgM=; b=NVBgBErekONl
	lR18KWco6fDJivDylQAGfMT3EtCJMBGpbXyk97mg0tnUyeT/EZ/BfcBgmSA0gbDE2UItFC150j/Zy
	ClIcbs8TEJUAywtuQ/UE5Xe1/7K+0IsKDGBD1Nmh0SabK2VWKc6bDMgOXbPkh7ncj45V7VySrApFu
	plLxexHVRTOmH1Ia+ZnDGgV7gVwYcHPvcp/XkmLUx8wLicAc6CsxdR9Os9ub+2BUYw5j2hG9qIiZC
	Eq3Jx6MiGxZ+B9php8SO+z0OdSn7+X4rd1t7kmNakbTV4dEdJxCty2R1FlVw5QHV19DDNxzEqHGx1
	0jkAZADQTqxq58I09VRnuw==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w7D1c-008K2q-1l;
	Mon, 30 Mar 2026 15:53:30 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	arnd@arndb.de,
	linux@weissschuh.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH 0/1] Fix kernel build failure with CONFIG_GCOV_PROFILE_ALL=y
Date: Mon, 30 Mar 2026 16:53:36 +0300
Message-ID: <20260330135337.937540-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273202-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,virtuozzo.com:dkim,virtuozzo.com:mid]
X-Rspamd-Queue-Id: 4CDEF35C7FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch fixes a build failure in net/core/skbuff.c that occurs when
CONFIG_GCOV_PROFILE_ALL=y is enabled.  The issue manifests as a
BUILD_BUG_ON compile-time assertion failure, even though the actual
runtime value satisfies the constraint.

Build failure without this patch
---------------------------------

With the following configuration enabled:

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

Root cause
----------

CONFIG_GCOV_PROFILE_ALL adds -fprofile-arcs -ftest-coverage -fno-tree-loop-im
to all kernel compilation units.  The skb_ext_total_length() function uses
a __always_inline loop over skb_ext_type_len[] array.  GCOV instrumentation
inserts branch counters, and -fno-tree-loop-im prevents loop optimization,
breaking the compiler's ability to constant-fold the result.  BUILD_BUG_ON
requires a compile-time constant and fails.

The problem is more pronounced in recent kernels (7.0+) where the number of
SKB extensions grew from 4 to 5+ (with addition of SKB_EXT_CAN, SKB_EXT_PSP,
etc.).  With 4 elements, GCC can still unroll and fold; with 5+, it gives up.

This affects both older and newer GCC versions (tested with GCC 11.4.1 and
GCC 16.0.1 20260327 experimental).

Solution
--------

Add a CONFIG_GCOV_PROFILE_ALL guard to the BUILD_BUG_ON, following the
existing pattern for CONFIG_KCOV_INSTRUMENT_ALL which has the same issue.

Konstantin Khorenko (1):
  net: fix skb_ext_total_length() BUILD_BUG_ON with CONFIG_GCOV_PROFILE_ALL

 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.5

