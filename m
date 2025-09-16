Return-Path: <netdev+bounces-223714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274D3B5A358
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F391886E34
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2800930B53A;
	Tue, 16 Sep 2025 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VDDsf+0Y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6C304BBA
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054911; cv=none; b=fwVSTHQ+b8lRqHjfFtwf2zPxzXBNM1ZswzZ03tXdIMhee2g7k/q3hpJJEMkIgII19Dgw3bfSYeS6S8Om7GXn5HC8SWlTx4+g0q2Qduv7IXEuasNr97HOyBMENNHSawDMb9NR3McFx+VzoVe0yNXYV1DqK+/Ve+n3tzYH1P2woXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054911; c=relaxed/simple;
	bh=L7j1Criv+922B70uFnhglneKJnljliB9Z8zQ7yYnoNI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=j5CEkB2FDQHO4mxaB1M+UflsgheBQ4rFN4vvxHhZW1xbO51yRMnSbbOGHn8td8PSlLkNOcbMwoPveCgzJLbqbSkwhT5CyO1yfG+1V7xQQgUn7XAqqf6zg8ETRm/oJhmzQmFgtbKLeV3zL0IXyvgRQmXE1sAz7hOi0VOw78sIKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VDDsf+0Y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C+tidYxM0HTuYfalldaox0E+gGCFUC7JbwJN9kreewE=; b=VDDsf+0YK0b898Q+ZpH2JlNiLj
	LbM95gz8hO330At2KBbOYihu7+aMe+hzi/AKCDyLYtdcr88Fa22Vo7dXaFT9kIXE9rEoXOd80hFWB
	DuRIuzEvpjtvfeOvEwanOQGI6o9gDzqwS/F+JRGGmRSrrNDYVeV6qGQWjGquyvftvozoTZZ1iJOfq
	kDwhEdIBw20R/Hb0fGbuJJWbZrsZPqbE++arqY4h0RBp90Rk/iHrvNRousGGHY2DSPAV/oUQOQenL
	QjClrLwm3bd12muK649e8gE8OakMjzrCA5znIflx2Rbe7Jg39hC1NXnwsxMsua8u7ciAkMBskxtH9
	lcpVkk6g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60630 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uycOG-0000000068X-2aJg;
	Tue, 16 Sep 2025 21:35:04 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uycOF-00000005xbC-3Mn4;
	Tue, 16 Sep 2025 21:35:03 +0100
In-Reply-To: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
References: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 4/5] net: dsa: mv88e6xxx: remove unused 88E6165
 register definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uycOF-00000005xbC-3Mn4@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 16 Sep 2025 21:35:03 +0100

Remove the unused 88E6165 register definitions. For the port
registers, add a comment describing that each arrival and departure
offset is for a set of four registers that correspond with status,
two timestamp registers and the PTP sequence ID captured from the
packet.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/ptp.h | 45 +++------------------------------
 1 file changed, 3 insertions(+), 42 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index a8dc34f1f8bf..529ac5d0907b 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -45,61 +45,22 @@
 #define MV88E6352_TAI_TIME_HI			0x0f
 
 /* 6165 Global Control Registers */
-/* Offset 0x01: Message ID */
-#define MV88E6XXX_PTP_GC_MESSAGE_ID		0x01
-
-/* Offset 0x02: Time Stamp Arrive Time */
-#define MV88E6XXX_PTP_GC_TS_ARR_PTR		0x02
-
-/* Offset 0x03: Port Arrival Interrupt Enable */
-#define MV88E6XXX_PTP_GC_PORT_ARR_INT_EN	0x03
-
-/* Offset 0x04: Port Departure Interrupt Enable */
-#define MV88E6XXX_PTP_GC_PORT_DEP_INT_EN	0x04
-
-/* Offset 0x05: Configuration */
-#define MV88E6XXX_PTP_GC_CONFIG			0x05
-#define MV88E6XXX_PTP_GC_CONFIG_DIS_OVERWRITE	BIT(1)
-#define MV88E6XXX_PTP_GC_CONFIG_DIS_TS		BIT(0)
-
-/* Offset 0x8: Interrupt Status */
-#define MV88E6XXX_PTP_GC_INT_STATUS		0x08
-
 /* Offset 0x9/0xa: Global Time */
 #define MV88E6165_PTP_GC_TIME_LO		0x09
 #define MV88E6165_PTP_GC_TIME_HI		0x0A
 
-/* 6165 Per Port Registers */
+/* 6165 Per Port Registers. The arrival and departure registers are a
+ * common block consisting of status, two time registers and the sequence ID
+ */
 /* Offset 0: Arrival Time 0 Status */
 #define MV88E6165_PORT_PTP_ARR0_STS	0x00
 
-/* Offset 0x01/0x02: PTP Arrival 0 Time */
-#define MV88E6165_PORT_PTP_ARR0_TIME_LO	0x01
-#define MV88E6165_PORT_PTP_ARR0_TIME_HI	0x02
-
-/* Offset 0x03: PTP Arrival 0 Sequence ID */
-#define MV88E6165_PORT_PTP_ARR0_SEQID	0x03
-
 /* Offset 0x04: PTP Arrival 1 Status */
 #define MV88E6165_PORT_PTP_ARR1_STS	0x04
 
-/* Offset 0x05/0x6E: PTP Arrival 1 Time */
-#define MV88E6165_PORT_PTP_ARR1_TIME_LO	0x05
-#define MV88E6165_PORT_PTP_ARR1_TIME_HI	0x06
-
-/* Offset 0x07: PTP Arrival 1 Sequence ID */
-#define MV88E6165_PORT_PTP_ARR1_SEQID	0x07
-
 /* Offset 0x08: PTP Departure Status */
 #define MV88E6165_PORT_PTP_DEP_STS	0x08
 
-/* Offset 0x09/0x0a: PTP Deperture Time */
-#define MV88E6165_PORT_PTP_DEP_TIME_LO	0x09
-#define MV88E6165_PORT_PTP_DEP_TIME_HI	0x0a
-
-/* Offset 0x0b: PTP Departure Sequence ID */
-#define MV88E6165_PORT_PTP_DEP_SEQID	0x0b
-
 /* Offset 0x0d: Port Status */
 #define MV88E6164_PORT_STATUS		0x0d
 
-- 
2.47.3


