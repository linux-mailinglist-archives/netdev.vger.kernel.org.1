Return-Path: <netdev+bounces-258601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iID2D/MJj2ngHQEAu9opvQ
	(envelope-from <netdev+bounces-258601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 12:24:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A16DF135B74
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 12:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17C1A303C62F
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE67130E0F0;
	Fri, 13 Feb 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbKsoDW7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13E2D47F1;
	Fri, 13 Feb 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981839; cv=none; b=CnzmEzkFcgUz6l3TWhkVNZB5zAh1Xb0KXVShgLH3/wT4eJbbgx1k0yHTj9zduDhxOVa2z9ex/b6jvm1j1ebo8LZ+Ak3/qm3YgmdL8YGDolKewPZjl3k05o/6v8QV00vV9vEYQH8Pg1Kfo2vFSsIsCeGjo9Dtpf40aLs7mr7NmQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981839; c=relaxed/simple;
	bh=eOUAluewwLteHnOQwgwF1FEmOzAaV27vBmh3LDI7F80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0I58+FTiZEnrwXz8WZXnkujgNdZy3IMLCixtIFnT5VqAXIkZ8s+SD1JWj0uUvFkPmfa1TXE2jEhk8aCUDRunrvT1vGtoZdr0UG0/cVjJVrO2aqJiRnhQJoaoB8rs3d9PEPdXVb1XvGx335dD8kOQpCbdLbSRbXT1jgU4uLzDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbKsoDW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AD3C4AF0B;
	Fri, 13 Feb 2026 11:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770981839;
	bh=eOUAluewwLteHnOQwgwF1FEmOzAaV27vBmh3LDI7F80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbKsoDW7MkOiqdBAbDsWAYwpy+2QC7aBgjexszdf70rQ3aWIHWTk/hK1Gcbm3O5fh
	 dWtYhdMBma4bd+q/gMchIV99jxaGZSBXx8ZyNsGNOzAtKvVxi0fTvnZV8KS3Gj3tLM
	 PNKto9qQ1qam8aW7D8d1q6rfs+RapaRqWD1cYi+YzzEK2KVq+PxPt/meqGINKV3Heu
	 CBh3DCRyU62dA54K/FFpQ/gVz9OPLag3PBp/0oU+UxuLV8autQNxAjP0q0T/rHJSNx
	 WZPJ8XBYkE9zuEWwUfeRV1ByUmOZDm0oYCRItDnDKUsS8uWRGrxG3dDulaYh3yyLCK
	 eUmihMge7C2mQ==
Date: Fri, 13 Feb 2026 13:23:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, ttoukan.linux@gmail.com,
	netdev@vger.kernel.org, kbusch@kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH] iommu/dma: Rate-limit WARN in iommu_dma_unmap_phys()
Message-ID: <20260213112355.GP12887@unreal>
References: <20260211-dma_io_mmu-v1-1-cf89e24437af@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211-dma_io_mmu-v1-1-cf89e24437af@debian.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258601-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,8bytes.org,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A16DF135B74
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 07:13:03AM -0800, Breno Leitao wrote:
> When a PCI error (e.g. AER error or DPC containment) marks the PCI
> channel as frozen or permanently failed, the IOMMU mappings for the
> device may already be torn down. If a driver continues processing
> completions in this state, every call to dma_unmap_page() triggers a
> WARN_ON in iommu_dma_unmap_phys().
> 
> In a real-world crash scenario on an NVIDIA Grace (ARM64) platform, a
> DPC event froze the PCI channel and the mlx5 NAPI poll continued
> processing error CQEs, calling dma_unmap for each pending WQE. With
> dozens of pending WQEs, the resulting WARN_ON storm monopolized the CPU
> in softirq context for over 23 seconds, triggering a soft lockup panic.
> 
> Replace WARN_ON(!phys) with WARN_RATELIMIT() to cap the warning output
> at the kernel's default rate limit (10 messages per 5 seconds), while
> still providing visibility into the failure with the device name in the
> message.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> ---
> I initially attempted to fix this in the driver itself, but that approach
> doesn't appear to be optimal, given the mappings can go away at any
> time, which is impossible to check at any time. Please see the discussion at:
> 
> https://lore.kernel.org/all/20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org/
> ---
>  drivers/iommu/dma-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

We have similar failure in our regression and the proposal fix is below,
can you please try if it fixes your issue too?

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 9e2cf191ed30..ac64a64e0565 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -44,7 +44,6 @@ static void mlx5e_reset_txqsq_cc_pc(struct mlx5e_txqsq *sq)
                  "SQ 0x%x: cc (0x%x) != pc (0x%x)\n",
                  sq->sqn, sq->cc, sq->pc);
        sq->cc = 0;
-       sq->dma_fifo_cc = 0;
        sq->pc = 0;
 }


