Return-Path: <netdev+bounces-288543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Gt6AJvFB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:17:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56297559B5A
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21B403018752
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983C919F40B;
	Sat, 16 May 2026 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWq4jsOG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564413B5B3;
	Sat, 16 May 2026 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894232; cv=none; b=iZDz43V+4o7HFCD2WVcfb8HPPCQvQ0lSouSLuwOrsfdc5qVHC6yzP1fQ5AUEk6xpkAXxIKmp/DY96Z/XtGq+ppH10r9MORpOjpVCimHpChJHUfG+INVF0NJ4c+whd7qtnNY2yalV9TrXzZRLeKFssBa7l6iCwzgBRs0et/HMA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894232; c=relaxed/simple;
	bh=3ry3Y4cHNXgYkcQujzG2rZgdNWylDhn+LiOnlNvOoiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoQlf0Alpb5IvVgVejVsVVma4Cig4aqHJzJSTdbGnYEiDz2rAEW+lK5jOuVchXTnZkWLl6oLuT583NWq7+tSQmuiH/uyF+CDMsqaQepC7Zi+He1IYTYj94EccFjmkqxwNc0+wtyBOWEA0VGS0Np+ayoQFHgG8Zn9SksaBemTtZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWq4jsOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D742C2BCB0;
	Sat, 16 May 2026 01:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894232;
	bh=3ry3Y4cHNXgYkcQujzG2rZgdNWylDhn+LiOnlNvOoiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWq4jsOGKiLxLktNULO9q3brsAKXRS75ZtQZCwKtgF5+/wkoeAiOI3KiX/dDlZPtD
	 E0GnRNxHVUqo2pkq2kZIMWoAW5+CfjAswWTxpk7+nAcXY76ZhYuZ5YPCa+RtMlN7YL
	 3KZXVFw0VfhtZMxj50RUD/iLU9jIj7t4TPE2YdyH6FILiAf/sBYH/AiVzXgap0Ifl9
	 1Cz722OZHaZUPu9duO+4jeaCC1XuNHQK27JOwhT21ppibG+msehUhmteh94zEVZl2b
	 LMDyzJ80tx1TQOGybJkrsiIQ88Ob8/3Kw0FmhsWZ95kIGsSmpN5PmS211vBoR3Ht1P
	 okGiSN2/zjN9Q==
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
Subject: Re: [PATCH v14 net-next 02/11] net/nebula-matrix: add our driver architecture
Date: Fri, 15 May 2026 18:17:07 -0700
Message-ID: <20260516011707.1863778-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513011649.4404-3-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-3-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 56297559B5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-288543-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pf.so:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add our driver architecture

This commit introduces the baseline driver architecture for the
nebula-matrix networking device. It establishes the Hardware, Channel,
Resource, Dispatch, and Device layers for device management.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 0000000000000..1d673b7757655
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> @@ -46,104 +46,149 @@
> +int nbl_hw_init_leonis(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	if (common->has_ctrl) {
> +		bar_len = pci_resource_len(pdev, NBL_MEMORY_BAR);
> +		bar_start  = pci_resource_start(pdev, NBL_MEMORY_BAR);
> +		if (!(pci_resource_flags(pdev, NBL_MEMORY_BAR) &
> +		    IORESOURCE_MEM) ||
> +		    bar_len < NBL_RDMA_NOTIFY_OFF) {

If bar_len is exactly equal to NBL_RDMA_NOTIFY_OFF (8192 bytes), this check
evaluates to false and passes.

> +			dev_err(&pdev->dev, "Invalid BAR: unassigned or length too small\n");
> +			ret = -EINVAL;
> +			goto ioremap_err;
> +		}
> +		hw_mgt->hw_addr =
> +			ioremap(bar_start,
> +				bar_len - NBL_RDMA_NOTIFY_OFF);

Which then leads to ioremap(bar_start, 0) here. Is mapping 0 bytes valid, or
could it lead to out-of-bounds accesses? Should the condition above be
bar_len <= NBL_RDMA_NOTIFY_OFF?

> +		if (!hw_mgt->hw_addr) {
> +			dev_err(&pdev->dev, "Memory bar ioremap failed\n");
> +			ret = -EIO;
> +			goto ioremap_err;
> +		}
> +		hw_mgt->hw_size = bar_len - NBL_RDMA_NOTIFY_OFF;
> +	} else {
> +		hw_mgt->hw_addr =
> +			ioremap(pci_resource_start(pdev, NBL_MEMORY_BAR),
> +				NBL_RDMA_NOTIFY_OFF);

Are we missing a validation check here? Unlike the has_ctrl branch, this
unconditionally maps NBL_MEMORY_BAR without checking if the BAR has the
IORESOURCE_MEM flag or if its length is at least NBL_RDMA_NOTIFY_OFF. Could
this cause issues if the device presents an unassigned or I/O port BAR?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
> index 0000000000000..2921f70890722
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h

[ ... ]

> +
> +#define NBL_MEMORY_BAR				0
> +#define NBL_MAILBOX_BAR				2
> +#define NBL_RDMA_NOTIFY_OFF			8192
> +#define NBL_HW_DUMMY_REG			0x1300904

[ ... ]

> +static inline void nbl_flush_writes(struct nbl_hw_mgt *hw_mgt)
> +{
> +	nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
> +}

Can this perform an out-of-bounds memory read? NBL_HW_DUMMY_REG is defined as
0x1300904 (~19MB), but when has_ctrl is false, the driver explicitly maps only
NBL_RDMA_NOTIFY_OFF (8192 bytes) for hw_mgt->hw_addr. Should the driver ensure
the offset is bounded by hw_mgt->hw_size?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 10c3536b327b2..56131a50d59bd 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

[ ... ]

> +struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
> +				  struct nbl_init_param *param)
> +{

[ ... ]

> +	ret = product_base_ops->hw_init(adapter);
> +	if (ret)
> +		goto hw_init_fail;
> +
> +	ret = product_base_ops->chan_init(adapter);
> +	if (ret)
> +		goto chan_init_fail;
> +
> +	ret = product_base_ops->res_init(adapter);
> +	if (ret)
> +		goto res_init_fail;
> +
> +	ret = nbl_disp_init(adapter);
> +	if (ret)
> +		goto disp_init_fail;
> +
> +	ret = nbl_dev_init(adapter);
> +	if (ret)
> +		goto dev_init_fail;
> +	return adapter;
> +
> +dev_init_fail:
> +	nbl_disp_remove(adapter);
> +disp_init_fail:
> +	product_base_ops->res_remove(adapter);
> +res_init_fail:
> +	product_base_ops->chan_remove(adapter);
> +chan_init_fail:
> +	product_base_ops->hw_remove(adapter);
> +hw_init_fail:
> +	return NULL;
> +}

Does this silently discard specific initialization error codes? When
sub-initialization routines fail, they return informative error codes like
-ENOMEM or -EINVAL, but this function catches them and simply returns NULL.

[ ... ]

> +static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
> +			       struct nbl_init_param *param)
> +{

[ ... ]

> +	/*
> +	 * Leonis only PF0 has ctrl capability, but PF0's pcie device_id
> +	 * is same with other PF.So handle it special.
> +	 */
> +	if (param->product_type == NBL_LEONIS_TYPE &&
> +	    (PCI_FUNC(pdev->devfn) == 0))
> +		param->caps.has_ctrl = 1;
> +}

Could this incorrectly grant VFs management privileges? In SR-IOV environments
where VFs are assigned to new virtual buses (such as with Alternative Routing-ID
Interpretation), VFs can also have a function number of 0. Should the driver
verify that the device is actually a Physical Function by checking
!pdev->is_virtfn?

[ ... ]

> +static int nbl_probe(struct pci_dev *pdev,
> +		     const struct pci_device_id *id)
> +{

[ ... ]

> +	adapter = nbl_core_init(pdev, &param);
> +	if (!adapter) {
> +		dev_err(dev, "Nbl adapter init fail\n");
> +		err = -ENODEV;
> +		goto adapter_init_err;
> +	}

If nbl_core_init() returned an ERR_PTR(ret) instead of NULL, we wouldn't have
to unconditionally override the true root cause of probe failures with -ENODEV,
which could make driver debugging easier.
-- 
pw-bot: cr

