Return-Path: <netdev+bounces-195290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D8DACF35C
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7277F1898B4C
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B250B19D080;
	Thu,  5 Jun 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nGo2Wb/L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5E770E2;
	Thu,  5 Jun 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749138473; cv=none; b=Cd2abs5+jlwNnmmc9B83yFQ/fbZt/PBxbFblz5zhn4uA1/ekXFVN6acHIwWcdqU0RtYE01t1AyOa05mpzBLLN4t126hDU2C/fG4kSRhbogWfUGoM7UDitMwXhhwKcyYgwV5QWL185kR4VScZHgjIphCYQ6bMg7DowoTBw6HFpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749138473; c=relaxed/simple;
	bh=oW1vIWpghipwl0zw5h3+1KgYOSm/LmaZDvXBIYV0rig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz06SX50cOpXmm59Mtx8skZ8zrSYJer9R5ysKx+Dty5QtAw+WOkoBiQxJeS/ctm/8KVISGGtz2RvPd9vr1l4ovCMCOLMN3NEAcdkVPGLbGQMZy8kug52IXEFvgIFL1aWeofvbSUP4fLQ8Ym1ddncBCPC0siGYEAo4W0u4pLyknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=nGo2Wb/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89A4C4CEE7;
	Thu,  5 Jun 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nGo2Wb/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1749138468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxhUZsqXZoy5NKRlMpwIJu7HzCURr8MlBIxhhj3NsB4=;
	b=nGo2Wb/LNCX0csPOfpiiCtEOelokibGXSymih+uehTAbr91pvL3ifS5U6WZ1yfmo76foyy
	SM4ce4zlZiL89gQGn6y8i3CqFxJb5sqJu2KFSxBWli8T+kkrp1tTi2kJixC8ATR9TzxDDh
	873tBTy5/ad/tqPhVyXJ9V8e015pZRE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f4913faa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Jun 2025 15:47:46 +0000 (UTC)
Date: Thu, 5 Jun 2025 17:47:32 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireguard/queueing: simplify wg_cpumask_next_online()
Message-ID: <aEG8FMsdNLKWtLf9@zx2c4.com>
References: <20250604233656.41896-1-yury.norov@gmail.com>
 <aEEbwQzSoVQAPqLq@yury>
 <aEGAfy80UcB_UMYs@zx2c4.com>
 <aEGooNws-KihCuWh@yury>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEGooNws-KihCuWh@yury>

On Thu, Jun 05, 2025 at 10:24:32AM -0400, Yury Norov wrote:
> On Thu, Jun 05, 2025 at 01:33:19PM +0200, Jason A. Donenfeld wrote:
> > On Thu, Jun 05, 2025 at 12:23:29AM -0400, Yury Norov wrote:
> > > On Wed, Jun 04, 2025 at 07:36:55PM -0400, Yury Norov wrote:
> > > > wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
> > > > function significantly simpler. While there, fix opencoded cpu_online()
> > > > too. 
> > > > 
> > > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > > ---
> > > >  drivers/net/wireguard/queueing.h | 14 ++++----------
> > > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> > > > index 7eb76724b3ed..3bfe16f71af0 100644
> > > > --- a/drivers/net/wireguard/queueing.h
> > > > +++ b/drivers/net/wireguard/queueing.h
> > > > @@ -104,17 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
> > > >  
> > > >  static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
> > > >  {
> > > > -	unsigned int cpu = *stored_cpu, cpu_index, i;
> > > > +	if (likely(*stored_cpu < nr_cpu_ids && cpu_online(*stored_cpu)))
> > > > +		return cpu;
> > > 
> > > Oops... This should be 
> > >                 return *stored_cpu;
> > 
> > Maybe it's best to structure the function something like:
> > 
> > unsigned int cpu = *stored_cpu;
> > if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu))) {
> > 	cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(),	cpu_online_mask);
> > return cpu;
> 
> If you prefer. I'll send v2 shortly

While you're at it, fix the commit subject to match the format used by
every single other wireguard commit. `$ git log --oneline drivers/net/wireguard`
to see what I mean.

