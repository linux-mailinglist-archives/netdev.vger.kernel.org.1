Return-Path: <netdev+bounces-282566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5dSDEXip8mmstQEAu9opvQ
	(envelope-from <netdev+bounces-282566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:59:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9230349BDDA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36198300F51B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE1621A459;
	Thu, 30 Apr 2026 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJs40i6b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BD5474F;
	Thu, 30 Apr 2026 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510770; cv=none; b=gLIzF1cauqNTZWomv0DO63SXNhH9jO4AbQyOUIOcoK9TGUd1VdS1zKC6HeWdH6yNGVfnApaQAYIWzHOdBNDApecBrP1nofFdawtb1Zmlvm6EdW5D9a1hwHmoB5TNceTL0ffJIxvhRv0RDIcPox/V8G3WRDZL3Z4GKccPbI8rbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510770; c=relaxed/simple;
	bh=kOruFAilq7Jtl1UPd7biykndLNJldYpzfBtFWIdBIWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdT55mL/AFfFnAp1eOa+dOJ/9hjNA5iMr/rdIFEUC9EwMB7Pg7rfgNgncwsM5shNDRTwyCDm5OUZJ/9qrAOV52UipKyy/TjHOtBFi7j/yJQrtsPMoI4i20bCsc/qvwi8EMnR7VXCWOYf/lPPG3SVUsE2uHDhxPXfwEypJVwOFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJs40i6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59414C19425;
	Thu, 30 Apr 2026 00:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777510769;
	bh=kOruFAilq7Jtl1UPd7biykndLNJldYpzfBtFWIdBIWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cJs40i6blewAusDoiLM8gOuK6cvIqQxqsa+U5FWJflaTG8nQueeTV+CTapOVCLtqh
	 G/XNs3pL+UiBsip+cwdi0yG90U2QRaqEOdtrge56C+JWFxKMLIF+NmoNAWSKwhtybg
	 8XP+IjnYlIi5350RBCIQ3LdEFdqxo0GdbrDzLqpq/7TWBRm1Hi4E26gInFCLIud4Sa
	 SrvujoRUEuOsHzCM7s8bgCbFMjZc0ftwyV+vaVPL8j7XLzYFh+48dhruLjjKM7riS4
	 pXgXQPRauG6ODLn80av/F0fntw6798xL9vg/3sxN0z2IbAEc3lcR9zLoeuxGI5uz2c
	 wgR6r4VRbROfw==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net] net: enetc: fix VSI mailbox timeout handling and DMA lifecycle
Date: Wed, 29 Apr 2026 17:59:20 -0700
Message-ID: <20260430005919.2320380-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428063111.2869408-1-wei.fang@nxp.com>
References: <20260428063111.2869408-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9230349BDDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-282566-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: enetc: fix VSI mailbox timeout handling and DMA lifecycle

This patch preserves the VSI mailbox DMA buffer in si->msg so it can
be freed on the next send (once the mailbox is no longer busy), and
adds a final free in enetc_vf_remove(). It also bails out early if
the mailbox is still busy when a new message is submitted.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index 6c4b374bcb0e..e8c5adee9743 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c

[ ... ]

> @@ -258,6 +281,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
>  static void enetc_vf_remove(struct pci_dev *pdev)
>  {
>  	struct enetc_si *si = pci_get_drvdata(pdev);
> +	struct enetc_msg_swbd msg = si->msg;
>  	struct enetc_ndev_priv *priv;
>  
>  	priv = netdev_priv(si->ndev);
>  	unregister_netdev(si->ndev);

Is there a race between this local copy of si->msg and a concurrent
ndo callback?

The local 'msg' is captured at function entry, before unregister_netdev()
has run, and .remove() does not hold RTNL. During that window, userspace
(for example 'ip link set dev ethX address ...') can acquire RTNL and
invoke enetc_vf_set_mac_addr() -> enetc_msg_vsi_set_primary_mac_addr()
-> enetc_msg_vsi_send() on the same si.

Inside enetc_msg_vsi_send(), on the non-busy path:

	/* Free the DMA buffer of the last message */
	enetc_msg_dma_free(dev, &si->msg);
	si->msg = *msg;

the buffer whose (vaddr, dma, size) our local 'msg' still holds a copy
of gets freed, and si->msg is replaced with a new allocation.

>  
>  	enetc_free_msix(priv);
>  
>  	enetc_free_si_resources(priv);
>  	enetc_teardown_cbdr(&si->cbd_ring);
>  
>  	free_netdev(si->ndev);
>  
>  	enetc_pci_remove(pdev);
> +	enetc_msg_dma_free(&pdev->dev, &msg);
>  }

When this trailing enetc_msg_dma_free(&pdev->dev, &msg) runs, can it
call dma_free_coherent() on a buffer that enetc_msg_vsi_send() already
freed, and also leak the newer buffer now sitting in si->msg (which is
no longer referenced by anything)?

Would capturing msg = si->msg after unregister_netdev() returns (i.e.
once no further ndo callbacks can race) avoid both the double free
and the leak?
-- 
pw-bot: cr

