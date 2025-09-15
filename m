Return-Path: <netdev+bounces-223058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AAFB57C56
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72293B1DDA
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71BC30CDA8;
	Mon, 15 Sep 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BC9qtumk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081193093CA
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941596; cv=none; b=sMg1RmCZQ46q/pr2wEH3NvZFweb7UzfKjd7dL+fSZW7XrpqfA2+GugSC3znY4CEYvLKMP+Y+LkWsbObZlAfLQG1L9IqQJZIejD/BqfMOr2IMvhm/JZ/Dwnjd7MoCK0V+JJVJ01yKnKLkQEpv67QfaO/RqobBSRcWJ0ebK6v0mrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941596; c=relaxed/simple;
	bh=Gtg3lrLBDQKiz4qq9tBfhQXZgR8A/q2EUDqWuqq4FFM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=fM5yHvGXC62AW++Y60uWYSRC5wneZ8XsPOwaEJz5TkXE+UUm+d9F72xT1yE1SPqsbYcVn3wIaPTHCNGVB9DVQzbpvu5CagrFPHf0DirbuWPW5KNspp+riQbSt40M7cu9Zxp91qICsQAWoq1wAw1A1Ps6ZquCsIwS+NiknSsbY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BC9qtumk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oAOL19asjmkFbVHES+ZjBKQM49OtvB0WVoMN68o27Po=; b=BC9qtumkH3Ac47ycNAIxG894wv
	4gP0T8BRdurFYiHSLY6rM7TBDZvsJeD54EeS5gDRVKa6ErTPuOrLoA9Gq7fsSgvgiASYmnS9xDzIV
	6Br8XUbxcmao1V959kfgNB8gHr3+jFeBJvJkJeAh/odwECapMDNR62jqiOohuCJNuqTfp5wSSAmsG
	qPr4bxobzNpId7h9pHquXxODVzfqTWWgbUalJHst8WOG7S5Vmw54Oacq/3v8kaNV+lPa830eXcIdr
	WdZSkMAJ5iAnFshLU2fmTMAsdCTzPyAf2e81zvMpfnh7KJOC8jVIMZcpkNr3+6am2pHVUOh3Ph8jl
	/GwUIYlw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36724 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uy8ud-000000000EL-2JPn;
	Mon, 15 Sep 2025 14:06:31 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uy8uc-00000005cFN-3XBU;
	Mon, 15 Sep 2025 14:06:30 +0100
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
Subject: [PATCH net-next 4/5] net: dsa: mv88e6xxx: remove unused 88E6165
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
Message-Id: <E1uy8uc-00000005cFN-3XBU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 15 Sep 2025 14:06:30 +0100

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
index 60c00a15d466..3cf3bed82872 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -46,61 +46,22 @@
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


