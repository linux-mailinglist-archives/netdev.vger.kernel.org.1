Return-Path: <netdev+bounces-258340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RDbICn/OjGnbtQAAu9opvQ
	(envelope-from <netdev+bounces-258340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:46:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B11126E9F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F1A43016931
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F16334C11;
	Wed, 11 Feb 2026 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUhi6ckZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9A1E1DE5;
	Wed, 11 Feb 2026 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770835578; cv=none; b=INV/X5DBHRz8IZN9bZ2R/wMq80aQoeaHssnf3a3yM6j2Ri5IYTPmtpgN8jaNJlogRQ0YurUrlIadyKwSRGsdBhcmzvdBd+4Kiyi0w63zIbivjrmENNpuZf8Lrt/dHN1ynj432wldMj3+VHId6IM6u1itoPiQwOst10H7hJZFC3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770835578; c=relaxed/simple;
	bh=CzFkENtP/0obbBgpxP+XYcbT1750L/IPE4Cj47MMsi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMj0Qrvsh76P0emTc3auIljbBznFs5U/cNVaWpaxxJxgGnXLLWD3u3+NMfF2hKLrImOqK0pJBdLargBqcMryJj6YjQqJCHZcsrNtyQsVWgftCal58rLr1tRgIvo3FJi9Q0YlfGf08itYnSTOCgpau2II5c4t2LXBQgDlpqHYKoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUhi6ckZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21128C4CEF7;
	Wed, 11 Feb 2026 18:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770835577;
	bh=CzFkENtP/0obbBgpxP+XYcbT1750L/IPE4Cj47MMsi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nUhi6ckZ6R9T+YHWWMGhVg5ypLCy1qnR4wZUXQ+KRbkLihmKND8GXZdBTEFBW/40F
	 +Xf2VOkWjIv1rVwv4z/GqjrHjcMda1aRL+SZPxAXcRSTV4v53O/Ci9/cvdhmfM8qIT
	 MwK9ZFSON823vyc9bKcEf1zqPsHpF11Vciwt1asq1sZ4uI8rJAS9T7+S2KxXsjPiEv
	 +1ir4z9kF4LE79M2PmtM0GIDZgug4IcV2TxMMhNYz413AOJyv5MVXAD468kub2NVMD
	 TrAdHZlKgFQ9W6uJRpgU8BQcelBdMqXgw7b1h+8l7+WOx2obejN4rojmB4bJWb0Iae
	 ACIr7olg5o+SQ==
Date: Wed, 11 Feb 2026 10:46:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: kernel-team@meta.com, alexander.duyck@gmail.com, lee@trager.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jacob.e.keller@intel.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbnic: close fw_log race between users and teardown
Message-ID: <20260211104600.5fbc5369@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20260211150022.527956-1-dg573847474@gmail.com>
References: <20260211150022.527956-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258340-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[meta.com,gmail.com,trager.us,davemloft.net,google.com,redhat.com,intel.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77B11126E9F
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 15:00:22 +0000 Chengfeng Ye wrote:
> Fixes a theoretical race on fw_log between the teardown path and fw_log
> write functions.
> 
> fw_log is written inside fbnic_fw_log_write() and can be reached from
> the mailbox handler fbnic_fw_msix_intr(), but fw_log is freed before
> IRQ/MBX teardown during cleanup, resulting in a potential data race of
> dereferencing a freed/null variable.
> 
> Possible Interleaving scenario:
>   CPU0: fbnic_fw_log_write()
>           if (fbnic_fw_log_ready())   // true
>           ... preempt ...
>   CPU1: fbnic_fw_log_free()
>           vfree(log->data_start);
>           log->data_start = NULL;
>   CPU0: continues, walks log->entries or writes to log->data_start

Could you be more specific about the entry points for CPU0 and CPU1?

> The initialization also has an incorrect order problem, as the fw_log
> is currently allocated after MBX setup during initialization.
> Fix the problems by adjusting the synchronization order to put
> initialization in place before the mailbox is enabled, and not cleared
> until after the mailbox has been disabled.

Since this is a fix please add a Fixes tag pointing to where the buggy
code was added.
-- 
pw-bot: cr

