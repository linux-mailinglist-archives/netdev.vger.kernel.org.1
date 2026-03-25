Return-Path: <netdev+bounces-271675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNoWAeUdxGmZwgQAu9opvQ
	(envelope-from <netdev+bounces-271675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:39:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B0329FC0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26BA130E26C1
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7420C3FBEA6;
	Wed, 25 Mar 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsXoMyI6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC972236F2;
	Wed, 25 Mar 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460004; cv=none; b=ZsokkrzK2PF2l7+FQIPDa4V94L9mWRl98Dslx9yd41f47spYbe5aSnoQkDylEGvCawceEoL/OF6Sdp9Z/uwBxvBy7Ws1Rdpv1aQZkOQFT1n3fgKOdHockj0tZ+ekma9aKJ3pvVOLQp9L+1Q9Cr8u5l/M2SkF1kUmOQyR+qATgGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460004; c=relaxed/simple;
	bh=zF0jSh3nubUZ/7rfSvD8Rmt1PxljKjDQ4076reQDN7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spQkiJ28EXYtde/A8nePPNbFkweE/VUxmq2VbIEpoSy3uQBwEbEj+pIEaedhMSaCQgXTHBPCC2HgvImNeYM9MfdfXBv+gT9SWuq251Z5uhgSzIOi937QbWnw/LsqIGcKAJEk5nuvQoRZarYramoaXnSfCQsGk0Pd1YTuK1QugyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsXoMyI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1231EC4CEF7;
	Wed, 25 Mar 2026 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774460003;
	bh=zF0jSh3nubUZ/7rfSvD8Rmt1PxljKjDQ4076reQDN7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsXoMyI6cdoBzr/UkALnPvv1gXRdY5jJWYCJkC2BuoQpTtnZfQwEiNTGvwAgVb+7X
	 +AX76taR4TKsY3aelqwnQj/5CJBYe+QDgLRRIguRneB+hB90ywmyVrT8C5f/cvBgsL
	 nGsIvhIR03TWqdcFAY+l2qr/IwEpdDjFBkHPn2mdWxBuQ0gQchAdjOJ85xwthrrH0A
	 RueOLk+toyeFmpsII2InV018J+H60CE7fGg9sROTRPvDmCkKxu/2C+OQy+5pG+ZvgQ
	 cTusddP0LIMSTRK1Icqj9VoJXXDjGYJqFM9K5ysbQEoopRAYRVeiMSqKFzdK8gxiKf
	 sDzpG88akUwkA==
Date: Wed, 25 Mar 2026 17:33:18 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	Frank.Li@nxp.com, saikrishnag@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v5 RESEND net 0/3] net: enetc: safely reinitialize TX BD
 ring when it has unsent frames
Message-ID: <20260325173318.GJ111839@horms.kernel.org>
References: <20260324062121.2745033-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324062121.2745033-1-wei.fang@nxp.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271675-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 709B0329FC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 02:21:18PM +0800, Wei Fang wrote:
> Currently the driver does not reset the producer index register (PIR) and
> consumer index register (CIR) when initializing a TX BD ring. The driver
> only reads the PIR and CIR and initializes the software indexes. If the
> TX BD ring is reinitialized when it still contains unsent frames, its PIR
> and CIR will not be equal after the reinitialization. However, the BDs
> between CIR and PIR have been freed and become invalid and this can lead
> to a hardware malfunction, causing the TX BD ring will not work properly.
> 
> Since the PIR and CIR are sofeware-configurable on ENETC v4. Therefore,
> the driver must reset them if they are not equal when reinitializing
> the TX BD ring.
> 
> However, resetting the PIR and CIR alone is insufficient, it cannot
> completely solve the problem. When a link-down event occurs while the TX
> BD ring is transmitting frames, subsequent reinitialization of the TX BD
> ring may cause it to malfunction. Because enetc4_pl_mac_link_down() only
> clears PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It
> doesn't set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, it is
> not safe to reinitialize the TX BD ring at this point.
> 
> To safely reinitialize the TX BD ring after a link-down event, we checked
> with the NETC IP team, a proper Ethernet MAC graceful stop is necessary.
> Therefore, add the Ethernet MAC graceful stop to the link-down event
> handler enetc4_pl_mac_link_down(). Note that this patch set is not
> applicable to ENETC v1 (LS1028A).
> 
> ---
> v5 link: https://lore.kernel.org/netdev/20260313094644.1132411-1-wei.fang@nxp.com/
> v5:
> 1. Add patch 3
> 2. Correct the typo in commit message of patch 1
> v4 link: https://lore.kernel.org/imx/20260312095415.669128-1-wei.fang@nxp.com/
> v4:
> Correct the offset of ENETC4_PSR
> v3 link: https://lore.kernel.org/imx/20260311084105.3982037-1-wei.fang@nxp.com/
> v3:
> 1. Split the v2 patch into two parts
> 2. Update the comments regarding PIR and CIR in enetc_setup_txbdr()
> 3. Use read_poll_timeout() instead of the while loop
> v2 link: https://lore.kernel.org/imx/20260309030412.2716984-1-wei.fang@nxp.com/
> v2:
> 1. Remove unused register macros (ENETC_SISR and SISR_TX_BUSY)
> 2. Remove spurious semicolon from enetc4_mac_wait_rx_empty()

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>


