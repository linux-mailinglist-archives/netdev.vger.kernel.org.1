Return-Path: <netdev+bounces-155641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFE7A033DF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DBF3A19D7
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2E1259488;
	Tue,  7 Jan 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVrUla6t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076DFCA4E
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736209195; cv=none; b=oDF8Of8gOdiXXD0Ce7xikLbXygT1Biqze/Gp1DdRjnLYUtOEaGDKR6QdMb3GzlZiHz2Z0kFS3rLDY/+SQDq349abn6pZZQEm40NcvTSbwdIkEgVS5kgRxnL5MqP9KDc7Q+Y1++i8Tf6S72oqtlNhAJyJ379hx2A/wk4wtOGlN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736209195; c=relaxed/simple;
	bh=eST7Uh+JF56TFfM8xvf490WJLwKuULE2I7G6iaWHnBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCKZk4PIlziSHW+JMYsCfX/dOcXkqbavrMfxGsuW+R9O84giTqOKw9lBo0ZvfXFEFLzUHtBr7qMDt464mfRP+h83zkkWrIB/7dyB6RK3RUVnXC3kMLhIEiiL9wbyijYGFnrjj5xJ4eWONrP7uQ5jxGUg/VaRMmSn0X/e+yXl5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVrUla6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7E3C4CED2;
	Tue,  7 Jan 2025 00:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736209194;
	bh=eST7Uh+JF56TFfM8xvf490WJLwKuULE2I7G6iaWHnBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lVrUla6tJN14maAL7plSJnit3ZPcR37vYcxUGsqmZsPvsKzjH9IsQj0JbnjgQYiXK
	 xtAkPYZDtRetJWgfA9X1NRqLleOBc8L2AQsTSzy6m1cIk/pSaksKKOUVcIFhfinKmj
	 4XGvTFtyOnqi4jJ2LS2HbgI0Ua87ljb+6qwMZ1Sg2ZeWrrDIDi9tBWFUKpMHnyUMjk
	 3HPaWBSRQ/ywV11XpSFzMOF/FypNApLZHS5azC9NuzmDLAA/T1VueSgT7n9P5FlVRZ
	 fGz6tPmD4f/smDGwFgTt7uL3KMDOvu3zCiVd6bRkllo9WHlJgN7uq3FQx60mBH6d4Q
	 nURWMX3bv3cfg==
Date: Mon, 6 Jan 2025 16:19:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Daley <johndale@cisco.com>
Cc: andrew+netdev@lunn.ch, benve@cisco.com, davem@davemloft.net,
 edumazet@google.com, neescoba@cisco.com, netdev@vger.kernel.org,
 pabeni@redhat.com, satishkh@cisco.com
Subject: Re: [PATCH net-next v4 4/6] enic: Use the Page Pool API for RX when
 MTU is less than page size
Message-ID: <20250106161953.019083b3@kernel.org>
In-Reply-To: <20250106215425.3108-1-johndale@cisco.com>
References: <20250104174152.67e3f687@kernel.org>
	<20250106215425.3108-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jan 2025 13:54:25 -0800 John Daley wrote:
> >> The Page Pool API improves bandwidth and CPU overhead by recycling
> >> pages instead of allocating new buffers in the driver. Make use of
> >> page pool fragment allocation for smaller MTUs so that multiple
> >> packets can share a page.  
> >
> >Why the MTU limitation? You can set page_pool_params.order
> >to appropriate value always use the page pool.  
> 
> I thought it might waste memory, e.g. allocating 16K for 9000 mtu.
> But now that you mention it, I see that the added code complexity is
> probably not worth it. I am unclear on what to set pp_params.max_len
> to when MTU > PAGE_SIZE. Order * PAGE_SIZE or MTU size? In this case
> the pages won't be fragmented so isn't only necessary for the MTU sized
> area to be DMA SYNC'ed?

Good point, once fragmentation is no longer possible you can
set .max_len to the size of the fragment HW may clobber,
and .offset to the reserved headroom.

> >  
> >> +    page_pool_destroy(rq->pool);
> >> +}  
> 
> I will make a v5 shortly. Would you recommend I split the patchset into 2 parts
> as I think @andrew+netdev was suggesting? The last 2 patches are kind of unrelated
> to the first 4.

Yes, seems like a good idea, patches 5 and 6 would probably have been
merged a while back if they were separate.

