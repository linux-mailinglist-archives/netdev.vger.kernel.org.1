Return-Path: <netdev+bounces-222506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDE2B54A4D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72281AC25C7
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135B2FD1C5;
	Fri, 12 Sep 2025 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="H6oOFmft"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C712FD1D6;
	Fri, 12 Sep 2025 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674099; cv=none; b=aes7iiEadGwpy6sGcs0nBIaIcYMdX5fHpPbCrW85XdKgS320eRXHo2xJdedtoFu7oCRSCL7NH8xxtaHJ7phC8ePBKD2jUXE2czGkoi/1TvsdZC4GFYOXPeiqRh9NkGfaYoHFRo8oDg81h2D94AhqhjVlVtH5QcSsmgyZ0ZSz2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674099; c=relaxed/simple;
	bh=Z7Pln5LTgZszALstLnj6rZvCravk6nhRRYnxGrHP58o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9E/WQm+4f1nw2rHxSJBUFHyZr360vTvkzWudE7KBuFjTvbviG/dC5ElqnYnHGqrrcbgeMs6dm2yTTGp5f412kSZSNEQd3U6NROxLsVvyJKCZasViQrFhx9KUmHENlN+Csh/twAFeiObpgCw7c6qQ9K0xYRZPEVU5hUSaUl1SkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=H6oOFmft; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tHyObWRBc+w7/TZVsa/8EuymxPotwQp52ccIw8C968g=; b=H6oOFmft+OeJxNyEMHhcixJVS4
	5yB3EW9C32Bcoue2aBmWIOAGegw6rYDHvlEEjVePiTPHvT7Z5/2ms6L7pEPj79EBZFgHHM0FkZb4t
	+DKIdbnixNT7zft3VfjIRSPt05E06h7iJjplFSTwrX58D6xiYP2H4Q3OD/fbq3Whb74ThFWfWY+Xs
	2AM5yVa74fUxugCEbqCTEKt3HDduIO40HnAnE5xx4TowejCPLmabDExSwxKm69cD5m1uyGtEWmrVT
	AZPcnCuDPzHkiOCw3JTX7WqRXqLpAZWofUIYStbd/QZfW+Pgvftf87IM46AKAOHoHOLGcAOwYj2md
	18qO/rGQ==;
Received: from [122.175.9.182] (port=38569 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1ux1K0-000000022nY-0FId;
	Fri, 12 Sep 2025 06:48:03 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ssantosh@kernel.org,
	richardcochran@gmail.com,
	m-malladi@ti.com,
	s.hauer@pengutronix.de,
	afd@ti.com,
	jacob.e.keller@intel.com,
	kory.maincent@bootlin.com,
	johan@kernel.org,
	alok.a.tiwari@oracle.com,
	m-karicheri2@ti.com,
	s-anna@ti.com,
	horms@kernel.org,
	glaroque@baylibre.com,
	saikrishnag@marvell.com,
	diogo.ivo@siemens.com,
	javier.carrasco.cruz@gmail.com,
	basharath@couthit.com,
	parvathi@couthit.com,
	pmohan@couthit.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	bastien.curutchet@bootlin.com,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v16 0/6] PRU-ICSSM Ethernet Driver
Date: Fri, 12 Sep 2025 16:14:49 +0530
Message-ID: <20250912104741.528721-1-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
Megabit ICSS (ICSSM).

Support for ICSSG Dual-EMAC mode has already been mainlined [1] and the
fundamental components/drivers such as PRUSS driver, Remoteproc driver,
PRU-ICSS INTC, and PRU-ICSS IEP drivers are already available in the mainline
Linux kernel. The current set of patch series builds on top of these components
and introduces changes to support the Dual-EMAC using ICSSM on the TI AM57xx,
AM437x and AM335x devices.

AM335x, AM437x and AM57xx devices may have either one or two PRU-ICSS instances
with two 32-bit RISC PRU cores. Each PRU core has (a) dedicated Ethernet interface
(MII, MDIO), timers, capture modules, and serial communication interfaces, and
(b) dedicated data and instruction RAM as well as shared RAM for inter PRU
communication within the PRU-ICSS.

These patches add support for basic RX and TX  functionality over PRU Ethernet
ports in Dual-EMAC mode.

Further, note that these are the initial set of patches for a single instance of
PRU-ICSS Ethernet.  Additional features such as Ethtool support, VLAN Filtering,
Multicast Filtering, Promiscuous mode, Storm prevention, Interrupt coalescing,
Linux PTP (ptp4l) Ordinary clock and Switch mode support for AM335x, AM437x
and AM57x along with support for a second instance of  PRU-ICSS on AM57x
will be posted subsequently.

The patches presented in this series have gone through the patch verification
tools and no warnings or errors are reported. Sample test logs obtained from AM33x,
AM43x and AM57x verifying the functionality on Linux next kernel are available here:

[Interface up Testing](https://gist.github.com/ParvathiPudi/59ca0087dc7bed0f83a3b0e6db27d39c)

[Ping Testing](https://gist.github.com/ParvathiPudi/bcd39aa7006f6176d8c5b71a23d0928b)

[Iperf Testing](https://gist.github.com/ParvathiPudi/9bb4fa42410fbc757a93f65ecb45e4f3)

[1] https://lore.kernel.org/all/20230106121046.886863-1-danishanwar@ti.com/
[2] https://lore.kernel.org/all/20250108125937.10604-1-basharath@couthit.com/

This is the v16 of the patch series [v1]. This version of the patchset
addresses the comments made on [v15] of the series.

Changes from v15 to v16 :

*) Added a patch to update the MAINTAINERS entries as per Jakub Kicinski's
review comment.
*) Rebased the series on latest net-next.

Changes from v14 to v15 :

*) Addressed Jakub Kicinski's comments on patch 4 of the series.
*) Addressed MD Danish Anwar comments on patch 2 of the series.
*) Rebased the series on latest net-next.

Changes from v13 to v14 :

*) Addressed Jakub Kicinski's comments on patch 4 of the series.
*) Addressed MD Danish Anwar comments on cover letter of the series.
*) Rebased the series on latest net-next.

Changes from v12 to v13 :

*) Addressed Alok Tiwari comments on patch 2, 3 and 5 of the series.
*) Addressed Bastien Curutchet comment on patch 2 of the series.
*) Rebased the series on latest net-next.

Changes from v11 to v12 :

*) Addressed Jakub Kicinski's comments on patch 2 of the series.
*) Rebased the series on latest net-next.

Changes from v10 to v11 :

*) Reduced patch series size by removing features such as Ethtool support,
VLAN filtering, Multicast filtering, Promiscuous mode handling, Storm Prevention,
Interrupt coalescing, and Linux PTP (ptp4l) ordinary clock support. This was done
based on Jakub Kicinski's feedback regarding the large patch size (~5kLoC).
Excluded features will be resubmitted.
*) Addressed Jakub Kicinski comments on patch 2, and 3 of the series.
*) Addressed Jakub Kicinski's comment on patch 4 of the series by implementing
hrtimer based TX resume logic to notify upper layers in case of TX busy.
*) Rebased the series on latest net-next.

Changes from v9 to v10 :

*) Addressed Vadim Fedorenko comments on patch 6 and 11 of the series.
*) Rebased the series on latest net-next.

Changes from v8 to v9 :

*) Addressed Vadim Fedorenko comments on patch 6 of the series.
*) Rebased the series on latest net-next.

Changes from v7 to v8 :

*) Addressed Paolo Abeni comments on patch 3 and 4 of the series.
*) Replaced threaded IRQ logic with NAPI logic based on feedback from Paolo Abeni.
*) Added Reviewed-by: tag from Rob Herring for patch 1.
*) Rebased the series on latest net-next.

Changes from v6 to v7 :

*) Addressed Rob Herring comments on patch 1 of the series.
*) Addressed Jakub Kicinski comments on patch 4, 5 and 6 of the series.
*) Addressed Alok Tiwari comments on Patch 1, 4 and 5 of the series.
*) Rebased the series on latest net-next.

Changes from v5 to v6 :

*) Addressed Simon Horman comments on patch 2, 7 and 11 of the series.
*) Addressed Andrew Lunn comments on patch 5 of the series.
*) Rebased the series on latest net-next.

Changes from v4 to v5 :

*) Addressed Andrew Lunn and Keller, Jacob E comments on patch 5 of the series.
*) Rebased the series on latest net-next.

Changes from v3 to v4 :

*) Added support for AM33x and AM43x platforms.
*) Removed SOC patch [2] and its dependencies.
*) Addressed Jakub Kicinski, MD Danish Anwar and Nishanth Menon comments on cover
   letter of the series.
*) Addressed Rob Herring comments on patch 1 of the series.
*) Addressed Ratheesh Kannoth comments on patch 2 of the series.
*) Addressed Maxime Chevallier comments on patch 4 of the series.
*) Rebased the series on latest net-next.

Changes from v2 to v3 :

*) Addressed Conor Dooley comments on patch 1 of the series.
*) Addressed Simon Horman comments on patch 2, 3, 4, 5 and 6 of the series.
*) Addressed Joe Damato comments on patch 4 of the series.
*) Rebased the series on latest net-next.

Changes from v1 to v2 :

*) Addressed Andrew Lunn, Rob Herring comments on patch 1 of the series.
*) Addressed Andrew Lunn comments on patch 2, 3, and 4 of the series.
*) Addressed Richard Cochran, Jason Xing comments on patch 6 of the series.
*) Rebased patchset on next-202401xx linux-next.

[v1] https://lore.kernel.org/all/20250109105600.41297-1-basharath@couthit.com/
[v2] https://lore.kernel.org/all/20250124122353.1457174-1-basharath@couthit.com/
[v3] https://lore.kernel.org/all/20250214054702.1073139-1-parvathi@couthit.com/
[v4] https://lore.kernel.org/all/20250407102528.1048589-1-parvathi@couthit.com/
[v5] https://lore.kernel.org/all/20250414113458.1913823-1-parvathi@couthit.com/
[v6] https://lore.kernel.org/all/20250423060707.145166-1-parvathi@couthit.com/
[v7] https://lore.kernel.org/all/20250503121107.1973888-1-parvathi@couthit.com/
[v8] https://lore.kernel.org/all/20250610105721.3063503-1-parvathi@couthit.com/
[v9] https://lore.kernel.org/all/20250623135949.254674-1-parvathi@couthit.com/
[v10] https://lore.kernel.org/all/20250702140633.1612269-1-parvathi@couthit.com/
[v11] https://lore.kernel.org/all/20250722132700.2655208-1-parvathi@couthit.com/
[v12] https://lore.kernel.org/all/20250724072535.3062604-1-parvathi@couthit.com/
[v13] https://lore.kernel.org/all/20250812110723.4116929-1-parvathi@couthit.com/
[v14] https://lore.kernel.org/all/20250822132758.2771308-1-parvathi@couthit.com/
[v15] https://lore.kernel.org/all/20250904101729.693330-1-parvathi@couthit.com/

Thanks and Regards,
Parvathi.

Parvathi Pudi (3):
  dt-bindings: net: ti: Adds DUAL-EMAC mode support on PRU-ICSS2 for
    AM57xx, AM43xx and AM33xx SOCs
  net: ti: icssm-prueth: Adds IEP support for PRUETH on AM33x, AM43x and
    AM57x SOCs
  MAINTAINERS: Add entries for ICSSM Ethernet driver

Roger Quadros (3):
  net: ti: icssm-prueth: Adds ICSSM Ethernet driver
  net: ti: icssm-prueth: Adds PRUETH HW and SW configuration
  net: ti: icssm-prueth: Adds link detection, RX and TX support.

 .../devicetree/bindings/net/ti,icss-iep.yaml  |   10 +-
 .../bindings/net/ti,icssm-prueth.yaml         |  233 +++
 .../bindings/net/ti,pruss-ecap.yaml           |   32 +
 .../devicetree/bindings/soc/ti/ti,pruss.yaml  |    9 +
 MAINTAINERS                                   |   12 +
 drivers/net/ethernet/ti/Kconfig               |   12 +
 drivers/net/ethernet/ti/Makefile              |    3 +
 drivers/net/ethernet/ti/icssg/icss_iep.c      |  101 +
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 1748 +++++++++++++++++
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |  262 +++
 .../net/ethernet/ti/icssm/icssm_prueth_ptp.h  |   85 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  257 +++
 12 files changed, 2761 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_ptp.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switch.h

-- 
2.43.0


