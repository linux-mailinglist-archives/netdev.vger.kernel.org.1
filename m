Return-Path: <netdev+bounces-236697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C773C3EF7B
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23EF188C6F2
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD592310631;
	Fri,  7 Nov 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3FxmfbX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF753101C9
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504228; cv=none; b=kGkKMQydtIfYEcAzQ6SedbNToeHUZGCEuNCDZ7oCAfNJoZn7wwdLeghI0SfbN3mOOmyI2Ti2yiuqwfJkGlcjjOQsNt3295BrumHF8+YoPkOj/+LrVWvD5Tk+w9XJXZQFshcXQR7M9eH+d8aMTRhKQAc0g6ECGgznAsGs5+CNAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504228; c=relaxed/simple;
	bh=MdkB/Xow1STZ/vd1dO5sr1mBnWw0IYtYq0tMvW62450=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZRh/CxeURv/qxQP1P4mk7B4byVD2XM/2yV37hiSCkgWVKVDdhcG5diV5w+gLEcr8nN2qLPxW51YY67ey9oePVssDMslq8DD4NHMtLDO+cQWYnGSHYfBqQBucap23HhMd8LejWxg9X8SOBtSi6pyLGHFY9s3Gseys4mTxVoU7xqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3FxmfbX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so838117a12.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762504225; x=1763109025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fNaNY6SHcDWfyejibfeRml/RW9cl2cli6RWaoB7xA0=;
        b=g3FxmfbX3ungyuv9Y6mlA1WF5pcOTAk5eYiolbOKlUGkjSzxZiFCn+ovNRLWsi7MZa
         vyQ3ZDfz48+KjZsDwytS/x4rFKV24xLhZJ0h2ZavgTFEBD0DJEiuq/3CkvTqGBgFDCX1
         NB5if8suUl4OEZQ/3/ZQQcOGqskuE/KEGvzGdtOkCO33iBFqV7A4EbXf+g4aG3hGj4c9
         2G/d0Cj0FxKc5mnZYXeNcaADt4p6xCRXxmQnY9H/x+pAdmKfSk+a+b7TTt7XE+Y6Mv6f
         /6n+9JF/Fc4CqMJ0ZdhE+GZFvb5MgSacdJICblvqHm7scAqSzpPjjSZSCR+AS9+L6Ebq
         QQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504225; x=1763109025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fNaNY6SHcDWfyejibfeRml/RW9cl2cli6RWaoB7xA0=;
        b=c2JBkn8IfPM/QtTaVqMkLbsW9qA9kVn5psgn279tQRiuGP+j4BNG8PSKelMYbMYZwT
         unxccvqQwuZaWU566fFctPc5LtvXVb4DkcWSWEOY/hM2glb2+Bl/8Jsu+CIG8vvWV9gn
         EFAYn0RXJt74NnI7nDfFNcY/ZMEenTGFabwy0yjLCegsOWh+lUsR3lv02NJFMDkHe5kC
         ElrxLfpVWeH8sD+ymm0xV84xQwP+5fRp1WOTTRdJgpc9datsljXgbwsqZ0b0dX/72dWi
         /3wEZUQ96e0wGRqFjAP1vkepMet+RjVeqiCUMl9vwA/O9go4JVhulgAP3bhqtNaL+w3E
         uL4w==
X-Forwarded-Encrypted: i=1; AJvYcCWkuyGp/WXSGBYFqX2rV6LPZiyJ4ColEYm+OYXFadPuyeXavvlsdMlBIfuHd3oNsZIYzo/eJ9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdpuDX7jUIS+W819zscBjAC7B/d7lLD4AFOIxZkXO/ydfGfABJ
	3b0JB0eRmbFJ8cvC0a3pBOSYJrWmXTzKvNTssJ3vmb/VJQthqF1amVz+
X-Gm-Gg: ASbGncsRBxq8+xEd0FOrEKcSixX8UTjjokn3lDzT47KZ9sOlK//klIVaxt1lgmjo7UV
	kY2myPVB653V6uG/6Gw0JPtNldAlp5MuqAKOh1jKKGK9P4i6fbeMKgToW99GiJWt2kZ+jdJ+vcN
	56UmJlQqIV5FF5ZIWtszmTZyRuunU0U9iQVYkTdYpR2+mblMNWvAYWUjPGLi2Q8kSSQbLtwxcb8
	37gNnDI4BVK+rANmapmHho92ZSOWyEPp1o9MKkucKGJbzEJJp3cqkp9ymbOcmKTdzKluRp9hoV3
	0UmjCQCmrEiRGeahML+HG8vrw9EQJDHo+SxUG8pnS/kgyiFLnaYrC/oy2Jj3bFtyx3dq5Po7Nn2
	IjX8eJKoouLG1F27mDY8dfs5afuVOeSQ0/CdSUJ+Dcf9EYm5a8/pqKyGCzAe19p964/PrhZ5fca
	zmvt2dtcl1SwnBgUCvBTSPXMcTZla28+tksLTz7npw4NoYMiJB7psS4vxvtkAvVkG4BUc=
X-Google-Smtp-Source: AGHT+IGUmqnYpbST9RYALAxh5I7SPH5rCK4jGuKHXFkKq4840xhq1+OC7120dFS4djX7wdG2rZX/lg==
X-Received: by 2002:a05:6402:2809:b0:641:3189:a192 with SMTP id 4fb4d7f45d1cf-6413f0763aamr2192820a12.20.1762504224957;
        Fri, 07 Nov 2025 00:30:24 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f85f8c7sm4054682a12.27.2025.11.07.00.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:30:24 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net v2] net: dsa: b53: bcm531x5: fix cpu rgmii mode interpretation
Date: Fri,  7 Nov 2025 09:30:06 +0100
Message-ID: <20251107083006.44604-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

b53_adjust_531x5_rgmii() incorrectly enable delays in rgmii mode, but
disables them in rgmii-id mode. Only rgmii-txid is correctly handled.

Fix this by correctly enabling rx delay in rgmii-rxid and rgmii-id
modes, and tx delay in rgmii-txid and rgmii-id modes.

Since b53_adjust_531x5_rgmii() is only called for fixed-link ports,
these are usually used as the CPU port, connected to a MAC. This means
the chip is assuming the role of the PHY and enabling delays is
expected.

Since this has the potential to break existing setups, treat rgmii
as rgmii-id to keep the old broken behavior.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Reported-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Changes v1 -> v2:
* dropped RFC prefix (since it did the opposite, and I got zero comments)
* dropped the KConfig option and just always treat RGMII as RGMII-ID
* adapted the commit message accordingly

 drivers/net/dsa/b53/b53_common.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index eb767edc4c13..ac476cc6d6db 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1447,6 +1447,13 @@ static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
 	else
 		off = B53_RGMII_CTRL_P(port);
 
+	/* Older driver versions incorrectly applied delays in
+	 * PHY_INTERFACE_MODE_RGMII mode. In order to not break old users, keep
+	 * interpreting RGMII as RGMII-ID.
+	 */
+	if (interface == PHY_INTERFACE_MODE_RGMII)
+		interface = PHY_INTERFACE_MODE_RGMII_ID;
+
 	/* Configure the port RGMII clock delay by DLL disabled and
 	 * tx_clk aligned timing (restoring to reset defaults)
 	 */
@@ -1458,19 +1465,24 @@ static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
 	 * account for this internal delay that is inserted, otherwise
 	 * the switch won't be able to receive correctly.
 	 *
+	 * PHY_INTERFACE_MODE_RGMII_RXID means RX internal delay, make
+	 * sure that we enable the port RX clock internal sampling delay
+	 * to account for this internal delay that is inserted, otherwise
+	 * the switch won't be able to send correctly.
+	 *
+	 * PHY_INTERFACE_MODE_RGMII_ID means both RX and TX internal delay,
+	 * make sure that we enable delays for both.
+	 *
 	 * PHY_INTERFACE_MODE_RGMII means that we are not introducing
 	 * any delay neither on transmission nor reception, so the
-	 * BCM53125 must also be configured accordingly to account for
-	 * the lack of delay and introduce
-	 *
-	 * The BCM53125 switch has its RX clock and TX clock control
-	 * swapped, hence the reason why we modify the TX clock path in
-	 * the "RGMII" case
+	 * BCM53125 must also be configured accordingly.
 	 */
-	if (interface == PHY_INTERFACE_MODE_RGMII_TXID)
+	if (interface == PHY_INTERFACE_MODE_RGMII_TXID ||
+	    interface == PHY_INTERFACE_MODE_RGMII_ID)
 		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
-	if (interface == PHY_INTERFACE_MODE_RGMII)
-		rgmii_ctrl |= RGMII_CTRL_DLL_TXC | RGMII_CTRL_DLL_RXC;
+	if (interface == PHY_INTERFACE_MODE_RGMII_RXID ||
+	    interface == PHY_INTERFACE_MODE_RGMII_ID)
+		rgmii_ctrl |= RGMII_CTRL_DLL_RXC;
 
 	if (dev->chip_id != BCM53115_DEVICE_ID)
 		rgmii_ctrl |= RGMII_CTRL_TIMING_SEL;

base-commit: c2c2ccfd4ba72718266a56f3ecc34c989cb5b7a0
-- 
2.43.0


