Return-Path: <netdev+bounces-256250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI6UFEragWlBLQMAu9opvQ
	(envelope-from <netdev+bounces-256250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:21:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC974D833D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C41630B909F
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F7334685;
	Tue,  3 Feb 2026 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPK7J5bo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kd7HBfSD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10732FA34
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117545; cv=none; b=dvf4k9K4WUL9AXYwcUOWlYU7n4mpmTZtpN6F5gIoZRWIQLZu0wj7X8iewu6TRC7rKuO5ZTyCpQEE9Y2OxXrRSMNkaIw0UIdysqwplebAGXQPaGg6AKaOPfGuSSnHfLTRbLFpZMwFzvIs95Omfkwa56OhYQu6tB4v8k+YHEPh6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117545; c=relaxed/simple;
	bh=O8KJekQh9FS/0oopKwm+g0QsiWOT6WSJ2NbPIfVUrDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tD03DmIFFxEf3bA+CAPigOnI7QR/eFkK//1fh5UNtp6X2WwtsCyBSuBzoabvsHOS21Kwt7VGyXv+9jojjW+YaIvtwVltHBIpmA85bErnKS/gPGAlBw1ZdYrtBrKA82F7tukZLsZkoS7yYB1MvweTAVmwxEhanwoIQVbhr7Ue4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPK7J5bo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kd7HBfSD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770117543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WnKseKgzuDEwEZ2TxAar2LzO8o7OZlfDBwq/L+OXzI=;
	b=SPK7J5boZRP8L6xLuwUZBZHzncrT0hBtqcErHjGeqw/ZpYpmsfsNcLrPBuN7jBiSgAVsky
	UAEhQk6aN1aC0ymO284r0EUwV6HgiI4qxSqB4yL9MenJfvLXtqkphWu24H/iQSe3U7ypHo
	MZGFLZoTIrWEpmU7HR231djFaNDlbH4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-tmg_p-4uNheyliZdoDmkgg-1; Tue, 03 Feb 2026 06:19:02 -0500
X-MC-Unique: tmg_p-4uNheyliZdoDmkgg-1
X-Mimecast-MFC-AGG-ID: tmg_p-4uNheyliZdoDmkgg_1770117541
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso4422668f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 03:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770117541; x=1770722341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2WnKseKgzuDEwEZ2TxAar2LzO8o7OZlfDBwq/L+OXzI=;
        b=Kd7HBfSDF9A7FiWvpuJvfmP/kmMrWPMqqlJOefOvEMGfofNSSMjb9eTX4lKyaH8BLV
         3HTjvcSS7oBAJW1VE8Jfht2+qepsk8UC/KKvLj1uFXsReQ4NWR1T4DcjCgHx9sRrqwej
         Xbag6X8VNnvVplYDan6JFL5Oa/fWv7muMhdHZBngPKW6SmlOeNvzKOwl+osfSyoadt+F
         BlBrWfjxeqwUTZGslAj5Tf6+eZ3aD7H2Ag5lt3sumeeTr+qltTgyV1npBvmfOTEO4Uzh
         N/vbLQ/pqSZoWqYrXoSnmBJT+z9Ve1K4FzQrRZqy9Ae969jvhFpFBM9fYNJUfogm0ayD
         3dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770117541; x=1770722341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WnKseKgzuDEwEZ2TxAar2LzO8o7OZlfDBwq/L+OXzI=;
        b=hMX1KV9Gv+cKBrlqdCZILo0x3DtKeN5QzUfBuSI+bJkS4svecgj+4wDioe13zjkNEu
         oekQx3D/9sKOJTQBx0yG3oT0LX+XQQGGh6VzQHLLbcT101/v8hZjuAP/jWySurluP/L4
         gGAERcRdIB+znTtLYmWtFZh+3v6jcrYa+hGRz1Oboc0GZNdHqGQ6OoNr72288k9Ge6rN
         ieDByMdXpqCdN7znQSVptvqiCJDHrdHSUAdoWf00DXXULp3ExbIX4nw9mAV0FOe/mWNz
         pfPryueKrx317LRZARJLOJlvnExjc3zTTanY8ZO1D5kp6ZtdDKnBnxWnXqmqX/21ndUi
         CSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSSWG05fz/GJOuURI5ZLY7pNmvtJm0378jsRBK1S0Aksy8wCVskIwSJeectFD4bgY4Ma8Hd2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5A0ZfOjRE5wr2vViAtTIqv4al3b5JgA7QmxEhrM1MHCrRjiV
	TomXznzWxGJcwbfEsXbxcX0FgIwpSiHTJ2XDgS8nq5/ihaGapWG66cO7i9H7Yj+/Kow20ouHRNK
	zUGD1tw20ZCp149MloWRqZlrbCm0QEG9zxy8aEPxRccGqgDkrCUMv7VZ3oA==
X-Gm-Gg: AZuq6aIcuqDZVi8RtmKr/3BpqZlauCaCvOfuT1S1QDVdTmoPs3BFm29z9RBdDFuWF3H
	j2Xrm3fW9wyoDPUgioMNfxHaGdAtkjAbwFZBx9lcvwSOwyvCY9GpqtHJw/udq90QpiP5dHqRy0U
	rU+ui2weM3NNdLTdu98Uyaj5S3m3cWzI/YB+CSub2MBcFiQqq58jHLqJ9YfF6X2qSfjV8vCWvnQ
	cn1vsXh54GbUmWi5MFxbn/FRvkdNGSZkQiuAEc6teOsgyjxcJRw5Gez5GwxgQ6LvgaikREoDdMD
	Vga+0fvLRD3vyqEyY8aZxJ3Ta4D7nB4KWLvbm4beUJmrmR7kj6OIc2hjkO4PONqZi5eY/rUhOqt
	lLpN3kTHcRWs=
X-Received: by 2002:a05:600c:a087:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-482db48f2ccmr209555325e9.30.1770117541299;
        Tue, 03 Feb 2026 03:19:01 -0800 (PST)
X-Received: by 2002:a05:600c:a087:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-482db48f2ccmr209554895e9.30.1770117540850;
        Tue, 03 Feb 2026 03:19:00 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbc7f580sm149384895e9.2.2026.02.03.03.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 03:19:00 -0800 (PST)
Message-ID: <bdb7cd69-7dcd-4e8a-b04a-14a2eb902311@redhat.com>
Date: Tue, 3 Feb 2026 12:18:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] s32g: Use a syscon for GPR
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Chester Lin <chester62515@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, imx@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, Jan Petrous <jan.petrous@oss.nxp.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Matthias Brugger <mbrugger@suse.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 NXP S32 Linux Team <s32@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linaro-s32@linaro.org
References: <cover.1769764941.git.dan.carpenter@linaro.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cover.1769764941.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256250-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,gmail.com,nxp.com,oss.nxp.com,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com,suse.com,pengutronix.de,linaro.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: BC974D833D
X-Rspamd-Action: no action

On 1/30/26 2:19 PM, Dan Carpenter wrote:
> The s32g devices have a GPR register region which holds a number of
> miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
> anything from there and we just add a line to the device tree to
> access that GMAC_0_CTRL_STS register:
> 
>                         reg = <0x4033c000 0x2000>, /* gmac IP */
>                               <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> 
> I have included the whole list of registers below.
> 
> We still have to maintain backwards compatibility to this format,
> of course, but it would be better to access these registers through a
> syscon.  Putting all the registers together is more organized and shows
> how the hardware actually is implemented.
> 
> Secondly, in some versions of this chipset those registers can only be
> accessed via SCMI.  It's relatively straight forward to handle this
> by writing a syscon driver and registering it with of_syscon_register_regmap()
> but it's complicated to deal with if the registers aren't grouped
> together.
> 
> Changes since v5:
> * Fix O vs 0 typo in yaml file
> * Add Jan Petrous's Reviewed-by tag
> 
> Changes since v4:
> * Return an error if regmap_write() fails
> * Add Rob's Reviewed-by tag to the yaml patch
> 
> Changes since v3:
> * Fix the yaml file format
> * Add netdev to the CC list on all emails so the CI triggers
> 
> Changes since v2:
> * Improve the documentation in .../bindings/net/nxp,s32-dwmac.yaml
> * "[PATCH v2 2/4] dt-bindings: mfd: syscon: Document the GPR syscon
>   for the NXP S32 SoCs" was applied so drop it.
> 
> Changes since v1:
> * Add imx@lists.linux.dev to the CC list.
> * Fix forward porting bug.  s/PHY_INTF_SEL_RGMII/S32_PHY_INTF_SEL_RGMII/
> * Use the correct SoC names nxp,s32g2-gpr and nxp,s32g3-gpr instead of
>   nxp,s32g-gpr which is the SoC family.
> * Fix the phandle name by adding the vendor prefix
> * Fix the documentation for the phandle
> * Remove #address-cells and #size-cells from the syscon block
> 
> Here is the whole list of registers in the GPR region
> 
> Starting from 0x4007C000
> 
> 0  Software-Triggered Faults (SW_NCF)
> 4  GMAC Control (GMAC_0_CTRL_STS)
> 28 CMU Status 1 (CMU_STATUS_REG1)
> 2C CMUs Status 2 (CMU_STATUS_REG2)
> 30 FCCU EOUT Override Clear (FCCU_EOUT_OVERRIDE_CLEAR_REG)
> 38 SRC POR Control (SRC_POR_CTRL_REG)
> 54 GPR21 (GPR21)
> 5C GPR23 (GPR23)
> 60 GPR24 Register (GPR24)
> CC Debug Control (DEBUG_CONTROL)
> F0 Timestamp Control (TIMESTAMP_CONTROL_REGISTER)
> F4 FlexRay OS Tick Input Select (FLEXRAY_OS_TICK_INPUT_SELECT_REG)
> FC GPR63 Register (GPR63)
> 
> Starting from 0x4007CA00
> 
> 0  Coherency Enable for PFE Ports (PFE_COH_EN)
> 4  PFE EMAC Interface Mode (PFE_EMACX_INTF_SEL)
> 20 PFE EMACX Power Control (PFE_PWR_CTRL)
> 28 Error Injection on Cortex-M7 AHB and AXI Pipe (CM7_TCM_AHB_SLICE)
> 2C Error Injection AHBP Gasket Cortex-M7 (ERROR_INJECTION_AHBP_GASKET_CM7)
> 40 LLCE Subsystem Status (LLCE_STAT)
> 44 LLCE Power Control (LLCE_CTRL)
> 48 DDR Urgent Control (DDR_URGENT_CTRL)
> 4C FTM Global Load Control (FLXTIM_CTRL)
> 50 FTM LDOK Status (FLXTIM_STAT)
> 54 Top CMU Status (CMU_STAT)
> 58 Accelerator NoC No Pending Trans Status (NOC_NOPEND_TRANS)
> 90 SerDes RD/WD Toggle Control (PCIE_TOGGLE)
> 94 SerDes Toggle Done Status (PCIE_TOGGLEDONE_STAT)
> E0 Generic Control 0 (GENCTRL0)
> E4 Generic Control 1 (GENCTRL1)
> F0 Generic Status 0 (GENSTAT0)
> FC Cortex-M7 AXI Parity Error and AHBP Gasket Error Alarm (CM7_AXI_AHBP_GASKET_ERROR_ALARM)
> 
> Starting from 4007C800
> 
> 4  GPR01 Register (GPR01)
> 30 GPR12 Register (GPR12)
> 58 GPR22 Register (GPR22)
> 70 GPR28 Register (GPR28)
> 74 GPR29 Register (GPR29)
> 
> Starting from 4007CB00
> 
> 4 WKUP Pad Pullup/Pulldown Select (WKUP_PUS)
> 
> Dan Carpenter (3):
>   net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
>   dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
>   dts: s32g: Add GPR syscon region

It looks like patch 3/3 depends on 1/3 but it should land in a different
tree, as patches 1 && 2 looks suitable for 'net-next' and 3/3 should
probably go via the arm/freescale tree.

We either need explicit ack from freescale maintainers or this should be
split across subtrees, right?

Thanks,

Paolo


