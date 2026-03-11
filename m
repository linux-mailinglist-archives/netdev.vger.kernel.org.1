Return-Path: <netdev+bounces-266793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDwbL+jzsWl7HQAAu9opvQ
	(envelope-from <netdev+bounces-266793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:59:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE2926B057
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD6613045AB8
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A20239936A;
	Wed, 11 Mar 2026 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iPW66n68"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5706347BDC;
	Wed, 11 Mar 2026 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269990; cv=none; b=tCja23wYyyBDpi2wLiHJrmltzRZM22E6VnCTepxY/mRyHjU2uK63VvLaoGjlmyX3a4oCL7SWHtGqoAhAbgYhE4O9x3CTVsdQVZjx0Ku786bF9yRbHp0D2M7aKX/14nws6gsixWQm64cDTFQHqH1vUzvM08BGjQxEApXMYktGv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269990; c=relaxed/simple;
	bh=sy9Zwi13LYATgziwqUdxkmcUUvo4YWLt3PnTjZqv2kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOVVXvQhSxHbQkEN+LNMBaL4YuaufJa0zRNMcf0eUVc2AfZPJQ0xJzwgrkZVGjwN7zt5np6uclIw2hj3RJMPyyHHdhPgO1jNL+UnaNFyfuBFOnz2zaSCVH7x+7fGp/km+CRhYVuktfU2mkivEjR2oAG4sUYQigcmhFvZuu6vwP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=iPW66n68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D74BC4CEF7;
	Wed, 11 Mar 2026 22:59:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iPW66n68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1773269986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sy9Zwi13LYATgziwqUdxkmcUUvo4YWLt3PnTjZqv2kU=;
	b=iPW66n681C3YfmXx7ixB8/OrfAekPxh3on8GyzOtfLEK9ERUeqP97ANsFieKJuiggi0OL/
	ZEKhcnxAr1G3bDC2FMsLccPsa5EutyzUajshYbVVJSOx7yenan38j1p6QCncIIEzREpXtl
	shQs6PHduTQNOyGqfmHnGSQbbUzW9cM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6f2398e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 22:59:46 +0000 (UTC)
Date: Wed, 11 Mar 2026 23:59:43 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Valentin Spreckels <valentin@spreckels.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireguard] wireguard: prevent ipv6 addrconf via
 IFF_NO_ADDRCONF flag
Message-ID: <abHz3xcsLhIPc_Jn@zx2c4.com>
References: <20260208170545.31942-1-valentin@spreckels.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260208170545.31942-1-valentin@spreckels.dev>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266793-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zx2c4.com:dkim,zx2c4.com:mid]
X-Rspamd-Queue-Id: 0BE2926B057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Valentin,

On Sun, Feb 08, 2026 at 06:05:45PM +0100, Valentin Spreckels wrote:
> Use the flag introduced in commit 8a321cf7becc6 ("net: add
> IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
> instead of mangling the addr_gen_mode to prevent ipv6 addrconf.

Can you give some more context here? Why was IFF_NO_ADDRCONF added when
the IN6_ADDR_GEN_MODE_NONE method has been working fine? What's the
difference between these approaches? I don't doubt that your patch is
correct, but I would like to better understand this.

Jason

