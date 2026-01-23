Return-Path: <netdev+bounces-252955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB/SHjPRc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:51:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516B7A50B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24AD23011A7A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009BF2C11DD;
	Fri, 23 Jan 2026 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vO3kAepe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333EE2C0F78
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197871; cv=none; b=Bem2seL/giDiugp4RRSggzcVrcrR8CL/mnM0GPZzoDorNe9SJo+7NqwB6Jqn9sWWe6PUxgiLNCbH1KtN2mn6fn0uGiDuV3tE5eQaomLdo7E8FxXE0tw0XKNgGlNHBFvO5LemUWaM5Kw/0Q1eKCF8zgo16OiLhlqXh4xrw4exjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197871; c=relaxed/simple;
	bh=kx6N8Fat+v4rKXAq3jr9szVFIZj8vDQESPGqHR9vba4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RQ0ZZIY1+O9pr9z9v8bEsCjZfmAxVrwVaUuZqePdWMTw8DUBdr8WqXF67HiZqhrcf4sSTougyd0ZUZ76sKfc8nqAzGvYoKcWNgr1CcbLxMKVuRFCvSDofGCPKhF69UslKh04AcrFiMGDkY9wdX3f4KFBoeVh/ek1Us9ScagnqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vO3kAepe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso29410675e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769197868; x=1769802668; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jNsJjXS8M5t/mEUZRdZlxrFzfCZpFMkBqFJLBshMIk=;
        b=vO3kAepe+aFIJKsU8yTO/kodsox4ao6cA3nXcJksSe9lni0T/QJXRBAUK/a6Fyqyqg
         ek9chWU2/CKKNc4/pZtSWQzl0wwxqwD6KXqCGpeyYdJs6Dfolq5U4SnmOORRWmRYKKI4
         aysqphxgC8fHk5m39nwZ9SnWPuKj5dAEBUCUh4Q0VUr7GMajixL8Nt+y9lVlV1d4JAHI
         YfTzd/0llFEhNtji7cMS5JuolFnseBvPaXHMrc3Qhi68IzZrTWtMRT1L0ZrToh+XokPJ
         dxwKq32isEIPAQrg+CN1WXqURVQSIXToLaIC9JB8SBi6kjERsnv5ci9ALNBKH2En3PW1
         UKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769197868; x=1769802668;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jNsJjXS8M5t/mEUZRdZlxrFzfCZpFMkBqFJLBshMIk=;
        b=hUZjHYQcM30wgiVxjbag1Cw2LUwN7r6gDeo5lo4k1HnUF+GRNNl7VIvkNhYGyeOmTO
         Sm7fIZqpxkywkkdFbRea8zs8Fl2C2BI42lRQ4LsRmqk7AzEHOnGlQVCaL9hlxH7sEiwY
         SRmiCmrv4TY8AxOZ0t1QaLqLtJl7qX0e/r+J09nIDWRQrNfRFFw+6lGq9/ezgk+T7Ucy
         /HKo96a1a+/CHCWAXrC0DdcenNDKlrbqURxs6lUkWi31+aSPGseKCBh1jiXNFS1rZ3lk
         1+VUXIC+/H2PZOM5Lh9OH+aKbw1ocI4BEHld2Y7kOpMvb6ygqTVhpzuI5D92TfLu/Fuz
         MRqA==
X-Forwarded-Encrypted: i=1; AJvYcCU7wuKLlDzUwvUcOt1cMTqGrhhZ5rKCZe1Reu8BZNuqcz2+VYRXugjrRDFUR6J6rhseJsdMY0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRv+A+BdsyVzuDMFtvYUdfmFA9FtjQwzWXgMRG3AUe6w76bc3h
	dvRo/qK0ul09/L3LYcbetgpgPqHtlDr141xEXx+l5O1+9KC3wl6HPCgT/J9MH7llFGU=
X-Gm-Gg: AZuq6aKtNf7HuJmd1EMr1/VZRLFG5ZjTjwgvV3Gk0Ywp/VF5TyA8on/G3PTLUKJ4SU7
	Cda6PmK4W9tyPsvIU1fcLF5cA6EoW0I1jXqF8oF5vkZOSU2YvHkLzvz7uEPFLeReLw2HzkLct68
	24wKsSlc5PLbW2Aw3OeAcx1HSu+VhNpWXQ+I58bCUyYLHxYGs3eiYpxvpeO+p/9Lhx+KZDlnMaG
	X8KPNw13ncR1UpS8QmzCVD5IWnSGf7LxO/hIOGoYxnac+uaVOYipKdJsLjiU5j/UVMfhSJThqkS
	Edpiy6sC+lZ5dw/cSnh1lFBnmYHkAI921tZ9jRnnoMCGujwkcQzxqj0yZ4I7kSmd/JqmcJ0Q6Rg
	6cws9S8Jg4hquNxN9eiF7v98h+JJLa+MWd8WEjb6GgGn/y4HDNikz79Sbajjs/HU+px85PVuJDa
	2hoEs+pqLmbr9lkjPI
X-Received: by 2002:a05:600c:5494:b0:480:1e9e:f9d with SMTP id 5b1f17b1804b1-4804c94810fmr65373435e9.8.1769197868314;
        Fri, 23 Jan 2026 11:51:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d8a5c32sm94300895e9.11.2026.01.23.11.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:51:07 -0800 (PST)
Date: Fri, 23 Jan 2026 22:51:04 +0300
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
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.li@nxp.com>,
	linaro-s32@linaro.org
Subject: [PATCH v4 0/3] s32g: Use a syscon for GPR
Message-ID: <cover.1769195864.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,gmail.com,oss.nxp.com,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com,suse.com,nxp.com,redhat.com,pengutronix.de,linaro.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252955-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1516B7A50B
X-Rspamd-Action: no action

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

Changes since v3:
* Fix the yaml file format
* Add netdev to the CC list on all emails so the CI triggers

Changes since v2:
* Improve the documentation in .../bindings/net/nxp,s32-dwmac.yaml
* "[PATCH v2 2/4] dt-bindings: mfd: syscon: Document the GPR syscon
  for the NXP S32 SoCs" was applied so drop it.

Changes since v1:
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
*** BLURB HERE ***

Dan Carpenter (3):
  net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
  dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
  dts: s32g: Add GPR syscon region

 .../bindings/net/nxp,s32-dwmac.yaml           | 13 +++++++++++
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |  6 +++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi      |  6 +++++
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 23 +++++++++++++++----
 4 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.51.0


