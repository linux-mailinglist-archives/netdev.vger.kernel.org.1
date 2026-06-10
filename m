Return-Path: <netdev+bounces-297521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bafrN/0dKWrOQwMAu9opvQ
	(envelope-from <netdev+bounces-297521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:19:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6070A667111
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:19:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=toke.dk (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297521-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297521-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E081731557F6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34A03A5453;
	Wed, 10 Jun 2026 08:12:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13F3A4535;
	Wed, 10 Jun 2026 08:12:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079169; cv=none; b=JMQ4hX3JnjrGFDLVYhT/0lM7gOtR9TV1JmGtRT1UcSGMttagCZ2as7FGPR0Ek8B6MKc5wC/74UFPLt7vcu8lsuDBreyhH2xyLytL51IryHOPsyA4hOng+CxjhaBvymQ3KOkbEs1UjCgPN8JsyswOWc97GHQJXbnKVG+CrQxZOWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079169; c=relaxed/simple;
	bh=aK2q3BbWD03U5yexJGsk3sWQvKsJGRPzWsplh0nC1VU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AGfBFJugVIpSjd+8uFkGReFzmYD5zZLaeFR081SwFIH1gxmLLmIcT+uo+fCcCYctu5CIAWMtzWlnCmP0vrwuLO9OUVmwpfES90UUbsit1H/hHzX1oPsiCBWKtIrc2feqwhsryTVwRJEAuwBwBD0UGG2oZ4mW5wPTcsfoXvZprQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, "moderated list:CAKE QDISC"
 <cake@lists.bufferbloat.net>, "open list:TC subsystem"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net/sched: cake: reject overhead values that
 underflow length
In-Reply-To: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
References: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
Date: Wed, 10 Jun 2026 10:06:04 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877bo6akgj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.77 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[toke.dk : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:cake@lists.bufferbloat.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297521-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6070A667111

Samuel Moelius <sam.moelius@trailofbits.com> writes:

> CAKE accepts overhead values that can make adjusted packet length
> arithmetic underflow.  A negative effective length can wrap through
> unsigned arithmetic and become a large value.
>
> Such configurations make rate accounting depend on integer wraparound
> rather than on the packet size userspace intended to model.
>
> Validate overhead settings before using them in adjusted length
> calculations.
>
> Fixes: a729b7f0bd5b ("sch_cake: Add overhead compensation support to the =
rate shaper")
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

