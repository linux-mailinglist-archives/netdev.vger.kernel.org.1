Return-Path: <netdev+bounces-283221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJBvELrM9GkDFAIAu9opvQ
	(envelope-from <netdev+bounces-283221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1DA4ADC01
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6ADB3005A9F
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF383D1CC5;
	Fri,  1 May 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="uZUGjoJq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4233D170B
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650870; cv=none; b=QrtJE42b0CrTOliKDE//Z4JB7As46KRWAokZ/2u1RlYdnGAOxXBi7bKxwec4f2wclW78otr0haao9L+1cotzWv2S/Oj03j1fr5Yu7xRpHy6oMs6HbuXibfSPFtjO533LLRGE3x1w/r7NXHLJ1AFvlAZ820gX1sOjqWkGf3S9B74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650870; c=relaxed/simple;
	bh=er84+EL1LCRrKcCTeLU8j/iTzDlY+KZoIM5wKUiIGjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRmma1y5ISt1uhkN57vCjFUpCPF8+hN5/vh0ntmyvdlRtsCIzpX5tYJ4sUEFvJTQhemL3XWnKmxqHa7x+Aa0THNZMYTKjNwYilVp7Krimq2FKYNwFfxqqH2nffd1YWQpvanK4xMBerNO0nTFpMht39/UhV7jYRAP6f7rtcYGjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=uZUGjoJq; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a08fa355a1so28892876d6.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777650868; x=1778255668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8otWr85W9XMyDBNKDSXuSyml6J7KaSXr45sNqDPMQHs=;
        b=uZUGjoJqg7OutEGNDHTI2oMO/F77B/t+zmO9ScW5BqOPO4pjUMny6sz8jXr64r/Mtr
         FXVYrtoTb6MTnx7Y4I7jdCgudX1nSsGStGmnBRoQxdgBI1QrtTp6CxbVgB0I2wDEe0Gg
         frnyIctANylsD2cgsz1CH5/Qc5agEdgGDFsApF4a+ur2pYGKndCc5CrAsg2hg3VCKTIP
         V77hNekiCuo+wffUB4J9DrNMhGpqN7HoWDLqKls2p8Nv7m7x/NEHcMY5DDtape3WvDrL
         Gk1QXtA8z6RmZRMbWDXmFuHMoPw3jYwtSrx9kVr7b3VRh508/IHuqB8vaVTF3cE6ib/Y
         Q93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650868; x=1778255668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8otWr85W9XMyDBNKDSXuSyml6J7KaSXr45sNqDPMQHs=;
        b=i2J2C2PMXLQCCHPe9akl61JpqaouUJEDjCBQue2Gzuencd0TQyFd3iFKKWMXQrrF0u
         F+Pm30LdeHXvBR/ueNpQhzcXWrOZg2dkUrBOfqfKIJJAdUmnl4oF2YntBh8nUdT8cxbi
         1/+2ZzRAmrwvgOuO4h6tpxHhfMe4yMIUMc6S9/QmG0OhHNnvu2emNCPpXnVCwYhH5JPM
         u1F8bJfrjyaf3hTMEtN07AmJ0i7Bm/5gyfPB5yhards5EDxnuBFr3iLcE5rPpMT6M0l9
         VXsqXa6UePMzEALySd1IvkUr+2QjZ0tqWJyeLp9QvkqcHQ0A9KrB3ulMJq+KN52PD819
         WlxA==
X-Forwarded-Encrypted: i=1; AFNElJ8PAetavudoBcwT6dPKMnGnUBetuqqxxZh8BpeARKv2LqAj68L47ltynr0NVY8KNkt/tRW9Zdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Z1nUV36hSucxXFdTUrdO5s91OxlnQGpxSwemrT9gdwCwydR5
	Ti++z70/vOP2SASw+OCEqSRKKmtm6rttOdEITgS94/7P1uyLI5ktHjfYKhSI+hErKFo=
X-Gm-Gg: AeBDietcVm0ama6IeYs7dvcbec0I3rWYeBScchchuWV6U0P6/FQuHMJlEzaNJKi1tQs
	IAjP9PY9uKrlZW0lxMx1XwKTghZC+OMpNtRiQLz1rZkE72340mOHBCj3HTdDi0UCPNG/JdscgrT
	I7zcpfi2ngnBE3nET8rQPfuis4iA0YD9ZmqZXEw5K4YxBOx9+dlOzzpIxqhlJNM8lb/Cs7Sm5cQ
	mKpwq9XWemuJ20Uh4gHRa0XuhpXw3wQUFWyHJu6RB/dFfC6B5jpvpJuopLnc+E+4JMjP85+DaOO
	8hKygJKhILKW4rPY9fxTut2AOuWdxKrKyKR4ClgKkxUFkFpZCYq9XHO0r4bmOGW2VnjUb4p89PL
	/pWUnr+XeXDI2aHpHZysAnxgJ35/2SVE7znYu09Dp/D/ivfzL2OIrGA6uUb8UHhORswDsWZCoLe
	zGszrx0crxojTP0XOFbC58y95aVTJZaMQTHKuFFJOcbsu+It2P4aHx39N5sp8nS1eANc8VgPSRg
	wpR3A==
X-Received: by 2002:a05:6214:4c8f:b0:89a:173d:9c5c with SMTP id 6a1803df08f44-8b6686383cfmr363016d6.32.1777650867766;
        Fri, 01 May 2026 08:54:27 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm26615406d6.22.2026.05.01.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:54:27 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: daniel@riscstar.com,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	matthew.gerlach@altera.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/12] net: enable TC956x support
Date: Fri,  1 May 2026 10:54:08 -0500
Message-ID: <20260501155421.3329862-1-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD1DA4ADC01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,kernel.org,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283221-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This series introduces stmmac driver support for the Toshiba TC9564
(also known as Qualcomm QPS615).  This is an Ethernet-AVB/TSN bridge IC
that provides a high-speed connection between a host SoC and Ethernet
devices on a network.  It incorporates a PCIe switch, and implements
two 10 Gbps capable Ethernet MACs (along with other IP blocks), and
is essentially a small and highly-specialized SoC.  The TC9564 is a
member of a family of similar chips, and the driver code uses "tc956x"
to reflect this.

TC956x chips incorporate a PCIe gen 3 switch, with one upstream and
three downstream ports.  Its PCIe functionality is already supported
upstream, including a power control driver that performs some early
configuration of the PCI ports ("pci-pwrctrl-tc9563.c").

One of the PCIe switch's downstream ports has an internal PCIe endpoint,
which implements two PCIe functions, each of which has an Ethernet MAC
(eMAC) subsystem. The eMAC is composed of a Synopsis Designware XGMAC
combined with an XPCS and PMA.  Each MAC is capable of operating at
10M/100M/1G/2.5G/5Gps and 10Gps.  The initial target platform is the
Qualcomm RB3gen2, which supports a 10Gbps Marvell PHY on port A, and
a 2.5Gbps Qualcomm PHY on port B.  (The Marvell PHY is not populated on
all RB3gen2 boards, and only 2.5 Gbps support is included initially.)

TC956x chips also implement several other blocks of functionality,
including a GPIO controller, interrupt controllers (MSIGEN), I2C
and SPI, a UART, and an Arm Cortex M3 CPU with 128KB SRAM.  The GPIO
interface exposes several lines to manage external resets.  The
interrupt controllers are used internally by the MAC functions.  The
UART, SPI, microcontroller, and SRAM are currently unused.

              ----------------------------------
              |              Host              |
              ------+...+----------+........+---
                    |i2c|          |  PCIe  |
    ----------------+...+----------+........+------
    | TC956x        |I2C|          |upstream|     |
    |               -----        --+--------+---  |
    |  -----  ------  -------    | PCIe switch |  |
    |  |SPI|  |GPIO|  |reset|    |             |  |
    |  -----  ------  |clock|    | DS3 DS2 DS1 |  |
    |                 -------    ---++--++--++--  |
    |  -----  ------     downstream//    \\  \\   |  downstream
    |  |MCU|  |SRAM|    /==========/      \\  \===== PCIe port 1
    |  -----  ------   //PCIe port 3       \\     |
    |                  ||                   \======= downstream
    |  ----+-----------++-----------+----         |  PCIe port 2
    |  | M | internal PCIe endpoint | M |         |
    |  | S |------------------------| S |  ------ |
    |  | I |   PCIe   |  |   PCIe   | I |  |UART| |
    |  | G |function 0|  |function 1| G |  ------ |
    |  | E |----++----|  |----++----| E |         |
    |  | N |  eMAC 0  |  |  eMAC 1  | N |         |
    --------+.......+------+.....+-----------------
            |USXGMII|      |SGMII|
          --+.......+--  --+.....+--
          |  ARQ113C  |  | QEP8121 |
          |    PHY    |  |   PHY   |
          -------------  -----------

The primary objective for this series is to support the Ethernet
functionality provided by the TC956x.  The code providing this
support has been structured into three distinct modules.
  - A driver for the GPIO controller
  - Code enabling the TC956x-specific eMAC/MSIGEN hardware
  - A "chip" driver, associated with the PCIe functions

The GPIO driver is implemented separately because in some hardware
configurations, these GPIO lines are used to manage resets for
external Ethernet PHYs.  We describe these PHYs via devicetree,
where the GPIO-based reset signals are defined using phandles.

The code for the eMAC/MSIGEN consists of a new source file that
populates hardware-specific details about the two MACs, and integrates
with the existing stmmac driver.  This also required implementing some
enhancements to the core stmmac driver, described further below.

To manage the common functionality (including configuring address
translation and controlling internal reset and clock signals), a
"chip" driver is implemented.  This chip driver is associated with
the PCIe function *itself*, not the eMAC associated with the function.

The driver binds to the internal PCI functions 0 and 1, and creates
a shared data structure describing the common chip elements the two
driver instances share.  Three auxiliary bus devices are created to
represent the GPIO controller and the two Synopsys MAC controllers.

The driver instance for PCIe function 0 has responsibility for
controlling the common chip functionality--creating the GPIO
controller auxiliary device, configuring address translation
between PCIe address space and internal addresses, and controlling
clocks and resets.  It creates a data structure--shared via its
platform data pointer with PCIe function 1--to represent shared
"chip" information.  In addition, PCIe function 0 creates an
auxiliary device to represent its attached eMAC.  It allocates
IRQs and maps BAR address ranges for use by the stmmac driver,
passing them in a structure via the auxiliary device's platform
data.

PCIe function 1 defers probing until after PCIe function 0 has
created the shared data structure.  After that its only job is
to set up IRQs and mapped memory and create the eMAC1 auxiliary
device.

The version of the Synopsys MAC IP is 3.01, which is largely compatible
with version 2.20.  The core stmmac driver required several changes to
enable support for the TC956x.
  - A change to dwxgmac2 support changes the interrupt mode when
    multi_msi_en is enabled.
  - While most support for version 3.01 simply uses the 2.20 code,
    an erratum related to the RX ring length is implemented for
    3.01 DMA operations.
  - Having the PCIe device be separate from an auxiliarly device
    implementing the eMAC required allowing a distinct DMA device
    to be maintained for an stmmac interface.

In addition:
  - A new source file provides memory-mapped access to XPCS using
    regmap.  The alignment of the TC956x MDIO registers aren't
    suitable for using simple MMIO.
  - Two additional XPCS changes are implemented that provides
    support for the XPCS as implemented in the TC956x.

This series is available here:
  https://github.com/riscstar/linux/tree/tc956x/stmmac-v1

					-Alex (and Daniel)

Alex Elder (3):
  net: stmmac: dma: create a separate dma_device pointer
  gpio: tc956x: add TC956x/QPS615 support
  misc: tc956x_pci: add TC956x/QPS615 support

Daniel Thompson (9):
  net: pcs: pcs-xpcs-regmap: support XPCS memory-mapped MDIO bus via
    regmap
  net: pcs: pcs-xpcs: select operating mode for 10G-baseR capable PCS
  net: pcs: pcs-xpcs: Preserve BMCR_ANENBLE during link up
  net: stmmac: dwxgmac2: Add multi MSI interrupt mode
  net: stmmac: dwxgmac2: Add XGMAC 3.01a support
  net: stmmac: dwxgmac2: export symbols for XGMAC 3.01a DMA
  dt-bindings: net: toshiba,tc965x-dwmac: add TC956x Ethernet bridge
  net: stmmac: tc956x: add TC956x/QPS615 support
  arm64: dts: qcom: qcs6490-rb3gen2: enable TC9564 with a single QCS8081
    phy

 .../bindings/net/toshiba,tc956x-dwmac.yaml    | 111 +++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  45 +-
 drivers/gpio/Kconfig                          |  11 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-tc956x.c                    | 209 +++++
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/tc956x_pci.c                     | 667 +++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  13 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +
 .../net/ethernet/stmicro/stmmac/chain_mode.c  |  12 +-
 .../ethernet/stmicro/stmmac/dwmac-tc956x.c    | 791 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  12 +
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   1 +
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |   1 +
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  78 +-
 .../net/ethernet/stmicro/stmmac/ring_mode.c   |  12 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  59 +-
 .../net/ethernet/stmicro/stmmac/stmmac_xdp.c  |   2 +-
 drivers/net/pcs/Makefile                      |   4 +-
 drivers/net/pcs/pcs-xpcs-regmap.c             | 203 +++++
 drivers/net/pcs/pcs-xpcs.c                    |  43 +-
 include/linux/pcs/pcs-xpcs-regmap.h           |  20 +
 include/linux/stmmac.h                        |   1 +
 include/soc/toshiba/tc956x-dwmac.h            |  84 ++
 26 files changed, 2341 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
 create mode 100644 drivers/gpio/gpio-tc956x.c
 create mode 100644 drivers/misc/tc956x_pci.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
 create mode 100644 drivers/net/pcs/pcs-xpcs-regmap.c
 create mode 100644 include/linux/pcs/pcs-xpcs-regmap.h
 create mode 100644 include/soc/toshiba/tc956x-dwmac.h


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.51.0


