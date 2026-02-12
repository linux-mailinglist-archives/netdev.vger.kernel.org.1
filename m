Return-Path: <netdev+bounces-258477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCGdOacOjmmS+wAAu9opvQ
	(envelope-from <netdev+bounces-258477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 18:32:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F82112FF38
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 18:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D21BC30107B7
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1E1E9B3F;
	Thu, 12 Feb 2026 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDGMjv6e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C81C68F;
	Thu, 12 Feb 2026 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917540; cv=none; b=HzDveOhX4u8gtIVzUOBBMokxpOxdK4kicMlG7Kp1giFxQH2UMZX9tWrDcEZ0iqKt1JBfMaxfOB+l7kDh1CZL9vUdgBAyvI+wb4QwbCGKy4HCvDtiaDNiACLCKbkWKud/iI2sEdSQbahHvtIaPMAcfkAbswLddLlesw1asJmpdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917540; c=relaxed/simple;
	bh=Y4CkFwxGS3N1onfLJwZV1c+zX+9mhjuOXr+bLagGgZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP2xekWnaGFIuKvFSxR6aw6yY1hi0NW8iwHIzxg7zMUTw3e2LnyVfvhBtvJj8uFB+sOvG5KD/TxSZbR5WM/TnooXrWbyPU/+/muP6m4bf0kLIA204CPt5Ab/EaW+zj5oJRABzP1f1lUyiGH59RGfzyr94Tmhb0DRDCpK658rzwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDGMjv6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45387C4CEF7;
	Thu, 12 Feb 2026 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770917539;
	bh=Y4CkFwxGS3N1onfLJwZV1c+zX+9mhjuOXr+bLagGgZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDGMjv6eu5iAfOnPOKeN9sn6VbpnJtknbr+scxhsyWo9U2P22FAGnCsdhbTJvSqaN
	 k0ZhskbHyYEUPqeGTTS4WKKBp+gFWtRHDqd8HWMM59bBdjJMKHzmjPHodJ323q5fhW
	 vkOEnr8H4v5BctGuYAD0SU9Yjky9g3xgV9XqOpI7QKqYb8cLVSvoUYMwr5AeriedRR
	 YrsGl/EDF5izc/30Oq7CDJUbbGQKak9xNxzSVEJ8MaRyZ2Ima08Un4miw9EXNUiRe/
	 YR6CZufYCwd9q/+wtzew32Qme6+7cpS3ghBgYzOuersx7B4UtYBttzs8JTwp742B0k
	 QnHQAFKhPiLEw==
Date: Thu, 12 Feb 2026 17:32:15 +0000
From: Simon Horman <horms@kernel.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net, 3chas3@gmail.com,
	shaojijie@huawei.com, stable@kernel.org
Subject: Re: [PATCH net v4] atm: fore200e: fix use-after-free in tasklets
 during device removal
Message-ID: <aY4On7k7vSlq6Tp5@horms.kernel.org>
References: <20260210094537.9767-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210094537.9767-1-duoming@zju.edu.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258477-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,gmail.com,huawei.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,zju.edu.cn:email]
X-Rspamd-Queue-Id: 8F82112FF38
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 05:45:37PM +0800, Duoming Zhou wrote:
> When the PCA-200E or SBA-200E adapter is being detached, the fore200e
> is deallocated. However, the tx_tasklet or rx_tasklet may still be running
> or pending, leading to use-after-free bug when the already freed fore200e
> is accessed again in fore200e_tx_tasklet() or fore200e_rx_tasklet().
> 
> One of the race conditions can occur as follows:
> 
> CPU 0 (cleanup)           | CPU 1 (tasklet)
> fore200e_pca_remove_one() | fore200e_interrupt()
>   fore200e_shutdown()     |   tasklet_schedule()
>     kfree(fore200e)       | fore200e_tx_tasklet()
>                           |   fore200e-> // UAF
> 
> Fix this by ensuring tx_tasklet or rx_tasklet is properly canceled before
> the fore200e is released. Add tasklet_kill() in fore200e_shutdown() to
> synchronize with any pending or running tasklets. Moreover, since
> fore200e_reset() could prevent further interrupts or data transfers,
> the tasklet_kill() should be placed after fore200e_reset() to prevent
> the tasklet from being rescheduled in fore200e_interrupt(). Finally,
> it only needs to do tasklet_kill() when the fore200e state is greater
> than or equal to FORE200E_STATE_IRQ, since tasklets are uninitialized
> in earlier states. In a word, the tasklet_kill() should be placed in
> the FORE200E_STATE_IRQ branch within the switch...case structure.
> 
> This bug was identified through static analysis.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@kernel.org
> Suggested-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> Reviewed-by: Jijie Shao <shaojijie@huawei.com>
> ---
> Changes in v4:
>   - Do tasklet_kill() in "switch(fore200e->state)-case FORE200E_STATE_IRQ" branch.
>   - Make the commit messages clearer.

Reviewed-by: Simon Horman <horms@kernel.org>


