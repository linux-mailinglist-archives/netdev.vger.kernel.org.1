Return-Path: <netdev+bounces-244177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15221CB18C7
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 01:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8273530225A6
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 00:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5514A0BC;
	Wed, 10 Dec 2025 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1gaNRdP8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WH6D19i7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399CE4A02;
	Wed, 10 Dec 2025 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765327906; cv=none; b=Hb3zysLyUzwWN/IuL+q3dviEZhTtAPe3047IK6gPGtV+4NyjZ4gbnx214LyUQp9XKmKHzS1sktfRGYy18G7zTSpB/X+NU2Xh+V8P7p/3bdUfA4yj42HcU6QehnmzvxMouHxOkrHaOzJZOHysYN0FY+6++LREKRo++V97Uj8lSW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765327906; c=relaxed/simple;
	bh=vqdII5RSawMOb1l2peg06DiBbcj7EJhlcWYCdEP7uRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SM/e/fMkp6Scxi5UleI5DcfMMt84r1zVSsmUGvSiYKggwbXAN+Y43E5asRG7KUwY73TDhRwrc/wtWd6Bsc1SJlCgM5b6SVhAdNtLWBOAKjXWCAAOLatehhoIPRZCbFG9Ei2ikYVUSil+DvPQdYrgSCORJMhXfEnGW2geZNTRzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1gaNRdP8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WH6D19i7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765327903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vqdII5RSawMOb1l2peg06DiBbcj7EJhlcWYCdEP7uRc=;
	b=1gaNRdP8EYZWkTZ2EbZrSV9ErOPrku+3n8azXszzKdKNp3FW5nQTsFaHgFIGDSzMcv6MDl
	FtkV4ThkiAriaSwWhy7gvnqilv+m9gE4fIGQrW0SOCyKfZrby1mUwysV3pgNaLjW7xCcAX
	t2JDdCl0xGXt0mADFDXfQyam5ZuUzSL5oqR8z+qFmmoFXxAWr3D/JUBB2GgFmj9mB9Lay4
	iVlXExB/gVKFTr7OcHDGHn5FSEMmyudtd6WsAVlTbmZnjxHQoS2ZxsQVn4gVvHq2zkiF/6
	mm1T0sHroEpHbxBoxNbcyp1tYu/rKZ02NUi3tJJwkW6htzt+3suIRsyL2skGCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765327903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vqdII5RSawMOb1l2peg06DiBbcj7EJhlcWYCdEP7uRc=;
	b=WH6D19i77Rj6HoscbHB4OViQhvqaZdSywY2gz9UX47Bm10Dfh6uC4pKVKsRvtveSOJB5BD
	m53s9GzHAoSKo5DA==
To: Eric Dumazet <edumazet@google.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Kevin Yang <yyd@google.com>, Willem de Bruijn <willemb@google.com>, Neal
 Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Subject: Re: [PATCH] time/timecounter: inline timecounter_cyc2time()
In-Reply-To: <20251129095740.3338476-1-edumazet@google.com>
References: <20251129095740.3338476-1-edumazet@google.com>
Date: Wed, 10 Dec 2025 09:51:38 +0900
Message-ID: <87ecp3f9b9.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 29 2025 at 09:57, Eric Dumazet wrote:
> Add an unlikely() around the cc_cyc2ns_backwards() case,
> even if FDO (when used) is able to take care of this optimization.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Earmarked for post rc1

