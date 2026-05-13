Return-Path: <netdev+bounces-287697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBUzCim9BGrrNQIAu9opvQ
	(envelope-from <netdev+bounces-287697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:04:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 065135388C5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBE3B3013EE9
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C663A6B9C;
	Wed, 13 May 2026 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXckAa7x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985F3A4F5E;
	Wed, 13 May 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695427; cv=none; b=qxY5CiYOGrXORoDnjtWyv9CzEr5tDpUsHb3qK5JNnMZa1QDA0TpYKIZS4o3szlId4RbLH3lEncuoeS+1FJZC85MfHoqQu/ApqT5AELccb7jOOspW8oAscOhHRM/S1kylgPAPEbMhutUFtbkqo9k/JVin/FAIBLnDeJooEW3lIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695427; c=relaxed/simple;
	bh=E1Qno85xQ4a1LPVATc1U74DHXegqIcnYbC3QIApo++s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szVQtQmecIuDrzyoP9XNMo6wAsiOCu5l27wCRMOqnbII0O9cu7XpKxw/0tqWCB3qyoWaP3UZnkmDUG/1s61o4CgjLtSwsBpHoiYMmOUSmmyrcZxyIbgUhIwNjMsRvxX9Id++hDTZ45ORhZWC5SCDF6BrLAMIVBaWgOX2fgaPC60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXckAa7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67386C19425;
	Wed, 13 May 2026 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778695427;
	bh=E1Qno85xQ4a1LPVATc1U74DHXegqIcnYbC3QIApo++s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TXckAa7xYAUzWsuE0QKajSduKfUTlAKR0fSNKyhei6QCzYdfA2MfiMKrrMvqv9C3g
	 4K/575ZTer67HkpESMPGn+hgCF7uGVDoW7vnkNTsfRUXQN7A1JH7LzUA134d8x0BrT
	 2gU1h3bUhdkI0rEf7ZWtbnASmp34zB5VxOASJNl+1CBWbjdw6/oOWQvwZAJA//gm7e
	 B06txNkjN96u/vlDgRlEV9XnsLsw8x+EdMvYHjRSjSD0uMNFafXJB7go8n/6kOr0Vn
	 zxHQUi2CW0vH1erI2tVyw59yBGpyLgC4Rrrd6kugM8VepuoicaYO6/drsAt9QJQuWl
	 ljiXQihp3oB8g==
Date: Wed, 13 May 2026 11:03:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] netdevsim: psp: serialize psp stats writers
Message-ID: <20260513110346.35c8accf@kernel.org>
In-Reply-To: <20260513-fix-psp-stats-v1-3-cdb3174f252f@gmail.com>
References: <20260513-fix-psp-stats-v1-0-cdb3174f252f@gmail.com>
	<20260513-fix-psp-stats-v1-3-cdb3174f252f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 065135388C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287697-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Action: no action

On Wed, 13 May 2026 05:59:38 -0700 Daniel Zahka wrote:
> The u64_stats_* api requires mutual exclusion on writers. The simplest
> way to do this is just to add a spinlock to the writer path, rather
> than making the stats per queue.
> 
> Synchronization of the reader and writer paths use the
> u64_stats_update_begin() api and does not require any fixes.

The spin lock makes the use of u64_stats_t a bit pointless.
Let's switch to atomic_long instead?
-- 
pw-bot: cr

