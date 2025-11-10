Return-Path: <netdev+bounces-237120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962EC45A03
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421A53B0822
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828C430100C;
	Mon, 10 Nov 2025 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UQMHZXOp"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8252FFF98;
	Mon, 10 Nov 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766709; cv=none; b=aogiQQpWZ0J3fAoQ9+3C6Pd8KFweaZKb/XTvzIFBRR+wQ/eZzIO5V9SslalinJImq9uhKwMPt0S4qccJUxJOlekcfErPWkIUZ8RibkwlDgNKSI3TMlg1OlhQetqG2FlNWINADBj8WEdplmmXejXTcg/dFeQIiCE6n/q8RlT9eIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766709; c=relaxed/simple;
	bh=iUZ/Yx3AukzK6pJNmffYidpyX2g/uXSCest8qxWEuqc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nzCdVmoSuUpamdHO0z90vfk/nMI4LlRXFrOYys71bhxoQIr8M4WRqhybFf9oF+h5DDwSFzzw9MMzeQdUejT3v24/kWrFKr6MXVmebSxlGAL8RHKzB0i4z7cguXatLhHRYsv/Jgvz4+ZnTBCW8rmVJVkzD/kEBA2g77ntBK6FDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UQMHZXOp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8F4C1C108E5;
	Mon, 10 Nov 2025 09:24:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ED1AE606F5;
	Mon, 10 Nov 2025 09:25:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43C21103718CD;
	Mon, 10 Nov 2025 10:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762766701; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2UjXNUAU7fR3oSw2iEJYC571sGcvg1zBexjhCxPzTys=;
	b=UQMHZXOpReBXvyFNfBv6U4tovBJdNrYDWQuOGjE7pe/xi/u+AE11n/wiFckZIprzy2+/SE
	PR48KLP4NvwtDZ38WWt8hTlyaQ3MhPuWDJmbNDQ93hthwVqd/SU1ZB02ylISlajaqTfszS
	yco9YZcGiJvg/lAaf1A+8RgE/65p0OpYJaI6oIOwHnDPh0azyjUsF1NerpswPubSUubXlM
	VZlaTL/pji2AXUkXTQaFOaOyslnTASbzd/cNm/20S/v2LJ5Fc/fpukAABRacpOvauG26Ox
	S+OsZF8KY83RI2cgHF3wqhUj6CoF/9aJY0348TSOCi7ApPx9/TK5qBW9KGcjeQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v2 0/3] net: phy: dp83869: Support 1000Base-X SFP
Date: Mon, 10 Nov 2025 10:24:52 +0100
Message-Id: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGWvEWkC/12NQQqDMBBFryKz7pQZG6t05T2Ki5hOaqBNJAliE
 e/eIF11+Xj89zdIEp0kuFUbRFlccsEXqE8VmEn7p6B7FIaa6oaZLpjsjExEo06yoqbGtJ3qlG4
 UlM0cxbr16N3BS0Yva4ahmMmlHOLnOFr48L+m+msujIRWXdlyS6ZV0o8h5JfzZxPeMOz7/gUIG
 4yftgAAAA==
X-Change-ID: 20251103-sfp-1000basex-a05c78484a54
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

This is version two of my series which adds support for using the DP83869
PHY as a transceiver between an RGMII upper MAC and a downstream 1000Base-X
SFP module.

Patch 1 and 2 of the series are necessary to get the PHY to properly switch its
operating mode to RGMII<->1000Base-X when an SFP module is inserted.

Patch 3 adds the actual SFP support, with only 1000Base-X modules supported for
now.

Side note: A wider-scoped series adding general SFP support to this PHY was sent
some time ago, but was not pursued, mainly due to complications with SGMII
support:

https://lore.kernel.org/netdev/20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com/

Best Regards,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v2:
- Simplified module capability check.
- Fixed unchecked return value in configure_mode().
- Link to v1: https://lore.kernel.org/r/20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com

---
Romain Gantois (3):
      net: phy: dp83869: Restart PHY when configuring mode
      net: phy: dp83869: ensure FORCE_LINK_GOOD is cleared
      net: phy: dp83869: Support 1000Base-X SFP

 drivers/net/phy/dp83869.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
---
base-commit: dd43cb8c0f1de74d7fa47913acbc2bc54672c6e0
change-id: 20251103-sfp-1000basex-a05c78484a54

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


