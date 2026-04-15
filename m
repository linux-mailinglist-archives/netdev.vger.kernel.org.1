Return-Path: <netdev+bounces-278776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HgHBguS32l0WAAAu9opvQ
	(envelope-from <netdev+bounces-278776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:26:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B7404C1F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14E6F3016810
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599403A5E64;
	Wed, 15 Apr 2026 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf7vnJgp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029422538F
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259592; cv=none; b=mn/qn36UB9upvG43ERni5yH4NX65K9Os1Xgm1gel74apEJZfo52PFfIACOWuROzJEO1gQtGahZq8CcXlmDnDPvScLILRb0lLG1F83fqhah09X2foHjzTYf0dmoPPjn175vAhYSvgHlsHq0yvO9V8fY6iouF1SErMYbTcBiFY1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259592; c=relaxed/simple;
	bh=DENY9p9CKwihwW347KzzpeYMyVvwNcN5J3ZSHZcwozU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czF/uKUiP20BMfBuMofCq+sgFaOzHnzUe6uffr94yZxz//wjXDndJp138NNc2F/Kk4qJjY+O5tY0SJ0Ti48RMzDi9ntnjuEPdh5kMh88LQ7547zAJbdUigLJpy+4m5hnAsHvDAms77PzCVbc3RcTfj2w0s717Inp+iytArc/DpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf7vnJgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B309EC19424;
	Wed, 15 Apr 2026 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776259592;
	bh=DENY9p9CKwihwW347KzzpeYMyVvwNcN5J3ZSHZcwozU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bf7vnJgpzCsbPUH8WG8aESx8Oi+xPqzTkKQaUX7Pc5u2zei199VgIVJlfLq5cU4v9
	 TGajpwWHwS8L9OyXYRva8Iv/nJm3OJj1vLNpCyfTKA/MnGfZUAvSVIQ/irb6M1vPGI
	 UZ/oAZ0211kBLmKkwVazf18jzrnthWWp5eGlXWWilmllIaKghpfjLJ4XiGSFjLTDMU
	 zeP86rJ4KfySFbfchl5zVQHbNaci1v7fIEwY8mEgOl0inXbgomqSDYoiZZ0f2WqjEY
	 HxNJrENRJAV4FdDNtfNQpLJGIrIFUlXbr2IGm7IpEY4juAuAOVw0Met80TpFdcYMFQ
	 z6Q+AO+uypEtQ==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	kiran.patil@intel.com
Subject: Re: [PATCH iwl-net 2/5] iavf: fix error path in iavf_request_misc_irq
Date: Wed, 15 Apr 2026 14:26:11 +0100
Message-ID: <20260415132610.803526-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413073035.4082204-3-aleksandr.loktionov@intel.com>
References: <20260413073035.4082204-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278776-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 841B7404C1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
iavf: fix error path in iavf_request_misc_irq

This patch drops the free_irq() call from the error path of
iavf_request_misc_irq() when request_irq() fails. This is intended to
prevent a kernel warning when freeing an unrequested vector.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index dad001abc9086..ab5f5adc2d3c2 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -587,7 +587,6 @@ static int iavf_request_misc_irq(struct iavf_adapter *adapter)
>  		dev_err(&adapter->pdev->dev,
>  			"request_irq for %s failed: %d\n",
>  			adapter->misc_vector_name, err);
> -		free_irq(adapter->msix_entries[0].vector, netdev);

Does this patch completely fix the warning?

If request_irq() fails, iavf_request_misc_irq() returns an error but leaves
adapter->msix_entries allocated.

In caller error handling paths like iavf_disable_vf() which clean up after a
failure, iavf_free_misc_irq() is called:

static void iavf_free_misc_irq(struct iavf_adapter *adapter)
{
	struct net_device *netdev = adapter->netdev;

	if (!adapter->msix_entries)
		return;

	free_irq(adapter->msix_entries[0].vector, netdev);
}

Since adapter->msix_entries is still allocated, the check passes and free_irq()
is called on the unrequested vector anyway, triggering the exact same warning.

Does the driver need to explicitly track whether the IRQ was successfully
requested?

>  	}
>  	return err;
>  }

