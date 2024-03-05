Return-Path: <netdev+bounces-77420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C396871C05
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06571F246E7
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC325B5DD;
	Tue,  5 Mar 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jdvQj2qy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="izYV4Xh1"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69B5A7A2
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635221; cv=none; b=PFt/FcHAkBNg15tlu3wnkVZ8EXYzAHXuJSpuVmRCHcjCbONuGpGNYDPw2qTHQLKHU4g7LYDtHu1A4QL74rENOSZJal7/7oZIXDa/R5xlyDN9NjX4efBNshqYMGuyKcAn3wGqDuioGhSaUrv1t9LrvVkg/o8G/KLFflXB4xWQgJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635221; c=relaxed/simple;
	bh=L/bJmJC6UshlmCmg0sI1fggDBrTlyKAdB/uqbdWjoec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnfSi8kgf1eGaSEnGmndtsVzFC/1Il0o/dVDzKonIIQhECgVMOMupUHm89eZq0EycPliowt5c7Eu+/w9bRPWsrlyUBJbEzgChCYp3jlG/9CygdHLZNZVII8MqHiDofyUZg9Nqm4a84xGsX9jAz6bHAX0rKkL1alVwBnhpYBugws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jdvQj2qy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=izYV4Xh1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 5 Mar 2024 11:40:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709635218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3TclGk8KD2UaRRHhD2N53mv1nrhKA93t3myV00ZAMA=;
	b=jdvQj2qyyczY0/l9k2dIIu2WW58HWE5MdyWHGWZp8PTbi5E2/EMcTYU34f1Pu7phyH37TH
	/kWeQpSUbies0PXi8OrZ2KbkZpAZrMzKl/oa00/yFbAH2uicwoHZHePjXSApqRPbJ4Ot68
	+Vq2GZ6d1c+dSiIPi3gvu14DQYbm9rLqiemgl70+G3DIUaKR6+hdYVuVuRMC3p9fuLpIHU
	7Cf6jY1ajlh6LSzjpRC09Z+3GKlZmwjs+0A/WKK4d6cwbZEtPQsHeoJXOZZc8wsBFs5R1S
	AJpup0hhOP6033+N5dk+GmI05wCrJv1/TZAq9SCf3IYw735uFfQIe/gpuF78lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709635218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3TclGk8KD2UaRRHhD2N53mv1nrhKA93t3myV00ZAMA=;
	b=izYV4Xh1DBKX88TE88SYRiMyj4n7W+PukhwwXpK+Pgcwo7hlfWAiRzXCHVSZVmrOTK+kH3
	tY9qBY90Ml8DVIDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v3 net-next 3/4] net: Use backlog-NAPI to clean up the
 defer_list.
Message-ID: <20240305104017.F_qF5rxs@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
 <20240228121000.526645-4-bigeasy@linutronix.de>
 <8f351363c3beaf84a3cb54643b02b0981b9e782c.camel@redhat.com>
 <20240305102535.Mw-yj_ra@linutronix.de>
 <3aa17b8d72f8d4605d1cccb7692cc152b77d7f87.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3aa17b8d72f8d4605d1cccb7692cc152b77d7f87.camel@redhat.com>

On 2024-03-05 11:36:39 [+0100], Paolo Abeni wrote:
> To clarify: I'm suggesting passing both arguments.

Ah. Okay. That would work. I am rebasing it so let me sneak that in.

> Cheers,
> 
> Paolo

Sebastian

