Return-Path: <netdev+bounces-282765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCnCC+sx82lPyQEAu9opvQ
	(envelope-from <netdev+bounces-282765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:41:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E224A0EEA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55DAF30028E8
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4160A3AEF27;
	Thu, 30 Apr 2026 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID6LGVDw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gejqwuin"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B439EF30
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545702; cv=none; b=UDeHW6d4juvUm3QRRJGGlBitndtkmoug0SzluYgAzrekPXy73NabKpN0Rzfbf/Rin7b0wiF6JrTceYzQZODlWpWl1UrZzNc4Y5t0DMZPx4uVXNplYbYCqhSsDsVeZFu/4I3NktIUpQmH6Z3ZRd8UvK5KmGV/gFOnVFB7hdO32bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545702; c=relaxed/simple;
	bh=M1UgE/v17PDBsac3FyL5NNSOdxOKVFaH1L/xRnpABDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rfr8U6YOXkmNb1uGG4XqVKoc848Vce5Uv0xWb0Mvr961LOvhiYq3cq3fKov96e/c3FO3NPeOe8Bg2f+qskP79VqESS0cHsQvpUmh8fkTpIyT+Swswh0ql+qbDcrf/cxIoU8bGqJMIYV74BFC9vVXnMeYPE7ffYZHO2FMBVUHZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ID6LGVDw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gejqwuin; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777545699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlB/HHoG0KdXRPcOptY6LFOlaz6EgO+V55I7swGUEwo=;
	b=ID6LGVDwWrwlySaoZQte0QSd0zP0oPP6I//4Fn19j6yyYvpPob9KX5E/ee0TL1nxvJ3mnT
	d7x8Fpn0u1/me13e/M32ZGblA9UdHOmV400d6wl4OkeAXlmGTEegZAP9HihoitjvG0ofKi
	xEu39gWkm6pdRb54zKF/Iza+2ScVv9c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-TNODFa1VPzuSDOBWDEqjTw-1; Thu, 30 Apr 2026 06:41:38 -0400
X-MC-Unique: TNODFa1VPzuSDOBWDEqjTw-1
X-Mimecast-MFC-AGG-ID: TNODFa1VPzuSDOBWDEqjTw_1777545697
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso8302615e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777545697; x=1778150497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlB/HHoG0KdXRPcOptY6LFOlaz6EgO+V55I7swGUEwo=;
        b=GejqwuinySrUI9QAlzaTbV2EgF2ohhhJE6NIU+FmEOq+3/bensirYnyXRcYwfkcbBc
         l1wdZffgxD2HO9P2JSHR406ptRVg71C+z8BFjENy1AcbC4XxGhTsnxAbZJuycJVCSl9y
         c6KMuwqIg2ODIh3ZuSvmhWNFif9hjqX/vwnz+TMjA0aSp4pJ+lniSQigT7qg3WqF+Gbw
         DoP7xHHn4SchX8OeHSG7lCmlDHGlFOmaQhAZQhNHzLj/zB2Zvwr3Vclc/6FmDHxlamMa
         fIz58KF+YuTj6Yt2ohafnRiv71zxHHcZE9ymcVxAm8dbV0H2Ykukq3cwrI1fUcjn8Ofv
         aBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777545697; x=1778150497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlB/HHoG0KdXRPcOptY6LFOlaz6EgO+V55I7swGUEwo=;
        b=p9aE88EBtBohq5sQxP/ucFAnq0mx9axMQpSu1r/SUN/6sCE1o/Y1geQivZxSKhfygF
         EmV71h2DCZsPkf4tpI5I+hFBbu3mXzAVrxZM5QNeoLjkwQ7h4K60rGOEhcGWMya4CqBt
         wCw/bwxq3vIL6CNOmzjN67C6XUHEgv6BG/zK8ELzrhj3/1AGDgUcgBTqL+mzDOK3tf0I
         kMh/SjGnLaDvV7UBYpT4IcQpSqr8PmASo71UhUhbk5Ru47eoyLV1hUCIqxhzROwLJnhR
         1yfGy1ffudjLyPwXDVMuRq4gIg+PMi09kFlv9KqpfqPIrJWErB7Bws7WkMue8Bl2+Cv8
         QFWw==
X-Forwarded-Encrypted: i=1; AFNElJ/aAA/g6UUQpTA0t/3IEHDm+Z0AvezjVIGACLCIBu1AExZ8hKKNPaHx0qCrejkUCodnD7dTCqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN544sPgl0KXyDao9/5s6e7OWc3MIJ6g7yL6QJyGd/wcuagF9A
	xcAYzvrBOIHrdXw0JDXIKlDku3aaFWgFWQ08MRXykHDX9RtUWIkqRNvNU476Qcpv6/Lm7b5TVkl
	4JVs7RVzpWlGnLNHHigu4azs/cldgASFLgUBcgng0xVtq7W5HFGvXIN9sYw==
X-Gm-Gg: AeBDieuQVNqoeJVf7M/D8T6VaBEy2zborru8onouqTqUVcFD+SA8sqCZNkEdIsboY1C
	bIY8Qq3mf2/huWQHky++E1IoQH74TFEVy5oPeMzJK71sF3XkCocaBg5pAbFirPXUpW7ArslrZ5A
	FuSni1U5/k6b+vOc9b8uPDgxNXBb+tgQpGH0ezPQJ7DECkdM3Je88I4nIQpyaRWM4sne+pwSCP9
	/1B1oEqPxrd7QeAhIqhUELPpQSF85vtFJ6MjoBKzDEBG6+AehQQYQ2TjOMQDA2Q0R3vIW2gt9rn
	23ZegNs3wFBR8w0LwODN2K4cAph1tsH3i4y5kGW1swRgDI930dKTLQ2mhtLhTD8l6g/+cgHibaE
	v0HmOGFq2cBgVOg7mLsT0HxxzDNDMHdFX+wlnkiDPXmTWONzi9roKBZFFZWK7pol++A==
X-Received: by 2002:a05:600c:c174:b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-48a83d66ba9mr39844525e9.3.1777545696624;
        Thu, 30 Apr 2026 03:41:36 -0700 (PDT)
X-Received: by 2002:a05:600c:c174:b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-48a83d66ba9mr39843895e9.3.1777545696080;
        Thu, 30 Apr 2026 03:41:36 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b120bdefsm12651906f8f.0.2026.04.30.03.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 03:41:35 -0700 (PDT)
Message-ID: <e41adaad-8937-4b5d-bdbf-d57d3efe2855@redhat.com>
Date: Thu, 30 Apr 2026 12:41:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 net-next 03/11] net/nebula-matrix: add chip related
 definitions
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, edumazet@google.com,
 enelsonmoore@gmail.com, skhan@linuxfoundation.org, hkallweit1@gmail.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260428114910.2616-1-illusion.wang@nebula-matrix.com>
 <20260428114910.2616-4-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260428114910.2616-4-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 39E224A0EEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,linux.dev,redhat.com,google.com,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-282765-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 4/28/26 1:48 PM, illusion.wang wrote:
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> index 77c67b67ba31..8831394ed11b 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> @@ -11,4 +11,473 @@
>  #include "../../nbl_include/nbl_include.h"
>  #include "../nbl_hw_reg.h"
>  
> +#define NBL_DRIVER_STATUS_REG			0x1300444
> +#define NBL_DRIVER_STATUS_BIT			16
> +
> +#pragma pack(1)

The kernel style for packed layouts is the __packed attribute; #pragma
pack is a non-portable compiler directive.

> +
> +/*  ----------  REG BASE ADDR  ----------  */
> +/* Interface modules base addr */
> +#define NBL_INTF_HOST_PCOMPLETER_BASE		0x00f08000
> +#define NBL_INTF_HOST_PADPT_BASE		0x00f4c000
> +#define NBL_INTF_HOST_MAILBOX_BASE		0x00fb0000
> +#define NBL_INTF_HOST_PCIE_BASE			0X01504000
> +/* DP modules base addr */
> +#define NBL_DP_USTORE_BASE			0x00104000
> +#define NBL_DP_UQM_BASE				0x00114000
> +#define NBL_DP_UPED_BASE			0x0015c000
> +#define NBL_DP_UVN_BASE				0x00244000
> +#define NBL_DP_DSCH_BASE			0x00404000
> +#define NBL_DP_SHAPING_BASE			0x00504000
> +#define NBL_DP_DVN_BASE				0x00514000
> +#define NBL_DP_DSTORE_BASE			0x00704000
> +#define NBL_DP_DQM_BASE				0x00714000
> +#define NBL_DP_DPED_BASE			0x0075c000
> +#define NBL_DP_DDMUX_BASE			0x00984000
> +/*  --------  MAILBOX BAR2 -----  */
> +#define NBL_MAILBOX_NOTIFY_ADDR			0x00000000
> +#define NBL_MAILBOX_BAR_REG			0x00000000
> +#define NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR	0x10
> +#define NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR	0x20
> +#define NBL_MAILBOX_QINFO_CFG_DBG_TABLE_ADDR	0x30
> +
> +/*  --------  MAILBOX  --------  */
> +
> +/* mailbox BAR qinfo_cfg_table */
> +struct nbl_mailbox_qinfo_cfg_table {
> +	u32 queue_base_addr_l;
> +	u32 queue_base_addr_h;
> +	u32 queue_size_bwind:4;
> +	u32 rsv1:28;
> +	u32 queue_rst:1;
> +	u32 queue_en:1;
> +	u32 dif_err:1;
> +	u32 ptr_err:1;
> +	u32 rsv2:28;

Sashiko says:

Can these bitfield register layouts work correctly on big-endian
hosts?
The C standard leaves allocation of bitfields within a storage unit
implementation-defined, and with GCC the order flips between LE and
BE targets (LSB-first on little-endian, MSB-first on big-endian).
Because nbl_hw_wr32() ultimately uses writel(), which only does
byte-level LE conversion, the hardware-visible bit positions produced
by these structs will differ between LE and BE builds.
The same question applies to every other bitfield struct added in
this header, e.g. nbl_mailbox_qinfo_map_table, nbl_host_msix_info,
ped_hw_edit_profile, dstore_disc_bp_th, nbl_shaping_net, ustore_pkt_len,
uvn_queue_err_mask, board_cfg_dw3, etc.
Would the explicit shift/mask helpers in <linux/bitfield.h>
(FIELD_PREP/FIELD_GET with GENMASK) be a better match here?

[...]
> +void nbl_write_all_regs(struct nbl_hw_mgt *hw_mgt)
> +{
> +	struct nbl_common_info *common = hw_mgt->common;
> +	u8 eth_mode = common->eth_mode;
> +	const u32 *nbl_sec046_data;
> +	const u32 *nbl_sec071_data;
> +	u32 i;
> +
> +	switch (eth_mode) {
> +	case 1:
> +		nbl_sec046_data = nbl_sec046_1p_data;
> +		nbl_sec071_data = nbl_sec071_1p_data;
> +		break;
> +	case 2:
> +		nbl_sec046_data = nbl_sec046_2p_data;
> +		nbl_sec071_data = nbl_sec071_2p_data;
> +		break;
> +	case 4:
> +		nbl_sec046_data = nbl_sec046_4p_data;
> +		nbl_sec071_data = nbl_sec071_4p_data;
> +		break;
> +	default:
> +		nbl_sec046_data = nbl_sec046_2p_data;
> +		nbl_sec071_data = nbl_sec071_2p_data;
> +	}
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC006_SIZE; i++) {
> +		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
> +			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
> +
> +		nbl_hw_wr32(hw_mgt, NBL_SEC006_REGI(i), nbl_sec006_data[i]);
> +	}
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC007_SIZE; i++)
> +		nbl_hw_wr32(hw_mgt, NBL_SEC007_REGI(i), nbl_sec007_data[i]);
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC008_SIZE; i++) {
> +		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
> +			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
> +
> +		nbl_hw_wr32(hw_mgt, NBL_SEC008_REGI(i), nbl_sec008_data[i]);
> +	}
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC009_SIZE; i++) {
> +		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
> +			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
> +
> +		nbl_hw_wr32(hw_mgt, NBL_SEC009_REGI(i), nbl_sec009_data[i]);
> +	}
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC010_SIZE; i++)
> +		nbl_hw_wr32(hw_mgt, NBL_SEC010_REGI(i), nbl_sec010_data[i]);
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC011_SIZE; i++) {
> +		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
> +			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
> +
> +		nbl_hw_wr32(hw_mgt, NBL_SEC011_REGI(i), nbl_sec011_data[i]);
> +	}
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC012_SIZE; i++)
> +		nbl_hw_wr32(hw_mgt, NBL_SEC012_REGI(i), nbl_sec012_data[i]);
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC013_SIZE; i++)
> +		nbl_hw_wr32(hw_mgt, NBL_SEC013_REGI(i), nbl_sec013_data[i]);
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC014_SIZE; i++)
> +		nbl_hw_wr32(hw_mgt, NBL_SEC014_REGI(i), nbl_sec014_data[i]);
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC022_SIZE; i++)
> +		nbl_hw_wr32(hw_mgt, NBL_SEC022_REGI(i), nbl_sec022_data[i]);
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC023_SIZE; i++)
> +		nbl_hw_wr32(hw_mgt, NBL_SEC023_REGI(i), nbl_sec023_data[i]);
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC024_SIZE; i++) {
> +		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
> +			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
> +
> +		nbl_hw_wr32(hw_mgt, NBL_SEC024_REGI(i), nbl_sec024_data[i]);
> +	}
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC025_SIZE; i++) {
> +		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
> +			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
> +
> +		nbl_hw_wr32(hw_mgt, NBL_SEC025_REGI(i), nbl_sec025_data[i]);
> +	}
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC026_SIZE; i++)
> +		nbl_hw_wr32(hw_mgt, NBL_SEC026_REGI(i), nbl_sec026_data[i]);
> +
> +	nbl_flush_writes(hw_mgt);
> +	for (i = 0; i < NBL_SEC027_SIZE; i++) {
> +		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
> +			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
> +
> +		nbl_hw_wr32(hw_mgt, NBL_SEC027_REGI(i), nbl_sec027_data[i]);

Sashiko says:

Could this loop read past the end of the nbl_sec009_data array?
The macro NBL_SEC009_SIZE is defined as 2048, but the nbl_sec009_data array
contains significantly fewer elements (around 754). This appears to cause
sequential out-of-bounds reads into the .rodata section, writing unrelated
memory to the device registers.
Similar size mismatches exist for nbl_sec025_data (262 elements vs size
1024)
and nbl_sec022_data (506 elements vs size 256).
Would it be safer to use ARRAY_SIZE() to bound these iterations?

/P


