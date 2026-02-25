Return-Path: <netdev+bounces-260731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFdgE69fnmmaUwQAu9opvQ
	(envelope-from <netdev+bounces-260731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:34:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEBF190EF7
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B22F30789C5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4369275AE8;
	Wed, 25 Feb 2026 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SajrUMH4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCB0228CA9;
	Wed, 25 Feb 2026 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986774; cv=none; b=r/F4C1fMf9tqhlnCXJwXDdQ5tShF8tuhVuaXOg2jZ0tnMfSUolQVI1/CA2foeVsGf0Xnl+wIM2cBiL7CrO06ZfLr5nhlA5XvSEPwii9GGUS4xlQ9/vhx8KY2GSVHQOVsPVa6jKke6TWPJjYHIm1Zig9fdOy1pjK2Fg/P7P+ENbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986774; c=relaxed/simple;
	bh=ibk16yeTZlaqlGBnC0WuhDja1zTjrU6fF717LH0KpRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRH7ZsXmYMIthEbx2w/tzec0xvDrFzkJD2oqRaGRlH/t6Fv4JNjxYE9qMY00HtSH3XJxUDyeua6E+9qlByRya+kWSihE6j9h6KfzFYnTdQXfbgw/BAzvUrAdtUD5AWMYPX0JhDlyvx+FNHmyAowh5+pbjK8xlSkaGWEgGeQNMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SajrUMH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023B1C116D0;
	Wed, 25 Feb 2026 02:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771986774;
	bh=ibk16yeTZlaqlGBnC0WuhDja1zTjrU6fF717LH0KpRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SajrUMH4rdtv695yz63D9f4cENf0m1MC7zo+JTjaSyy15p3ijdNg8QUOj/tLx0KTD
	 MCbDCoxXkF1e+xyLXp9XsdjBLy7mxjiL6YdtZhI9M9GO4B3Tjl6draLl0SyXi8jYlx
	 4THahWSThZCNreDGhoteRpepdWogx147UMVIheZJdVskevty9TX5WibvWQaieAoqmI
	 WqoYHYMK7NKUhnrFr86IUrUOHrJXjqt7RFxLF6KAwtRyS51+id91ewf8Vmw2VnYcBt
	 M6GU2v14VTpvhGO4LgBKboZzB8Y069rK39SEET6MlMM9JEKYnear9rk4MOg3uQt0cX
	 sHlWxO8wHlHDQ==
Date: Tue, 24 Feb 2026 18:32:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next 1/7] bng_en: add per-PF workqueue, timer, and
 slow-path task
Message-ID: <20260224183253.23143628@kernel.org>
In-Reply-To: <20260223163641.755200-2-bhargava.marreddy@broadcom.com>
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
	<20260223163641.755200-2-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260731-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CBEBF190EF7
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 22:06:35 +0530 Bhargava Marreddy wrote:
> +	if (atomic_read(&bn->intr_sem) != 0)
> +		goto bnge_restart_timer;
> +
> +	/* Periodic work added by later patches */
> +
> +bnge_restart_timer:
> +	mod_timer(&bn->timer, jiffies + bn->current_interval);

This intr_sem thing looks highly questionable.

It provides no synchronization guarantee since the state of intr_sem 
may change immediately after the read. Please use normal locking
primitives and/or cancel the timer _sync() if you want to make sure
it's not running.

