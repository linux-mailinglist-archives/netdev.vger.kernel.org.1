Return-Path: <netdev+bounces-205306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E61AFE2AA
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700CB3A5EF1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C2277031;
	Wed,  9 Jul 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Yh3d9S3c"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0FE274B48
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049890; cv=none; b=NePYO25bMfsIiitspb5NvoOyCkaHnL0UUT7151g7d7srsDC0E1QIQxT2MgeuYvAGIx3lY+m+YcB780uKjkGwV7Nl5TsMmgnYIOkZs5UV4L+VLI9M0uetgR6xH8GXDgNdPB6LgBFTGb0MlQPBt/wGbuZIjpH3UGlVFgrlVO+L6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049890; c=relaxed/simple;
	bh=8Cc8vYayrEg/fUhvqL8UmdMZ45EOHGUlbb01UjvmRjU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c9qBEyfgPVcK+opVvbHyeW9q8ANl8kmq6C08oeei8N2PdvxIZsAsiNjM4yHkk2zDyXpnPLTvejrsKCVYVTgaQFwV58PcrVft/nGbDhdjkWq2x5K6wx5EHtmbdkZ8v1eS05tvdykmkGJZXkr/E1Czxugt43sdFvS3TrO9g/qKfYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Yh3d9S3c; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752049879;
	bh=ITrxfJWGyQsJ3Vn/O+6zvqyFnyfIsfGYltnS0fvPwp8=;
	h=From:Subject:Date:To:Cc;
	b=Yh3d9S3cum4urUeWq1W6W0TeJ0qwSfqw1irBqCaGq7fA6lxQOnVAed/M2YURZwhnx
	 2UMLMJHShmSSNE5tIJbk33DNWRcTYFc0EnhOQfbEoKJx1hm5SCxURLeFxzjPusv3u9
	 N05VabO56NV5WoR3Bh8jTFhPnyEIMXqKAI3U16/jXnJyy8iB6s2FLSpdt0tnLYpW6Y
	 bW0/uEfYMNc1Sy9o+9vRYvmGcHlRG8wnhxFFmv+SQImGdGG0FqgO34WI2irM3P0rZI
	 drFf+ecx9S9sqCaI+LVbq2+l4IkFv5lRSIp42wFWnitg+SRq5Nq/l7zhkCW6qZzHdc
	 3AJ6hoR7wMFFw==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 4E73B6B153; Wed,  9 Jul 2025 16:31:19 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Subject: [PATCH net-next v3 0/8] net: mctp: Improved bind handling
Date: Wed, 09 Jul 2025 16:31:01 +0800
Message-Id: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMUobmgC/3XNvQ6DIBwE8FcxzMXwYUU79T2aDgJ/KoNgAImN8
 d1LmFw6Xu7yuwNFCBYiejQHCpBttN6VwG8NUvPkPoCtLhkxwu6EM4oXlVYsrdMYhBj7wdCBGI3
 Kfg1g7F6tF3KQsIM9oXdpZhuTD996kmntqycIv3iZYoKlFDAKxbqe8qfyGpR3MYVNpVb5pZ22C
 mZ2RcQVYQUxcgI9KGpkp/8g53n+ANHHW1r8AAAA
X-Change-ID: 20250321-mctp-bind-e77968f180fd
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752049878; l=2870;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=8Cc8vYayrEg/fUhvqL8UmdMZ45EOHGUlbb01UjvmRjU=;
 b=0io8gpkGC69qpuZjtTXeZP60KbmKWS+iKJI/aZswOxHUam1LR4BR+OjBwnieFgjt5W0m17jrV
 x31GNb2oM6kAKzx2SWLpWZoJZ4WJWd5oIeNKPCqKuang0oACsl5n4dM
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
 net/mctp/af_mctp.c         | 146 +++++++++++++++++++++++++++++++---
 net/mctp/route.c           |  85 ++++++++++++++++----
 net/mctp/test/route-test.c | 194 ++++++++++++++++++++++++++++++++++++++++++++-
 net/mctp/test/sock-test.c  | 167 ++++++++++++++++++++++++++++++++++++++
 net/mctp/test/utils.c      |  36 +++++++++
 net/mctp/test/utils.h      |  17 ++++
 8 files changed, 635 insertions(+), 35 deletions(-)
---
base-commit: ea988b450690448d5b12ce743a598ade7a8c34b1
change-id: 20250321-mctp-bind-e77968f180fd

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


