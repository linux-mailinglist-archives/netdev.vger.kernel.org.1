Return-Path: <netdev+bounces-292471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAG6HGZ3F2ruFggAu9opvQ
	(envelope-from <netdev+bounces-292471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9197D5EAD1A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C19030350DD
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A833C4B78;
	Wed, 27 May 2026 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R92DX4Tp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DFF38A706;
	Wed, 27 May 2026 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922784; cv=none; b=YqDhRv+MR1g/t8N0IdziGyifACwxnQrvhk+v+1E/y+tV7ojbT3vjD8ddux9ByjKLX0+dQU9vF/8X8phk7TzT51BsLRHZ1qlHuWB7vcXs9f8zUu40Y7bP+0HAZAwaQOq4swR9dA3w0aCN3y48X9PmeYUUo7Sc852NQIlrL0RNlV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922784; c=relaxed/simple;
	bh=jBl149U1YBEelUdPE4SseXrjukSwwS/ZsHVHIZDCqqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjnbWD6wuptfRjjfeRmLRlV2L+ft90JyXc3FGDMHAaIOKNQcFW0MyZoGc38WZG6te3UXbCXGFFjjiXfFryokgm+yXRE3chZ96txqsu689C+Z086toInDe3lkpzxlKqbL2kyNG8muYGUJK7s9DlhIu0QgVvEeMyzm4EkkUwMGem4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R92DX4Tp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34231F000E9;
	Wed, 27 May 2026 22:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779922783;
	bh=CG0rbY0IhIbANwrwkt6q+zvR4Fexp1pSiAB7HWhdR10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R92DX4TpwIbnUShKaRWUIMM+6Emk4JMXeeQRNtp4F4E8p52LqaOQvFKDC6bukxOFg
	 0gjL3ZdT3hiumbXn9qD/GwlFdscUV1YBXsBLRQ2OXjg8pvwzAsBS+mcs8sNeo3i5lA
	 AQuej3rxZPFeDYznrz86AkVxW3L1YnikWgyvHxk+aOU3rHmJxZ6Sp2RM1C9+UP87Rb
	 nwsHgr1P4nTWoXgMaho6YbNyT2tWM7xVkVy6e4raNipKdt0fhImw+hJi2XzOld1qSl
	 BHytKBCsVEAoszjVdMnRjtAvGWB6EOTSoidy7TuT5Uq7Cr5wkFsZc8PlT4tcoxn+dy
	 ldb9Q2i9dFMsQ==
Date: Wed, 27 May 2026 15:59:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gustavold@gmail.com,
 asantostc@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 0/9] netconsole: stop charging every netpoll user for
 netconsole-only state
Message-ID: <20260527155942.45c43c8d@kernel.org>
In-Reply-To: <ahbvRJO-P2tgvmXj@gmail.com>
References: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
	<20260526190053.619cc53d@kernel.org>
	<ahazcZw0KRwu5hUR@gmail.com>
	<ahbvRJO-P2tgvmXj@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org,gmail.com,meta.com];
	TAGGED_FROM(0.00)[bounces-292471-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9197D5EAD1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 06:22:02 -0700 Breno Leitao wrote:
> I was reading Linus' Linux 7.1-rc5 email[1], and I am wondering if these
> type of "fixes" should go to net or are you planning to change it to net-next.
> 
> """
>    These things are "fixes", sure, but at the same time a lot of them
>    are simply so irrelevant that I think they'd be better off in
>    a linux-next tree and get merged during the merge window.
> """ --linus

Ack, we started pondering cases which are obviously not-net-worthy
but still WIP and also hard to say if all of the fixes you'll write 
would fall under it. So just prepare for net with Fixes tags and we'll
route the patches accordingly.

(some kind of "can't be triggered by an unprivileged user" would seem
like an obvious delineation but "can't be" implies we explore all the
possible options of triggering, maybe Mythos can think of something we
can't, and (b) "unprivileged" is not as strong as we'd like if we
have to assume that people are crazy enough to allow user netns :/)

