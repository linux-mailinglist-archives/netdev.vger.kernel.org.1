Return-Path: <netdev+bounces-249458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F93D195CD
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BC18302409E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F17392B82;
	Tue, 13 Jan 2026 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAP2Pc6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF71F392829
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313616; cv=none; b=IZZWg2UqJfN3uHJXd44vYM+1nVTWxzb62Z28j3+RFJdz6GDgCYrnvvrF9bbopDyqB0zP890tpRHw7sYMlZ8vB0BZkbtrV7dOZHnYenuqA+nXUjYSantGr0TcJ3UGS1gzPppK2itHensNnnsZPcPT/1PevkFoLgC8I53IoYjSUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313616; c=relaxed/simple;
	bh=ixwvhtBEkBoDvp5N4KEkKF182ppMydq9tQFQtSsQMTM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jiJ41gd9o549oDsWX8d1ETdnbiKH3gA/TxfJtNM7sXuxn2C7vfHKG5CHt4ycMhNX0tI0pbw3KGANygNGkFsGzLwj3s/YfM0zmrJ/dzx1TN/hdpv+OJED+JFhbeArWed86ih1QdJIxlLp4NSxUpkHpQCKSMf3qazYBx5aWoNGARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dAP2Pc6s; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso69746085e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768313610; x=1768918410; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpPYFuBpeHzrlOUi6OsVjYU9ydxR9fDDFonQuw5LFlU=;
        b=dAP2Pc6sTNDk+xB8Fx9CPJZ5LqG1aueLBOMwUKZ+EMH2PEyy6FgLyqfSsA6v6gamPt
         5EU7j3ls8TmXWIT3L0/vblU/e4t4H4BDYcpntOMVaTnJgC31oy8J5oNefpeM/XEpzKws
         s4VqjitoshTyQz6xTXbHwLbDjsJR10RO6crpPQMwgnAtz9Mz4bgbDZMBn9nsSZgwEeUC
         h4HuSA5MLSvaXx65Aq81jvGngvUHqbwB1x862xQKXbWIx1TMm7KqWf9zUFK88fR2MUlF
         O7kAkvYZx9ktKXZ6YaxkrtShA7/2+OQ415VEQT/eYCSGgEEBPYgYPxtI0+8eOQ5gkvqr
         U56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768313610; x=1768918410;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpPYFuBpeHzrlOUi6OsVjYU9ydxR9fDDFonQuw5LFlU=;
        b=TDs7uP0jxT1EnaYcgSx/wWg7O1ABxdJQfL+QTQ+pSavdFGo4jXwPRoPRiQyUGh6p/x
         N+86x1nDenrAHjVpqZMClZRuGWtj9cjn+er0xKKSwQ9HendUxB10acpUAq6hUMZyRooZ
         RBcP/je4Ds7OmGrY4DhOrn7hz2hiDt1OCUfa1DvLtx0Ffj7cJBwcRjDPPOU9cfkCrt+4
         uAaOVb9qNSa3lUCR+Z/Yr2ssXTBkuhiIoIdQs66klh8sEfIYyp+sKDg6ckWqLhEWe5Yz
         vw0SrYecUVsDwPIE6DYa16dne914aKmQdeQ856MAJJ86epC9LlXe8CGkoFcBu33GhQ6N
         eaIA==
X-Forwarded-Encrypted: i=1; AJvYcCUeNkgXr7nHGcADiTKPMpvDcoDI9HydEGJ0UUt2CUAmqp1OjnSRFsnTqM/fkjASD/D2XgMxyaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0AOWWdGTKGuPBjtCYytthtsAg3zFcjdHU1kwqT1MabZbAtl6
	XmVfSMcpVxZ6BYAnpIvxdk0gAg3FOXrz5fivrOHUAMubjrCvpGmplaUs+hLDvkl6KKE=
X-Gm-Gg: AY/fxX4Ry2t9keZ9MAUBnTOn0yI/EVj6kIhLYWTi1FYI1nB2K0ip+bThnKpkNg97wmn
	smjpRuOKt9lD4pyi1QgjJqCmachAyhqbmtJWx0tucos3E0mbnLoE/Cjgmw9Tnd9YFk5hJ318t6y
	witomFi04X/TSEFYDBv2D4pwRfFItZdkXRGNmEtOy57b/ML594UvWsdtON3LDda64NOCJiSQ0rY
	8BTuBQO59m/sBDK+EwbpXYQwpR7anr0dQTdJKpo5v9DP/W+yL3YPyxKDGigtehszGaJvlwmxxSM
	GlVGmmnVA4Hc4f6VY84nL/D7QwFyFEVxs+WvRbUdLRIwpmDWKNXkwGzkajie+jNt9xoDYi5j2d9
	WKSJ3Ng4T3/Fr7Sk4+BvKY6odlcK3JcZOOHmIgNgrrkjXxgXjeAASfh9XVzBuYeRYVXuCaJBtKz
	uT5dHahxo+AhsBktKLukJAJdmHiT0=
X-Google-Smtp-Source: AGHT+IESteNDhCsp9djoyMeUvPvQ33cMYgxEEj70wmWesi8MDh/SKjav/Vxq6pmgAEpoaSXmrBuSJw==
X-Received: by 2002:a05:600c:1392:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-47d84b3b724mr277918305e9.30.1768313610033;
        Tue, 13 Jan 2026 06:13:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee0b45b8fsm1590895e9.4.2026.01.13.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:13:29 -0800 (PST)
Date: Tue, 13 Jan 2026 17:13:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chester Lin <chester62515@gmail.com>, Frank Li <Frank.li@nxp.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: [PATCH v3 0/3] s32g: Use a syscon for GPR
Message-ID: <cover.1768311583.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Frank has pushed back on this a bit.  I think he objects to how
stmmac/dwmac-s32.c controlls the PHY by writing to a register instead
of through a driver.  Creating a syscon driver will make writing to
other drivers even easier.  In the end, we're going to need to write
to register eventually whether it's directly or through an abstraction
layer.  I feel like this is a good change and when we start dealing
with SCMI then it's an essential change.  I have fixed Krzysztof's
complaint about the poor documentation in the nxp,s32-dwmac.yaml
file.

The s32g devices have a GPR register region which holds a number of
miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
anything from there and we just add a line to the device tree to
access that GMAC_0_CTRL_STS register:

                        reg = <0x4033c000 0x2000>, /* gmac IP */
                              <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */

I have included the whole list of registers below.

We still have to maintain backwards compatibility to this format,
of course, but it would be better to access these registers through a
syscon.  Putting all the registers together is more organized and shows
how the hardware actually is implemented.

Secondly, in some versions of this chipset those registers can only be
accessed via SCMI.  It's relatively straight forward to handle this
by writing a syscon driver and registering it with of_syscon_register_regmap()
but it's complicated to deal with if the registers aren't grouped
together.

Changed since v2:
* Improve the documentation in .../bindings/net/nxp,s32-dwmac.yaml
* "[PATCH v2 2/4] dt-bindings: mfd: syscon: Document the GPR syscon
  for the NXP S32 SoCs" was applied so drop it.

Changed since v1:
* Add imx@lists.linux.dev to the CC list.
* Fix forward porting bug.  s/PHY_INTF_SEL_RGMII/S32_PHY_INTF_SEL_RGMII/
* Use the correct SoC names nxp,s32g2-gpr and nxp,s32g3-gpr instead of
  nxp,s32g-gpr which is the SoC family.
* Fix the phandle name by adding the vendor prefix
* Fix the documentation for the phandle
* Remove #address-cells and #size-cells from the syscon block

Here is the whole list of registers in the GPR region

Starting from 0x4007C000

0  Software-Triggered Faults (SW_NCF)
4  GMAC Control (GMAC_0_CTRL_STS)
28 CMU Status 1 (CMU_STATUS_REG1)
2C CMUs Status 2 (CMU_STATUS_REG2)
30 FCCU EOUT Override Clear (FCCU_EOUT_OVERRIDE_CLEAR_REG)
38 SRC POR Control (SRC_POR_CTRL_REG)
54 GPR21 (GPR21)
5C GPR23 (GPR23)
60 GPR24 Register (GPR24)
CC Debug Control (DEBUG_CONTROL)
F0 Timestamp Control (TIMESTAMP_CONTROL_REGISTER)
F4 FlexRay OS Tick Input Select (FLEXRAY_OS_TICK_INPUT_SELECT_REG)
FC GPR63 Register (GPR63)

Starting from 0x4007CA00

0  Coherency Enable for PFE Ports (PFE_COH_EN)
4  PFE EMAC Interface Mode (PFE_EMACX_INTF_SEL)
20 PFE EMACX Power Control (PFE_PWR_CTRL)
28 Error Injection on Cortex-M7 AHB and AXI Pipe (CM7_TCM_AHB_SLICE)
2C Error Injection AHBP Gasket Cortex-M7 (ERROR_INJECTION_AHBP_GASKET_CM7)
40 LLCE Subsystem Status (LLCE_STAT)
44 LLCE Power Control (LLCE_CTRL)
48 DDR Urgent Control (DDR_URGENT_CTRL)
4C FTM Global Load Control (FLXTIM_CTRL)
50 FTM LDOK Status (FLXTIM_STAT)
54 Top CMU Status (CMU_STAT)
58 Accelerator NoC No Pending Trans Status (NOC_NOPEND_TRANS)
90 SerDes RD/WD Toggle Control (PCIE_TOGGLE)
94 SerDes Toggle Done Status (PCIE_TOGGLEDONE_STAT)
E0 Generic Control 0 (GENCTRL0)
E4 Generic Control 1 (GENCTRL1)
F0 Generic Status 0 (GENSTAT0)
FC Cortex-M7 AXI Parity Error and AHBP Gasket Error Alarm (CM7_AXI_AHBP_GASKET_ERROR_ALARM)

Starting from 4007C800

4  GPR01 Register (GPR01)
30 GPR12 Register (GPR12)
58 GPR22 Register (GPR22)
70 GPR28 Register (GPR28)
74 GPR29 Register (GPR29)

Starting from 4007CB00

4 WKUP Pad Pullup/Pulldown Select (WKUP_PUS)

Dan Carpenter (3):
  net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
  dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
  dts: s32g: Add GPR syscon region

 .../bindings/net/nxp,s32-dwmac.yaml           | 12 ++++++++++
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |  6 +++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi      |  6 +++++
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 23 +++++++++++++++----
 4 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.51.0


