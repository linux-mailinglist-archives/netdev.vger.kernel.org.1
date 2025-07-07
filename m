Return-Path: <netdev+bounces-204463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8058AFAB42
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8A43B9959
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 05:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1942750EE;
	Mon,  7 Jul 2025 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="B2yNovs/"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313113AA3C
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867728; cv=none; b=BLvx86G31dJlnlOp5j5N36mkd55Yltxx7/XoxU1PO7ePQqYe7GFa0x+J5x0kBgkdbKNhAeI9QyFd9s8YRaHpsPJ2/yxyWdVUnsjXdf7vif7iHbig5ot4wk+WS5LZb5R8M3xYrid9V8YdGvmpwRM78U4z/6mWBFuFkVgwSzT7P2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867728; c=relaxed/simple;
	bh=Vb6VkOgzjujFji5071M4oTCuyvHuD4xgSnzvE5wuLqo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KnTSeZvh5oZV7WBXZ7YZ1rrogqfpV0ZRl7r91omMWi5Dsfih8iX0E05QeH3mBXewdxW7MOICkXcZZKQgET8L7fsDXvFov5td6e/RYc9DEQjouLScEb0rLBZLld/Ki5dqNKG7wZHQETnsKSbOBfM0ZQndfpD/6MwjqEcwkqGqx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=B2yNovs/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751867718;
	bh=ElKvaRimuAR6o8UDcSeevR5NXv9RIltcpu92Px2grv8=;
	h=From:Subject:Date:To:Cc;
	b=B2yNovs/U4FHotpAiV2VL1S5ssnG/ko0okckFI/mKL6nkwmGWZJ0D6gQMcnSICAws
	 E6OHOmtY1b5nlJw+GJiJ2Fz+9G1I0OgFTntnvIDJklQii/66ut6aR5s/MY5/B4c3L0
	 O/uH4M0hk2yIc61mZIeaFQ7ikEx7//jT58mXN6eN4DzaEJdT56LSndpeQNoP8DczBY
	 ddj7vdlXakV/heb51vimPLhRuHhkeR9g0+1gBNK0beLi1Eeh6XnUnR+DKjS1Wwyu5Q
	 DyxEecdoEtGL30v5hI04wtVsetr4lfrdQLQd192VMwBVAiIqPmEBgkNKHE9AbqAw1L
	 cdv44TOhyuymg==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 342246AC76; Mon,  7 Jul 2025 13:55:18 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Subject: [PATCH net-next v2 0/7] net: mctp: Improved bind handling
Date: Mon, 07 Jul 2025 13:55:13 +0800
Message-Id: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEFha2gC/02NwQ6DIBAFf8XsuWsAW9Ge+h+NB4G1chAMoLEx/
 nsJpx4n8zLvhEjBUoRndUKg3UbrXQZxq0DPo/sQWpMZBBMP1giOi04rKusMkpR92028Y5OBvF8
 DTfYorTc4SujoSDBkM9uYfPiWk50XX3qSNX+9nSNDpST1Uot7y5uX9oa0dzGFTada+6UeNxiu6
 /oBQ/muTrcAAAA=
X-Change-ID: 20250321-mctp-bind-e77968f180fd
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751867717; l=2369;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=Vb6VkOgzjujFji5071M4oTCuyvHuD4xgSnzvE5wuLqo=;
 b=y76VNFkGMSaDzCz8SbY7VStXLawLPqoqx/Pdo91XJ/UNFMLc0RONi/4P0HuC4BlQvdYMm4QYY
 ZF26ioeUXgyB7NuEXe0xYGwNIIZvP60VpgUPP6PyUC70Yb7FbM2dsIN
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

route-test.c will have non-trivial conflicts with Jeremy's in-review
"net: mctp: Add support for gateway routing" series - I'll post an
updated series once that lands.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
Changes in v2:
- Use DECLARE_HASHTABLE
- Remove unused kunit test case
- Avoid kunit test snprintf truncation warning
- Fix lines >80 characters
- Link to v1: https://lore.kernel.org/r/20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au

---
Matt Johnston (7):
      net: mctp: Prevent duplicate binds
      net: mctp: Treat MCTP_NET_ANY specially in bind()
      net: mctp: Add test for conflicting bind()s
      net: mctp: Use hashtable for binds
      net: mctp: Allow limiting binds to a peer address
      net: mctp: Test conflicts of connect() with bind()
      net: mctp: Add bind lookup test

 include/net/mctp.h         |   5 +-
 include/net/netns/mctp.h   |  20 ++-
 net/mctp/af_mctp.c         | 146 +++++++++++++++-
 net/mctp/route.c           |  85 ++++++++--
 net/mctp/test/route-test.c | 411 ++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 635 insertions(+), 32 deletions(-)
---
base-commit: f20f4b056e747230050cb1c4f287a03ec3838abb
change-id: 20250321-mctp-bind-e77968f180fd

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


