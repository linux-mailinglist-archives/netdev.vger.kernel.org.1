Return-Path: <netdev+bounces-215322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EADB2E177
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99B91C26A7E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5653B322755;
	Wed, 20 Aug 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyMqCZTc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265F322751
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704715; cv=none; b=CJ94hyV28LYisZt2pGfpL+Vq5ftUtbo1vJ2HygJtFroD1zRKFS1OQW9V93H1hNpPtbBjAXgL6RsWr2yQMWarL9c+Ct/hIjfAWZ+jxF9Ug7p9Z+5jVp41kD2PRrWQZGtXJ2z9CY1ft1CzrtltJ4ALbXRhC7mU2aBtRqxzciT76sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704715; c=relaxed/simple;
	bh=j+W0dKSaEjHxZys2ScmMyr++n0zeqhiFSjsu4AmEhIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9xlweZOgaGG8tcc9SLHLWKUas0BC7b0kHnBxZ6JlMWggIdCOWBytPWjy785SI+ofUBHghnBgiwtZFX++uH8ICUsW0ojZP7tn8t9iGuYKQINCYdv+r033mwcwuJfuQz6Rd2fk+WMQx7RKNe5NrM9QtDVoVZj06zVsk4TYXHaq+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyMqCZTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F868C4CEE7;
	Wed, 20 Aug 2025 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755704714;
	bh=j+W0dKSaEjHxZys2ScmMyr++n0zeqhiFSjsu4AmEhIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EyMqCZTccVnrzLFf/dLxX2U4TakJgE7RTNoD7yLhRFMIvEM1z7k9NI0p6cFiiv8AW
	 491aZuYvkuExOJjegzX55c184Pr6bm1bxbjwewA8Czjc5tvFk15K0ykahFx4Tx35lM
	 vCvQ3qEgYwkrAzltvx2bzc34AcMcgIADFyyhuUcjPqSVsGrmTEa/cnqxgVkaf+tOqu
	 Au8eoVxzMyZ/Cm9TJOANlvSGZTYl438Q2SRruAG8wgTwV9P6vae4ytOaBpAXJqlxCp
	 O799k+crNmC5K40udGPOkvJ1N4cc1x02SEJk2R/K/waplqmK4b8uOXTh8Nxv9sTiHN
	 F+uWuvP3IiuTg==
Date: Wed, 20 Aug 2025 08:45:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <netdev@vger.kernel.org>, "'Andrew Lunn'" <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>, "'Eric Dumazet'"
 <edumazet@google.com>, "'Paolo Abeni'" <pabeni@redhat.com>, "'Simon
 Horman'" <horms@kernel.org>, "'Jacob Keller'" <jacob.e.keller@intel.com>,
 "'Mengyuan Lou'" <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v4 4/4] net: wangxun: support to use adaptive
 RX/TX coalescing
Message-ID: <20250820084513.587f560b@kernel.org>
In-Reply-To: <0bea01dc1175$d1394730$73abd590$@trustnetic.com>
References: <20250812015023.12876-1-jiawenwu@trustnetic.com>
	<20250812015023.12876-5-jiawenwu@trustnetic.com>
	<20250815111854.170fea68@kernel.org>
	<0bea01dc1175$d1394730$73abd590$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 09:57:43 +0800 Jiawen Wu wrote:
> On Sat, Aug 16, 2025 2:19 AM, Jakub Kicinski wrote:
> > On Tue, 12 Aug 2025 09:50:23 +0800 Jiawen Wu wrote:  
> > > @@ -878,6 +909,8 @@ static int wx_poll(struct napi_struct *napi, int budget)
> > >
> > >  	/* all work done, exit the polling mode */
> > >  	if (likely(napi_complete_done(napi, work_done))) {
> > > +		if (wx->adaptive_itr)
> > > +			wx_update_dim_sample(q_vector);  
> > 
> > this is racy, napi is considered released after napi_complete_done()
> > returns. So napi_disable() can succeed right after that point...
> >   
> > > @@ -1611,6 +1708,8 @@ void wx_napi_disable_all(struct wx *wx)
> > >  	for (q_idx = 0; q_idx < wx->num_q_vectors; q_idx++) {
> > >  		q_vector = wx->q_vector[q_idx];
> > >  		napi_disable(&q_vector->napi);
> > > +		cancel_work_sync(&q_vector->rx.dim.work);
> > > +		cancel_work_sync(&q_vector->tx.dim.work);  
> > 
> > so you may end up with the DIM work scheduled after the device is
> > stopped.  
> 
> But the DIM work doesn't seem to be concerned about the status of napi.
> And even if the device is stopped, setting itr would not cause any errors.
> 
> I can't fully grasp this point...
> Should I move cancel_work_sync() in front of napi_disable()?

My point is that this is possible today:

     CPU 0                     CPU 1

  napi_complete_done()
                            napi_disable()
                            cancel_work()
  wx_update_dim_sample()
    schedule_work()

You can probably use disable_work_sync() and enable_work..
to fix it.

