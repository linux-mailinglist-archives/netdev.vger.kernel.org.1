Return-Path: <netdev+bounces-274439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Kf0NP0yzmkpmAYAu9opvQ
	(envelope-from <netdev+bounces-274439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:12:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF9C386913
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69F7B30416E9
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 09:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14A31F9A4;
	Thu,  2 Apr 2026 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srqec2Sy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000433B97D
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120755; cv=none; b=bJ5qhpYKDmxRhabupzuD77bqIIdeOdvQAFpT1/50SLRUylnR9hyFRYqKjdj63MJVt8zEW91ZCx6gY7+bk/4eGQiuDORkVnbk5uEEo+YTE4aJv9eSfzHfvChcbIFsptChvxWMeNdbRojM6ogdYo3pC2aZvPRovrWFAVUhvHpo5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120755; c=relaxed/simple;
	bh=CjBV/owWI247yfG79jLRulbbRLdo2S4dP1YEjPDoUS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYvSEIAtVhLD+fonBp5YAiHUqSduTTe1j0xrzNA19nR0/Yuj55te/4QleV8eGS3C9dBszea9GYAi2vIfskr9Xxm8/AyGNscuqN+j055qWzntGW+xFriGdiKc4BPciRePwVPlNpUqI2LzlSgc5k6QhuJeRGnmQKYEsfVh/nQo4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Srqec2Sy; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c66eafc1easo1396543eec.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 02:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775120753; x=1775725553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPEZbM1C3GanUjAOvxNaSiryMHwICBkP7nMDWiLSo3g=;
        b=Srqec2Sy7qQxuMNmffBc8TdK9WqtOpZ3RE2fuidC7VtY7aHR40GFbvC5C1jveMisXx
         WDRV9qr4mWfbfCqkJDcMHRbqJXXddyCrSTwFtRU8TqGXLAyIlkLMWTRXBgT2cqLFvCTV
         hkUaTAYl+RUPjz9NLKbeIiOi86/AdVejpZa82s9l63SzYz44BDOVxNapkgDTZxQ4floT
         3mwuP+Ab/+lo69c0mws6ZE13rq4Qy/GU/f9RSHvEuWnxT/qp15w/RqzNlRFrqSZqa4Qa
         IdeOAlu/iVkmvwgOZyEEvpOWRrVh6aupH41NrUkDvX66iRU2INsKvjh78cqS/nmqy/kQ
         PkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120753; x=1775725553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPEZbM1C3GanUjAOvxNaSiryMHwICBkP7nMDWiLSo3g=;
        b=hMgUWX82/5gAHJd0Q8enUWRVXDTG1JCXynsbyH5om3GPrLQ6osgrh/RlnOm7ZtO7kB
         HsrQvA6yjIDgBz3qlSHZnf19vxWx0DGs7p2XXC1AshyyHPLe3GkPo8jMpUVYuWT8FbyX
         LLjU81yklTx83QO/5JcDCTyF5kEvjcn52pDcbeFNjFSUNl+iWjhA0KsnD8y/YFpE8WGi
         E8L2Tbn+/x8ow98FvlRrr+LuDYqI72FGMYuZCbsLIo3ogjeKJzI7s1F/ZTTCrtzR+dUF
         BF5XKWQEgLOTnlpFHeXw0T0D90rEm/+OvaF6EG/C4D9E9WJWNDb/lOgtrsDgwXt7bbTH
         2UhA==
X-Forwarded-Encrypted: i=1; AJvYcCXNtquE96Zzpyl/yN90Too2qGzWBgOSy7DuDlnccITH0uXemIZmwa6oGYjsQSURiUBa/KP61U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNa9JBSEMp9V61Hybv56zZ5S/88DFlYUdN+gdbFojPXi1hqop
	ISptlAsOLliPMh2NIx8Iag338mtraH9kB9n4ehC3w4liLIpngl8GMVKh
X-Gm-Gg: ATEYQzwKi+CgjCPXlqjCX5nm5daqYoiGh/yPPhbMwCEkHPltXxT/+1PNCRnqtJjQ/r0
	CW9RqNCQc2zyO0XuaRrG4p6TUkuoigjG1uuqbhR51g6PmYLrzvPGkNZf+iJlfSIlvbyWlmAIYtn
	5am9KH+pG6pbzUTyL6cVYvELvEqw1dV/2N/jEjM3kYkuXNqOpxFevuzJP3y/CdpfD2VLLC+/aIl
	s4J9fv9mAw9jMHZnL9V6U3/E6J/yPkwDvhoBfjfKO2lbyQepEsbds6TZIrxoGSf7B4gZIOv3XMN
	dq0yoXJRyNQHe1LrFzmtWfip8sLQE5H7ndtMWdtdMvKlVhcTLUjwkaA0iFSK+2VxEw061rhc7Uu
	oMaQSGMAofIT44Mb93SmJmIn/OtXJfLjSWZYz3bIUUG08iQybP/j8ffnyesSZobepdSIH0Q/cUj
	tRkJ+yWDebSAwFCdOlNPaX/THvyCvTpIdnalHo5xdhKOf77oJTkBe6L+jmN0Th
X-Received: by 2002:a05:7301:4188:b0:2c5:347:e642 with SMTP id 5a478bee46e88-2c932eae777mr3960179eec.33.1775120752674;
        Thu, 02 Apr 2026 02:05:52 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21cf::147f? ([2620:10d:c090:400::5:9571])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7d3111d1sm1921109eec.30.2026.04.02.02.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:05:52 -0700 (PDT)
Message-ID: <8ab93859-b904-4aa7-9ce4-a2b13d34c44a@gmail.com>
Date: Thu, 2 Apr 2026 02:05:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 net-next 07/11] net/nebula-matrix: add intr resource
 implementation
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, jani.nikula@intel.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260401022318.28550-1-illusion.wang@nebula-matrix.com>
 <20260401022318.28550-8-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260401022318.28550-8-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org,intel.com];
	TAGGED_FROM(0.00)[bounces-274439-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2EF9C386913
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/26 7:23 PM, illusion.wang wrote:
> MSI-X Interrupt Configuration:
> Dynamically allocate and manage MSI-X interrupt vectors, including
> network interrupts and other types of interrupts.
> Interrupt Mapping Table Management: Maintain the MSI-X mapping table
> (msix_map_table) to establish interrupt associations between hardware
> and software.
> Interrupt Enabling/Disabling:
> Support enabling or disabling specific interrupts through hardware
> operations.
> Interrupt Information Query: Provide interfaces to obtain the
> hardware register addresses and data of interrupts.
> 
> Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
> ---
>   .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
>   .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  71 +++++
>   .../nbl_hw_leonis/nbl_resource_leonis.c       |  13 +
>   .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  | 243 ++++++++++++++++++
>   .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |  12 +
>   .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  33 +++
>   .../nbl/nbl_include/nbl_include.h             |   2 +
>   7 files changed, 375 insertions(+)
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
> 
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> index b03c20f9988e..a56e722a5ac7 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> @@ -9,6 +9,7 @@ nbl-objs +=       nbl_common/nbl_common.o \
>   				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
>   				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
>   				nbl_hw/nbl_resource.o \
> +				nbl_hw/nbl_interrupt.o \
>   				nbl_core/nbl_dispatch.o \
>   				nbl_core/nbl_dev.o \
>   				nbl_main.o
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 4ef0d5989a76..aa5e91c2b278 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -63,6 +63,73 @@ static void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, const u32 *data,
>   	spin_unlock(&hw_mgt->reg_lock);
>   }
>   
> +static void nbl_hw_enable_mailbox_irq(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				      bool enable_msix, u16 global_vec_id)
> +{
> +	struct nbl_mailbox_qinfo_map_table mb_qinfo_map = { 0 };
> +
> +	nbl_hw_rd_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
> +		       (u32 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
> +
> +	if (enable_msix) {
> +		mb_qinfo_map.msix_idx = global_vec_id;
> +		mb_qinfo_map.msix_idx_valid = 1;
> +	} else {
> +		mb_qinfo_map.msix_idx = 0;
> +		mb_qinfo_map.msix_idx_valid = 0;
> +	}
> +
> +	nbl_hw_wr_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
> +		       (u32 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
> +}
> +
> +static void nbl_hw_configure_msix_map(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				      bool valid, dma_addr_t dma_addr, u8 bus,
> +				      u8 devid, u8 function)
> +{
> +	struct nbl_function_msix_map function_msix_map = { 0 };
> +
> +	if (valid) {
> +		function_msix_map.msix_map_base_addr = dma_addr;
> +		/* use af's bdf, because dma memmory is alloc by af */
> +		function_msix_map.function = function;
> +		function_msix_map.devid = devid;
> +		function_msix_map.bus = bus;
> +		function_msix_map.valid = 1;
> +	}
> +
> +	nbl_hw_wr_regs(hw_mgt,
> +		       NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(func_id),
> +		       (u32 *)&function_msix_map, sizeof(function_msix_map));
> +}
> +
> +static void nbl_hw_configure_msix_info(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				       bool valid, u16 interrupt_id, u8 bus,
> +				       u8 devid, u8 function, bool msix_mask_en)
> +{
> +	struct nbl_pcompleter_host_msix_fid_table host_msix_fid_tbl = { 0 };
> +	struct nbl_host_msix_info msix_info = { 0 };
> +
> +	if (valid) {
> +		host_msix_fid_tbl.vld = 1;
> +		host_msix_fid_tbl.fid = func_id;
> +
> +		msix_info.intrl_pnum = 0;
> +		msix_info.intrl_rate = 0;
> +		msix_info.function = function;
> +		msix_info.devid = devid;
> +		msix_info.bus = bus;
> +		msix_info.valid = 1;
> +		if (msix_mask_en)
> +			msix_info.msix_mask_en = 1;
> +	}
> +
> +	nbl_hw_wr_regs(hw_mgt, NBL_PADPT_HOST_MSIX_INFO_REG_ARR(interrupt_id),
> +		       (u32 *)&msix_info, sizeof(msix_info));
> +	nbl_hw_wr_regs(hw_mgt, NBL_PCOMPLETER_HOST_MSIX_FID_TABLE(interrupt_id),
> +		       (u32 *)&host_msix_fid_tbl, sizeof(host_msix_fid_tbl));
> +}
> +
>   static void nbl_hw_update_mailbox_queue_tail_ptr(struct nbl_hw_mgt *hw_mgt,
>   						 u16 tail_ptr, u8 txrx)
>   {
> @@ -195,6 +262,9 @@ static u32 nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt)
>   }
>   
>   static struct nbl_hw_ops hw_ops = {
> +	.configure_msix_map = nbl_hw_configure_msix_map,
> +	.configure_msix_info = nbl_hw_configure_msix_info,
> +
>   	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
>   	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
>   	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
> @@ -204,6 +274,7 @@ static struct nbl_hw_ops hw_ops = {
>   	.get_real_bus = nbl_hw_get_real_bus,
>   
>   	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
> +	.enable_mailbox_irq = nbl_hw_enable_mailbox_irq,
>   
>   	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
>   	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> index 00569aa3459a..770a255ab06f 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> @@ -12,6 +12,7 @@ static struct nbl_resource_ops res_ops = {
>   	.get_eth_id = nbl_res_get_eth_id,
>   };
>   
> +static bool is_ops_inited;
>   static struct nbl_resource_mgt *
>   nbl_res_setup_res_mgt(struct nbl_common_info *common)
>   {
> @@ -37,11 +38,19 @@ static struct nbl_resource_ops_tbl *
>   nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
>   {
>   	struct nbl_resource_ops_tbl *res_ops_tbl;
> +	int ret;
>   
>   	res_ops_tbl = devm_kzalloc(dev, sizeof(*res_ops_tbl), GFP_KERNEL);
>   	if (!res_ops_tbl)
>   		return ERR_PTR(-ENOMEM);
>   
> +	if (!is_ops_inited) {
> +		ret = nbl_intr_setup_ops(&res_ops);
> +		if (ret)
> +			return ERR_PTR(-ENOMEM);
> +		is_ops_inited = true;
> +	}
> +
>   	res_ops_tbl->ops = &res_ops;
>   	res_ops_tbl->priv = res_mgt;
>   
> @@ -203,6 +212,10 @@ static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
>   		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
>   		if (ret)
>   			return ret;
> +
> +		ret = nbl_intr_mgt_start(res_mgt);
> +		if (ret)
> +			return ret;
>   	}
>   	return 0;
>   }
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 000000000000..aeea866be9c3
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include "nbl_interrupt.h"
> +
> +static int nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
> +					 u16 func_id)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	struct device *dev = res_mgt->common->dev;
> +	struct nbl_msix_map_table *msix_map_table;
> +	u16 *interrupts;
> +	u16 intr_num, i;
> +
> +	/* use ctrl dev bdf */
> +	hw_ops->configure_msix_map(res_mgt->hw_ops_tbl->priv, func_id, false, 0,
> +				   0, 0, 0);
> +
> +	intr_num = intr_mgt->func_intr_res[func_id].num_interrupts;
> +	interrupts = intr_mgt->func_intr_res[func_id].interrupts;
> +
> +	WARN_ON(!interrupts);

So we WARN_ON no interrupts and then proceed to iterate over 
interrupts[]? This will surely crash. WARN_ON is not providing any 
safety here.

> +	for (i = 0; i < intr_num; i++) {
> +		if (interrupts[i] >= NBL_MAX_OTHER_INTERRUPT)
> +			clear_bit(interrupts[i] - NBL_MAX_OTHER_INTERRUPT,
> +				  intr_mgt->interrupt_net_bitmap);
> +		else
> +			clear_bit(interrupts[i],
> +				  intr_mgt->interrupt_others_bitmap);
> +
> +		hw_ops->configure_msix_info(res_mgt->hw_ops_tbl->priv, func_id,
> +					    false, interrupts[i], 0, 0, 0,
> +					    false);
> +	}
> +
> +	kfree(interrupts);
> +	intr_mgt->func_intr_res[func_id].interrupts = NULL;
> +	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
> +
> +	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
> +	dma_free_coherent(dev, msix_map_table->size, msix_map_table->base_addr,
> +			  msix_map_table->dma);
> +	msix_map_table->size = 0;
> +	msix_map_table->base_addr = NULL;
> +	msix_map_table->dma = 0;
> +
> +	return 0;
> +}
> +
> +static int nbl_res_intr_configure_msix_map(struct nbl_resource_mgt *res_mgt,
> +					   u16 func_id, u16 num_net_msix,
> +					   u16 num_others_msix,
> +					   bool net_msix_mask_en)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	struct nbl_common_info *common = res_mgt->common;
> +	struct nbl_msix_map_table *msix_map_table;
> +	struct nbl_msix_map *msix_map_entries;
> +	struct device *dev = common->dev;
> +	u16 requested, intr_index;
> +	u8 bus, devid, function;
> +	bool msix_mask_en;
> +	u16 *interrupts;
> +	int ret = 0;
> +	u16 i;
> +
> +	requested = num_net_msix + num_others_msix;
> +	if (requested > NBL_MSIX_MAP_TABLE_MAX_ENTRIES)
> +		return -EINVAL;
> +	if (intr_mgt->func_intr_res[func_id].interrupts)
> +		nbl_res_intr_destroy_msix_map(res_mgt, func_id);
> +
> +	ret = nbl_res_func_id_to_bdf(res_mgt, func_id, &bus, &devid, &function);
> +	if (ret == U32_MAX)
> +		return -EINVAL;
> +
> +	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
> +	WARN_ON(msix_map_table->base_addr);
> +	msix_map_table->size =
> +		sizeof(struct nbl_msix_map) * NBL_MSIX_MAP_TABLE_MAX_ENTRIES;
> +	msix_map_table->base_addr = dma_alloc_coherent(dev,
> +						       msix_map_table->size,
> +						       &msix_map_table->dma,
> +						       GFP_KERNEL);
> +	if (!msix_map_table->base_addr) {
> +		pr_err("Allocate DMA memory for function msix map table failed\n");
> +		msix_map_table->size = 0;
> +		return -ENOMEM;
> +	}
> +
> +	interrupts = kcalloc(requested, sizeof(interrupts[0]), GFP_KERNEL);
> +	if (!interrupts) {
> +		ret = -ENOMEM;
> +		goto alloc_interrupts_err;
> +	}
> +
> +	intr_mgt->func_intr_res[func_id].interrupts = interrupts;
> +	intr_mgt->func_intr_res[func_id].num_interrupts = requested;
> +	intr_mgt->func_intr_res[func_id].num_net_interrupts = num_net_msix;
> +
> +	for (i = 0; i < num_net_msix; i++) {
> +		intr_index = find_first_zero_bit(intr_mgt->interrupt_net_bitmap,
> +						 NBL_MAX_NET_INTERRUPT);
> +		if (intr_index == NBL_MAX_NET_INTERRUPT) {
> +			pr_err("There is no available interrupt left\n");

Can we use dev_err instead of pr_err? Here and at other places as well?

> +			ret = -EAGAIN;
> +			goto get_interrupt_err;
> +		}
> +		interrupts[i] = intr_index + NBL_MAX_OTHER_INTERRUPT;
> +		set_bit(intr_index, intr_mgt->interrupt_net_bitmap);
> +	}
> +
> +	for (i = num_net_msix; i < requested; i++) {
> +		intr_index =
> +			find_first_zero_bit(intr_mgt->interrupt_others_bitmap,
> +					    NBL_MAX_OTHER_INTERRUPT);
> +		if (intr_index == NBL_MAX_OTHER_INTERRUPT) {
> +			pr_err("There is no available interrupt left\n");
> +			ret = -EAGAIN;
> +			goto get_interrupt_err;
> +		}
> +		interrupts[i] = intr_index;
> +		set_bit(intr_index, intr_mgt->interrupt_others_bitmap);
> +	}
> +
> +	msix_map_entries = msix_map_table->base_addr;
> +	for (i = 0; i < requested; i++) {
> +		msix_map_entries[i].global_msix_index = interrupts[i];
> +		msix_map_entries[i].valid = 1;
> +
> +		if (i < num_net_msix && net_msix_mask_en)
> +			msix_mask_en = 1;
> +		else
> +			msix_mask_en = 0;
> +		hw_ops->configure_msix_info(res_mgt->hw_ops_tbl->priv, func_id,
> +					    true, interrupts[i], bus, devid,
> +					    function, msix_mask_en);
> +	}
> +
> +	/* use ctrl dev bdf */
> +	hw_ops->configure_msix_map(res_mgt->hw_ops_tbl->priv, func_id, true,
> +				   msix_map_table->dma, common->hw_bus,
> +				   common->devid, common->function);
> +
> +	return 0;
> +
> +get_interrupt_err:
> +	while (i--) {
> +		intr_index = interrupts[i];
> +		if (intr_index >= NBL_MAX_OTHER_INTERRUPT)
> +			clear_bit(intr_index - NBL_MAX_OTHER_INTERRUPT,
> +				  intr_mgt->interrupt_net_bitmap);
> +		else
> +			clear_bit(intr_index,
> +				  intr_mgt->interrupt_others_bitmap);
> +	}
> +	kfree(interrupts);
> +	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
> +	intr_mgt->func_intr_res[func_id].interrupts = NULL;
> +
> +alloc_interrupts_err:
> +	dma_free_coherent(dev, msix_map_table->size, msix_map_table->base_addr,
> +			  msix_map_table->dma);
> +	msix_map_table->size = 0;
> +	msix_map_table->base_addr = NULL;
> +	msix_map_table->dma = 0;
> +
> +	return ret;
> +}
> +
> +static int nbl_res_intr_enable_mailbox_irq(struct nbl_resource_mgt *res_mgt,
> +					   u16 func_id, u16 vector_id,
> +					   bool enable_msix)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	u16 global_vec_id;
> +
> +	global_vec_id = intr_mgt->func_intr_res[func_id].interrupts[vector_id];
> +	hw_ops->enable_mailbox_irq(res_mgt->hw_ops_tbl->priv, func_id,
> +				   enable_msix, global_vec_id);
> +
> +	return 0;
> +}
> +
> +/* NBL_INTR_SET_OPS(ops_name, func)
> + *
> + * Use X Macros to reduce setup and remove codes.
> + */
> +#define NBL_INTR_OPS_TBL						\
> +do {									\
> +	NBL_INTR_SET_OPS(configure_msix_map,				\
> +			 nbl_res_intr_configure_msix_map);		\
> +	NBL_INTR_SET_OPS(destroy_msix_map,				\
> +			 nbl_res_intr_destroy_msix_map);		\
> +	NBL_INTR_SET_OPS(enable_mailbox_irq,				\
> +			 nbl_res_intr_enable_mailbox_irq);		\
> +} while (0)
> +
> +/* Structure starts here, adding an op should not modify anything below */
> +static struct nbl_interrupt_mgt *nbl_intr_setup_mgt(struct device *dev)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt;
> +
> +	intr_mgt = devm_kzalloc(dev, sizeof(*intr_mgt), GFP_KERNEL);
> +	if (!intr_mgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return intr_mgt;
> +}
> +
> +int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct device *dev = res_mgt->common->dev;
> +	struct nbl_interrupt_mgt *intr_mgt;
> +	int ret;
> +
> +	intr_mgt = nbl_intr_setup_mgt(dev);
> +	if (IS_ERR(intr_mgt)) {
> +		ret = PTR_ERR(intr_mgt);
> +		return ret;
> +	}
> +	res_mgt->intr_mgt = intr_mgt;
> +	return 0;
> +}
> +
> +int nbl_intr_setup_ops(struct nbl_resource_ops *res_ops)
> +{
> +#define NBL_INTR_SET_OPS(name, func)		\
> +	do {					\
> +		res_ops->NBL_NAME(name) = func; \
> +		;				\
> +	} while (0)
> +	NBL_INTR_OPS_TBL;
> +#undef NBL_INTR_SET_OPS
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
> new file mode 100644
> index 000000000000..b876bf30084b
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_INTERRUPT_H_
> +#define _NBL_INTERRUPT_H_
> +
> +#include "nbl_resource.h"
> +
> +#define NBL_MSIX_MAP_TABLE_MAX_ENTRIES	1024
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> index 51b5b958cde8..1b80676cf19a 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> @@ -18,6 +18,37 @@
>   
>   struct nbl_resource_mgt;
>   
> +/* --------- INTERRUPT ---------- */
> +#define NBL_MAX_OTHER_INTERRUPT			1024
> +#define NBL_MAX_NET_INTERRUPT			4096
> +
> +struct nbl_msix_map {
> +	u16 valid:1;
> +	u16 global_msix_index:13;
> +	u16 rsv:2;
> +};
> +
> +struct nbl_msix_map_table {
> +	struct nbl_msix_map *base_addr;
> +	dma_addr_t dma;
> +	size_t size;
> +};
> +
> +struct nbl_func_interrupt_resource_mng {
> +	u16 num_interrupts;
> +	u16 num_net_interrupts;
> +	u16 msix_base;
> +	u16 msix_max;
> +	u16 *interrupts;
> +	struct nbl_msix_map_table msix_map_table;
> +};
> +
> +struct nbl_interrupt_mgt {
> +	DECLARE_BITMAP(interrupt_net_bitmap, NBL_MAX_NET_INTERRUPT);
> +	DECLARE_BITMAP(interrupt_others_bitmap, NBL_MAX_OTHER_INTERRUPT);
> +	struct nbl_func_interrupt_resource_mng func_intr_res[NBL_MAX_FUNC];
> +};
> +
>   /* --------- INFO ---------- */
>   struct nbl_sriov_info {
>   	unsigned int bdf;
> @@ -77,6 +108,8 @@ int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
>   			   u8 *bus, u8 *dev, u8 *function);
>   void nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id,
>   			u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id);
> +int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt);
> +int nbl_intr_setup_ops(struct nbl_resource_ops *resource_ops);
>   void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
>   					    enum nbl_vsi_serv_type *dst_type);
>   #endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> index 6a0bf5e8ca32..e4f11e6ded94 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> @@ -19,6 +19,8 @@
>   
>   #define NBL_MAX_FUNC					520
>   #define NBL_MAX_ETHERNET				4
> +/* Used for macros to pass checkpatch */
> +#define NBL_NAME(x)					x
>   
>   enum nbl_product_type {
>   	NBL_LEONIS_TYPE,


