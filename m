Return-Path: <netdev+bounces-212809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E988B2214B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59FF169D88
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A42E62D8;
	Tue, 12 Aug 2025 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t1NnKv42";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ns13Rijm"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011512E62C2;
	Tue, 12 Aug 2025 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987424; cv=none; b=iUkQxpX/Cx/igVbFDtLoV1bW3v5iJFj+Uc3OOqe9xENIKl0KG0ZY8K0cyfnDE0o2h7Sq4/tnFITE6plLiH46bKO4jXUCpxwb8ut5+pDOazqyDfhIdKPy18rVg+6ifq99WhrGwzknPqAg6SZb2XXHQDFB69PvaQvbQxvoUOduRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987424; c=relaxed/simple;
	bh=z5KrdPaJoIcAwxg5NIX7YY9FZ0SSxid4/vfG7j8p4+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JHs8V8DrdUzIS3SPS+brEncZiyhTfLYCYIZL/zM1l4ImchLaCg+hCXQgxNkyRJ6ZwsaO/1bwu0l6sZPLUPmsvXn0I2J7NJ0vueE/DzJ1hGz1Mwbi11o89TF/JrquXFayQzhccQwfTzzNNXeVxljEAm2Y1QSRULyry0ZX7FHMfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=t1NnKv42; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ns13Rijm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c1Pp52yNJz9tyC;
	Tue, 12 Aug 2025 10:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HDKwhZne+MWQ6D1gAzrzcp4fIk7iWM+DbYn4d7wNqk=;
	b=t1NnKv42T5qARIp/7N3aKRv55VqHYOhA6dJQJLuLGpTpCBDgoLl8qCJ6+9ur2ar+WIDgud
	2utN7gM+88PiKVVs+uiyFFf6pXGYFVBY2JxCHtC81/3IhPzIC3VFAod1ji3sJQceeoPWsw
	oHXP9oZ3kAq0EV5BOvfFtkuZgKR1hANviP8Qph8GGvto1kdoRgY3mVo9pmMNVnWXc2gyF6
	jkZ+nXbGQqOG6LdnvnXzPHnScLzPxhux4nVly2LjT0q6dYpOlW9sH4FVOBcjR/79mnt3F8
	hLFi2H/dfyIy4xbMeMPhZg+AUojGWSMqQsz1rM+MiHKfZDWDlK1JHFD2u++F5w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ns13Rijm;
	spf=pass (outgoing_mbo_mout: domain of lukasz.majewski@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lukasz.majewski@mailbox.org
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HDKwhZne+MWQ6D1gAzrzcp4fIk7iWM+DbYn4d7wNqk=;
	b=ns13RijmCqnAvL75e0Wr6Sgj8kbeYSHy9FePBMvQXf1Hd1CbhHg+wkFL/0GkCaMuo2FOBo
	Mix+q2CLzV0iGuMHJItZHTVuH7MGBiU5g0Snypo0SIxsrz7YmTH7/DEyw3N/5qEY6Vq4Vf
	3uSZalYpeOKANYhCtkWXNLJLBOQmnXojD1B1efmM3qqsK52Gt1LTa6Zt0ffJela1M1Aosh
	TPNwiaMy94+UpKcaEEMo+uc30Sw8VqII+lRoz9aknU2kDwFIVAhxZ+5bPeCWC+5Jpc3JDQ
	/l2cp6wIBy/0/15jcE2+1OanB7a30Z5CgB8tHtreMf8UlGcSjpfWCPLt5E16SQ==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [net-next RESEND v17 02/12] ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2 switch description
Date: Tue, 12 Aug 2025 10:29:29 +0200
Message-Id: <20250812082939.541733-3-lukasz.majewski@mailbox.org>
In-Reply-To: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
References: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a63c911f662d4c298c3
X-MBO-RS-META: 4fyeuew4sc1nmbd6o3dzquieh3h183fj
X-Rspamd-Queue-Id: 4c1Pp52yNJz9tyC

The current range of 'reg' property is too small to allow full control
of the L2 switch on imx287.

As this IP block also uses ENET-MAC blocks for its operation, the address
range for it must be included as well.

Moreover, some SoC common properties (like compatible, clocks, interrupts
numbers) have been moved to this node.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

---
Changes for v2:
- adding extra properties (like compatible, clocks, interupts)

Changes for v3:
- None

Changes for v4:
- Rename imx287 with imx28 (as the former is not used in kernel anymore)

Changes for v5:
- None

Changes for v6:
- Add interrupt-names property

Changes for v7:
- Change switch interrupt name from 'mtipl2sw' to 'enet_switch'

Changes for v8 - v17:
- None
---
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
index bbea8b77386f..8aff2e87980e 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
@@ -1321,8 +1321,13 @@ mac1: ethernet@800f4000 {
 			status = "disabled";
 		};
 
-		eth_switch: switch@800f8000 {
-			reg = <0x800f8000 0x8000>;
+		eth_switch: switch@800f0000 {
+			compatible = "nxp,imx28-mtip-switch";
+			reg = <0x800f0000 0x20000>;
+			interrupts = <100>, <101>, <102>;
+			interrupt-names = "enet_switch", "enet0", "enet1";
+			clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
+			clock-names = "ipg", "ahb", "enet_out", "ptp";
 			status = "disabled";
 		};
 	};
-- 
2.39.5


