Return-Path: <netdev+bounces-294338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F4KxEkIiH2ojhwAAu9opvQ
	(envelope-from <netdev+bounces-294338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:34:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F8631229
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:34:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SCa4gLfD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294338-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294338-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F24BA3003838
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84A0396D29;
	Tue,  2 Jun 2026 18:34:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71095368D48
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:34:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425276; cv=none; b=AWVpexqGI6YbVUhZUSFB5KadxJ91oIZqEvSkuY1wwdqJFYwEyWOjLfu5N1RyHnApB5U69ezbRYy/I/bHA8x/7cGOMoN2JN5PIjkBUN/SFP9i+Zm4+DjbB5OfRYwnQ2YuvHgVPZdxPywLXilPb2dCrCFL9kxW8uoPkeAZDZ2mzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425276; c=relaxed/simple;
	bh=FMFohVegby0EGmIa4LDMenBHl6w24dHK/77N6pNKziU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYXOmWn4Bq7emUyDLLSc0hWxTQfs5b7W6EdKhxycocd0rehKlVy4Rdcm3KzqwHby1Gk3pY4GV57dTZhRbUJv5nFKtmqSjke6Fve2ry1+BpRIOWw0gFV3tPVDespiQKTzddWUBCXIB18cHB3VU2nGJX27qPRAkOIMDdV75lNaBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCa4gLfD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D968B1F00893;
	Tue,  2 Jun 2026 18:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780425275;
	bh=FMFohVegby0EGmIa4LDMenBHl6w24dHK/77N6pNKziU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SCa4gLfDiH81yA+T7Jmj4LwuBGAayK4TikRg8pu1Aji7RL4JqxL95mWRU5hkaDvau
	 CjoEwUuOeXzXzrboQvenP91DXTKA1MhDjYYSLpGYKXN/3/WSLYavrUGl/a+v84u1jH
	 tyhv8DD6cU/0I0ZEJbJZ8EysyHwmVlNTe1sVA08jYE0Zd9mx5dUrVktSwkmS1Wls2j
	 0w6mH7XC3jk09KwpHSnbg6IVvGhpkflmSqnVddGzRKIl08XTsmGTcNUxlNNIdtZhdy
	 Xyr14YAgZm99wfSS/pK8se8mJmL5F8W06mTwv2tdwPvMNoPQqqI6GLXEKaJf03N4I4
	 rsdioaTjfrRkQ==
Date: Tue, 2 Jun 2026 11:34:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew@lunn.ch
Subject: Re: [PATCH net] pcnet32: stop holding device spin lock during
 napi_complete_done
Message-ID: <20260602113434.5898517e@kernel.org>
In-Reply-To: <20260602164158-oscmaes92@gmail.com>
References: <20260528140320.5556-1-oscmaes92@gmail.com>
	<20260602024428.1664921-1-kuba@kernel.org>
	<20260602164158-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oscmaes92@gmail.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294338-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 957F8631229

On Tue, 2 Jun 2026 18:41:58 +0200 Oscar Maes wrote:
> The suggested race condition is impossible, even after
> calling napi_complete_done all pcnet32 interrupts are masked via CSR3.
> pcnet32_interrupt would never be called until the second locked
> section in pcnet32_poll, which unmasks the interrupts.

Not very clear to me that pcnet32_interrupt() will not trigger until we
unmask, but okay, not worth the effort..

