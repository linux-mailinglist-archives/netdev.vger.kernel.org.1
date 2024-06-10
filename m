Return-Path: <netdev+bounces-102159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E53901B3A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237E51C211AC
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 06:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B7E17999;
	Mon, 10 Jun 2024 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HztRYOkH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJvD1c/C"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F839168C7;
	Mon, 10 Jun 2024 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718000820; cv=none; b=bjEX6Orv8Jt2QSpTfj4QC1GDAf7A3q9CV4WQFSAlezw3E9p09TCPVRR19i3FzJyq/FOVV9371I+FXZfQy+9dvntPTWD6LCVsuij1ILYrfGEpAszw5RgmSQ1px7gM4a2PxMdbJM5B4TuQ7ufOeU+A4NInNUUn3XtQAN+OwNtJ5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718000820; c=relaxed/simple;
	bh=qVS4uWCLaKdFK2NC/OAD52q59vFb53l4MTlUH4Z3vqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0eJY8HAF50TMuzs4dmBTUvucm8zTgyfgy7jFkkYJeLTtdf0JnjxBMcJtrUFavyVZN1Q4jjTbPkCgGRbOgOjJ96dX6nPEtnmag8gHBv7DPBBPImC2l3MoxDoJuVGqXRHiP86PO+0QjMuS+rsGBj6eOmJsFHrr/vs1SETCyixw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HztRYOkH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aJvD1c/C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Jun 2024 08:26:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718000817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TvFu3BRt8q4dgKDxmnRBZhJWGPPVGPSI4HtJtIpA3c0=;
	b=HztRYOkHZ3LcyEznfFH+tiCGe1DQY+hFOZoI/b0WYNOjNQ4AbE7M4m29Cov7Bjp0+d/+bk
	jGQTSlKukskzIp1zpw1pmmYV/f6WmkKru/4uRz/42CLn40JYZPAH0aFv7eikr+dKG0//DR
	1rpcZ5MJGXF+j6GC3s/v9D814bfaJGtK8eZar/kP1dTrx1Wkm1DxctVbII2FIvEeuHTOW9
	sIq0p38efdWiz4dGY10HDfSSIYPcN8wyPwnHDzuZp53qIskM8Sq0GwivfN2DVam79IIbfn
	jNh9lL2GcBr9M+gcDYjgT4pt76TnI9L4G1/dEnF5oX/4T2sLRV1XD2jybmpPNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718000817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TvFu3BRt8q4dgKDxmnRBZhJWGPPVGPSI4HtJtIpA3c0=;
	b=aJvD1c/CnAnecMXRiVD5hDapt+SkY1K1UXfb8uHhGOI0czwIU9DYvWKOYxld/ovVIsDgyd
	X16LvRd+VcHDHCBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dev: Simplify the conditional of backlog
 lock functions
Message-ID: <20240610062655.Ow6--EAe@linutronix.de>
References: <20240609072022.2997-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240609072022.2997-1-yajun.deng@linux.dev>

On 2024-06-09 15:20:22 [+0800], Yajun Deng wrote:
> The use_backlog_threads() contains the conditional of PREEMPT_RT, so we
> don't need to add PREEMPT_RT in the backlog lock.
> 
> Remove the conditional of PREEMPT_RT in the backlog lock.

This is part of
	https://lore.kernel.org/all/20240607070427.1379327-10-bigeasy@linutronix.de/

> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Sebastian

