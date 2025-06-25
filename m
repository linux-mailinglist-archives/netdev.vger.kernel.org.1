Return-Path: <netdev+bounces-200959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC00AE78BA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD17E189E4B9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D122F217707;
	Wed, 25 Jun 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="IerBEROg"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46AB20B801
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836910; cv=none; b=aWg3g4zAYB11AfwlSUQnUkUgcWulRcYswZARxri4h5Ap5lLgMmoOEANUBEMjuMjUOLi67bedrxW12fTrZ4SVfiDRBII40Of5+K0jBafg8LvzXIcnMVtPDBg1i99cK1Fu0KkSXuTvhMvEaL2iNdU9vuVmgwLknN9K032mG/jj8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836910; c=relaxed/simple;
	bh=56zWy/MHAGMb43kS0H/oeW6TDZoZUXWbOZ3FqB/mEhE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HpYEO2MQGukb8QwY9LOwCdLQ/UHwX7dp9JchOpIhjcM9aGiPnnofDqKBtK2uEvkea+oaNyoyCs3AOXeBxV/OsNHsLRTtagBbj6sYoytOY+fQqIr/2MpjB0SnyE4pnh+y8l0QmGc9az5in3X+84MO+hDWOj59qiVBAmkHndqQKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=IerBEROg; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750836904;
	bh=UmCNkvBaJLHGoeoEs45ATdfViqeFrsXOKYje637Qk7o=;
	h=From:Subject:Date:To:Cc;
	b=IerBEROgb2Z5xpY0h+7TESqdvJGrXly6uHDSX8FrKigc9/r39HOpnI+Ipploj07AC
	 nydBpGjwUsZaQOGbFamPw3k90CHKG/re1JSYDh+qXaz7W7T6wHKHeMzSVurnqV02vi
	 C0xvg2PsoNeh0WG1srLBOP8gIGIrysvZYba2ZDTxZCSNYUtrqR23vbirkmlYgDLhWE
	 gifyr9l4JIAVSDMc3BxCQ8dCmxZLnyCvPo5ZKWrzDGoWdZ033NufLvy2WBhLtYjTpw
	 Q8jd3ojUcRsFDbgkeKfl/g6MtOY1xPlngflSF01gB9wruGbt7c1MNS6VZngbCGjqsM
	 1zzpO8ELAAHNg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 7A58F69A2F; Wed, 25 Jun 2025 15:35:04 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v3 00/14] net: mctp: Add support for gateway
 routing
Date: Wed, 25 Jun 2025 15:34:38 +0800
Message-Id: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI6mW2gC/3XNTQ7CIBQE4KsY1tLwwP658h7GRaGPloVggGJN0
 7tLWBmNy8lkvtlIQG8wkPNhIx6TCcbZHMTxQNQ82AmpGXMmnPGa1ZzRERPVzj8HPxo7UdYC9K0
 4tUxqkkcPj9qsBbwSi5FaXCO55WY2ITr/Kk8JSl/QBuAbTUAZbWTTS9AoRasvyo2onA3RLypWy
 t2rYSlq4p9S/yPxLAndQcdAskbxP9K+72/MtuDBCwEAAA==
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
 net/mctp/af_mctp.c         |  62 ++---
 net/mctp/route.c           | 563 +++++++++++++++++++++++++++--------------
 net/mctp/test/route-test.c | 612 +++++++++++++++++++++++++++++----------------
 net/mctp/test/sock-test.c  | 229 +++++++++++++++++
 net/mctp/test/utils.c      | 196 ++++++++++++++-
 net/mctp/test/utils.h      |  44 ++++
 8 files changed, 1310 insertions(+), 456 deletions(-)
---
base-commit: 0097c4195b1d0ca57d15979626c769c74747b5a0
change-id: 20250520-dev-forwarding-0711973470bf

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


