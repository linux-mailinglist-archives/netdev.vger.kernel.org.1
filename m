Return-Path: <netdev+bounces-223056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4418B57C55
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52ED23AE8F2
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABADE30B53B;
	Mon, 15 Sep 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gdVcjmfH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD85A30B53A
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941586; cv=none; b=AXvXg6xYtRLXdrDZQBDCmywixORwgckAkAZrMBEeXIY/983qhXB6O5mj9XrGaPT9pP3Tx9jwMcmEIKa0feccPEv5dLnnmdExLg3sVA+ZeuHq0y9Qwtg16UKurI9uFxnk8FE+S0kYK++kzGKZPEhdlRvtGxPC6AyN/Uio5TvRkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941586; c=relaxed/simple;
	bh=OQFY0TAhk+P9xQeUndK4vXkHCkbXW2/3+EnYZ0wmzt4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=m0fbckMHr97wSnrK7OXNgFY8vwn4ngzJmfFMHFi66VoSLQZsJnrXPDIZsCxe/5sPjBLuAp327PzlaNx8fARcCjvv29W6G0FXycIndbBic8ErURT/TeDzJeBgMjnkA40vgJ3YgeMETS93pWZyPt0fmlbU4m6gvsvDHeNE0xtbdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gdVcjmfH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L7Ss2I7o/U8k6ob48al7r4kEYsVIxStdSqkenE6GH20=; b=gdVcjmfH+WmI/O9l/WwxRgVoKj
	scx99stwic12IoTW05AEOKHSmfTGTvXKr6T6H1WOeJnKnM+2HtjmOFNSwNtlMx3EQCfNuZJbrcT5G
	5ecBwDX4RXkMjvp2yV1TrLnom1p1JrtPMJ088rUOOAOGt2tX6XpeCCvuMT8RpFqVEIdXsgWknLwko
	+JDyATh5MtvMjQ7FgPTsEMKFB2TX/EC+JNd9glPLlXatfSplSlvx3crp9+PfldOU8isrlxVTcMwMX
	t9eSopn0phEVud6+3D5Uxz9z7WB8De7AB8x0nt9TMcPIEHeYh2YH4l9/14bnxmus1zDFG7vZ0i+u7
	1eQButHA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37528 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uy8uT-000000000Du-1TLz;
	Mon, 15 Sep 2025 14:06:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uy8uS-00000005cFB-2b1N;
	Mon, 15 Sep 2025 14:06:20 +0100
In-Reply-To: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 2/5] net: dsa: mv88e6xxx: remove unused TAI
 definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uy8uS-00000005cFB-2b1N@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 15 Sep 2025 14:06:20 +0100

Remove the TAI definitions that the code never uses.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/ptp.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 67deb2f0fddb..3e0296303d61 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -33,25 +33,6 @@
 /* Offset 0x01: Timestamp Clock Period (ps) */
 #define MV88E6XXX_TAI_CLOCK_PERIOD		0x01
 
-/* Offset 0x02/0x03: Trigger Generation Amount */
-#define MV88E6XXX_TAI_TRIG_GEN_AMOUNT_LO	0x02
-#define MV88E6XXX_TAI_TRIG_GEN_AMOUNT_HI	0x03
-
-/* Offset 0x04: Clock Compensation */
-#define MV88E6XXX_TAI_TRIG_CLOCK_COMP		0x04
-
-/* Offset 0x05: Trigger Configuration */
-#define MV88E6XXX_TAI_TRIG_CFG			0x05
-
-/* Offset 0x06: Ingress Rate Limiter Clock Generation Amount */
-#define MV88E6XXX_TAI_IRL_AMOUNT		0x06
-
-/* Offset 0x07: Ingress Rate Limiter Compensation */
-#define MV88E6XXX_TAI_IRL_COMP			0x07
-
-/* Offset 0x08: Ingress Rate Limiter Compensation */
-#define MV88E6XXX_TAI_IRL_COMP_PS		0x08
-
 /* Offset 0x09: Event Status */
 /* Offset 0x0A/0x0B: Event Time */
 #define MV88E6352_TAI_EVENT_STATUS		0x09
@@ -64,13 +45,6 @@
 #define MV88E6352_TAI_TIME_LO			0x0e
 #define MV88E6352_TAI_TIME_HI			0x0f
 
-/* Offset 0x10/0x11: Trig Generation Time */
-#define MV88E6XXX_TAI_TRIG_TIME_LO		0x10
-#define MV88E6XXX_TAI_TRIG_TIME_HI		0x11
-
-/* Offset 0x12: Lock Status */
-#define MV88E6XXX_TAI_LOCK_STATUS		0x12
-
 /* Offset 0x00: Ether Type */
 #define MV88E6XXX_PTP_GC_ETYPE			0x00
 
-- 
2.47.3


