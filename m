Return-Path: <netdev+bounces-101852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55003900460
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50EA1F23CFE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2C1946DF;
	Fri,  7 Jun 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="puEFBW1i"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9D187324
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766057; cv=none; b=nUiBLkG+rINJVrQY/9UOMzZcM5waK6AJG5YL1r1UyUgVAIDIN8VoyR4B00LqkwCF9UwYk8Q+2eSv9fw0VrXYYzR6pu2GdaFApnyjz8pJN+gALyjKiCkGqWjBnv2w3qISkqNWzWfRSFLvClWHIAT76rYo+VkaU9nBzFH2xuint0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766057; c=relaxed/simple;
	bh=M57GmtZA7uRuye5XGW7w65bnbiEuyeFO424hHO+XQY8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LHoe18ZbZQwlfsCdCZ7iCU6XX0Y4fNzsaDyUTvBrqOjWw/jcDomd2Uvw3qt7pLq/10E/Jt56LDOBMOhrvcgRqaZizFiUU4hRo1Lba2Xe80v4wlE6DZcrL+AGYB5AYB+RBs/zocCQqdwtUi2yb9KHK3WFg8Gct/wrP6A/y0irDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=puEFBW1i; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024060713140988ab2b301d9274c97d
        for <netdev@vger.kernel.org>;
        Fri, 07 Jun 2024 15:14:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=sTjKOiLBJ41DZpxQsI71jhDcMjYRDYvyrj4yxx6L3Vc=;
 b=puEFBW1ivREMLt24MKBqv3xL4egFgbQFdsko6t6gnS+ZPCsXIEYlp9XGNMdqe60wukEyA1
 av894e3zYg66Ul5E9MZLDiIQs/4PaQnmSS3jUi1UKuBQFr1a3CpHgwthZuZn0ZAaONAuGYlY
 gZhjxsaqF2RBP9mepK7SVcEtSMtkU=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH net-next v3 0/4] Enable PTP timestamping/PPS for AM65x
 SR1.0 devices
Date: Fri, 07 Jun 2024 14:02:41 +0100
Message-Id: <20240607-iep-v3-0-4824224105bc@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPEEY2YC/1WMwQ6DIBAFf8XsuTQIithT/6PpAXFb9yAaIMTG+
 O8l9NB4fJk3s0NATxjgVu3gMVGgxeUhLxXYybg3MhrzBsFFw1vRM8KV6WFojLRDz5WG/Fw9vmg
 rlQc4jMzhFuGZyUQhLv5T8qku/FRKNeOsE520vGt7Mcp7IJzRhatd5lJI4m8p3vwskS00GmvLT
 au0OlvHcXwBXZs3HtgAAAA=
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717766048; l=3009;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=M57GmtZA7uRuye5XGW7w65bnbiEuyeFO424hHO+XQY8=;
 b=qIfW66+YKoQkrc5SJJN2tiHs003VGAqgW6y5350rcJBm/109jXHtPaZiTAK/yAPMRkGG2jQLh
 8MkaSvLmFPzC8+gyCxWEwtVlBRJoogcaKmSUfwFxeKwVZjxvI7qDBTO
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

This patch series enables support for PTP in AM65x SR1.0 devices.

This feature relies heavily on the Industrial Ethernet Peripheral
(IEP) hardware module, which implements a hardware counter through
which time is kept. This hardware block is the basis for exposing
a PTP hardware clock to userspace and for issuing timestamps for
incoming/outgoing packets, allowing for time synchronization.

The IEP also has compare registers that fire an interrupt when the
counter reaches the value stored in a compare register. This feature
allows us to support PPS events in the kernel.

The changes are separated into four patches:
 - PATCH 01/04: Register SR1.0 devices with the IEP infrastructure to
		expose a PHC clock to userspace, allowing time to be
		adjusted using standard PTP tools. The code for issuing/
		collecting packet timestamps is already present in the
		current state of the driver, so only this needs to be
		done.
 - PATCH 02/04: Remove unnecessary spinlock synchronization.
 - PATCH 03/04: Add support for IEP compare event/interrupt handling
		to enable PPS events.
 - PATCH 04/04: Add the interrupts to the IOT2050 device tree.

Currently every compare event generates two interrupts, the first
corresponding to the actual event and the second being a spurious
but otherwise harmless interrupt. The root cause of this has been
identified and has been solved in the platform's SDK. A forward port
of the SDK's patches also fixes the problem in upstream but is not
included here since it's upstreaming is out of the scope of this
series. If someone from TI would be willing to chime in and help
get the interrupt changes upstream that would be great!

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
Changes in v3:
- Collect Reviewed-by tags
- Add patch 02/04 removing spinlocks from IEP driver
- Use mutex-based synchronization when accessing HW registers
- Link to v2: https://lore.kernel.org/r/20240604-iep-v2-0-ea8e1c0a5686@siemens.com

Changes in v2:
- Collect Reviewed-by tags
- PATCH 01/03: Limit line length to 80 characters
- PATCH 02/03: Proceed with limited functionality if getting IRQ fails,
	       limit line length to 80 characters
- Link to v1: https://lore.kernel.org/r/20240529-iep-v1-0-7273c07592d3@siemens.com

---
Diogo Ivo (4):
      net: ti: icssg-prueth: Enable PTP timestamping support for SR1.0 devices
      net: ti: icss-iep: Remove spinlock-based synchronization
      net: ti: icss-iep: Enable compare events
      arm64: dts: ti: iot2050: Add IEP interrupts for SR1.0 devices

 .../boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 12 ++++
 drivers/net/ethernet/ti/icssg/icss_iep.c           | 84 +++++++++++++++++++---
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   | 51 ++++++++++++-
 3 files changed, 136 insertions(+), 11 deletions(-)
---
base-commit: 2f0e3f6a6824dfda2759225326d9c69203c06bc8
change-id: 20240529-iep-8bb4a3cb9068

Best regards,
-- 
Diogo Ivo <diogo.ivo@siemens.com>


