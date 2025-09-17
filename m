Return-Path: <netdev+bounces-224144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D035CB81322
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857983BA0DF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD72FDC4E;
	Wed, 17 Sep 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O2vZxhxW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kFaUz3Fn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O2vZxhxW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kFaUz3Fn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937E1C84C0
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130553; cv=none; b=QPNPil+XgB3619aAynjRxvV7A9udSImKZ0xBkc4QW/M2zwXZqEFalcURtoyhykJg4PjlXrDOzPAQPYhNIDR4IVBFJ+LpnU2FAo7Qvkhf7N4ofXvU36GjcedO/mwbpMrZp4jbLxSfQalJ9ElZLbDyPjU9iHQ0PXj4HzjYxAYeyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130553; c=relaxed/simple;
	bh=UVL3gdf6NH6koXbnHiPxOPGIFPpXJn2O28tT0vMmw5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4PTjh5JoaQMvq7/3eP7L+IJaUVsxMgA6qKEJGNdhDOhMcKCZ6GR5v8dC1bdinxTDh+ZHMLneDk0naG2jku38mxJcY2pjJ0eCIoC6fKdUmElaP8+kHwO0sZleCauNj3YvEGjdYHZ0/sFn3d+wmU2UugaLefC8Rb1zWpoIpsGeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O2vZxhxW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kFaUz3Fn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O2vZxhxW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kFaUz3Fn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C32333FAF;
	Wed, 17 Sep 2025 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758130550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WNWcYltxo57Z7fXaHTD+/D3YFM25k7GHh6vZ4sWlNvE=;
	b=O2vZxhxW3wohiew34G5vm9/rDrUfmlbctdMFtNxH1Zk5msllHu73ZulGb8gftAeqAPzmv1
	kDrGrzzAzmayoaLHZDmHUlHPinMhZ3CCICblvx/05HpIO2yBMkHXvLD+sWCXaGO9Gyyu6P
	AOxjkEeC5FII32ti7Fw9xYirJRlE6A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758130550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WNWcYltxo57Z7fXaHTD+/D3YFM25k7GHh6vZ4sWlNvE=;
	b=kFaUz3Fnsbq30971T5YbAMe+Ef5KV6P9365xV3w7LEGqrUc7u5ms3AkkG/99V0ub1wfkGC
	wnnNbsqs52zy96AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758130550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WNWcYltxo57Z7fXaHTD+/D3YFM25k7GHh6vZ4sWlNvE=;
	b=O2vZxhxW3wohiew34G5vm9/rDrUfmlbctdMFtNxH1Zk5msllHu73ZulGb8gftAeqAPzmv1
	kDrGrzzAzmayoaLHZDmHUlHPinMhZ3CCICblvx/05HpIO2yBMkHXvLD+sWCXaGO9Gyyu6P
	AOxjkEeC5FII32ti7Fw9xYirJRlE6A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758130550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WNWcYltxo57Z7fXaHTD+/D3YFM25k7GHh6vZ4sWlNvE=;
	b=kFaUz3Fnsbq30971T5YbAMe+Ef5KV6P9365xV3w7LEGqrUc7u5ms3AkkG/99V0ub1wfkGC
	wnnNbsqs52zy96AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5D46137C3;
	Wed, 17 Sep 2025 17:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 32bwN3Xxymg6RQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 17 Sep 2025 17:35:49 +0000
Date: Wed, 17 Sep 2025 19:35:48 +0200
From: David Sterba <dsterba@suse.cz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dkirjanov@suse.de, kirjanov@gmail.com
Subject: Re: [PATCH net 1/2] Revert "eth: remove the DLink/Sundance (ST201)
 driver"
Message-ID: <20250917173548.GG5333@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250901210818.1025316-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901210818.1025316-1-kuba@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,suse.de,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.50

On Mon, Sep 01, 2025 at 02:08:17PM -0700, Jakub Kicinski wrote:
> This reverts commit 8401a108a63302a5a198c7075d857895ca624851.
> 
> I got a report from an (anonymous) Sundance user:
> 
>   Ethernet controller: Sundance Technology Inc / IC Plus Corp IC Plus IP100A Integrated 10/100 Ethernet MAC + PHY (rev 31)
> 
> Revert the driver back in. Make following changes:
>  - update Denis's email address in MAINTAINERS

> +SUNDANCE NETWORK DRIVER
> +M:	Denis Kirjanov <dkirjanov@suse.de>

FWIW this email address does not exist anymore, you may want to replace
it with kirjanov@gmail.com (found in archives and added to CC).

> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/ethernet/dlink/sundance.c

