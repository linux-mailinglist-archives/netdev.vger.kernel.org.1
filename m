Return-Path: <netdev+bounces-186037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94137A9CD94
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C274E179458
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6027A10E;
	Fri, 25 Apr 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKP/xkg1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB2914A0B7
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596251; cv=none; b=rLyGM4OImX7fNoJfst5Z7lGZ1/a7hbBhtJNBtduq9h95SmLeMJJ76MKHZpy+mD6C4164QoZsjOKn6L2+fQXRILAlZtMs4WttXslpMgjFfFaRDhNd6+6w1CgaVg8msmth3qlJWDvqfgnfDMrkCS0074GfAAK2IfxTh00uqylNXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596251; c=relaxed/simple;
	bh=sueGXT63mBN6KKAZOWkZ4D94mmjOXOnDVw4/MyzX8Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a1MiXq8eZl1Kih0NA23VEpLa1G1P7pDCNu6Jhbl/QmST8Y9Ru/WQGil+Zkp2lihrd5E/JLklG+AipQVCffMssljMrf1/YHAkukUYKqkXV69zdZ+uXrfvzpMBI1zWuIzOv6mJGO9gvo68KlY9u9z/WllmDymNHVWi0gC5PAsfyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKP/xkg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4777C4CEE4;
	Fri, 25 Apr 2025 15:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745596251;
	bh=sueGXT63mBN6KKAZOWkZ4D94mmjOXOnDVw4/MyzX8Tw=;
	h=From:Date:Subject:To:Cc:From;
	b=dKP/xkg1Q7JRgJDw3qGbE+AHi+nDHt/GDX9AgHN/d3LdDM83QN/vmrsddZtF/4Vzv
	 IZXmEa7vvosqFWVNaAIt8klKY4JIOuAtu6Ui7xX0WKRHUWw1CkLX0h3sbk9ihFJBvQ
	 /npYwdge8tRwXSJdqZj+GFh7FX1gWwJoTTJ9+etXlm1EZinQDHcpEFdJ+RKOCQeASJ
	 cfn8A5NY65fd8L9g5xW8hJkW+fVrpZbe6E6/nP6Mp9SAkL4XJl2JZGE7YW6xMvyhJ1
	 OKl1zlvQdy0SndRlePSIJNbeyQT6v6ny2dfhUwyvlnS9y4LjcDWqdMZH3yIlUndcvR
	 A8JtNJjI0Ligg==
From: Simon Horman <horms@kernel.org>
Date: Fri, 25 Apr 2025 16:50:47 +0100
Subject: [PATCH net] net: dlink: Correct endianness handling of led_mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-dlink-led-mode-v1-1-6bae3c36e736@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFavC2gC/x3MQQqAIBBA0avErBswyZCuEi3KmWqoLDQikO6et
 HyL/xNEDsIR2iJB4FuiHD6jKgtwy+BnRqFs0EobVWuDtIlfcWPC/SDGQRkyjZ20dSPk6Aw8yfM
 PO/B8Qf++H0lihDdlAAAA
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

As it's name suggests, parse_eeprom() parses EEPROM data.

This is done by reading data, 16 bits at a time as follows:

	for (i = 0; i < 128; i++)
                ((__le16 *) sromdata)[i] = cpu_to_le16(read_eeprom(np, i));

sromdata is at the same memory location as psrom.
And the type of psrom is a pointer to struct t_SROM.

As can be seen in the loop above, data is stored in sromdata, and thus psrom,
as 16-bit little-endian values.

However, the integer fields of t_SROM are host byte order integers.
And in the case of led_mode this leads to a little endian value
being incorrectly treated as host byte order.

Looking at rio_set_led_mode, this does appear to be a bug as that code
masks led_mode with 0x1, 0x2 and 0x8. Logic that would be effected by a
reversed byte order.

This problem would only manifest on big endian hosts.

Found by inspection while investigating a sparse warning
regarding the crc field of t_SROM.

I believe that warning is a false positive. And although I plan
to send a follow-up to use little-endian types for other the integer
fields of PSROM_t I do not believe that will involve any bug fixes.

Compile tested only.

Fixes: c3f45d322cbd ("dl2k: Add support for IP1000A-based cards")
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/dlink/dl2k.c | 2 +-
 drivers/net/ethernet/dlink/dl2k.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index d88fbecdab4b..232e839a9d07 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -352,7 +352,7 @@ parse_eeprom (struct net_device *dev)
 	eth_hw_addr_set(dev, psrom->mac_addr);
 
 	if (np->chip_id == CHIP_IP1000A) {
-		np->led_mode = psrom->led_mode;
+		np->led_mode = le16_to_cpu(psrom->led_mode);
 		return 0;
 	}
 
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 195dc6cfd895..0e33e2eaae96 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -335,7 +335,7 @@ typedef struct t_SROM {
 	u16 sub_system_id;	/* 0x06 */
 	u16 pci_base_1;		/* 0x08 (IP1000A only) */
 	u16 pci_base_2;		/* 0x0a (IP1000A only) */
-	u16 led_mode;		/* 0x0c (IP1000A only) */
+	__le16 led_mode;	/* 0x0c (IP1000A only) */
 	u16 reserved1[9];	/* 0x0e-0x1f */
 	u8 mac_addr[6];		/* 0x20-0x25 */
 	u8 reserved2[10];	/* 0x26-0x2f */


