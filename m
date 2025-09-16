Return-Path: <netdev+bounces-223373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A821B58E99
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F1E7AFE23
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 06:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEBB280338;
	Tue, 16 Sep 2025 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tKGD0OcL"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7C2777F3
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005228; cv=none; b=TwzdARvzo2cYuBht/xuxg3WRlZzow9oVADJaT2I1gg0ulq3dam4q+7rP3f0TuT6tJbXnlgcZ7SJgxyJSoaQvUTO0dT4MHtgnm6F1To4mzo1FisU77z8JnjG4jcGG/dc/cO5e5Uil1Y8lP2qr82nvwXYpAWPjrQq1BBa9NelMIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005228; c=relaxed/simple;
	bh=ixnPJSz/rvC/EypjUzFbrjm7d8lthdogrnUalvRW89Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cZI8c0LL0+ZbCxic786xd4ebvUkEOP16+pVXCTcmSpftUBksQUamVxMxky+Ul6xrRw8yx0SZafaY+yz0e+zO92ZOieWtaVQuRSAEDmFRs/H0BrCwrfoSy3Yttn9C0aSXtalXlLG1ihoPeZeN2O1yn6BV+mcwPLbRffWLHKrrZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tKGD0OcL; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758005221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9POLLP8ZbOwDyCGGly8E/uUVBxtn+SCHe1doDfsp8mk=;
	b=tKGD0OcLrodTUA41+TiNv0p8iiAz0ao/Bqj++eW63vemizWLX+t6392bh+cYEjpKMvztyC
	a+3QNKGcagKnIxN7cOw4I41N1FKECv+HJp13sZzmwECQwAmlL6OIdgIBQ8H9pkSPEZzr81
	KbjUznRFhpx1dvmtmnieNICTqa/0Vd8=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v2 0/3] net: Avoid ehash lookup races
Date: Tue, 16 Sep 2025 14:46:11 +0800
Message-Id: <20250916064614.605075-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

After replacing R/W locks with RCU in commit 3ab5aee7fe84 ("net: Convert
TCP & DCCP hash tables to use RCU / hlist_nulls"), a race window emerged
during the switch from reqsk/sk to sk/tw.

Now that both timewait sock (tw) and full sock (sk) reside on the same
ehash chain, it is appropriate to introduce hlist_nulls replace
operations, to eliminate the race conditions caused by this window.

---
Changes:
  v2:
    * Patch 1
	* Use WRITE_ONCE() to initialize old->pprev. 
    * Patch 2&3
	* Optimize sk hashed check. Thanks Kuni for pointing it out!

  v1: https://lore.kernel.org/all/20250915070308.111816-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (3):
  rculist: Add __hlist_nulls_replace_rcu() and
    hlist_nulls_replace_init_rcu()
  inet: Avoid ehash lookup race in inet_ehash_insert()
  inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()

 include/linux/rculist_nulls.h | 61 +++++++++++++++++++++++++++++++++++
 include/net/sock.h            | 23 +++++++++++++
 net/ipv4/inet_hashtables.c    |  4 ++-
 net/ipv4/inet_timewait_sock.c | 15 ++++-----
 4 files changed, 93 insertions(+), 10 deletions(-)

-- 
2.25.1


