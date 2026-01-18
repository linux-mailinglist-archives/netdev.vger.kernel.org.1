Return-Path: <netdev+bounces-250926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE0D39A3D
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 23:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 447D230080E5
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF6A3002D8;
	Sun, 18 Jan 2026 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY5OR5q8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E102E2FD7D5
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768774070; cv=none; b=kE0amQoSqVQJ7p3WHj3khRto6hr6GbLmW0evTgTJgT0yPl6wmQ71E2OEHcn6+Vg8Crg/v+sz37marHCzqg0FlSmiMIP2UJ8FdbZ3WzkZ5CelGBIk+Or1G83ctTOQkEpXd0pxxMU4NLbJ2w1GHbhz2GIXt9Ee4ckCmrviH4SpS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768774070; c=relaxed/simple;
	bh=nly2BsUTWXdKfhE/cjmvmuU8HIFEayixTBYvU1BVqzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mEJIEifpKY+w0yUtlqDl64Eu3eZd+LwtmisTtMVWqeSUenMqIPFRSCLPhN7sEqpZheO2oO6pIQDqT3WwhvbXRPzHIdvcQLhfDb/4yR7GsMXQ+TSTbLmv5aikTgK4huFBqtVIMYjylerwP8GHpNayhAiax2zusooW8UF6zl2BSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY5OR5q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C8CC19423;
	Sun, 18 Jan 2026 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768774069;
	bh=nly2BsUTWXdKfhE/cjmvmuU8HIFEayixTBYvU1BVqzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NY5OR5q8ap6IvZOG8BWlL7PeyFY/OoylaXEAvOCLEP3xp6X0w98Lx/Cak3enRktFI
	 hqIxe6sPhI+sQD4pDZJaCttbumeKDfXfxR9p5YkFWgXGPmawIETqKDPQWpsc5EoCuU
	 YvLdvVdyW4ZCLWw9+TTrMLb9FVvp53qwIYDG9SjCwwABPbhEBmLXhwXTmSxXhfWXyH
	 a6FWGeefJ7ao3k7lI3ERy8kXPMniKGbmxtdvp5OdLmQ+N4YO8g4GfZTtmOl13qhTPB
	 oliDWx4mk/w4uMn6cspy5baxI59I/tgQqhB7D8s37yj3vSvdn1D+ismTGoINGtNGmI
	 /LYesxO9Zn3Sw==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 18 Jan 2026 23:07:33 +0100
Subject: [PATCH net-next 3/4] net: dsa: ks8995: Add stub bridge join/leave
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-ks8995-fixups-v1-3-10a493f0339d@kernel.org>
References: <20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org>
In-Reply-To: <20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Implementing ks8995_port_pre_bridge_flags() and
ks8995_port_bridge_flags() without port_bridge_join()
is a no-op.

This adds stubs for bridge join/leave callbacks following
the pattern of drivers/net/dsa/microchip/ksz_common.c:
as we have STP callbacks and these will be called right
after bridge join/leave these will take care of the
job of setting up the learning which is all we support.

Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/ks8995.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index 5ad62fa4e52c..060bc8303a14 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -461,6 +461,26 @@ static void ks8995_port_disable(struct dsa_switch *ds, int port)
 	dev_dbg(ks->dev, "disable port %d\n", port);
 }
 
+static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
+				   struct dsa_bridge bridge,
+				   bool *tx_fwd_offload,
+				   struct netlink_ext_ack *extack)
+{
+	/* port_stp_state_set() will be called after to put the port in
+	 * appropriate state so there is no need to do anything.
+	 */
+
+	return 0;
+}
+
+static void ks8995_port_bridge_leave(struct dsa_switch *ds, int port,
+				     struct dsa_bridge bridge)
+{
+	/* port_stp_state_set() will be called after to put the port in
+	 * forwarding state so there is no need to do anything.
+	 */
+}
+
 static int ks8995_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 					struct switchdev_brport_flags flags,
 					struct netlink_ext_ack *extack)
@@ -635,6 +655,8 @@ static int ks8995_get_max_mtu(struct dsa_switch *ds, int port)
 static const struct dsa_switch_ops ks8995_ds_ops = {
 	.get_tag_protocol = ks8995_get_tag_protocol,
 	.setup = ks8995_setup,
+	.port_bridge_join = ks8995_port_bridge_join,
+	.port_bridge_leave = ks8995_port_bridge_leave,
 	.port_pre_bridge_flags = ks8995_port_pre_bridge_flags,
 	.port_bridge_flags = ks8995_port_bridge_flags,
 	.port_enable = ks8995_port_enable,

-- 
2.52.0


