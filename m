Return-Path: <netdev+bounces-136175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057DB9A0C9E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365E91C20FC0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFD81442F6;
	Wed, 16 Oct 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPo+VqeY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E503C6BA;
	Wed, 16 Oct 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089081; cv=none; b=SSaDEaTH81PJgbtFNox1iBdwu7BgnQ7gEuWqNd7pK+nnb+7qfjIN3atnYoDR7rsJ53EgLmAAH0EkHvO+PfjKCU3JvVrMiD34XV9qMkJwFKk/iJ7GkbcAmYdGsijB0zr/ZYBdfN67+oKx0ChaoqRt1SDIO0xXMfdWJFPipNsQcyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089081; c=relaxed/simple;
	bh=Mizpp8oFpRiGDwCGbovxq5aGDaGwDmQgZOgsWOoWv3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fTSGfV9TUht/Ao/Curw9i5Xs/I1rFhraYJVpZbo8mN56bnBOyLEXj6fWrtghjGXgIpbWNjDgfqS+A5GWXKqh7TD2Tr5NATH0NJjzdRQIZ0bYVSjYuaSA5iXIK0mjcpiEtcA8qxFoSiHUDtvLjCbHcwXnCLLTzYSJs5/q9cqNDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPo+VqeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4298DC4CEC5;
	Wed, 16 Oct 2024 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729089081;
	bh=Mizpp8oFpRiGDwCGbovxq5aGDaGwDmQgZOgsWOoWv3Y=;
	h=From:Date:Subject:To:Cc:From;
	b=RPo+VqeYw4iS7d99pz4WLddaEuB/18LdVOJkzAoB2hk64/OGUzofmIBh/sSJ+33fu
	 QH9VVokhDs7hK1Sk8dlwYEn4lFh5rUjva0JbnHpg7YAnldfGDDcKwC9Xc1V/E9xbed
	 6Ompd8MXF0f3aKjZaVjB9B/vm9A8naNDOe8tcKrbfOaPsclCP67meHqpjTKqHYM5zN
	 yXIMioegQsDnzKT0+RXkp1WeWDyQ81vehRb6VlWBQK72/2nf3yvPIPhUXDASU8vytB
	 ZOosG2Yuh/nBTIJb59ms4Cc8IFn6FV/jFrvB0snCbU1szldqFtJgm/iUSGmTKSc5+h
	 jCWYcDj84WCBQ==
From: Simon Horman <horms@kernel.org>
Date: Wed, 16 Oct 2024 15:31:14 +0100
Subject: [PATCH net-next] net: usb: sr9700: only store little-endian values
 in __le16 variable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-blackbird-le16-v1-1-97ba8de6b38f@kernel.org>
X-B4-Tracking: v=1; b=H4sIADHOD2cC/x3MQQqAIBRF0a3EHydoRlFbiQZZr/oUFhohiHtPG
 p7BvZE8HMNTX0RyeNnzZTNUWdC8T3aD4CWbKlnVSqpGmHOaD8NuEScyldGAblp0XUs5uh1WDv9
 wIItHWISHxpQ+i6BrBWoAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

In sr_mdio_read() the local variable res is used to store both
little-endian and host byte order values. This prevents Sparse
from helping us by flagging when endian miss matches occur - the
detection process hinges on the type of variables matching the
byte order of values stored in them.

Address this by adding a new local variable, word, to store little-endian
values; change the type of res to int, and use it to store host-byte
order values.

Flagged by Sparse as:

.../sr9700.c:205:21: warning: incorrect type in assignment (different base types)
.../sr9700.c:205:21:    expected restricted __le16 [addressable] [usertype] res
.../sr9700.c:205:21:    got int
.../sr9700.c:207:21: warning: incorrect type in assignment (different base types)
.../sr9700.c:207:21:    expected restricted __le16 [addressable] [usertype] res
.../sr9700.c:207:21:    got int
.../sr9700.c:212:16: warning: incorrect type in return expression (different base types)
.../sr9700.c:212:16:    expected int
.../sr9700.c:212:16:    got restricted __le16 [addressable] [usertype] res

Compile tested only.
No functional change intended.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/usb/sr9700.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index cb7d2f798fb4..091bc2aca7e8 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -177,9 +177,9 @@ static int sr9700_get_eeprom(struct net_device *netdev,
 static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	__le16 res;
+	int err, res;
+	__le16 word;
 	int rc = 0;
-	int err;
 
 	if (phy_id) {
 		netdev_dbg(netdev, "Only internal phy supported\n");
@@ -197,14 +197,14 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
 		if (value & NSR_LINKST)
 			rc = 1;
 	}
-	err = sr_share_read_word(dev, 1, loc, &res);
+	err = sr_share_read_word(dev, 1, loc, &word);
 	if (err < 0)
 		return err;
 
 	if (rc == 1)
-		res = le16_to_cpu(res) | BMSR_LSTATUS;
+		res = le16_to_cpu(word) | BMSR_LSTATUS;
 	else
-		res = le16_to_cpu(res) & ~BMSR_LSTATUS;
+		res = le16_to_cpu(word) & ~BMSR_LSTATUS;
 
 	netdev_dbg(netdev, "sr_mdio_read() phy_id=0x%02x, loc=0x%02x, returns=0x%04x\n",
 		   phy_id, loc, res);


