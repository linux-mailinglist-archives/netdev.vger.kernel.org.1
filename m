Return-Path: <netdev+bounces-68988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5CD849173
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 00:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB361C2147E
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 23:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36FFB674;
	Sun,  4 Feb 2024 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pI8wLBL+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9810A13
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088492; cv=none; b=AP9OD9QxJJTlV27MHKc5c1/pX8Y59PI1EvtEDihSXGaSbUDMWjWPKqFkHCRgzA+nSiYhM4wD/EedfNRszrDeAVgydtVaXaPKtW/MG/SzOPytMS/logFcw8I4VnzNmFlYqurfWz2DSE+sQlz1I74tm93J84BU+cJCH79h65xhtEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088492; c=relaxed/simple;
	bh=rgVBTe9NFmv8qTwkOhPt7f4J9RmY8pruu+A4aU1aFzU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gTkP7VJo3Iq8OtCnaNP67CJpPnfWV0uWZ+NXITm8mTv9iT+KegzM3bzVqzYlOrEcbbn44VsSOPbh5/j4wmdDne3PIP7U5VGXEJ35qc+7u9qfl8AcBUL/Qun2OxEQR0Dt0zq0RwsmqsnvhbeNObkr46Eio67q6sSNP1bPsaVl7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pI8wLBL+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Mqtx7lxLWZIY0eIcPwokUlmdtI2sjcvUXDAfmr7jYBM=; b=pI8wLBL+fiHouXWaSIPaBlkyBE
	2SRfN8K01QMyXVI1y7wh56B1bssZKijq9pYlu/KeOTH/aaVVgRx93Wi5eKthq3H6WCWwKslxos5H4
	2vGxkixLRHvNu5p2Cese93wdrDm4w59amdrhcBvZ5pUpsALranGS+Ne42pZ0/mzcX8T0=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWlh8-006z0G-Iz; Mon, 05 Feb 2024 00:14:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v2 0/2] Unify C22 and C45 error handling during
 bus enumeration
Date: Sun, 04 Feb 2024 17:14:13 -0600
Message-Id: <20240204-unify-c22-c45-scan-error-handling-v2-0-0273623f9c57@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEYawGUC/5WNQQqDMBBFryKz7pQYbdGueo/iIokTHZCxJFEU8
 e4N3qDLx/v8d0CkwBThVRwQaOXIs2TQtwLcaGQg5D4zaKVrpVWFi7Df0WmNrn5gdEaQQpgD5nU
 /sQzYqFJb+2yt9S3kn28gz9vV+IBQQqEtQZfNyDHNYb/ia3n5PzpriQobY1pvKld7Z97TInJ3I
 3Tnef4AfhgpptoAAAA=
To: Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Tim Menninger <tmenninger@purestorage.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=rgVBTe9NFmv8qTwkOhPt7f4J9RmY8pruu+A4aU1aFzU=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwBpaxaY9f5yJY9nzaNSpuW27IWEaUM0lTNWCo
 g8I0kzh7K6JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAaWgAKCRDmvw3LpmlM
 hCynD/0TLH7EfVN8NGrS8ikshQ6vPlLUUTbezVPwZd2jJ8W/jtWbSD5XvHCnzKt1qR4yXD9kD8O
 zKLS9/1K0qE8qJHJY6LYS7os62OgjINWCr64RJAoh2E/n0ahwLafmEiDJ7oKJTQ3Ddlw35qrZLl
 H3iatRiBfOP3uOzauHsPR4cEpj0mNyRKZzw2L0q7nQ5UVZCzTcX59lVLszmlTVMUZFT3gVMvlpy
 xdNSBoK7QzkYu6t+3DA13P5VgaFYA7P6XMLpdaHtpoVvlp0dMrQi02/sFKwU6IzGwtteXagQXe2
 GuLVdSXMLbgEEO8SNpqrGJwNyurBXPzAMjIrptDK15//mUgprjBkU1DiTCt4d7dQFpYa3nQUptC
 gJxH0nfVA8SyLY+10Y+ZocpK8UaQJ/3M+yvVr5qYqj0WbDf8yMhYw4qgDeZSTSpFeoXAe932s6C
 yVR3KYPOjKsi/clYOcX37T1Leykj/ygF+Vbkk/4/nl3YcgNr/4bQMCAba+wBe3Hiyxc/3nds87t
 lmwvRCjklirzy4KbKSHXq2fFhFzJHaDtBBsV0t98vzrwLxkoTRMYQiIkDr7WxCjkLd7UXKdDtNT
 mC+2c64IBZRWoLDIE+osl2+CsRB492bONT/iyfjvLIp6za368IzBudLTqZeGHDPSJKxMcXv2Koz
 2QoVLpy98PTbkpg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

When enumerating an MDIO bus, an MDIO bus driver can return -ENODEV to
a C22 read transaction to indicate there is no device at that address
on the bus. Enumeration will then continue with the next address on
the bus.

Modify C45 enumeration so that it also accepts -ENODEV and moves to
the next address on the bus, rather than consider -ENODEV as a fatal
error.

Convert the mv88e6xxx driver to return -ENODEV rather than 0xffff on
read for families which do not support C45 bus transactions. This is
more efficient, since enumeration will scan multiple devices at one
address when 0xffff is returned, where as -EONDEV immediately jumps to
the next address on the bus.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v2:
- C44 -> C45 Typo
- Only return -ENODEV for unimplemented C45 read.
- Link to v1: https://lore.kernel.org/r/20240203-unify-c22-c45-scan-error-handling-v1-0-8aa9fa3c4fca@lunn.ch

---
Andrew Lunn (2):
      net: phy: c45 scanning: Don't consider -ENODEV fatal
      net: dsa: mv88e6xxx: Return -ENODEV when C45 not supported

 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 drivers/net/phy/phy_device.c     | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)
---
base-commit: d6aa8e0aa605a6baba08220e4a83fa2619a4c4d7
change-id: 20240203-unify-c22-c45-scan-error-handling-8012bb69bbf9

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


