Return-Path: <netdev+bounces-176229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8520A696BA
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBD24226B2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33321F4C88;
	Wed, 19 Mar 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="S4jxsm0s";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="exqmR/i+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F291DF747
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.6.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406129; cv=none; b=jqibv9v+7jKF+tEkwBE4Byj6dWlTcEexEs+MEx4M/6hLwgSjEBPjZIVTJ4GDE4Lsr5DZiMzDXGFjeIitzC7e1HvSmFlO0h8zbkZsl609j3CJzTQclSOQ16YefrhHK4q04P5/5i+0qpbcfd5DogUnnXAa1SYS53ot5lSPCCz7X2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406129; c=relaxed/simple;
	bh=ulLHGjxueayWNFG5dV4m32uO9KN97QFXBh1lvH3lq5A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OU0DAfQRc5otZppTWKN2ZJPXgj47sr835g1aeTTzLUj7gOcn7rgz3WWOWEHTsSu/lL+DgJHPjLDGKJCFoZtqArgElzDS15EBBbNvlGu8HNbf/vR7RDm2vt1B6wxNI68H9DI/NhH0hSzcL+cwKOadgY2UAdQ89YhAkea6dw1GDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=S4jxsm0s; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=exqmR/i+; arc=none smtp.client-ip=160.80.6.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 52JGMnb5000730;
	Wed, 19 Mar 2025 17:22:54 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id ECFC31209AE;
	Wed, 19 Mar 2025 18:41:42 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1742406103; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQtk1sBLOrLlektexdMxk/2YBB+OJ0M5+4ttuU/cBB8=;
	b=S4jxsm0sb2qdvCcGRqu3hxX7pwnDxuwbiVXxhdx/StLDhPkEN/zES5fyzXmwzJLjrGsgDL
	t0TMYpHEOKCQyBBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1742406103; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQtk1sBLOrLlektexdMxk/2YBB+OJ0M5+4ttuU/cBB8=;
	b=exqmR/i+bkKC9rg7e6DzXTWBoBh06cwkULCKJr/bqRDyn3Sy45cGJQEQTZfEQesBusNTry
	r5gfY+YC1l3Y1DB9z2IqmCwLLSteUjQClTofTIkjfxrjEfKLxKi8FHo0+sWo+fSN68T8r0
	81B8jXM7Z+APF+HolmjgLD0YWHZ9uByhwgWxuNIkWM0QhWAfub/NwE+eCzxcxLQ7aPg5AN
	2YaZ3AGUwriyUhuXJrLC0tDInVkbGpRpQ1P7/BoJmXrvtW9jxWF2jWvr9QSnhqCskKzaAv
	ZlD5VvONpPT46J9otTqYbhBLPWIVpib0r7qhT2m0CcsPV53lbBcLkrhLsVqEsQ==
Date: Wed, 19 Mar 2025 18:41:42 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH v2 net-next] MAINTAINERS: Add Andrea Mayer as a
 maintainer of SRv6
Message-Id: <20250319184142.35ba847797499aaee8ffc148@uniroma2.it>
In-Reply-To: <a9c961ab-a90c-46ee-b2e7-0f160ecae99e@redhat.com>
References: <20250312092212.46299-1-dsahern@kernel.org>
	<a9c961ab-a90c-46ee-b2e7-0f160ecae99e@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Tue, 18 Mar 2025 15:58:17 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> 
> 
> On 3/12/25 10:22 AM, David Ahern wrote:
> > Andrea has made significant contributions to SRv6 support in Linux.
> > Acknowledge the work and on-going interest in Srv6 support with a
> > maintainers entry for these files so hopefully he is included
> > on patches going forward.
> > 
> > v2
> > - add non-uapi header files
> 
> FTR, the changelog should come after the '---' separator. Yep this is a
> somewhat 'recent' process change WRT the past. No need to repost I can
> fix it while applying the patch.
> 
> @Andrea: we need your explicit ack here, as this is basically putting
> some obligations on you ;)
> 
> /P
> 

Hi,

It is a pleasure for me accept this role (just sent an Acked-by).
Thank you all for considering the work I have done on SRv6 over the years.

I'm glad to continue working on this topic, to be included in future patches,
and to contribute to the SRv6 subsystem as much as I can.

Andrea

