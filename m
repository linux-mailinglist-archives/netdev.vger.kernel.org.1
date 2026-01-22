Return-Path: <netdev+bounces-252409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JUMJptBcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:26:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB868BE1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C506C3004606
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC50043CEC8;
	Thu, 22 Jan 2026 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQAGHHIM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B557D42EECA;
	Thu, 22 Jan 2026 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095317; cv=none; b=myCWCOf2nZnL9RQeEBS9L+1Sc/lNYPFoRaKGzGVN4yZsLRb2JuIKAUNB3J8+RYCOCPKc2vqseX/xObL4NULS9cD9Q/5A3NedrRkO925YYGwSohfkGxtm1Xgxu4sklFCKASyZ9xeSksZ4NYaDK5BztgLmM8djHYLrhMFOn44gqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095317; c=relaxed/simple;
	bh=fwpmgVUXri5YJxqIoDiQocbzg0KS4OrbIq1DkS/Is+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVVPXbpfDZGcVo/h+ejLqG7jRMvERK68Ge8jEJOkxwMZWoIc6TkUS+d8pQKnZm2VPEejphPD3E3cDNKS8sQ052vgWWfQOAjd50mjNq9ldk9cDv9hn8eQaGhn9SBGqAc8r94GkhIztyZtY10h0nRRrB+26oWhrh7NmBlDE6M4P0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQAGHHIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87A5C116C6;
	Thu, 22 Jan 2026 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769095317;
	bh=fwpmgVUXri5YJxqIoDiQocbzg0KS4OrbIq1DkS/Is+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tQAGHHIMzB9WcQE27vfzfIRbYqNlMQrlvWTTr+uKZloRwixX+DMO23zWMKPWvs4rT
	 CwFARhm21WmSrKMkOfPfI2JQtVA6hhWtQFQ+PrJxLCoxOu+/JM0Hk9DjV9cNYzTjf7
	 ZCP504UdDnfqpnV+gxuEIcHrwjBqSM2QAitJto5CTs11JAyKj+GFT5PpQ6xjOhTXtq
	 XLORuE6mNK63vtH3GTolDFHJ2Mhpr9x0BZ4ft+R/+/+7zsAZO8FjR2sFkgqIkzm7pO
	 Z5WHCOiSH8PL5482jxCfStGNPNEd6KGT9iwWdP4ZttsLcaUadpn5IG1DUx0jYlw//E
	 x7JJkLJ6C0qEA==
Date: Thu, 22 Jan 2026 07:21:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yangfl <mmyangfl@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net-next v6 1/3] net: dsa: yt921x: Fix MIB overflow
 wraparound routine
Message-ID: <20260122072155.127f0c78@kernel.org>
In-Reply-To: <CAAXyoMPfQnrYWX_5LPr=vODQcg1Nx1-=rk7+6SSHZ6EqpXH69g@mail.gmail.com>
References: <20260118013019.1078847-1-mmyangfl@gmail.com>
	<20260118013019.1078847-2-mmyangfl@gmail.com>
	<a5b78a79-8f8a-44d3-9a1e-1019ec57f910@redhat.com>
	<CAAXyoMPfQnrYWX_5LPr=vODQcg1Nx1-=rk7+6SSHZ6EqpXH69g@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-252409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,linaro.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EBB868BE1
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 21:19:29 +0800 Yangfl wrote:
> > Why targeting net-next here? the blamed commit is already in Linus'tree
> > and it looks like the above could causes functional issues, ad the wrong
> > value is written into the mib.
> >
> > I think this should go via net.
>
> There are following patches which are not fully suitable for net tree,
> and the issue does not block the main functionality, only gives wrong
> statistics.
> 
> Should the whole series be sent to net, or split into two parts?

Split into two parts please (and the second one posted after net is
merged back into net-next).

