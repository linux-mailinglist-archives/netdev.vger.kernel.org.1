Return-Path: <netdev+bounces-288546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBSoDajFB2pyIAMAu9opvQ
	(envelope-from <netdev+bounces-288546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:17:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD0F559B69
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF2DE300B9C2
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C12222A9;
	Sat, 16 May 2026 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYTNMhAI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB81DDC35;
	Sat, 16 May 2026 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894239; cv=none; b=bvBpnsve1oMtDLiIYgnt4ZIftnmlVDMvm44oZDQsB1GPHHZLt3ulNyNHR8p6SGUq2v0h+hVupYCAMfe9zilW0kV5Md2zW/Acf734HHBwpmdwP3RxvZN0UVUeYKCOEk15HWdkgPkl9/6Hx5OPACdP8wmwR6/Zy6H6XXlVZLGLfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894239; c=relaxed/simple;
	bh=NTmDybnJmucN1fJhDmejKbpLOc0Fb9sL51dU5jBJuW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ+1QEWacRHYDxf8IfHfA4/fqbaLPQz7wncizorYpVyyXSYckF6Vj1tq/aUHlTOJrJTrYJOD4CvNi82DILpGVuGP14ngTZIv3ylzl14ig95Ps+nEmB8MV+CxoT34vHbUkDPMgGJ87xDx6tI23Bd2Eon9r0f3Oh2M3yKNtio1jKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYTNMhAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227ECC2BCB7;
	Sat, 16 May 2026 01:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894238;
	bh=NTmDybnJmucN1fJhDmejKbpLOc0Fb9sL51dU5jBJuW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYTNMhAIfSOlQvjpWdYwSHbqy/72TSG3EMldWT/nL+FNYurmno0ESXcjBStwtJn2V
	 bXETEAr9rMRpE1CDaDaqXLuI4i8ZjFqcQAIq4vXYIG9Ytpvjw3Geh0K2WN2Fmi0Q+B
	 n0YTcgJxjq1WNWziI/Pc1/u1NlZPFbijOZcABXTMPUJv//5gECrH7PHe1Rc5u9SUv9
	 7O95ykCiQ4n1jVv30X/cBKQDgx65Jju00+MZa3Anhb8zmTv93IlJRNtM8IVdEs2t4p
	 N/NF21ZXzARekZCzD3/9qgEA3lt/8dU9SBEyO2Zn8g0J3BEZAUHDW6emHlKG5A23sr
	 ykPtiBabUPn2g==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 net-next 07/11] net/nebula-matrix: add intr resource implementation
Date: Fri, 15 May 2026 18:17:17 -0700
Message-ID: <20260516011717.1863989-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513011649.4404-8-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-8-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDD0F559B69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-288546-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add intr resource implementation
    
Implement dynamic allocation and management of MSI-X interrupt vectors,
including network interrupts and other interrupt types. Maintain the
MSI-X mapping table (msix_map_table) to establish interrupt associations
between hardware and software. Support enabling/disabling specific
interrupts through hardware operations.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 55d6ed70a9e60..612d6c9812b01 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -64,6 +64,76 @@ static void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, const u32 *data,

[ ... ]

> +static void nbl_hw_configure_msix_map(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				      bool valid, dma_addr_t dma_addr, u8 bus,
> +				      u8 devid, u8 function)
> +{
> +	union nbl_function_msix_map_u function_msix_map;
> +
> +	memset(&function_msix_map, 0, sizeof(function_msix_map));
> +	if (valid) {
> +		function_msix_map.info.msix_map_base_addr = dma_addr;
> +		/* use af's bdf, because dma memmory is alloc by af */
> +		function_msix_map.info.function = function;
> +		function_msix_map.info.devid = devid;
> +		function_msix_map.info.bus = bus;
> +		function_msix_map.info.valid = 1;
> +	}
> +
> +	nbl_hw_wr_regs(hw_mgt,
> +		       NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(func_id),
> +		       function_msix_map.data, sizeof(function_msix_map));

Is there an out-of-bounds array access here when passing
function_msix_map.data?

union nbl_function_msix_map_u contains struct info which is 16 bytes long,
but its data array is defined as u32 data[NBL_FUNC_MSIX_MAP_DWLEN], where
NBL_FUNC_MSIX_MAP_DWLEN is 3 (12 bytes).

When nbl_hw_wr_regs() receives sizeof(function_msix_map) (16 bytes), it will
iterate 4 times and access data[3]. Since data is an array of size 3, this
triggers an out-of-bounds memory violation under CONFIG_UBSAN_BOUNDS.
Should NBL_FUNC_MSIX_MAP_DWLEN be updated to 4?

> +}

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> index 15dc7f78afc0b..b1f5724e727a9 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> @@ -18,6 +18,35 @@
>  
>  struct nbl_resource_mgt;
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

Does this code use C bitfields for hardware-shared structures?

This structure is used for DMA-coherent memory in
nbl_res_intr_configure_msix_map():

drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c:nbl_res_intr_configure_msix_map() {
    ...
	msix_map_table->size =
		sizeof(struct nbl_msix_map) * NBL_MSIX_MAP_TABLE_MAX_ENTRIES;
	msix_map_table->base_addr = dma_alloc_coherent(dev,
						       msix_map_table->size,
    ...
}

Bitfield packing order is implementation-defined in C. On Big Endian
architectures, compilers pack bitfields in the opposite direction from Little
Endian, which will cause the hardware to read misaligned or reversed bit
positions. Standard kernel practice mandates using explicitly sized types
like __le16 and bitwise operations (FIELD_PREP, etc.) for hardware-facing
memory.

The same applies to MMIO registers written using unions containing bitfields,
such as union nbl_function_msix_map_u and union nbl_mailbox_qinfo_map_table_u.
Could these be converted to standard bitwise operations as well?

