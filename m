Return-Path: <netdev+bounces-261332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DvgDGI/oGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:41:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FAD1A5D1A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 071A63011691
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFD93815DE;
	Thu, 26 Feb 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpjAezW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCDA374160;
	Thu, 26 Feb 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109660; cv=none; b=gTNTm3Yq6ivZGwzJK0WSdIEDmfdBz8Kp2hOZS3rulwO0H3ZeLYNOY7knE6B2Z45gNIZEljAkGEXQNVx0Vg+GFUE+uyCESyQAavAbKbrLxVGqJHLWdpAfJr/Hp7hMEaAF3jm1ijK+q8ngpL7HFCO7ZJRBPRyOc1CvzPYESrqZbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109660; c=relaxed/simple;
	bh=Dxof4QUXsFafsqqGFB2Bo3niMvMuWJaGywElknUwohQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA1CLFqTtsYAnFRwx8kuGW5hfYG3F+2DwZzHifvkAKSaB5GT9SxSe8HCJg/wywKS/uYLP++zQSLFaxRR+qCvSRKvHILwC6tI8jzIK8nu2L8YCXCzQomRlvNq/oLOQyAy3pRquPX3/GYg0UtYEcQb5oMpf9+laJh1qZ3pngTWpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpjAezW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A275AC116C6;
	Thu, 26 Feb 2026 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772109660;
	bh=Dxof4QUXsFafsqqGFB2Bo3niMvMuWJaGywElknUwohQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpjAezW2qivSliKKSQ1pWlTiqhHIh94dBX6jQq1vrF4V3U145FD4siB4yhBPT38W4
	 Fh+omotpD6q8IA89d7vJwp7AXRxQFkCopLesAmjosJRsRDssMzoUQqlOQltktjHF0b
	 Z23tQs4IaKVjBzB9cQ+leLMpbT4813IabGR5oKlJ4Nr8DRn6lxQuuvEpa0S6YYoSZ2
	 XymnsBF+bFLOnjChWRwe0U1xzzBRrClxq+478tVbKsm3Sl6VsWiTixwSKKb2RrPT6H
	 dJ7efy/zZ8sLANByYvc7fXLEfJt+d8AAps+j2JybUXjaYQGdzPGNq27DdDS1nmz+lL
	 BY4u+sYQgwUCg==
Date: Thu, 26 Feb 2026 12:40:56 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, Thomas.Lendacky@amd.com
Subject: Re: [PATCH net 1/2] amd-xgbe: fix sleep while atomic on
 suspend/resume
Message-ID: <aaA_WJaNG03dcAPB@horms.kernel.org>
References: <20260225110001.1000014-1-Raju.Rangoju@amd.com>
 <20260225110001.1000014-2-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225110001.1000014-2-Raju.Rangoju@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261332-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9FAD1A5D1A
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:30:00PM +0530, Raju Rangoju wrote:

...

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c

...

> @@ -453,7 +453,7 @@ static const struct pci_device_id xgbe_pci_table[] = {
>  };
>  MODULE_DEVICE_TABLE(pci, xgbe_pci_table);
>  
> -static SIMPLE_DEV_PM_OPS(xgbe_pci_pm_ops, xgbe_pci_suspend, xgbe_pci_resume);
> +DEFINE_SIMPLE_DEV_PM_OPS(xgbe_pci_pm_ops, xgbe_pci_suspend, xgbe_pci_resume);

Sorry for not noticing this before sending my previous email.

Sparse flags that xgbe_pci_pm_ops should (still) be static.

>  
>  static struct pci_driver xgbe_driver = {
>  	.name = XGBE_DRV_NAME,

...

