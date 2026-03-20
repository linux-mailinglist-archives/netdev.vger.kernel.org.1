Return-Path: <netdev+bounces-269838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UELPKl0EvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:25:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB592D72F0
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBA8530162BB
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ACE37266E;
	Fri, 20 Mar 2026 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRbuGfGL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155AE371053;
	Fri, 20 Mar 2026 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995098; cv=none; b=PJZgeIgq56kMygFRNLdJZOLzG/ufaPN7XShRALQtw7oW1iXGp7t1zGhkyNqbQfXgYTb9NGETWGo4X+GhKYctaimIhnNuArmuL8tDLv8onN7UlZ7Rn1TXW6YPlBRVsgz9Z3eFooK5BrhU3NKbQBFt8Fbtkduhm3ewK1McRKEVItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995098; c=relaxed/simple;
	bh=BOiFP4GTwK9KfyYOLBsLbrcHmaO46GyQ68oBX/hGBJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5WiyNl+Fe/DAK813FDVTlIPKzV/xSCYAPPbzfKvTIUKzQRL/CBeLgfGTdrVlzGsLYYlcbmH6rCuNd6kHGGrbBBxIxUWB8gl6QqVzzy6VezMBD0r/u2mX7D6+DRk773PrpH867F34rMiebQE1Uzx6aG7KdK5xkfQTQcAM7MohbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRbuGfGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFF9C4CEF7;
	Fri, 20 Mar 2026 08:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773995097;
	bh=BOiFP4GTwK9KfyYOLBsLbrcHmaO46GyQ68oBX/hGBJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRbuGfGLO9xOx3+Il1Qx7u4d32oe3BWur6zeJY4BJ6LTNMqn/wgWYXjSNfcRLQilg
	 oFHAOacmsbggrS3O5B6lGD24ssZrmu3OpxyZ/q83iPGdB2eW//oVH5L0IvR0kBceoq
	 A7CSbmr/4Mh/xpAQS/VqcB/j7fpzexZ628P8eZdwvgmfRdwqUqagnUKHZt6xPnMFol
	 RI/WY1JfoibBZltHsHQwIX6xeOLwiTq/lOjGzPXCslAQUawWp7xcU3qcPKdw1wyDxb
	 rz+qFkrCnHZ2jFfDI4C2pNp4h4R3UYxiAh+qfPTRu1AQkROr6AXyyzmUEmm7Ra/i61
	 M0dbbrzBcUMAw==
Date: Fri, 20 Mar 2026 08:24:53 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Anderson Nascimento <anderson@allelesecurity.com>,
	marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rxrpc: Fix keyring reference count leak in
 rxrpc_setsockopt()
Message-ID: <20260320082453.GY1753385@horms.kernel.org>
References: <20260319161004.GH1753385@horms.kernel.org>
 <20260313132327.409785-1-anderson@allelesecurity.com>
 <20260313132327.409785-2-anderson@allelesecurity.com>
 <172885.1773939353@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172885.1773939353@warthog.procyon.org.uk>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-269838-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 0EB592D72F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 04:55:53PM +0000, David Howells wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
> > > Fixes: 17926a7 ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
> > 
> > nit: Please use 12 (or more if needed to avoid a collision) bytes
> >      for the hash in Fixes tags.
> 
> I fixed this when I posted my collection of rxrpc patches, including this one.

Thanks David,

Sorry for not noticing that.

