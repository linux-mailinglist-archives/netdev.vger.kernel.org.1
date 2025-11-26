Return-Path: <netdev+bounces-241978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF50C8B3E0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A371C4E34C0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2C633C519;
	Wed, 26 Nov 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="VFfT63/p"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A4312829;
	Wed, 26 Nov 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178602; cv=none; b=DG8EZJrV8yC3y/CwRwVojoX+y8dsIlwlw65VMjzY6qKTfCWeG+/ecAGE2bss2CH6HpaKWb8n2kgsM0bVSJssXqpIsk+K+2DsXEgWi1LV//VOyj9FEHqS4CATQEE77zzTJhiH0QoTb4epOUZKiEIooTQi81X3pbJuRgvyOU4YiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178602; c=relaxed/simple;
	bh=Q4Z3868li/A6eo5IRbSWBw0t5W/8hZllqn00nGowgW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6EvcpILjptznD1erTVYDk9Fo4+Fm3BdgPIhSA9yg7XrqjJ5Op9rCCCaRG+JiJ8kxJE7ENe+FIsPrNj09hLMhPAY9e7MLx486tBSd+AOCPISjBEBv174Ato3nOGdyY2tum1UkVMwK/Ba/jGkXpzbDfozKagS6ycbT2N5D91aH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=VFfT63/p; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764178585;
	bh=Q4Z3868li/A6eo5IRbSWBw0t5W/8hZllqn00nGowgW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFfT63/ph1wB57vgLEqoDxil+r+c6Z08EeLhSUQ4Mvfk4X31y8n0CW8zVtdLCuJyC
	 5lyCCrUG5ybGLd+tbPxR5OpFzXEhFE7LdP0ZR14jQYnm+FWyDYjDwiWuIB++aaR9Pm
	 K+TWIFZY0E98RCCjJUKFkASStPApH14ZsA7xZ8bC5aK/mJ9TVK3Phe/z6+Tr6PUEdr
	 P0redFdjRLzc/WOpIXnA7H9jlsyQloRJ2tWA/cCJQafpxgjUp0Z1HwTRZxcbapvnMP
	 KUAN8jIEYcpHRn2/ur7qtJ2ywvk4Ub3GXNtW0yVdVFJXz5TuOhf7zlG8VBxQQOqVJw
	 p4BwI8KAo+/KQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id A590360112;
	Wed, 26 Nov 2025 17:36:25 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id EFB392032B7; Wed, 26 Nov 2025 17:35:50 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: [PATCH wireguard v4 04/10] wireguard: netlink: lower .maxattr for WG_CMD_GET_DEVICE
Date: Wed, 26 Nov 2025 17:35:36 +0000
Message-ID: <20251126173546.57681-5-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126173546.57681-1-ast@fiberby.net>
References: <20251126173546.57681-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Previously .maxattr was shared for both WG_CMD_GET_DEVICE and
WG_CMD_SET_DEVICE. Now that it is split, then we can lower it
for WG_CMD_GET_DEVICE to follow the documentation which defines
.maxattr as WGDEVICE_A_IFNAME for WG_CMD_GET_DEVICE.

$ grep -hC5 'one but not both of:' include/uapi/linux/wireguard.h
 * WG_CMD_GET_DEVICE
 * -----------------
 *
 * May only be called via NLM_F_REQUEST | NLM_F_DUMP. The command
 * should contain one but not both of:
 *
 *    WGDEVICE_A_IFINDEX: NLA_U32
 *    WGDEVICE_A_IFNAME: NLA_NUL_STRING, maxlen IFNAMSIZ - 1
 *
 * The kernel will then return several messages [...]

While other attributes weren't rejected previously, the consensus
is that nobody sends those attributes, so nothing should break.

Link: https://lore.kernel.org/r/aRyLoy2iqbkUipZW@zx2c4.com/
Suggested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/wireguard/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index e7efe5f8465dc..c2d0576e96f5f 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -623,7 +623,7 @@ static const struct genl_split_ops wireguard_nl_ops[] = {
 		.dumpit = wg_get_device_dump,
 		.done = wg_get_device_done,
 		.policy = device_policy,
-		.maxattr = WGDEVICE_A_PEERS,
+		.maxattr = WGDEVICE_A_IFNAME,
 		.flags = GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	}, {
 		.cmd = WG_CMD_SET_DEVICE,
-- 
2.51.0


