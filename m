Return-Path: <netdev+bounces-201804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572BFAEB1AE
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A77E1BC6B1A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AF427EFED;
	Fri, 27 Jun 2025 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ay+21rgJ"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB814277026
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014369; cv=none; b=hT3/7GQJQ2Yhu9zgSMgKTP8NWgb8XHYTNpFkqEhSbLihs18ylStkMTSYOTRDFcvWRmS2So9jGaXBawXbbdZW+IgK5ASIXb8PeI8O4zYrylatPoB1/9dkmFUIiBtaaVjLZwqZH/phcD/QiAKR3cLI1hTBXWiNmpaHuijKUnVBUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014369; c=relaxed/simple;
	bh=TtIR8UYQdItw2vezph2XTVibrPgIo9NfYNC6HZbrLzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jnB8qoWTgY7+9Y4QUXkaDgOSDu8Z84Y5OEZjbsHAJd5twF8voW6MUL5bLCfaCCHaWqXO2KjiQQ/AHkXR8YIAQPqKL7z7H0Jey1AjpHfaJuWUN1cRz4knPcJmuMpNux5xuR5ie/xzSkgRqs1WS2adlJncmtP/HdA+klZdligSO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ay+21rgJ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751014365;
	bh=tK377rKA/I2vUb+E72lKTE07/N51K4Q0nDeqZmYcaoY=;
	h=From:Subject:Date:To:Cc;
	b=ay+21rgJQMemVRkkJvXYZrMb3RCKLr58GUR5w3eNKfDuKXuBZjsLnNS9doUP4dG/A
	 1O/85nXIrhI6tKgTBXS4+0ta1MRwReS4oA3uUUV/CFA4ymq/0LzoJN2NtRT64QQ7PI
	 BnzLW9DEIrhTfDmfqKJr76DiZtLq4DVY3nk/EIyiRKxmxNzeMkfmSQlMCPkOoznzuz
	 n+3FvhPB4rdzWMc6um3TZ6az9uh4HMP4x6YsK/J09wFZAmD1/2Aaf/aqS4kpkG+PJN
	 C1V2kcgLAfQIXR68HZO/DbzMcdIqZrq6FqX2K2R2t0zQM+dL8ZnHFXLp/UZ4Wr0vIB
	 AeUtRy4hg1akA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 7D85169DE7; Fri, 27 Jun 2025 16:52:45 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v4 00/14] net: mctp: Add support for gateway
 routing
Date: Fri, 27 Jun 2025 16:52:16 +0800
Message-Id: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMBbXmgC/33NMQ4CIRQE0KsYajH/g7vrWnkPY7HARykEA4gas
 3eXUBmNlpPJvHmyRNFRYtvFk0UqLrnga1gvF0yfJn8k7kzNTIDooBPADRVuQ7xN0Th/5DAgjoN
 cD6Asq6NLJOvuDdwzT5l7umd2qM3JpRzioz0VbH1De8RPtCAH3qt+VGhJycHudDCkg085XnVe6
 XBeTdemFvEujV+SqJK0G9wAKui1+CPJN0l0X5KskqgfykhAqeQPaZ7nF64RHA5VAQAA
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


