Return-Path: <netdev+bounces-166227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01BAA35169
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 23:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2B116B9CD
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D03C26E14D;
	Thu, 13 Feb 2025 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tvlp9e1y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lWVipJtW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2242661B9;
	Thu, 13 Feb 2025 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486596; cv=none; b=Zmqghg80heCGNFYWeukYZG+GS+ITjYZDEHeXys5W4pXuPl5kMpKI8eKVRqkhUbLfYIz8f29C5zLDhKxotLxGFf56UY738w8+He10qvYFsefr8qhcxZcXftUxx6/i8p89CAzUGUuPfpQH7B71smjXgjSpX6Svw2I2jQXYd31LhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486596; c=relaxed/simple;
	bh=ipJ692m88D8RI2bNjAwTUlpC2vNwbT53/hzUkTCJFcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OwSur2UMjb4vCfPWNgrJn3r00YNJz+iZ/ItKED61n6KVzp/KkLo6MoXYHPJTuqbzwaF9aSpMJQxW5pkZfqhsc6KmI8E6VXo0bUghgONt27cXcj2ESeNytX7amy88FhS5JzSK8plGYqfmEqCAEDeL8IwT6TJrU8f4KrKm4EhYYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tvlp9e1y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lWVipJtW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739486592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=07a3+CYGw74UN4M9XxqpV7Zw3gnwqNcGS7ko7WqeKMU=;
	b=Tvlp9e1yFSScG2IxH5C9QPZ9f7J9SsK8IKVtyQgMEVhsiCwpGORezjeI24zz+XWiF/FlJw
	FzgRQ+OOPw2tEBNBhebd3jLNWgcezqszumVYMZfMV16t1haDHW1jVQC27Yb/J7DXuMSAUq
	sACpBd5nx/wjfbkBG/4zeT1D9Rd/RigUbzgLIgtiR7F+UeLGOmqg5KUihpdmX/bQpRr+lY
	mUd9P2enOM9d1a1LjUAJdDG37HVYdiYsaVOXrlstznBORXlPTMWbeULaaZ2qJNGCEkQiS2
	QdSd73fLCukiAFGrMpraVduOe2lT1LJSxEZlcVTc3YHCbFfHUbrjF6Se0oKBew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739486592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=07a3+CYGw74UN4M9XxqpV7Zw3gnwqNcGS7ko7WqeKMU=;
	b=lWVipJtWI3dAH4fxxWXRnbdoSSTGB6hypDwwr7+7knKqP6Tfm847Dg71K5h+qGRqeed/vL
	hijpdg6icqL9FIBw==
To: "Vankar, Chintan" <c-vankar@ti.com>, Jason Reeder <jreeder@ti.com>,
 vigneshr@ti.com, nm@ti.com, Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
 s-vadapalli@ti.com, danishanwar@ti.com, m-malladi@ti.com
Subject: Re: [RFC PATCH 1/2] irqchip: ti-tsir: Add support for Timesync
 Interrupt Router
In-Reply-To: <dda464e2-d442-4e20-bc6d-cea854c5f17f@ti.com>
References: <20250205160119.136639-1-c-vankar@ti.com>
 <20250205160119.136639-2-c-vankar@ti.com> <87lduin4o5.ffs@tglx>
 <09880b14-cef1-44cd-9fa4-8840fb673c0a@ti.com> <87cyfplg8s.ffs@tglx>
 <dda464e2-d442-4e20-bc6d-cea854c5f17f@ti.com>
Date: Thu, 13 Feb 2025 23:43:11 +0100
Message-ID: <87jz9tjwjk.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chintan!

On Fri, Feb 14 2025 at 00:15, Vankar, Chintan wrote:
> On 2/11/2025 1:33 AM, Thomas Gleixner wrote:
>> On Sun, Feb 09 2025 at 14:06, Vankar, Chintan wrote:
>>> On 2/7/2025 2:58 AM, Thomas Gleixner wrote:
>> If I understand this correctly, then the interrupt number you need to
>> allocate for this is never going to be requested. If it would be
>> requested it just would do nothing and the handler would never be
>> invoked, right?
>> 
>> The allocation just establishes the routing of a signal between two
>> arbitrary IP blocks in the SoC.
>> 
>> So the question is what has this to do with interrupts in the first
>> place?
>
> Your understanding is correct about the Timesync INTR. As I mentioned
> Timesync INTR is an instance of Interrupt Router which has multiple
> output and not all the output lines are acting as interrupt lines unlike
> other Interrupt Routers. Timesync INTR can have devices on both the
> sides, we can provide input to Timesync INTR that can be consumed by
> some other device from the output line. As an instance, One of the
> input of Timesync INTR is an output from the CPTS module which can be
> consumed by other device and that does not need to handle/allocate Linux
> irq number.

Two questions:

 1) For the case where no interrupt is involved, how is the routing
    configured?

 2) For the case where it routes an input line to an interupt, then how
    is this interrupt going to be handled by this interrupt domain which
    is not connected to anything and implements an empty disfunctional
    interrupt chip?

Thanks

        tglx

