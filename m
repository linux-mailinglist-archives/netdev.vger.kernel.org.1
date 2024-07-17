Return-Path: <netdev+bounces-111853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B432B9339A5
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C902836F7
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 09:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33C33D994;
	Wed, 17 Jul 2024 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="aCHD06fC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5BE37160
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721207330; cv=none; b=GWOJDXk2xlg8ZDy1Hzkp/bhb6ofIxUb4tQMfF/VIt0/9dpEiEVgjKDXmiyBZFN42yfJh5Std911P5YmV0HvwOl+5PWZhMSSxAHGhg0UvrdHG77qNESUz6XE8gdNyAOTFLVcDQqXHnS0rFGXf/KzpmgmLuG2BR/hHijHpfLpKVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721207330; c=relaxed/simple;
	bh=sJFPH4SzOIchPvnOtl0r8sDlfrqVfDvjgzlzSpGuHPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbUUxnb3LNT/MHJMqckVlGZkpmZOmIO2/eU/tfPIIZL9eGJy8ehgKZT70FVrJfcNdU3e7NuSZZDZNJwub0S9h7H4NEuC/a794gnOpKpVKADMO9YI64+9Ffn8eECKtpN8djtTQk7gvdx2HUyOgzm9jTtIGXuWdeT9E8As/86huPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=aCHD06fC; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id 5E3905A0004;
	Wed, 17 Jul 2024 11:08:44 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZyNmjALlk2IG; Wed, 17 Jul 2024 11:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1721207323;
	bh=sJFPH4SzOIchPvnOtl0r8sDlfrqVfDvjgzlzSpGuHPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCHD06fCJ1iEwQbDglyY26AcgmfVTNXymAMN+Xkz3KrU/ykV7uh17tMv6tlon9GlL
	 iOtiEKTAJzqyDKnbb+3GF7xFzYVHNCxcXvMXJE1NVXfueba82/BCPO5gydkgfAcwbr
	 +LUosaazM+5tmzHl7oX2i6/ZuL1S+G2yyjAaWac3BPd8C6NV2TaEaeSh/Er2hR9k8F
	 scLZDR/5u7zHC/aXHJ2NeSovl3DgIryqwcHgGZUV+/W50b+RudfBqy4Wk6IM3ukwBG
	 dYnrsAF83u280wCqHNntnKB5IexWASd0IXeM+BiBGtzM/axYrBxjQHu3I2a2QovB1Q
	 gjR3wQ822m7qg==
Received: from think.home (unknown [185.12.128.224])
	by mail.codelabs.ch (Postfix) with ESMTPSA id 3DD105A0002;
	Wed, 17 Jul 2024 11:08:43 +0200 (CEST)
From: Martin Willi <martin@strongswan.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Murali Krishna Policharla <murali.policharla@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net v2 1/2] net: dsa: mv88e6xxx: Limit chip-wide frame size config to CPU ports
Date: Wed, 17 Jul 2024 11:08:19 +0200
Message-ID: <20240717090820.894234-2-martin@strongswan.org>
In-Reply-To: <20240717090820.894234-1-martin@strongswan.org>
References: <20240717090820.894234-1-martin@strongswan.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marvell chips not supporting per-port jumbo frame size configurations use
a chip-wide frame size configuration. In the commit referenced with the
Fixes tag, the setting is applied just for the last port changing its MTU.

While configuring CPU ports accounts for tagger overhead, user ports do
not. When setting the MTU for a user port, the chip-wide setting is
reduced to not include the tagger overhead, resulting in an potentially
insufficient maximum frame size for the CPU port. Specifically, sending
full-size frames from the CPU port on a MV88E6097 having a user port MTU
of 1500 bytes results in dropped frames.

As, by design, the CPU port MTU is adjusted for any user port change,
apply the chip-wide setting only for CPU ports.

Fixes: 1baf0fac10fb ("net: dsa: mv88e6xxx: Use chip-wide max frame size for MTU")
Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Martin Willi <martin@strongswan.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 07c897b13de1..5b4e2ce5470d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3626,7 +3626,8 @@ static int mv88e6xxx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	mv88e6xxx_reg_lock(chip);
 	if (chip->info->ops->port_set_jumbo_size)
 		ret = chip->info->ops->port_set_jumbo_size(chip, port, new_mtu);
-	else if (chip->info->ops->set_max_frame_size)
+	else if (chip->info->ops->set_max_frame_size &&
+		 dsa_is_cpu_port(ds, port))
 		ret = chip->info->ops->set_max_frame_size(chip, new_mtu);
 	mv88e6xxx_reg_unlock(chip);
 
-- 
2.43.0


