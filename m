Return-Path: <netdev+bounces-237925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A45C51950
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0323A3F30
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E065253B58;
	Wed, 12 Nov 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="whea2mAf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r+iXVuy/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D3288537
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941805; cv=none; b=pjkdRQqyo4V6bf9969t0OgO0D2Omx5zb9n03XU5RBNEWVlaP1rIu1P+c1nRHWTIa0SC9x3vx2PBUvVj80vLPrDRuzlKYT1WrIas0tZkZNKMRdACI7gj8dMBC/4o0KThL9uG85eVkr3EgET3nhGJmyCheuih7cGV0MZGsOZZi/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941805; c=relaxed/simple;
	bh=55jfVxiYidX9qe2xp5UXp6QMgdzYxsf2aOL+w4NwdZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caVsE2iTQ0IUwLw83rNHr+AsZvE0iiy9ZSN8Z364AHMRJ9nJii1sH+1eUt++ORnvh25cwGA7nyyKD8qFAoUuEhyozbR+Lbrk2GVBtQGBsE0lXHGJwIsf0evhWoygn+36dscFkeJAfVP3uLcY4w2XIOQIxuKCjGdK8ztxfEZS4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=whea2mAf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r+iXVuy/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Nov 2025 11:03:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762941802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55jfVxiYidX9qe2xp5UXp6QMgdzYxsf2aOL+w4NwdZg=;
	b=whea2mAf7YvamJ0ENO1cVlIg+icz3xVRlRMcCOpEYJyTKeQe9GBrR6vh9fuPRDs8MFUy+z
	uyKg4L265wtUO16rJPhB5W+/TeL0Exkb4a4kLSlgvomgWlPa9gKrFr/U4ihvZh7g6+OTcG
	hfhT/NdgPiJSHFyZ6iKsqJ+HAOy9G8+VQF1MgJqf37fOHVdrtn/wNY3wuwMYcWi8l00jyM
	JWV+dNLBljcS1CDS8VMjfYyebsP6Nf5TpfBz43D0FUqXQ32We9DsNkfBQVWRGwetaswQH9
	IunHe9Blo0AMAPGagSet22N3KIys9h/3D23bzPxirFgehzjxyACxnp2Kc82VUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762941802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55jfVxiYidX9qe2xp5UXp6QMgdzYxsf2aOL+w4NwdZg=;
	b=r+iXVuy/+yz/SlDcMqgI7bCqazOlaKArNEuMbV5G7eg1D7KE6eXrzUQt6AMuLbbqpZxMpW
	TUfsEXE3ZCcSbOCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	liuhangbin@gmail.com, m-karicheri2@ti.com, arvid.brodin@alten.se
Subject: Re: [PATCH net 0/2] hsr: Send correct HSRv0 supervision frames
Message-ID: <20251112100319.YFgqZLH9@linutronix.de>
References: <cover.1762876095.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cover.1762876095.git.fmaurer@redhat.com>

On 2025-11-11 17:29:31 [+0100], Felix Maurer wrote:
> Hangbin recently reported that the hsr selftests were failing and noted
> that the entries in the node table were not merged, i.e., had
> 00:00:00:00:00:00 as MacAddressB forever [1].
>=20
> This failure only occured with HSRv0 because it was not sending
> supervision frames anymore. While debugging this I found that we were
> not really following the HSRv0 standard for the supervision frames we
> sent, so I additionally made a few changes to get closer to the standard
> and restore a more correct behavior we had a while ago.

Thank you. I meant to look into this=E2=80=A6

> The selftests can still fail because they take a while and run into the
> timeout. I did not include a change of the timeout because I have more
> improvements to the selftests mostly ready that change the test duration
> but are net-next material.

I added a -W10 to ping and it passes while -W5 fails. I can't remember
that this happen before but whatever. Sure, fix the testsuite via -next
if you have more things in order to improve it.

Sebastian

