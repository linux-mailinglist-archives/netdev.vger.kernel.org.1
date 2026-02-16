Return-Path: <netdev+bounces-258930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCeeNjNQk2nk3QEAu9opvQ
	(envelope-from <netdev+bounces-258930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:13:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 396971469D6
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAC513011764
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF052D5C74;
	Mon, 16 Feb 2026 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHQ3DFdq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD33A2D1F7B;
	Mon, 16 Feb 2026 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262000; cv=none; b=Fq3xSS0I9LL/GsW5Lsv/bckSVVnz2zbgikFgnKnGl/QpUm515yViKutVFyXkJSGZ0UKNrujUOhtIAFdbUV73Yse+8ICM2SMq1MIkOZuL2IEDgIHfBWGnKPfevIHBlIFAMDH+iVE4dswL/bR+C8wLCb2X1PKe0t3cHdobUnCQHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262000; c=relaxed/simple;
	bh=wwNjpAxLnbWXj2x/gojmm+AaV5qKGG7+RSBh/gjAdOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vEdPYrmRR89Fwubfpy6B1LgbcRgJl28LNp+e6RQo4z71wUbJ1KDrW+q2Jxe9JE+esd01m4PJmQorCcen/7DiQADZQMTBdiWNi6YzDv2J2MuFUK3GBCj4tVenXzJOwltpkzUnMepi+gCHwY2emJs/NmFfjH49YgWJs6E+tcw+4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHQ3DFdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E48EC116C6;
	Mon, 16 Feb 2026 17:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771262000;
	bh=wwNjpAxLnbWXj2x/gojmm+AaV5qKGG7+RSBh/gjAdOA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=QHQ3DFdqL2DPGRDBjFNQmai8V4mCdE3oBhf1i3UDoiA5EYpbWvu/OcB37Zakonxub
	 emKz8mKQpJoMPTImApm48tvr6hN8OPsGYzNwLSMR7A4jch6Y7u3C3eKkc7NXDE1PHp
	 uefi+KTqZcM9cFWiPVUWXrKr3YQWZGBchDKjuwBsKLZhciRw8xpaanwJg1tGEUi0m6
	 SPbHxvbvPoERdAQjZvY2HPgYx3NWKMu8lknc9S7Mz5mvOHt270Xzi7Avi1yA42ouWY
	 NnESqfa4o0+0Yyl8jrfsTNZE+L+bR6xERivymPmHSLIlykUgIk59U5P5oa0g6ZsEis
	 JMjvTsi0tYFEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA38E81A5A;
	Mon, 16 Feb 2026 17:13:20 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Mon, 16 Feb 2026 18:11:09 +0100
Subject: [PATCH] net: phy: realtek: Add support for PHY LEDs on RTL8211F-VD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-rtl8211fvd-add-leds-v1-1-a2b8617bbf80@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKxPk2kC/x3MzQpAUBBA4VfRrE2ZKePnVWQhM5gSuldS8u5ul
 t/inAeiBbcIbfZAsMuj71sC5RmMy7DNhq7JwAVLwSQYzrVmoulSHFRxNY1YsZUqItYwQSqPYJP
 f/7Xr3/cDklKhhGUAAAA=
X-Change-ID: 20260216-rtl8211fvd-add-leds-72e5d666e921
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Miroslav Ondra <ondra@faster.cz>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771261999; l=1456;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=UcDBB6aqn6VGJO+wrWmfuuDhMbNI+KYuwnnokfwejMY=;
 b=q1iiWNCuapGkYpnUzMCoonZHxYfGwV7ZC8l5ct9AzwknkjTQeTtkfca2avgxpzrlskW2I1AJX
 nCj+z1JNK7pDiX4V65P3N8Mj6sOv/RxpPodcdDwYM/UoPRdy5n6coGV
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.67 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.83)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258930-lists,netdev=lfdr.de,cleverline1mc.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[faster.cz,vger.kernel.org,gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[cleverline1mc@gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 396971469D6
X-Rspamd-Action: no action

From: Kryštof Černý <cleverline1mc@gmail.com>

Realtek RTL8211F-VD has the same LED configuration
and registers as RTL8211F.
Use the existing LED related functions for this chip,
so it is possible to also use the netdev trigger.

Tested on ROCK Pi E.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
I have been trying to match LED behavior of RTL8211F-VD with RTL8211E
and found out the RTL8211F is supported already,
which by the look in datasheet matched the RTL8211F-VD.
So I have reused the functions and tested on ROCK Pi E.
---
 drivers/net/phy/realtek/realtek_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 75565fbdbf6d..530b4e26d16e 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -2243,6 +2243,9 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
 		.flags		= PHY_ALWAYS_CALL_SUSPEND,
+		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
+		.led_hw_control_get = rtl8211f_led_hw_control_get,
+		.led_hw_control_set = rtl8211f_led_hw_control_set,
 	}, {
 		.name		= "Generic FE-GE Realtek PHY",
 		.match_phy_device = rtlgen_match_phy_device,

---
base-commit: 350adaf7fde9fdbd9aeed6d442a9ae90c6a3ab97
change-id: 20260216-rtl8211fvd-add-leds-72e5d666e921

Best regards,
-- 
Kryštof Černý <cleverline1mc@gmail.com>



