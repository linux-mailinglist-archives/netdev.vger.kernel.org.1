Return-Path: <netdev+bounces-209799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF2DB10E3E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A0C5A363C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DB32E974E;
	Thu, 24 Jul 2025 15:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F812DE714
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369284; cv=none; b=hNLTH/TwSft/m0dOsIaz4SAXiVF0TaGN0dXWLQfcMSYqKzy+rvfxy0GU9oivvFPBzXCogcjNbK2t7lWOu45MNi3OpSDbXqVE2DSl//3gpEvedAg6MkeKktqtDVUFEdg4CTJQSCHxEvEMLr6u9T5xX91MMiRdXo/Km1+4y//Ca44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369284; c=relaxed/simple;
	bh=G/mG2umtWG8c9grYB8AEVFB284nedLx9HllOWJoRqxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZrYM73PXqJb/689o2S/tDYxOSlCCOXSfC6h+J2BQXw1CY2wmRQYP8f1mndXK+62hnzZaBsI4oq9B+549XQyj/dYghKh5mmT2yQoI6iyGby9gFyakoAO1uL6VjDTxL4T/eswHFc+OI7QbZuqKzUXoEqXF6IxlBxHJLkKn5D57Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2001:67c:370:1998:30cb:b625:4f9:61b4] (helo=alea.q.nox.tf)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1uexRc-000000030oc-1mXz;
	Thu, 24 Jul 2025 17:01:19 +0200
Received: from equinox by alea.q.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1uexRB-000000001f3-2nD1;
	Thu, 24 Jul 2025 17:00:49 +0200
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Lamparter <equinox@diac24.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: [PATCH net-next v2 0/4] net/ipv6: RFC6724 rule 5.5 preparations
Date: Thu, 24 Jul 2025 17:00:37 +0200
Message-ID: <20250724150042.6361-1-equinox@diac24.net>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,


let's try this again, this time without accidentally shadowing the 'err'
variable.  Sigh.  (Apologies for the immediate v2.)

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
 net/ipv6/ip6_output.c   | 25 +++++++++++++++++------
 net/ipv6/route.c        | 16 ++++++++++++---
 5 files changed, 70 insertions(+), 46 deletions(-)

-- 
2.47.2


