Return-Path: <netdev+bounces-100902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC50E8FC831
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697FA283627
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF94618FDCB;
	Wed,  5 Jun 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="AlZZuAyj"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FC618FC89
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580589; cv=none; b=Px+FmMHaiObcoaDh1G9ZDU9jb5gNNb9/LZQkKzEZ9PfT/CLzjeho2TNEishhM56c+A/MSN6SHMhb3H/LZH1R6ad4FIirlmVpO5+pTWRi9iNlzlScDQyy2GU6XuLSMpP/6Ls1xYc4RomdLgPL44tbkvRoZ5TQDPqe+2jSjgOJXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580589; c=relaxed/simple;
	bh=5cCX3zmO6lxhZl1eGK0mtxNLxmIYe05SyZsdv+4c/YM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g2d3ARMNdcrs1u2Fx26p/YbuPseI1twHDIITCvQByyHq7HrMjp1YroD9m/r45s9Y1Nthp4JKMRLr3fdGqzTkWMJ6zxeKS1ulLoHnor/vv1p01s8PsZwM/KD+PszybjKK68TYTuU+POBlcrAZJhtSKgu1yadk1GzMWNRH6A9SoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AlZZuAyj; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 2A2B52019F; Wed,  5 Jun 2024 17:43:06 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717580586;
	bh=mLZRk7ZhitQNtpy2NpyoKvVabyPtPOZ1cCSwmwZ2GG0=;
	h=From:Subject:Date:To:Cc;
	b=AlZZuAyjnRHd0ilMzOAZBj9TC6ZLQy7r/K/QJQjA7VBIoiDi2EwEr5ZgSd91kHL0c
	 PW9OSctf8LHO6kFoSXAF/fubckUOOGCT37jCRAn6lt89Ahb8WiqxfbYOHf/9mGWoCL
	 KfdhMTBeXMgT8qhEn33dCxQaJPctxdkYpOxVTddzb/rm+xv2hYaCzhGmcaAsIVn9Pe
	 S4NCilHEdgwmYxOeZFrfklfpwK9cc52H1XkUS8cdtuolyOrJ9UeDYNyrEkMmNreQPn
	 uHs6aaswDVvHvb7hy8bDU0I6M2b6rWlOX2tnYcCsL2Q1AXxZIhDDq2Nr6TYEIUiA0s
	 6F7FosWtk7zBA==
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v2 0/3] net: core: Unify dstats with tstats and
 lstats, add generic collection helper
Date: Wed, 05 Jun 2024 17:42:56 +0800
Message-Id: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAzYGYC/12NwQ7CIBBEf6XZszTQClZP/ofpAWG1HISG3TY1T
 f9dwtHjzJu82YEwByS4NTtkXAOFFEvoTg24ycY3iuBLhk52Z2mkFp7YMomnQTm4Xg1aayjjOeM
 rbFX0gIgsIm4MYyFTIE75Wx9WVfm/bFVCClXK/mpQmYu8u+TRpUicF8etS5/WLjAex/ED4/koi
 bEAAAA=
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
v2:
- use correct percpu var in dev_fetch_dstats
- use correct accessor in vfr rx drop accounting
- Link to v1: https://lore.kernel.org/r/20240605-dstats-v1-0-1024396e1670@codeconstruct.com.au

---
Jeremy Kerr (3):
      net: core,vrf: Change pcpu_dstat fields to u64_stats_t
      net: core: Implement dstats-type stats collections
      net: vrf: move to generic dstat helpers

 drivers/net/vrf.c         | 57 +++++++++++++++--------------------------------
 include/linux/netdevice.h | 15 ++++++++-----
 net/core/dev.c            | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 45 deletions(-)
---
base-commit: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58
change-id: 20240605-dstats-b6e08c318555

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


