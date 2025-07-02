Return-Path: <netdev+bounces-203192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E87BAF0B7B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4B81898F8D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B19221577;
	Wed,  2 Jul 2025 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GZxVhR6N"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16B217730
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437220; cv=none; b=hw5xFadws4PP5gYiTE5FJqq6XEDAPKn4HlbmewFAdg0ZEmNBDSE9rH70WXBOFt5YnATzz07nKGqIMcjXSW4zNMhhe4eO7l5FPxJBEci0i4t/Hp+Gk9EfXvkrnpA7suGnmC5wPMQak2XbKa99UlffkDJ0txI3iUgZPqfc7DdZTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437220; c=relaxed/simple;
	bh=+O92DlIFO/+R66YcV8Zri60iERkqXwfUg1HIFKftWPk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iWtW4aFvA0MZn2L+7EOcTZzstSqNXg0kvD/YCwjlw4Z5/DUqEbq61WO/A2D70pNoNoxi1ie+3FxVGzwQkpeAHId/YXeq4UsmutXMPnaOYvEmboa5aABQGUAXITdiploQWWJTM9qE6/0rTiXqWwYyNOWuYKyoceU9ZQg0BGuWpwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GZxVhR6N; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751437214;
	bh=+C8rmtZuNVyVlZsyinsZ2AzV/6moSeK+UOu7Yd29HuQ=;
	h=From:Subject:Date:To:Cc;
	b=GZxVhR6Ndt85rR7dcvsgaDjvr3aOP3GTiI6NpPINMLxHw2xFmcH39gj+q8DiTBAvU
	 KbS4/iqEv15hhWTCs4xQvCxeYuc6clriBkvBDviESLx/fCx2C27j/t9tQDF+x96FqO
	 Y6A+/8/cwpRK09n7z5LkehwChiVV5TPWsVMinB4OeQTum3C7Pez1U4J3KTETsM0M6P
	 W3NSf0ZCBeIgfotxnKZXeFC8S8IYZGt4pkhO153iACklam4nrK5IXrkFAY6nL+1+Ot
	 OzRwxKcp1Zqt3NGc822nOZ5c5GBr5VZE4O2ntTXImW22i8IUkkIGvRXys8mJbiglvb
	 3YdvQlt7lS+dA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id F1CC76A6E7; Wed,  2 Jul 2025 14:20:14 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v5 00/14] net: mctp: Add support for gateway
 routing
Date: Wed, 02 Jul 2025 14:20:00 +0800
Message-Id: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJDPZGgC/33NwW7DIBAE0F+JOJeIBdvEPfU/qhy8sCQcChUQk
 iryvxdxsmo1x9Fo3jxZpuQps/fDkyWqPvsYWhjfDsxcl3Ah7m3LTAo5ilEKbqlyF9N9SdaHCxc
 aYNZq0AIda6PvRM4/OvjJAhUe6FHYuTVXn0tMP/2pQu87OgH8RStwwSecZgRHqLT7MNGSiSGXd
 DPlaOLXcbl1tcqtNO8k2STlTnASgGIy8oWkNpIcd5JqkmwfaJUAheqFNGwlvZOGJmmJqMyCZtb
 mH2ld119xDT9anwEAAA==
X-Change-ID: 20250520-dev-forwarding-0711973470bf
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

This series adds a gateway route type for the MCTP core, allowing
non-local EIDs as the match for a route.

Example setup using the mctp tools:

    mctp route add 9 via mctpi2c0
    mctp neigh add 9 dev mctpi2c0 lladdr 0x1d
    mctp route add 10 gw 9

- will route packets to eid 10 through mctpi2c0, using a dest lladdr
of 0x1d (ie, that of the directly-attached eid 9).

The core change to support this is the introduction of a struct
mctp_dst, which represents the result of a route lookup. Since this
involves a bit of surgery through the routing code, we add a few tests
along the way.

We're introducing an ABI change in the new RTM_{NEW,GET,DEL}ROUTE
netlink formats, with the support for a RTA_GATEWAY attribute. Because
we need a network ID specified to fully-qualify a gateway EID, the
RTA_GATEWAY attribute carries the (net, eid) tuple in full:

    struct mctp_fq_addr {
        unsigned int net;
        mctp_eid_t eid;
    }

Of course, any questions, comments etc are most welcome.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Changes in v5:
- reinstate IFF_LOOPBACK check for new routes. Reported by Paolo Abeni
- mctp_sendmsg: return immediately on errors before we have allocated
  skb, preventing a mctp_dst_release() on uninit dst. Reported by Paolo
  Abeni.
- move mctp_dev_hold() to nlparse_populate, so we're consistent in the
  cleanup semantics. defer all stores to @rt to the success case.
- keep existing semantics of extaddr->halen checking
- Link to v4: https://lore.kernel.org/r/20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au

Changes in v4:
- avoid vla detection from const array-size initialiser, reported by ktr
- Link to v3: https://lore.kernel.org/r/20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au

Changes in v3:
- 02/14 (new): Reduce frame size for route_input_cloned_frag kunit test,
  preventing -Wframe-size-larger-than warnings
- Link to v2: https://lore.kernel.org/r/20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au

Changes in v2:
- 12/13: prevent uninitialsed gateway variable in nlparse_common
- 13/13: make test data static
- commit message spelling fixes
- Link to v1: https://lore.kernel.org/r/20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au

---
Jeremy Kerr (14):
      net: mctp: don't use source cb data when forwarding, ensure pkt_type is set
      net: mctp: test: make cloned_frag buffers more appropriately-sized
      net: mctp: separate routing database from routing operations
      net: mctp: separate cb from direct-addressing routing
      net: mctp: test: Add an addressed device constructor
      net: mctp: test: Add extaddr routing output test
      net: mctp: test: move functions into utils.[ch]
      net: mctp: test: add sock test infrastructure
      net: mctp: test: Add initial socket tests
      net: mctp: pass net into route creation
      net: mctp: remove routes by netid, not by device
      net: mctp: allow NL parsing directly into a struct mctp_route
      net: mctp: add gateway routing support
      net: mctp: test: Add tests for gateway routes

 include/net/mctp.h         |  52 +++-
 include/uapi/linux/mctp.h  |   8 +
 net/mctp/af_mctp.c         |  66 ++---
 net/mctp/route.c           | 574 ++++++++++++++++++++++++++++--------------
 net/mctp/test/route-test.c | 612 +++++++++++++++++++++++++++++----------------
 net/mctp/test/sock-test.c  | 229 +++++++++++++++++
 net/mctp/test/utils.c      | 196 ++++++++++++++-
 net/mctp/test/utils.h      |  44 ++++
 8 files changed, 1324 insertions(+), 457 deletions(-)
---
base-commit: 0097c4195b1d0ca57d15979626c769c74747b5a0
change-id: 20250520-dev-forwarding-0711973470bf

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


