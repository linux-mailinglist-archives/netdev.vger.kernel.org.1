Return-Path: <netdev+bounces-288548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPF/HMnFB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:18:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 819F8559B92
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2798D3008686
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8EF1FC7FB;
	Sat, 16 May 2026 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHWv4W8a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C621DDC35;
	Sat, 16 May 2026 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894245; cv=none; b=O7e0atLgx/xMfjCQ3y3G3qp8JE8zQ1B0GPoGGx4T1e1xYBrlR7UmJ04iQrxlFNDCAqsThiZVNmTnvAbNZa/WZHm7NrLpKlickruoz877j3JnxLsAYMnuXCD9lpaj2MQgS3qkGebhjG0RIT1pvCL/bDC2UZuNXYKowgfc23ablfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894245; c=relaxed/simple;
	bh=f+M4vcKwK8EwFb05uG2mSIdBy1gVpWjjQiVq8hoOUyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6ssPk1AzVsBk2K12l927wRo0JZeLokgvESk6ntzRBMW8uA0wUx+wMja7R8OxCD6Gxpndbd9Bi0qgSCUDJjeq0wn/9N1Cy6ubSZcFGhrYrU1gXY57kqaTzG56X3qaK/7hdE5sFJeApzzBRHLrjtmXNELwRrVn45Rm0BRx2vUbi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHWv4W8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5050BC2BCB0;
	Sat, 16 May 2026 01:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894245;
	bh=f+M4vcKwK8EwFb05uG2mSIdBy1gVpWjjQiVq8hoOUyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHWv4W8aTRT649ijIOuO0gjo7dXWcKaODvDA+DmbSHPrQK+r6qQAVKParEqrNKop3
	 09mn12Ry07hZsVvFITooKfsXuG5p2uQFiZz3VTXhor1BcgmqUwd7M2I4cIcCaGawhm
	 +PG1d6wlq30v699Uv93eynLUT2RUAmfJ6mJKoyO+Rczpxm19EKDsUPqqvRuVkSu4ys
	 bkrMf4tJc/OvcyJDiBkdZT1OOVhHPQ9xvKauXOGyq47rXq25lq5uWEUJBqn7ADJ1Di
	 eJ2qQI0lqqWe/FrtvHT3jb+UNaRHVY7fkpZqeR+ctQYc9Ky+S9KmwNuun002cdVwAc
	 Mw2Pmu17Ixecg==
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
Subject: Re: [PATCH v14 net-next 10/11] net/nebula-matrix: add common/ctrl dev init/reinit operation
Date: Fri, 15 May 2026 18:17:23 -0700
Message-ID: <20260516011723.1864084-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513011649.4404-11-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-11-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 819F8559B92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-288548-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add common/ctrl dev init/reinit operation

This commit introduces common and control device setup and teardown routines
for the nebula-matrix network driver. It configures mailbox channels, queue
tasks, and MSI-X initialization.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -6,6 +6,159 @@
>  #include <linux/pci.h>
>  #include "nbl_dev.h"

[ ... ]

> +static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	struct nbl_dispatch_mgt *priv = dev_mgt->disp_ops_tbl->priv;
> +	struct nbl_common_info *common = dev_mgt->common;
> +	struct nbl_dev_common *common_dev;
> +	int ret;
> +
> +	common_dev = devm_kzalloc(&adapter->pdev->dev, sizeof(*common_dev),
> +				  GFP_KERNEL);
> +	if (!common_dev)
> +		return -ENOMEM;
> +	common_dev->dev_mgt = dev_mgt;
> +
> +	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	if (ret)
> +		return ret;
> +
> +	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
> +	common->vsi_id = disp_ops->get_vsi_id(priv, NBL_VSI_DATA);
> +	if (common->vsi_id == U32_MAX)
> +		return -ENOENT;

If disp_ops->get_vsi_id() or disp_ops->get_eth_id() fail below, does this
leak the mailbox channel queue?

Because dev_mgt->common_dev is not assigned until the very end of this
function, the standard cleanup routine nbl_dev_remove_common_dev() will
return early due to its NULL check. It seems the queue will not be destroyed
in these error paths.

> +	ret = disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_num,
> +			     &common->eth_id, &common->logic_eth_id);
> +	if (ret)
> +		return ret;
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
> +				   &common_dev->clean_mbx_task);
> +
> +	dev_mgt->common_dev = common_dev;
> +	nbl_dev_init_msix_cnt(dev_mgt);
> +
> +	return 0;
> +}
> +
> +static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +
> +	if (!common_dev)
> +		return;
> +
> +	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);

Can this lead to a race condition and a potential use-after-free?

By tearing down the channel queue before unregistering the task, a pending
or running clean_mbx_task could execute on the destroyed queue.

Additionally, is a call to cancel_work_sync() needed here for the
clean_mbx_task? Since common_dev is allocated via devm_kzalloc, it will be
freed when the device detaches. If the work is still pending or running, it
might try to access the freed memory.

> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
> +}

[ ... ]

