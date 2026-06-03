Return-Path: <netdev+bounces-294879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rdHkHbtwIGoN3gAAu9opvQ
	(envelope-from <netdev+bounces-294879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:21:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4C063A82D
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:21:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UNmece+f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294879-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294879-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 699FB303E6CC
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435263CEBB8;
	Wed,  3 Jun 2026 18:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2737F8A5;
	Wed,  3 Jun 2026 18:20:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510838; cv=none; b=ebwjiHKZH3Dsq4FwnGFn52xITgWIgGt4l4YyTmvCzlk35hoKNK+FD/cdBduXj/Z4X4YMy6rBqC2KG5uYTSe8hu0YsJjKfvqMymA32AkI5tM0+zd3ST6I4mHOJEeCcTJmi1aB8uaQoRHpRKF5iS5EfzCbzv4FvOaaPUCYHuYEexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510838; c=relaxed/simple;
	bh=nL2y9yeTZPrmxLGYRiRqauwwXLu8r42gY21buXmJmhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIhyYWlxDk8WyGJHLKTpVnZU5bekovgYEi0ptzIsADeW0cbdH9EMYmpJimGlMNDE6HDLRD6vt6VdPSTe/FrOD7uKNAL5mdzWEZRt48u2J/1oLN5R4LzVWYHepc2GCK4KHHPDfe8mf1uWqcfgeadHFIQMnyD4b8JPskveNlIIe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNmece+f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AB01F00893;
	Wed,  3 Jun 2026 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780510836;
	bh=Vvijg2M3Z6HIbSN8SvUXc5OOMLKNy8vMuwtc8byuD3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UNmece+fw67f2PhC3+xNY42DQ7T2hdtkI/1Rci9wFA9go463XTFPA9pNqeTH6xorT
	 59jOJSrj4/iBjQCViSjQ5dVcz6szMCxdPIsarlICl31bnT/nEsChsms+S9Awusj5xS
	 sP8UafjPUukEwJsoKLufwyNkctRSHYJSpfiN9sd6RjtV8jVYpci+oU4g5vR1ZwzPsw
	 uhRDeR/VpEJ3R70dCVdLJU9BKYgjzrrnxbtPJyTHzGNVnumHo5eyXNzPD1YOO9UCVR
	 RgwGAB3sBV1Ip/HloxUtvkiKCoNBdF0MbifOw0USbQzEziZldikpd2Fn9kXZsUbpSo
	 tUtmWmE4KlwDQ==
Date: Wed, 3 Jun 2026 11:20:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 ecree.xilinx@gmail.com, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, baijiaju1990@gmail.com
Subject: Re: [PATCH] sfc: Use acquire/release for irq_soft_enabled
Message-ID: <20260603112035.0866d7d4@kernel.org>
In-Reply-To: <20260528092838.2099352-1-hanguidong02@gmail.com>
References: <20260528092838.2099352-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294879-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hanguidong02@gmail.com,m:netdev@vger.kernel.org,m:linux-net-drivers@amd.com,m:ecree.xilinx@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:baijiaju1990@gmail.com,m:ecreexilinx@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE4C063A82D

On Thu, 28 May 2026 17:28:38 +0800 Gui-Dong Han wrote:
> irq_soft_enabled is a lockless gate for interrupt handlers. When clear,
> handlers must only acknowledge interrupts and must not touch channel state.
> 
> Channel reallocation disables this gate, swaps and initializes channel
> pointers, frees old channels, and then enables the gate again. READ_ONCE()
> does not provide an acquire barrier, so an IRQ handler can observe the gate
> as enabled while still seeing stale channel pointers or channel state.
> 
> Use release stores when updating the gate and acquire loads in interrupt
> handlers before touching channels. Keep the existing smp_wmb() after gate
> updates, preserving the current ordering with event queue start and stop.

Why are you keeping the smp_wmb() tho? You don't have to repeat what
the patch does. The goal of the commit message is to explain the why.

Ed, WDYT?

Please don't repost this until someone from Solarflare/AMD comments.

> Add small helpers to document the ordering and avoid repeating barrier
> comments at every caller. Without the comments, checkpatch warns about
> memory barriers without comments.
-- 
pw-bot: cr

