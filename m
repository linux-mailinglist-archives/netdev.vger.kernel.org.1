Return-Path: <netdev+bounces-99116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C08D3BCD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D651F2380C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348C318413D;
	Wed, 29 May 2024 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="ASnKYqZX"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF0139588
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998745; cv=none; b=N25bAgwPZtZUaIW2vpldklQb3GL7EUWPh7cUilv3tKIAPOc6BBzmc7wRYdIpw0wMdyeQ8TzjOdVOHCsr0aeCmkSwiZaTtKHlbfsfB7MrO+p0VyMQbpwwGQpCADOeoOE9IH/C1eItEM2Ge1IPTL5eVvHrWrfbpunc3hp63ZocK/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998745; c=relaxed/simple;
	bh=gwX2kkdkZRLairWU2xTI1d16ODW2DyEZw3WNUACnlWk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GV/Ur+aZzcOeR/R3NrktzPiVbXrCDPc+y3cJxK0lnCuhDRVLSZtE/5/HwVzbmowFhqlbNY2Dq33NqOQRPNB5iMMwWXdYD6FpdUF+dmL3F9WXTMwSlFFtWDS0JVpz8vpdlykMIHRdXZNWXhWRq0uBROjXlDTvQKblEssAcUtNxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=ASnKYqZX; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024052916053368880d2b3a43e03d26
        for <netdev@vger.kernel.org>;
        Wed, 29 May 2024 18:05:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=0Y8mqvn+ASO0qgqEBYkV7o/QyQw+Qg4BOBuSdQRySBU=;
 b=ASnKYqZXzj31Ew5QmPDwoTZ2XUPiW8iQq1pA7F+DQoOViQJ6Gje+tA1/PTnJYeCSut2YVM
 qxiHD1L+r8D24Lu06fGqQSwL80xB/eT8Vpe9PX87fbSVGlOJoFsFzJXKFB37bH4HtVCX46iF
 WpqlFu0u0FN2CH8Uzw8HQLVWLWns8=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH 0/3] Enable PTP timestamping/PPS for AM65x SR1.0 devices
Date: Wed, 29 May 2024 17:05:09 +0100
Message-Id: <20240529-iep-v1-0-7273c07592d3@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADVSV2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNL3czUAl2LpCSTROPkJEsDMwsloMqCotS0zAqwKdGxtbUAvyR4M1U
 AAAA=
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716998732; l=2334;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=gwX2kkdkZRLairWU2xTI1d16ODW2DyEZw3WNUACnlWk=;
 b=p8e2carzdqE3em6oz7uTTHcMm8aNDjPGFGRJ3Bo2Zb2h9cFywKIi20rkffqeBDCUVtOF9/xPQ
 Gc/l9HZbxmFBp2EKuJyuwknWSs6/LHkP8W2f0PQAhwd3Jkw34/pX/rx
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

The changes are separated into three patches:
 - PATCH 01/03: Register SR1.0 devices with the IEP infrastructure to
		expose a PHC clock to userspace, allowing time to be
		adjusted using standard PTP tools. The code for issuing/
		collecting packet timestamps is already present in the
		current state of the driver, so only this needs to be
		done.
 - PATCH 02/03: Add support for IEP compare event/interrupt handling
		to enable PPS events.
 - PATCH 03/03: Add the interrupts to the IOT2050 device tree.

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
Diogo Ivo (3):
      net: ti: icssg-prueth: Enable PTP timestamping support for SR1.0 devices
      net: ti: icss-iep: Enable compare events
      arm64: dts: ti: iot2050: Add IEP interrupts for SR1.0 devices

 .../boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 12 ++++
 drivers/net/ethernet/ti/icssg/icss_iep.c           | 71 ++++++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   | 49 ++++++++++++++-
 3 files changed, 131 insertions(+), 1 deletion(-)
---
base-commit: 2f0e3f6a6824dfda2759225326d9c69203c06bc8
change-id: 20240529-iep-8bb4a3cb9068

Best regards,
-- 
Diogo Ivo <diogo.ivo@siemens.com>


