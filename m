Return-Path: <netdev+bounces-211626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C9B1AA35
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 22:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A870189CD09
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 20:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A650A234966;
	Mon,  4 Aug 2025 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Og0pv9Iy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F621D5BC
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754340183; cv=none; b=deDQ51rNDty1OAbdL4nbNT5TbvvdsJOSZQrzXhqQovqXrZkXIPD9k7o46UAKVdw4kT78vzzhbxqaWbDPsxd/1bK6aleLk6OFaYIgQppm+Cw+nx9FvFPId2/3tfU+1dZrEWwAnv4F5s1tvNIQWeYvjunIv4b4n/JP0AJlKfzkKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754340183; c=relaxed/simple;
	bh=1q0AJSmYwpiwEBMDPBrAvoL7wGmF84F98gzMAFhHLOI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YcKw+K+NRWFpS6dV1e3p1PIPUzj59Jt2ibW9d1xDTzQmham804OJtRiGnRhfJ4xdJnXLu0ZthFH+DWmcbgGEZPkq1HFr+vbRiVjQ/ChLJsimwYPkEHY9l3ZMdTKbLdrTxY20nMKntfBjEPU2TxI49M0If0NjYY/jCRc8BDCr+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Og0pv9Iy; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=qjuggcw4ufhxxknibr33maxmii.protonmail; t=1754340178; x=1754599378;
	bh=10WUjNzk2HF2RaLox2mr9sq+QEXRMLLfRbsEMop6Otc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Og0pv9Iy17lNk2Hvuz3r78HIhRqYaj9Fhla93p6PF4g7i1T3h+8n+FuJ3ZCvUzahx
	 efbdVkgGl/1aAexrMJ0qL1HHztn+GIxOKAF2NxeK2bWg/pMGku76EwWpIa+5Vu5u6s
	 CX97OolQ28gPpuQMDQbLlq6gDwJklWSPqdqrLc5zibwccM4AO7zAHbdc7Y98nlzxuQ
	 yq9WOfrVpzqlfqQRWumjBT5bBxgzzyw85Cr/fQ6BhMOHyyFHi92qKTPLjDDCH/EI6C
	 qfMjBxuOlLtYVXJ1PCE9PLxGcyTD7o2XNQyHtz462zl9LK/WXAKibjatGMMFUxYB0i
	 iBJodpsY1WzVw==
Date: Mon, 04 Aug 2025 20:42:53 +0000
To: davem@davemloft.net, dsahern@kernel.org
From: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>, syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
Subject: [PATCH 1/1] ipv6: Check AF_UNSPEC in ip6_route_multipath_add()
Message-ID: <20250804204233.1332529-1-maksimilijan.marosevic@proton.me>
Feedback-ID: 97766065:user:proton
X-Pm-Message-ID: 14d0a06c66484cfe47a197f02c06aca5859d00cf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This check was removed in commit e6f497955fb6 ("ipv6: Check GATEWAY
in rtm_to_fib6_multipath_config().") as part of rt6_qualify_for ecmp().
The author correctly recognises that rt6_qualify_for_ecmp() returns
false if fb_nh_gw_family is set to AF_UNSPEC, but then mistakes
AF_UNSPEC for AF_INET6 when reasoning that the check is unnecessary.
This means certain malformed entries don't get caught in
ip6_route_multipath_add().

This patch reintroduces the AF_UNSPEC check while respecting changes
of the initial patch.

Reported-by: syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Da259a17220263c2d73fc
Fixes: e6f497955fb6 ("ipv6: Check GATEWAY in rtm_to_fib6_multipath_config()=
.")
Signed-off-by: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>
---
 net/ipv6/route.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3299cfa12e21..d4b988bed920 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5456,6 +5456,14 @@ static int ip6_route_multipath_add(struct fib6_confi=
g *cfg,
 =09=09=09goto cleanup;
 =09=09}
=20
+=09=09if (rt->fib6_nh->fib_nh_gw_family =3D=3D AF_UNSPEC) {
+=09=09=09err =3D -EINVAL;
+=09=09=09NL_SET_ERR_MSG(extack,
+=09=09=09=09       "Device only routes can not be added for IPv6 using the=
 multipath API.");
+=09=09=09fib6_info_release(rt);
+=09=09=09goto cleanup;
+=09=09}
+
 =09=09rt->fib6_nh->fib_nh_weight =3D rtnh->rtnh_hops + 1;
=20
 =09=09err =3D ip6_route_info_append(&rt6_nh_list, rt, &r_cfg);
--=20
2.50.1



