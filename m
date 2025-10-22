Return-Path: <netdev+bounces-231593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0638BBFB144
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12667347B14
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D593128B2;
	Wed, 22 Oct 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Dx0jM4j/"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011130F54C;
	Wed, 22 Oct 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124148; cv=none; b=mH3yiTA2aUqiqiogm27sHZpKCJbYbyYLzjPCk/T112EJbgrW6r3Z9oe404JHKChVNorGe5p5pGiQTcRxm5oT/x4Mcu1lU5TG48iUHorZURwrnFv5qilGWntJ0H1wq0DinfvYRQ86opoErcDiG3JUSaBDHhi3cx4d9OFhewIDZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124148; c=relaxed/simple;
	bh=koZWgXQnn7LJHWsl2Nzqfl4WDuL8ilxpvvzc4qg4vxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdHcR+AnttEhBamgTmWvQhkB9nnPEGz3u12mxwZclOFDYnH6iFR0qBVgFd2qWAIgSpgnTOTvNjqkuUaZUy+D84IS48BXo6XO2xPnBiN5E+mv4qqj79bH6PObEep4YyZ8+SNH1YDVuzASEfmnhWvhrrVOz5iXmzTG2v9RUk9XMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Dx0jM4j/; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 2AB9DA0AB4;
	Wed, 22 Oct 2025 11:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=+lVcfQnH5Z5cT64ywzQO
	ZUW2kZQFOrzn08/uddow9Yg=; b=Dx0jM4j/Rrq9tvwIYVdhlUPGsLeBJoDXmfAg
	b0kMB+5tqm8PR1SY9ayHkuAO9ia7xfg1fRUe5zVMdFmvqes9ERrqmR2q5L7Sb/7c
	C2vf5kiRBkbI+JSiZ2J8y7UXbjZiwv4bLTBdrUsS2+y76XcyqLhA+leRFDi+si0J
	bLtzzs/D8RH/iQuvGaCGX0HPt/nnJtajCM931aEaF6gn4gMqynJnkLi1kCb+NDVB
	w3GKqt1zlLMHxPbHCWXxwhurly5hWhS1cmUw9JzAq4wlzg8ZSry+C3ZHwcBtW1ZS
	2YDQE63+Vz3vS+GZxC5kTmQITdoHUyFdJlhJOHo4t39DKQiZYNlZSohKO3WWNzZU
	TTj0DEP34JQSs5wWVFANQnj6h59kaPbptRc8lIxQJLNyMCMwlEK3KXRi/86QxQX5
	PV/j7vEhvhvpiKz7JhB2lA4K1CzkuFyG/UlTT8RKj5jfsft3M5IGZ3TEWmPHjwtY
	YYEyKrhKjUtzSvx+IkVtb08sqYlgYvco8GMatETzVVsB4HkV7AZiplSkKOxow7Mu
	tg9JyXar9r6fcvbKFFakS0sHCjeA/zlTmflOdSkLKqqH/9S+5478PgdLcCpOPVX9
	udGBdZJkunXrSNzRPtNDt8w09tiTES8I6ufQsSpiHofz2EKAJBajdWWmmL9pq3vn
	dhH7zEw=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v4 2/4] net: mdio: change property read from fwnode_property_read_u32() to device_property_read_u32()
Date: Wed, 22 Oct 2025 11:08:51 +0200
Message-ID: <41f1a73142c35a647944c13d73b8d770ccf20538.1761124022.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1761124022.git.buday.csaba@prolan.hu>
References: <cover.1761124022.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761124136;VERSION=8000;MC=315264230;ID=130159;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F647D62

Changed fwnode_property_read_u32() in mdio_device_register_reset()
to device_property_read_u32(), which is more appropriate here.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V3 -> V4: unmodified
V2 -> V3: unmodified
V1 -> V2: added new patch based on maintainer request
---
 drivers/net/phy/mdio_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index fb1cb7a26..5d39b25b7 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -86,9 +86,9 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
 	struct reset_control *reset;
 
 	/* Read optional firmware properties */
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-assert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-assert-us",
 				 &mdiodev->reset_assert_delay);
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-deassert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-deassert-us",
 				 &mdiodev->reset_deassert_delay);
 
 	/* reset-gpio, bring up deasserted */
-- 
2.39.5



