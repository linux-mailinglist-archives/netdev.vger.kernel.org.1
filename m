Return-Path: <netdev+bounces-273864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OZDF/KJzGlXTgYAu9opvQ
	(envelope-from <netdev+bounces-273864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:58:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE62374153
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFF6F30C3E6D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A1E34846D;
	Wed,  1 Apr 2026 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geYMprZb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB035B138
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012073; cv=none; b=DrFAGoxFnPpLO+oC3IpC0uVMfaYah+iIUVjXQcHgxyJ86jM+9wQG42rrxghng8PGtXPfxJUDCTwipj8KV8X07p4POWSLeQcFXcmOi0TKDJGrGDHo9y6jtRuTOIt3n7x8ZBzO0zd6GgWWEhtCRjsQQFEZF9Anqai3OnEpOfRQ3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012073; c=relaxed/simple;
	bh=Hzzyg+MXut1u5if8nMcqVf0bkOOvSumZDWV9QzMJ9vA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3EFdzPz7VGccxfciNvmb+1GBBAVf0KADitVpDxU6knFgaViu1r2JoXAs8cxiO8Zjzb+rJMomvJDO3qEMvSWsm7LBKdV8XseSYOSdMkDuIBtjTBG1m9ADB1NOsMiLBv/9AJgRDG8AWcSnShPBeWOtyWZMqWMwtWiiiLqLmQcRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geYMprZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B04C19423;
	Wed,  1 Apr 2026 02:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775012072;
	bh=Hzzyg+MXut1u5if8nMcqVf0bkOOvSumZDWV9QzMJ9vA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=geYMprZbzkw3aFYFTYvfkJpLmWHwFwF7C02wsF9PskSeSX8BopYkarfcoZRIZ1jb5
	 5BcpfNcfzSXqPkVYtia08r9Hj5SdQFsEqoyLv7Fl12KaHDiP6NAb42P+M5g5OXCleM
	 egW1vtTtq9+Fl6JNIvq1ZBXReB+DQV9v8ZWR5WsbhTTMRmcvA4BrrvM+Wc1hHycgk0
	 ia3YpHRcyfDnMsNx2AR2WO1zAwX/OJVxqpFFoXFl8lBzOP8UhwwMF74EF4Ihv+lUoW
	 PJVvYtzq4WlX7u40lvaa0UMiwaBJZ7WOvp0ed+BF65rYYNFre46iAPdp8F6bC/CRDF
	 RmIyeb/f7Ndfw==
Date: Tue, 31 Mar 2026 19:54:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: macb: Factor out the handling of
 non-hot IRQ events into a separate function
Message-ID: <20260331195431.7965c24a@kernel.org>
In-Reply-To: <20260328-macb-irq-v1-3-7b3e622fb46c@gmail.com>
References: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
	<20260328-macb-irq-v1-3-7b3e622fb46c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273864-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EE62374153
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 18:17:47 +0800 Kevin Hao wrote:
>  	struct macb_queue *queue = dev_id;
>  	struct macb *bp = queue->bp;
>  	struct net_device *dev = bp->dev;
> -	u32 status, ctrl;
> +	u32 status;
>  	bool isr_clear;

nit: please try to keep the variable declaration lines sorted longest to
shortest

