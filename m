Return-Path: <netdev+bounces-165692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED73A33121
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83C6161504
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAFA202C3B;
	Wed, 12 Feb 2025 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTE0bAo8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B17201258;
	Wed, 12 Feb 2025 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393892; cv=none; b=TfDm3GPe3BZKW2T6Hx1sj2gAbv+OosNokV1o3CR1fwjOuKHDsVjTVdjnk11yTuScnWbIcNuSqRFYr8eKUBF0gnO7TCChSNgUZ7y1IA6m4H/MAdgdoO0h9Z7JrYD7x0cxg96vb5cStqu2g06LlPbZl956f6lz9lvF8NW2A4t11ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393892; c=relaxed/simple;
	bh=XWVybzP+GL5RtVVntd6QhQ5TYhd8Dg9F79A+o4QAFRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBsy1BB0jf4G7SeBAZu5AloQyVW+/kIRdzDpBzyyB7mDiaHEwzJqkDHOTWBYJLlVwoXz9YwlDJN3nbrRWRSIHrRI3veAcmVFeskkkKIdYjZJhyHDkvd3YeVUbQ2LcPV5O0P/AZi8wWPDY2MX7rG0iYQTN/Tw0CcycK0psGxVQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTE0bAo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D2FC4CEDF;
	Wed, 12 Feb 2025 20:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739393891;
	bh=XWVybzP+GL5RtVVntd6QhQ5TYhd8Dg9F79A+o4QAFRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTE0bAo8hJA7JdqoLxawEE8LzI5hvY3SBDd7Vhv9T5T370XXV6558/Wq2xWeTd+xv
	 NwPBXJz1R7tHIFQa56AGNwPZw+uVZ075ECt0aH5wt4i+2dvghODngT7lU7Xa0+Ty6/
	 9y7Q8b68VuSrUBXOocX1kvXNVTwfvHOP0sSMm9ApHwL+o9eMT3wU42GdUgUtSyQhmr
	 g0Yxm2YocD4jWAaTsWcgbsO8ePQ7F2zWZ3m/7VoI4t3Egc2w8AuDEsCypBJR67uGqI
	 IN8YkTzbfIa87P2Vvflxz/IWn0Mto88PxrBkLxhhHVS7mk+YCMY0/4WOT9InT7wzLT
	 SAbO/QbC6homA==
Date: Wed, 12 Feb 2025 21:58:08 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 2/2] r8152: Call napi_schedule() from proper context
Message-ID: <Z60LYAml7kq_7XOb@pavilion.home>
References: <20250212174329.53793-1-frederic@kernel.org>
 <20250212174329.53793-3-frederic@kernel.org>
 <20250212204929.GA2685909@electric-eye.fr.zoreil.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212204929.GA2685909@electric-eye.fr.zoreil.com>

Le Wed, Feb 12, 2025 at 09:49:29PM +0100, Francois Romieu a écrit :
> Frederic Weisbecker <frederic@kernel.org> :
> [...]
> > r8152 may call napi_schedule() on device resume time from a bare task
> > context without disabling softirqs as the following trace shows:
> [...]
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> > index 468c73974046..1325460ae457 100644
> > --- a/drivers/net/usb/r8152.c
> > +++ b/drivers/net/usb/r8152.c
> > @@ -8537,8 +8537,11 @@ static int rtl8152_runtime_resume(struct r8152 *tp)
> >  		clear_bit(SELECTIVE_SUSPEND, &tp->flags);
> >  		smp_mb__after_atomic();
> >  
> > -		if (!list_empty(&tp->rx_done))
> > +		if (!list_empty(&tp->rx_done)) {
> > +			local_bh_disable();
> >  			napi_schedule(&tp->napi);
> > +			local_bh_enable();
> > +		}
> 
> AFAIU drivers/net/usb/r8152.c::rtl_work_func_t exhibits the same
> problem.

It's a workqueue function and softirqs don't seem to be disabled.
Looks like a goot catch!

Thanks.

> 
> -- 
> Ueimor

