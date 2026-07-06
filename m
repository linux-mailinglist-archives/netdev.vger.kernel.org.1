Return-Path: <netdev+bounces-304917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 27s5O8B+S2pkSQEAu9opvQ
	(envelope-from <netdev+bounces-304917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:09:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678270EEB8
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:09:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IcZpkkoU;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304917-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304917-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D8FC356632B
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1531748C402;
	Mon,  6 Jul 2026 09:15:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E843635E
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:15:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329327; cv=none; b=l298rmQDe0wCtZGjv44oiMbODiWz5cg9TADG0a39Hog9AqnCc6QUbnP+L2y6dQ2JhEpld/32wngqeA8rNcfvLPRnq10Pjg7ks9rHUgyGx3P4m8jENJvAkfP8qv+YlA9Nt3F/+uhOcQwxq7ExcQFW6u4BfY2RmZwgh0Bql2toWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329327; c=relaxed/simple;
	bh=SlNqGmETJ9Q8UAkQSzGcvlMdwkMGS8oYl0+UlW2dAag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQPv0a95KAbNH5dlGpbDIMeD77TEXAKpaHFq4OLN27k7qAdu9FePwt+Bvdj9r3jWuq6lA8eVd85D3B70fShePCM16I/VBOg1mWeXKtjOz3FvtSRt4HNmc3jwaqpCCl0VD/FIiJnkmtC1X8uRr6C5dwtO1nEUz5FqXJSOerkv8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcZpkkoU; arc=none smtp.client-ip=209.85.210.195
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so2868935b3a.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783329321; x=1783934121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PO7sRlb4LngBB0NhQzK1DjshH0p/tRvHLng9mNY0Vj8=;
        b=IcZpkkoUlQyNSCJ0Xxv9cyPoiHF42vactkVX/+6JJKCyrzhnyWAkVru01LcpEbQ4+c
         rfYZ+do8G0sQ2GX1qSvN2MmcwOxdC3l9EgMX+92qZvfqKV8HrWWbsyzPsamwmMBJo8yW
         zYjlg1Fw8cleS1ImRXDzCEWWQ4Qs8ZyIddjgn31oI+vx1aplDmJ/mldSPdZmmwFUhvIp
         4o6TgLZ2oBo0vq+OBDt83eoxskiq05l3n7jH87ljxWFKR4OdOt6F0QbmZLQyFXFlpIMW
         wmPjqcGEJFVmLmE/kyeTdGHQdx3e/iOaIVJQHYHds7n54rN7k+RfYiUB5EVMos7NrrWZ
         DwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783329321; x=1783934121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PO7sRlb4LngBB0NhQzK1DjshH0p/tRvHLng9mNY0Vj8=;
        b=kOZrzD4OGSdHTaHKHZ/ei5Bjod4FLF1PUsmbT5jA9Thuyc272kJz1lzmFUa09lBQst
         B9CO3zGt9ubWdu6A21KhyQpzxp9CnWxuW1ZaKlJZNmz5tNc4O3d/dz9f21F1iEi6qb+6
         VzKIV9DDdtExQprQSLYJf/23wfG7+JJP1cIZiXqwNNRORcsI0Fi2VJ/1ZRJiI74Xoyz4
         tBvEpALWP+xN/41xyJRvnMxtIY/N+uEtlHbNkW9vUQHUQ+Y70xbZ+ZPlqaDYVB9n8hO3
         TkpB9V0pxW+KKRnOAY0bjioD8RbLt8IbMkLK5jF0LdS2bOennuwVWoLTewgY8h2xh0/d
         uvpw==
X-Forwarded-Encrypted: i=1; AHgh+RrwT/vlcL75aRcyaJcIQrMLLKFiSsAjLVyLJkbHn+7h61eUqExx1lxDWePM2tdrF8LKiX90C9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0foBAdP76bqAye9LDLFTmDtTQSDa/JHyZI1MokyAUiDd4d3Sx
	EEXVoQqkfTQLSqJwkoCvEeLtRQKWASiRoyGxIqoFEqiU7mmkIR5uwEEG
X-Gm-Gg: AfdE7cmF3hL5n28cG7Eqabg4V5nnocrb5X9vDmOHwsIWYgel9mFUZP0GHy/TXQrmBkZ
	sdYgNrE05+o+SYQ1t2lpBJnPYy97nnY4a0DDdq2RtQC/ac0TYffQ6f2AixR3L5TFqV4W5fDx2OP
	kzJ5hUDzyCN45Qi9s0SGI25Et+isqM1VFv5rqYNFfUsAi5meMiTphBTeod6UDK2sIMp65qSJ4co
	4Mcz5vs+c2L2R7t/nf8mdApMttHXK4kVGgIIOqLDgBJpAhR0SOIdSQj103H9GM+PsTXao+jPhvV
	g6TlCiod+SOP3i5puZYXSFd6iSO1paPSquVEI5YSQDyR1RHzoqiTknUvShoUGu1CXv2J4ktfamR
	ZfeeM33Hf71T5qGVDvT21bIjf//j5+QldBUxONKmY2pSD5ae3Z5SLgtdg/uOsXx2TqaRSeSCwOl
	2VkbJoxPNl7M4aPdAXKSrwvSWW
X-Received: by 2002:a05:6a00:bd0c:b0:847:77f0:72af with SMTP id d2e1a72fcca58-847f6ecb888mr7926803b3a.40.1783329320787;
        Mon, 06 Jul 2026 02:15:20 -0700 (PDT)
Received: from [192.168.1.101] ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm3445963b3a.53.2026.07.06.02.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:15:20 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Date: Mon, 06 Jul 2026 17:14:43 +0800
Subject: [PATCH v2 3/5] net: phy: motorcomm: Enable optional clock for
 YT8531
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-rv1126-alientek-dlrv1126-v2-3-ff3176ca362b@gmail.com>
References: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
In-Reply-To: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yanan He <grumpycat921013@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783329287; l=1439;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=SlNqGmETJ9Q8UAkQSzGcvlMdwkMGS8oYl0+UlW2dAag=;
 b=y6ylHRmWgT7jI86bC726VoaKX+LpK4637earqAkTGSrc4CX0YqwDp1WW/spDefa3DoiAUsZOh
 Vi4pQJYhQAiAYpVdofljX7KHjKSc3kOcTx5ju2ZdGCW3K/esm48DEaL
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519;
 pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-304917-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:Frank.Sae@motor-comm.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:grumpycat921013@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,sntech.de,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com,motor-comm.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7678270EEB8

Some boards feed the YT8531 PHY from an SoC-provided external
reference clock described by the common ethernet-phy "clocks" property.

Enable the optional PHY clock during probe so boards can model this
clock as a PHY input instead of keeping the clock alive from the MAC
driver.

This is needed on the Alientek DLRV1126, where the PHY reference clock
is provided by CLK_GMAC_ETHERNET_OUT.

Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
 drivers/net/phy/motorcomm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 5071605a1a11..3396a38cfc0f 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -6,6 +6,7 @@
  * Author: Frank <Frank.Sae@motor-comm.com>
  */
 
+#include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -1180,9 +1181,15 @@ static int yt8521_probe(struct phy_device *phydev)
 static int yt8531_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
+	struct clk *clk;
 	u16 mask, val;
 	u32 freq;
 
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get and enable PHY clock\n");
+
 	if (device_property_read_u32(dev, "motorcomm,clk-out-frequency-hz", &freq))
 		freq = YTPHY_DTS_OUTPUT_CLK_DIS;
 

-- 
2.54.0


