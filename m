Return-Path: <netdev+bounces-283658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CgZMIef92kwjwIAu9opvQ
	(envelope-from <netdev+bounces-283658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:18:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9E64B7168
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B91F30062EF
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADC033F59A;
	Sun,  3 May 2026 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WfpOGw+8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826EB1519B4;
	Sun,  3 May 2026 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777835906; cv=none; b=dfCtFE6rIfcLmMnyvotKQzRF73yo2ui6JEltuNEvklG1INQrXZu9ELHJLuP1M0HqQZ5TE0ZaO5AiRHgdrDmjIjgir9mnCuzHfjL9RJowsh77H/+7F0CdgDygPvbUXdQ3d5SyRpO0qgc1vNyumwvmarpiJyi9ThE7KCiTM7g8fEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777835906; c=relaxed/simple;
	bh=ePcpXM5/Zdl03afA48w5tWP6f5yL4+QENjD7b1gbXdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loTbkfiia4dzNwocoqqUgo7wvXJ58L+/epJpmCG44CAcqxKwtysaItug0GB1MBrdxJtt8dY6/ZNXlkX1KnCPWUr6XS1+l7HOi2rua5xSXGyuYdM0NsKdF1zsZl3SZd2RcJDPv9226uhdYMUq3D9yrkq2eOp1BNNLhXXjkfy6tE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=WfpOGw+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1967C2BCB4;
	Sun,  3 May 2026 19:18:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WfpOGw+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1777835903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvbCPF33TR3vMOeCZdDKdWWTrx7EGQFu5M3mI1ro1aU=;
	b=WfpOGw+8pFVtoMGIxVQizVs4Jv4NDANcfdhQf+tP4fqjMOfDXFGntaoDcQpGGLBbN8cjJQ
	baTbK1KBcs1E+IZqqMe3t3xZiJYDPcgpsCdp7PZYhTNQ764q1DlBSLmINL8j+FwHwQjeTk
	PBq49vKXxvxGoNM1PMLRWTEOWABilLE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7a0af592 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 3 May 2026 19:18:22 +0000 (UTC)
Date: Sun, 3 May 2026 21:18:18 +0200
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
Message-ID: <afefejiY8SX8UfTm@zx2c4.com>
References: <20260208170545.31942-1-valentin@spreckels.dev>
 <abHz3xcsLhIPc_Jn@zx2c4.com>
 <c486b63c-521f-4972-80bf-ebb2bfe04724@spreckels.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c486b63c-521f-4972-80bf-ebb2bfe04724@spreckels.dev>
X-Rspamd-Queue-Id: 1F9E64B7168
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283658-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zx2c4.com:url,zx2c4.com:dkim,zx2c4.com:mid]

On Sat, Mar 21, 2026 at 08:20:53PM +0100, Valentin Spreckels wrote:
> Hi Jason,
> 
> On 11/03/2026 23:59, Jason A. Donenfeld wrote:
> > Hi Valentin,
> > 
> > On Sun, Feb 08, 2026 at 06:05:45PM +0100, Valentin Spreckels wrote:
> >> Use the flag introduced in commit 8a321cf7becc6 ("net: add
> >> IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
> >> instead of mangling the addr_gen_mode to prevent ipv6 addrconf.
> > 
> > Can you give some more context here? Why was IFF_NO_ADDRCONF added when
> > the IN6_ADDR_GEN_MODE_NONE method has been working fine? What's the
> > difference between these approaches? I don't doubt that your patch is
> > correct, but I would like to better understand this.
> 
> Only wireguard configures addr_gen_mode inside the kernel, otherwise it 
> is only set by userspace; userspace is also able to overwrite the 
> IFF_NO_ADDRCONF set by wireguard.
> 
> Commit 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to 
> prevent ipv6 addrconf") introduces the private interface flag 
> IFF_NO_ADDRCONF, which isn't accessible by userspace.
> 
> Thus use the IFF_NO_ADDRCONF flag in wireguard.
> 
> 
> Does that answer your questions? If yes, I will submit a v2 with this as 
> commit message.

I applied this here:
https://git.zx2c4.com/wireguard-linux/commit/?id=88427bcbe5bd3711de387b1c1f6540ef6fc05a78

Sorry for the delay! Patch looks good as-is, once I looked into the
internal mechanism.

Jason

