Return-Path: <netdev+bounces-195231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC51DACEE98
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B16018961FB
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A7213D531;
	Thu,  5 Jun 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a2znoELQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA802101E6;
	Thu,  5 Jun 2025 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123211; cv=none; b=iWDLKP4bz+CkyjS0vqU8Cm4A67+0ooLNjNHY53y0k28QT9ZNm7ik9t2C80e2cpvuuR+2AdjSb7BRMAytWqc0edjIWLp25jCp+H+hxPQEEjxqFw8cl4cYFIcTSfGpEEqslgC2Se27FW94Ixlcgu40JKVugk30H5mTDJlNRx6xlbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123211; c=relaxed/simple;
	bh=w7hPH+q/U5eQGtznQs8S3dFRvHKmq2rs4MZWvF9tfWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML0wD2GIS4YRnizShM7Ys3LqBu79GPN8FGwsifeTrGX8hkIxcH1yLwAaVaUFvF18QBpW0CDcplzi+mnyfV4IQiZTVnczj/KtFbv/x2JEMrCLPOXUPZGSO2gEgElo4nxymksMnO6vE8iniHphR8D08jM9QsBaMV8gLcXbjjN06NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=a2znoELQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4287DC4CEE7;
	Thu,  5 Jun 2025 11:33:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a2znoELQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1749123207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogn73FjG8sYoj02NOLkqeGhrcdp1XGtgrdO25c6aItU=;
	b=a2znoELQo1HQAUNHvAbcuJ6T15FNvxNtwueIdblf4DEGwJLLZ9/O44lwK22wyf0S+sLTQP
	jbyJKzsm3o4p74yK9ffhXomoOwZrNh2DQsAO46JZsSreJ5tD3CpYyWTIg0XinyF62upx2z
	nUVVjxfB2yPlwPwcjN0QA189ah43Iv8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e6ed023 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Jun 2025 11:33:26 +0000 (UTC)
Date: Thu, 5 Jun 2025 13:33:19 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireguard/queueing: simplify wg_cpumask_next_online()
Message-ID: <aEGAfy80UcB_UMYs@zx2c4.com>
References: <20250604233656.41896-1-yury.norov@gmail.com>
 <aEEbwQzSoVQAPqLq@yury>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEEbwQzSoVQAPqLq@yury>

On Thu, Jun 05, 2025 at 12:23:29AM -0400, Yury Norov wrote:
> On Wed, Jun 04, 2025 at 07:36:55PM -0400, Yury Norov wrote:
> > wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
> > function significantly simpler. While there, fix opencoded cpu_online()
> > too. 
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  drivers/net/wireguard/queueing.h | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> > index 7eb76724b3ed..3bfe16f71af0 100644
> > --- a/drivers/net/wireguard/queueing.h
> > +++ b/drivers/net/wireguard/queueing.h
> > @@ -104,17 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
> >  
> >  static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
> >  {
> > -	unsigned int cpu = *stored_cpu, cpu_index, i;
> > +	if (likely(*stored_cpu < nr_cpu_ids && cpu_online(*stored_cpu)))
> > +		return cpu;
> 
> Oops... This should be 
>                 return *stored_cpu;

Maybe it's best to structure the function something like:

unsigned int cpu = *stored_cpu;
if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu))) {
	cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(),	cpu_online_mask);
return cpu;

