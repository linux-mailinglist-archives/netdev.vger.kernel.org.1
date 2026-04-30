Return-Path: <netdev+bounces-282956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD3KDumM82md4wEAu9opvQ
	(envelope-from <netdev+bounces-282956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:10:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EDE4A6378
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC9DF30097E7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E1F413258;
	Thu, 30 Apr 2026 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kORl4kJS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01446346E5A;
	Thu, 30 Apr 2026 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568998; cv=none; b=rZkIozRLgLB+B0AaPnXtNtb8ZP1qmSJaZooGX0mz9ud4ljvH/cQ4PmN4Zhsci+4Z2bTWOb/IpaFIxf0JnQnlkiGaWfNDimEjQPR0bHv0b5OOslEmhLTqyX4fa4q0ilg5xPvSYDJbRywkO5nHef1zpOLYPHsZotiPeRZl+kF/qOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568998; c=relaxed/simple;
	bh=iQqCgFMI5z6iq1NiAFeIa69BDcAIBnEVEyxyv4ZzTW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHIpFvePlb0TYfk4cCnODx5u2oB0eW2bmpWUqOX/r1blejhkjqWV/iG58JXoNUnxxaYtIIX1PgSRQqqYe82RPK8HvbxbhQH2SqIOC+iqF7yki8+3c5jTdGNQy4dBCJOv8Cx4QvmEC8eN8vEd9YwTQ55zNthhusfWoZ/K1xOjL80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kORl4kJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28718C2BCB3;
	Thu, 30 Apr 2026 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777568997;
	bh=iQqCgFMI5z6iq1NiAFeIa69BDcAIBnEVEyxyv4ZzTW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kORl4kJSMh7G4oKwR529AGcpHSBoC8ZohAMCVm6NK4m/QcvXaqaDBivS7WPXfg8ib
	 2rHRDPrqDLBLDdAdnDAAjSup0CE5CPD4wslUUVVj6BsaaB4KHqNSmuyj1Fxp8gPIPB
	 G0WV6ulaRlsl2Ar8iv83hIGCLBwZSJcySd56ht5FK8hxVFvIOC0EXPz56oMN8i6CiZ
	 yFaXn9cLMSXO2X5E+r//EVFkCetRwnc915X8OyQzZnO9qlvcltm3yBldJQbOei3wGw
	 /Fc+hzYtl01MxBkSeBsw38xEs1BGjGYY5QdSwuJAATaez5GiAvakY47FTQaxQ8b2Ly
	 7x2HQqdTb3Xgg==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: 'Simon Horman' <horms@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 net] net: enetc: fix VSI mailbox timeout handling and DMA lifecycle
Date: Thu, 30 Apr 2026 18:09:22 +0100
Message-ID: <20260430170922.1729686-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429081930.3259824-1-wei.fang@nxp.com>
References: <20260429081930.3259824-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 86EDE4A6378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-282956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Subject: net: enetc: fix VSI mailbox timeout handling and DMA lifecycle

This commit attempts to fix a use-after-free issue in the VSI mailbox
send path by deferring the freeing of the DMA buffer if the hardware is
still processing the message. The DMA buffer information is stored in the
si structure and freed on the next send or when the driver is removed.

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c

[ ... ]

> @@ -259,6 +282,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
>  {
>  	struct enetc_si *si = pci_get_drvdata(pdev);
>  	struct enetc_ndev_priv *priv;
> +	struct enetc_msg_swbd msg;
>  
>  	priv = netdev_priv(si->ndev);
>  	unregister_netdev(si->ndev);
> @@ -270,7 +294,9 @@ static void enetc_vf_remove(struct pci_dev *pdev)
>  
>  	free_netdev(si->ndev);
>  
> +	msg = si->msg;
>  	enetc_pci_remove(pdev);
> +	enetc_msg_dma_free(&pdev->dev, &msg);

Is it possible for the mailbox to still be busy here?

The commit addresses the use-after-free in the send path by checking the
mailbox busy status before freeing the previous buffer. However, during
driver teardown, enetc_msg_dma_free() is called unconditionally.

If a prior message sent via enetc_msg_vsi_send() times out and the hardware
is still accessing the buffer, and then the driver is unbound, could this
cause the hardware to read from freed DMA memory?

Should the teardown path wait for the mailbox to become idle or ensure the
hardware is safely reset before freeing the buffer?

>  }

