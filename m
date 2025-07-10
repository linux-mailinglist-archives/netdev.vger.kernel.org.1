Return-Path: <netdev+bounces-205706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A5DAFFCFA
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490B1642711
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614B28DB56;
	Thu, 10 Jul 2025 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jQl1u96N"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CBF28C842
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137771; cv=none; b=J3uKxPNUGn9xUyIfj9l4DWqidHQKS1rtZF3DaY1nz8RlHQrv4PhjcIqjusDj+aEozKw6ta8n38rfwzPn+Ow5BFIMIWuWNPIZxaZOtRxDrXakTHGrXwfXB5+jDBRofTNUucA4TSi0pw0gF96QC8cr6QbsvOKV//dc90CkVLUyOAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137771; c=relaxed/simple;
	bh=s7J6izHDbhVusU7xe/iwtM4Xn2cTJsUAqNoRx9oqBqw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ulzx4p2eHBBFRjQ3BvlKnD1GW72XrnGOxS29EkuROPh+QlXRmzi6cbU39E4j3HlCmhotxuPnkCvCUY1r3zOKEG7fQe/1yneOKzFvb5wXOxUrFhp4RjW9l0J08EamLT1CSw9Ralcon7MTuFfP9n8qPYWBYXqWn0/X0VAYqLEzFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jQl1u96N; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752137762;
	bh=ccKPaY1g/kgd1JByVBZbwiDElNqFJcdXep30u7HvQSc=;
	h=From:Subject:Date:To:Cc;
	b=jQl1u96NM+1Ivx41ezlxgSqaAvV2KY86D3WO/kaRCV3GhSeBucuuUDDtNixhvjFQ2
	 DHWqduCjUhSrffcHm2PB+lU8UOaDb7xQmJKLQ8LXkxbxpkoDKXq6l4IiDmg8hoD1yc
	 Yo5b3ouyp+QKL4CpN1zeh9G7I2QublwMBwwuYIFZCs62+IvqSzRIV895mG+EM/gZYf
	 YYNU1bdLMnp50ddVCRx9rH2gIA4+pA8BfXiw3b2ElYfBf3IJ+QcGybaD93NwABGJ6t
	 f2frPh7ucGFCPpsnO/WEYa6lVI0adzIUdWMMIVrVirihalq02CPe6yrpl8y0IjDwTI
	 rLYIwo6C/gxdw==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 02F306B217; Thu, 10 Jul 2025 16:56:02 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Subject: [PATCH net-next v4 0/8] net: mctp: Improved bind handling
Date: Thu, 10 Jul 2025 16:55:53 +0800
Message-Id: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABmAb2gC/33NPQ4CIRQE4KsYajH87Mpi5T2MxfJ4KIWwAdxoz
 N5dQkWj5WQm33xIxuQxk9PuQxKuPvsYahj2OwL3OdyQelszEUyMTApOH1AWanywFJXSx8nxiTl
 L6n5J6PyrWRcSsNCAr0Kutbn7XGJ6t5OVt755isnOWzll1BiFWoEYjlyeIVqEGHJJTygHiI/D/
 GzgKnpE9YioiDMz2gm4M4P9g8ge0T0iK4Iz6MkYN6IefyDbtn0BsLsVj0EBAAA=
X-Change-ID: 20250321-mctp-bind-e77968f180fd
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137761; l=3098;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=s7J6izHDbhVusU7xe/iwtM4Xn2cTJsUAqNoRx9oqBqw=;
 b=Vl8S/2R0leO2CGmJe5CJx1n3KcVoIjbGVb5iPrkhdrGKfAgF5Dsnm7x1+1SfrvGE5s+tZgCG5
 o90FSpWOTYdDT8yT9Tsu47Ax6pdCxrwHjJIKA6M+yd+di2bpCLaB8ap
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

This series improves a couple of aspects of MCTP bind() handling.

MCTP wasn't checking whether the same MCTP type was bound by multiple
sockets. That would result in messages being received by an arbitrary
socket, which isn't useful behaviour. Instead it makes more sense to
have the duplicate binds fail, the same as other network protocols.
An exception is made for more-specific binds to particular MCTP
addresses.

It is also useful to be able to limit a bind to only receive incoming
request messages (MCTP TO bit set) from a specific peer+type, so that
individual processes can communicate with separate MCTP peers. One
example is a PLDM firmware update requester, which will initiate
communication with a device, and then the device will connect back to the
requester process. 

These limited binds are implemented by a connect() call on the socket
prior to bind. connect() isn't used in the general case for MCTP, since
a plain send() wouldn't provide the required MCTP tag argument for
addressing.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
Changes in v4:
- Fix error path socket release in mctp_bind()
- Fix commit message Fixes: for mctp_test_route_extaddr_input
- Link to v3: https://lore.kernel.org/r/20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au

Changes in v3:
- Rebased to net-next
- kunit tests have been updated for MCTP gateway routing changes
- Bind conflict tests are now in the new mctp/tests/sock-test.c
- Added patch for mctp_test_route_extaddr_input kunit socket cleanup
  (fixes MCTP gateway routing change in net-next, required by tests in
  this series)
- Link to v2: https://lore.kernel.org/r/20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au

Changes in v2:
- Use DECLARE_HASHTABLE
- Remove unused kunit test case
- Avoid kunit test snprintf truncation warning
- Fix lines >80 characters
- Link to v1: https://lore.kernel.org/r/20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au

---
Matt Johnston (8):
      net: mctp: mctp_test_route_extaddr_input cleanup
      net: mctp: Prevent duplicate binds
      net: mctp: Treat MCTP_NET_ANY specially in bind()
      net: mctp: Add test for conflicting bind()s
      net: mctp: Use hashtable for binds
      net: mctp: Allow limiting binds to a peer address
      net: mctp: Test conflicts of connect() with bind()
      net: mctp: Add bind lookup test

 include/net/mctp.h         |   5 +-
 include/net/netns/mctp.h   |  20 ++++-
 net/mctp/af_mctp.c         | 148 +++++++++++++++++++++++++++++++---
 net/mctp/route.c           |  85 ++++++++++++++++----
 net/mctp/test/route-test.c | 194 ++++++++++++++++++++++++++++++++++++++++++++-
 net/mctp/test/sock-test.c  | 167 ++++++++++++++++++++++++++++++++++++++
 net/mctp/test/utils.c      |  36 +++++++++
 net/mctp/test/utils.h      |  17 ++++
 8 files changed, 637 insertions(+), 35 deletions(-)
---
base-commit: ea988b450690448d5b12ce743a598ade7a8c34b1
change-id: 20250321-mctp-bind-e77968f180fd

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


