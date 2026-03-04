Return-Path: <netdev+bounces-263795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJcQGrEfqGlQoQAAu9opvQ
	(envelope-from <netdev+bounces-263795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:04:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B2B1FF74F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D33DE302DF7E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C4372672;
	Wed,  4 Mar 2026 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPtXwZTB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE9370D64;
	Wed,  4 Mar 2026 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625801; cv=none; b=WtTclM/Xmiioe0EoTQ2TfI1UVP0ttunp9HiFktIckyBztVFwQscVzzRrYAK2WjhkAY9dP119P4gKA7eTpfzi0DGmOX8m0QJXAHoFilnzyowfrnI5sOmk1L5auGFZx3E/gcJBv0RO8sZEWx2xmeDEKcV4Rx9RztwKXErIErEMyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625801; c=relaxed/simple;
	bh=rLUd3lgpCcgXrJrGAnXCXtK4GhCncE6r6i7MBqFeEfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KYhpYboC3uxzUUj1pgYDe4wugrRiAFyWzRq7aIFcYbMbOZFA04oZ5f2KqqPSoqRDUnesjfkd+qPzcZHlLoVGcWy/wOXBlZW3AEexlRMVID8AAgnVKJgBk4N9mXDwgu3dEIWhKLXF4/7SyV5Csup1mX4Z9/IuYDsLK426ArR1WHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPtXwZTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94FBFC19423;
	Wed,  4 Mar 2026 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772625800;
	bh=rLUd3lgpCcgXrJrGAnXCXtK4GhCncE6r6i7MBqFeEfI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=fPtXwZTBc0b4w35ejHx3iWDFr66HOmxNs4GA8HsKw28jyhn08TIHWwWDvT0b7+NY+
	 lt3eGe52I9vcXsf8OWS8xIPJ9WRFi1RS6JrejufB7mpZfJbhbpcA4EU+/rhI6Qw504
	 S8td0KC9Y7zaiFytqadR7etmxAC/M8nzSlt837Ixr+FMdPtKdQUgEt1S0eJG/FjYJq
	 DxItdSapkWpagBBNtiUhrXi8hMv4hGwN8rwpQmwnY+Pfc+zHS0XIwyhrOSD62AvSlW
	 ha28xpsQ4T2RTS05RKi5F4fOSZUsICXEXDMnHOOBgotxe1LGY5vdxjbPf29c/4tLuJ
	 xMYItrtIoRSeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7818DEB7ECF;
	Wed,  4 Mar 2026 12:03:20 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Wed, 04 Mar 2026 13:03:10 +0100
Subject: [PATCH net-next v2] net: phy: realtek: Add support for PHY LEDs on
 RTL8211F-VD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-rtl8211fvd-add-leds-v2-1-d50bd8a50f08@gmail.com>
X-B4-Tracking: v=1; b=H4sIAH0fqGkC/32NTQqDMBBGryKz7hRnoNF21XuIi2hGHfCnJBJaJ
 Hdv6gG6fA++9x0QxKsEeBQHeIkadFsz8KWAfrLrKKguM3DJpmQy6Pe5ZqIhOrTO4SwuYMVyc8Y
 YuTNBXr68DPo+q02bedKwb/5znkT62f+9SEhouasNVV031OVzXKzO135boE0pfQFJxKzctgAAA
 A==
X-Change-ID: 20260216-rtl8211fvd-add-leds-72e5d666e921
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Daniel Golle <daniel@makrotopia.org>
Cc: Miroslav Ondra <ondra@faster.cz>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772625799; l=1495;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=b9WJdwgEAJzujhzgFrIVP9oyEzwN09jGayVy7lFDZmo=;
 b=q+3JhmVA3G6a1NbuIFV7FNiCPImMnZSC0wf7PDxROLyOKJneWg0DNNmWM3B+TGt+/ir1erXiN
 Lysh8oTXscQAXtuf5u8CX8phANPZVy5B++d/fJQOAx/okGIrDy6GU/L
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com
X-Rspamd-Queue-Id: B4B2B1FF74F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.55 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-263795-lists,netdev=lfdr.de,cleverline1mc.gmail.com];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[faster.cz,vger.kernel.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[cleverline1mc@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Action: no action

From: Kryštof Černý <cleverline1mc@gmail.com>

Realtek RTL8211F-VD has the same LED configuration
and registers as RTL8211F.
Use the existing LED related functions for this chip,
so it is possible to also use the netdev trigger.

Tested on ROCK Pi E.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Thanks Andrew Lunn for his feedback.
---
Changes in v2:
- Sending in the right time and fixing subject line.
- No code changes.
- Link to v1: https://lore.kernel.org/r/20260216-rtl8211fvd-add-leds-v1-1-a2b8617bbf80@gmail.com
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



