Return-Path: <netdev+bounces-244773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 880DECBE6AA
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2A6C3048428
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60C3074BA;
	Mon, 15 Dec 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdcBa5Xi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480192EB866
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809711; cv=none; b=rSpl88G+whFujvpzfQQ9PGyRWJek9WPHcamaTdiPIHVjHB/0P+RPaahSFZsEOwIIbuA5FOXq+OBUCj9xe/XsrTCHvbG5Brn2KOTAOrJR76129wsb8SI6wrkMe2NnVF5mAc8yJdVPY4rKZxmB4DpVkeFdzxQMYYLiwXTR2B8jE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809711; c=relaxed/simple;
	bh=3LEY9+gvgyLYDxiWssEFrDzVVT5UeklBK8qSgtG3XrE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P5KBjhe3auYu2TJoEl6KgVzA5MI35I91fnN50dAyW/IXie3hvLZZji7+15RACkaxo8PQEx4gFJ9NgV0r8x180AVP/KpS5JylFLSbqy6ELOS0dSOPcT5ASPCbGfM3nt/V+/F8SQa9TeF7+5n5K7oUoqd6Y0ww7FcV27GIZm86KG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sdcBa5Xi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so770170f8f.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 06:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765809707; x=1766414507; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOcUNs+T7w7UnOFVcqXvYSgg4w1o3SYRSucYGzT5NG4=;
        b=sdcBa5XifKKjLE0p7E1NnKGmrKk/vcL5XInWFU7rkVfqbNKVITQ4Tv0Zkng6g1LfQB
         /qbXa8PwKorbELwLDrG5hU1QKHqLuE7R2LQs4PsE7U1ijHaWOIWb6O4xiayl7sdUE1YT
         1xBDTZ7e42Y95tZmtHJFJYV7tt4rrfcPqKlBtZJRmFowiB/1rSBsHu5jz2Gp1+qW8aDf
         C6C1E3W6LkUBwJQ/e3ylGepODte8Jfu59isNbdcWW4xS8OFFtGo8OtqhIYVCiWBbMFTT
         9+eUBwSM0uzzO+PolScs36i5MKEv9n07xCkBhZfc/pitmpAgeAvl0Qdgx2Pf0GUVKnHk
         MDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765809707; x=1766414507;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOcUNs+T7w7UnOFVcqXvYSgg4w1o3SYRSucYGzT5NG4=;
        b=eLSvnMnuoODixiLSgI2qscVUd41N86JcAXOmJW/7FO89cW7jZTynyZPnWJu91CPl+O
         e9EwliBVdjiwNASyIrh2yr/U+pLiJp2L61POPyhpmAOY9AO+1EJ3gN2a94Atbfv693j6
         Zaze5lvpnDhiYqpx8UL3cmr04e60/JENBMPszL7Gh2K8IaR6gjny4djkV3tK3J+lIXZn
         qGiB13UPVZGaZjb56tkvGTpqMPJFJMzOiXu7KB5MKDg1tj9emcjj/WpO14N2717gPntM
         9LYIO9/x/Nlwi+NSxVzHaRpxYNJwR2iisCm6ADVmpP1ClJbT9Cy2hR7GuZMmG1t6DC+y
         2dqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy+nXpAkvRl3KaODJ74lV9lfslVCZEnfkQsDx0iMQvqn3wl5eaQkjzeoOiBXoCFPBOElM0G1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHgCZCx00pdk/fqBZjllZ9EQwuDOPYkIyQTppvzXdY5P+4qhK6
	WWkgzQvpFlOv3Dy4VZdioZa6O4LfP7JQ0UH+OBWmXSsQ2d4ZKZmjl8gfmSjd2nUZ8C0=
X-Gm-Gg: AY/fxX4fxXVoAQTOjXwZiZ+ErzPJfg+ueiwduXuc6nqyBvsoVfJmUDxn3sHneN6UILk
	lEFtpDLfagzRh89VTG9Lblis1LpmnGSdBkOdF7fU8uNFbf/GrIy96BS5uLiDdLGacUhOhNf1S6m
	WPtPtkGtimDtotMzu2AX0rHSPDPmZm002B7gowPh8vmYYhb9nWWch6F5Jf0cTJ3iF2mw3IxMmvW
	+qeKs0hx2HPQ30HVRUu91Fr25iWexjn9n1ObxEu9+2KzZqrz6LrGYTaMeimzYvypDDWE0A0M6o0
	RSHhfaRFOB9qfB7G+8Fnbb2+u/cAnFzSm8+FTPsc3DVav+XtjsjRQGa3WPsE+gKKcpcKjfitDKM
	X5FLBX+UMr8dY6qjSnnLhkrHwYAjgc2h6Ei13fFQoHdcst01Eckx0lgxSk4Eb/viW+XeOAqq6yY
	Ue2n6j6hvRWS2JHBpv
X-Google-Smtp-Source: AGHT+IH7tV1xCOROP2jvu0xV490eqBk9+v5Ntm6XR34UvABXmZ0b23HM/6I4IQoJkUDLysFdkLNqfw==
X-Received: by 2002:a5d:64c7:0:b0:431:327:5dc8 with SMTP id ffacd0b85a97d-43103275eb4mr709797f8f.46.1765809707367;
        Mon, 15 Dec 2025 06:41:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ff626b591sm17343328f8f.15.2025.12.15.06.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:41:46 -0800 (PST)
Date: Mon, 15 Dec 2025 17:41:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chester Lin <chester62515@gmail.com>
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
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: [PATCH v2 0/4] s32g: Use a syscon for GPR
Message-ID: <cover.1765806521.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The s32g devices have a GPR register region which holds a number of
miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
anything from there and we just add a line to the device tree to
access that GMAC_0_CTRL_STS register:

                        reg = <0x4033c000 0x2000>, /* gmac IP */
                              <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */

We still have to maintain backwards compatibility to this format,
of course, but it would be better to access these through a syscon.
First of all, putting all the registers together is more organized
and shows how the hardware actually is implemented.  Secondly, in
some versions of this chipset those registers can only be accessed
via SCMI, if the registers aren't grouped together each driver will
have to create a whole lot of if then statements to access it via
IOMEM or via SCMI, where if we use a syscon interface we can write
a driver to handle that quite transparently without modifying each
individual driver which reads or writes to one of these registers.
That code is out of tree for now, but eventually we'll want to
support this.

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

Dan Carpenter (4):
  net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
  dt-bindings: mfd: syscon: Document the GPR syscon for the NXP S32 SoCs
  dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
  dts: s32g: Add GPR syscon region

 .../devicetree/bindings/mfd/syscon.yaml       |  4 ++++
 .../bindings/net/nxp,s32-dwmac.yaml           | 10 ++++++++
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |  6 +++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi      |  6 +++++
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 23 +++++++++++++++----
 5 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.51.0


