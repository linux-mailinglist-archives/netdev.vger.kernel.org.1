Return-Path: <netdev+bounces-100836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 714368FC3C7
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107991F22156
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 06:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7529319046D;
	Wed,  5 Jun 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="YZHUblLW"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1842190463
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569473; cv=none; b=YmXehCYnWkeUM5OS5mFftpSTCmSzCO4asE4rfuE6p70AHOxeSEptSh1fvKeqKee9fXq2jqvjDhpF23az7/X9lG9RDnl/O7CwNAT756GVQioAQJ9gqJPlBuDh6m7+fQWOlML7pldEkvQ35K82BCq0rBiwXtKcRhiK3ybRH8OIibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569473; c=relaxed/simple;
	bh=pz0ZBBN7nu2eg4cY8l3uO3wigfmD4Wp4HmDpLlGAXQU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KOIvgmejRthChUojbGshFg8BHcQCMFTGvulMZa9zYrBHCpaCvUCuGc0tbYhARZyaNuGCQ1jMuN3A1k6oIOK8vEjzZ0l5t7420w7rvucFLiJJX8yzBHd2tha8Nki9fdrlFh2H4MaLYsczx1/weJu2N+atxEPAoo+fVN5GwMh0yl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=YZHUblLW; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 0335B2019F; Wed,  5 Jun 2024 14:37:43 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717569464;
	bh=u7/lxYuFvee2qHyrqvhX9wpSXMcVL5aE9AVu9JV3yPU=;
	h=From:Subject:Date:To:Cc;
	b=YZHUblLWTRMgLEu+eAAF2BTRTLKONW/Oi60Qo+SAWXvYDuHDWrbDHIUI4ulzGJ/uU
	 5Yjp7fPHmAoVtdSlVSvn7jVlsclOihtCsSIEGzQrKNN1x1yMPs6pqmnHe4RxK7Kn8R
	 d/NPx1S99XlSYhDuhzZZI6AwJ/VaU346dFsr5VIcmJy1ptPsj9OlQm6Pspr/E4zgt0
	 C7Js5ush+behXVvQzw6XZkb5+Btqg4E4e0NXck1UtWw1IZst8ZIEHTKS0wozz2vgRj
	 zt6Wu/IxVZHvOL+wIbj6leWIQ10Y9j2hSlUCWXz54pWWHHtQRL7gXWHskmLrEGmxLA
	 cI03yuT8+ySBg==
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH 0/3] net: core: Unify dstats with tstats and lstats, add
 generic collection helper
Date: Wed, 05 Jun 2024 14:37:27 +0800
Message-Id: <20240605-dstats-v1-0-1024396e1670@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKcHYGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNT3ZTiksSSYt0ks1QDi2RjQwtTU1MloOKCotS0zAqwQdGxtbUAxlN
 0R1gAAAA=
To: David Ahern <dsahern@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.13.0

The struct pcpu_dstats ("dstats") has a few variations from the other
two stats types (struct pcpu_sw_netstats and struct pcpu_lstats), and
doesn't have generic helpers for collecting the per-cpu stats into a
struct rtnl_link_stats64.

This change unifies dstats with the other types, adds a collection
helper (dev_get_dstats64) for ->ndo_get_stats64, and updates the single
driver (vrf) to use this helper.

Of course, questions/comments/etc are most welcome!

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Jeremy Kerr (3):
      net: core,vrf: Change pcpu_dstat fields to u64_stats_t
      net: core: Implement dstats-type stats collections
      net: vrf: move to generic dstat helpers

 drivers/net/vrf.c         | 48 ++++++++++------------------------------
 include/linux/netdevice.h | 15 ++++++++-----
 net/core/dev.c            | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 43 deletions(-)
---
base-commit: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58
change-id: 20240605-dstats-b6e08c318555

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


