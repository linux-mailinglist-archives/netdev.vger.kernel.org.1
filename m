Return-Path: <netdev+bounces-185938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42483A9C32A
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B336D927527
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889A42343AF;
	Fri, 25 Apr 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcMWUsOY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D287230BC2;
	Fri, 25 Apr 2025 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572798; cv=none; b=phuRWLVIo8E71iHvekB9gnZuUWBCQ3fJATqwP0rx0AHqD701XMCDbsoEJL9aiLWUJz+6f1iMm4xRmNpUsLNXtzAVLRYzULLW92vuzce0z78QgCt+qFGqJwgviI5EwSf4sjyl5fP2M1hgG/k4/i3UkXtaLXgMuB0qzUg+3T12ufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572798; c=relaxed/simple;
	bh=s+UM6pisdmKw4N9/rscRvpbQV5hWX+gCZWCLZQIJwcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pl3IRGVVdSNhgOZ8ELNYl5omwwuzqbPEu+1BGx2OFmd5yJ4ryi6+IcRrmLydCik3SsiUoRLIXfBos05batimMq80mU1UZGfyFTW2wfArlI0fMtsZD5qH24LoDiT0+HEoV9FyhatV3kzfptdBFv4y4b4vOXz5SUPveU3NnKlySpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcMWUsOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4C27C4CEE4;
	Fri, 25 Apr 2025 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745572797;
	bh=s+UM6pisdmKw4N9/rscRvpbQV5hWX+gCZWCLZQIJwcQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=QcMWUsOY+tfg+yMSUeRa0AJAjh2uSxwqe6c3JH4/d60hO20ZOglqn5AS28oQRnNyH
	 OpXkDSpy9HrsN9SWaT1QhlhNPRnz0KnMOHifrGtw1idvHzjzpeGZFq2y+uk2tCdZRL
	 heWBumAI+X+oJ8/G/RiAIQc1WEpDA/0aKOFB6oTh8IbBHt7ZfdtGlJ4cIIzDJ32Pwm
	 42Mjcr02GaAtQc6AM1V7bLSOK6dgXZbDYEhvNaRPrLDAA/SJ3OjEzVjAsQ8aKUQOSp
	 5mHbu7lZCuZJcdqgrecpfXTrdPDtokYJ4oJmZDlZ4QtZjF9xb6Ysq/t9JIr762QvWk
	 QCSjJHnAXX5LA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA72C369D1;
	Fri, 25 Apr 2025 09:19:57 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 25 Apr 2025 13:19:28 +0400
Subject: [PATCH v2] net: dsa: qca8k: fix led devicename when using external
 mdio bus
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-qca8k-leds-v2-1-b638fd3885ca@outlook.com>
X-B4-Tracking: v=1; b=H4sIAJ9TC2gC/22MQQ7CIBBFr9LMWkwHpLGuvIfpAmFqJ61FoRJNw
 93Frl38xfvJeytECkwRTtUKgRJH9nMBuavADma+kWBXGGQtdX2QWjytOY5iIheF0qTw2hqFbQ9
 FeATq+b3FLl3hgePiw2drJ/y9fzMJBYpGYWOcKpPy7F/L5P24t/4OXc75C4PqVLmmAAAA
X-Change-ID: 20250425-qca8k-leds-35e31b9a319f
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745572796; l=3435;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=ydGK36Kl5X3P/v+3CwPypXc8oDZyqDCNEcnQKXNutFA=;
 b=M4+pevfUAbWEi3MH1shAmBryPB6xZcVeewXJQthY8K/LnKGCjAm5MZD+k9aHotIPA/Rb6PEPN
 SGaAHTo0uWVBjuck36b1/Fa4nk6RbYnvbqZwaXZnuR45en4ILAEFpS3
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

The qca8k dsa switch can use either an external or internal mdio bus.
This depends on whether the mdio node is defined under the switch node
itself and, as such, the internal_mdio_mask is populated with its
internal phys. Upon registering the internal mdio bus, the slave_mii_bus
of the dsa switch is assigned to this bus. When an external mdio bus is
used, it is left unassigned, though its id is used to create the device
names of the leds.
This leads to the leds being named '(efault):00:green:lan' and so on as
the slave_mii_bus is null. So let's fix this by adding a null check and
use the devicename of the external bus instead when an external bus is
configured.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
Fix the led device names when an external mdio is configured.
The current codepath for registering led device names 'assumes' that the
internal mdio bus is used. Therefore, add a check and fallback to the
device name of the external mdio bus while creating the led device
names.

Wrong device names:
root@OpenWrt:~# ls -l /sys/class/leds                                           
lrwxrwxrwx    1 root     root             0 Jan  1  1970 (efault):00:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n
lrwxrwxrwx    1 root     root             0 Jan  1  1970 (efault):01:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n
lrwxrwxrwx    1 root     root             0 Jan  1  1970 (efault):02:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n

Correct device names:
root@OpenWrt:~# ls -l /sys/class/leds                                                                                                                      
lrwxrwxrwx    1 root     root             0 Jan  1  1970 90000.mdio-1:00:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n
lrwxrwxrwx    1 root     root             0 Jan  1  1970 90000.mdio-1:01:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n
lrwxrwxrwx    1 root     root             0 Jan  1  1970 90000.mdio-1:02:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n
---
Changes in v2:
- Fixed c/p error from older kernel version: slave_mii_bus was renamed
  to internal_mdio_bus
- Link to v1: https://lore.kernel.org/r/20250425-qca8k-leds-v1-1-6316ad36ad22@outlook.com
---
 drivers/net/dsa/qca/qca8k-leds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index 43ac68052baf9f9926aaf4a9d8d09640f9022fcd..ef496e345a4e7dd5b9fb805b8e0ff3cce56e2986 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -429,7 +429,8 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
 		init_data.fwnode = led;
 		init_data.devname_mandatory = true;
 		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d",
-						 priv->internal_mdio_bus->id,
+						 priv->internal_mdio_bus ?
+						 priv->internal_mdio_bus->id : priv->bus->id,
 						 port_num);
 		if (!init_data.devicename) {
 			fwnode_handle_put(led);

---
base-commit: 02ddfb981de88a2c15621115dd7be2431252c568
change-id: 20250425-qca8k-leds-35e31b9a319f

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



