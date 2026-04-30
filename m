Return-Path: <netdev+bounces-283017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA+dKUjq82kA8wEAu9opvQ
	(envelope-from <netdev+bounces-283017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:48:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4811E4A8F28
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3CC9302F24B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AF23DA5C6;
	Thu, 30 Apr 2026 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU2QAg42"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB523DA5B5;
	Thu, 30 Apr 2026 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592868; cv=none; b=atMU/dGQkst4ixrC/ZdtyfG2CJEAptdO7h15y8YtHONrQmncinD3O3go7+ne9I6SmChwatd68LE4/vrdycoiTyo+jyYqMD2l1LW8QJaJ1DJYYZ03Vc9VElc4l5EmnTACEASvO51g1UHL1FnXhC7LQmAGuNFid/20BlXajRuPEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592868; c=relaxed/simple;
	bh=WZ3eT3xdLHy5u7YcqL0ogKQsD0wpsZ7CxqWCX+prLy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmvVYQ7LvOnoA8Q8a75Y0k7UGexg3AdZTfudTHO5Ezv3WYtY0+cBIoF2EN+cl4zDaQ7NV6eovXJC6k2RbTAo8HQfUiQH87pXHY6j79NHC9DJWVqw0Apej9CSDtoP8of0CHoKtAoaYZBH4fCs01T38xXudjd8U8diSz0RCnSavCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU2QAg42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794AAC2BCB3;
	Thu, 30 Apr 2026 23:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777592868;
	bh=WZ3eT3xdLHy5u7YcqL0ogKQsD0wpsZ7CxqWCX+prLy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jU2QAg42s+31kEUIpmjiGn9bjAHBJgt4dFWV83YJEsxoedyyx3ilKfrTLtBCbycMh
	 wDGJDy6nIW53dcsxua+va+prM/ZNQhkUXWhIRATVfFRNfFngNgyH1GPcvydOMAW90Q
	 Hrnvjjb7IIUV4YYWGpJ3Y5+W1rtnsj7QT54xJokqaWK1pGiY6cYl4PftKuOD6TtTHQ
	 emQwx/pAd4c0DqdRDn0Njj+IG6lP1neJOKkDwJLijMu1Lhed9IWQmYGEfDFscSigQn
	 XqQu/68KolzqhfudOQ+hYvUocGoSTGrqfAuprbrCnydGPgnu5Gx9NrYL4Cc7H+NiPM
	 gj5yEgUAKeCpg==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 net-next 07/11] net/nebula-matrix: add intr resource implementation
Date: Thu, 30 Apr 2026 16:47:46 -0700
Message-ID: <20260430234746.3074632-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428114910.2616-8-illusion.wang@nebula-matrix.com>
References: <20260428114910.2616-8-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4811E4A8F28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283017-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add intr resource implementation

This patch adds an interrupt resource module that tracks MSI-X vector
allocation per function via two bitmaps and a per-function array, and
introduces three resource ops (configure_msix_map, destroy_msix_map,
enable_mailbox_irq) plus the matching hw_ops (configure_msix_map,
configure_msix_info, enable_mailbox_irq) that program the device MSI-X
mapping and info registers.

A few questions below on the new code.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> index 1ec1c28d99ff..1cceb0df5e1e 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> @@ -12,6 +12,7 @@ static struct nbl_resource_ops res_ops = {
>  	.get_eth_id = nbl_res_get_eth_id,
>  };
>  
> +static bool is_ops_inited;

Is this lazy initialization of a file-scope vtable safe against concurrent
probes?

nbl_res_setup_ops() does an unlocked check-then-set on is_ops_inited and
then mutates the file-scope res_ops by calling nbl_intr_setup_ops():

	if (!is_ops_inited) {
		ret = nbl_intr_setup_ops(&res_ops);
		if (ret)
			return ERR_PTR(-ENOMEM);
		is_ops_inited = true;
	}

Two probe threads for different functions on the same device could both
observe is_ops_inited == false and race on writing the same pointer fields
into res_ops.  Would a static designated initializer in res_ops (keeping
res_ops const and dropping is_ops_inited / nbl_intr_setup_ops entirely)
remove the race and simplify the scaffolding?

Related: nbl_intr_setup_ops() only ever returns 0, so the caller's
"if (ret) return ERR_PTR(-ENOMEM);" is unreachable, and mapping any future
failure to -ENOMEM would also be incorrect.  Could this function be void?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 000000000000..92a6fff5523e
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> @@ -0,0 +1,246 @@
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

Is func_id bounds-checked anywhere on this path?  intr_mgt->func_intr_res[]
is sized NBL_MAX_FUNC (520) but the u16 func_id (0..65535) is indexed
directly, and nbl_res_func_id_to_bdf() (which validates against max_pf) is
not called here.  If func_id arrives from a mailbox message in a later
patch, can this index out of bounds?

The same question applies to nbl_res_intr_enable_mailbox_irq() and to the
first use of func_intr_res[func_id] in nbl_res_intr_configure_msix_map()
below, which happens before nbl_res_func_id_to_bdf() is called.

> +
> +	if (!interrupts) {
> +		dev_err(dev, "No interrupts to clr for func_id %u\n", func_id);
> +		return -EINVAL;
> +	}
> +	for (i = 0; i < intr_num; i++) {
> +		if (interrupts[i] >= NBL_MAX_OTHER_INTERRUPT)
> +			clear_bit(interrupts[i] - NBL_MAX_OTHER_INTERRUPT,
> +				  intr_mgt->interrupt_net_bitmap);
> +		else
> +			clear_bit(interrupts[i],
> +				  intr_mgt->interrupt_others_bitmap);

What serializes access to intr_mgt->interrupt_net_bitmap,
intr_mgt->interrupt_others_bitmap and intr_mgt->func_intr_res[func_id]
across concurrent invocations of these three ops?

set_bit() / clear_bit() are individually atomic, but the sequence used in
nbl_res_intr_configure_msix_map():

	intr_index = find_first_zero_bit(intr_mgt->interrupt_net_bitmap,
					 NBL_MAX_NET_INTERRUPT);
	...
	set_bit(intr_index, intr_mgt->interrupt_net_bitmap);

is a non-atomic read-modify-write.  Two concurrent calls for different
func_ids could each observe the same zero bit and both claim it, resulting
in two functions being programmed with the same global MSI-X index.

The per-function state has a similar concern: configure, destroy and
enable_mailbox_irq all read/write func_intr_res[func_id].interrupts,
num_interrupts and msix_map_table without any lock held.  Concurrent
callers on the same func_id can race the "if (interrupts) destroy" TOCTOU
and realloc, double-kfree() the interrupts array, or dma_free_coherent()
twice.  enable_mailbox_irq dereferences interrupts[vector_id] which
destroy_msix_map has just freed and set to NULL -- is this a
use-after-free?

The WARN_ON(msix_map_table->base_addr) below suggests single-threaded use
is assumed; what enforces that?

[ ... ]

> +	kfree(interrupts);
> +	intr_mgt->func_intr_res[func_id].interrupts = NULL;
> +	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
> +
> +	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
> +	dma_free_coherent(dev, msix_map_table->size, msix_map_table->base_addr,
> +			  msix_map_table->dma);

Is there a teardown path that iterates over func_intr_res[] and calls
destroy_msix_map() for each active func_id on module unload / device
remove?

The interrupts array (kcalloc) and the msix_map_table (dma_alloc_coherent)
allocated in configure_msix_map are not devm-managed, and
nbl_res_remove_leonis() does not walk func_intr_res[].  Any func_id still
mapped at unload time would leak both allocations and leave a stale bus
address programmed in the hardware MSI-X map register.

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

Is this reconfigure ordering intentional?

The existing mapping is torn down (dma_free_coherent, kfree, and
hw_ops->configure_msix_map(valid=false)) before the new allocations are
attempted.  If the subsequent dma_alloc_coherent or kcalloc fails, the
function returns -ENOMEM with the previously working interrupt setup
already gone and no rollback.  Would allocate-then-swap be safer?

> +
> +	ret = nbl_res_func_id_to_bdf(res_mgt, func_id, &bus, &devid, &function);
> +	if (ret == U32_MAX)
> +		return -EINVAL;

nbl_res_func_id_to_bdf() is declared to return int but returns U32_MAX on
error, and the caller stores it in int ret and compares against U32_MAX.
This currently works only because -1 sign-extends to 0xFFFFFFFF.  If the
callee is later changed to return a normal negative errno (for example
-EINVAL), will this check silently stop detecting failures and let
uninitialised bus/devid/function be programmed into hardware?

> +
> +	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
> +	WARN_ON(msix_map_table->base_addr);
> +	msix_map_table->size =
> +		sizeof(struct nbl_msix_map) * NBL_MSIX_MAP_TABLE_MAX_ENTRIES;
> +	msix_map_table->base_addr = dma_alloc_coherent(dev,
> +						       msix_map_table->size,
> +						       &msix_map_table->dma,
> +						       GFP_KERNEL);

[ ... ]

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

Is a dma_wmb() (or equivalent) needed between the stores into the
dma_alloc_coherent table (msix_map_entries[i] fields above) and the MMIO
writel() in hw_ops->configure_msix_map that arms the device to DMA-read
that table?

dma_alloc_coherent guarantees cache coherence but not ordering between
CPU stores into the coherent buffer and subsequent MMIO stores on
weakly-ordered architectures such as arm64 and ppc.

> +
> +	return 0;

[ ... ]

> +static int nbl_res_intr_enable_mailbox_irq(struct nbl_resource_mgt *res_mgt,
> +					   u16 func_id, u16 vector_id,
> +					   bool enable_msix)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	u16 global_vec_id;
> +
> +	global_vec_id = intr_mgt->func_intr_res[func_id].interrupts[vector_id];

Is this dereference guarded anywhere?  There is no check that
func_intr_res[func_id].interrupts is non-NULL or that vector_id is less
than num_interrupts.

After destroy_msix_map() runs, interrupts is NULL; and before
configure_msix_map() has ever run for that func_id it is also NULL, so
this becomes a NULL-pointer read at offset 2 * vector_id.  When interrupts
is non-NULL but vector_id is out of range, this is an out-of-bounds slab
read whose value is then programmed into a hardware MSI-X register via
hw_ops->enable_mailbox_irq().

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

This isn't a bug, but could this X-macro scheme be replaced with a plain
designated initializer on a const struct nbl_resource_ops?  The indirection
through NBL_INTR_OPS_TBL / NBL_INTR_SET_OPS and the NBL_NAME(x) helper
(whose stated purpose is "Used for macros to pass checkpatch") add no
type safety over:

	static const struct nbl_resource_ops res_ops = {
		.configure_msix_map  = nbl_res_intr_configure_msix_map,
		.destroy_msix_map    = nbl_res_intr_destroy_msix_map,
		.enable_mailbox_irq  = nbl_res_intr_enable_mailbox_irq,
		...
	};

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> index 90c78aefa498..d4a1374e0dd2 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> @@ -18,6 +18,37 @@
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

Is it safe to rely on C bitfield layout for a structure that is written
into dma_alloc_coherent memory and then consumed by the device?  The bit
ordering of bitfields within a storage unit is implementation-defined, and
GCC reverses bit ordering on big-endian targets.

The same question applies to nbl_mailbox_qinfo_map_table,
nbl_host_msix_info, nbl_pcompleter_host_msix_fid_table and
nbl_function_msix_map, which are assembled with C bitfields and then cast
to u32 * to be written into MMIO registers in nbl_hw_leonis.c.  Would
explicit FIELD_PREP / shifts-and-masks or __le* encoding be more portable?

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

msix_base and msix_max do not appear to be read or written anywhere in
this patch.  Could these be added in the patch that first uses them?

> +	u16 *interrupts;
> +	struct nbl_msix_map_table msix_map_table;
> +};

[ ... ]

One last question on the commit message:

    MSI-X Interrupt Configuration:
    Dynamically allocate and manage MSI-X interrupt vectors, including
    network interrupts and other types of interrupts.
    ...
    Interrupt Information Query: Provide interfaces to obtain the
    hardware register addresses and data of interrupts.

The patch programs the device-private MSI-X mapping and info registers and
tracks index bitmaps, but there is no pci_alloc_irq_vectors(), no
request_irq(), no IRQ handler, and no "interrupt information query" getter
exposed through nbl_resource_ops -- only configure_msix_map,
destroy_msix_map and enable_mailbox_irq are added.  Could the commit
message be narrowed to what this patch actually implements?

