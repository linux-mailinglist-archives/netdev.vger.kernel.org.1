Return-Path: <netdev+bounces-270066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKJ7Gdi6vWnyAwMAu9opvQ
	(envelope-from <netdev+bounces-270066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:23:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBD22E1505
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21CC53047EB9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960C936CDEB;
	Fri, 20 Mar 2026 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="pCV8zefZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A636C9FC;
	Fri, 20 Mar 2026 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041589; cv=none; b=Wdl9U8pTfxrwti79TWPWO5U7iZY+JReTi6oapzTDLvh+igBV5uXhYOyGb8ZkhFFc4zZ5HMzPl3JxDb1MlijJEIIF+tidEbMfqBQXxGUotEiFLPAf9sYh+q16Ni2l4oqFMJ0itzPbX43YknNU2gIx3mTThbG3asJtPUzJknlVbE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041589; c=relaxed/simple;
	bh=Gq2xqQqrmftpT57FeNDWL0jS4zcLO2bwhEOeokCs5hU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZK4KU6TcAHpGHZrYqzKljMZnZWaMivAzi8EyQrfIMF4CjoXt9/48yAVtTbCeADbGwt4CvyihwwuGMAb8Ltmg72XDiUMpcbEthWJIyevrgcOUeqCtOcfPu8MfIM1Ifxq9mtvDbVN+9bFH2H9R0A+WwWQKTK9SKiEqdJUcqjISAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=pCV8zefZ; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A4580C00081D;
	Fri, 20 Mar 2026 14:19:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A4580C00081D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1774041586;
	bh=Gq2xqQqrmftpT57FeNDWL0jS4zcLO2bwhEOeokCs5hU=;
	h=From:To:Cc:Subject:Date:From;
	b=pCV8zefZWs6nQ8qbbp1PMF1+RrOToJ1ctst8SnXQXzOwdfi66zcRP/OKLvsuX1nhc
	 gNWrYPjzL8EGkttfebarnWYEhmu0cZkLUdIMwhjHva0CnbPoyupwLAgWcAWowBPdgT
	 p78HDblCqKZZWhAEHToVb7nEFCbfQGTBM4aJdS4Q=
Received: from lvnvdb8054.lvn.broadcom.net (lvnvdb8054.lvn.broadcom.net [10.17.214.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id AAA6DAE80;
	Fri, 20 Mar 2026 17:19:43 -0400 (EDT)
From: "Jitendra Vegiraju" <jitendra.vegiraju@broadcom.com>
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	jitendra.vegiraju@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	rmk+kernel@armlinux.org.uk,
	rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	me@ziyao.cc,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	vladimir.oltean@nxp.com,
	lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com,
	maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: [PATCH net-next v8 0/5] net: stmmac: Add PCI driver support for BCM8958x
Date: Fri, 20 Mar 2026 14:19:15 -0700
Message-ID: <20260320211921.1202058-1-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270066-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,armlinux.org.uk,altera.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jitendra.vegiraju@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid]
X-Rspamd-Queue-Id: 6EBD22E1505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

This patchset adds basic PCI ethernet device driver support for Broadcom
BCM8958x Automotive Ethernet switch SoC devices.

This SoC device has PCIe ethernet MAC attached to an integrated ethernet
switch using XGMII interface. The PCIe ethernet controller is presented to
the Linux host as PCI network device.
Management of integrated ethernet switch on this SoC is not handled via
the PCIe interface.

The following block diagram gives an overview of the application.
             +=================================+
             |       Host CPU/Linux            |
             +=================================+
                        || PCIe
                        ||
        +==========================================+
        |           +--------------+               |
        |           | PCIE Endpoint|               |
        |           | Ethernet     |               |
        |           | Controller   |               |
        |           |   DMA        |               |
        |           +--------------+               |
        |           |   MAC        |   BCM8958X    |
        |           +--------------+   SoC         |
        |               || XGMII                   |
        |               ||                         |
        |           +--------------+               |
        |           | Ethernet     |               |
        |           | switch       |               |
        |           +--------------+               |
        |             || || || ||                  |
        +==========================================+
                      || || || || More external interfaces

The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
MAC IP introduces new DMA architecture called Hyper-DMA for virtualization
scalability.

Driver functionality specific to new MAC (DW25GMAC) is implemented in
new file dw25gmac.c.

v7->v8:
   Addressed review comments from v7.
   Patch2:
       Add a helper function with common code for three setup functions
       in dwxgmac2_core.c (Russell King).
   Patch4:
       Use stmmac_plat_dat_alloc() to allocate memory for
       :plat_stmmacenet_data: (Russell King).
       Changed few bool variable initialization to bool types in
       dwxgmac_brcm_default_data().
   Patch5:
       Make use of plat->init, plat->exit handlers to cleanup
       probe function error handling path (Russell King).
       Use managed API to free irq vectors.
v6->v7:
   Minor changes to v6 patchset adapting to recent changes net-next.
   Patch1:
       Make use of the core_type variable for MAC core identification.
       Define enum value DWMAC_CORE_25GMAC and discard previous proposal to
       add new variables in struct plat_stmmacenet_data.
   Patch2:
       Updated patch to latest net-next branch code base.
   Patch3:
       Modified hwif entry matching to use core_type DWMAC_CORE_25GMAC.
   Patch4:
       Adapted glue driver to match recent stmmac core changes.
       Changed susped/resume functionality to use common framework.
   https://lore.kernel.org/netdev/20260313222206.778760-1-jitendra.vegiraju@broadcom.com/
v5->v6:
   Change summary to address comments/suggestions by Serge Semin.
   Patch1:
     Removed the complexity of hdma mapping in previous patch series and
     use static DMA mapping.
     Renamed plat_stmmacenet_data::snps_dev_id as dev_id and moved to
     the beginning of the struct.
   Patch2:
     Added dw25gmac_get_hw_feature() for dw25gmac.
     Use static one-to-one VDMA-TC-PDMA mapping.
   Patch4:
     Remove usage of plat_stmmacenet_data::msi_*_vec variables for
     interrupt vector initialization.
     Change phy_interface type to XGMII.
     Cleanup unused macros.
   https://lore.kernel.org/netdev/20241018205332.525595-1-jitendra.vegiraju@broadcom.com/

v4->v5:
   Summary of changes in this patch series:
   As suggested by Serge Semin, defined common setup function for dw25gmac.
   To accommodate early adopter DW25GMAC used in BCM8958x device, provide
   a mechanism to override snps_id and snps_dev_id used for driver entry
   matching in hwif.c

   Patch1:
     Added plat_stmmacenet_data::snps_id,snps_dev_id fields - Serge Semin
   Patch2:
     Define common setup function for dw25gmac_setup() - Serge Semin
     Support DW25GMAC IPs with varying VDMA/PDMA count - Abhishek Chauhan
     Allocate and initialize hdma mapping configuration data dynamically
     based on device's VDMA/PDMA feature capabilities in dw25gmac_setup().
     Spelling errors in commit log, lower case 0x for hex -Amit Singh Tomar
   Patch3:
     Glue support in hwif.c for DW25GMAC in hwif.c - Serge Semin
     Provide an option to override snps_id and snps_dev_id when the device
     reports version info not conformant with driver's expectations as is
     the case with BCM8958x device. - Serge Semin
   Patch4:
     Remove setup function in the glue driver - Serge Semin
     Remove unnecessary calls pci_enable_device() and pci_set_master()
     in dwxgmac_brcm_pci_resume() - Jakub Kicinski
     Merge variable definitions to single line - Amit Singh Tomar
    https://lore.kernel.org/netdev/20240904054815.1341712-1-jitendra.vegiraju@broadcom.com/
   
v3->v4:
   Based on Serge's questions, received a confirmation from Synopsys that
   the MAC IP is indeed the new 25GMAC design.
   Renamed all references of XGMAC4 to 25GMAC.
   The patch series is rearranged slightly as follows.
   Patch1 (new): Define HDMA mapping data structure in kernel's stmmac.h
   Patch2 (v3 Patch1): Adds dma_ops for dw25gmac in stmmac core
       Renamed new files dwxgmac4.* to dw25gmac.* - Serge Semin
       Defined new Synopsis version and device id macros for DW25GMAC.
       Converted bit operations to FIELD_PREP macros - Russell King
       Moved hwif.h to this patch, Sparse flagged warning - Simon Horman
       Defined macros for hardcoded values TDPS etc - Serge Semin
       Read number of PDMAs/VDMAs from hardware - Serge Semin
   Patch3 (v3 Patch2): Hooks in hardware interface handling for dw25gmac
       Resolved user_version quirks questions - Serge, Russell, Andrew
       Added new stmmac_hw entry for DW25GMAC. - Serge
       Added logic to override synopsis_dev_id by glue driver.
   Patch4 (v3 Patch3): Adds PCI driver for BCM8958x device
       Define bitmmap macros for hardcoded values - Andrew Lunn
       Added per device software node - Andrew Lunn
   Patch5(new/split): Adds BCM8958x driver to build system
   https://lore.kernel.org/netdev/20240814221818.2612484-1-jitendra.vegiraju@broadcom.com/

v2->v3:
   Addressed v2 comments from Andrew, Jakub, Russel and Simon.
   Based on suggestion by Russel and Andrew, added software node to create
   phylink in fixed-link mode.
   Moved dwxgmac4 specific functions to new files dwxgmac4.c and dwxgmac4.h
   in stmmac core module.
   Reorganized the code to use the existing glue logic support for xgmac in
   hwif.c and override ops functions for dwxgmac4 specific functions.
   The patch is split into three parts.
     Patch#1 Adds dma_ops for dwxgmac4 in stmmac core
     Patch#2 Hooks in the hardware interface handling for dwxgmac4
     Patch#3 Adds PCI driver for BCM8958x device
   https://lore.kernel.org/netdev/20240802031822.1862030-1-jitendra.vegiraju@broadcom.com/

v1->v2:
   Minor fixes to address coding style issues.
   Sent v2 too soon by mistake, without waiting for review comments.
   Received feedback on this version.
   https://lore.kernel.org/netdev/20240511015924.41457-1-jitendra.vegiraju@broadcom.com/

v1:  
   https://lore.kernel.org/netdev/20240510000331.154486-1-jitendra.vegiraju@broadcom.com/

Jitendra Vegiraju (6):
  Add 25GMAC core type to dwmac_core_type enum
  Add DW25GMAC support in stmmac core driver
  Integrate dw25gmac into hwif handling
  Add PCI driver support for BCM8958x
  Fix error handling in probe function.
  Add BCM8958x driver to build system

 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   3 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |  12 +-
 .../net/ethernet/stmicro/stmmac/dw25gmac.c    | 161 +++++++
 .../net/ethernet/stmicro/stmmac/dw25gmac.h    |  92 ++++
 .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 445 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   1 +
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  59 ++-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  51 ++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  20 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  35 ++
 include/linux/stmmac.h                        |   1 +
 14 files changed, 876 insertions(+), 24 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c

-- 
2.34.1


