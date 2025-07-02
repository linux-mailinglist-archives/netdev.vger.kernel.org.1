Return-Path: <netdev+bounces-203172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D79AF0ACF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA4716EE9F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622B71F237E;
	Wed,  2 Jul 2025 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fWqGc+8a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680660B8A
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434863; cv=none; b=O4ovuhaKpv9qbiHJhcv2XkaX7IRnIF4NokgbCPa3JTmTFwT5aVsmdRkfy5woxmEH6Zw8qUWgPQn+48uA/QX57EHYDnjMF1Hae7UyveoMvdeP+ZoOPCf0KCiU2FHwTQDj9JTO16IGTWlwQOxTjFGnj0vGh6tgnNpIlUS09kGnhuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434863; c=relaxed/simple;
	bh=kbZ3QjJ9AU85KcLMcUJ2sMW+/dVFO6hCHAmTZq+sW5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAlb8hy+2fYAeF4C0PwJDgFl8xV4gdOXvknB0yJ6RW6+F7RLGbxLCWavDy+oo98PwYYLmF6AC4q4PFUri2b035HAN6VeLyzpQez1U2835+kMaukEwWwF9TWxeukbnV73NVSx/KKDPQOCtDLDmAy3kSaQv5EJH4WDxGYVpJ5YXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fWqGc+8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9AFC4CEEE;
	Wed,  2 Jul 2025 05:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751434862;
	bh=kbZ3QjJ9AU85KcLMcUJ2sMW+/dVFO6hCHAmTZq+sW5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWqGc+8atDZbhT3hUVhzJY62Szh3LwIT2vLAxQQm9Dm1oYeidt+KYKMllH1Ro+llf
	 JInP5UYs493htNJdYpiRd/bODLAvglJP+PuwZahs3T/fTIYM6Wm85pQXDHSeRhj+kf
	 Yy2C5XfyCFRmAKrNjCqm9HwOdgQLnJIY+EnK01Ro=
Date: Wed, 2 Jul 2025 07:40:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH] net/sched: sch_qfq: Fix null-deref in agg_dequeue
Message-ID: <2025070231-unrented-sulfate-8b6f@gregkh>
References: <CAM_iQpWkQd_1BdP+4cA2uQ5HP2wrb5dh8ZUgGWY7v3enLq_7Fg@mail.gmail.com>
 <20250702040228.8002-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702040228.8002-1-xmei5@asu.edu>

On Tue, Jul 01, 2025 at 09:02:28PM -0700, Xiang Mei wrote:
> From: n132 <xmei5@asu.edu>
> 
> To prevent a potential crash in agg_dequeue (net/sched/sch_qfq.c)
> when cl->qdisc->ops->peek(cl->qdisc) returns NULL, we check the return
> value before using it, similar to the existing approach in sch_hfsc.c.
> 
> To avoid code duplication, the following changes are made:
> 
> 1. Moved qdisc_warn_nonwc to include/net/sch_generic.h and removed
> its EXPORT_SYMBOL declaration, since all users include the header.
> 
> 2. Moved qdisc_peek_len from net/sched/sch_hfsc.c to
> include/net/sch_generic.h so that sch_qfq can reuse it.
> 
> 3. Applied qdisc_peek_len in agg_dequeue to avoid crashing.
> 
> Signed-off-by: n132 <xmei5@asu.edu>

We need a real name, sorry.  Please read the documentation for why.

thanks,

greg k-h

