Return-Path: <netdev+bounces-269532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F65OqoivGkptQIAu9opvQ
	(envelope-from <netdev+bounces-269532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:22:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8F62CEB27
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 635D732ABF29
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AF93BED33;
	Thu, 19 Mar 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPFiceKr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F138A292;
	Thu, 19 Mar 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936609; cv=none; b=gYhiDHxtU1DPpl9GOhf/mhGvh+VfJUoHCVVVKnkvGOe5fqAbghWNuHBy1r3LW4yFjc9s0hAlLeQmFYHAdjLtOjLeffJqUrNduuZGfZ3iGgLFyOpwQF+AVDlWV2IPpn+9f9XyuHh2j5vbo0KAE0eQomg5D6jP+bm0bsQTR8g0tRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936609; c=relaxed/simple;
	bh=ROqWzTgLOTGiqbYldN+//mg1TluitqoWvKYogKgCnck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptcvIxi9ZgGnYcr71lxBX4LBsdwRkTTeDH36HuWFFNo+WIrNNABmVJmfQMEWVp9246Lu3XkrQz7LYk4d9WkmNoIHgtbypv99z6k7ok/ud1+5j6o4JigRQBAwqC7uoLLtrdLdO6rH10pmrVtJf77oCm7AkKVx2tWlvuf/TB4+u7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPFiceKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC62C19424;
	Thu, 19 Mar 2026 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773936609;
	bh=ROqWzTgLOTGiqbYldN+//mg1TluitqoWvKYogKgCnck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPFiceKrgyXDvn2JPhw54AcmrcBEida3wdOJMhstIZSHPnbTBUGck1nduTxpxRVTY
	 N2SUmXs/XuhiCPcWG3O/v1swj8cknoZa5YwpZ8HfVb0qOKSz8UcVidZoikJbH9e7Fz
	 mG4+BSEJL+M7SNUJqdN5Nf1WWOCk8QOfkMbwrdsvEQRv0HQP0VGr+jcKFimD6/lrBG
	 zPB/azrPK4xHVElE2Cof7yUwNcEFxRH9hz+3E1bgCYiRFCJ31mVp+DlbeO1CCsbNqa
	 zayPUYXgDK6Bxy2JWznQ3kL+L9nQRmsfZUI4MD6UG0MI23VJwn8/VnuI0aJW8CYT5G
	 Gj97pifRab65A==
Date: Thu, 19 Mar 2026 16:10:04 +0000
From: Simon Horman <horms@kernel.org>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rxrpc: Fix keyring reference count leak in
 rxrpc_setsockopt()
Message-ID: <20260319161004.GH1753385@horms.kernel.org>
References: <20260313132327.409785-1-anderson@allelesecurity.com>
 <20260313132327.409785-2-anderson@allelesecurity.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313132327.409785-2-anderson@allelesecurity.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-269532-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E8F62CEB27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:23:26AM -0300, Anderson Nascimento wrote:
> In rxrpc_setsockopt(), the code checks 'rx->key' when handling the
> RXRPC_SECURITY_KEYRING option. However, this appears to be a logic error.
> The code should be checking 'rx->securities' to determine if a keyring
> has already been defined for the socket.
> 
> Currently, if a user calls setsockopt(RXRPC_SECURITY_KEYRING) multiple
> times on the same socket, the check 'if (rx->key)' fails to block
> subsequent calls because 'rx->key' has not been defined by the function.
> This results in a reference count leak on the keyring.
> 
> This patch changes the check to 'rx->securities' to correctly identify
> if the socket security keyring has already been configured, returning -EINVAL
> on subsequent attempts.
> 
> Before the patch:
> 
> It shows the keyring reference counter elevated.
> 
> $ cat /proc/keys | grep AFSkeys1
> 27aca8ae I--Q--- 24469721 perm 3f010000  1000  1000 keyring   AFSkeys1: empty
> $
> 
> After the patch:
> 
> The keyring reference counter remains stable and subsequent calls return an error:
> 
> $ ./poc
> setsockopt: Invalid argument
> $
> 
> Fixes: 17926a7 ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")

nit: Please use 12 (or more if needed to avoid a collision) bytes
     for the hash in Fixes tags.

> Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>

...

