Return-Path: <netdev+bounces-252406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKVXHD5CcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:29:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C239768D01
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 709A6300D47A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E47B3904C7;
	Thu, 22 Jan 2026 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgDfdKXM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1E38FF15
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095000; cv=none; b=ZH14UqIDv4LIrhLBHJV6vd59wdEFw9pncgJZxzkfFLhoEm2n+Oihm2cPsV0hk+QdWUuvjkc1wUVkY59X2FIP8YMafwGfxtsILwqgXPpeCIuZmUr/RzYYmHVUU768NGB4+L9KcXoPxyh512owF3/Qm+ptLttKWJjGIf9hoohQuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095000; c=relaxed/simple;
	bh=9ufWMtQYwrxEnz5TzXI02Pi3tx1GcOZ6YJ5xpAPGZOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQLZOxlZcaKNc5AZDyS7682Ybo21+Js3XnZBSEfM2skwzPB8Hwidyh8nS3SowNPwcS6PbH2A77tK9cedUY8A4pHiBHTaagZ4ifQkt1VV+h5O55juBdu6UyiSzczLRAXftnGVQhREsU4zIX4ssjJwv1Xj3nlLqHPyjkjBKcqvVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgDfdKXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AF8C116C6;
	Thu, 22 Jan 2026 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769094999;
	bh=9ufWMtQYwrxEnz5TzXI02Pi3tx1GcOZ6YJ5xpAPGZOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mgDfdKXMT1ciFHsxEZRmceg3whnjPmNYayCr+gC4wKiY0Z3F9tXBDxuFUngc/mJ1y
	 RbdTSO4A1k+ueN2bp3U5irct+EeWF2G7scXAxQmJXxT/hRarObKahCxpxP+MiZCG6m
	 HGN28oCmwIkYMKGXj3og1aIW2c6VpCLEcIqzP8QW7PuwjuYEIlTB0w9J8oFtby5RwV
	 o3nym6H+v5qYTKybMonqaI9TvjRLi+psl5S1kEWFkSSFC+/6Cw3yWc0H39l9y7UYM2
	 6z4Vi/GKAMymmKFNzwfYusRhWSrfiw1e6tvdhR00IKLMjgiq1VLd2hbXStj1bvAGDN
	 B3ZSnG5vPP2ew==
Date: Thu, 22 Jan 2026 07:16:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: <pvalerio@redhat.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <lorenzo@kernel.org>, <claudiu.beznea@tuxon.dev>,
 <nicolas.ferre@microchip.com>, <netdev@vger.kernel.org>,
 <edumazet@google.com>, =?UTF-8?B?R3LDqWdvcnk=?= Clement
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [net-next,3/8] cadence: macb: Add page pool support handle
 multi-descriptor frame rx
Message-ID: <20260122071638.71e96253@kernel.org>
In-Reply-To: <DFV720NVKS7T.31AL827EQB1G4@bootlin.com>
References: <20260115222531.313002-4-pvalerio@redhat.com>
	<20260119193622.1255610-1-kuba@kernel.org>
	<DFV720NVKS7T.31AL827EQB1G4@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252406-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: C239768D01
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 15:39:51 +0100 Th=C3=A9o Lebrun wrote:
> On Mon Jan 19, 2026 at 8:36 PM CET, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> >
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-lo=
cal.html =20
>=20
> This page indicates the prompt is at `review-prompt/prompt.md` but the
> repo never has had any `prompt.md` file. Guessing from
> `kernel/skills/kernel.md` it seems to be `kernel/review-core.md`
> instead.

Thanks for pointing out, it got renamed yesterday evening.
Let me update the help page.

