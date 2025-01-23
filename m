Return-Path: <netdev+bounces-160537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C22A1A1A0
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B793916D4D1
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE23B20D518;
	Thu, 23 Jan 2025 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0AAFCkN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RBVlao7l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0AAFCkN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RBVlao7l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDF20DD6E
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627177; cv=none; b=WKncA70PeyF2GsEZfYBuk3Q0JCRn+C4G2ErHfzm/JaEtCyKvPH8yhiEREwz8i2pxBIasyAWaGG/F0ahunz30LHLyId10+ZDfPcXy4X7/YSt0n1eXsDeGxTTXxsNyQG2A3E8lXBgKYtOXWytbsIwhnlawQka39oyzV3i65dj12Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627177; c=relaxed/simple;
	bh=I6rf9giTZO3kfxTCPdEnRjNqmtjaKjDotSCb44MUkwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR0fNO5+IViCyMv+710OSfnDqZku3ibBspxoz4XV1RHViUlyFXkHhXWZCoYoCjDXCgSyPmqS1dRFyKkDMF6gQp3Mcz37ZXmU2rw1ESvZv1bajGe/q+9ZRr2c/FYeYCbWPD8PW4gKbjIkWmQX4Bk3Deoc4IXyD4qSZgqRDNC9fcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z0AAFCkN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RBVlao7l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z0AAFCkN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RBVlao7l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C300821171;
	Thu, 23 Jan 2025 10:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737627173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N170I7lgUZQ68GTH4ZhH6kfBFdXMRTRlxoBDyF4kzPY=;
	b=Z0AAFCkNGxhq7AF3upn0fQ8oxqSWbXHqRUJJE9PCSS5pxoVE1RO4hNk9tQnxwwYQSiuC0Q
	VGYty+9nOofi7xodKkNDV26Z36E92sYJ91nUY1huUnB/090b0i3HMabk2v29LiqnE4Y9U3
	x4pvuV1QO8ph80Jus+lZfmSglxBdo24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737627173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N170I7lgUZQ68GTH4ZhH6kfBFdXMRTRlxoBDyF4kzPY=;
	b=RBVlao7lIslVaG5dFEgfKqP/JLCB6O3RjTX/q3ObO0oJxAgwDoZcdTTEgyw1PTJdXtrTj2
	D23rL3HKhf09bIAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737627173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N170I7lgUZQ68GTH4ZhH6kfBFdXMRTRlxoBDyF4kzPY=;
	b=Z0AAFCkNGxhq7AF3upn0fQ8oxqSWbXHqRUJJE9PCSS5pxoVE1RO4hNk9tQnxwwYQSiuC0Q
	VGYty+9nOofi7xodKkNDV26Z36E92sYJ91nUY1huUnB/090b0i3HMabk2v29LiqnE4Y9U3
	x4pvuV1QO8ph80Jus+lZfmSglxBdo24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737627173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N170I7lgUZQ68GTH4ZhH6kfBFdXMRTRlxoBDyF4kzPY=;
	b=RBVlao7lIslVaG5dFEgfKqP/JLCB6O3RjTX/q3ObO0oJxAgwDoZcdTTEgyw1PTJdXtrTj2
	D23rL3HKhf09bIAw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id B08F320056; Thu, 23 Jan 2025 11:12:53 +0100 (CET)
Date: Thu, 23 Jan 2025 11:12:53 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Michael Edwards <mkedwards@meta.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ethtool: Fix JSON output for IRQ coalescing
Message-ID: <uaf5yxosya37pt4h4zkygnilk25cidzlj33hbfmbtqete5dywi@jsg4npkqti7c>
References: <20250121181732.4f74b6a6@kernel.org>
 <20250122181153.2563289-1-mkedwards@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122181153.2563289-1-mkedwards@meta.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Jan 22, 2025 at 09:40:15AM -0800, Michael Edwards wrote:
> Currently, for a NIC that supports CQE mode settings, the output of
> ethtool --json -c eth0 looks like this:
> 
> [ {
>         "ifname": "eth0",
>         "rx": false,
>         "tx": false,
>         "rx-usecs": 33,
>         "rx-frames": 88,
>         "tx-usecs": 158,
>         "tx-frames": 128,
>         "rx": true,
>         "tx": false
>     } ]
> 
> This diff will change the first rx/tx pair to adaptive-{rx|tx} and
> the second pair to cqe-mode-{rx|tx} to match the keys used to set
> the corresponding settings.
> 
> Fixes: 7e5c1ddbe67d ("pause: add --json support")
> Fixes: ecfb7302cfe6 ("netlink: settings: add netlink support for coalesce cqe mode parameter")
> Signed-off-by: Michael Edwards <mkedwards@meta.com>
> ---

Good catch. I guess I should find some JSON linting tool to run on new
or modified JSON output that would catch issues like this.

Michal

