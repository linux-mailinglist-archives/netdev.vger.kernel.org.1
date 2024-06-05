Return-Path: <netdev+bounces-100895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 280C78FC7A4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C451F2566F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F69191489;
	Wed,  5 Jun 2024 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S0RVvBOb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7JbgJh4g"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F05191469
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579315; cv=none; b=jM0q0aW6suBX8xHqVlloyho8upNJ4astUPP7RXYY5Uhir8vmGEE2huSxaaNl2GvWos7/dKC0QbeGAqM+AEEcemPAm0+v1cyvrnpaNuKlGUsd0bPsxfiTk+BnMWoBhWx1hU86OHgVPDa3MSL3HM2q5Tg+PqPe4VkL9+rxTXeL9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579315; c=relaxed/simple;
	bh=Ed2udcxEdxirtF2Hs+woNGvmYWEW4T9fPAhGbOKBv8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAc+HT8ISkR1hZgMBRAE+j4QlBwG7Y+kPXw3Zki+tsPZgPLyiBmR94o10O3ziSrC4cQlzdok6da6F3avetvT+e/sDUZPg2NQMYgmorAVRJWsy/l8LDtFxBpVEFc+L/H7vBfYYqCrJRB5TKiO5ZwkapEiSvWpXpIwrju4fUT0MSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S0RVvBOb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7JbgJh4g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Jun 2024 11:21:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717579312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2o2e0kaxDgwgKp1c3nZs821hyos3DsmABaxNxHdUaf8=;
	b=S0RVvBObc6dZT+YTUy1Yubrv+/Na1rQAUGZRIdMtOZzZ4RZngTAzr68an+GT4UUujyGOZX
	9qlN2+Pm7B3qIv+HBQHDMSkDWTgvM7DxuAuR/2ZWPvuVW3stSOCCnbQXUKuO660/5tGouh
	jLpt/xY9OpMu9vzENNb3LUDWadsBicOf62Eu8bps6rAMZmunXRBUBNTVIrvXwfw7GeGuTw
	dAZ1eUQ3hyQwuQUnyd+0s97CW++bh+x+Ga9umdGejGOoWR8d5GsEGBgTAyIY7ZQeICN2zo
	8bnHCBsZH+lxH/mWBs2LO1Ic977Fyetd8I8pdoBndqSiarzgDUnJjvmHvvuTfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717579312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2o2e0kaxDgwgKp1c3nZs821hyos3DsmABaxNxHdUaf8=;
	b=7JbgJh4g6wpj6/10/n/n3gBEs7CSuNSZr76Mbco3bJo6LuKMUbQWyJ7yjqF0lUfUhvGfbg
	ZprYMGw+JF0B81AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, vschneid@redhat.com,
	tglozar@redhat.com
Subject: Re: [PATCH net-next v7 0/3] net: tcp: un-pin tw timer
Message-ID: <20240605092151.IP-Mr4sC@linutronix.de>
References: <20240604140903.31939-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604140903.31939-1-fw@strlen.de>

On 2024-06-04 16:08:46 [+0200], Florian Westphal wrote:
> This is v7 of the series where the tw_timer is un-pinned to get rid of
> interferences in isolated CPUs setups.
> 
> First patch makes necessary preparations, existing code relies on
> TIMER_PINNED to avoid races.

And BH-disabled.
Thank you.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

