Return-Path: <netdev+bounces-293267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI8nKyD9GWrx0QgAu9opvQ
	(envelope-from <netdev+bounces-293267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:54:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05324608B2C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C861C3007E3D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECE33B388A;
	Fri, 29 May 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6UNERM9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E3F42188B;
	Fri, 29 May 2026 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087880; cv=none; b=oq5OV/qZjFeJGg1D/jGAFWuX586Uxjz1FwZga6TTbaO6AgRedT6/L9oD+2xmZPQIaoGpg8AhPxDG/kcpcyA5EMAyyffuCw5V36zAxzzKO9vFwsDsxgFURhY7X9kWeE9x4OyjuXPgN4LToaCXa07FTAml7YNvZCoQDLNAOD+ClU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087880; c=relaxed/simple;
	bh=ULlSI87JIIL+Px4MIKA16erTR9w9JyJb5eGNoO/i0vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mj/3A0RBjapzyijSes0NifRxcXOQxrYTCw7/kJ4NSsoGLgXLhJ7alr6aUKkmXlfN9S4lMbBDiSkCY0nlf0AuLne1mCguqU5BG5IElAF+kQkuYzw20XlfUChHXIl8GOb7oGGxRRUz4CRazCQmfy1ioBOzksSDq1fcMo+6nGwUqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6UNERM9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD49D1F00893;
	Fri, 29 May 2026 20:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780087878;
	bh=SVNTxuS+DZCaGj3QZoytl1+/geEMlmZUksNj40oFI9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A6UNERM946RzocKVtHf1j1LYAW040XVKOwZEfEsT6l7sfSVdpg6XDM1TanHtUH8fF
	 maIN3KnrWm2LGGeiwKNdLaqvg0iCx4A38OxRud5CGDeV6/RnimC7LX0LYmjjkSzQXR
	 oQP1fnetw3vEoEUyKhTgrTVF0cqokOTDpEM4oe/1XgidWAER4mpccXkqFlrJUnO/RG
	 rBZdO9fHheXS8bSbDzJN+p/SWqq42gx+WOWuxAj41dbzyiRcJMXjk495hq4hI7T51R
	 qvJXRHL3dPOFBh00LxV/t1RVMEx+S7mWe1M+kJYBlRKhM3PypeLZX/L4dRXo9V/o2h
	 H4K5Aj8VZgcAA==
Date: Fri, 29 May 2026 13:51:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org,
 syzbot+819eb928d120d2bdad0e@syzkaller.appspotmail.com, Kuniyuki Iwashima
 <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: anycast: insert aca into global hash under
 idev->lock
Message-ID: <20260529135116.183e083e@kernel.org>
In-Reply-To: <20260529152219.235475-1-jiayuan.chen@linux.dev>
References: <20260529152219.235475-1-jiayuan.chen@linux.dev>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293267-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,819eb928d120d2bdad0e];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05324608B2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 23:22:18 +0800 Jiayuan Chen wrote:
> syzbot reported a splat [1]: a slab-use-after-free in
> ipv6_chk_acast_addr(), which walks the global inet6_acaddr_lst[] hash
> under RCU and dereferences a struct ifacaddr6 that has already been
> freed while still linked in the hash, so a later reader walks into a
> dangling node.

Please do not violate the 24h repost grace period on netdev.
We are tracking the violations now, if you keep doing this 
there will be consequences..

