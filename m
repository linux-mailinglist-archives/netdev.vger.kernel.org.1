Return-Path: <netdev+bounces-111738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988B932662
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 14:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CDA1C2206E
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 12:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4C17B031;
	Tue, 16 Jul 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="H5PPjSsB"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BEF17CA08
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721132238; cv=none; b=KXVIoEmoGydEoiZYXhWGO0vYsGX42W/y8xi7tDhiHnkTcFLbOeZdrl+b9zP/kKvSt6oNo49z2+C9+HhYQwP6sIl6UCnW7b7QVKCDMNNS5jpiGxhXeslnFMGTiaFS8agQ/EXoVPz6XEOElBiavjbFBxGQpZmzeHtMYtsE6SR41Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721132238; c=relaxed/simple;
	bh=IG+VHMkG8Fhd7AMPVA4pHUwu/jPhoCaD1257wkjoVRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YP6TqvyjXksBE7FeEvED1o7WsKOYs54NKNUK0CyhIg0V5AXnbl8e6uzjqyzZUu5JZIuAvH8VRfhil3z0eBIUy1BubQXkvSbVFuilzKxi4Ki5xLaCYQGxpXEHuDJpzoZMoZguqdSvkPsU+i45X2GjIjHf5XevKsfZNGz/90s0uHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=H5PPjSsB; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id 24D565A0002;
	Tue, 16 Jul 2024 14:08:22 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rV9rOI7JOOW7; Tue, 16 Jul 2024 14:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1721131701;
	bh=IG+VHMkG8Fhd7AMPVA4pHUwu/jPhoCaD1257wkjoVRY=;
	h=From:To:Cc:Subject:Date:From;
	b=H5PPjSsBTpooNNhIUO5iqcqQHHfytIMtY0EERww6XqWe1djltS7VP1IV/4tF/wXFb
	 rXO3BuVPmx+7eIvfJX1ElFfh/J4bC8Y3U2IbYGulpPVxnWnOeGNOPP0xmjHCRwbp1Z
	 vuJdpBytQ08sKMKSO+KZREwfb3SNTRhPGO8LUZdW6CtKqS4g9Gd7D90SW6wEoISf2V
	 3LeYuyyBnZVZCXGWfE8YdY4S1gqx+u2LfokL/rcRvCNoSjLxwaHZ4jOE8s2JRwhfWG
	 eERKeHNk2tLdWIX66YeCZBRgvZBEU2XdN3TcgROhX6W0g9aGHYgSlf2y41Q2ZYdLed
	 /KPMKB45a4XXA==
Received: from think.wlp.is (unknown [185.12.128.225])
	by mail.codelabs.ch (Postfix) with ESMTPSA id EFD205A0001;
	Tue, 16 Jul 2024 14:08:20 +0200 (CEST)
From: Martin Willi <martin@strongswan.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: dsa: mv88e6xxx: Respect other ports when setting chip-wide MTU
Date: Tue, 16 Jul 2024 14:08:08 +0200
Message-ID: <20240716120808.396514-1-martin@strongswan.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DSA chips not supporting per-port jumbo frame size configurations use a
chip-wide setting. In the commit referenced with the Fixes tag, the
setting is applied just for the last port changing its MTU. This may
result in two issues:

  * Starting with commit b9c587fed61c ("dsa: mv88e6xxx: Include tagger
    overhead when setting MTU for DSA and CPU ports"), the CPU port
    accounts for tagger overhead. If a user port is configured after
    the CPU port, the chip-wide setting may be reduced again, as the
    user port does not account for tagger overhead.
  * If different user ports use different MTUs (say within different
    L2 domains), setting the lower MTU after the higher MTU may result
    in a chip-wide setting for the lower MTU, only.

Any of the above may result in clearing MV88E6185_G1_CTL1_MAX_FRAME_1632
while it is actually required for the current configuration on some (CPU)
ports. Specifically, on a MV88E6097 this results in dropped frames when
setting the MTU to 1500 and sending local full-sized frames over a user
port.

To respect the MTU requirements of all CPU and user ports, get the maximum
frame size requirements over all ports when updating the chip-wide
setting.

Fixes: 1baf0fac10fb ("net: dsa: mv88e6xxx: Use chip-wide max frame size for MTU")
Signed-off-by: Martin Willi <martin@strongswan.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 07c897b13de1..c231c956bf9a 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3604,9 +3604,19 @@ static int mv88e6xxx_get_max_mtu(struct dsa_switch *ds, int port)
 	return ETH_DATA_LEN;
 }
 
+static int mv88e6xxx_get_port_mtu(struct dsa_port *dp)
+{
+	if (dsa_port_is_cpu(dp))
+		return dp->conduit->mtu;
+	if (dsa_port_is_user(dp) && dp->user)
+		return dp->user->mtu;
+	return 0;
+}
+
 static int mv88e6xxx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	struct dsa_port *dp;
 	int ret = 0;
 
 	/* For families where we don't know how to alter the MTU,
@@ -3626,8 +3636,14 @@ static int mv88e6xxx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	mv88e6xxx_reg_lock(chip);
 	if (chip->info->ops->port_set_jumbo_size)
 		ret = chip->info->ops->port_set_jumbo_size(chip, port, new_mtu);
-	else if (chip->info->ops->set_max_frame_size)
+	else if (chip->info->ops->set_max_frame_size) {
+		dsa_switch_for_each_port(dp, ds) {
+			if (dp->index == port)
+				continue;
+			new_mtu = max(new_mtu, mv88e6xxx_get_port_mtu(dp));
+		}
 		ret = chip->info->ops->set_max_frame_size(chip, new_mtu);
+	}
 	mv88e6xxx_reg_unlock(chip);
 
 	return ret;
-- 
2.43.0


