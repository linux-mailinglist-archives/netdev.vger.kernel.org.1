Return-Path: <netdev+bounces-284560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO19FNQ6+mlZLAMAu9opvQ
	(envelope-from <netdev+bounces-284560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:45:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C54D2D75
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDB63301DF45
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5123BED19;
	Tue,  5 May 2026 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8wYLQiV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAA17A300
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006737; cv=none; b=BxGl9JQFRmS2uUOYtryQKObJn2mViid2ReWR2vcvozgZJL+VbY+uMk3QoMdryNTij84nUpuhSV20t5Txpfkz6tge8ankNpfm0za34WjMNdciI0eTTt8GAJYH07B2IepEwtY5WF6WBEQms4Ef5MHuwLbVHxqltCO7YOzSzVsgBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006737; c=relaxed/simple;
	bh=FiE9g4LdhsjTLwLjI+wQr3lrszCZm4XG6YDCmtu2PXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qH18lC8WiZF/YS3yQTpvRyz7fTOo1UmqVuYXABx30Qy1P/F7Ih4WNdlQEIYlYphqx7Admyc72jAMVh/xVZaxEm/iBrGUZV1WjVlNhcKIYzXlydXNkXhUCH6NfPTy1kbD/o/79aQHqTk8eViHjaexbEcjspq6rrt1w+HFNnkulvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8wYLQiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48750C2BCB4;
	Tue,  5 May 2026 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778006737;
	bh=FiE9g4LdhsjTLwLjI+wQr3lrszCZm4XG6YDCmtu2PXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8wYLQiVOAkfGj+lV4OwRz0yZcC3JDPgTDjKQb9kdOwpifcQCtnSyzT4HjBXbG6jA
	 qFFil54rPi3WFFFdb6cNpSCS3lZvnBw53b5pSD2fu66dT7k2zeWe619rqGr1ODZqna
	 iRePZqkFwSXWHMOtK/dkE1Aj4p7AeMLd0BHdENrvCrdznKHRrlUAWtzt/+Y7SkPq9i
	 AJfampuOxjKtde20h0zrhIlv3aGiTHakh97oaUQBVF6BB3t5BaQtH+lMATmtBtuunD
	 z57KKmVixC0hzlAsRkbWQtiHHUPxkqBgDOS2yxVhbZyNETk+7DI/F1cUuMru+sCxsL
	 xw5CZzLV2e/pQ==
From: Simon Horman <horms@kernel.org>
To: eric.joyner@amd.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net] pds_core: Fix potential invalid stack memory access
Date: Tue,  5 May 2026 19:45:15 +0100
Message-ID: <20260505184515.573028-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501031944.52172-1-eric.joyner@amd.com>
References: <20260501031944.52172-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE2C54D2D75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284560-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
pds_core: Fix potential invalid stack memory access

This commit attempts to fix a potential stack corruption issue when an admin
queue command times out. It adds a spinlock around the timeout completion
check to prevent concurrent access by the timeout handler and the completion
handler.

> diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
> --- a/drivers/net/ethernet/amd/pds_core/adminq.c
> +++ b/drivers/net/ethernet/amd/pds_core/adminq.c
> @@ -283,9 +283,15 @@ int pdsc_adminq_post(struct pdsc *pdsc,
[ ... ]
>  		remaining = wait_for_completion_timeout(wc, poll_jiffies);
>  		if (remaining)
>  			break;
>  
>  		if (!pdsc_is_fw_running(pdsc)) {
[ ... ]
>  			err = -ENXIO;
>  			break;
>  		}
[ ... ]
>  	} while (time_before(jiffies, time_limit));
>  	time_done = jiffies;
[ ... ]
>  	/* Check the results and clear an un-completed timeout */
> -	if (time_after_eq(time_done, time_limit) && !completion_done(wc)) {
> -		err = -ETIMEDOUT;
> -		complete(wc);
> +	if (time_after_eq(time_done, time_limit)) {
> +		unsigned long irqflags;
> +
> +		spin_lock_irqsave(&pdsc->adminq_lock, irqflags);

Can an ABA race condition occur if the thread is preempted right before
acquiring the adminq_lock?

If the thread times out and is preempted just before spin_lock_irqsave(),
the hardware could complete the command, and a new thread might wrap the
admin queue, reusing the same slot. The new thread would call
reinit_completion(wc), resetting wc->done to 0.

When the preempted thread resumes, completion_done(wc) would evaluate to
false, causing it to erroneously complete the new command prematurely.

> +		if (!completion_done(wc)) {
> +			err = -ETIMEDOUT;
> +			complete(wc);
> +		}
> +		spin_unlock_irqrestore(&pdsc->adminq_lock, irqflags);
>  	}

Does this leave the stack memory corruption possible on the -ENXIO error
path?

If the wait loop breaks early because pdsc_is_fw_running() evaluates to false,
time_done may be less than time_limit. The code would bypass this newly added
locked block and return without calling complete(wc). Could the interrupt
handler later write to the destroyed stack variable comp?

Will successful commands that complete right near the timeout limit
incorrectly return -ETIMEDOUT?

If wait_for_completion_timeout() successfully acquires the completion, it
decrements wc->done to 0 and breaks. If jiffies has advanced past time_limit
due to thread preemption, completion_done(wc) will evaluate to false inside
this block because wc->done is 0.

This sets err to -ETIMEDOUT, which isn't cleared on success, triggering an
unintended device reset down the err_out path.

