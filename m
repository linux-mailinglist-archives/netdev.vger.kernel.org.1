Return-Path: <netdev+bounces-235506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABC2C31A37
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAAA3BCAA2
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47E732E73A;
	Tue,  4 Nov 2025 14:51:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412EF24EF8C
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267867; cv=none; b=DSkmSB1eXN9Dtf8cWoinyihLwBGj5P32qlMLndbulO9geh1Sd4dVlGNNrQnTxGUAUQqxoyjgxYqZ8jTOhl1pp7NMrA2km3crW8TwWTEau6xUfZuC+i/I3Hjd5t6TJF/jkJJ750Su637mGZFBdl+vNUw3HRHHlO3sqvAM8X+E6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267867; c=relaxed/simple;
	bh=CHqfKwG1aWKsEHuMqqarnwLchnwf+dNGEBLcPxpQVeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCYZJQqvyGUNExwkX4UEMYuRfT/HlA7/8jt8jwicDAcQzG+vMA0mffFcypv77g124hgLV132kYAqI06UxiOA+VdF8i7gzIXMuZc0A1kk6lyUoszxMPuRdaimfagpd61N9ruIS+iv3ssAurFh7rwM2/wkx/L2T3PtKpu7LHSKLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2001:67c:1232:144:9c7d:e76f:d255:c66c] (helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1vGILB-000000009A7-2pYd;
	Tue, 04 Nov 2025 15:48:58 +0100
Received: from equinox by alea with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1vGIKi-0000000057M-1iYN;
	Tue, 04 Nov 2025 09:48:28 -0500
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: David Lamparter <equinox@diac24.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: [RESEND PATCH net-next v2 0/4] net/ipv6: RFC6724 rule 5.5 preparations
Date: Tue,  4 Nov 2025 09:48:18 -0500
Message-ID: <20251104144824.19648-1-equinox@diac24.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,


Jakub, you had asked me a little while ago to resend this at a later
point not shortly before the merge window closes.  Unfortunately I don't
do enough kernel work to track when that is (sorry), so here goes
nothing I guess.  I'm still trying to get Patrick or Lorenzo to look at
this and throw a Reviewed-by.

To emphasise, these patches **should not change any behavior**.

following 4 patches are preparations for RFC6724 (IPv6 source address
selection) rule 5.5, which says "prefer addresses announced by the
router you're using".  The changes here just pass down the route into
the source address selection code, it's not used for anything yet.  I
have the actual 6724 rule 5.5 code working and am putting together
kernel self-tests currently.

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
 net/ipv6/ip6_output.c   | 25 +++++++++++++++++------
 net/ipv6/route.c        | 16 ++++++++++++---
 5 files changed, 70 insertions(+), 46 deletions(-)

-- 
2.50.1


