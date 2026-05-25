Return-Path: <netdev+bounces-291328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NiMEGdUFGp2MgcAu9opvQ
	(envelope-from <netdev+bounces-291328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:53:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A755CB614
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE43B3001FB9
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF8A384229;
	Mon, 25 May 2026 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rlEXQO0o"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D23845B3
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717217; cv=none; b=cZ1DzfvuFMoyu5CSmlaoh6tZ5bctzNlqjz/vMjLyJL1DAycuZnNGUokmVOPijeAFqmDVr6K9rPG1G49OhKwZBFIZz4P7rDD6m+hkglVGP9NlSP3i816/I9rWqjfgKmKWbMMz7LYhMkMJIkqlSg9wza3/GLs99F8SFGsQHkocu1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717217; c=relaxed/simple;
	bh=kkV++uKVZm7p3+IQDKtGfpSqDT5XyDknnuAx8eY8wtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trVziVJ0KV6SABE5c436FMh3X6j5Ayn2nPiB5zhaRisfDg0nxvFL9srepUCAprPG0ShXwqh3ZXsEsC0vMA5X6puC+KeTZmHt/bjkbH6UNufDK4H72Frsc8gvF6mOTb/K717Uq1wX0/RrXKwRMRVy0Z7u+jjY7VI/mNk3LZY59sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rlEXQO0o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1LYU8Wk8YjgmFsCB1ccS9Gtg4b9qZK+4tWsYlj8yLdU=; b=rlEXQO0oU8zE/6TeYSPtQSL2x5
	yt2mOAvAdifhfp2x8Uqwy27hG15/IUBtnVkUPXzjy4Tb9bLvIZzYAH6nZP95QEHM/R+vqopojD5US
	BVHPUQaLFXXqDgk47oHybGWNxykeM7S+2sYa0qge4srNNsiZ9PlhERKinRP+Yi3OnGDk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRVkL-004Tbf-Lr; Mon, 25 May 2026 15:53:33 +0200
Date: Mon, 25 May 2026 15:53:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/2] pcnet32: stop holding device spin lock
 during napi_complete_done
Message-ID: <01fd91eb-36c4-4585-bace-c1b6ec15c556@lunn.ch>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
 <20260525125437.4061-2-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525125437.4061-2-oscmaes92@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291328-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 45A755CB614
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 02:54:36PM +0200, Oscar Maes wrote:
> napi_complete_done may call gro_flush_normal (though not currently, as GRO
> is unsupported at the moment), which may result in packet TX. This will
> eventually result in calling pcnet32_start_xmit - resulting in a deadlock
> while trying to re-acquire the already locked spin lock.
> 
> It is safe to split the spinlock block into two, because the hardware
> registers are still protected from concurrent access, and the two blocks
> perform unrelated operations that don't need to happen atomically. The call
> to napi_complete_done does not require external locking.
> 
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

