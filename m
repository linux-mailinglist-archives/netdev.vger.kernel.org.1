Return-Path: <netdev+bounces-111852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054839339A4
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3A51C20D00
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 09:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9DC3BBCB;
	Wed, 17 Jul 2024 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="GawDM/DO"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44A38F97
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721207330; cv=none; b=nfvaZm+IJ0BzRy4vsoD94E4cmItA+uItYSsidz5hM2YVAzfHD1mTUZHWMF0+rKZHlvZhYza540g6P/+1PWWDBZ4DYuEGpD4MI4vWk7HIx6PRPB0y3qL89NyhYNd/MMBj+f1a85nk06u3f3NYTNvczsrAk4E71zST5/59XPBjtck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721207330; c=relaxed/simple;
	bh=N42cqY0I8yT6ZfvI+LElwDnJf0ppkaP3hiNRDj9hcFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9hXnsyNnAMhUSjN5kvJsMjJsYD71doW6RPT+2Lz/92t9MDVIso9GjOrZFzO0/wD6LDy6oCeuwz3ghmDCwT6FXbbXU5qewL4HD1D9bRCeR4E3KV8QjW0rHwBXMPFemJ+o2UjuRrMxiLwI5rvPRoPXzE9l5uwkDGOsuvxn5Kk1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=GawDM/DO; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id 50E4F5A0001;
	Wed, 17 Jul 2024 11:08:45 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dkFK9lWPNmfj; Wed, 17 Jul 2024 11:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1721207323;
	bh=N42cqY0I8yT6ZfvI+LElwDnJf0ppkaP3hiNRDj9hcFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GawDM/DOxjnPF3LkO8t32e2cK+TK5/9P+miE50q22aKXj+/KoOfrr97uXYptYEsXM
	 fMNe5OUBUFdLhs7n5soRaZnEJFdteYpFlTa8OfKpgD76EDQV/kIsaATh+IF8O9jSVM
	 ezXiDbs/8tkIb0hIqer4ydU7xKZQH17VDyFYHS1BeR91WiF0EPe4gZhVem3OcLpL6W
	 eRFh09kjoY0uNF8yc2FK1NfqNx/3fh+lD9fjzZDuMNC8gPhVMSz+4qDCSX7oviDiaI
	 lKa/PWleDLXvV/tmgvOxlKgZnEOBjG1hB9UF5K9zDihBM4/Dy6bzmasT9mjWb4c2nI
	 RGRG2LZqWLMpQ==
Received: from think.home (unknown [185.12.128.224])
	by mail.codelabs.ch (Postfix) with ESMTPSA id 655075A0003;
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
Subject: [PATCH net v2 2/2] net: dsa: b53: Limit chip-wide jumbo frame config to CPU ports
Date: Wed, 17 Jul 2024 11:08:20 +0200
Message-ID: <20240717090820.894234-3-martin@strongswan.org>
In-Reply-To: <20240717090820.894234-1-martin@strongswan.org>
References: <20240717090820.894234-1-martin@strongswan.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Broadcom switches supported by the b53 driver use a chip-wide jumbo frame
configuration. In the commit referenced with the Fixes tag, the setting
is applied just for the last port changing its MTU.

While configuring CPU ports accounts for tagger overhead, user ports do
not. When setting the MTU for a user port, the chip-wide setting is
reduced to not include the tagger overhead, resulting in an potentially
insufficient chip-wide maximum frame size for the CPU port.

As, by design, the CPU port MTU is adjusted for any user port change,
apply the chip-wide setting only for CPU ports. This aligns the driver
to the behavior of other switch drivers.

Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Martin Willi <martin@strongswan.org>
---
 drivers/net/dsa/b53/b53_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 8f50abe739b7..0783fc121bbb 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2256,6 +2256,9 @@ static int b53_change_mtu(struct dsa_switch *ds, int port, int mtu)
 	if (is5325(dev) || is5365(dev))
 		return -EOPNOTSUPP;
 
+	if (!dsa_is_cpu_port(ds, port))
+		return 0;
+
 	enable_jumbo = (mtu >= JMS_MIN_SIZE);
 	allow_10_100 = (dev->chip_id == BCM583XX_DEVICE_ID);
 
-- 
2.43.0


