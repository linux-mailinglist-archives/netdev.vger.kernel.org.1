Return-Path: <netdev+bounces-196423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02929AD4BC0
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C7F16C468
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 06:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AC422CBC6;
	Wed, 11 Jun 2025 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="isK/HPGe"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411428FD
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749623462; cv=none; b=f256PfqEL4ExFoTHvLSmFxKwV/+pUcXcQhuPJOfyaClNiuycXfELeFIxwjRwB1zDS5gYe8hdYCNRl0LiMINooXAQhgF01czy0XZPafCxO7BVUJlKk1xDrQnuOezx2bz3N6u90B/OdNVBB748w8MuAi7pq0v1C1ax7zIagwp0V4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749623462; c=relaxed/simple;
	bh=WBNH4L5hDQ4xX/RLafEdt0CMbfj6IFfzoJ1cza8J9ms=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZwXu7NaJPcSs5kFLxjmBUoHrXg0XoFbQpZUZSF/2JIhE74vq2DjSC3v54ujFkUVs4XzwwLGcl2Tm1Wmq3XIn+XGzClWQW/+7EYN2/mYhI7DVG8VS8upEMI7M36qN6MePCCkjcSNsV6sbpvXOIHE2D9xnjWJzQtnjA2JQJtTXK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=isK/HPGe; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749623457;
	bh=9HTZYOtLbn3hE7mHuNjiywNmhFd2Sw3QxLpZHg8L3AU=;
	h=From:Subject:Date:To:Cc;
	b=isK/HPGewrNpJc2HBz72Iml9hpdIxKKl5H7xUsYJ3DkmB/FJFeZ0bU+on+ISMW6r+
	 0d2w0k0StrIjRXS6EAMtVoKbh8O/J5DzD5vbzhMSroTw8Qt67CQ9R/5EDoulK2YAqO
	 6mUZjE/RJMENdYVC4oSPiA683tZyio467axzvM8NVmOSjALk3Wr6Q8lAdioWSNNUxD
	 7OeShpN0eg1NhIiGFF4327NB+aNIP+hRQcRGFoLW7qO/OnQh/2Xnfc1chuYwr+wXL2
	 o/zmHHcu03OYfPMEnGpZsXJpwoSB8pHmt1O7ER7U+2DAQsp4fLzI7LWgoBlsydDf/x
	 QuYBye4W9DEJw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id B47F467A3E; Wed, 11 Jun 2025 14:30:57 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next 00/13] net: mctp: Add support for gateway routing
Date: Wed, 11 Jun 2025 14:30:27 +0800
Message-Id: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIMiSWgC/x3MQQqEMAxA0atI1gbSqhS9irhwbKrZxCEVRxDvP
 sXlW/x/Q2YTzjBUNxifkmXXAldXsGyzrowSi8GT76jzhJFPTLv9ZouiK1Jwrg9NG+iToERf4yT
 XOxxB+UDl64Dpef6wOdUnagAAAA==
X-Change-ID: 20250520-dev-forwarding-0711973470bf
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

This series adds a gatweay route type for the MCTP core, allowing
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
Jeremy Kerr (13):
      net: mctp: don't use source cb data when forwarding, ensure pkt_type is set
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
 net/mctp/route.c           | 563 ++++++++++++++++++++++++++++--------------
 net/mctp/test/route-test.c | 604 +++++++++++++++++++++++++++++----------------
 net/mctp/test/sock-test.c  | 229 +++++++++++++++++
 net/mctp/test/utils.c      | 196 ++++++++++++++-
 net/mctp/test/utils.h      |  44 ++++
 8 files changed, 1307 insertions(+), 451 deletions(-)
---
base-commit: 0097c4195b1d0ca57d15979626c769c74747b5a0
change-id: 20250520-dev-forwarding-0711973470bf

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


