Return-Path: <netdev+bounces-101779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B79000BD
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363A0287099
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA015CD58;
	Fri,  7 Jun 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="R2Ynr5aF"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1779F4
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755941; cv=none; b=EiTgdI+2b53WKyZ66S9Bvn/eLI07Z0QpB5TIfsirEmUo10RuYcTI1l8hEME+/qzfG3zSlrNRLXPkFP7QJgN9jnAmErUDRIs9XjuapPUlUkLxDoWfIV52HtrvP1MOe6eN4URRzRQuDri4WViwCQw5uV0MSVjVYU14uo2FDN49nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755941; c=relaxed/simple;
	bh=O/GVMyFHjpM2MRFNrvpiQhbq0PUn1eVOQcMAp4s/n/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WuXUnE9efPGac7yAdU+fcNz3TU7+7ariqqODrDtN944aMi2JS+LaHdYXUpj1Yr4WSwkY1CY+Q/5nhyZfQIzLL8u8zrcNwrIl45hrfElNGElv+1TNVT/nrbn8X9x+kFyxfiBP9NZNkhtput8R40LQAWBw6MHWB/wgyo4p0DNr2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=R2Ynr5aF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 3A800201B5; Fri,  7 Jun 2024 18:25:37 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717755937;
	bh=q8rfTzYJgwrK3P276wfIKm/jkHCq+brRhmQplC7vmOA=;
	h=From:Subject:Date:To:Cc;
	b=R2Ynr5aFerQ3PqdLYp6wCrp17ymzNm8OkGe7vxF/+fVi9d9GCOAQkvauMYrs3q9pl
	 UJ/Gbqtsm7ZsLfobqp45OR4oN1fHpyz2ld4gSxJIXBkO12tlh/4cTYKg0jF7fIcsTj
	 7AUUop5wVTYAlw+0WaQhTOAm0iBS5cQxaoxdBieuWd/OF6cCFwQyZ1Psp0FYEmOhcK
	 r2/I2W9CZ2uyER59gvgZczGrybEaOwXXZkeJXcFwImV1hvuv+Jt9XT4jPjhSC4kJSy
	 HMsiA2ne58C3hcxSFG8lQvg7trKwagG/LJlGIhQlr2L7H6fuYYIPZdUiMuqd0UqYDE
	 O6DNRBOazifRQ==
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v3 0/3] net: core: Unify dstats with tstats and
 lstats, implement generic dstats collection
Date: Fri, 07 Jun 2024 18:25:23 +0800
Message-Id: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPgYmYC/3XNTQ7CIBAF4Ks0s5aGH6HVlfcwLpAOloVggJKap
 neXsDS6fPNevtkgYXSY4NxtELG45IKvQRw6MLP2DyRuqhk45UeqqCRTyjoncldIRyPYKKWEOn5
 FtG5t0BU8ZuJxzXCrzexSDvHdPhTW+m+sMEIJq0dxUsjUQC8mTGiCTzkuJvcmPHu9NK3w3wKvw
 mA1UmFHJqz4I+z7/gEV+Y8+8wAAAA==
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
implementation to the core, and updates the single driver (vrf) to use
this generic implementation.

Of course, questions/comments/etc are most welcome!

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
v3:
- rather than exposing helpers, perform dstat collection implicitly when
  type == NETDEV_PCPU_STAT_DSTAT
- Link to v2:
  https://lore.kernel.org/r/20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au

---
v2:
- use correct percpu var in dev_fetch_dstats
- use correct accessor in vfr rx drop accounting
- v1: https://lore.kernel.org/r/20240605-dstats-v1-0-1024396e1670@codeconstruct.com.au

---
Jeremy Kerr (3):
      net: core,vrf: Change pcpu_dstat fields to u64_stats_t
      net: core: Implement dstats-type stats collections
      net: vrf: move to generic dstat helpers

 drivers/net/vrf.c         | 56 ++++++++++++++---------------------------------
 include/linux/netdevice.h | 12 +++++-----
 net/core/dev.c            | 50 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 45 deletions(-)
---
base-commit: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58
change-id: 20240605-dstats-b6e08c318555

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


