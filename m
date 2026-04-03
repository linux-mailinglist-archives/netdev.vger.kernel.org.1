Return-Path: <netdev+bounces-274967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPtjA1SEz2mwwwYAu9opvQ
	(envelope-from <netdev+bounces-274967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:11:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DBF392A29
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88745300D0D8
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59522DE6F1;
	Fri,  3 Apr 2026 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s12bb9vb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8366F20DD51
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207503; cv=none; b=BEm4eLg6pJlveRKSWGgVZMTSwK+H0kmWLynFezoVgxmUVFA03LOG87yasHdxDR3H8zXLEParVry4rkA/yGInBLGBs4Qr48X+Ka2+RJUAl3bm6AfmaRfNzMg0qXnlLy082PWcK1o0wPDSc5QwZKw/+EjM+E+qaBISOrTBPxhvhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207503; c=relaxed/simple;
	bh=MmlIaJ9yGTrDk4ESaEPt7Z8bs3ConO2uqtUwszGU+PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKxtkNNMi85tQdpt8iFt27s4OSn5+OJiCHSWSNQeu9ZV6Vdx8KnsBIxZ/Lyffb6MJx/Ad7mHiyFwRcW0xulDQvH6lvMHiyTUnhuHV2BNXBnXL07kNkHykIcCZjtQ4BMNapE4W3PzUl2UZlXYjoYIDsjNjtW7i+VnoZzdvCAid78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s12bb9vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2C7C4CEF7;
	Fri,  3 Apr 2026 09:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775207503;
	bh=MmlIaJ9yGTrDk4ESaEPt7Z8bs3ConO2uqtUwszGU+PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s12bb9vbP27D3eJbosHTzPM+rbUdqvFaupKZwRdx+nfqwiNvPSyIcA6h6ufTn/aYS
	 6swWGMhyOzRBBvc6CwqSpA+sDZ9G2RBUF+mPnvViwoWnvTElg36YqhsRn1sD3B0uwY
	 UFJYTW/Kz9YlTSoC9YRUBjQhT+TvBEKW+Zo8eSh0GYQQvO98gWNuPfaKwmujQMJ/dl
	 i6IshMP9CZYu39WtOZjoRhKVUwS1B9gt2IM+F1JuYyfWHwHx8y0xrCTXt+N/t+486F
	 6SUctRg2xq+kWXs72KrcwcNHLEs3yVrL31bcYWMJHa6Bb3ovh9d90NijuAhI0ti2+5
	 onBGlf7YzDoJA==
Date: Fri, 3 Apr 2026 10:11:39 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] ice: fix locking around
 wait_event_interruptible_locked_irq
Message-ID: <20260403091139.GF11973@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-2-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274967-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: A6DBF392A29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:23:25AM +0100, Aleksandr Loktionov wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Commit 50327223a8bb ("ice: add lock to protect low latency interface")
> introduced a wait queue used to protect the low latency timer interface.
> The queue is used with the wait_event_interruptible_locked_irq macro, which
> unlocks the wait queue lock while sleeping. The irq variant uses
> spin_lock_irq and spin_unlock_irq to manage this. The wait queue lock was
> previously locked using spin_lock_irqsave. This difference in lock variants
> could lead to issues, since wait_event would unlock the wait queue and
> restore interrupts while sleeping.
> 
> The ice_read_phy_tstamp_ll_e810() function is ultimately called through
> ice_read_phy_tstamp, which is called from ice_ptp_process_tx_tstamp or
> ice_ptp_clear_unexpected_tx_ready. The former is called through the
> miscellaneous IRQ thread function, while the latter is called from the
> service task work queue thread. Neither of these functions has interrupts
> disabled, so use spin_lock_irq instead of spin_lock_irqsave.
> 
> Fixes: 50327223a8bb ("ice: add lock to protect low latency interface")
> Cc: stable@vger.kernel.org
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20250109181823.77f44c69@kernel.org/
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

