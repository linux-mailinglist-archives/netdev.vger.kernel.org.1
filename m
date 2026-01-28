Return-Path: <netdev+bounces-254177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI27LNHceWnI0QEAu9opvQ
	(envelope-from <netdev+bounces-254177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:54:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C739F0A3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1B6B3008222
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85DB34D4E4;
	Wed, 28 Jan 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFVrayuy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFF34B40A
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594042; cv=none; b=ds2dULMMYDA7ojoQ3frrxOCfBqwEaHHKeCPVyzgdsxw2TQafEqFQfk4Ob5lHJzGHMISTEt6Naftk54RSWMJPbdHBDFSVFZpaTvitPrezQznGn6K+qk0czPgDxDnKkRE1xlzH+iJXTGtT2nw8as6soTZTcpR+AwVSnhdjWvq7FgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594042; c=relaxed/simple;
	bh=F4IKa6rLYVWEFkv/IgXWcLrQfKoUBWLsvQ8TAjo1Q+4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B6RGBo1OUhHZ/ptr1P3+xzp6tSG3lrC6dpH+D/xREzVxOz5se/aPs+7rpXQu6m0BfvTdPYAc73CuKxdMtTzF5CHsG52WkyT0qgQ5toluUjDHwz2kjkw31cAEEExg7f691fhpPijAdbtY7rkbKCHx5sqxJUaKQfMLP91rMru8dEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uFVrayuy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so55185355e9.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 01:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769594039; x=1770198839; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bvsllvRxaSRJovqhkHtFHrVWBKQNv1To0hacwlFk6IM=;
        b=uFVrayuyFmoazzuD7O2pbOx7KTxSkXGuj53yTExaGtXqEWdX2ko2tGFAHZXoFnOShE
         GNTa5IdRS9UUc6LkUzBeumTBjE9/ulM7tos4HE37jG/zTQyjmfQeyQhDtphX0G9Y6AX/
         aE5O5xhyFi+1NxZnL3pIexzKE81nDJR+sI+NycpEofDAd3D1VNJa4eXeVakgtYoJti1P
         zy6CjDh9l4rrgfPv6EhNH/3AW0zuX119LzSD4iVlOeQ4Im9o3qh+pBKH2vX+7rhSeFoS
         CVTIRtkL6myvhLCV/XXH7WDPrdM6t9BqgflLSIlILNC0eFGe3zCPhBL4IhnbRwWVC44W
         PY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594039; x=1770198839;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvsllvRxaSRJovqhkHtFHrVWBKQNv1To0hacwlFk6IM=;
        b=BCXWMrDiGrzkWCBigZw8tb7EWoy/rIc+gg7gqcVflmO6GH3d+WdQzZCOkmKsNDJVUa
         POFkeamSH3kksLA70GxasMR/qewHBDfsc2GFYDX+sIF4SV4LEWpmo6mQ1GjRu7GPfE3N
         0AilQRObVq8bNPv0P4Rg2WM1gpbserKMnRP4xbmIjOnXB0dWYO1Tarox10J/i3hS0pUK
         w5c2nf+e+GZxYWxC/Ph1ngukmdQ1ZnSYRilDxz7rOeVSGCX4TDSwNRokQ1oyKuT8RxCR
         S5mlctmbd0nSMxmRfTq8j6AosIMUD5nadvxswCscgPhcZxBjYeK8PYBarNTufYoSd+P1
         0Dbg==
X-Forwarded-Encrypted: i=1; AJvYcCXz6ljWL/84iQNG4vx2a4+2tXF8XZREviSFgROEA8GFexFJdd5tUgP8MXJAZ761t9DmMmxY/Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YznDob7vpxX1JLbsS/gkqukG9N5cnTJyd8IIOSv0Do7jU6S+cCZ
	Gf6V0G61L+XvW6KA3HdJUHW9gn8TYIGHT1EaJ1e0LKfYk/tOnedM0Zf9p4UDop0Wlss=
X-Gm-Gg: AZuq6aJzgLnzJyKCDSNkAGd0dut9zAhUk7Pgo+7j6P4mKKbT8316IiSI8tBhkWyWjnx
	lu/keZSuf/kIlPq5Ly1gaa36Of3uBTKnSiCbimh7yP/2xsJLyFcktkW2uUziPaRnlpa8ovdxnvJ
	Fwca4Z3nhygiJDeZVdUYLPT5+EzfLg5C2QbhVURBYirO9bRxgQmS1fodUIJS736BlfJn6FPpFAb
	LvK+PGpUtcVL/LZSffEyH3E07RXIP8MGyztZjx3hu3jRtLOdtUMWELt/HIEf1JkeZhLdAgJ00Td
	Pmg6g/zGE2B7jS9F2EuY8ebNTKOTO26eJ6JmpSz5dFHXvwB58I4LIR/XAFMdo5oQJF3J6q2omAn
	5GvrbAjnMrFrpZgeeIuR9NvWO3WEkWOjvznl9idGGxNbsPME4i1Q1S6YwQBG+aC+qllqzPUB5ko
	01MPM0Yled725oyVEq
X-Received: by 2002:a05:600c:83c4:b0:47e:e946:3a57 with SMTP id 5b1f17b1804b1-48069ca552amr51714835e9.36.1769594039364;
        Wed, 28 Jan 2026 01:53:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354205sm5836437f8f.41.2026.01.28.01.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:53:58 -0800 (PST)
Date: Wed, 28 Jan 2026 12:53:55 +0300
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
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v5 0/3] s32g: Use a syscon for GPR
Message-ID: <cover.1769592679.git.dan.carpenter@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,gmail.com,oss.nxp.com,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com,suse.com,nxp.com,redhat.com,pengutronix.de];
	TAGGED_FROM(0.00)[bounces-254177-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 15C739F0A3
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

Changes since v4:
* Return an error if regmap_write() fails
* Add Rob's Reviewed-by tag to the yaml patch.

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

 .../bindings/net/nxp,s32-dwmac.yaml           | 13 +++++++++
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |  6 ++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi      |  6 ++++
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 28 +++++++++++++++----
 4 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.51.0


