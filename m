Return-Path: <netdev+bounces-281588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPK6KyMU8GnXOAEAu9opvQ
	(envelope-from <netdev+bounces-281588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:57:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1797347C906
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EF5D300EF80
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB4E2DA76A;
	Tue, 28 Apr 2026 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF37EZES"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70C729E11D;
	Tue, 28 Apr 2026 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341357; cv=none; b=eLAg/u5em/leg8W7RCLHMmkShI875iYMFk/lDehpLcQehl59DyAQd5zhp7uxaL/wzX7ocm4dz+w40hldXkIPkgACZq6kjQHHOq8lLF6EST7Mfo1h+kobPnyvkJV/nST4Ss8NxqszExp3/L2MnBBV3k3rIee1I5DIj0uszG8y348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341357; c=relaxed/simple;
	bh=B4TMd3gwcIx9uAkQwTjFjTQ/15OxP4DbOJFkrysFdxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmTDmQVOpGRl6+zxgPK3uYiuTpcsm/BF53F9Vs+pqzbJol5cL31XMZVoS/jEmj+bHCLfU9vGXfK6KhOLMPEueWakurJ7En3DVk3HUggZpmUHAQzHgHPt3VhVmBB1jB8hM4BCCPx2veqLipZNfEAVn3YnC5hvRXQgDHqrz1FCMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF37EZES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E66C19425;
	Tue, 28 Apr 2026 01:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777341357;
	bh=B4TMd3gwcIx9uAkQwTjFjTQ/15OxP4DbOJFkrysFdxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cF37EZESJRVe/nw9/RtFyiCLDVZilYN/gQ6pnjgujGjh1/CBV7jOOGyLsrXeVIAb7
	 1ZtyNCTRGYkXuQXrKOKMZaCBFRJk4PLNE58W1oedNOXJ5CdQ0vpklhFy+wsIbf6ziP
	 rc1YPDYlXFJuTvYyc1xawpahHe34MPQ7nqIejLxptl/+ehj1JpoDw3qbHaYp5Mt/X6
	 +K02Hx1vGfB47XRrylmdWZmANBI8zItI0buoGe9RiBANfKmjcJ5ReA/0zeJ4QS/NNt
	 BAji+Y22s4pMxveizE5NE/4/jKG+poS+nwvD+iSl1PcA6scAmoSJMMt55esUkTkACV
	 mcmNpWBukyrwg==
Date: Mon, 27 Apr 2026 18:55:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
Subject: Re: [PATCH net] net: enetc: fix VSI mailbox timeout handling and
 DMA lifecycle
Message-ID: <20260427185556.1805c3e3@kernel.org>
In-Reply-To: <20260424021534.2740211-1-wei.fang@nxp.com>
References: <20260424021534.2740211-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1797347C906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281588-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, 24 Apr 2026 10:15:34 +0800 Wei Fang wrote:
> +	/* The VSI mailbox may be busy if last message was not yet processed
> +	 * by PSI. So need to check the mailbox status before sending.
> +	 */
> +	vsimsgsr = enetc_rd(&si->hw, ENETC_VSIMSGSR);
> +	if (vsimsgsr & ENETC_VSIMSGSR_MB) {
> +		/* It is safe to free the DMA buffer here, the caller does
> +		 * not access the DMA buffer if enetc_msg_vsi_send() fails.
> +		 */
> +		enetc_msg_dma_free(dev, msg);
> +		dev_err(dev, "VSI mailbox is busy\n");
> +		return -EBUSY;

Sashiko suggests EIO here, since it's effectively an IO issue
and this errno goes back to user space

> +	}
> +
> +	/* Free the DMA buffer of the last message */
> +	enetc_msg_dma_free(dev, &si->msg);
> +	si->msg = *msg;
>  	enetc_msg_vsi_write_msg(&si->hw, msg);
>  
>  	do {

> @@ -269,7 +292,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
>  	enetc_teardown_cbdr(&si->cbd_ring);
>  
>  	free_netdev(si->ndev);
> -
> +	enetc_msg_dma_free(&pdev->dev, &si->msg);
>  	enetc_pci_remove(pdev);

Sashiko points out that if the goal is to avoid memory corruption we
should only free the buffer if the mbox is not busy. If it's busy
printing a warning and leaking is probably better.
-- 
pw-bot: cr

