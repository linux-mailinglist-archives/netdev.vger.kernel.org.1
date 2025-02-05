Return-Path: <netdev+bounces-163123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FA1A295A3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848F01685FC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFAD1957E4;
	Wed,  5 Feb 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YNVMMHRw"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5DF1D89F8;
	Wed,  5 Feb 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771321; cv=none; b=dCZ3kIJDY5z1/U3QIFe3qCJaQOEQMk6vWja7RuvdaM2uPf5I1uhg7pXB5tLwjVkjuWb3pLBuP1LALsD6eDuG51EqydtHoXdH/UxX3Fs3e6gILHmsqqeqp4+yFiUd5QyczzMjlweOf1auPPQSwYKqE1NVuE2wtSnsawYZhyAjZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771321; c=relaxed/simple;
	bh=7SHd8mXTl/j002K9wm5letf/0Hv/w7gBwrNHLDtLpuo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HctE4hyCT/eL+PHWjD/HQ4rTxY16JChkjHPfKRYcvRhwa/qCMtiUO1v+yjrJoXAXv0RJProkOqxdxeZzKdGal7LYv4fjqkBS1Ex57YD66hdNn4MHd1PWkRIM/CHw0UbRi1GjjmDkhFWr8+2kX1XlhR/8vdIPNKSud1bE6ZU73TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YNVMMHRw; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 515G1PD83452035
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 10:01:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738771286;
	bh=FmbOdU2UgJjlXvsT6/EXT0PuXH5wF4u+Prc8j3Fq5gg=;
	h=From:To:CC:Subject:Date;
	b=YNVMMHRwpeJFkEEL/wIMfjDsCFR9TOQClIggFjiRIDBTCOflxB3hfN+tlQEjW1IKT
	 7pcRHfqc5U9UCOLg7vtlht9LDJ0wd9ocUha8vH0DKxGL/xJur2zhqZWjUDE2oRK/FM
	 eZzjhYCZJf2k4iL6hl5c0byZ7VJ1bBdkAyaB4FT8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 515G1P4U122486
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Feb 2025 10:01:25 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 10:01:25 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 10:01:25 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 515G1OZS061878;
	Wed, 5 Feb 2025 10:01:25 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Jason Reeder <jreeder@ti.com>, <vigneshr@ti.com>, <nm@ti.com>,
        "Chintan
 Vankar" <c-vankar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Thomas Gleixner
	<tglx@linutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [RFC PATCH 0/2] Add support for Timesync Interrupt Router
Date: Wed, 5 Feb 2025 21:31:17 +0530
Message-ID: <20250205160119.136639-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series introduces the driver support for Timesync Interrupt Router,
I will appreciate feedback on the driver implementation.

Timesync Interrupt Router is an instantiation of the generic interrupt
router module. It provides a mechanism to mux M interrupt inputs to N
interrupt outputs, where all M inputs are selectable to be driven as per N
output. More details about interrupt router and timesync interrupt router
can be found in sections 9.3 and 11.3.2 of TRM:
https://www.ti.com/lit/ug/spruiu1d/spruiu1d.pdf

Timesync Interrupt Router's inputs are either from peripherals or from
Device sync events. This series adds support on how we can map output
of the Timesync Interrupt Router corresponding to the input received
from peripherals.

As an instance, one of the input for Timesync Interrupt Router is,
Generator function, which is an output from CPTS module. The CPTS hardware
doesn't support PPS signal generation. Using the GenFx (periodic signal
generator) function, it is possible to model a PPS signal followed by
routing it via the Timesync Interrupt router to the CPTS_HWy_TS_PUSH
(hardware time stamp) input, in order to generate timestamps at 1 second
intervals.

To provide PPS support to am65-cpts driver we need to configure timesync
interrupt router to route input received as GenFx output from CPTS module
back to HWy_TS_PUSH input of CPTS module.

AM62x is one of the SoCs which has Timesync Router and mapping for all its
output corresponding to its input can be found on SDK documentation of
TISCI at:
https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am62x/interrupt_cfg.html#timesync-event-router0-interrupt-router-output-destinations

This series is based on linux-next tagged next-20250205.


Chintan Vankar (2):
  irqchip: ti-tsir: Add support for Timesync Interrupt Router
  net: ethernet: ti: am65-cpts: Add support to configure GenF signal for
    CPTS

 drivers/irqchip/Kconfig             |   9 +++
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/ti-timesync-intr.c  | 109 ++++++++++++++++++++++++++++
 drivers/net/ethernet/ti/am65-cpts.c |  21 ++++++
 4 files changed, 140 insertions(+)
 create mode 100644 drivers/irqchip/ti-timesync-intr.c

-- 
2.34.1


