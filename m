Return-Path: <netdev+bounces-265882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D0YKyeKr2lvaAIAu9opvQ
	(envelope-from <netdev+bounces-265882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:04:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E9D244956
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9E583007ADE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC1E3A7855;
	Tue, 10 Mar 2026 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0r0GZVf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296473A1E9F;
	Tue, 10 Mar 2026 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111813; cv=none; b=gRGjpJjw6g8WX0AfNybNS9sHUrn3oVLhQOnAuAJQDOqE05OnzZv+da/AybZ3BOqOm6VOClD7cp0dNerOlytAUP8vMasaruFyGumGtDEXWQNaZ+jO1VW4Fg5VkplfxMx6A/HwKWaw6lRhjR9HvqJusiWAG9SCkPAMDQmCJ+mvDac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111813; c=relaxed/simple;
	bh=Ryahdl1cGdzDm3QLudO0LdvAuUSGlLo+YD2XEQzuC0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwPJgT7RK7yrUN+ZGQ+3tgp5TT1E+0RaEdwX+TXbbM+t6aWIOvB44EMv+dyWlsmWXX17RvKmgantulqhyBmU6jdEKXb51nhmXrKiUAZkBtrnv/dcoHv3b642x1ZmlAuNSCJ9IJ/5EXPvdfSW29DzWCoGWUISBbmvEbPrTXi6o90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0r0GZVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3210DC4CEF7;
	Tue, 10 Mar 2026 03:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111812;
	bh=Ryahdl1cGdzDm3QLudO0LdvAuUSGlLo+YD2XEQzuC0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b0r0GZVfXalCZplh0qwqFJrEpo+Qhie0qIJVvrsQhj1BJc/w28NBPqTz1spNpHHPp
	 +yqqk7lL3xuNuO2XtgA/UYHrBtF3OsYbVHCiBsoJCy0RT5s2kNPiO5O0LFyt92vUoX
	 c4soZKgD5rwtx8wxE0Qn61CBaU759ImLbo/6RA8KBoSGEDvdtLuZqpMU8V73rtOsXe
	 FL24JTmddu7VFRHNNhOjF426HlHlTlRtEnddxJmGAob3JNCaI3ssbzt2RjHE9qpWUq
	 krdHoWnMriOdaSMmSKxX1NUjsXDqKNej1cf+Z1C3QeyZJsk1TOnjxmLR/YE/gjzOrS
	 +Ht7asEifKClg==
Date: Mon, 9 Mar 2026 20:03:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next v4 01/10] bng_en: add per-PF workqueue, timer,
 and slow-path task
Message-ID: <20260309200331.31338dee@kernel.org>
In-Reply-To: <20260305200018.111728-2-bhargava.marreddy@broadcom.com>
References: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
	<20260305200018.111728-2-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A6E9D244956
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265882-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri,  6 Mar 2026 01:30:08 +0530 Bhargava Marreddy wrote:
> +static void bnge_sp_task(struct work_struct *work)
> +{
> +	struct bnge_net *bn = container_of(work, struct bnge_net, sp_task);
> +	struct bnge_dev *bd = bn->bd;
> +
> +	set_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
> +	/* Ensure sp_task state is visible before checking BNGE_STATE_OPEN */
> +	smp_mb__after_atomic();
> +	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
> +		clear_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
> +		return;
> +	}
> +
> +	/* Event handling work added by later patches */
> +
> +	/* Ensure all sp_task work is done before clearing the state */
> +	smp_mb__before_atomic();
> +	clear_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
> +}
> +
> +static bool bnge_drv_busy(struct bnge_net *bn)
> +{
> +	return test_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
> +}

> @@ -2542,6 +2584,12 @@ static void bnge_close_core(struct bnge_net *bn)
>  	bnge_tx_disable(bn);
>  
>  	clear_bit(BNGE_STATE_OPEN, &bd->state);
> +	/* Ensure BNGE_STATE_OPEN is cleared before checking drv_busy */
> +	smp_mb__after_atomic();
> +	while (bnge_drv_busy(bn))
> +		msleep(20);

AI code review points out that patch 2 will cause a deadlock.
This waits for the service task under the instance lock.
But service task will try to acquire that lock in patch 2.

I previously complained about flag-based-locking in the stats,
this is similarly problematic. Can we make the service task
take the instance lock across the entire function?
And check if OPEN is set under the instance lock?
-- 
pw-bot: cr

