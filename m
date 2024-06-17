Return-Path: <netdev+bounces-104147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370A090B514
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDB51C234B2
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47C15B118;
	Mon, 17 Jun 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="B4TM6ofX"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D315A86C
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637755; cv=none; b=mvxYreOhZ/peJO9HAEMeKPeFkccBDaLSYgx19iMtJwTxQ2j2ejk2jaT/RPVyVL0mSkn340t+TRvLQe8MN7Jgp3/hgPvct9xpBL8gc+i8sIdq65ZNkCYNJ8uCT1y2oL6nQNvQjVOZgzdC3c5kaacvy9OMNYt2a1BKozwm5vv1HGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637755; c=relaxed/simple;
	bh=sg5qrRLMgV+5Rd79tG8DOD89TmOPOBc48So8jR20CzI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WyiP/FmBYlFOngnBvgBMDs8Ur+H4RxUO4DR7qNR3cXVF+xz6CV6AN53feU71e4eHAPN2gN6pB8buEeJbrVTRBfbRHMpYNd6y95E7UpuZrSREC8PB2v7ue4ETn4K6/iqRhXIZAmHhfLMPtp71hnWWOrPkMK4rZcqvQ+eyTHsTSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=B4TM6ofX; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024061715222286f2add98a613d8bb6
        for <netdev@vger.kernel.org>;
        Mon, 17 Jun 2024 17:22:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=fHWwCnEEzxb5x9fgBwa1bofIh1XbeYWIAnnLCU2FiVk=;
 b=B4TM6ofXf907ezC4l9DjfnBIiQ2Qt1MI02YZWecAUOnXX1rceDwOmTNDnvMOC4jGH4X45u
 iVWVNG7Yg50F6aQqFlCeGBpQHo/4QMZoyo1AkXc4kybTqSNj6DT7TgTQrKl2izJOYVwk8aYj
 s+jxUihi/fV304hSDZgtdnv02fL74=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH net-next v4 0/5] Enable PTP timestamping/PPS for AM65x
 SR1.0 devices
Date: Mon, 17 Jun 2024 16:21:39 +0100
Message-Id: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAINUcGYC/2XMQQ6DIBCF4asY1qWBAQG76j2aLgCnlUXRiDE2x
 ruX4KI1XU7efP9KEo4BE7lUKxlxDin0MR/yVBHf2fhEGtp8E2AgWQ0NDThQ45y0wruGKUPy5zD
 iIyylciMRJxpxmcg9L11IUz++S37mZT+UZk4Z1aCFZ7puoBXXFPCFMZ19/yqFGb5KMbkryAqtQ
 e6ZrZVR/0r8Kr0rkZU0IAEkZ7XzR7Vt2wc9RAv8DgEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718637740; l=3378;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=sg5qrRLMgV+5Rd79tG8DOD89TmOPOBc48So8jR20CzI=;
 b=ft2pcbfBtSt7xPuY8+Ze7XzsA/tEgT+g3/HWFb9JuBvF7HFl8d5jGSAwxanu6b8D1J0m1eBGn
 gH6pXeHQ3QECY+5YCUI/GiVyV2knoM7EHqq0rCnRL46FCJc7XKArYXp
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

The changes are separated into five patches:
 - PATCH 01/05: Register SR1.0 devices with the IEP infrastructure to
		expose a PHC clock to userspace, allowing time to be
		adjusted using standard PTP tools. The code for issuing/
		collecting packet timestamps is already present in the
		current state of the driver, so only this needs to be
		done.
 - PATCH 02/05: Remove unnecessary spinlock synchronization.
 - PATCH 03/05: Document IEP interrupt in DT binding.
 - PATCH 04/05: Add support for IEP compare event/interrupt handling
		to enable PPS events.
 - PATCH 05/05: Add the interrupts to the IOT2050 device tree.

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
Changes in v4:
- Remove unused 'flags' variables in patch 02/05
- Add patch 03/05 describing IEP interrupt in DT binding
- Link to v3: https://lore.kernel.org/r/20240607-iep-v3-0-4824224105bc@siemens.com

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
Diogo Ivo (5):
      net: ti: icssg-prueth: Enable PTP timestamping support for SR1.0 devices
      net: ti: icss-iep: Remove spinlock-based synchronization
      dt-bindings: net: Add IEP interrupt
      net: ti: icss-iep: Enable compare events
      arm64: dts: ti: iot2050: Add IEP interrupts for SR1.0 devices

 .../devicetree/bindings/net/ti,icss-iep.yaml       |  9 +++
 .../boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 12 +++
 drivers/net/ethernet/ti/icssg/icss_iep.c           | 88 ++++++++++++++++++----
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   | 51 ++++++++++++-
 4 files changed, 145 insertions(+), 15 deletions(-)
---
base-commit: 2f0e3f6a6824dfda2759225326d9c69203c06bc8
change-id: 20240529-iep-8bb4a3cb9068

Best regards,
-- 
Diogo Ivo <diogo.ivo@siemens.com>


