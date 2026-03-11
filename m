Return-Path: <netdev+bounces-266621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLnnKEZOsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:13:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C95262CA5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4EAE303C5A2
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AAD3D88FF;
	Wed, 11 Mar 2026 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnew9YEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61633CB2EC
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227562; cv=none; b=PuCWJ3MrFZX8fNpp1IduPOc31Q6vjURfo6aQM3hBviF88LWi1Kg5nfvAXXY0wUowQqvuWptUCS2/fOtEvksaLRV3LRA1AGpLhCGb4xlP27W9AC69Qe+/MQit48j2n+bWo8gRe/WtxaueIJ0/OTvEAlf6GQEXuokRrSzAP1f2BYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227562; c=relaxed/simple;
	bh=Xa9cyAvn1wvWX9/TK20Gkm+rSEPKa/4eLs7loxk3a6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lTCLfMhHN3Xmboh2d/tocqgKOr7ep+LCxiC4/nyfAT+yw6Q8xC+kjPHTm+P7mbBESf4RVWDSIGZ4e9EMYZoZmI3QkTtCHgfzR4efdIru8oMxO+mbLBwI2tt6VPPGQN7KfBHPtv6vdXi3GNtogLOdHq5O/Srxbn85ztHwRLblNwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnew9YEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58324C4CEF7;
	Wed, 11 Mar 2026 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773227561;
	bh=Xa9cyAvn1wvWX9/TK20Gkm+rSEPKa/4eLs7loxk3a6g=;
	h=From:To:Cc:Subject:Date:From;
	b=hnew9YEiG3uHbRm/S1mRuPH8qxS+j8iBFJ6g+iIM9+Q7cbSbp2OtSk9FzvwjRlhoG
	 bg7/CfLWvRYu2InLRyXB6T/3mwocNfwdxFNF52wD3JySetfAxD/mWvbQlbkMtiSj9c
	 1IIrHggts4KuDW4yehgYHPm1PpiviGZD1EOfZ9VIHrTpE4Jf4z0srgOSOsrxNE9JmW
	 HBJh63BHJGezGcakyCT5X+LwWEXB6Re0Gk5xZBy46KUWyiSfvNeCzcDaksIHhPX4H7
	 uBLDEURH903VDz6wgq/a7UFrlAVmZeM7XJBf3/RBmMIT6Ym/MvV18ov4TMoJnryO+2
	 uQFlPi++/clsw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Linus Walleij <linusw@kernel.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net] net: dsa: realtek: Fix LED group port bit for non-zero LED group
Date: Wed, 11 Mar 2026 12:12:37 +0100
Message-ID: <20260311111237.29002-1-kabel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 28C95262CA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266621-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bang-olufsen.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The rtl8366rb_led_group_port_mask() function always returns LED port
bit in LED group 0; the switch statement returns the same thing in all
non-default cases.

This means that the driver does not currently support configuring LEDs
in non-zero LED groups.

Fix this.

Fixes: 32d617005475a71e ("net: dsa: realtek: add LED drivers for rtl8366rb")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
I was just looking at the driver code ouf of curiosity and saw this.

I don't have corresponing hardware nor documentation.

But it seems to be a copy-paste mistake from early driver development that
was not fixed later, maybe because the original developer had only a board
with port LEDs in LED group 0...
---
 drivers/net/dsa/realtek/rtl8366rb-leds.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb-leds.c b/drivers/net/dsa/realtek/rtl8366rb-leds.c
index 99c890681ae6..509ffd3f8db5 100644
--- a/drivers/net/dsa/realtek/rtl8366rb-leds.c
+++ b/drivers/net/dsa/realtek/rtl8366rb-leds.c
@@ -12,11 +12,11 @@ static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
 	case 0:
 		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
 	case 1:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+		return FIELD_PREP(RTL8366RB_LED_X_1_CTRL_MASK, BIT(port));
 	case 2:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+		return FIELD_PREP(RTL8366RB_LED_2_X_CTRL_MASK, BIT(port));
 	case 3:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+		return FIELD_PREP(RTL8366RB_LED_X_3_CTRL_MASK, BIT(port));
 	default:
 		return 0;
 	}
-- 
2.52.0


