Return-Path: <netdev+bounces-209750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6B3B10B35
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581543AC36A
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991382D541E;
	Thu, 24 Jul 2025 13:19:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE62D3747
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363152; cv=none; b=gE1ADGRJDMwh7+JAaGbCLr5LIgemUTMRytim0hWkwe5hhfacVD8RSSwVj4l6FtCydHUVvjODeK2H+NZWNiQukWJIaAwARnxqrUyLLvyvkAcUTc1lXqD7gR+knTcfWYZzvAyo6nGZEIsfYnuNgbQmaLVEY2d/aUdnrVI8RuF4uJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363152; c=relaxed/simple;
	bh=UIpQ7myc+zlNwliIGAn48W7tFQgwFpTEe0b/ULgB630=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RtErPzu1uXqWs5S6lA4ADtdLUePpxe20W0ZXn40y2zTE5QfLUP0EDTkYH0SN5b6TmJSzwR37XGr7RmPnegC0TE/dPU18JjtYTMLMH2Lzg7LDhkiPiC3fuZW7vI8pDvmjbj9FLcAFspKgqmifrn4APH+NQpwUa+EQigS+GwEIZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2001:67c:370:1998:30cb:b625:4f9:61b4] (helo=alea.q.nox.tf)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1uevqf-00000002yTC-0i9u;
	Thu, 24 Jul 2025 15:19:01 +0200
Received: from equinox by alea.q.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1uevqI-000000008N2-17cj;
	Thu, 24 Jul 2025 15:18:38 +0200
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Lamparter <equinox@diac24.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: [PATCH net-next 0/4] net/ipv6: RFC6724 rule 5.5 preparations
Date: Thu, 24 Jul 2025 15:18:21 +0200
Message-ID: <20250724131828.32155-1-equinox@diac24.net>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

following 4 patches are preparations for RFC6724 (IPv6 source address
selection) rule 5.5, which says "prefer addresses announced by the
router you're using".  The changes here just pass down the route into
the source address selection code, it's not used for anything yet.
(Any change of behavior from these patches is a mistake on my end.)

Cheers,

David


David Lamparter (4):
  net/ipv6: flatten ip6_route_get_saddr
  net/ipv6: create ipv6_fl_get_saddr
  net/ipv6: use ipv6_fl_get_saddr in output
  net/ipv6: drop ip6_route_get_saddr

 include/net/addrconf.h  |  4 ++++
 include/net/ip6_route.h | 26 ------------------------
 net/ipv6/addrconf.c     | 45 +++++++++++++++++++++++++++++++----------
 net/ipv6/ip6_output.c   | 27 ++++++++++++++++++-------
 net/ipv6/route.c        | 16 ++++++++++++---
 5 files changed, 71 insertions(+), 47 deletions(-)

-- 
2.47.2


