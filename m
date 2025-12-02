Return-Path: <netdev+bounces-243289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 936EDC9C947
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 19:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58AEA4E3B27
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 18:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65732C11E3;
	Tue,  2 Dec 2025 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxkbmKEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FB21C9E5
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699431; cv=none; b=CaUxs8IHLAABctYV/Uc/A1guhNQW47ZijdAK9vvkj7BuDk08OJ4ZoXu6EKNDfYy9ji5kuYDIysWN2Fruo6A0nK+2G1dwCwRdAW0pof1AAManHv9yWKH62/HFgWVms5Rpb3p3IKPKGcpL5U4ZUMurI8j04/xQc3BF+TtVRbQlplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699431; c=relaxed/simple;
	bh=kIIxpDCzAiF+wx/yf+gGzLt+4Ot/8vUkQHd1YvCPew4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDsohyGVQNHH72It/6aqfqrDFGFh1fBfdkAoRMbT0fQwkM1VWhviKng5Yakrr3rwevu9Qm+nTNKDV2D8FE+zdPs2MLazdDMLQ0YKjJgWBxYtQEfhUVvJUt+omcnPMJQ2FlmdMjPKr6ttkMN3iKNOd2SxoG7t5KhRYzD1NkCcmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OxkbmKEO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2e671521so1886928f8f.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 10:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764699428; x=1765304228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6b74+PpIp4g7MMqPdYt95ZSBDMLgOHp379BS/AlUf30=;
        b=OxkbmKEOMdfd70iV7tGDNb9WXTKw1sTd8BB1DOId+NBwS9j/1vy1iAKdt79//w3ZP3
         yxERnDroP1lgnNwCj8PM39gkFhS8W1TIiJ7dDXVRLc7hDHbf6ERPFImXiDNuCL7V31fg
         3ANBYk/gduGOMi/B/Vu/wgWq7Sx5XCCNS+mT7s2FuCCSvojFwGciaNjx0dP7nmINCny2
         qesuMsrdpnyNGF6SdBUKwvoaJk6C1yuetzKv7NyQBHrc9DvjFs42DykJTjWhNHWqExFp
         C/KeVLN+Xr+LeLJMVaHfyVwbPDNk8p299gWM/EtSw+uDakgq8M0UtNW9jFexzqKtH34b
         9g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764699428; x=1765304228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6b74+PpIp4g7MMqPdYt95ZSBDMLgOHp379BS/AlUf30=;
        b=mVzLYcjX/glVPKnuUYDGJ89AJJeoQ9YwdkvsWlUBfeeOY44DRaAcRf7NyYp7VrUD8H
         tEobtxLmTYyvhetEEEgEMLNPggkYoKOtcYt85aY9YCzZw/OifvFD5ZDz4X4ITTdkazYO
         ONa83p/QF7OkqqJa6UfYv9EgvZUbPGZZwR3Y4I6CA4AV+wS1sGnTkH5ygl7LazMl+LjE
         IA+bAzuMUGQNtsh/KHkT4m2j3tANJbYXjcFDGqi9Us54OvUpiSgjBGoREoVoUhmgGRNF
         ZG7CzCLxR/yh7JDXT3sntGx8lMFEkACJ5Jtv0o5ZCfmS1UCfDuPCr5j4jur2aAaBOhow
         uOQw==
X-Forwarded-Encrypted: i=1; AJvYcCWlfF+hra3g02YWdfXGnvxYS+QpgBBbFqrLkayxCpl/++Lv9FPg3ELq4hOynLAJ0Z5f4rjnx9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzI63jlryCvtMUumuFaX8Q4bYR8HMHufFuwsyPHGQXZZHTmxUv
	HIl1WdbzYzXPu86UavX2KKLcR8jjjmiP9BZYZo718CYxDM8bYpOaFPYtRm6GxEl34p4=
X-Gm-Gg: ASbGnctn5RutiwCPI1Zy9plLlCu2d1HDwkgFMpKqVqoa+FKiFOD6RB5BsxbR9ARm7vr
	0Y/rgvmBZsa36Mwkknh44TVazZLRE9898L82gvjcqUpIiBu+lzdbsUMUTORcvffGNjJmB3VlCq4
	1UUcGfH1mRiUhM/MkGEcvKWsaXcKnMf7tQvBhKvckMlwY+SUec4zvlqEmIi4VeqN4JD5hKDMc4+
	GKfs0vOwmV03ixLAdiFG0Rh9WbG19mZ28twHrajTnIARhvOKNLUekmi++0R8fHMb8AA2FmKHfg0
	hl9KvlfTrlAoS8IGeWnLJHqfi+yayezt96cbp9QjA/rPyfH7tUherWrFs5/4Y5SQWhK2k+CrGT1
	83uZLmqA/QT+asl/PjFNWJVnOqrRNnCsBG6uUBcWiRaSgZ7W1jAEDAX8elx2wKUbXdKXIXPGEPy
	b4iDGT68SldqW9bXx/
X-Google-Smtp-Source: AGHT+IGdPY6yqrBKJkkOOYWF6CM+7Jwdu1H0nVTCpwkcVSguUh9pxxkKdepb4CrjpvgK1/jyWOMffg==
X-Received: by 2002:a5d:5f82:0:b0:42b:3220:9412 with SMTP id ffacd0b85a97d-42e0f3491e2mr34996565f8f.28.1764699428016;
        Tue, 02 Dec 2025 10:17:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1ca1a3f1sm34529299f8f.28.2025.12.02.10.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 10:17:07 -0800 (PST)
Date: Tue, 2 Dec 2025 21:17:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org
Subject: Re: [PATCH 1/4] net: stmmac: s32: use the syscon interface
 PHY_INTF_SEL_RGMII
Message-ID: <aS8tH3VD9uxl56ah@stanley.mountain>
References: <cover.1764592300.git.dan.carpenter@linaro.org>
 <6275e666a7ef78bd4c758d3f7f6fb6f30407393e.1764592300.git.dan.carpenter@linaro.org>
 <aS4W0M+ZkQzuUjtT@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS4W0M+ZkQzuUjtT@lizhi-Precision-Tower-5810>

On Mon, Dec 01, 2025 at 05:29:36PM -0500, Frank Li wrote:
> On Mon, Dec 01, 2025 at 04:08:20PM +0300, Dan Carpenter wrote:
> > On the s32 chipset the GMAC_0_CTRL_STS register is in GPR region.
> > Originally, accessing this register was done in a sort of ad-hoc way,
> > but we want to use the syscon interface to do it.
> 
> What's benefit by use syscon interface here? syscon have not much
> well consided funcitonal abstraction.
> 

The GPR has a bunch of random registers that aren't really related.
On these chips they're just regular MMIO registers, but in other
configurations you can only access them using SCMI.

It's better to group them together that's how they are in the hardware.
Otherwise we'd end up randomly adding a register address to the
ethernet device tree entry, but it's nicer to use a phandle to
reference the GPR.

The only register we're using now is the GMAC_0_CTRL_STS but here
is the list of registers in the GPR.

From 0x4007C000

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

Then from 0x4007CA00

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

From 4007C800

4  GPR01 Register (GPR01)
30 GPR12 Register (GPR12)
58 GPR22 Register (GPR22)
70 GPR28 Register (GPR28)
74 GPR29 Register (GPR29)

From 4007CB00

4 WKUP Pad Pullup/Pulldown Select (WKUP_PUS)

regards,
dan carpenter


